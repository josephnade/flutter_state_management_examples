import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:stream_transform/stream_transform.dart';
import '../model/post.dart';
import 'package:http/http.dart' as http;
part 'post_event.dart';
part 'post_state.dart';

typedef HttpClient = http.Client;
const int postLimit = 20;
const Duration _postDuration = Duration(milliseconds: 200);

EventTransformer<T> postDroppable<T>(Duration duration) {
  return ((events, mapper) => droppable<T>().call(events.throttle(duration), mapper));
}

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc({required HttpClient client})
      : _client = client,
        super(const PostState()) {
    on<PostFetched>((_onPostFetched), transformer: postDroppable(_postDuration));
  }
  final HttpClient _client;
  Future<void> _onPostFetched(PostFetched event, Emitter<PostState> emitter) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == PostStatus.initial) {
        final List<Post> posts = await _fetchPosts();
        return emitter(state.copyWith(status: PostStatus.success, posts: posts, hasReachedMax: false));
      }
      final posts = await _fetchPosts(state.posts.length);
      posts.isEmpty
          ? emitter(state.copyWith(hasReachedMax: true))
          : emitter(state.copyWith(status: PostStatus.success, posts: List.of(state.posts)..addAll(posts)));
    } on Exception catch (_) {
      emitter(state.copyWith(status: PostStatus.failure));
    }
  }

  Future<List<Post>> _fetchPosts([int startIndex = 0]) async {
    final response =
        await _client.get(Uri.https('jsonplaceholder.typicode.com', '/posts', {'_start': '$startIndex', '_limit': '$postLimit'}));
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List<dynamic>).map((post) => Post.fromJson(JsonMap.from(post))).cast<Post>().toList();
    } else {
      throw PostException(error: response.body);
    }
  }
}
