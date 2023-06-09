import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/widgets/multistep_page.dart';

/// A class representing the onboarding page of the app using the [MultistepPage] widget
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultistepPage(
        onDone: () => _completedWelcome(context),
        onNextPage: (page) async {
          if (page == 0) {
            try {
              await Permission.location
                  .request(); // Request location permission
            } catch (_) {
              print("No permissions on this device");
            }
          } else {
            try {
              await Permission.notification
                  .request(); // Request notification permission
            } catch (_) {
              print("No permissions on this device");
            }
          }
        },
        pages: [
          // Page 1 - Ask for location permission
          Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/images/location_welcome.png',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 40,
                bottom: 40,
                right: 40,
                left: 40,
                child: Column(children: [
                  Expanded(flex: 9, child: Container()),
                  const Expanded(
                      flex: 2,
                      child: Text('Location',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                          ),
                          textAlign: TextAlign.center)),
                  const Expanded(
                      flex: 3,
                      child: Text(
                        'Providing access to your location data let\'s us give more accurate pollen estimates nearby!',
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 24,
                            fontFamily: "Varela"),
                        textAlign: TextAlign.center,
                      )),
                  Flexible(flex: 3, child: Container()),
                ]),
              ),
            ],
          ),
          // Page 2 - Ask for notification permission
          Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/images/location_notification.png',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 40,
                bottom: 40,
                right: 40,
                left: 40,
                child: Column(children: [
                  Expanded(flex: 9, child: Container()),
                  const Expanded(
                      flex: 2,
                      child: Text('Notifications',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                          ),
                          textAlign: TextAlign.center)),
                  const Expanded(
                      flex: 3,
                      child: Text(
                        'Notifications allow you receive warnings for high pollen levels nearby',
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 24,
                            fontFamily: "Varela"),
                        textAlign: TextAlign.center,
                      )),
                  Flexible(flex: 3, child: Container()),
                ]),
              ),
            ],
          ),
        ]);
  }

  void _completedWelcome(BuildContext context) async {
    // Navigate to the home page
    Navigator.of(context).pushNamedAndRemoveUntil("/", (route) => false);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('completedWelcome',
        true); // Mark the welcome screen as completed so it doesn't appear again
  }
}
