import 'package:example/features/home/home_page.dart';
import 'package:example/features/locator/locator.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_flite/mvvm_flite.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ServiceLocatorProvider.locator(
      locator: locator,
      child: MaterialApp(
        title: 'Simple MVVM Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
