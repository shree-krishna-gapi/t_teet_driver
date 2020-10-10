import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:t_teet_rider/utils/Colors.dart';
class FormTitle extends StatelessWidget {
  FormTitle({this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
    );
  }
}
class FormFieldSubText extends StatelessWidget {
  FormFieldSubText({this.subText});
  final String subText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6.0),
      child: Text(subText,style: TextStyle(fontSize: 12,color: Colors.black.withOpacity(0.8)),),
    );
  }
}

class ActiveRadio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.5),
      width: 20,height: 20,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColor.colorPrimary,
          boxShadow: [BoxShadow(
            color: AppColor.colorPrimary.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 0), // changes position of shadow
          ),]
      ),
      child: Container(decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.white),),
    );
  }
}

class InActiveRadio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.5),
      width: 20,height: 20,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black87,
          boxShadow: [BoxShadow(
            color: Colors.black87.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 0), // changes position of shadow
          ),]
      ),
      child: Container(decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.white),),
    );
  }
}
class MaleRadio extends StatelessWidget {
  MaleRadio({this.active});
  final String active;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.5),
      width: 16,height: 16,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: active == 'active' ?  AppColor.colorPrimary : Colors.blue.withOpacity(0.5),
          boxShadow: [BoxShadow(
            color: Colors.black87.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 0), // changes position of shadow
          ),]
      ),
      child: Container(decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.white),),
    );
  }
}
class FemaleRadio extends StatelessWidget {
  FemaleRadio({this.active});
  final String active;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.5),
      width: 16,height: 16,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: active == 'active' ?  AppColor.colorPrimary : Colors.pink.withOpacity(0.4),
          boxShadow: [BoxShadow(
            color: Colors.black87.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 0), // changes position of shadow
          ),]
      ),
      child: Container(decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.white),),
    );
  }
}
class BorderRadio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 17,height: 17,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 5,color: AppColor.colorPrimary,)
      ),
    );
  }
}
class GreenDots extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(height: 6,width: 6, decoration: BoxDecoration(
        shape: BoxShape.circle,color: AppColor.colorPrimary.withOpacity(0.7)
    ),);
  }
}


class CleanButton extends StatefulWidget {
  const CleanButton({this.text, this.onPressed});
  final String text;
  final Function onPressed;
  @override
  _CleanButtonState createState() => _CleanButtonState();
}

class _CleanButtonState extends State<CleanButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Material(
          color: Colors.white,
          child: InkWell(
            onTap: (){widget.onPressed();},
            splashColor: AppColor.splashColorPrimary,
            child: Container(child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.5
              ),
              child: Align(alignment: Alignment.center ,child: Text(widget.text,style: TextStyle(
                  fontSize: 25,fontWeight: FontWeight.w600
              ),)),
            ),width: double.infinity,),
          ),
        ),
      ),
    );
  }
}
class VerifyButton extends StatefulWidget {
  const VerifyButton({this.text, this.onPressed});
  final String text;
  final Function onPressed;
  @override
  _VerifyButtonState createState() => _VerifyButtonState();
}

class _VerifyButtonState extends State<VerifyButton> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(
        widget.text,
        style: TextStyle(fontSize: 30.0),
      ),
      textColor: Colors.white,
      onPressed: () {
        widget.onPressed();
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.0),
      ),
      color: AppColor.colorPrimary,

    );
  }
}

class NextButton extends StatefulWidget {
  const NextButton({this.text, this.onPressed});
  final String text;
  final Function onPressed;
  @override
  _NextButtonState createState() => _NextButtonState();
}

class _NextButtonState extends State<NextButton> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(
        widget.text,
        style: TextStyle(fontSize: 20.0),
      ),
      textColor: Colors.white,
      onPressed: () {
        widget.onPressed();
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.0),
      ),
      color: AppColor.colorPrimary,

    );
  }
}

class AppBarBack extends StatelessWidget {
  AppBarBack({this.txt,this.onPressed});
  final String txt;
  Function onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(left: 5,right: 10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              // SizedBox(width: 4,),
              Text(
                txt,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                ),
              )
            ]),
      ),
    );
  }
}
class AppBarSkip extends StatelessWidget {
  AppBarSkip({this.txt,this.onPressed});
  final String txt;
  Function onPressed;
  @override
  Widget build(BuildContext context) {
    return txt != '' ? InkWell(onTap: onPressed,child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(txt,   style: TextStyle(color: AppColor.colorPrimary, fontSize: 18.5, ),),
    )):Text('');
  }
}

//
// class AppBarBack extends StatefulWidget {
//    AppBarBack({this.txt,this.onPressed});
//   final String txt;
//   Function onPressed;
//   @override
//   _AppBarBackState createState() => _AppBarBackState();
// }
//
// class _AppBarBackState extends State<AppBarBack> {
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             Icon(
//               Icons.arrow_back_ios,
//               color: Colors.black,
//             ),
//             Text(
//               "Back",
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 15,
//                 fontWeight: FontWeight.normal,
//               ),
//             )
//           ]),
//     );
//   }
// }

class DotsActive extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6),
      padding: EdgeInsets.all(1.5),
      height: 10, width: 10, decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(90),
        ),
        color: Colors.black
    ),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(90),
            ),
            color: Colors.white
        ),
      )
    );
  }
}
class DotsInactive extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container( margin: EdgeInsets.symmetric(horizontal: 6),
      padding: EdgeInsets.all(1.5),
      height: 10, width: 10, decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
            Radius.circular(90)
        ),color: Colors.black
    ),);
  }
}

class Wait extends StatelessWidget {
  Wait({this.txt});
  final String txt;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircularProgressIndicator(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(txt,style: TextStyle(fontWeight: FontWeight.w600),),
        )
      ],
    );
  }
}
class HelpLineCall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 30),
        child: Text('Need Help? Call: +977-4444762',style: TextStyle(color: Colors.white),),
      ),
    );
  }
}

final Connectivity _connectivity = Connectivity();
Future<dynamic>networkStatus() async{
  try {
    ConnectivityResult result = await _connectivity.checkConnectivity();
    if(result == ConnectivityResult.none) {
      return false;
    }
    else {
      return true;
    }
  } on PlatformException catch (e) {
    print(e.toString());
    print('**************');
    return false;
  }
}


class SignUpPageTitle extends StatelessWidget {
  SignUpPageTitle({this.txt});
  final String txt;
  @override
  Widget build(BuildContext context) {
    return Text(txt,
      style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w300),
    );
  }
}
