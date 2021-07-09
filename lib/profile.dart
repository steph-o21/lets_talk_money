import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Profile extends StatefulWidget{
  const Profile({required this.interstitialAd, required this.isInterstitialAdReady});

  final InterstitialAd? interstitialAd;
  final bool? isInterstitialAdReady;

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile>{
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late String first, last, username;
  late InterstitialAd? _interstitialAd;
  late bool? _isInterstitialAdReady;


  @override
  void initState(){
    super.initState();
    _interstitialAd = widget.interstitialAd;
    _isInterstitialAdReady = widget.isInterstitialAdReady;

    //if the ad is loaded, show the ad
    if (_isInterstitialAdReady !=null) {
      _interstitialAd?.show();
    }
  }


  @override
  Widget build (BuildContext context){
    return Scaffold(
      appBar: AppBar(
          title: Text(auth.currentUser?.displayName.toString() ?? "null"),
          centerTitle: true
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 16, top: 25, right: 16),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget> [
                Text("Edit Profile", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
                SizedBox(height: 15),
                Center(
                    child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage('https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png')
                    )
                ),
                SizedBox(height: 15),
                //first name
                TextField(
                    onChanged: (value){
                      first = value.trim();
                    },
                    decoration: InputDecoration(
                      labelText: 'First Name',
                    )
                ),
                //last name
                TextField(
                    onChanged: (value){
                      last = value.trim();
                    },
                    decoration: InputDecoration(
                        labelText: 'Last Name'
                    )
                ),
                //user name
                TextField(
                    onChanged: (value){
                      username = value.trim();
                    },
                    decoration: InputDecoration(
                        labelText: 'User Name',
                        hintText: auth.currentUser?.displayName
                    )
                ),
                SizedBox(height: 15),
                ElevatedButton(
                    onPressed: (){
                      saveChanges(first, last, username);
                    },
                    child: Text("Save", style: TextStyle(fontSize: 15, color: Colors.white))
                )
              ]
          ),
        ),
      ),
    );
  }
  Future<String?> saveChanges(String first, String last, String username) async{

    //updates current user's display name
    auth.currentUser?.updateDisplayName(username).then((_){
      print("Display Name Was Changed Successively");
    }).catchError((error){
      print("Cannot be changed");
    });

    CollectionReference user = firestore.collection('user');
    user.doc(auth.currentUser?.uid).set({
      'first': first,
      'last': last,
      'username': username,
      'user_id': auth.currentUser!.uid
    }).then((value)=>print("Changes made successfully")).catchError((error)=>print("Failed to make changes:$error"));
  }
}
