import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decisionapp/services/authFunctions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  //------------------------------------------
  final _formkey = GlobalKey<FormState>();
  var _email = '';
  var _password = '';
  var _username = '';
  bool isLoginPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: [
              // Container(
              //   margin: EdgeInsets.all(30),
              //   height: 200,
              //   child: Image.asset('assets/todo.png'),
              // ),
              SizedBox(
                height: 20,
              ),
              Container(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (!isLoginPage)
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            key: ValueKey('username'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Incorrect Username';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _username = value!;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(8.0),
                                  borderSide: new BorderSide()),
                              labelText: "Enter Username",
                            ),
                          ),
                        SizedBox(height: 10),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          key: ValueKey('email'),
                          validator: (value) {
                            if (value!.isEmpty || !value.contains('@')) {
                              return 'Incorrect Email';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _email = value!;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(8.0),
                                borderSide: new BorderSide()),
                            labelText: "Enter Email",
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          obscureText: true,
                          keyboardType: TextInputType.emailAddress,
                          key: ValueKey('password'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Incorrect password';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _password = value!;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(8.0),
                                borderSide: new BorderSide()),
                            labelText: "Enter Password",
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                            padding: EdgeInsets.all(5),
                            width: double.infinity,
                            height: 70,
                            child: ElevatedButton(
                                child: isLoginPage
                                    ? Text(
                                        'Login',
                                      )
                                    : Text(
                                        'SignUp',
                                      ),
                                onPressed: () {
                                  final validity =
                                      _formkey.currentState!.validate();
                                  FocusScope.of(context).unfocus();

                                  if (validity) {
                                    _formkey.currentState!.save();
                                    isLoginPage
                                        ? signinUser(_email, _password, context)
                                        : signupUser(_email, _password,
                                            _username, context);
                                  }
                                })),
                        SizedBox(height: 10),
                        Container(
                          child: TextButton(
                              onPressed: () {
                                setState(() {
                                  isLoginPage = !isLoginPage;
                                });
                              },
                              child: isLoginPage
                                  ? Text(
                                      "Don't have an account? SignUp",
                                    )
                                  : Text(
                                      'Already have an account? Login',
                                    )),
                        )
                      ],
                    ),
                  ))
            ],
          )),
    );
  }
}
