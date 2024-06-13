import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:full_app/views/widgets/drawer_page.dart';
import 'package:provider/provider.dart';

import '../../providers/localizations_notifier.dart';
import '../../providers/settings_notifier.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final localeController = Provider.of<LocaleController>(context);

    return Scaffold(
      drawer: const DrawerPage(),
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.settings,
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
        actions: [
          DropdownButton<Locale>(
            value: localeController.locale,
            onChanged: (Locale? newLocale) {
              if (newLocale != null) {
                localeController.setLocale(newLocale);
              }
            },
            items: AppLocalizations.supportedLocales.map<DropdownMenuItem<Locale>>((Locale locale) {
              return DropdownMenuItem<Locale>(
                value: locale,
                child: Text(locale.toString()),
              );
            }).toList(),
          ),
        ],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SwitchListTile(
              title: toggle
                  ? Text(
                      AppLocalizations.of(context)!.nightMode,
                    )
                  : const Text("Light mode"),
              value: toggle,
              onChanged: (value) {
                toggle = value;
                AdaptiveTheme.of(context).toggleThemeMode(useSystem: value);
                setState(() {});
              },
            ),
            Text(
              AppLocalizations.of(context)!.textSize,
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
