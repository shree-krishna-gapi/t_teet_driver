import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:t_teet_rider/utils/keyboardStatus.dart';
import 'package:t_teet_rider/utils/staticWidget.dart';
import 'package:t_teet_rider/utils/toastManager.dart';
import '../utils/StorageManager.dart';
import '../screens/GenderPage.dart';
import '../utils/Colors.dart';

class NamePage extends StatefulWidget {
  @override
  _NamePageState createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;
    var height = screenSize.height;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        titleSpacing: 0.0,
        automaticallyImplyLeading: false,
        centerTitle: false,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppBarBack(txt:'Back',onPressed: (){
              Navigator.of(context).pop();
            },),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        height: height,
        width: width,
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              width: width,
              child: Padding(
                padding: EdgeInsets.only(top: height * 0.05, left:30.0),
                child: SignUpPageTitle(txt:"What's Your Name?"),
              ),
            ),
            Container(
              height: height * 0.05,
              color: Colors.white,
            ),

            Expanded(
              child: Container(
                width: width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(30),
                    topRight: const Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: width * 0.8,
                        padding: EdgeInsets.only(top: height * 0.005),
                        child: TextFormField(
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          controller: _nameController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            fillColor: Colors.white,
                            hintText: "Full Name",
                          ),
                        ),
                      ),
                      KeyboardStatus(minHeight: height * 0.1, maxHeight :height * 0.38,),
                      Container(
                        // padding: EdgeInsets.only(top: height * 0.3),
                        child: SizedBox(
                          height: height * 0.08,
                          width: width * 0.6,
                          child: NextButton(text:'Next',onPressed : (){
                            if(_nameController.value.text == null || _nameController.value.text == '') {
                              ToastManager().fromValidationError(context,'please, insert your full name');
                            }else {
                              StorageManager()
                                  .setUserName(_nameController.value.text);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => GenderPage()));
                            }
                          }),
                        ),
                      )
                      // Padding(
                      //   padding: EdgeInsets.only(
                      //       bottom: MediaQuery.of(context).viewInsets.bottom),
                      //   child: ,
                      // )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
