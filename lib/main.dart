import 'package:decisionapp/auth/welcome.dart';
import 'package:decisionapp/pages/home.dart';
import 'package:decisionapp/services/providers/templateProvider.dart';
import 'package:decisionapp/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TemplateProvider(),
        ),
      ],
      child: MyAppChild(),
    );
  }
}

class MyAppChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: AppColors.primary,
          // fontFamily: 'WorkSans',
          // scaffoldBackgroundColor: Colors.white,
          brightness: Brightness.light,
          // appBarTheme: AppBarTheme(
          //     iconTheme: IconThemeData(color: Colors.black),
          //     backgroundColor: AppColors.primary,
          //     elevation: 0)
        ),
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Home();
            } else {
              return Welcome();
            }
          },
        ));
  }
}
