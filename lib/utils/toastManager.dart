import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'Colors.dart';
class ToastManager {
  fromValidation(context,message) {
    showToast(message,
        context: context,
        animation: StyledToastAnimation.slideFromBottom,
        reverseAnimation: StyledToastAnimation.slideToBottom,
        startOffset: Offset(0.0, 3.0),
        reverseEndOffset: Offset(0.0, 3.0),
        position: StyledToastPosition.bottom,
        duration: Duration(seconds: 3),
        shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        //Animation duration   animDuration * 2 <= duration
        animDuration: Duration(seconds: 1),
        curve: Curves.elasticOut,
        backgroundColor: AppColor.colorPrimary,
        reverseCurve: Curves.fastOutSlowIn);
  }
  fromValidationError(context,message) {
    showToast(message,
        context: context,
        animation: StyledToastAnimation.slideFromBottom,
        reverseAnimation: StyledToastAnimation.slideToBottom,
        startOffset: Offset(0.0, 3.0),
        reverseEndOffset: Offset(0.0, 3.0),
        position: StyledToastPosition.bottom,
        duration: Duration(seconds: 3),
        shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        //Animation duration   animDuration * 2 <= duration
        animDuration: Duration(seconds: 1),
        curve: Curves.elasticOut,
        backgroundColor: AppColor.offLineColor,
        reverseCurve: Curves.fastOutSlowIn);
  }
}