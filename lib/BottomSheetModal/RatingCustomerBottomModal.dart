//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_rating_bar/flutter_rating_bar.dart';
//import 'package:t_teet_rider/utils/Colors.dart';
//import 'package:t_teet_rider/utils/Constants.dart';
//
//class RatingCustomerBottomModal extends StatefulWidget {
//  @override
//  _RatingCustomerBottomModalState createState() => _RatingCustomerBottomModalState();
//}
//
//class _RatingCustomerBottomModalState extends State<RatingCustomerBottomModal> {
//  var _rating;
//
//  @override
//  Widget build(BuildContext context) {
//    final screenHeight = MediaQuery.of(context).size.height;
//    final screenWidth = MediaQuery.of(context).size.width;
//    return Stack(
//      children: <Widget>[
//        Positioned(
//          left: 0,
//          right: 0,
//          bottom: 0,
//          child: Container(
//              height: screenHeight * 0.55,
//              width: screenWidth,
//              decoration: BoxDecoration(
//                  color: AppColor.colorPrimary,
//                  borderRadius: BorderRadius.only(
//                      topLeft: Radius.circular(24.0),
//                      topRight: Radius.circular(24.0))),
//              child: Column(
//                children: <Widget>[
//                  Container(
//                      decoration: BoxDecoration(
//                          color: AppColor.colorPrimary,
//                          borderRadius: BorderRadius.only(
//                              topLeft: Radius.circular(24.0),
//                              topRight: Radius.circular(24.0))),
//                      child: Column(
//                        children: <Widget>[
//                          SizedBox(
//                            height: screenHeight * 0.01,
//                          ),
//
//                          Center(
//                            child: Container(
//                                child: Container(
//                                  width: 80,
//                                  height: 80,
//                                  decoration: new BoxDecoration(
//                                      color: Colors.grey,
//                                      shape: BoxShape.circle,
//                                      image: DecorationImage(
//                                          alignment: Alignment.center,
//                                          image: NetworkImage(
//                                              Constants.PLACEHOLDER),
//                                          fit: BoxFit.fill)),
//                                )),
//                          ),
//                          SizedBox(
//                            height: screenHeight * 0.01,
//                          ),
//                          Text(
//                            "Rider's Name",
//                            style: TextStyle(color: Colors.white),
//                          ),
//                          SizedBox(
//                            height: screenHeight * 0.01,
//                          ),
//                          Row(
//                            mainAxisAlignment: MainAxisAlignment.center,
//                            children: <Widget>[
//                              Icon(
//                                Icons.star,
//                                color: Colors.yellow,
//                              ),
//                              Text(
//                                "4.6",
//                                style: TextStyle(color: Colors.white),
//                              ),
//                              Icon(
//                                Icons.bookmark,
//                                color: Colors.white,
//                              ),
//                              Text(
//                                "Silver Driver",
//                                style: TextStyle(color: Colors.white),
//                              )
//                            ],
//                          ),
//                          SizedBox(
//                            height: screenHeight * 0.01,
//                          ),
//                        ],
//                      )),
//                  Expanded(
//                    child: Container(
//                      width: screenWidth,
//                      decoration: BoxDecoration(
//                          color: Colors.white,
//                          borderRadius: BorderRadius.only(
//                              topLeft: Radius.circular(24.0),
//                              topRight: Radius.circular(24.0))),
//                      child: Column(
//                        children: <Widget>[
//                          SizedBox(
//                            height: screenHeight * 0.02,
//                          ),
//                          Text(
//                            "Ratings your riding experience with Asmita Nepal",
//                            style: TextStyle(color: Colors.grey),
//                          ),
//                          RatingBar(
//                            direction: Axis.horizontal,
//                            allowHalfRating: true,
//                            itemCount: 5,
//                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
//                            itemBuilder: (context, _) => Icon(
//                              Icons.star,
//                              color: Colors.amber,
//                            ),
//                            onRatingUpdate: (rating) {
//                              setState(() {
//                                _rating = rating;
//                              });
//                              print(rating);
//                            },
//                          ),
//                          SizedBox(
//                            height: screenHeight * 0.02,
//                          ),
//                          Padding(
//                            padding: EdgeInsets.symmetric(horizontal: 10.0),
//                            child: Container(
//                              height: 2.0,
//                              width: screenWidth * 0.95,
//                              color: Colors.grey,
//                            ),
//                          ),
//                          SizedBox(
//                            height: screenHeight * 0.02,
//                          ),
//                          Center(
//                            child: Container(
//                              child: SizedBox(
//                                height: screenHeight * 0.08,
//                                width: screenWidth * 0.7,
//                                child: RaisedButton(
//                                  elevation: 0.0,
//                                  child: Text(
//                                    "Done",
//                                    style:TextStyle(fontSize: 30.0,)
//
//                                  ),
//                                  textColor: Colors.white,
//                                  onPressed: () {
//                                    print(_rating);
//                                    Navigator.pushNamed(context, '/home');
//
//                                  },
//                                  shape: RoundedRectangleBorder(
//                                    borderRadius: BorderRadius.circular(
//                                        screenHeight * 0.1),
//                                  ),
//                                  color: AppColor.colorPrimary,
//                                ),
//                              ),
//                            ),
//                          )
//                        ],
//                      ),
//                    ),
//                  )
//                ],
//              )),
//        )
//      ],
//    );
//  }
//}
//
//
