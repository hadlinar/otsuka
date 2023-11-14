import 'dart:async';

import 'package:ediscount/views/page/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';

import '../../bloc/login/login_bloc.dart';
import '../../utils/global.dart';

class Login extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _LoginPage();
  }
}

class _LoginPage extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String username = '';
  String pass = '';
  bool showPassword = true;

  final home = Home();


  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginBlocState>(
      listener: (context, state) {
        if (state is LoadingLoginState) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  title: Container(
                    height: 50,
                    width: 50,
                    child: const Center(
                      child: SpinKitDoubleBounce(
                        color: Color(0xff77A2D2),
                        size: 50,
                      ),
                    ),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Center(
                          child: Text("Please wait",
                              style: Global.getCustomFont(Global.BLACK, 14, 'medium'),
                              textAlign: TextAlign.center)
                      ),
                    ],
                  ),
                );
              }
          );
        }
        else if (state is SuccessLoginState) {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => home
          ));
        }
        else if (state is WrongPasswordLoginState) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Global.defaultModal(() {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                }, context, Global.IC_WARNING, "Wrong password", "Ok", false);
              }
          );
        }
        else if (state is NoUsernameState) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Global.defaultModal(() {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                }, context, Global.IC_WARNING, "User not found", "Ok", false);
              }
          );
        }
        else if (state is ServerErrorState) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Global.defaultModal(() {
                  Navigator.pop(context);
                  Navigator.pop(context);
                }, context, Global.IC_WARNING, "Internal server error", "Ok", false);
              }
          );
        }
        else if (state is NotLoggedInState) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Global.defaultModal(() {
                  Navigator.pop(context);
                  Navigator.pop(context);
                }, context, Global.IC_WARNING, "User not registered", "Ok", false);
              }
          );
        }
      },
      child: GestureDetector (
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView (
            child: Column(
              children: [
                Stack(
                  children: [
                    Align(
                        child: Container(
                          margin: const EdgeInsets.only(top: 140),
                          child: SizedBox(
                            width: 250,
                            child: Image.asset(
                              'assets/images/logo.png',
                            ),
                          ),
                        )
                    ),
                    Container(
                        padding: const EdgeInsets.only(left: 31, right: 31),
                        margin: const EdgeInsets.only(top: 378),
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(top: 30, bottom: 20),
                              child: TextFormField(
                                style: Global.getCustomFont(Global.BLACK, 14, 'medium'),
                                maxLines: 1,
                                controller: usernameController,
                                onChanged: (text) {
                                  username = text;
                                },
                                decoration: InputDecoration(
                                  labelText: "Username",
                                  alignLabelWithHint: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius .circular(10),
                                      borderSide: BorderSide()),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 30),
                              child: TextFormField(
                                controller: passwordController,
                                onChanged: (text) {
                                  pass = text;
                                },
                                style: Global.getCustomFont(Global.BLACK, 15, 'medium'),
                                obscureText: showPassword,
                                decoration: InputDecoration(
                                    labelText: "Password",
                                    alignLabelWithHint: true,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius .circular(10),
                                        borderSide: const BorderSide()
                                    ),
                                    suffixIcon: IconButton(
                                        icon: const Icon(Icons.remove_red_eye),
                                        onPressed: () {
                                          setState(() {
                                            showPassword = !showPassword;
                                          });
                                        }
                                    )
                                ),
                              ),
                            ),
                          ] ,
                        ),

                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: const EdgeInsets.only(left: 18, right: 18, top: 9, bottom: 9),
                    width: 190,
                    height: 56,
                    color: Colors.white,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Color(Global.BLUE))
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(Color(Global.BLUE)),
                        ),
                        onPressed: () {
                          BlocProvider.of<LoginBloc>(context).add(
                              LoginEvent(
                                  username,
                                  pass
                              )
                          );
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'bold',
                              fontSize: 15
                          ),
                        )
                    ),
                  ),
                )
              ],
            )
          ),
        )
      ),
    );
  }
}