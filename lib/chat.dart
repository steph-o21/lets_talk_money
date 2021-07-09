import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bubble/bubble.dart';

class Chat extends StatelessWidget{
  const Chat({Key? key, required this.peer, required this.peerID}): super(key: key);
  final String peer, peerID;

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: Text(peer),
          centerTitle: true,
        ),
        body: ChatBox(peer: peer, peerID: peerID)
    );
  }
}

class ChatBox extends StatefulWidget{

  const ChatBox({required this.peer, required this.peerID});
  final String peer, peerID;

  @override
  _ChatBoxState createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  final auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final _messageHolder = TextEditingController();

  late String message, currUserID, peerID, conversationID;

  @override
  void initState() {
    super.initState();
    currUserID = auth.currentUser!.uid;
    peerID = widget.peerID;
    conversationID = getconversationID(currUserID, widget.peerID);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
          children: <Widget>[
            Column(
                children: <Widget>[
                  buildMessage(),
                  buildInput()
                ]
            )
          ],
        )
    );
  }

  void sendMessage() {
    _messageHolder.clear(); //to clear textbox

    firestore.collection('messages').doc(conversationID).collection(conversationID).add({ //adding message to firebase
      'user': <String>[currUserID, widget.peerID],
      'idFrom': currUserID,
      'idTo': widget.peerID,
      'date_time': DateTime.now(),
      'content': message
    }).then((value) => print("Message Sent")).catchError((error) =>
        print("Error: Failed to Send Message:$error"));
  }

  String getconversationID(String userID, String peerID) {
    return userID.hashCode <= peerID.hashCode
        ? userID + '_' + peerID
        : peerID + '_' + userID;
  }

  Widget buildMessage() {
    return Flexible(
      child: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('messages').doc(conversationID).collection(
            conversationID).orderBy('date_time', descending: false).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else
            //maps document snapshot content from query snapshot
            return ListView(
              children: snapshot.data!.docs.map((doc) {
                return buildItem(doc);
              }).toList(),
            );
        },
      ),
    );
  }

  Widget buildInput() {
    return Container(
        child: Row(
            children: <Widget>[
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(
                          left: 10.0, top: 10.0, bottom: 10.0),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            message = value.trim();
                          });
                        },
                        controller: _messageHolder,
                        decoration: InputDecoration(
                            filled: true,
                            labelText: 'Write a message',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0)
                            )
                        ),
                      )
                  )
              ),
              Container(
                  child: ElevatedButton(
                      child: Icon(Icons.send, color: Colors.white),
                      style: ElevatedButton.styleFrom(shape: CircleBorder(),
                          padding: EdgeInsets.all(10.0),
                          primary: Colors.pink),
                      onPressed: () {
                        sendMessage();
                      }
                  )
              )
            ]
        )
    );
  }
  Widget buildItem(QueryDocumentSnapshot listMessage) {
    return Row(
      children: <Widget>[
        // Text
        Container(
          padding: EdgeInsets.all(5.0),
          margin: EdgeInsets.symmetric(vertical: 5),
          child: Bubble(
              padding: const BubbleEdges.all(10.0),
              elevation: 0,
              color: listMessage['idFrom'] == currUserID ? Colors.pink: Colors.purple,
              child: Text(listMessage['content'], style: listMessage['idFrom'] == currUserID ? TextStyle(color: Colors.white) : TextStyle(color: Colors.white))
          ),
        )
      ],
      mainAxisAlignment:listMessage['idFrom'] == currUserID ? MainAxisAlignment.end : MainAxisAlignment.start,
    );
  }
}
