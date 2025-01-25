import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:testapp/view/Home_view.dart';

const apiKey = 'AIzaSyBviOcUyzrYe_BfuLjK7SUi_LkPKa6mNBc';


void main()async {
   WidgetsFlutterBinding.ensureInitialized();
  //Assign publishable key to flutter_stripe
  Stripe.publishableKey = "pk_test_51QKHhBHVuF3PVZMqTaj9UbiayN05aQc4BlrL3ptOD0CKYgdhHimtCfekMd3Yqsei8wDW603Or3sroBp8CwhwKKP500fpnmvWaa";
    await dotenv.load(fileName: "assets/.env");
    Gemini.init(apiKey: apiKey, enableDebugging: true);
  // Stripe.instance.applySettings();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeView()
    );
  }
}