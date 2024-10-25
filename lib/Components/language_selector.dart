import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../Data/language_manager.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  Future<void> _changeLanguage(BuildContext context, String languageCode) async {
    await LanguageManager().changeLanguage(context, languageCode);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        popupMenuTheme: const PopupMenuThemeData(
          color: Color(0xFF092d52),
        ),
      ),
      child: DropdownButton<String>(
        value: context.locale.languageCode,
        underline: Container(),
        icon: const Icon(Icons.language, color: Color(0xFF092d52)),
        items: LanguageManager.languageData.entries.map((entry) {
          return DropdownMenuItem(
            value: entry.key,
            child: Text('${entry.value['flag']} ${entry.value['code']?.toUpperCase()}'),
          );
        }).toList(),
        onChanged: (String? value) {
          if (value != null) {
            _changeLanguage(context, value);
          }
        },
        dropdownColor: Colors.white,
        style: const TextStyle(
          color: Color(0xFF092d52),
          fontSize: 16,
        ),
      ),
    );
  }
}