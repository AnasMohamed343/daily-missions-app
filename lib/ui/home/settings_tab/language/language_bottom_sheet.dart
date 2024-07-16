import 'package:daily_missions_app/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageBottomSheet extends StatefulWidget {
  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    SettingsProvider provider = Provider.of<SettingsProvider>(context);
    return Container(
      padding: EdgeInsets.all(22),
      child: Column(
        children: [
          InkWell(
              onTap: () {
                provider.changeAppLocal('en');
              },
              child: provider.currentLang == 'en'
                  ? getSelectedLang('English')
                  : getUnSelectedLang('English')),
          SizedBox(
            height: 15,
          ),
          InkWell(
              onTap: () {
                provider.changeAppLocal('ar');
              },
              child: provider.currentLang == 'ar'
                  ? getSelectedLang('العربيه')
                  : getUnSelectedLang('العربيه')),
        ],
      ),
    );
  }

  Widget getSelectedLang(String selectedLang) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          selectedLang,
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

  Widget getUnSelectedLang(String unSelectedLang) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          unSelectedLang,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
