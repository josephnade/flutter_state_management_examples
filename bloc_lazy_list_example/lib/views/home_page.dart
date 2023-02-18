// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_lazy_list_example/core/post_bloc/post_bloc.dart';

import '../core/model/post.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostBloc>(
      create: (context) => PostBloc(client: HttpClient())..add(const PostFetched()),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    if (_isBottom) context.read<PostBloc>().add(const PostFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final double maxScroll = _scrollController.position.maxScrollExtent;
    final double currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * .9);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Posts"),
          centerTitle: true,
        ),
        body: BlocBuilder<PostBloc, PostState>(
          builder: (context, postState) {
            switch (postState.status) {
              case PostStatus.failure:
                return Center(
                    child: Text(
                  'Bir hata oluştu!',
                  style: Theme.of(context).textTheme.headline5,
                ));
              case PostStatus.success:
                if (postState.posts.isEmpty) {
                  return Center(child: Text("Herhangi bir Post Bulunamadı...", style: Theme.of(context).textTheme.headline5));
                }
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return index >= postState.posts.length
                        ? const IndicatorWidget()
                        : ListPostItem(
                            post: postState.posts[index],
                          );
                  },
                  itemCount: postState.hasReachedMax ? postState.posts.length : (postState.posts.length + 1),
                  controller: _scrollController,
                );
              default:
                return Center(
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: const [
                    Text("Lütfen Bekleyiniz..."),
                    CircularProgressIndicator(
                      strokeWidth: 1.5,
                    )
                  ]),
                );
            }
          },
        ));
  }
}

class ListPostItem extends StatelessWidget {
  const ListPostItem({Key? key, required this.post}) : super(key: key);
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        leading: Text('${post.id}', style: Theme.of(context).textTheme.caption),
        title: Text(post.title),
        subtitle: Text(post.body),
        isThreeLine: true,
      ),
    );
  }
}

class IndicatorWidget extends StatelessWidget {
  const IndicatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: SizedBox(
      width: 36,
      height: 36,
      child: CircularProgressIndicator(
        strokeWidth: 1.5,
      ),
    ));
  }
}
