import 'package:awesome_todo_app/resources/l10n/l10n.dart';
import 'package:awesome_todo_app/src/features/todo/controller/todo_page_controller.dart';
import 'package:awesome_todo_app/src/features/todo/view/widgets/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A widget that displays a message when there are no todos to show, based on the current filter.
///
/// This widget listens to the `todoListProvider` and `todoFilterProvider` using Riverpod
/// to determine the list of todos and the active filter. Depending on these values, it displays
/// a contextually appropriate message.
///
/// The messages displayed are localized using the `l10n` package.

class NoTodosWidget extends ConsumerWidget {
  const NoTodosWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the unfiltered list of todos, defaulting to an empty list if null.
    final unFilteredTodoList = ref.watch(todoListProvider).valueOrNull ?? [];

    // Retrieve the current to-do filter (e.g., all, active, completed).
    final filter = ref.watch(todoFilterProvider);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Text(
          // Determine the message to display based on the filter and to-do list status.
          unFilteredTodoList.isEmpty
              ? context.l10n.noToDosYetCreateOneToGetStarted
              : switch (filter) {
            TodoListFilter.all => context.l10n.noToDosYetCreateOneToGetStarted,
            TodoListFilter.active => context.l10n.allToDosAreCompletedGreatJob,
            TodoListFilter.completed => context.l10n.noCompletedToDosYetStartMarkingThemOff,
          },
          textAlign: TextAlign.center,
          style: TextStyle(
            // Set text color and opacity based on the current theme.
            color: Theme.of(context).primaryColor.withOpacity(0.6),
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
