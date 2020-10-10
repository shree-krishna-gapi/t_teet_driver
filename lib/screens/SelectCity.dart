import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../utils/StorageManager.dart';
import '../screens/GenderPage.dart';
import '../utils/Colors.dart';

class SelectCity extends StatefulWidget {
  @override
  _SelectCityState createState() => _SelectCityState();
}

class _SelectCityState extends State<SelectCity> {
  final _formKey = GlobalKey<FormState>();
  final _citynameController = TextEditingController();

  List cityList = [
    {
      'id': 0,
      'name': 'Kathmandu',
      'value': 'one'
    },
    {
      'id': 1,
      'name': 'Patan',
      'value': 'two'
    },
    {
      'id': 2,
      'name': 'Bhaktapur',
      'value': 'three'
    }
  ];


  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;
    var height = screenSize.height;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        titleSpacing: 0.0,
        automaticallyImplyLeading: false,
        centerTitle: false,
        elevation: 0.0,
        title: GestureDetector(
          onTap:(){Navigator.pop(context);},
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
                Text(
                  "Back",
                  style: TextStyle(
                    color: Colors.black,  fontSize: 15, fontWeight: FontWeight.normal,
                  ),
                )
              ]
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        height: height,
        width: width,
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              width: width,
              child: Padding(
                padding: EdgeInsets.only(top: height * 0.05, left:30.0),
                child: Text(
                  "Choose Your City",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
            Container(
              height: height * 0.05,
              color: Colors.white,
            ),
            Expanded(
              child: Container(
                width: width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(30),
                    topRight: const Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: width * 0.8,
                        padding: EdgeInsets.only(top: height * 0.005),
                        child: TextFormField(
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          controller: _citynameController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            fillColor: Colors.white,
                            hintText: "Your city",
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Container(
                          padding: EdgeInsets.only(top: height * 0.3),
                          child: SizedBox(
                            height: height * 0.08,
                            width: width * 0.6,
                            child: RaisedButton(
                              child: Text(
                                "Next",
                                style: TextStyle(fontSize: 20.0),
                              ),
                              textColor: Colors.white,
                              onPressed: () {
                                StorageManager()
                                    .setUserName(_citynameController.value.text);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => GenderPage()));
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(height * 0.1),
                              ),
                              color: AppColor.colorPrimary,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
