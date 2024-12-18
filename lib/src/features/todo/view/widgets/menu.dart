import 'package:awesome_todo_app/src/features/todo/controller/todo_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Keys for components for testing
final bottomNavigationBarKey = UniqueKey();

enum TodoListFilter {
  all('All', Icons.list),
  active('Active', Icons.circle),
  completed('Completed', Icons.done);

  const TodoListFilter(
    this.label,
    this.icon,
  );

  final String label;
  final IconData icon;
}

/// Bottom menu widget
class Menu extends HookConsumerWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(todoFilterProvider);

    int currentIndex() {
      switch (filter) {
        case TodoListFilter.completed:
          return 2;
        case TodoListFilter.active:
          return 1;
        case TodoListFilter.all:
          return 0;
      }
    }

    return BottomNavigationBar(
      key: bottomNavigationBarKey,
      elevation: 0.0,
      onTap: (index) {
        ref
            .read(todoFilterProvider.notifier)
            .setState(TodoListFilter.values[index]);
      },
      items: List.generate(
        TodoListFilter.values.length,
        (index) {
          final filter = TodoListFilter.values[index];
          return BottomNavigationBarItem(
            icon: Icon(filter.icon),
            label: filter.label,
            tooltip: filter.label,
          );
        },
      ),
      currentIndex: currentIndex(),
      selectedItemColor: Colors.amber[800],
    );
  }
}
