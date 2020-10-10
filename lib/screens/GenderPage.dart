import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gender_selection/gender_selection.dart';
import 'package:t_teet_rider/screens/TermsOfServicePage.dart';
import 'package:t_teet_rider/utils/Colors.dart';
import 'package:t_teet_rider/screens/EmailPage.dart';
import 'package:t_teet_rider/utils/StorageManager.dart';
import 'package:t_teet_rider/utils/staticWidget.dart';
import 'package:t_teet_rider/utils/toastManager.dart';

class GenderPage extends StatefulWidget {
  @override
  GenderPageState createState() => GenderPageState();
}

class GenderPageState extends State<GenderPage> {
  String gender = "";
  bool maleActive = false;
  bool femaleActive = false;
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
        child: Column(
          children: <Widget>[

            Container(
              color: Colors.white,
              width: width,
              child: Padding(
                padding: EdgeInsets.only(top: height * 0.05, left:30.0),
                child: SignUpPageTitle(txt:"What's Your Gender?"),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                padding: EdgeInsets.only(top: 10.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          ClipOval(
                            child: Container(height: 130, width: 130,
                              child: Center(
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    splashColor: Colors.amber,
                                    onTap: (){
                                      setState(() {
                                        maleActive =! maleActive;
                                      });
                                      if(femaleActive) {
                                        setState(() {
                                          femaleActive = false;
                                        });
                                      }
                                      gender = 'male';
                                    },
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset('assets/images/genderMale.PNG',height: 80,),
                                        SizedBox(height: 8,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            maleActive ? MaleRadio(active: 'active') : MaleRadio(active: 'inActive'),SizedBox(width: 8,),
                                            Text('Male',style: TextStyle(
                                                fontSize: 16,fontWeight: FontWeight.w400,fontStyle: FontStyle.italic,
                                                color: Colors.black.withOpacity(0.7)
                                            ),)
                                          ],
                                        ),
                                        SizedBox(height: 8,),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          ClipOval(
                            child: Container(height: 130, width: 130,
                              child: Center(
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    splashColor: Colors.amber,
                                    onTap: (){
                                      setState(() {
                                        femaleActive =! femaleActive;
                                        if(femaleActive) {
                                          maleActive = false;
                                        }
                                      });
                                      gender = 'female';
                                    },
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset('assets/images/genderFemale.PNG',height: 80,),
                                        SizedBox(height: 8,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            femaleActive ? FemaleRadio(active: 'active') : FemaleRadio(active: 'inActive'),SizedBox(width: 8,),
                                            Text('Female',style: TextStyle(
                                                fontSize: 16,fontWeight: FontWeight.w400,fontStyle: FontStyle.italic,
                                                color: Colors.black.withOpacity(0.7)
                                            ),)
                                          ],
                                        ),
                                        SizedBox(height: 8,),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // GenderSelection(
                          //   padding: EdgeInsets.only(top: 10.0),
                          //   femaleImage:
                          //   NetworkImage(
                          //       "https://cdn1.iconfinder.com/data/icons/website-internet/48/website_-_female_user-512.png"),
                          //   maleImage: NetworkImage(
                          //       "https://icon-library.net/images/avatar-icon/avatar-icon-4.jpg"),
                          //   selectedGenderIconBackgroundColor: Colors.amber,
                          //   selectedGenderTextStyle: TextStyle(
                          //       color: Colors.amber,
                          //       fontSize: 19,
                          //       fontWeight: FontWeight.bold),
                          //   onChanged: (Gender gender) {
                          //     print(gender.toString());
                          //     print(gender);
                          //     print(gender.index);
                          //     if(gender.index == 0){
                          //       this.gender = "Male";
                          //     }else{
                          //       this.gender = "Female";
                          //
                          //     }
                          //   },
                          // ),


                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Container(
                          padding: EdgeInsets.only(top: height * 0.25),
                          child: SizedBox(
                            height: height * 0.08,
                            width: width * 0.6,
                            child: NextButton(text:'Next',onPressed : (){
                              if(gender == '') {
                                ToastManager().fromValidationError(context,'please, choose your gender');
                              } else {
                                StorageManager().setGender(gender);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EmailPage()));
                              }

                            }),
                          ),
                        ),
                      )
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
