import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lets_talk_money/home.dart';

class SignIn extends StatefulWidget{
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('Friendly Chat App')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(25),
                child: Image.asset('assets/chat.jpeg'),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                        onPressed: () {
                          signIn();
                        },
                        child: Text('Anon Log In'),
                      style: ElevatedButton.styleFrom(primary: Colors.pink),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future <String?> signIn() async{
    try{
      await auth.signInAnonymously();
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MyHomePage()));
      return 'Signed In';
    } on FirebaseAuthException catch(e){
      return e.message;
    }
  }
}