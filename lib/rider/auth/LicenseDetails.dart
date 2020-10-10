import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:t_teet_rider/utils/staticWidget.dart';
import 'package:t_teet_rider/utils/Colors.dart';
import 'package:t_teet_rider/utils/fadeAnimation.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:t_teet_rider/rider/auth/DocDetails.dart';
import 'package:t_teet_rider/utils/StorageManager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:t_teet_rider/utils/toastManager.dart';
class LicenseDetails extends StatefulWidget {
  @override
  _LicenseDetailsState createState() => _LicenseDetailsState();
}

class _LicenseDetailsState extends State<LicenseDetails> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _licenseNumber = TextEditingController();
  TextEditingController _licenseExpiryDate = TextEditingController();
  TextEditingController _bluebookExpiryDate = TextEditingController();

  final FocusNode _fieldTwo = FocusNode();
  final FocusNode _fieldThree = FocusNode();
  final FocusNode _fieldFour = FocusNode();
  _inputFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
  static const double textFieldPadding = 0.0;
  static const double inputFieldPadding = 24.0;
  bool privateVechicle = false;
  bool publicVehile = false;

  _getDate()async {
    NepaliDateTime _selectedDateTime = await picker.showMaterialDatePicker(
      context: context,
      initialDate: NepaliDateTime.now(),
      firstDate: NepaliDateTime(2050),
      lastDate: NepaliDateTime(2090),
      initialDatePickerMode: DatePickerMode.day,
    );
    print(_selectedDateTime);
  }
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
                  child: FormTitle(title: 'License and Bluebook Information',),
                ),
                ),
//                FlatButton(onPressed: _getDate, child: Text('Demo')),
                FadeAnimation(
                  0.2, Padding(
                  padding: const EdgeInsets.symmetric(vertical: textFieldPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top:10.0,bottom: 8.0),
                        child: Text('Vechicle Type:',style: TextStyle(fontSize: 16,color: Colors.black87),),
                      ),
                      Row(
                        children: <Widget>[
                          InkWell(
                            onTap:() {
                              setState(() {
                                publicVehile = false;
                                privateVechicle = true;
                              });
                          },
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: privateVechicle ? ActiveRadio():InActiveRadio(),
                                ),
                                Text('Private Vehicle',style: TextStyle(fontSize: 14,color: Colors.black),),
                              ],
                            ),
                          ),
                          SizedBox(width: 8,),
                          InkWell(
                            onTap: () {
                              setState(() {
                                privateVechicle = false;
                                publicVehile = true;
                              });
                            },
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: publicVehile ? ActiveRadio():InActiveRadio(),
                                ),
                                Text('Public Vehicle',style: TextStyle(fontSize: 14,color: Colors.black),)
                              ],
                            ),
                          )
                        ],
                      )
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
                        controller: _licenseNumber,
                        onChanged: (val) {
                        },
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ), decoration: InputDecoration(hintText: "License Number",contentPadding: EdgeInsets.only(top: inputFieldPadding),hintStyle: TextStyle(
                        fontSize: 15, color: Colors.black45,
                      ),suffixIcon: Icon(Icons.arrow_drop_down,size: 28,),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColor.inputFocusColor,width: 1.2),
                        ),
                      ),

                      ),
                      FormFieldSubText(subText:'Eg. 05-03-00025478'),
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
                        controller: _licenseExpiryDate,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ), decoration: InputDecoration(hintText: "License Expiry Date",contentPadding: EdgeInsets.only(top: inputFieldPadding),hintStyle: TextStyle(
                        fontSize: 15, color: Colors.black45,
                      ),suffixIcon: Icon(Icons.arrow_drop_down,size: 28,),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColor.inputFocusColor,width: 1.2),
                        ),
                      ),

                      ),
                      FormFieldSubText(subText:'See on your license'),
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
                        textInputAction: TextInputAction.done,
                        focusNode: _fieldFour,
                        controller: _bluebookExpiryDate,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(hintText: "Bluebook Expiry Date",contentPadding: EdgeInsets.only(top: inputFieldPadding),hintStyle: TextStyle(
                        fontSize: 15, color: Colors.black45,
                      ),suffixIcon: Icon(Icons.arrow_drop_down,size: 28,),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColor.inputFocusColor,width: 1.2),
                        ),
                      ),

                      ),
                      FormFieldSubText(subText:'See on your license'),
                    ],
                  ),
                ),
                ),

                SizedBox(height: 40,),
                FadeAnimation(
                  0.4, CleanButton(text:'Next',onPressed: () async{

                      String licenseNumber= _licenseNumber.text;
                      String licenseExpiryDate = _licenseExpiryDate.text;
                      String bluebookExpiryDate = _bluebookExpiryDate.text;
                      if (privateVechicle == false && publicVehile == false) {
                        ToastManager().fromValidationError(context,'Please, choose vechicle type');
                      }else if(licenseNumber == null || licenseNumber== '') {
                        ToastManager().fromValidationError(context,'Please, provide license number');
                      } else if (licenseExpiryDate == null || licenseExpiryDate == ''){
                        ToastManager().fromValidationError(context,'Please, provide license expiry date');
                      }
                      else if (bluebookExpiryDate == null || bluebookExpiryDate == ''){
                        ToastManager().fromValidationError(context,'Please, provide bluebook expiry date');
                      }
                      else {
                        StorageManager().setVehicleType(privateVechicle);
                        StorageManager().setLicenseNumber(licenseNumber);
                        StorageManager().setLicenseExpiryDate(licenseExpiryDate);
                        StorageManager().setBluebookExpiryDate(bluebookExpiryDate);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DocDetails()));
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
