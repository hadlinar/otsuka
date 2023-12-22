import 'dart:async';

import 'package:ediscount/views/page/home.dart';
import 'package:ediscount/views/page/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';

import '../../bloc/login/login_bloc.dart';
import '../../utils/global.dart';
import '../../utils/global_state.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);


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

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginBlocState>(
        listener: (context, state) {
          if (state is SuccessLoginState) {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => Home()
            ));
          }
          if (state is LoadingLoginState || state is InitialLoginState) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    title: const SizedBox(
                      height: 50,
                      width: 50,
                      child: Center(
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
          if (state is WrongPasswordLoginState) {
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
          if (state is NoUsernameState) {
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
          if (state is ServerErrorState) {
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
          if (state is NotLoggedInState) {
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
        child: SafeArea(
            top: false,
            bottom: false,
            child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Scaffold(
                    backgroundColor: Colors.white,
                    body: SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.only(left: 21, right: 21),
                        margin: const EdgeInsets.only(top: 100),
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 239,
                                      child: Image.asset(
                                        'assets/images/logo.png',
                                      ),
                                    ),
                                    Container(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                      Container(
                                        margin: const EdgeInsets.only(top: 30, bottom: 20),
                                        child: TextFormField(
                                          style: Global.getCustomFont(Global.BLACK, 15, 'medium'),
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
                                          margin: const EdgeInsets.only(bottom: 32.0),
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
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              padding: const EdgeInsets.only(left: 18, right: 18, top: 9, bottom: 9),
                                              width: 150,
                                              height: 56,
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
                                            )
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                  ],
                ),
                      ),
                    )
              )
            )
        )
    );
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }
}

