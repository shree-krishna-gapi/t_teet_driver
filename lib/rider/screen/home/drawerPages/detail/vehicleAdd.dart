import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:t_teet_rider/utils/Colors.dart';
import 'package:t_teet_rider/utils/StorageManager.dart';
import 'package:t_teet_rider/utils/Styles.dart';
import 'package:t_teet_rider/utils/Utils.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:t_teet_rider/utils/staticWidget.dart';
import 'package:t_teet_rider/utils/staticWidget.dart';
import 'package:t_teet_rider/utils/toastManager.dart';
class VehicleAdd extends StatefulWidget {
  @override
  _VehicleAddState createState() => _VehicleAddState();
}

class _VehicleAddState extends State<VehicleAdd> {
  Firestore firestore;
  FirebaseStorage firebaseStorage;
  File vehiclePhoto;
  final picker = ImagePicker();
  final TextEditingController vehicleName = TextEditingController();
  final TextEditingController vehicleModel = TextEditingController();
  final TextEditingController vehicleDescription = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    initialize();
    super.initState();
  }
  initialize() async {
    getFirebaseStorage().then((value) {
      print('value $value');
      firebaseStorage = value;
    });
  }
  String imageDownloadPath;
  Future getImage() async {
    bool connection = await networkStatus();
    String phone = await StorageManager().getPhone();
    if(connection) {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      print(pickedFile.path);
      print('-----------------------');
      if (pickedFile != null) {
        showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Wait(txt:'please wait...'),
              );
            });
        setState(() {
          vehiclePhoto = File(pickedFile.path);
        });
        final StorageReference ref = firebaseStorage.ref().child('rider').child(phone).child('vehiclePhoto');



        final StorageUploadTask uploadTask = ref.putFile(
          vehiclePhoto,
        );
        uploadTask.onComplete.then((value) {
          value.ref.getDownloadURL().then((value) {
            print('upload success-> ${value}');
            imageDownloadPath = value;
            Navigator.of(context).pop();
            }
          );
        });

      }
    }else {
      ToastManager().fromValidationError(
          context, 'Please check your network connection');
    }
  }
  double paddingHeight = 20.0;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;
    var height = screenSize.height;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        automaticallyImplyLeading: false,
        centerTitle: false,
        elevation: 0.0,
        title: GestureDetector(
          onTap:(){Navigator.pop(context);},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: [
                      Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Text("Add Vehicles",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),


                ]
            ),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            SizedBox(height: paddingHeight,),
            Row(
              children: [
                Expanded(child: Container(),flex: 1,),
                Expanded(child: Material(
                  color:Colors.transparent,
                  child: InkWell(
                    splashColor: AppColor.colorPrimary,
                    onTap:(){
                      getImage();
                    },
                    child: Container(height: 120,
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColor.blackBorder,
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
                          vehiclePhoto != null ? ClipRRect(borderRadius: BorderRadius.circular(11),
                              child: Center(child: Image.file(vehiclePhoto,fit: BoxFit.cover,height: 90,width: double.infinity,))):Container(),
                          Positioned(child: Center(
                            child: Center(
                              child: Image.asset('assets/images/cameraIcon.PNG', height: 28,
                                fit: BoxFit.cover,color: AppColor.blackBorder, ),
                            ),
                          ),
                          ),
//                                  _image != null ? Image.file(_image):Text(''),
                        ],
                      ),
                    ),
                  ),
                ),flex: 3,),
                Expanded(child: Container(),flex: 1,),
              ],
            ),
            SizedBox(height: paddingHeight,),
            Center(
              child: Container(
                width: width * 0.87,
                height: height * 0.07,
                child: TextFormField(
                  controller: vehicleName,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[200])),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.black)),
                    filled: true,
                    fillColor: Colors.grey[100],
                    contentPadding: EdgeInsets.only(top: 5,left: 12),
                    hintText: "Vehicle Name",
                  ),
                ),
              ),
            ),
            SizedBox(height: paddingHeight,),


            Center(
              child: Container(
                width: width * 0.87,
                height: height * 0.07,
                child: TextFormField(
                  controller: vehicleModel,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[200])),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.black)),
                    filled: true,
                    fillColor: Colors.grey[100],
                    contentPadding: EdgeInsets.only(top: 5,left: 12),
                    hintText: "Vehicle Model",
                  ),
                ),
              ),
            ),
            SizedBox(height: paddingHeight,),
            Center(
              child: Container(
                width: width * 0.87,
                height: height * 0.07,
                child: TextFormField(
                  controller: vehicleDescription,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[200])),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.black)),
                    filled: true,
                    fillColor: Colors.grey[100],
                    contentPadding: EdgeInsets.only(top: 30,left: 12),
                    hintText: "Vehicle Description",
                  ),
                  maxLines: 4,
                ),
              ),
            ),

            SizedBox(height: 50,),
            ClipRRect(
              borderRadius: BorderRadius.circular(90),
              child: Container(
                width: double.infinity,
                height: 46,
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 1.2,
                      color: AppColor.blackBorder),
                  borderRadius: BorderRadius.circular(90),
                    // color: AppColor.blackBorder
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.orange,
                    child: Center(child: Text('Submit',style: TextStyle(
                        fontWeight: FontWeight.w600,fontSize: 15
                    ),)),
                    onTap: ()async {

                      String phone = await StorageManager().getPhone();
                      print('your phone number $phone');
                      if(imageDownloadPath == '' || imageDownloadPath == null) {
                        ToastManager().fromValidation(
                            context, 'Insert your vehicle image');
                      } else if(vehicleName.text == '' || vehicleName.text == null) {
                        ToastManager().fromValidation(
                            context, 'Insert your vehicle name');
                      } else if(vehicleModel.text == '' || vehicleModel.text == null) {
                        ToastManager().fromValidation(
                            context, 'Upload your vehicle model year');
                      }else if(vehicleDescription.text == '' || vehicleDescription.text == null) {
                        ToastManager().fromValidation(
                            context, 'Upload your vehicle Description');
                      }
                      else {
                        bool connection = await networkStatus();
                        if(connection) {
                          showDialog<void>(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Wait(txt:'please wait...'),
                                );
                              });
                          Map<String, dynamic> demoData = {
                            "vehicle_image": imageDownloadPath,
                            "vehicle_name": vehicleName.text,
                            "vehicle_model": vehicleModel.text,
                            "vehicle_description": vehicleDescription.text,
                            };
                          Firestore.instance.collection("vehicles").document(phone)
                              .collection('test').document().setData(demoData
                          )
                              .catchError((e) {
                            print(e);
                          }).whenComplete((){
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          });
                        }
                        else {
                          ToastManager().fromValidationError(
                              context, 'Please check your network connection');
                        }
                      }},
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
  final hintTextStyle = TextStyles();
}
