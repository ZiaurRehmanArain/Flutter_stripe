import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:testapp/stripe_services/stripe_services.dart';

void main()async {
   WidgetsFlutterBinding.ensureInitialized();

  //Assign publishable key to flutter_stripe
  Stripe.publishableKey = "pk_test_51QKHhBHVuF3PVZMqTaj9UbiayN05aQc4BlrL3ptOD0CKYgdhHimtCfekMd3Yqsei8wDW603Or3sroBp8CwhwKKP500fpnmvWaa";
    await dotenv.load(fileName: "assets/.env");
  // Stripe.instance.applySettings();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('payment chatbot'),),
        body: Column(children: [
          ElevatedButton(onPressed: ()async{
            print('press');
         await   StripeServices().makePayment(context);
            print('press last');
            
            }, child: Text('Payment'))
        ],),
      ),
    );
  }
}