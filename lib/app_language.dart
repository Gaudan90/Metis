import 'package:flutter/material.dart';

class AppLanguage extends InheritedWidget {
  final Locale locale;
  final Function(Locale) changeLanguage;

  const AppLanguage({
    super.key,
    required this.locale,
    required this.changeLanguage,
    required super.child,
  });

  static AppLanguage of(BuildContext context) {
    final AppLanguage? result = context.dependOnInheritedWidgetOfExactType<AppLanguage>();
    assert(result != null, 'No AppLanguage found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(AppLanguage oldWidget) {
    return locale != oldWidget.locale;
  }
}