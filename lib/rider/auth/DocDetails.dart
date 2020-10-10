import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:t_teet_rider/screens/HomeScreen.dart';
import 'package:t_teet_rider/screens/TermsOfServicePage.dart';
import 'package:t_teet_rider/utils/StorageManager.dart';
import 'package:t_teet_rider/utils/Utils.dart';
import 'package:t_teet_rider/utils/staticWidget.dart';
import 'package:t_teet_rider/utils/Colors.dart';
import 'package:t_teet_rider/utils/fadeAnimation.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:t_teet_rider/utils/toastManager.dart';
class DocDetails extends StatefulWidget {
  @override
  _DocDetailsState createState() => _DocDetailsState();
}

class _DocDetailsState extends State<DocDetails> {
  FirebaseStorage firebaseStorage;
  Firestore firestore;
  bool privateRadio = false;
  bool publicRadio = false;
  double boxHeight = 90.0;
  double iconHeight = 28.0;
  File licensePhoto;
  File citizenshipFrontPhoto;
  File citizenshipBackPhoto;
  File blueBookFrontPhoto;
  File blueBookBackPhoto;

  @override
  void initState() {
    // TODO: implement initState
    initialize();
    super.initState();
  }

  final picker = ImagePicker();
  Future getImage(photo) async {
    bool connection = await networkStatus();
    if(connection) {
      waitAlert();
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      if(photo == 'licensePhoto') {
        setState(() {
          licensePhoto = File(pickedFile.path);
        });
        _uploadFile(licensePhoto,'licensePhoto');
      }else if(photo == 'citizenshipFrontPhoto') {
        setState(() {
          citizenshipFrontPhoto = File(pickedFile.path);
        });
        _uploadFile(citizenshipFrontPhoto,'citizenshipFrontPhoto');
      }else if(photo == 'citizenshipBackPhoto') {
        setState(() {
          citizenshipBackPhoto = File(pickedFile.path);
        });
        _uploadFile(citizenshipBackPhoto,'citizenshipBackPhoto');
      }else if(photo == 'blueBookFrontPhoto') {
        setState(() {
          blueBookFrontPhoto = File(pickedFile.path);
        });
        _uploadFile(blueBookFrontPhoto,'blueBookFrontPhoto');
      }else if(photo == 'blueBookBackPhoto') {
        setState(() {
          blueBookBackPhoto = File(pickedFile.path);
        });
        _uploadFile(blueBookBackPhoto,'blueBookBackPhoto');
      }
      Navigator.of(context).pop();
    }
    else {
      ToastManager().fromValidationError(context,'Please check your network connection');
    }


  }
  waitAlert() {
    showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            content: Wait(txt:'please wait...'),
          );
        });
  }

  initialize() async {
    getFirebaseStorage().then((value) {
      firebaseStorage = value;
    });



  }


  Future<void> _uploadFile(image,imageDesc) async {
    String phone = await StorageManager().getPhone();
    final StorageReference ref = firebaseStorage.ref().child('rider').child(phone).child(imageDesc).child('$image');
    final StorageUploadTask uploadTask = ref.putFile(
      image,
    );
    uploadTask.onComplete.then((value) {
      value.ref.getDownloadURL().then((value) {
//        print("pci ${value}");
        if(value == null || value == '') {
          ToastManager().fromValidationError(context,'Upload Failled! please, try again');
        }else {
          if(imageDesc == 'licensePhoto') {
            licensePhotoId = value;
            StorageManager().setLicensePhoto(value);
          }else if(imageDesc == 'citizenshipFrontPhoto') {
            citizenshipFrontPhotoId = value;
            StorageManager().setBlueBookBackPhoto(value);
          }else if(imageDesc == 'citizenshipBackPhoto') {
            citizenshipBackPhotoId = value;
            StorageManager().setBlueBookBackPhoto(value);
          }else if(imageDesc == 'blueBookFrontPhoto') {
            blueBookFrontPhotoId = value;
            StorageManager().setBlueBookFrontPhoto(value);
          } else if(imageDesc == 'blueBookBackPhoto') {
            blueBookBackPhotoId = value;
            StorageManager().setBlueBookBackPhoto(value);
          }
        }
      });
    });
  }
  String licensePhotoId;
  String citizenshipFrontPhotoId;
  String citizenshipBackPhotoId;
  String blueBookFrontPhotoId;
  String blueBookBackPhotoId;
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
            AppBarSkip(txt:'',onPressed: (){
            },),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 10),
            child: ListView(
              children: <Widget>[
                FadeAnimation(
                  0.1,FormTitle(title: 'Upload your documents',),
                ),
                SizedBox(height: 15,),
                FadeAnimation(0.2,Padding(padding: EdgeInsets.only(left: 15),child: Row(
                  children: <Widget>[
                    Expanded(child: Padding(
                      padding: const EdgeInsets.only(right:15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start ,
                        children: <Widget>[
                          Material(
                            color:Colors.transparent,
                            child: InkWell(
                              splashColor: AppColor.colorPrimary,
                              onTap:(){
                                getImage('licensePhoto');
                              },
                              child: Container(height: boxHeight,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColor.colorPrimary,
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColor.colorPrimary.withOpacity(0.02),
                                    spreadRadius: 5,
                                    blurRadius: 5,
                                    offset: Offset(0, 0), // changes position of shadow
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(12),
                              ),
//                              child: Icon(Icons.camera_enhance,color: Colors.green,),
                                child: Stack(
                                  children: <Widget>[
                                    licensePhoto != null ? ClipRRect(borderRadius: BorderRadius.circular(11),
                                  child: Image.file(licensePhoto,fit: BoxFit.cover,height: boxHeight,width: double.infinity,)):Container(),
                                  Positioned(child: Center(
                                    child: Image.asset('assets/images/cameraIcon.PNG', height: iconHeight,
                                      fit: BoxFit.cover,color: AppColor.colorPrimary, ),
                                  ),
                                  ),
//                                  _image != null ? Image.file(_image):Text(''),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 6.0,bottom: 15.0),
                            child: Text('Upload Your License Picture',style: TextStyle(fontSize: 13,color: Colors.black.withOpacity(0.8)),),
                          )
                        ],
                      ),
                    ),flex: 1,),
                    SizedBox(width: 30,),
                    Expanded(child: Container(),flex: 1,)
                  ],
                ),)),
                FadeAnimation(0.3,Padding(padding: EdgeInsets.symmetric(horizontal: 10),child: Row(
                  children: <Widget>[
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start ,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right:10.0),
                          child: Material(
                            color:Colors.transparent,
                            child: InkWell(
                              splashColor: AppColor.colorPrimary,
                              onTap:(){
                                getImage('citizenshipFrontPhoto');
                              },
                              child: Container(height: boxHeight,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColor.colorPrimary,
                                    width: 2,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColor.colorPrimary.withOpacity(0.02),
                                      spreadRadius: 5,
                                      blurRadius: 5,
                                      offset: Offset(0, 0), // changes position of shadow
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(12),
                                ),
//                              child: Icon(Icons.camera_enhance,color: Colors.green,),
                                child: Stack(
                                  children: <Widget>[
                                    citizenshipFrontPhoto != null ? ClipRRect(borderRadius: BorderRadius.circular(11),
                                        child: Image.file(citizenshipFrontPhoto,fit: BoxFit.cover,height: boxHeight,width: double.infinity)):
                                    Container(),
                                    Positioned(child: Center(
                                      child: Image.asset('assets/images/cameraIcon.PNG', height: iconHeight,
                                        fit: BoxFit.cover,color: AppColor.colorPrimary, ),
                                    )
                                    ),
//                                  _image != null ? Image.file(_image):Text(''),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                       labelDescription('Upload Your Citizenship Front Picture'),
                      ],
                    ),flex: 1,),
                    SizedBox(width: 30,),
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start ,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right:10.0),
                          child: Material(
                            color:Colors.transparent,
                            child: InkWell(
                              splashColor: AppColor.colorPrimary,
                              onTap:(){
                                getImage('citizenshipBackPhoto');
                              },
                              child: Container(height: boxHeight,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColor.colorPrimary,
                                    width: 2,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColor.colorPrimary.withOpacity(0.02),
                                      spreadRadius: 5,
                                      blurRadius: 5,
                                      offset: Offset(0, 0), // changes position of shadow
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(12),
                                ),
//                              child: Icon(Icons.camera_enhance,color: Colors.green,),
                                child: Stack(
                                  children: <Widget>[
                                    citizenshipBackPhoto != null ? ClipRRect(borderRadius: BorderRadius.circular(11),
                                        child: Image.file(citizenshipBackPhoto,fit: BoxFit.cover,height: boxHeight,width: double.infinity)):Container(),
                                    Positioned(child: Center(
                                      child: Image.asset('assets/images/cameraIcon.PNG', height: iconHeight,
                                        fit: BoxFit.cover,color: AppColor.colorPrimary, ),
                                    )
                                    ),
//                                  _image != null ? Image.file(_image):Text(''),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        labelDescription('Upload Your Citizenship Back Picture'),
                      ],
                    ),flex: 1,)
                  ],
                ),)),
                SizedBox(height: 15,),
                FadeAnimation(0.3,Padding(padding: EdgeInsets.symmetric(horizontal: 10),child: Row(
                  children: <Widget>[
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start ,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right:10.0),
                          child: Material(
                            color:Colors.transparent,
                            child: InkWell(
                              splashColor: AppColor.colorPrimary,
                              onTap:(){
                                getImage('blueBookFrontPhoto');
                              },
                              child: Container(height: boxHeight,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColor.colorPrimary,
                                    width: 2,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColor.colorPrimary.withOpacity(0.02),
                                      spreadRadius: 5,
                                      blurRadius: 5,
                                      offset: Offset(0, 0), // changes position of shadow
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(12),
                                ),
//                              child: Icon(Icons.camera_enhance,color: Colors.green,),
                                child: Stack(
                                  children: <Widget>[
                                    blueBookFrontPhoto != null ? ClipRRect(borderRadius: BorderRadius.circular(11),
                                        child: Image.file(blueBookFrontPhoto,fit: BoxFit.cover,height: boxHeight,width: double.infinity)):Container(),
                                    Positioned(child: Center(
                                      child: Image.asset('assets/images/cameraIcon.PNG', height: iconHeight,
                                        fit: BoxFit.cover,color: AppColor.colorPrimary, ),
                                    )
                                    ),
//                                  _image != null ? Image.file(_image):Text(''),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        labelDescription('Upload Your Bluebook Front Picture'),
                        subDescription('Eg. Vechicle Number Page'),
                      ],
                    ),flex: 1,),
                    SizedBox(width: 30,),
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start ,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right:10.0),
                          child: Material(
                            color:Colors.transparent,
                            child: InkWell(
                              splashColor: AppColor.colorPrimary,
                              onTap:(){
                                getImage('blueBookBackPhoto');
                              },
                              child: Container(height: boxHeight,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColor.colorPrimary,
                                    width: 2,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColor.colorPrimary.withOpacity(0.02),
                                      spreadRadius: 5,
                                      blurRadius: 5,
                                      offset: Offset(0, 0), // changes position of shadow
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(12),
                                ),
//                              child: Icon(Icons.camera_enhance,color: Colors.green,),
                                child: Stack(
                                  children: <Widget>[
                                    blueBookBackPhoto != null ? ClipRRect(borderRadius: BorderRadius.circular(11),
                                        child: Image.file(blueBookBackPhoto,fit: BoxFit.cover,height: boxHeight,width: double.infinity)):Container(),
                                    Positioned(child: Center(
                                      child: Image.asset('assets/images/cameraIcon.PNG', height: iconHeight,
                                        fit: BoxFit.cover,color: AppColor.colorPrimary, ),
                                    )
                                    ),
//                                  _image != null ? Image.file(_image):Text(''),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        labelDescription('Upload Your Bluebook Back Picture'),
                        subDescription('Eg. Vechicle Expiry Page'),
                      ],
                    ),flex: 1,)
                  ],
                ),)),
                SizedBox(height: 30,),
                FadeAnimation(
                  0.3, FadeAnimation(
                  0.4, CleanButton(text:'Next',onPressed: () {
                    if(licensePhotoId == null || licensePhotoId =='') {
                      ToastManager().fromValidationError(context,'Please, upload a license photo');
                    }else if(citizenshipFrontPhotoId == null || citizenshipFrontPhotoId =='') {
                      ToastManager().fromValidationError(context,'Please, upload a citizenship front photo');
                    }else if(citizenshipBackPhotoId == null || citizenshipBackPhotoId =='') {
                      ToastManager().fromValidationError(context,'Please, upload a citizenship back photo');
                    }
                    else if(blueBookFrontPhotoId == null || blueBookFrontPhotoId =='') {
                      ToastManager().fromValidationError(context,'Please, upload a bluebook front photo');
                    }else if(blueBookBackPhotoId == null || blueBookBackPhotoId == '') {
                      ToastManager().fromValidationError(context,'Please, upload a bluebook back photo');
                    } else {
                      Navigator.push(
                          context, MaterialPageRoute(
                          builder: (context) => TermsOfService()));
                    }
                },),
                ),
                ),
                FadeAnimation(0.3, HelpLineCall() )

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
  labelDescription(String txt) {
    return Padding(
      padding: const EdgeInsets.only(top: 6.0),
      child: Text(txt,style: TextStyle(fontSize: 12,color: Colors.black.withOpacity(0.8)),)
    );
  }
  subDescription(String txt) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0,bottom: 20.0),
      child: Text(txt,style: TextStyle(fontSize: 10,color: Colors.black.withOpacity(0.8),
      fontWeight: FontWeight.w400),),
    );
  }
}
