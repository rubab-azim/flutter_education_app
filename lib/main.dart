import 'package:flutter/material.dart';
import 'package:flutter_education_app/core/res/colours.dart';
import 'package:flutter_education_app/core/res/fonts.dart';
import 'package:flutter_education_app/core/services/injection_container.dart';
import 'package:flutter_education_app/core/services/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
        colorScheme: ColorScheme.fromSwatch(accentColor: Colours.primaryColour),
        fontFamily: Fonts.poppins,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      onGenerateRoute: generateRoutes,
    );
  }
}
