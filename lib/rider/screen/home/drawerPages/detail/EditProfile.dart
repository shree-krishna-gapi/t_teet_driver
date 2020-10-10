import 'package:flutter/material.dart';
import 'package:t_teet_rider/screens/HomeScreen.dart';
import 'package:t_teet_rider/utils/Colors.dart';
import 'package:t_teet_rider/utils/StorageManager.dart';
import 'package:t_teet_rider/utils/Styles.dart';
import 'package:t_teet_rider/utils/staticWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t_teet_rider/utils/toastManager.dart';
class EditPage extends StatefulWidget {
  EditPage({this.name,this.gender,this.email,this.phone});
  final String name,gender,email,phone;
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  var phone = "";
  var email = "";
  var name = "";
  String currentGenderName;
  Firestore firestore = Firestore.instance;
  @override
  void initState() {
    defaultGender();
    getName();
    super.initState();
  }
  defaultGender() {
    currentGenderName = widget.gender;
  }
  chooseGender(String gender) {
    print('gender $gender');
    setState(() {
      currentGenderName = gender;
    });
  }
  changeInfo() async{
    print(currentGenderName);
    print(_firstnamecontroller.text);
    var manager = StorageManager();
    var phone = await manager.getPhone();
    bool result = await networkStatus();
    if(result) {
      showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              content: Wait(txt:'please wait...'),
            );
          });
      await firestore.collection("riders").document('$phone').updateData({
        "name": _firstnamecontroller.text,
        "gender": currentGenderName
      });
      StorageManager().setUserName(_firstnamecontroller.text);
      Navigator.pop(context);
      // Navigator.pop(context);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
    }
    else {
      Navigator.pop(context);
      ToastManager().fromValidationError(context,'Please, check your internet connection');
    }

//    StorageManager().setUserName(name);
//    Navigator.pop(context);
  }
  var _firstnamecontroller = TextEditingController();
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;
    var height = screenSize.height;
    _firstnamecontroller = TextEditingController(text:widget.name);
    var _lastnamecontroller = TextEditingController();
    _firstnamecontroller.text = '${widget.name}';
    List gender = ["Male", "Female"];
    String select;


//    currentGenderName = widget.gender;
    Row addRadioButton(int btnValue, String title) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Radio(
            activeColor: Colors.black,
            value: gender[btnValue],
            groupValue: select,
            onChanged: (value) {
              print(value);
              setState(() {
                select = value;
              });
            },
          ),

          Text(title)
        ],
      );
    }

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.black)),
        actions: <Widget>[
          InkWell(
            onTap: changeInfo,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Save",
                  style: TextStyle(fontSize: 16,color: Colors.black),
                ),
                SizedBox(width: width / 25),
              ],
            ),
          ),
        ],
        title: Text("Your Info", style: TextStyles.TitleStyle),
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: height * 0.02),
            Padding(
              padding: EdgeInsets.only(left: width * 0.055),
              child: Text("Personal Info",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 16.0)),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Center(
              child: Container(
                width: width * 0.87,
                height: height * 0.07,
                child: TextFormField(
                  controller: _firstnamecontroller,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () => _firstnamecontroller.clear(),
                      icon: Icon(
                        Icons.clear,
                        color: Colors.black,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[200])),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.black)),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: "First Name",

                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
//            Center(
//              child: Container(
//                width: width * 0.87,
//                height: height * 0.07,
//                child: TextFormField(
//                  controller: _lastnamecontroller,
//                  decoration: InputDecoration(
//                      suffixIcon: IconButton(
//                        onPressed: () => _lastnamecontroller.clear(),
//                        icon: Icon(
//                          Icons.clear,
//                          color: Colors.black,
//                        ),
//                      ),
//                      enabledBorder: OutlineInputBorder(
//                          borderRadius: BorderRadius.all(Radius.circular(8)),
//                          borderSide: BorderSide(color: Colors.grey[200])),
//                      focusedBorder: OutlineInputBorder(
//                          borderRadius: BorderRadius.all(Radius.circular(8)),
//                          borderSide: BorderSide(color: Colors.black)),
//                      filled: true,
//                      fillColor: Colors.grey[100],
//                      hintText: "Last Name"),
//                ),
//              ),
//            ),
//            SizedBox(
//              height: height * 0.02,
//            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "Gender :",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),

                Row(
                  children: [
                    currentGenderName == 'male' ? InkWell(onTap: ()=>chooseGender('male'), child: ActiveRadio()):
                    InkWell(onTap: ()=>chooseGender('male'),child: InActiveRadio()),
                    Padding(
                      padding: const EdgeInsets.only(left:10),
                      child: Text('Male'),
                    ),
                    SizedBox(width: 15,),
                    currentGenderName == 'female' ? InkWell(onTap: ()=>chooseGender('female'), child: ActiveRadio()):
                    InkWell(onTap: ()=>chooseGender('female'),child: InActiveRadio()),
                    Padding(
                      padding: const EdgeInsets.only(left:10),
                      child: Text('Female'),
                    ),
                  ],
                ),
//                addRadioButton(0, 'Male'),
//                addRadioButton(1, 'Female'),
              ],
            ),
            SizedBox(
              height: height * 0.04,
            ),
            Padding(
              padding: EdgeInsets.only(left: width * 0.055),
              child: Text("Account Info",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 16.0)),
            ),
            ListTile(
                title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.email,
                            color: Colors.black,
                          ),
                          SizedBox(width: 15.0),
                          Text("Email", style: TextStyles.TileStyle),
                          Text(" "),
                          Text(".",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500)),
                          Text(" "),
                          Text("Unverified",
                              style: TextStyle(
                                color: AppColor.offLineColor,
                                fontSize: 13,
                              )),
                        ],
                      ),
                      Row(children: <Widget>[
                        SizedBox(
                          width: 40.0,
                        ),
                        Text("$email", style: TextStyles.SubtitleStyle),
                      ])
                    ])),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                height: 1.0,
                width: width * 0.95,
                color: Colors.grey[200],
              ),
            ),
            ListTile(
                title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.phone,
                            color: Colors.black,
                          ),
                          SizedBox(width: 15.0),
                          Text("Phone", style: TextStyles.TileStyle),
                          Text(" "),
                          Text(".",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500)),
                          Text(" "),
                          Text("Verified",
                              style: TextStyle(
                                color: AppColor.noticeColor,
                                fontSize: 13,
                              )),
                        ],
                      ),
                      Row(children: <Widget>[
                        SizedBox(
                          width: 40.0,
                        ),
                        Text("$phone", style: TextStyles.SubtitleStyle),
                      ])
                    ])),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                height: 1.0,
                width: width * 0.95,
                color: Colors.grey[200],
              ),
            ),
            ListTile(
              title: Row(children: <Widget>[
                Icon(
                  Icons.payment,
                  color: Colors.black,
                ),
                SizedBox(width: 15.0),
                Text("Add payment method",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500))
              ]),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                height: 1.0,
                width: width * 0.95,
                color: Colors.grey[200],
              ),
            ),
          ],
        ),
      ),
    );
  }

  getName() {
    StorageManager().getPhone().then((value) {
      setState(() {
        phone = value;
      });
    });
    StorageManager().getPhone().then((value) {
      setState(() {
        email = value;
      });
    });
  }
}
