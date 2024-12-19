import 'package:awesome_todo_app/resources/l10n/l10n.dart';
import 'package:awesome_todo_app/src/features/todo/view/todo_page.dart';
import 'package:flutter/material.dart';

/// The main entry point of the application, defining the app structure and localization.
class App extends StatelessWidget {
  /// Constructor for the `App` widget.
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Build and return the main MaterialApp widget, which is the root of the app.
    return const MaterialApp(
      // Disable the debug banner that appears in the top-right corner of the app in debug mode.
      debugShowCheckedModeBanner: false,

      // Define the supported locales for localization in the app. This will be fetched from the
      // `AppLocalizations` class, which manages all the translations.
      supportedLocales: AppLocalizations.supportedLocales,

      // List of localization delegates to handle translations and app-specific localizations.
      localizationsDelegates: [
        // Spread the list of localization delegates defined in `AppLocalizations`
        ...AppLocalizations.localizationsDelegates,
      ],

      // Define the home screen of the app, which in this case is the TodoPage widget.
      home: TodoPage(),
    );
  }
}
