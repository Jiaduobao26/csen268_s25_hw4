import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainScaffold extends StatelessWidget {
  final Widget child;

  const MainScaffold({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // query the current route
    final String location = GoRouter.of(context).location;

    // hide the bottom navigation bar if the current route is '/detail'
    final bool hideBottomNavigationBar = location.contains('/detail');
    final bool goBack = location.contains('/detail');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          _getTitle(context),
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurface, 
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: goBack ? const Icon(Icons.arrow_back) : const Icon(Icons.menu),
          color: Theme.of(context).colorScheme.onSurface,
          onPressed: () {
            if (goBack) {
              context.pop();
            }
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            color:Theme.of(context).colorScheme.onSurface,
            onPressed: () {},
          ),
        ],
      ),
      body: child, // This is where the child widget will be displayed
      bottomNavigationBar: !hideBottomNavigationBar ?BottomNavigationBar(
        currentIndex: _getSelectedIndex(context),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'By Author',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.title),
            label: 'By Title',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Profile',
          ),
        ],
        onTap: (index) => _onItemTapped(context, index),
      ): null,
    );
  }

  int _getSelectedIndex(BuildContext context) {
    final String location = GoRouter.of(context).location;
    if (location.startsWith('/byAuthor')) {
      return 0;
    } else if (location.startsWith('/byTitle')) {
      return 1;
    } else if (location.startsWith('/profile')) {
      return 2;
    }
    return 0; // default index
  }

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/byAuthor');
        break;
      case 1:
        context.go('/byTitle');
        break;
      case 2:
        context.go('/profile');
        break;
    }
  }

  String _getTitle(BuildContext context) {
    final String location = GoRouter.of(context).location;
    if (location.startsWith('/byAuthor')) {
      return 'Books';
    } else if (location.startsWith('/byTitle')) {
      return 'Books';
    } else if (location.startsWith('/profile')) {
      return 'Profile';
    } else {
      return 'Main Scaffold'; // default title
    }
  }
}