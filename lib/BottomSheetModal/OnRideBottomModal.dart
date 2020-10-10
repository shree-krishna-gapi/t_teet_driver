//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
//import 'package:t_teet_rider/utils/Colors.dart';
//import 'package:t_teet_rider/utils/Constants.dart';
//
//class OnRideBottomModal extends StatefulWidget {
//  @override
//  _BottomSheetModal18state createState() => _BottomSheetModal18state();
//}
//
//class _BottomSheetModal18state extends State<OnRideBottomModal> {
//  bool _isChecked = false;
//
//  List<String> _texts = [
//    "Customer is not ready to go",
//    "I waited for too long",
//    "I accepted wrong request"
//  ];
//
//  @override
//  Widget build(BuildContext context) {
//    var screenSize = MediaQuery.of(context).size;
//    var height = MediaQuery.of(context).size.height;
//    var width = MediaQuery.of(context).size.width;
//
//    return Stack(
//      children: <Widget>[
//        Positioned(
//            left: 0,
//            right: 0,
//            bottom: 0,
//            child: Container(
//              height: height * 0.35,
//              width: width,
//              decoration: BoxDecoration(
//                  color: Colors.grey[200],
//                  borderRadius: BorderRadius.only(
//                      topLeft: Radius.circular(24.0),
//                      topRight: Radius.circular(24.0))),
//              child: Column(
//                children: <Widget>[
//                  SizedBox(
//                    height: height * 0.02,
//                  ),
//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceAround,
//                    children: <Widget>[
//                      Container(
//                          child: Container(
//                            width: 80,
//                            height: 80,
//                            decoration: new BoxDecoration(
//                                color: Colors.grey,
//                                shape: BoxShape.circle,
//                                image: DecorationImage(
//                                    alignment: Alignment.center,
//                                    image: NetworkImage(
//                                        Constants.PLACEHOLDER),
//                                    fit: BoxFit.fill)),
//                          )),
//                      Column(
//
//                        children: <Widget>[
//                          Text(
//                            "User's Name",
//                            style: TextStyle(
//                                color: Colors.black,
//                                fontWeight: FontWeight.w500),
//                          ),
//                          Row(
//                            children: <Widget>[
//                              Icon(
//                                Icons.star,
//                                color: Colors.yellow,
//                              ),
//                              Icon(
//                                Icons.star,
//                                color: Colors.yellow,
//                              ),
//                              Icon(
//                                Icons.star,
//                                color: Colors.yellow,
//                              )
//                              //as the rating
//                            ],
//                          )
//                        ],
//                      ),
//                      Container(
//                        width: 80,
//                        height: height/25,
//                        decoration: new BoxDecoration(
//                          borderRadius: BorderRadius.circular(24.0),
//                          color: AppColor.colorPrimary,
//                          shape: BoxShape.rectangle,
//                        ),
//                      )
//                    ],
//                  ),
//                  SizedBox(
//                    height: height * 0.02,
//                  ),
//
//                  Row(
//                    children: <Widget>[
//                      SizedBox(
//                        width: width * 0.08,
//                      ),
//                      Icon(
//                        Icons.radio_button_unchecked,
//                        color: AppColor.colorPrimary,
//                      ),
//                      Text(
//                        "  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . ",
//                        style: TextStyle(
//                            color: AppColor.colorPrimary, fontSize: 18),
//                      ),
//                      Icon(
//                        Icons.location_on,
//                        color: AppColor.colorPrimary,
//                      )
//                    ],
//                  ),
//                  SizedBox(
//                    height: height * 0.02,
//                  ),
//
//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.end,
//                    children: <Widget>[
//                      Column(
//                        crossAxisAlignment: CrossAxisAlignment.end,
//                        children: <Widget>[
//                          Text(
//                            "Dropoff Location",
//                            style: TextStyle(
//                                color: Colors.black,
//                                fontSize: 11,
//                                fontWeight: FontWeight.w500),
//                          ),
//                          Text(
//                            "Bansbari, Chakrapath",
//                            style: TextStyle(color: Colors.black, fontSize: 18),
//                          )
//                        ],
//                      ),
//                      SizedBox(
//                        width: width * 0.08,
//                      )
//                    ],
//                  ),
//                  SizedBox(
//                    height: height * 0.02,
//                  ),
//
//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceAround,
//                    children: <Widget>[
//                      Container(
//                        height: height * 0.08,
//                        width: width * 0.7,
//                        child: RaisedButton(
//                            elevation: 0.0,
//                            color: AppColor.colorPrimary,
//                            shape: RoundedRectangleBorder(
//                              borderRadius: BorderRadius.circular(height* 0.1),
//                            ),
//                            onPressed: () {
//                                Navigator.pushNamed(context, '/invoice');
////
//
//
//                            },
//                            child: Text("Drop",
//                                style: new TextStyle(color: Colors.white, fontSize: 30.0))),
//                      )
//                    ],
//                  )
//                ],
//              ),
//            ))
//      ],
//    );
//  }
//}
