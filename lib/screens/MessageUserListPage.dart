import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:t_teet_rider/models/UserProfile.dart';
import 'package:t_teet_rider/screens/Messaging.dart';
import 'package:t_teet_rider/utils/Colors.dart';
import 'package:t_teet_rider/utils/Constants.dart';
import 'package:t_teet_rider/utils/StorageManager.dart';


class MessageUserListPage extends StatefulWidget {



  @override
  _MessageUserListPageState createState() => _MessageUserListPageState();
}

class _MessageUserListPageState extends State<MessageUserListPage> {
  var messages = List<Message>();

//  var name ="";
  var phone = "";
  var userListId = List<String>();
  var userList = List<UserProfile>();
  var filteredUserList = List<UserProfile>();



  @override
  void initState() {
    getRiders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.colorPrimary,
        title: Text("Messages",
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700)),
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.close, color: Colors.white)),
      ),
      body: Container(
        height: height,
        width: width,
        color: Colors.white,
        child: SingleChildScrollView(child: allData()),
      ),
    );
  }

  getRiders() async {
    phone = await StorageManager().getPhone();
    Firestore.instance
        .collection('messages')
        .document("$phone")
        .snapshots()
        .forEach((element) {
      print("${element.documentID}");
      setState(() {
        userListId.add(element.documentID);
      });
    });

    await Firestore.instance
        .collection('users')
        .getDocuments().then((value) => {
          for(var i in value.documents){
            userList.add(UserProfile.fromJson(i.data))
          }
    });

    for(var z in userList){
      if(phone == z.phone){
//        print("I am ${z.name}");
        setState(() {
          filteredUserList.add(z);

        });

         print(filteredUserList);
      }
    }
  }

  Widget allData() {
    for (var i in filteredUserList) {
      return myItems(i);
    }
  }

  Widget myItems( UserProfile userProfile) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: FlatButton(
          child: Row(
            children: <Widget>[
              Material(
                child: userProfile.profile != null
                    ? CachedNetworkImage(
                  placeholder: (context, url) => Container(
                    child: CircularProgressIndicator(
                      strokeWidth: 1.0,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          AppColor.colorPrimary),
                    ),
                    width: 50.0,
                    height: 50.0,
                    padding: EdgeInsets.all(15.0),
                  ),
                  imageUrl: userProfile.profile,
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.fitWidth,
                )
                    : Container(
                    height: 50.0,
                    width: 50.0,
                    child: Image(image: NetworkImage(Constants.PLACEHOLDER))),
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                clipBehavior: Clip.hardEdge,
              ),
              Flexible(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                          'Name: ${userProfile.name}',
                          style: TextStyle(color: Colors.white),
                        ),
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                      ),
                      Container(
                        child: Text(
                          'Phone number: ${userProfile.phone}',
                          style: TextStyle(color: Colors.white),
                        ),
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                      ),

                    ],
                  ),
                  margin: EdgeInsets.only(left: 20.0),
                ),
              ),
            ],
          ),
          onPressed: () {
            print("hello"+ userProfile.name);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MessagingPage(userProfile.name)),

            );
          },
          color: AppColor.colorPrimary,
          padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
      margin: EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
    );
  }

}



class Message {
  String name;
  String message;

  Message({this.name, this.message});
}
