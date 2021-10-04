import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fridayy_one/business_login/models/message_model.dart';
import 'package:fridayy_one/business_login/utils/routing_constants.dart';
import 'package:fridayy_one/business_login/utils/theme.dart';
import 'package:fridayy_one/router.dart' as router;
import 'package:fridayy_one/services/service_locator.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Directory dir = await path.getApplicationDocumentsDirectory();
  Hive
    ..init(dir.path)
    ..registerAdapter(MessageAdapter());
  await Hive.openBox<Message>('messages');
  setupServiceLocator();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fridayy',
      theme: FridayyThemes.lightTheme,
      darkTheme: FridayyThemes.lightTheme,
      debugShowCheckedModeBanner: false,
      navigatorKey: navigationService.navigatorKey,
      onGenerateRoute: router.generateRoute,
      initialRoute: Routes.splashScreen,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: Theme.of(context)
              .textTheme
              .caption!
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
