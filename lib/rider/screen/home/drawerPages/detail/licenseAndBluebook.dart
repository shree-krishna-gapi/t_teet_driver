import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:t_teet_rider/utils/Colors.dart';
class LicenseAndBluebook extends StatefulWidget {
  LicenseAndBluebook({this.licensePhoto,this.bluebookFrontPhoto,this.bluebookBackPhoto});
  final String licensePhoto,bluebookFrontPhoto,bluebookBackPhoto;
  @override
  _LicenseAndBluebookState createState() => _LicenseAndBluebookState();
}

class _LicenseAndBluebookState extends State<LicenseAndBluebook> {

  @override
  Widget build(BuildContext context) {
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
                          child: Text("License and Bluebook",
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
      body: BluebookTab(frontPhoto:widget.bluebookFrontPhoto,backPhoto:widget.bluebookBackPhoto));
  }
  final tabStyle = TextStyle(
      fontSize: 17
  );
}


class BluebookTab extends StatelessWidget {
  BluebookTab({this.frontPhoto,this.backPhoto});
  final String frontPhoto,backPhoto;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        children: [
          CachedNetworkImage(
            imageUrl: frontPhoto,fit: BoxFit.fill,
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          SizedBox(height: 15,),
          CachedNetworkImage(
            imageUrl: backPhoto,fit: BoxFit.fill,
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ],
      ),
    );
  }
}
