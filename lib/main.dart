import 'package:dynamic_todo_form_application/provider/productProviderClass.dart';
import 'package:dynamic_todo_form_application/view/HomePage.dart';
import 'package:dynamic_todo_form_application/view/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ProductProvider()),
  ], child:const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {'/home': (context) => const HomePage(),
      '/':(context) => const SplashScreen()},
      initialRoute: '/',
    );
  }
}
