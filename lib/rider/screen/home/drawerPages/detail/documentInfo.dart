import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:t_teet_rider/utils/Colors.dart';
class DocumentInfo extends StatefulWidget {
  DocumentInfo({this.licensePhoto,this.bluebookFrontPhoto,this.bluebookBackPhoto});
  final String licensePhoto,bluebookFrontPhoto,bluebookBackPhoto;
  @override
  _DocumentInfoState createState() => _DocumentInfoState();
}

class _DocumentInfoState extends State<DocumentInfo> with SingleTickerProviderStateMixin{
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this);
    super.initState();
  }
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
                          child: Text("Document",
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
        bottom: TabBar(
    unselectedLabelColor: Colors.black45,
    labelColor: Colors.black,
    tabs: [
      Text('License',style: tabStyle),
      Text('Bluebook',style: tabStyle),
      Text('Others',style: tabStyle),
    ],indicatorColor: AppColor.colorPrimary,
    labelPadding: EdgeInsets.only(bottom: 4),
    controller: _tabController,
    )),
      body: TabBarView(
        children: [
         Container(
           child: Column(
             children: [
               CachedNetworkImage(
                 imageUrl: widget.licensePhoto,fit: BoxFit.fill,
                 errorWidget: (context, url, error) => Icon(Icons.error),
               ),
             ],
           ),
         ),
          BluebookTab(frontPhoto:widget.bluebookFrontPhoto,backPhoto:widget.bluebookBackPhoto),
          Text("This is notification Tab View"),
        ],
        controller: _tabController,
      ),

    );
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
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl: frontPhoto,fit: BoxFit.fill,
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          CachedNetworkImage(
            imageUrl: backPhoto,fit: BoxFit.fill,
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ],
      ),
    );
  }
}
