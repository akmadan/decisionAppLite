import 'package:decisionapp/auth/login.dart';
import 'package:decisionapp/services/functions.dart';
import 'package:decisionapp/utils/styles.dart';
import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: DrawerWidget(),
      // appBar: AppBar(),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Container(
              //     height: 120, width: 120, child: ImageWidget(image: logo)),
              SizedBox(
                height: 20,
              ),
              Text(
                'DecisionApp',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              Text('Make Decisions Online',
                  style: TextStyle(
                    fontSize: 18,
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    style: buttonStyle,
                    onPressed: () {
                      navigate(context, AuthForm());
                    },
                    child: Text('Authenticate')),
              ),
              // SizedBox(
              //   height: 10,
              // ),
              // Container(
              //   width: double.infinity,
              //   height: 50,
              //   child: ElevatedButton(
              //       style: ButtonStyle(
              //           backgroundColor:
              //               MaterialStateProperty.all(AppColors.darkGrey)),
              //       onPressed: () {
              //         navigate(context, Login());
              //       },
              //       child: Text('SignUp')),
              // ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
