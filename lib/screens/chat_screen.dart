// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, avoid_print, prefer_const_literals_to_create_immutables

import 'package:chatnest/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  String messages = '';
  User? loggeduser;

  final messageClear = TextEditingController();
  void loadUser() {
    final user = _auth.currentUser;
    if (user != null) {
      print("User is currently signed in.");
      setState(() {
        loggeduser = user;
      });
      print(loggeduser!.email);
    } else {
      print("No user is currently signed in.");
    }
  }

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              _auth.signOut();
              Navigator.pop(context);
            },
          ),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue,
              Colors.purple,
              Colors.red,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('messages')
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.lightBlueAccent,
                      ),
                    );
                  }
                  final messages = snapshot.data!.docs;
                  List<MessageBuble> messagesWidgets = [];
                  for (var message in messages) {
                    final messageData = message.data() as Map<String, dynamic>?;
                    final messagetext = messageData?['text'] ?? '';
                    final messageSender = messageData?['sender'] ?? 'Unknown';
          
                    final messageWidget = MessageBuble(
                      sender: messageSender,
                      text: messagetext,
                      isCurrentUser: messageSender == loggeduser!.email,
                    );
                    messagesWidgets.add(messageWidget);
                  }
          
                  return Expanded(
                    child: ListView(
                      key: ValueKey(messagesWidgets),
                      reverse: true,
                      children: messagesWidgets,
                    ),
                  );
                },
              ),
              Container(
                decoration: kMessageContainerDecoration,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: messageClear,
                        onChanged: (value) {
                          messages = value;
                        },
                        decoration: kMessageTextFieldDecoration,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (messages.isNotEmpty) {
                          _firestore.collection('messages').add(
                            {
                              'text': messages,
                              'sender': loggeduser?.email ?? 'Unknown',
                              'timestamp': FieldValue.serverTimestamp(),
                            },
                          );
                          messageClear.clear();
                        }
                      },
                      child: Text(
                        'Send',
                        style: kSendButtonTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MessageBuble extends StatelessWidget {
  const MessageBuble(
      {required this.sender,
      required this.text,
      super.key,
      required this.isCurrentUser});
  final String sender;
  final String text;
  final isCurrentUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Material(
            borderRadius: isCurrentUser
                ? BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
            elevation: 5,
            color: isCurrentUser ? Colors.lightBlue : Colors.red,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                text,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
