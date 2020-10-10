import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:t_teet_rider/rider/screen/home/drawerPages/detail/vehicleAdd.dart';
import 'package:t_teet_rider/rider/screen/home/drawerPages/detail/vehicleUpdate.dart';
import 'package:t_teet_rider/utils/Colors.dart';
import 'package:t_teet_rider/utils/PushNotificationService.dart';
import 'package:t_teet_rider/utils/StorageManager.dart';
import 'package:t_teet_rider/utils/Utils.dart';
class Vehicle extends StatefulWidget {
  // Vehicle({this.vechicleYear,this.vehicleModel});
  // final String vechicleYear,vehicleModel;
  @override
  _VehicleState createState() => _VehicleState();
}

class _VehicleState extends State<Vehicle> {
  bool expansionValue = false;
  var manager = StorageManager();

  String phone;
  @override
  void initState() {
    // TODO: implement initState
    initialize();
    super.initState();
  }
  initialize() async {
    phone = await StorageManager().getPhone();
    setState(() {
      getFirestoreInstance().then((value) {
        firestore = value;
      });
    });
  }

  double dynamicHeight = 0.0;
  double setupHeight = 0.0;

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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VehicleAdd()),
              );
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
              SingleChildScrollView(
                child: StreamBuilder(
                    stream: Firestore.instance.collection("vehicles").document(phone).collection('test').snapshots(),
                    builder: (context, snapshot) {
                      if(!snapshot.hasData)
                        return Text('loading');
                      return ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data.documents.length == null ? 0 : snapshot.data.documents.length,
                          itemBuilder: (context, index) {

                            return Column(
                              children: [
                                Container(
                                  height: 120,
                                  child: Row(
                                    children: [
                                      Expanded(flex:4, child: Padding(
                                        padding: const EdgeInsets.only(left: 20,top: 30),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('${snapshot.data.documents[index]['vehicle_model']}',style: TextStyle(  //widget.vechicleYear
                                              color: Colors.black,fontWeight: FontWeight.w600, fontSize: 18,

                                            ),),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 3,bottom: 15),
                                              child: Text("${snapshot.data.documents[index]['vehicle_name']}",style: TextStyle(  //${obj.phone} //{widget.vehicleModel
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
                                                    onTap: (){
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(builder: (context) => VehicleUpdate(
                                                          index: index,
                                                          image: snapshot.data.documents[index]['vehicle_image'],
                                                          name: snapshot.data.documents[index]['vehicle_name'],
                                                          model: snapshot.data.documents[index]['vehicle_model'],
                                                          description: snapshot.data.documents[index]['vehicle_description'],

                                                        )),
                                                      );
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets.fromLTRB(15,5,15,5),
                                                      child: Text('UPDATE',style: TextStyle(color: Colors.white),),
                                                    ),),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),),
                                      Expanded(flex:5, child: Stack(
                                        children: <Widget>[
                                          Positioned(child:
                                          Container(
                                            // height: 140,
                                            child: CachedNetworkImage(
                                              imageUrl: "${snapshot.data.documents[index]['vehicle_image']}",
                                              height: 120,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) => Padding(
                                                padding: const EdgeInsets.only(right:40,bottom: 10),
                                                child: CircularProgressIndicator(),
                                              ),
                                              errorWidget: (context, url, error) => Icon(Icons.error),
                                            ),
                                          ),
                                            right: -10,top: 30,
                                          ),
                                        ],
                                      ),),
                                    ],
                                  ),
                                ),
                                SizedBox(height: height * 0.04,),
                                Container(
                                  child: Stack(
                                    children: [
                                      expansionValue ? Container() : Positioned(child:  Container(color: AppColor.blackBorder.withOpacity(0.8),
                                        padding: EdgeInsets.symmetric(vertical: 1),
                                        child:Container(
                                          height: 1, color: Colors.white,
                                        ),),top: 8,left: 0,
                                        right: 0, bottom: 8,),
                                      ExpansionTile(
                                        onExpansionChanged: (value$index){
                                          if(value$index) {
                                            setState(() {
                                              dynamicHeight = dynamicHeight + 60.0;
                                              expansionValue = value$index;
                                            });
                                          }else {
                                            setState(() {
                                              dynamicHeight = dynamicHeight;
                                              expansionValue = value$index;
                                            });
                                          }

                                        },
                                        title: new Text('See Details',style: new TextStyle(fontSize: 15.0,
                                          fontWeight: FontWeight.w500,),),
                                        children: <Widget>[
                                          Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                              child: Text('${snapshot.data.documents[index]['vehicle_description']}')
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),
                                ),
                                SizedBox(height: height * 0.04,),
                              ],
                            );
                          });
                    }),
              ),
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
              InkWell(
                child: Container(
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
                ),
              )
            ],
          ),
        )
    );
  }

}
class Message{
  final String test;
  const Message(this.test);
}
