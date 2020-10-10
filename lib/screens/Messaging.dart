import 'dart:async';

import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:t_teet_rider/models/UserProfile.dart';
import 'package:t_teet_rider/utils/Colors.dart';
import 'package:t_teet_rider/utils/Constants.dart';
import 'package:t_teet_rider/utils/StorageManager.dart';
import 'package:t_teet_rider/utils/Utils.dart';

class MessagingPage extends StatefulWidget {

  String id;
  String name;
  UserProfile userProfile;

  MessagingPage(this.id);




  @override
  _MessagingPageState createState() => _MessagingPageState();
}

class _MessagingPageState extends State<MessagingPage> {
  var name = "";
  var phone = "";
  var messages = List<ChatMessages>();
  final TextEditingController _messageController = new TextEditingController();

  final ScrollController listScrollController = ScrollController();

  var m = List<ChatMessages>();
  var u = UserProfile();
  UserProfile userProfile;




  var i = 0;

  @override
  void initState() {
    initialize();
//    initializeMessages();
//    buildListMessage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var heightback;
    if(height <= 650){
      heightback = height*0.19;
    }
    else{
      heightback = height*0.154;
    }


    double pixelRatio = MediaQuery.of(context).devicePixelRatio;
    double px = 1 / pixelRatio;

//    BubbleStyle styleSomebody = BubbleStyle(
//      nip: BubbleNip.leftBottom,
//      color: Colors.white,
//      elevation: 1 * px,
//      margin: BubbleEdges.only(top: height / 2, right: 50.0),
//      alignment: Alignment.topLeft,
//    );
//    BubbleStyle styleMe = BubbleStyle(
//      nip: BubbleNip.rightBottom,
//      color: Colors.white,
//      elevation: 1 * px,
//      margin: BubbleEdges.only(top: height / 3, left: 50.0),
//      alignment: Alignment.topRight,
//    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: Stack(children: <Widget>[
        Container(
          width: width,
          height: height,
          color: Colors.grey[300],
//          child: Bubble(
//            alignment: Alignment.center,
//            color: Colors.grey[300],
//            elevation: 0,
//            margin: BubbleEdges.only(top: 8.0),
//          ),
        ),
        Padding(
            padding: EdgeInsets.only(top: 140),
            child: SingleChildScrollView(child: receiveMsg())),

        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: new BoxDecoration(
              shape: BoxShape.rectangle,
              border: new Border.all(
                color: Colors.white,
                width: 1.0,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Stack(children: <Widget>[
                Container(
                  color: Colors.white,
                  child: TextFormField(
                    controller: _messageController,
                    textAlign: TextAlign.start,
                    onFieldSubmitted: (value) {
                      _messageController.text = value;
                    },
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: const InputDecoration(
                      fillColor: Colors.white,
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
//                      suffixIcon: RaisedButton(child: Icon(Icons.send),
//                      ),
                      hintText: "Send message",

                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: width * 0.9),
                    child: IconButton(
                        icon: Icon(
                          Icons.send,
                          color: AppColor.colorPrimary,
                        ),
                        onPressed: () {
                          sendMessage("${_messageController.text}");
                        })),
              ]),
            ),
          ),
        ),
        Container(
          height: heightback,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24.0),
                  bottomRight: Radius.circular(24.0))),
        ),
//        Center(child: RaisedButton(child: Text("Press Here"),
//            onPressed: (){sendMessage("");})),
        Stack(children: <Widget>[
          Positioned(
            top: 0,
            child: Container(
              width: width,
              decoration: BoxDecoration(
                  color: AppColor.colorPrimary,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(24.0),
                      bottomRight: Radius.circular(24.0))),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ),
                              Text(
                                "Back",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: new BoxDecoration(
                                  color: Colors.grey,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      alignment: Alignment.center,
                                      image:
                                          NetworkImage(Constants.PLACEHOLDER),
                                      fit: BoxFit.fill)),
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              "${widget.id}",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.phone_in_talk,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  )
                ],
              ),
            ),
          ),
        ]),
      ]),
    );
  }

  Firestore firestore;

  initialize() async {
    getFirestoreInstance().then((value) {
      firestore = value;
      getAllData();
    });
    getName();
  }

  void sendMessageData(String message) async {
    var text = _messageController.text;
    var manager = StorageManager();
    var user = await manager.getUser();
    await firestore.collection("messages/$phone/${widget.id}").add({
      "time": DateTime.now().millisecondsSinceEpoch.toString(),
      "name": user.name,
      "phone": user.phone,
      "message": text
    });
  }

  void getMessages() async {
    var manager = StorageManager();
    var user = await manager.getUser();
//    await firestore.collection("messages/users/$phone")
  }

//  void initializeMessages() {
//    var time = DateTime.now().millisecondsSinceEpoch;
//    messages.add(ChatMessages("$time","$name","$phone",_messageController.text));
////    messages.add(ChatMessages("$time","$name","$phone",_messageController.text));
////    messages.add(ChatMessages("$time","$name","$phone",_messageController.text));
//  }
  void sendMessage(message) {
    sendMessageData(message);
    /*var text = _messageController.text;
    var time = DateTime.now().millisecondsSinceEpoch;
    setState(() {
      messages.add(ChatMessages("$time", "$name", "$phone", text));
    });*/
    _messageController.text = '';
    setState(() {
      Timer(
          Duration(milliseconds: 500),
          () => listScrollController
              .jumpTo(listScrollController.position.maxScrollExtent));
    });
  }

  getName() {
    StorageManager().getUserName().then((value) {
      setState(() {
        name = value;
      });
    });
    StorageManager().getPhone().then((value) {
      setState(() {
        phone = value;
      });
    });
  }

  ///

  Future<String> getAllData() async {
    /*Firestore.instance
        .collection('messages')
        .document('users')
        .collection('+9779808603897')
        .getDocuments()
        .then((value) =>
    {
      value.documents.forEach((f) {
        print('${f.data}}');
        messages.add(ChatMessages.fromJson(f.data));
      })
    });*/

    Firestore.instance
        .collection('messages')
        .document("$phone")
        .collection('${widget.id}')
        .snapshots(includeMetadataChanges: true)
        .listen((event) {
      for (var dc in event.documentChanges) {
        switch (dc.type) {
          case DocumentChangeType.added:
            setState(() {
              messages.add(ChatMessages.fromJson(dc.document.data));
            });
            break;
        }
      }
    });
  }

  Widget receiveMsg() {
    BubbleStyle styleSomebody = BubbleStyle(
      padding: BubbleEdges.all(20),
      nip: BubbleNip.leftBottom,
      color: Colors.white,
      margin: BubbleEdges.only(top: 10 / 2, right: 50.0),
      alignment: Alignment.topLeft,
    );

    BubbleStyle styleMe = BubbleStyle(
      padding: BubbleEdges.all(20),
      nip: BubbleNip.rightBottom,
      color: Colors.white,
      margin: BubbleEdges.only(top: 10 / 3, left: 50.0),
      alignment: Alignment.topRight,
    );

    return Column(
      children: [
        for (var i in messages)
          i.phone == phone
              ? Bubble(
                  style: styleMe,
                  child: Text('${i.message}'),
                  margin: BubbleEdges.only(top: 20 / 5.20),
                )
              : Bubble(
                  style: styleSomebody,
                  child: Text('${i.message}'),
                  margin: BubbleEdges.only(top: 20 / 5.20),
                ),
      ],
    );
  }
}

class ChatMessages {
  String time;
  String name;
  String phone;
  String message;

  ChatMessages(this.time, this.name, this.phone, this.message);

  ChatMessages.fromJson(Map<String, dynamic> json)
      : time = json['time'],
        phone = json['phone'],
        name = json['name'],
        message = json['message'];
}
