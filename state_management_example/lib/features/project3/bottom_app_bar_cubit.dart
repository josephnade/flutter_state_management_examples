import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePageExample extends StatelessWidget {
  const ChangePageExample({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => HomeCubit(), child: const HomeWidget());
  }
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select<HomeCubit, HomeTab>((HomeCubit cubit) => cubit.state.tab);
    return Scaffold(
      body: IndexedStack(index: selectedTab.index, children: const [Page1(), Page2()]),
      bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              HomeTabButton(iconData: Icons.list_alt_sharp, selectedValue: selectedTab, value: HomeTab.page1),
              HomeTabButton(iconData: Icons.abc_outlined, selectedValue: selectedTab, value: HomeTab.page2),
            ],
          )),
    );
  }
}

class HomeTabButton extends StatelessWidget {
  const HomeTabButton({super.key, required this.value, required this.selectedValue, required this.iconData});
  final HomeTab value;
  final HomeTab selectedValue;
  final IconData iconData;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.read<HomeCubit>().setTab(value),
      icon: Icon(iconData),
      color: selectedValue != value ? null : Theme.of(context).colorScheme.secondary,
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page 1')),
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page 2')),
    );
  }
}

enum HomeTab { page1, page2 }

class HomeState extends Equatable {
  final HomeTab tab;

  const HomeState({this.tab = HomeTab.page1});

  @override
  List<Object?> get props => [tab];
}

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  void setTab(HomeTab tab) => emit(HomeState(tab: tab));
}
