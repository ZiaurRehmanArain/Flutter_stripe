import 'package:flutter/material.dart';
import 'package:testapp/view/3d_model_view.dart';

class CustomizeView extends StatelessWidget {
  const CustomizeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('CUstomize'),),
      body: Column(children: [
            ElevatedButton(onPressed: (){
             

              
            }, child: Text('On Text ')),
            ElevatedButton(onPressed: (){

              
            }, child: Text('Text with logo ')),
            ElevatedButton(onPressed: (){
 Navigator.push(context, MaterialPageRoute(builder: (context) => My3DMdodelRender(),));
              
            }, child: Text('3d model ')),
      ],),
    );
  }
}