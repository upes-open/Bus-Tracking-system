import 'package:flutter/material.dart';
import '../main.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    super.initState();
_navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(Duration(milliseconds: 2000), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(color: Color(0xfff6f8f4)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Center(
                child:Image.asset(
                  'assets/images/bus.png',
                ),
              ),
                Text(
                  " UPES BUS TARCKER",
                  style: TextStyle(
                    height: 5,
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                  ),
                ),
                CircularProgressIndicator(),
              ],
            )),
      ),
    );
  }
}
