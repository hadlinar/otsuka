import 'dart:async';

import 'package:ediscount/bloc/user/user_bloc.dart';
import 'package:ediscount/views/page/change_password.dart';
import 'package:ediscount/views/page/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../models/user.dart';
import '../../utils/global.dart';
import 'change_name.dart';

class ProfilePage extends StatefulWidget {
  User? user;
  ReloadPage? reloadPage;

  ProfilePage(this.user, {Key? key, this.reloadPage}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProfilePage();
  }
}

typedef ReloadPage = void Function(int resultMessage, BuildContext context, bool fromProfile);

class _ProfilePage extends State<ProfilePage> {
  User? user;
  bool flgUpt = false;

  late UserBloc userBloc;

  late StreamSubscription streamUser;

  @override
  void initState() {
    super.initState();
    userBloc = BlocProvider.of<UserBloc>(context);
    userBloc.add(GetUserEvent());

    streamUser = userBloc.stream.listen((state) {
      if(state is LoadingUserState) {
        Container(
          color: Colors.white,
          child: Center(
            child: SpinKitDoubleBounce(
              color: Color(Global.TOSCA),
              size: 70,
            ),
          ),
        );
      }
      if(user == null) {
        Container(
          color: Colors.white,
          child: Center(
            child: SpinKitDoubleBounce(
              color: Color(Global.TOSCA),
              size: 70,
            ),
          ),
        );
      }
      if (state is GetUserState) {
        setState(() {
          user = state.getUser;
        });
        streamUser.cancel();
      } else {
        Container();
      }
    });

    streamUser = userBloc.stream.listen((state) {
      if(state is LoadingUserState) {
        Container(
          color: Colors.white,
          child: Center(
            child: SpinKitDoubleBounce(
              color: Color(Global.TOSCA),
              size: 70,
            ),
          ),
        );
      }
      if(user == null) {
        Container(
          color: Colors.white,
          child: Center(
            child: SpinKitDoubleBounce(
              color: Color(Global.TOSCA),
              size: 70,
            ),
          ),
        );
      }
      if (state is GetUserState) {
        setState(() {
          user = state.getUser;
        });
        streamUser.cancel();
      } else {
        Container();
      }
    });

  }

  @override
  void dispose() {
    userBloc.close();
    streamUser.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: SweepGradient(
                    colors: [Color(Global.TOSCA), Color(Global.BLUE)],
                    stops: [0, 1],
                    center: Alignment.bottomLeft,
                  )
              ),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                widget.reloadPage!(200, context, true);
              },
              icon: Icon(
                Icons.arrow_back_rounded,
                color: Color(Global.WHITE),
                size: 25.0,
              ),
            ),
            title: Text(
                "Profile",
                style: Global.getCustomFont(Global.WHITE, 15, 'medium')
            ),
          ),
          body: Container(
            color: Color(Global.BACKGROUND),
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 13),
            child: Column(
              children: [
                SizedBox(
                    child: Card(
                        color: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  padding: const EdgeInsets.only(left: 10, top: 10, bottom: 7, right: 10),
                                  child: Text("Username", style: Global.getCustomFont(Global.DARK_GREY, 13, 'book'))
                              ),
                              Container(
                                  padding: const EdgeInsets.only(top: 3, left: 15, right: 7, bottom: 10),
                                  child: Text(flgUpt ? user!.username : widget.user!.username, style: Global.getCustomFont(Global.BLACK, 13, 'book'))
                              ),
                              Container(
                                  padding: const EdgeInsets.only(left: 10, top: 10, bottom: 7, right: 10),
                                  child: Text("Name",
                                    style: Global.getCustomFont(Global.DARK_GREY, 13, 'book'),
                                    textAlign: TextAlign.start,
                                  )
                              ),
                              Container(
                                  padding: const EdgeInsets.only(top: 3, left: 15, right: 7, bottom: 10),
                                  child: Row(
                                    children: [
                                      Text(flgUpt ? user!.nama : widget.user!.nama, style: Global.getCustomFont(Global.BLACK, 13, 'book')),
                                      Container(
                                        width: 14,
                                      ),
                                      InkWell(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context) => ChangeNamePage(
                                                widget.user!.nama,
                                                successEditName: (int resMessage, BuildContext ctx, bool flg) {
                                                  if (resMessage == 200) {
                                                    Navigator.of(ctx).pop();
                                                    Navigator.of(ctx).pop();
                                                    flgUpt = flg;
                                                    BlocProvider.of<UserBloc>(context).add(GetUserEvent());
                                                  }
                                                },
                                              )
                                          ));
                                        },
                                        child: Icon(
                                          Icons.create_outlined,
                                          color: Color(Global.DARK_GREY),
                                          size: 20,
                                        ),
                                      )
                                    ],
                                  )
                              ),
                            ],
                          ),
                        )
                    )
                ),

                SizedBox(
                    child: Card(
                        color: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => ChangePasswordPage(
                                      successChangePasswordName: (int resMessage, BuildContext ctx) {
                                        if (resMessage == 200) {
                                          Navigator.of(ctx).pop();
                                          BlocProvider.of<UserBloc>(context).add(GetUserEvent());
                                        }
                                      },
                                    )
                                ));
                              },
                              child: Container(
                                padding: const EdgeInsets.only(left: 10, top: 10, bottom: 7, right: 10),
                                child: Row(
                                  children: [
                                    Text("Change password", style: Global.getCustomFont(Global.BLACK, 13, 'book')),
                                    const Spacer(),
                                    Icon(
                                      Icons.keyboard_arrow_right_rounded ,
                                      color: Color(Global.DARK_GREY),
                                      size: 25,
                                    ),
                                  ],
                                ),
                              ),
                            )
                        )
                    )
                ),
              ],
            ),
          )
    );
  }
}