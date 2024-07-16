import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/settings_provider.dart';
import 'language/language_bottom_sheet.dart';
import 'mode/mode_bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsTab extends StatefulWidget {
  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    SettingsProvider provider = Provider.of<SettingsProvider>(context);
    return Container(
      padding: EdgeInsets.all(17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              AppLocalizations.of(context)!.language,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          InkWell(
            onTap: () {
              showLanguageBottomSheet();
            },
            child: Container(
              margin: EdgeInsets.all(12),
              padding: EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                border: Border.all(color: Color(0xff5D9CEC), width: 2),
                borderRadius: BorderRadius.circular(1),
              ),
              child: Text(
                provider.currentLang == 'en' ? 'English' : 'العربيه',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xff5D9CEC),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 17,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              AppLocalizations.of(context)!.mode,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          InkWell(
            onTap: () {
              showModeBottomSheet();
            },
            child: Container(
              margin: EdgeInsets.all(12),
              padding: EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                border: Border.all(color: Color(0xff5D9CEC), width: 2),
                borderRadius: BorderRadius.circular(1),
              ),
              child: Text(
                provider.currentTheme == ThemeMode.dark
                    ? AppLocalizations.of(context)!.dark
                    : AppLocalizations.of(context)!.light,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xff5D9CEC),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => LanguageBottomSheet(),
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
    );
  }

  void showModeBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ModeBottomSheet(),
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
    );
  }
}
