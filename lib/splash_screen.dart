import 'dart:async';
import 'package:empresa_abc/user-interface/bottom_navigation.dart';
import 'package:empresa_abc/user-interface/clientes_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavigation())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset("assets/logo.png", height: 100.0),
          SizedBox(height: 30.0),
          Text("EMPRESA ABC", style: TextStyle(fontSize: 30),),
          SizedBox(height: 50.0),

          SpinKitRipple(color: Colors.red),
        ],
      ),
    );
  }

}