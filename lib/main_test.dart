import 'package:business/src/assets/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:business/src/controllers/navigator/navigator_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final NavigatorController _controller = Get.put(NavigatorController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GetMaterialApp(
        home: MyHomePage(),
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: _controller.themeMode(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final NavigatorController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Theme Example'),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Obx(
              () => Container(
                width: double.infinity,
                margin: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey, // Change the color as needed
                    width: 1.0, // Adjust the border width
                  ),
                  borderRadius:
                      BorderRadius.circular(8.0), // Adjust the border radius
                ),
                child: CupertinoSlidingSegmentedControl<ThemeMode>(
                  children: {
                    ThemeMode.light: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'Light',
                        style: TextStyle(color: Get.theme.dividerColor),
                      ),
                    ),
                    ThemeMode.dark: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'Dark',
                        style: TextStyle(color: Get.theme.dividerColor),
                      ),
                    ),
                    ThemeMode.system: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'System',
                        style: TextStyle(color: Get.theme.dividerColor),
                      ),
                    ),
                  },
                  thumbColor: Get.theme.cardColor,
                  groupValue: _controller.themeMode(),
                  backgroundColor: Colors.transparent,
                  onValueChanged: (value) =>
                      setThemeMode(context, value as ThemeMode),
                ),
              ),
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text('Your App Content Goes Here'),
      ),
    );
  }

  setThemeMode(BuildContext context, ThemeMode themeMode) {
    _controller.setThemeMode(themeMode);
    Navigator.pop(context);
  }
}
