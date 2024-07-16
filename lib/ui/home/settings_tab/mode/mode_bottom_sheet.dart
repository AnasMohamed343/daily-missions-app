import 'package:daily_missions_app/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class ModeBottomSheet extends StatefulWidget {
  @override
  State<ModeBottomSheet> createState() => _ModeBottomSheetState();
}

class _ModeBottomSheetState extends State<ModeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    SettingsProvider provider = Provider.of<SettingsProvider>(context);
    return Container(
      padding: EdgeInsets.all(22),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              provider.updateAppTheme(ThemeMode.dark);
            },
            child: provider.currentTheme == ThemeMode.dark
                ? getSelectedMode(AppLocalizations.of(context)!.dark)
                : getUnSelectedMode(AppLocalizations.of(context)!.dark),
          ),
          SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              provider.updateAppTheme(ThemeMode.light);
            },
            child: provider.currentTheme == ThemeMode.light
                ? getSelectedMode(AppLocalizations.of(context)!.light)
                : getUnSelectedMode(AppLocalizations.of(context)!.light),
          ),
        ],
      ),
    );
  }

  static Widget getSelectedMode(String selectedMode) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          selectedMode,
          style: TextStyle(
            color: Color(0xff5D9CEC),
            fontSize: 22,
          ),
        ),
        Icon(
          Icons.check,
          color: Color(0xff5D9CEC),
          size: 30,
        ),
      ],
    );
  }

  Widget getUnSelectedMode(String unSelectedMode) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          unSelectedMode,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
