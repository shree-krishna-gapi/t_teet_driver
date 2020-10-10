//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:t_teet_rider/utils/Colors.dart';
//import 'package:t_teet_rider/utils/Constants.dart';
//
//class BottomModalHome extends StatefulWidget {
//  @override
//  _BottomModalHomestate createState() => _BottomModalHomestate();
//}
//
//class _BottomModalHomestate extends State<BottomModalHome> {
//
//  GlobalKey<ScaffoldState> _key = GlobalKey();
//  bool _isVisible = true;
//  bool _isChecked = false;
//  int _currentIndex = 1;
//
//  void showRequest() {
//    setState(() {
//      _isVisible = true;
//    });
//  }
//
//  List<GroupModel> _group = [
//    GroupModel(
//      text: "Customer is not ready to go",
//      index: 1,
//    ),
//    GroupModel(
//      text: "I waited for  too long",
//      index: 2,
//    ),
//    GroupModel(
//      text: "I accepted wrong request",
//      index: 3,
//    ),
//  ];
//  @override
//  Widget build(BuildContext context) {
//    var screenSize = MediaQuery.of(context).size;
//    var height = MediaQuery.of(context).size.height;
//    var width = MediaQuery.of(context).size.width;
//
//    showAlertDialog(BuildContext context) {
//      // set up the AlertDialog
//      AlertDialog alert = AlertDialog(
//        shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(width / 24),
//        ),
//        backgroundColor: Colors.white,
//        title: Column(
//          children: <Widget>[Text("Do you really want to cancel?", style: TextStyle(fontSize:16,),),
//            Text("Let us know to help us improve.", style: TextStyle(fontSize:12,),)],
//        ),
//        content: StatefulBuilder(
//          builder: (BuildContext context, StateSetter setState){
//            return Container(
//              width: width / 2,
//              height: height/ 2.5,
//              child: Column(
//                children: <Widget>[
//                  Expanded(
//                    child: ListView(
//                      padding: EdgeInsets.all(8.0),
//                      children: _group
//                          .map((item) => RadioListTile(
//                        activeColor: Colors.black,
//                        groupValue: _currentIndex,
//                        title: Text("${item.text}"),
//                        value: item.index,
//                        onChanged: (val) {
//                          setState(() {
//                            _currentIndex = val;
//                          });
//                        },
//                      ))
//                          .toList(),
//
//                    ),
//                  ),
//                  Column(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      children:<Widget>[
//
//                        Container(
//                          height: height/20,
//                          width: width*0.5,
//                          child: RaisedButton(child: Text("Cancel my ride", style: TextStyle(color: Colors.white),),
//                            color: AppColor.colorPrimary,
//                            onPressed: (){Navigator.pop(context); },
//                            shape:
//                            RoundedRectangleBorder(
//                              borderRadius:
//                              BorderRadius.circular(
//                                  height * 0.1),
//                            ),),
//                        ),
//                        SizedBox(height: height/50),
//                        Container(
//                          height: height/20,
//                          width: width*0.5,
//                          child: RaisedButton(child: Text("Decline", style: TextStyle(color: AppColor.colorPrimary,),),
//                            onPressed: (){Navigator.pop(context); },
//                            color:
//                            Colors.white,
//
//                            shape:
//                            RoundedRectangleBorder(
//                                borderRadius:
//                                BorderRadius.circular(
//                                    height * 0.1),
//                                side:
//                                BorderSide(color: AppColor.colorPrimary, width: 3.0)
//                            ),),
//                        )
//                      ] ),
//                ],
//
//              ),
//            );
//          }
//
//        ),
//      );
//
//      showDialog(
//        context: context,
//        builder: (BuildContext context) {
//          return alert;
//        },
//      );
//    }
//
//    return Stack(
//      children: <Widget>[
//        Positioned(
//            left: 0,
//            right: 0,
//            bottom: 0,
//            child: Visibility(
//              visible: _isVisible,
//              child: Container(
//                height: height/2.5,
//                width: width,
//                decoration: BoxDecoration(
//                    color: Colors.grey[200],
//                    borderRadius: BorderRadius.only(
//                        topLeft: Radius.circular(24.0),
//                        topRight: Radius.circular(24.0))),
//                child: Column(
//                  children: <Widget>[
//                    SizedBox(
//                      height: height * 0.02,
//                    ),
//                    Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceAround,
//                      children: <Widget>[
//                        Container(
//                            child: Container(
//                          width: 80,
//                          height: 80,
//                          decoration: new BoxDecoration(
//                              color: Colors.grey,
//                              shape: BoxShape.circle,
//                              image: DecorationImage(
//                                  alignment: Alignment.center,
//                                  image: NetworkImage(
//                                      Constants.PLACEHOLDER),
//                                  fit: BoxFit.fill)),
//                        )),
//                        Column(
//                          children: <Widget>[
//                            Text(
//                              "User's Name",
//                              style: TextStyle(
//                                  color: Colors.black,
//                                  fontWeight: FontWeight.w500),
//                            ),
//                            Row(
//                              children: <Widget>[
//                                Icon(
//                                  Icons.star,
//                                  color: Colors.yellow,
//                                ),
//                                Icon(
//                                  Icons.star,
//                                  color: Colors.yellow,
//                                ),
//                                Icon(
//                                  Icons.star,
//                                  color: Colors.yellow,
//                                )
//                                //as the rating
//                              ],
//                            )
//                          ],
//                        ),
//                        Container(
//                          width: 80,
//                          height: 80,
//                          decoration: new BoxDecoration(
//                            color: AppColor.colorPrimary,
//                            shape: BoxShape.circle,
//                          ),
//                        )
//                      ],
//                    ),
//                    SizedBox(
//                      height: height * 0.02,
//                    ),
//                    Row(
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      mainAxisAlignment: MainAxisAlignment.spaceAround,
//                      children: <Widget>[
//                        Icon(
//                          Icons.radio_button_unchecked,
//                          color: AppColor.colorPrimary,
//                        ),
//                        Column(
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: <Widget>[
//                            Text("Pickup Location"),
//                            Text("Bansbari, Chakrapath")
//                          ],
//                        ),
//                        Column(
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: <Widget>[
//                            Text("Travel Distance"),
//                            Text("8.6Km")
//                          ],
//                        ),
//                      ],
//                    ),
//                    SizedBox(
//                      height: height * 0.02,
//                    ),
//                    Row(
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      mainAxisAlignment: MainAxisAlignment.spaceAround,
//                      children: <Widget>[
//                        Icon(
//                          Icons.location_on,
//                          color: AppColor.colorPrimary,
//                        ),
//                        Column(
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: <Widget>[
//                            Text("Dropoff Location"),
//                            Text("Bansbari, Chakrapath")
//                          ],
//                        ),
//                        Column(
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: <Widget>[
//                            Text("Rider Distance"),
//                            Text("1.6Km")
//                          ],
//                        ),
//                      ],
//                    ),
//                    SizedBox(
//                      height: height * 0.02,
//                    ),
//                    Padding(
//                      padding: EdgeInsets.symmetric(horizontal: 10.0),
//                      child: Container(
//                        height: 1.0,
//                        width: width * 0.95,
//                        color: Colors.grey,
//                      ),
//                    ),
//                    SizedBox(
//                      height: height * 0.02,
//                    ),
//                    Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceAround,
//                      children: <Widget>[
//                        Text(
//                          "Payment : Cash",
//                          style: TextStyle(
//                              color: Colors.black, fontWeight: FontWeight.w500),
//                        ),
//                        Text(
//                          "Nrs. 120.00",
//                          style: TextStyle(
//                              color: Colors.black, fontWeight: FontWeight.w500),
//                        )
//                      ],
//                    ),
//                    SizedBox(
//                      height: height * 0.02,
//                    ),
//                    Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceAround,
//                      children: <Widget>[
//                        Container(
//                          height: height / 15.5,
//                          width: width / 2.5,
//                          child: RaisedButton(
//                              elevation: 0.0,
//                              color: Colors.red,
//                              shape: RoundedRectangleBorder(
//                                borderRadius: BorderRadius.circular(height * 0.1),
//                              ),
//                              onPressed: () {
//                                setState(() {
//                                  _isVisible =false;
//                                });
//                              },
//                              child: Text("Reject",
//                                  style: new TextStyle(color: Colors.white))),
//                        ),
//                        Container(
//                          height: height / 15.5,
//                          width: width / 2.5,
//                          child: RaisedButton(
//                              elevation: 0.0,
//                              color: AppColor.colorPrimary,
//                              shape: RoundedRectangleBorder(
//                                borderRadius: BorderRadius.circular(height * 0.1),
//                              ),
//                              onPressed: () {
//                                showModalBottomSheet(
//                                    context: context,
//                                    builder: (builder) {
//                                      return Container(
//                                        width: width,
//                                        height: height / 2.5,
//                                        child: Column(
//                                          children: <Widget>[
//                                            SizedBox(
//                                              height: height * 0.02,
//                                            ),
//                                            Row(
//                                              mainAxisAlignment:
//                                                  MainAxisAlignment.start,
//                                              children: <Widget>[
//                                                SizedBox(width: width * 0.08),
//                                                Container(
//                                                    child: Container(
//                                                  width: 80,
//                                                  height: 80,
//                                                  decoration: new BoxDecoration(
//                                                      color: Colors.grey,
//                                                      shape: BoxShape.circle,
//                                                      image: DecorationImage(
//                                                          alignment:
//                                                              Alignment.center,
//                                                          image: NetworkImage(
//                                                              Constants.PLACEHOLDER),
//                                                          fit: BoxFit.fill)),
//                                                )),
//                                                SizedBox(width: width * 0.08),
//                                                Column(
//                                                  children: <Widget>[
//                                                    Text(
//                                                      "User's Name",
//                                                      style: TextStyle(
//                                                          color: Colors.black,
//                                                          fontWeight:
//                                                              FontWeight.w500),
//                                                    ),
//                                                    SizedBox(
//                                                      width: width / 5,
//                                                    )
//                                                  ],
//                                                ),
//                                              ],
//                                            ),
//                                            Row(
//                                              children: <Widget>[
//                                                SizedBox(
//                                                  width: width * 0.08,
//                                                ),
//                                                Icon(
//                                                  Icons.radio_button_unchecked,
//                                                  color: AppColor.colorPrimary,
//                                                ),
//                                                Text(
//                                                  "  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . ",
//                                                  style: TextStyle(
//                                                      color: AppColor.colorPrimary, fontSize: 18),
//                                                ),
//                                                Icon(
//                                                  Icons.location_on,
//                                                  color: AppColor.colorPrimary,
//                                                ),
//                                              ],
//                                            ),
//                                            SizedBox(
//                                              height: height * 0.02,
//                                            ),
//                                            Row(
//                                              mainAxisAlignment: MainAxisAlignment.start,
//                                              children: <Widget>[
//                                                SizedBox(width: width*0.08,),
//                                                Column(
//                                                  crossAxisAlignment: CrossAxisAlignment.start,
//                                                  children: <Widget>[
//                                                    Text(
//                                                      "Pickup Location",
//                                                      style: TextStyle(
//                                                          color: Colors.black,
//                                                          fontSize: 11,
//                                                          fontWeight: FontWeight.w500),
//                                                    ),
//                                                    Text(
//                                                      "Bansbari, Chakrapath",
//                                                      style: TextStyle(color: Colors.black, fontSize: 18),
//                                                    )
//                                                  ],
//                                                ),
//                                                SizedBox(
//                                                  width: width * 0.08,
//                                                )
//                                              ],
//                                            ),
//
//                                            SizedBox(
//                                              height: height * 0.02,
//                                            ),
//                                            SizedBox(
//                                              height: height * 0.02,
//                                            ),
//                                            SizedBox(
//                                              height: height * 0.02,
//                                            ),
//                                            Row(
//                                              mainAxisAlignment:
//                                                  MainAxisAlignment.spaceAround,
//                                              children: <Widget>[
//                                                Container(
//                                                  height: height / 15.5,
//                                                  width: width / 2.5,
//                                                  child: RaisedButton(
//                                                      elevation: 0.0,
//                                                      color: Colors.red,
//                                                      shape:
//                                                          RoundedRectangleBorder(
//                                                        borderRadius:
//                                                            BorderRadius.circular(
//                                                                height * 0.1),
//                                                      ),
//                                                      onPressed: () {
//                                                        showAlertDialog(context);
//                                                      },
//                                                      child: Text(
//                                                          "Cancel request",
//                                                          style: new TextStyle(
//                                                              color:
//                                                                  Colors.white))),
//                                                ),
//                                                Container(
//                                                  height: height / 15.5,
//                                                  width: width / 2.5,
//                                                  child: RaisedButton(
//                                                      elevation: 0.0,
//                                                      color:
//                                                          AppColor.colorPrimary,
//                                                      shape:
//                                                          RoundedRectangleBorder(
//                                                        borderRadius:
//                                                            BorderRadius.circular(
//                                                                height * 0.1),
//                                                      ),
//                                                      onPressed: () {
//                                                        showModalBottomSheet(
//                                                            context: context,
//                                                            builder: (builder) {
//                                                              return Container(
//                                                                width: width,
//                                                                height:
//                                                                    height / 2.5,
//                                                                child: Column(
//                                                                  children: <
//                                                                      Widget>[
//                                                                    SizedBox(
//                                                                      height:
//                                                                          height *
//                                                                              0.02,
//                                                                    ),
//                                                                    Row(
//                                                                      mainAxisAlignment:
//                                                                          MainAxisAlignment
//                                                                              .start,
//                                                                      children: <
//                                                                          Widget>[
//                                                                        SizedBox(width: width * 0.08),
//                                                                        Container(
//                                                                            child:
//                                                                                Container(
//                                                                          width:
//                                                                              80,
//                                                                          height:
//                                                                              80,
//                                                                          decoration: new BoxDecoration(
//                                                                              color: Colors
//                                                                                  .grey,
//                                                                              shape: BoxShape
//                                                                                  .circle,
//                                                                              image: DecorationImage(
//                                                                                  alignment: Alignment.center,
//                                                                                  image: NetworkImage(
//                                                                                      Constants.PLACEHOLDER),
//                                                                                  fit: BoxFit.fill))
//                                                                                  ,
//                                                                        )),
//                                                                        SizedBox(width: width * 0.08),
//                                                                        Column(
//                                                                          children: <
//                                                                              Widget>[
//                                                                            SizedBox(width: width * 0.08),
//                                                                            Text(
//                                                                              "User's Name",
//                                                                              style:
//                                                                                  TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
//                                                                            ),
//                                                                            SizedBox(
//                                                                              width:
//                                                                                  width / 5,
//                                                                            )
//                                                                          ],
//                                                                        ),
//                                                                      ],
//                                                                    ),
//                                                                    SizedBox(
//                                                                      height: height * 0.02,
//                                                                    ),
//                                                                    Row(
//                                                                      children: <Widget>[
//                                                                        SizedBox(
//                                                                          width: width * 0.08,
//                                                                        ),
//                                                                        Icon(
//                                                                          Icons.radio_button_unchecked,
//                                                                          color: AppColor.colorPrimary,
//                                                                        ),
//                                                                        Text(
//                                                                          "  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . ",
//                                                                          style: TextStyle(
//                                                                              color: AppColor.colorPrimary, fontSize: 18),
//                                                                        ),
//                                                                        Icon(
//                                                                          Icons.location_on,
//                                                                          color: AppColor.colorPrimary,
//                                                                        )
//                                                                      ],
//                                                                    ),
//                                                                    SizedBox(
//                                                                      height: height * 0.02,
//                                                                    ),
//                                                                    Row(
//                                                                      mainAxisAlignment: MainAxisAlignment.end,
//                                                                      children: <Widget>[
//                                                                        Column(
//                                                                          crossAxisAlignment: CrossAxisAlignment.end,
//                                                                          children: <Widget>[
//                                                                            Text(
//                                                                              "Dropoff Location",
//                                                                              style: TextStyle(
//                                                                                  color: Colors.black,
//                                                                                  fontSize: 11,
//                                                                                  fontWeight: FontWeight.w500),
//                                                                            ),
//                                                                            Text(
//                                                                              "Bansbari, Chakrapath",
//                                                                              style: TextStyle(color: Colors.black, fontSize: 18),
//                                                                            )
//                                                                          ],
//                                                                        ),
//                                                                        SizedBox(
//                                                                          width: width * 0.08,
//                                                                        )
//                                                                      ],
//                                                                    ),
//
//
//                                                                    SizedBox(
//                                                                      height:
//                                                                          height *
//                                                                              0.02,
//                                                                    ),
//                                                                    SizedBox(
//                                                                      height:
//                                                                          height *
//                                                                              0.02,
//                                                                    ),
//                                                                    SizedBox(
//                                                                      height:
//                                                                          height *
//                                                                              0.02,
//                                                                    ),
//                                                                    Row(
//                                                                      mainAxisAlignment:
//                                                                          MainAxisAlignment
//                                                                              .spaceAround,
//                                                                      children: <
//                                                                          Widget>[
//                                                                        Container(
//                                                                          height: height /
//                                                                              15.5,
//                                                                          width: width /
//                                                                              2.5,
//                                                                          child: RaisedButton(
//                                                                              elevation: 0.0,
//                                                                              color: Colors.red,
//                                                                              shape: RoundedRectangleBorder(
//                                                                                borderRadius: BorderRadius.circular(height * 0.1),
//                                                                              ),
//                                                                              onPressed: () {
//                                                                                showAlertDialog(context);
//                                                                              },
//                                                                              child: Text("Cancel request", style: new TextStyle(color: Colors.white))),
//                                                                        ),
//                                                                        Container(
//                                                                          height: height /
//                                                                              15.5,
//                                                                          width: width /
//                                                                              2.5,
//                                                                          child: RaisedButton(
//                                                                              elevation: 0.0,
//                                                                              color: AppColor.colorPrimary,
//                                                                              shape: RoundedRectangleBorder(
//                                                                                borderRadius: BorderRadius.circular(height * 0.1),
//                                                                              ),
//                                                                              onPressed: () {
//                                                                                Navigator.pushNamed(context, '/onride');
////
//                                                                              },
//                                                                              child: Text("Pick Up", style: new TextStyle(color: Colors.white))),
//                                                                        )
//                                                                      ],
//                                                                    )
//                                                                  ],
//                                                                ),
//                                                              );
//                                                            });
//                                                      },
//                                                      child: Text("Arrived",
//                                                          style: new TextStyle(
//                                                              color:
//                                                                  Colors.white))),
//                                                )
//                                              ],
//                                            )
//                                          ],
//                                        ),
//                                      );
//                                    });
//                              },
//                              child: Text("Accept",
//                                  style: new TextStyle(color: Colors.white))),
//                        )
//                      ],
//                    )
//                  ],
//                ),
//              ),
//            ))
//      ],
//    );
//  }
//}
//
//
//class GroupModel {
//  String text;
//  int index;
//  GroupModel({this.text, this.index});
//}
