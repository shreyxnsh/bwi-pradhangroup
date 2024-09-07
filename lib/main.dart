import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pradhangroup/navigationmenu.dart';

import 'login/loginUI.dart';
import 'onboard/firstonboard.dart';
import 'onboard/splash.dart';
import 'package:typesense/typesense.dart' as typesense;

var client;
Future main() async {
  await GetStorage.init();
   final host = "tkbs34xd5wfh6ucgp-1.a1.typesense.net",
      protocol = typesense.Protocol.https;
  final config = typesense.Configuration(
// Api key
    'OFS4RMW1vOAzJrwh1qM8i8If5qed7x4B',
    nodes: {
      typesense.Node(
        protocol,
        host,
        port: 443,
      ),
      typesense.Node.withUri(
        Uri(
          scheme: 'https',
          host: host,
          port: 443,
        ),
      ),
      typesense.Node(
        protocol,
        host,
        port: 443,
      ),
    },
    numRetries: 3, // A total of 4 tries (1 original try + 3 retries)
    connectionTimeout: const Duration(seconds: 2),
  );
  client = typesense.Client(config);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget { 
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Pradhan Group',debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: splash(),
    );
  }
}
extension ColorExtension on String {
  toColor() {
    var hexColor = this.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}


