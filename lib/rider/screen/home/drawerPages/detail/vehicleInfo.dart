import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:t_teet_rider/utils/Colors.dart';
class VehicleInfo extends StatefulWidget {
  VehicleInfo({this.vechicleYear,this.vehicleModel});
  final String vechicleYear,vehicleModel;
  @override
  _VehicleInfoState createState() => _VehicleInfoState();
}

class _VehicleInfoState extends State<VehicleInfo> {
  bool expansionValue = false;
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
                          child: Text("Vehicles",
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
          ),actions: <Widget>[

          InkWell(
            onTap: () {
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Icon(Icons.add,size: 22,color: Colors.black,),
            ),
          ),
        ],
          backgroundColor: Colors.white,
        ),
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              Container(height: 135,
                  color: Colors.white,
                  child: Stack(
                    children: <Widget>[
                      Positioned(child:  Image.asset('assets/images/vehicle1.png',height: 100,),
                      right: -50,top: 30,
                      ),

                      Positioned(child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("2018",style: TextStyle(  //widget.vechicleYear
                            color: Colors.black,fontWeight: FontWeight.w600, fontSize: 18,

                          ),),
                          Padding(
                            padding: const EdgeInsets.only(top: 3,bottom: 5),
                            child: Text("Acura ILX",style: TextStyle(  //${obj.phone} //{widget.vehicleModel
                              color: Colors.black,fontWeight: FontWeight.w600, fontSize: 14,
                            ),),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              color: Colors.orange,
                              child: Material(
                                  color: Colors.transparent,
                                child: InkWell(
                                  splashColor: Colors.green,
                                  child: Padding(
                                  padding: const EdgeInsets.fromLTRB(15,4,15,4),
                                  child: Text('UPDATE',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white),),
                                ),),
                              ),
                            ),
                          )
                        ],
                      ), right: 0,  top: 40,bottom: 0,left: 20, ),
                    ],
                  )
              ),
              SizedBox(height: height * 0.05,),
              Container(
                child: Stack(
                  children: [
                    expansionValue ? Container() : Positioned(child:  Container(color: AppColor.blackBorder,
                      padding: EdgeInsets.symmetric(vertical: 1),
                      child:Container(
                      height: 1, color: Colors.white,
                    ),),top: 8,left: 0,
                    right: 0, bottom: 8,),
                    ExpansionTile(
                      onExpansionChanged: (value){
                        setState(() {
                          expansionValue = value;
                        });
                      },
                      title: new Text('See Details',style: new TextStyle(fontSize: 15.0,
                          fontWeight: FontWeight.w500,),),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: new Column(
                            children: <Widget>[
                              RaisedButton(onPressed: (){
                              },
                                color: Colors.orange,
                                child: Text('Hello World',style: TextStyle(color: Colors.white),),
                              )

                            ],
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
              SizedBox(height: height * 0.04,),
              Container(height: 120,
                  color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20,),
                          Container(
                            child: Row(
                              children: [
                                Text("lyft ",style: TextStyle(  //widget.vechicleYear
                                  color: Colors.black, fontSize: 13,
                                  letterSpacing: -0.4,
                                  shadows: <Shadow>[
                                    Shadow(
                                      offset: Offset(0.0, 0.0),
                                      blurRadius: 2.0,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),

                                  ],


                                ),),Text("express drive",style: TextStyle(  //widget.vechicleYear
                                  color: Colors.black,fontWeight: FontWeight.w600, fontSize: 13,

                                ))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5,bottom: 5,right: 15),
                            child: Text("Save Your Vehicle from wear and tear.",style: TextStyle(  //${obj.phone} //{widget.vehicleModel
                              color: Colors.black,fontWeight: FontWeight.w600, fontSize: 14, height: 1.3
                            ),),
                          ),
                        ],
                      ),flex: 5,),
                      Expanded(child: Container(
                        child: Stack(
                          children: <Widget>[
                            Positioned(child:  Image.asset('assets/images/carRent.png',height: 100,),
                              right: -12,top: 0,
                            ),
                          ],
                        ),
                      ),flex: 3,)
                    ],
                  )
              ),
              Container(height: 1, color: AppColor.blackBorder,),
              Row(
                children: [
                  Expanded(child: Container(
                    child: Material(color: Colors.transparent,child: InkWell(splashColor: Colors.orange,
                        onTap: () {
                      print('click');
                        },
                        child: Center(child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Text('Learn more',style: TextStyle(fontWeight: FontWeight.w600),),
                        )))),
                  ),flex: 1,),
                  Expanded(child: Container(
                    child: Material(color: Colors.transparent,child: InkWell(splashColor: Colors.orange,
                        onTap: () {
                          print('click');
                        },
                        child: Center(child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Text('Rent a car',style: TextStyle(fontWeight: FontWeight.w600),),
                        )))),
                  ),flex: 1,),
                ],
              ),
              Container(height: 1, color: AppColor.blackBorder,),

              SizedBox(height: height*0.11),
              Container(
                padding: EdgeInsets.all(3.0),
                width: double.infinity,
                height: 48,
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 1.2,
                        color: AppColor.blackBorder),
                    borderRadius: BorderRadius.circular(90),
                ),
                child: Center(child: Text('Continue application',style: TextStyle(
                  fontWeight: FontWeight.w600,fontSize: 15
                ),)),
              )
            ],
          ),
        )
    );
  }

}
