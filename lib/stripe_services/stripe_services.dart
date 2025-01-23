import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeServices {
  var paymentIntent;
  Future<void> makePayment(context) async {
    try {
      //STEP 1: Create Payment Intent
       paymentIntent = await createPaymentIntent('600', 'USD');

      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
            
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent![
                      'client_secret'], //Gotten from payment intent
                  style: ThemeMode.light,
                  // googlePay: PaymentSheetGooglePay(merchantCountryCode:'' ),
                  merchantDisplayName: 'Ikay'))
          .then((value) {});

      //STEP 3: Display Payment sheet
      displayPaymentSheet(context);
    } catch (err) {
      throw Exception(err);
    }
  }


  createPaymentIntent(String amount, String currency) async {

    try {

       double pkrAmount = double.parse(amount);
    double usdAmount = pkrAmount / 280; // Example exchange rate: 1 USD = 280 PKR
    int stripeAmount = (usdAmount * 100).round();
      //Request body
      Map<String, dynamic> body = {
        'amount': stripeAmount.toString(),
        'currency': currency,
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }



  displayPaymentSheet(context) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        print('payment detial : //////////////////////////:   ${paymentIntent!['id']}');
        // print('payment detial : //////////////////////////:   $value');

      
        paymentIntent = null;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('PAID succeed')));
      }).onError((error, stackTrace) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('PAID Fial')));

        throw Exception(error);
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Fialed')));

     
    } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('PAID fialed')));

      print('$e');
    }
  }
}