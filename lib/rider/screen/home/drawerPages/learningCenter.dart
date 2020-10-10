import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:t_teet_rider/utils/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:t_teet_rider/utils/staticWidget.dart';
class LearningCenter extends StatefulWidget {
  @override
  _LearningCenterState createState() => _LearningCenterState();
}

class _LearningCenterState extends State<LearningCenter> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;
    var height = screenSize.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
            onTap: () {
//              _drawerKey.currentState.openDrawer();
              Navigator.pop(context);
            },
            child: Icon(Icons.close,color: Colors.black,)),
        title: Text('Learning Center',style: TextStyle(color: Colors.black)),
      ),
      body: ListView(
        children: [
         Container(
           padding: EdgeInsets.all(10),
           child: Column(
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               SizedBox(height: height*0.01,),
               Text('Recommended for you',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
               SizedBox(height: height*0.015,),
               Container(
                 decoration: BoxDecoration(
                   border: Border.all(
                     color: AppColor.blackBorder,
                     width: 1.2,
                   ),
                   boxShadow: [
                     BoxShadow(
                       color: Colors.black.withOpacity(0.02),
                       spreadRadius: 5,
                       blurRadius: 5,
                       offset: Offset(0, 0), // changes position of shadow
                     ),
                   ],
                   borderRadius: BorderRadius.circular(12),
                 ),
                 child: ClipRRect(
                   borderRadius: BorderRadius.circular(8),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Image.asset('assets/images/learningCenterBanner.PNG',width: width,fit: BoxFit.fitWidth,),
                       Padding(
                         padding: const EdgeInsets.fromLTRB(15,10,15,4),
                         child: Text('Stay Informed: New Tutorials',style: TextStyle(
                              fontSize: 15,fontWeight: FontWeight.w600
                         ),),
                       ),
                       Padding(
                         padding: const EdgeInsets.fromLTRB(15,0,15,10),
                         child: Text('Concerned about your taxes? wondering how to keep yourself safe? Learn more.',style: TextStyle(
                           letterSpacing: 0.4
                         ),),
                       )
                     ],
                   ),
                 ),
               ),
      Slider(titleImage:'assets/images/shieldUser.png',mainTitle:'Safety',subTitle:'COVID safety tutorial',
          description:'Health safety guidelines from leading health organications.',color: Colors.blue[700],),
               Slider(titleImage:'assets/images/dollarSign1.PNG',mainTitle:'Earnings',subTitle:'COVID safety tutorial',
                 description:'Health safety guidelines from leading health organications.',color: Colors.pink[700],),
               Slider(titleImage:'assets/images/starRating.png',mainTitle:'Ratings & Trips',subTitle:'COVID safety tutorial',
                 description:'Health safety guidelines from leading health organications.',color: Colors.amber[700],),
               SizedBox(height: height*0.04,),

             ],
           ),
         ),

        ],
      ),
    );
  }
}


class Slider extends StatefulWidget {
  Slider({this.titleImage,this.mainTitle,this.subTitle,this.description,this.color});
  final String titleImage,mainTitle,subTitle,description;
  final color;
  @override
  _SliderState createState() => _SliderState();
}

class _SliderState extends State<Slider> {
  CarouselSlider carouselSlider;
  List<int> list = [1, 2, 3];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;
    var height = screenSize.height;
    return Column(
      children: [
        SizedBox(height: height*0.04,),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right:8.0,left: 8.0),
              child: Image.asset(widget.titleImage,height: 20,color: widget.color,),
            ),
            Text(widget.mainTitle,style: TextStyle(fontSize: 16,
                fontWeight: FontWeight.w600),)
          ],
        ),
        SizedBox(height: 10,),
        CarouselSlider(
          options: CarouselOptions(height: 120.0,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 5),
            autoPlayAnimationDuration: Duration(milliseconds: 2000),
            pauseAutoPlayOnTouch:true,
            scrollDirection: Axis.horizontal,
            enlargeCenterPage: false,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },),
          items: list.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 7.5),
                  width: width * 0.9,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      // borderRadius: BorderRadius.circular(11),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8)),
                          color: widget.color,
                        ),
                        width: 7,),
                      Expanded(child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(8),bottomRight: Radius.circular(8)),
                          color: AppColor.blackBorder,
                        ),
                        child: Container(
                          margin:EdgeInsets.fromLTRB(0, 1.2, 1.2, 1.2),
                          padding: EdgeInsets.symmetric(horizontal: 10) ,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topRight: Radius.circular(8),bottomRight: Radius.circular(8)),
                            color: Colors.white,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start ,
                            children: [
                              Text(widget.subTitle,style: TextStyle(
                                  fontWeight: FontWeight.w600,letterSpacing: 0.4
                              ),),
                              SizedBox(height: 6,),
                              Text(widget.description,style: TextStyle(
                                  letterSpacing: 0.2
                              ),)
                            ],
                          ),
                        ),
                      ))
                    ],
                  ),
                );
              },
            );
          }).toList(),
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
      ],
    );
  }
}
