import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:full_app/views/widgets/drawer_page.dart';

import '../../providers/settings_notifier.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsScreen> {
  Color pickerColor = const Color(0xff443a49);
  Color currentColor = const Color(0xff443a49);

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  bool toggle = true;
  @override
  Widget build(BuildContext context) {
    final settingsNotifier = SettingsNotifier.of(context);
    return Scaffold(
      drawer: const DrawerPage(),
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SwitchListTile(
              title:
                  toggle ? const Text("Night mode") : const Text("Light mode"),
              value: toggle,
              onChanged: (value) {
                toggle = value;
                AdaptiveTheme.of(context).toggleThemeMode(useSystem: value);
                setState(() {});
              },
            ),
            Text(
              "Text Size:",
              style: TextStyle(
                fontSize: settingsNotifier.sizeText.size,
                color: settingsNotifier.sizeText.color,
              ),
            ),
            ListenableBuilder(
              listenable: settingsNotifier,
              builder: (context, child) {
                return Slider(
                  value: settingsNotifier.sizeText.size,
                  min: 12,
                  max: 30,
                  divisions: 18,
                  label: settingsNotifier.sizeText.size.toString(),
                  onChanged: (value) async {
                    settingsNotifier.setSizeText(value);
                    await settingsNotifier.loadSizeText();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
