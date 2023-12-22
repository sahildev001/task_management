import 'package:flutter/material.dart';
import 'package:task_management/features/authentication/view/authentication.dart';
import 'package:task_management/l10n/l10n.dart';
import 'package:task_management/utils/hivePrefs/user_prefs.dart';

import '../../features/home/view/home.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: (UserPrefs().getLoginResponse() == null)
          ? const Authentication()
          :  Home(),
    );
  }
}
