/// This file defines a localized bottom menu widget and an enumeration to filter to-do items.
/// It leverages the power of Riverpod for state management and localizations for multilingual support.

import 'package:awesome_todo_app/resources/l10n/l10n.dart';
import 'package:awesome_todo_app/src/features/todo/controller/todo_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Enum representing the possible filters for the to-do list.
///
/// Each filter corresponds to an icon and has a method to retrieve its localized text.
enum TodoListFilter {
  /// Displays all to-do items.
  all(Icons.menu),

  /// Displays only active (pending) to-do items.
  active(Icons.pending),

  /// Displays only completed to-do items.
  completed(Icons.task_alt);

  /// Constructor that associates an [IconData] with each filter.
  const TodoListFilter(this.icon);

  /// The icon associated with the filter.
  final IconData icon;

  /// Retrieves the localized text for the filter.
  ///
  /// This method uses the localization context (`l10n`) to provide user-friendly, translated labels.
  /// - `context`: The current [BuildContext] to access localizations.
  String localizedText(BuildContext context) => switch (this) {
        TodoListFilter.all => context.l10n.all,
        TodoListFilter.active => context.l10n.active,
        TodoListFilter.completed => context.l10n.completed,
      };
}

/// A widget that renders a bottom navigation menu for filtering to-do items.
///
/// This widget uses Riverpod's `HookConsumerWidget` for seamless state management.
/// It dynamically builds menu items based on the `TodoListFilter` enum and updates
/// the state using the [todoFilterProvider].
class Menu extends HookConsumerWidget {
  /// Creates a [Menu] widget.
  const Menu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the current filter state from the Riverpod provider.
    final filter = ref.watch(todoFilterProvider);

    return BottomNavigationBar(
      elevation: 0.0,
      onTap: (index) {
        // Update the filter state when a menu item is tapped.
        ref
            .read(todoFilterProvider.notifier)
            .setState(TodoListFilter.values[index]);
      },
      // Generate the navigation items dynamically based on the `TodoListFilter` values.
      items: List.generate(
        TodoListFilter.values.length,
        (index) {
          final filter = TodoListFilter.values[index];
          return BottomNavigationBarItem(
            icon: Icon(filter.icon), // Display the filter's icon.
            label: filter.localizedText(context), // Localized label.
            tooltip: filter.localizedText(context), // Localized tooltip.
          );
        },
      ),
      currentIndex: filter.index,
      // Highlight the currently selected filter.
      unselectedItemColor: Colors.black38,
      // Styling for unselected items.
      selectedLabelStyle:
          const TextStyle(fontSize: 18), // Styling for selected labels.
    );
  }
}
