import 'dart:async';

import 'package:ediscount/bloc/user/user_bloc.dart';
import 'package:ediscount/views/page/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../models/user.dart';
import '../../utils/global.dart';
import '../../widget/customer_text_field.dart';

class ChangeNamePage extends StatefulWidget {
  late String name;
  SuccessEditName? successEditName;

  ChangeNamePage(this.name, {this.successEditName});

  @override
  State<StatefulWidget> createState() {
    return _ChangeNamePage();
  }
}

typedef SuccessEditName = void Function(int resultMessage, BuildContext context);

class _ChangeNamePage extends State<ChangeNamePage> {
  User? user;
  TextEditingController nameController = TextEditingController();
  String name = '';

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
      if(state is GetUserState) {
        setState(() {
          user = state.getUser;
        });
        streamUser.cancel();
      }
      if(state is SuccessChangeNameState) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Global.defaultModal(() {
                Navigator.pop(context);
                widget.successEditName!(200, context);
              }, context, Global.IC_CHECK, "Saved", "Ok", false);
            }
        );
      }
      else {
        Container();
      }
    });

  }

  @override
  void dispose() {
    nameController.dispose();
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
              "Change Name",
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
                                padding: const EdgeInsets.only(left: 10, top: 7, bottom: 7, right: 10),
                                child: TextFormField(
                                  style: Global.getCustomFont(Global.BLACK, 13, 'book'),
                                  maxLines: 1,
                                  controller: nameController,
                                  onChanged: (text) {
                                    name = text;
                                  },
                                  decoration: InputDecoration(
                                    labelText: "New name",
                                    alignLabelWithHint: true,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius .circular(10),
                                        borderSide: BorderSide()),
                                  ),
                                ),
                            ),
                          ],
                        ),
                      )
                  )
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  padding: const EdgeInsets.only(left: 18, right: 18, top: 9, bottom: 9),
                  margin: const EdgeInsets.only(bottom: 5),
                  // color: Colors.white,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 93,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                          color: Color(Global.RED),
                                          width: 3
                                      )
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all<Color>(Color(Global.WHITE)),
                              ),
                              onPressed: Navigator.of(context).pop,
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                    color: Color(Global.RED),
                                    fontFamily: 'bold',
                                    fontSize: 13
                                ),
                              )
                          ),
                        ),
                        Container(
                          width: 14,
                        ),
                        SizedBox(
                          width: 93,
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
                                BlocProvider.of<UserBloc>(context).add(
                                    ChangeNameEvent(
                                      nameController.text
                                    )
                                );
                              },
                              child: const Text(
                                "Save",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'bold',
                                    fontSize: 13
                                ),
                              )
                          ),
                        ),
                      ]
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}