import 'dart:math';

import 'package:flutter/material.dart';

class Mas extends StatefulWidget {
  @override
  _MasState createState() => _MasState();
}

class _MasState extends State<Mas> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            title: Text('Mas'),
            centerTitle: true,
            backgroundColor: Colors.indigo[400],
          ),
          body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 300,
                height: 300,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: new BorderRadius.all(new Radius.circular(30.0)),
                    gradient: new LinearGradient(
                        colors: [Colors.indigo[400], Colors.purple[100]],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        tileMode: TileMode.mirror),
                        boxShadow: [
            BoxShadow(
                blurRadius: 10, color: Colors.black, offset: Offset(10, 10))
          ],
                        ),
                         transform: Matrix4.rotationZ(pi/40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/logo.png',height: 150.0),
                    SizedBox(height: 30,),
                    Text("Empresa", style: TextStyle(fontSize: 28, color: Colors.white),),
                    Text("ABC", style: TextStyle(fontSize: 25, color: Colors.white))
                  ],
                ), 
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
