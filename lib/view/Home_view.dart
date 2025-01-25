import 'package:flutter/material.dart';
import 'package:testapp/stripe_services/stripe_services.dart';
import 'package:testapp/view/Gemini_view.dart';
import 'package:testapp/view/customize_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('payment chatbot'),),
        body: Column(children: [
          ElevatedButton(onPressed: ()async{
            print('press');
         await   StripeServices().makePayment(context);
            print('press last');
            
            }, child: Text('Payment')),
            ElevatedButton(onPressed: (){


              Navigator.push(context, MaterialPageRoute(builder: (context) => CustomizeView(),));
            }, child: Text('Customize')),

            

            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(),));
            }, child: Text('Gemini'))
        ],),
      );
  }
}