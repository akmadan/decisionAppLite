import 'package:flutter/material.dart';
// import 'package:imei_phone/screens/tractImei.dart';

navigate(BuildContext context, Widget newClass) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => newClass));
}
