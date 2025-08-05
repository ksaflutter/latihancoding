import 'package:flutter/material.dart';

class Latihanhari7 extends StatelessWidget {
  const Latihanhari7({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bikin APP Sedekah'),
        // title color white
        foregroundColor: Colors.white, 
        backgroundColor: Colors.teal,  
       
      ),
      // buat text headline 
      body: Padding( 
        padding :EdgeInsetsGeometry.all(20.0),
        child: ListView(
          // buat text headline
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Head Line'), 
            )
          ],
          
        ),
       )

  }
}