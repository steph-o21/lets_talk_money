import 'package:flutter/widgets.dart';
import 'package:lets_talk_money/signIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lets_talk_money/chat.dart';
import 'package:lets_talk_money/profile.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lets_talk_money/ad_helper.dart';

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late String currUserID = auth.currentUser!.uid;

  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;
  InterstitialAd? _interstitialAd;
  bool _isInterstitialAdReady = false;

  @override
  void initState() {
    super.initState();
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );
    _bannerAd.load();
    //loads the interstitial ad when home_page state is first initiated
    _loadInterstitialAd();
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
              title: Text('Welcome'),
              centerTitle: true,
              //profile icon that leads to profile page to allow for changes
              leading: IconButton(
                icon: Icon(Icons.person),
                onPressed: (){
                  //loads the interstitial ad everytime user clicks profile icon
                  _loadInterstitialAd();
                  //sends in the interstitial variables into the profile info page
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile(interstitialAd: _interstitialAd, isInterstitialAdReady: _isInterstitialAdReady)));
                },
              ),
              actions: <Widget>[
                //Log out icon button
                IconButton(
                    icon: Icon(Icons.logout,color: Colors.white),
                    //on pressed, will show alert dialog asking for user to confirm logging out
                    onPressed: () => showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          //description message in alert dialog
                            content: Text('Are you sure you want to log out?'),
                            actions: <Widget>[
                              //will cancel and return back to home page
                              TextButton(
                                child: Text('Cancel'),
                                onPressed: () => Navigator.pop(context, 'Cancel'),
                              ),
                              //will sign out user and return to splash screen
                              TextButton(
                                child: Text('Yes'),
                                onPressed: () {
                                  auth.signOut();
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>SignIn()));
                                },
                              ),
                            ]
                        )
                    )
                )
              ]
          ),
          //Stream builder returns message posts from firesetore database
          body: Stack(
              children:[
                StreamBuilder<QuerySnapshot>(
                  //returns document of users that excludes the current users document
                  stream: firestore.collection('users').where('user_id', isNotEqualTo: currUserID).snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    else
                      //maps document snapshot content from query snapshot
                      return ListView(
                        children: snapshot.data!.docs.map((doc) {
                          return Card(
                            child: ListTile(
                                title: Text(doc['username']),
                                trailing: ElevatedButton(
                                    onPressed: (){
                                      //saves username and userID of person user will be chatting with
                                      String username = doc['username'];
                                      String userID = doc['user_id'];
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Chat(peer: username, peerID: userID)));
                                    },
                                    child: Text('Message')
                                )
                            ),
                          );
                        }).toList(),
                      );
                  },
                ),
                //if banner ad is ready, display banner ad
                if(_isBannerAdReady)
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: _bannerAd.size.width.toDouble(),
                        height: _bannerAd.size.height.toDouble(),
                        child: AdWidget(ad: _bannerAd),
                      )
                  )
              ]
          )
      ),
    );
  }
  //method to load the interstitial ad
  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          this._interstitialAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              //ProfileInfo();
            },
          );
          _isInterstitialAdReady = true;
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
          _isInterstitialAdReady = false;
        },
      ),
    );
  }
}

