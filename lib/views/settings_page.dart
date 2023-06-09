import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/widgets/settings_item.dart';

/// A class representing the settings of the app
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

/// A class representing the state of the settings page
class _SettingsPageState extends State<SettingsPage> {
  final _settings = Settings();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Settings")),
        body: AnimatedBuilder(
            // AnimatedBuilder is used to load the settings from SharedPreferences
            animation: _settings,
            builder: (context, child) {
              // Build the settings list if the settings have been loaded
              if (_settings.hasData) return buildSettingsList();
              // Show a loading indicator while the settings are loading
              return const Center(child: CircularProgressIndicator());
            }));
  }

  // Build the list of settings
  Widget buildSettingsList() {
    return SizedBox.expand(
        child: Column(children: [
      SettingsItem.toggle(
        text: "Enable Notifications",
        value: _settings.notifications,
        onChanged: (value) => _settings.notifications = value,
        leading: const Icon(Icons.notifications),
      ),
      SettingsItem(
        text: "Location Settings",
        onTap: openLocationSettings,
        trailing: const Icon(Icons.exit_to_app),
      ),
      SettingsItem(
        text: "Reset Welcome Screen",
        onTap: _settings.resetWelcomeScreen,
        trailing: const Icon(Icons.restart_alt),
      ),
    ]));
  }

  // Set the notifications setting
  void setNotifications(SharedPreferences prefs, bool value) {
    setState(() {
      prefs.setBool("notifications", value);
    });
  }

  // Open the phone's location settings page
  void openLocationSettings() {
    Geolocator.openLocationSettings()
        .catchError((_) => print("Can't open settings on current platform"))
        .ignore();
  }

  // Show the welcome screen again on the next app launch
  void resetWelcome() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('completedWelcome', false);
  }
}

class Settings extends ChangeNotifier {
  SharedPreferences? _prefs;
  bool hasData = false;
  late bool _notifications;
  bool get notifications => _notifications;
  set notifications(bool value) {
    _prefs?.setBool("notifications", value).then((_) {
      _notifications = value;
      notifyListeners();
    });
  }

  Settings() {
    SharedPreferences.getInstance().then((value) => _loadPrefs(value));
  }

  // Show the welcome screen again on the next app launch
  void resetWelcomeScreen() {
    _prefs?.setBool("completedWelcome", false);
  }

  // Load the settings from SharedPreferences
  _loadPrefs(SharedPreferences prefs) {
    _prefs = prefs;
    hasData = true;
    _notifications = _prefs!.getBool("notifications") ?? true;
    notifyListeners();
  }
}
