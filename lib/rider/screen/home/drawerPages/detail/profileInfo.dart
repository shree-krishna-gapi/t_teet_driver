import 'package:flutter/material.dart';
import 'package:t_teet_rider/utils/Colors.dart';
import 'package:t_teet_rider/utils/Styles.dart';
class ProfileInfo extends StatefulWidget {
  final String name,email,city,gender,phone;
  ProfileInfo({this.name,this.email,this.city,this.gender,this.phone});
  @override
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;
    var height = screenSize.height;

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.black)),
        title: Text("Your Info", style: TextStyles.TitleStyle),
        backgroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          Padding(
            padding: EdgeInsets.only(left: width * 0.03),
            child: Text("Name",
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w700,
                    fontSize: 16.0)),
          ),
          Padding(
            padding: EdgeInsets.only(left: width * 0.03),
            child: Container(
              width: width * 0.87,
              height: height * 0.07,
              child: TextFormField(
                enabled: false,
//                controller: _firstnamecontroller,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[200])),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.black)),
                    filled: true,
                    fillColor: Colors.grey[200],
                    labelStyle: TextStyle(color: Colors.black87),
                    labelText: "${widget.name}"),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Padding(
            padding: EdgeInsets.only(left: width * 0.03),
            child: Text("Phone",
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w700,
                    fontSize: 16.0)),
          ),
          Padding(
            padding: EdgeInsets.only(left: width * 0.03),
            child: Container(
              width: width * 0.87,
              height: height * 0.07,
              child: TextFormField(
                enabled: false,
//                controller: _firstnamecontroller,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[200])),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.black)),
                    filled: true,
                    fillColor: Colors.grey[200],
                    labelStyle: TextStyle(color: Colors.black87),
                    labelText: "${widget.phone}"),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Padding(
            padding: EdgeInsets.only(left: width * 0.03),
            child: Text("Email",
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w700,
                    fontSize: 16.0)),
          ),
          Padding(
            padding: EdgeInsets.only(left: width * 0.03),
            child: Container(
              width: width * 0.87,
              height: height * 0.07,
              child: TextFormField(
                enabled: false,
//                controller: _firstnamecontroller,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[200])),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.black)),
                    filled: true,
                    fillColor: Colors.grey[200],
                    labelStyle: TextStyle(color: Colors.black87),
                    labelText: "${widget.email}"),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Padding(
            padding: EdgeInsets.only(left: width * 0.03),
            child: Text("Gender",
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w700,
                    fontSize: 16.0)),
          ),
          Padding(
            padding: EdgeInsets.only(left: width * 0.03),
            child: Container(
              width: width * 0.87,
              height: height * 0.07,
              child: TextFormField(
                enabled: false,
//                controller: _firstnamecontroller,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[200])),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.black)),
                    filled: true,
                    fillColor: Colors.grey[200],
                    labelStyle: TextStyle(color: Colors.black87),
                    labelText: "${widget.gender}"),
              ),
            ),
          ),
        ],
      ),
    );
  }
  labelText(String txt) {
    return Align(child: Text('$txt',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),alignment: Alignment.centerRight,);
  }
  labelFieldText(String txt) {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Align(child: Text('$txt',style: TextStyle(fontSize: 16,),),alignment: Alignment.centerLeft,),
    );
  }
}
