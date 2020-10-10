import 'dart:math';

// import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:t_teet_rider/rider/screen/home/drawer.dart';
import 'package:t_teet_rider/rider/screen/home/drawerPages/detail/documentInfo.dart';
import 'package:t_teet_rider/rider/screen/home/drawerPages/detail/licenseAndBluebook.dart';
import 'package:t_teet_rider/screens/HomeScreen.dart';
import 'package:t_teet_rider/utils/Colors.dart';
import 'package:t_teet_rider/utils/Constants.dart';
import 'package:t_teet_rider/utils/StorageManager.dart';
import 'package:t_teet_rider/utils/Utils.dart';
import 'package:t_teet_rider/utils/staticWidget.dart';
import 'package:t_teet_rider/utils/toastManager.dart';
import 'detail/EditProfile.dart';
import 'detail/profileInfo.dart';
import 'detail/vehicleInfo.dart';
import 'dart:io';
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
//  RiderProfile obj = new RiderProfile("12345","9843910399","Ram","male", "abc@gmail.com", "hello") ;

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  String name = "", profile = Constants.PLACEHOLDER, phone = "";

  String city,
      email,
      gender,
      vehicleModel,
      vehicleName,
      vehicleNumber,
      vehicleYear,
      licenseNumber,
      licensePhoto,
      licenseExpiryDate,
      blueNookFrontPhoto,
      blueBookBackPhoto;
  bool userVechiclePublicOrPrivate;

  @override
  void initState() {
    initialize();
    getProfileDataFrom();
    super.initState();
  }

  Firestore firestore = Firestore.instance;

  initialize() async {
    getFirestoreInstance().then((value) {
      firestore = value;
      getProfileData();
    });
  }

  getProfileData() async {
    var id = await StorageManager().getPhone();
    firestore
        .collection('riders')
        .document('$id')
        .get()
        .then((DocumentSnapshot data) {
      name = data['name'];
      city = data['city'];
      email = data['email'];
      gender = data['gender'];
      phone = data['phone'];
      profile = data['profile'];
      userVechiclePublicOrPrivate = data['publicOrPrivate'];

      vehicleModel = data['vehicleModel'];
      vehicleName = data['vehicleName'];
      vehicleNumber = data['vehicleNumber'];
      vehicleYear = data['vehicleYear'];

      licenseNumber = data['licenseNumber'];
      licensePhoto = data['licensePhoto'];
      licenseExpiryDate = data['licenseExpiryDate'];

      blueNookFrontPhoto = data['blueBookFrontPhoto'];
      blueBookBackPhoto = data['blueBookBackPhoto'];
      StorageManager().setUserName(name);
      StorageManager().setProfileImage(profile);
      StorageManager().setPhoneNumber(phone);
      StorageManager().setGender(gender);
    });
  }

  void getProfileDataFrom() {
    StorageManager().getUserName().then((value) {
      setState(() {
        name = value;
      });
    });
    StorageManager().getProfileImage().then((value) {
      setState(() {
        profile = value;
      });
    });

    StorageManager().getPhone().then((value) {
      setState(() {
        phone = value;
      });
    });
  }
  final picker = ImagePicker();
  File changedProfile;
  String newProfile;
  changeProfile() async{
    bool connection = await networkStatus();
   if(connection) {
     showDialog<void>(
         context: context,
         barrierDismissible: false, // user must tap button!
         builder: (BuildContext context) {
           return AlertDialog(
             content: Wait(txt:'please wait...'),
           );
         });
     final pickedFile = await picker.getImage(source: ImageSource.gallery);
     setState(() {
       changedProfile = File(pickedFile.path);
       newProfile = changedProfile.toString();
     });
     var manager = StorageManager();
     var phone = await manager.getPhone();
     print('this is $phone');
     if(changedProfile !=null) {
       await firestore.collection("riders").document('$phone').updateData({
         "profile": changedProfile,
       }).then((value){
         print('value');
         Navigator.pop(context);
         Navigator.pushReplacement(context,
             MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
       });
     } else {
       Navigator.pop(context);
     }
   }
   else {
     ToastManager().fromValidationError(context,'Please, check your internet connection');
   }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
            onTap: () {
//              _drawerKey.currentState.openDrawer();
              Navigator.pop(context);
            },
            child: Icon(
              Icons.close,
              color: Colors.black,
            )),
        title: Text('Profile', style: TextStyle(color: Colors.black)),
        actions: <Widget>[
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditPage(
                    name:name,gender:gender,email:email,phone:phone
                )),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Row(
                children: <Widget>[
                  Text(
                    'Edit',
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Icon(
                    Icons.edit,
                    size: 17,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: DrawerPage(tag: 'Profile'),
      ),
      body: Container(
        color: Colors.black.withOpacity(0.02),
        child: ListView(
          children: <Widget>[
            Container(
                height: 310,
                color: Colors.white,
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: 160,
                      margin: EdgeInsets.only(right: 120, top: 20),
                      child: Center(
                          child: Image.asset(
                            'assets/images/bike.png',
                          )),
                    ),
                    Positioned(
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.only(bottom: 4, left: 40),
                              child: Text(
                                "$name",
                                style: TextStyle(
                                  //${obj.phone}
                                  color: AppColor.colorPrimary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 40),
                              child: Text(
                                "$phone",
                                style: TextStyle(
                                  //${obj.id}
                                    color: Colors.black,
                                    fontSize: 14),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 15),
                              height: 1,
                              color: Colors.black26,
                            ),
                            SizedBox(
                              height: 14,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text(
                                      '0',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4.0),
                                      child: Text('Total Ride'),
                                    )
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.star,
                                          size: 17,
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          'New',
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4.0),
                                      child: Text('Rating'),
                                    )
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      '14',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4.0),
                                      child: Text('Days'),
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 14,
                            ),
                          ],
                        ),
                      ),
                      right: 0,
                      left: 0,
                      bottom: 0,
                    ),
                    Positioned(
                      child: Center(
                        child: Stack(
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: new BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(90),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    spreadRadius: 3,
                                    blurRadius: 5,
                                    offset:
                                    Offset(0, 1), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Container(
                                decoration: new BoxDecoration(
                                  color: Colors.white.withOpacity(0.9),
//                          shape: BoxShape.circle,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(90),
                                  ),
                                ),
                                padding: EdgeInsets.all(3.0),
                                // child: ClipOval(
                                //   child: newProfile == null || newProfile == '' ? CachedNetworkImage(
                                //     imageUrl: profile,
                                //     fit: BoxFit.fill,
                                //   ): Image.file(changedProfile, fit: BoxFit.fill,),
                                // ),
                                child: ClipOval(
                                  child: newProfile == null || newProfile == '' ? Image.asset(
                                    '$profile',
                                    fit: BoxFit.fill,
                                  ): Image.file(changedProfile, fit: BoxFit.fill,),
                                ),
                              )
                            ),
                            Positioned(child:

                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black12
                              ),

                              child: InkWell(
                                onTap: changeProfile,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Image.asset(
                                      'assets/images/updateProfile.PNG', width: 24,
                                      color: Colors.white.withOpacity(0.95),
                                    ),
                                    SizedBox(height: 10,),
                                  ],
                                ),
                              ),
                            ),

                              left: 0, right: 0,bottom: 0,top: 0,),
                          ],
                        ),
                      ),
                      right: 0,
                      left: 70,
                      bottom: 50,
                      top: 0,
                    ),
                  ],
                )),
            Container(
              // height: 300,
              child: Builder(
                builder: (BuildContext context) {
                  final double height = MediaQuery.of(context).size.height*0.40;
                  return Container(
                    margin: EdgeInsets.fromLTRB(7, 8, 7, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        carouselSlider = CarouselSlider(
                          options: CarouselOptions(
                            height: 120,
                            initialPage: 0,
                            viewportFraction: 1.0,
                            enlargeCenterPage: false,
                            autoPlay: true,
                            reverse: false,
                            enableInfiniteScroll: true,
                            autoPlayInterval: Duration(seconds: 5),
                            autoPlayAnimationDuration: Duration(milliseconds: 2000),
                            pauseAutoPlayOnTouch:true,
                            scrollDirection: Axis.horizontal,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        _currentIndex = index;
                                      });
                                    },
                          ),

                          items: list.map((item) {
                            return Container(
                              width: double.infinity,
                              child: Card(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 5, top: 18),
                                        child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Icon(Icons.camera_enhance,size: 18,)),
                                      ),
                                    ),
                                    Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 18, bottom: 10),
                                              child: Text(
                                                'Upload your profile photo',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15),
                                              ),
                                            ),
                                            Text(
                                                'Your photo helps drivers feel safer and identify you.',style: TextStyle(
                                              fontSize: 13
                                            ),),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 18.0, bottom: 10.0),
                                              child: Row(
                                                children: <Widget>[
                                                  InkWell(
                                                    child: Text(
                                                      'Upload',
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.deepPurple),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  InkWell(
                                                    child: Text(
                                                      'Dismiss',
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.black45),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                            );
                          },
                          ).toList(),

                        ),

                      ],
                    ),
                  );
                },),
            ),

            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ...List.generate(
                  list.length,
                      (index) =>
                  _currentIndex == index ? DotsActive() : DotsInactive(),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 15, top: 15, bottom: 15),
              child: Text(
                'Account Settings',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
              ),
            ),
            Container(
              color: Colors.white,
              child: ListTile(
                leading: Icon(
                  Icons.account_circle,
                  color: Colors.black,
                ),
                title: Text('Your info', style: TextStyle(color: Colors.black)),
                subtitle: Text(
                  'Account, Personal',
                  style: TextStyle(color: Colors.black),
                ),
                trailing: Icon(
                  Icons.info,
                  color: AppColor.offLineColor,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileInfo(
                              city: city,
                              email: email,
                              name: name,
                              gender: gender,
                              phone: phone)));
                },
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Container(
              color: Colors.white,
              child: ListTile(
                leading: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1.5),
                      borderRadius: BorderRadius.all(
                        Radius.circular(90),
                      )),
                  child: Image.asset(
                    'assets/images/vechile.png',
                    color: Colors.black,
                    height: 11,
                  ),
                ),
                title:
                Text('Vehicle Info', style: TextStyle(color: Colors.black)),
                subtitle: Text(
                  '',
                  style: TextStyle(color: Colors.black),
                ),
                trailing: Icon(
                  Icons.info,
                  color: AppColor.offLineColor,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VehicleInfo(
                              vechicleYear: vehicleYear,
                              vehicleModel: vehicleModel)));
                },
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Container(
              color: Colors.white,
              child: ListTile(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LicenseAndBluebook(
                              licensePhoto: licensePhoto,
                              bluebookFrontPhoto: blueNookFrontPhoto,
                              bluebookBackPhoto: blueBookBackPhoto)));
                },
                leading: Image.asset(
                  'assets/images/lic.png',
                  color: Colors.black,
                  height: 19,
                ),
                title: Text(
                  'Licenses and Bluebook Information',
                  style: TextStyle(color: Colors.black),
                ),
                trailing: Icon(
                  Icons.info,
                  color: AppColor.offLineColor,
                ),
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Container(
              color: Colors.white,
              child: ListTile(
                leading: Image.asset(
                  'assets/images/doccc.png',
                  color: Colors.black,
                  height: 19,
                ),
                title: Text('Your documents',
                    style: TextStyle(color: Colors.black)),
//                subtitle: Text('Your documents',style: TextStyle(color: Colors.black),),
                trailing: Icon(
                  Icons.info,
                  color: AppColor.offLineColor,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DocumentInfo(
                              licensePhoto: licensePhoto,
                              bluebookFrontPhoto: blueNookFrontPhoto,
                              bluebookBackPhoto: blueBookBackPhoto)));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<int> list = [1, 2, 3];
  int _currentIndex = 0;
  CarouselSlider carouselSlider;
}

class SliderCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
//                      width: 60,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 10, top: 15),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Icon(Icons.camera_enhance)),
            ),
          ),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 18, bottom: 10),
                    child: Text(
                      'Upload your profile photo',
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                  ),
                  Text('Your photo helps drivers feel safer and identify you.'),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0, bottom: 20.0),
                    child: Row(
                      children: <Widget>[
                        InkWell(
                          child: Text(
                            'Upload',
                            style:
                            TextStyle(fontSize: 16, color: Colors.deepPurple),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          child: Text(
                            'Dismiss',
                            style: TextStyle(fontSize: 16, color: Colors.black45),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}

class CustomHalfCircleClipper extends CustomClipper<Path> {
  @override

  Path getClip(Size size) {

    final Path path = new Path();
    path.lineTo(-180.0, size.height / 2);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width,-90);
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

