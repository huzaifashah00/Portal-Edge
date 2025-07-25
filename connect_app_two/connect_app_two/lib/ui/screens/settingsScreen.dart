import 'package:uol_student/ui/widgets/settingsContainer.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  static Widget routeInstance() {
    return const SettingsScreen();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SettingsContainer(),
    );
  }
}
