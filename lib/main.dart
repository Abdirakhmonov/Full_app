
import 'package:flutter/material.dart';
import 'package:full_app/providers/settings_notifier.dart';
import 'package:full_app/utils/routes_utild.dart';
import 'package:full_app/viewmodel/settings_controller.dart';
import 'package:full_app/views/screens/main_page.dart';
import 'package:full_app/views/screens/settings_screen.dart';
import 'package:full_app/views/screens/todos_screen.dart';

import 'data/local_data.dart';


void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  final settingsController = SettingsController(
    themeModeData: LocalData(),
    sizeTextData: LocalData(),
  );
  await settingsController.loadTheme();
  await settingsController.loadSizeText();
  await settingsController.loadColorText();

  runApp(MainRunner(settingsController: settingsController));
}

class MainRunner extends StatelessWidget {
  final SettingsController settingsController;

  const MainRunner({super.key, required this.settingsController});

  @override
  Widget build(BuildContext context) {
    return SettingsNotifier(
      settingsController: settingsController,
      child: Builder(
        builder: (context) {
          final settingsNotifier = SettingsNotifier.of(context);
          return AnimatedBuilder(
            animation: settingsNotifier,
            builder: (context, child) {
              return MaterialApp(
                routes: {
                  Routes.settingsRoute: (context) => const SettingsScreen(),
                },
                debugShowCheckedModeBanner: false,
                darkTheme: ThemeData.dark(useMaterial3: true),
                themeMode: settingsNotifier.appTheme.themeMode,
                home: const HomePage(),
              );
            },
          );
        },
      ),
    );
  }
}
