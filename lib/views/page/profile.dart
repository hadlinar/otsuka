import 'package:ediscount/bloc/user/user_bloc.dart';
import 'package:ediscount/views/page/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../models/user.dart';
import '../../utils/global.dart';

class ProfilePage extends StatefulWidget {
  User user;

  ProfilePage(this.user, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProfilePage();
  }
}

class _ProfilePage extends State<ProfilePage> {
  late User user;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserBloc>(context).add(GetUserEvent());
    user = widget.user;
  }

  @override
  void dispose() {
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
          onPressed: Navigator.of(context).pop,
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
      backgroundColor: Color(Global.BACKGROUND),
      body: BlocListener<UserBloc, UserBlocState> (
        listener: (context, state) {
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
          if (state is GetUserState) {
            setState(() {
              user = state.getUser;
            });
          }
          if (state is NotLoggedInState || state is ServerErrorState) {
            Login();
          }
          else {
            Container();
          }
        },
        child: Container(
          child: Column(
            children: [
              Container(
                child: Text(user.nama)
              ),
              Container(
                  child: Text(user.username)
              )
            ],
          ),
        )
      ),
    );
  }
}