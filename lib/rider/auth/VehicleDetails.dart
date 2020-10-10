import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:t_teet_rider/rider/auth/LicenseDetails.dart';
import 'package:t_teet_rider/utils/staticWidget.dart';
import 'package:t_teet_rider/utils/Colors.dart';
import 'package:t_teet_rider/utils/fadeAnimation.dart';
import 'package:t_teet_rider/utils/StorageManager.dart';
import 'package:t_teet_rider/utils/toastManager.dart';
//import 'package:fluttertoast/fluttertoast.dart';
class VechileDetails extends StatefulWidget {
  @override
  _VechileDetailsState createState() => _VechileDetailsState();
}

class _VechileDetailsState extends State<VechileDetails> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _vehicleType = TextEditingController();
  TextEditingController _vehicleNumber = TextEditingController();
  TextEditingController _vehicleModel = TextEditingController();
  TextEditingController _vehicleColor = TextEditingController();
  TextEditingController _vehicleYear = TextEditingController();
  TextEditingController _vehicleDoor = TextEditingController();
  TextEditingController _vehicleSeat = TextEditingController();
  String a;
  List vehicleList = [
    {
      'id': 0,
      'name': 'Two-wheeler',
      'value': 'one'
    },
    {
      'id': 1,
      'name': 'Four-wheeler',
      'value': 'two'
    },
    {
      'id': 2,
      'name': 'Four-wheeler-Deluxe',
      'value': 'three'
    }
  ];
  int vehicleIndex;
  String vehicleName = '';
  bool carSelection = false;
  _showVechicleType() {
    showDialog<void>(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                content: Container(
                  height: 100,
                  width: double.minPositive,
                  child: ListView.builder(
                    itemCount: vehicleList.length,
                    itemBuilder: (BuildContext context,int index) {
                      return  index == vehicleIndex ? InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 7.0),
                          child: Row(
                            children: <Widget>[
                              ActiveRadio(),
                              Padding(padding: EdgeInsets.only(left: 10),child: Text('${vehicleList[index]['name']}'),)
                            ],
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            vehicleIndex = index;
                          });
                          vehicleSelectFunction(index);
                        },
                      ):InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 7.0),
                          child: Row(
                            children: <Widget>[
                              InActiveRadio(),
                              Padding(padding: EdgeInsets.only(left: 10),child: Text('${vehicleList[index]['name']}'),)
                            ],
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            vehicleIndex = index;
                          });
                          vehicleSelectFunction(index);
                        },
                      );
                    },
                  ),
                ),
              );
            },
          );
        });
  }
  vehicleSelectFunction(index) {
    setState(() {
      vehicleName = vehicleList[index]['name'];
      print(vehicleName);
    });
    if(index==1) {
      setState(() {
        carSelection = true;
      });
    }
    else {
      setState(() {
        carSelection = false;
      });
    }
    Timer(Duration(milliseconds: 100),()=> Navigator.of(context).pop());
  }
  final FocusNode _fieldTwo = FocusNode();
  final FocusNode _fieldThree = FocusNode();
  final FocusNode _fieldFour = FocusNode();
  final FocusNode _fieldFive = FocusNode();
  final FocusNode _fieldSix = FocusNode();
  final FocusNode _fieldSeven = FocusNode();
  _inputFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
  static const double textFieldPadding = 0.0;
  static const double inputFieldPadding = 24.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        automaticallyImplyLeading: false,
        centerTitle: false,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppBarBack(txt:'Back',onPressed: (){
              Navigator.of(context).pop();
            },),
            AppBarSkip(txt:'Skip',onPressed: (){
            },),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: ListView(
              children: <Widget>[
                FadeAnimation(
                  0.1, Padding(
                  padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
                  child: FormTitle(title: 'Vehicle Details',),
                ),
                ),
                FadeAnimation(
                  0.2, Padding(
                  padding: const EdgeInsets.symmetric(vertical: textFieldPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ), decoration: InputDecoration(hintText: vehicleName == '' ? "Vehicle Type" : vehicleName,contentPadding: EdgeInsets.only(top: inputFieldPadding),hintStyle: TextStyle(
                          fontSize: 15, color: vehicleName == '' ?Colors.black45 : Colors.black
                      ),
                        suffixIcon: Icon(Icons.arrow_drop_down,size: 28),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColor.inputFocusColor,width: 1.2),
                        ),
                      ),readOnly: true,
                        onTap: _showVechicleType,
                      ),
                      FormFieldSubText(subText:'Choose your vehicle type'),
                    ],
                  ),
                ),
                ),

                FadeAnimation(
                  0.3, Padding(
                  padding: const EdgeInsets.symmetric(vertical: textFieldPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        focusNode: _fieldTwo,
                        onFieldSubmitted: (term) {
                          _inputFocusChange(context, _fieldTwo, _fieldThree);
                        },
                        controller: _vehicleNumber,
                        onChanged: (val) {
                        },
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ), decoration: InputDecoration(hintText: "Vehicle Number",contentPadding: EdgeInsets.only(top: inputFieldPadding),hintStyle: TextStyle(
                        fontSize: 15, color: Colors.black45,
                      ),suffixIcon: Icon(Icons.arrow_drop_down,size: 28,),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColor.inputFocusColor,width: 1.2),
                        ),
                      ),

                      ),
                      FormFieldSubText(subText:'Eg. Ba87 Pa8645'),
                    ],
                  ),
                ),
                ),

                FadeAnimation(
                  0.4, Padding(
                  padding: const EdgeInsets.symmetric(vertical: textFieldPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        focusNode: _fieldThree,
                        onFieldSubmitted: (term) {
                          _inputFocusChange(context, _fieldThree, _fieldFour);
                        },
                        controller: _vehicleModel,
                        onChanged: (val) {
                        },
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ), decoration: InputDecoration(hintText: "Vehicle Model",contentPadding: EdgeInsets.only(top: inputFieldPadding),hintStyle: TextStyle(
                        fontSize: 15, color: Colors.black45,
                      ),suffixIcon: Icon(Icons.arrow_drop_down,size: 28,),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColor.inputFocusColor,width: 1.2),
                        ),
                      ),

                      ),
                      FormFieldSubText(subText:'Eg. Yahama FzFi, Bajaj Pulsar 150'),
                    ],
                  ),
                ),
                ),

                FadeAnimation(
                  0.4, Padding(
                  padding: const EdgeInsets.symmetric(vertical: textFieldPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        focusNode: _fieldFour,
                        onFieldSubmitted: (term) {
                          _inputFocusChange(context, _fieldFour, _fieldFive);
                        },
                        controller: _vehicleColor,
                        onChanged: (val) {
                        },
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ), decoration: InputDecoration(hintText: "Vehicle Colour",contentPadding: EdgeInsets.only(top: inputFieldPadding),hintStyle: TextStyle(
                        fontSize: 15, color: Colors.black45,
                      ),suffixIcon: Icon(Icons.arrow_drop_down,size: 28,),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColor.inputFocusColor,width: 1.2),
                        ),
                      ),

                      ),
                      FormFieldSubText(subText:'Choose the colour of your vehicle'),
                    ],
                  ),
                ),
                ),

                FadeAnimation(0.4,Padding(
                  padding: const EdgeInsets.symmetric(vertical: textFieldPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        focusNode: _fieldFive,
                        onFieldSubmitted: (term) {
                          _inputFocusChange(context, _fieldFive, _fieldSix);
                        },
                        controller: _vehicleYear,
                        onChanged: (val) {
                        },
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ), decoration: InputDecoration(hintText: "Vehicle Make Year",contentPadding: EdgeInsets.only(top: inputFieldPadding),hintStyle: TextStyle(
                        fontSize: 15, color: Colors.black45,
                      ),suffixIcon: Icon(Icons.arrow_drop_down,size: 28,),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColor.inputFocusColor,width: 1.2),
                        ),
                      ),

                      ),
                      FormFieldSubText(subText:'Eg. 2010, 2015'),
                    ],
                  ),
                )),
                carSelection ? FadeAnimation(
                  0.2, Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: textFieldPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            focusNode: _fieldSix,
                            onFieldSubmitted: (term) {
                              _inputFocusChange(context, _fieldSix, _fieldSeven);
                            },
                            controller: _vehicleDoor,
                            onChanged: (val) {
                            },
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ), decoration: InputDecoration(hintText: "Number of Doors",contentPadding: EdgeInsets.only(top: inputFieldPadding),hintStyle: TextStyle(
                            fontSize: 15, color: Colors.black45,
                          ),suffixIcon: Icon(Icons.arrow_drop_down,size: 28,),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColor.inputFocusColor,width: 1.2),
                            ),
                          ),
                          ),
                          FormFieldSubText(subText:'Eg. Two, Three'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: textFieldPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            focusNode: _fieldSeven,
                            textInputAction: TextInputAction.done,
                            controller: _vehicleSeat,
                            onChanged: (val) {
                            },
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ), decoration: InputDecoration(hintText: "Number of Seats",contentPadding: EdgeInsets.only(top: inputFieldPadding),hintStyle: TextStyle(
                            fontSize: 16, color: Colors.black45,
                          ),suffixIcon: Icon(Icons.arrow_drop_down,size: 28,),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColor.inputFocusColor,width: 1.2),
                            ),
                          ),

                          ),
                          FormFieldSubText(subText:'Eg. 3, 4'),
                        ],
                      ),
                    ),
                  ],
                ),
                ):Container(),
                SizedBox(height: 40,),
                FadeAnimation(
                  0.2, CleanButton(text:'Next',onPressed: () {
                  if(vehicleName == null || vehicleName == '') {
                    ToastManager().fromValidationError(context,'Please, provide a vehicle name');
                  }else if(_vehicleNumber.text == null || _vehicleNumber.text == '') {
                    ToastManager().fromValidationError(context,'Please, provide a vehicle number');
                  }
                  else if(_vehicleModel.text == null || _vehicleModel.text == '') {
                    ToastManager().fromValidationError(context,'Please, provide a vehicle model');
                  }
                  else if(_vehicleColor.text == null || _vehicleColor.text == '') {
                    ToastManager().fromValidationError(context,'Please, provide a vehicle color');
                  }
                  else if(_vehicleYear.text == null || _vehicleYear.text == '') {
                    ToastManager().fromValidationError(context,'Please, provide a vehicle year');
                  }
                  else {
                    print(carSelection);
                    if(carSelection == true ) {
                      print('sdfdsf${_vehicleDoor.text}');
                      if(_vehicleDoor.text == null || _vehicleDoor.text == '') {
                        ToastManager().fromValidationError(context,'Please, provide a no. of vehicle doors');
                      }else if(_vehicleSeat.text == null || _vehicleSeat.text == '') {
                        ToastManager().fromValidationError(context,'Please, provide a no. of vehicle seats');
                      }else {
                        StorageManager().setVehicleDoor(_vehicleDoor.text);
                        StorageManager().setVehicleSeat(_vehicleSeat.text);
                        StorageManager().setVehicleName(vehicleName);
                        StorageManager().setVehicleNumber(_vehicleNumber.text);
                        StorageManager().setVehicleModel(_vehicleModel.text);
                        StorageManager().setVehicleColor(_vehicleColor.text);
                        StorageManager().setVehicleYear(_vehicleYear.text);
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => LicenseDetails()));
                      }
                    }
                    else {
                      StorageManager().setVehicleName(vehicleName);
                      StorageManager().setVehicleNumber(_vehicleNumber.text);
                      StorageManager().setVehicleModel(_vehicleModel.text);
                      StorageManager().setVehicleColor(_vehicleColor.text);
                      StorageManager().setVehicleYear(_vehicleYear.text);
                      Navigator.push(
                        context, MaterialPageRoute(builder: (context) => LicenseDetails()));
                    }
                  }

                  },),
                ),
              ],
            ),
          ),
        ),
        decoration: BoxDecoration(
            gradient: AppColor.primaryGradient
        ),
      ),
    );
  }



}
