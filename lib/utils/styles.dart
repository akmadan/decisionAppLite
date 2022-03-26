import 'package:decisionapp/utils/colors.dart';
import 'package:flutter/material.dart';
// import 'package:imei_phone/utils/colors.dart';

ButtonStyle buttonStyle = ButtonStyle(
    textStyle: MaterialStateProperty.all(
      TextStyle(color: Colors.white, fontFamily: 'WorkSans'),
    ),
    elevation: MaterialStateProperty.all(0),
    backgroundColor: MaterialStateProperty.all(AppColors.primary));
