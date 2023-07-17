import 'package:ediscount/bloc/user/user_bloc.dart';
import 'package:ediscount/views/page/detail_pending.dart';
import 'package:ediscount/views/page/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import '../../../utils/global.dart';
import '../../../utils/global_state.dart';
import '../../bloc/pdk/pdk_bloc.dart';
import '../../bloc/user/user_state.dart';
import '../../models/pdk.dart';
import '../../models/user.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

final GlobalState store = GlobalState.instance;

class _HomePage extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<PDK> pdk = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserBloc>(context).add(GetUserEvent());
    BlocProvider.of<PDKBloc>(context).add(GetProcessPDKEvent());
    _tabController = TabController(length: 2, vsync: this);
  }


  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Global.defaultModal(() {
                  Navigator.pop(context);
                  SystemNavigator.pop();
                }, context, Global.IC_WARNING, "Are you sure you want to quit [the apps]?", "Yes", true);
              }
          );
          return Future.value(true);
        },
        child: BlocBuilder<UserBloc, UserBlocState>(
          builder: (context, state) {
            print(state.toString());
            if(state is LoadingUserState) {
              return Container(
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
              return Scaffold(
                  backgroundColor: Color(Global.BLUE),
                  appBar: AppBar(
                    backgroundColor: Color(Global.BLUE),
                    automaticallyImplyLeading: false,
                    elevation: 0,
                    centerTitle: false,
                    flexibleSpace: Container(
                      decoration: BoxDecoration(
                          gradient: SweepGradient(
                            colors: [Color(Global.TOSCA), Color(Global.BLUE)],
                            stops: [0, 1],
                            center: Alignment.bottomLeft,
                          )
                      ),
                    ),
                    bottom: PreferredSize(
                        preferredSize: const Size.fromHeight(30.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.only(left: 23, bottom: 20),
                            child: Text(
                                "Hello, ${state.getUser.nama}!",
                                style: Global.getCustomFont(Global.WHITE, 20, 'book')
                            ),
                          ),
                        )
                    ),
                    actions: [
                      PopupMenuButton(
                          itemBuilder: (context){
                            return [
                              PopupMenuItem<int>(
                                value: 0,
                                child: Text(
                                    "Profile",
                                    style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                ),
                              ),
                              PopupMenuItem<int>(
                                value: 1,
                                child: Text(
                                    "Logout",
                                    style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                ),
                              ),
                            ];
                          },
                          onSelected:(value){
                            if(value == 0){
                              print("profile");
                            }
                            if(value == 1) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Global.defaultModal(() {
                                      Navigator.pop(context);
                                      BlocProvider.of<UserBloc>(context).add(LogoutEvent());
                                    }, context, Global.IC_WARNING, "Are you sure you want to logout?", "Yes", true);
                                  }
                              );
                            }
                          }
                      ),
                    ],
                  ),
                  body: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                      color: Color(Global.BACKGROUND),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.only(left: 20, right:20, top: 13),
                        child: Column(
                          children: [
                            Container(
                              height: 40,
                              margin: const EdgeInsets.only(bottom:10, left: 30, right: 30),
                              decoration: BoxDecoration(
                                  color: const Color(0xffE7ECF2),
                                  borderRadius: BorderRadius.circular(25)
                              ),
                              child: TabBar(
                                controller: _tabController,
                                indicator: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Color(Global.TOSCA)
                                ),
                                labelColor: Colors.white,
                                unselectedLabelColor: Colors.black,
                                tabs: [
                                  Tab(
                                      child: Text(
                                        "Pending",
                                        style: Global.getCustomFont(Global.BLACK, 14, 'book'),
                                      )
                                  ),
                                  Tab(
                                      child: Text(
                                        "Approved",
                                        style: Global.getCustomFont(Global.BLACK, 14, 'book'),
                                      )
                                  )
                                ],
                              ),
                            ),
                            BlocListener<PDKBloc, PDKBlocState>(
                                listener: (context, state) {
                                  if(state is LoadingPDKState) {
                                    Center(
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        child: const Center(
                                          child: SpinKitDoubleBounce(
                                            color: Color(0xff77A2D2),
                                            size: 50,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  else if (state is GetListProcessState) {
                                    setState(() {
                                      pdk = state.getListProcess;
                                    });
                                  }
                                  else if (state is FailedPDKState) {
                                    Login();
                                  }
                                  else {
                                    Container();
                                  }
                                },
                                child: Expanded(
                                  child: TabBarView(
                                    controller: _tabController,
                                    children: [
                                      Column(
                                        children: [
                                          Expanded(
                                              child: pdk.isNotEmpty ? ListView.builder(
                                                itemCount: pdk.length,
                                                scrollDirection: Axis.vertical,
                                                shrinkWrap: true,
                                                itemBuilder: (context, i) {
                                                  return InkWell(
                                                    onTap: (){
                                                      Navigator.push(context, MaterialPageRoute(
                                                          builder: (context) => DetailPendingPDK(
                                                            pdk[i],
                                                            state.getUser,
                                                            successPostPDK: (int resMessage, BuildContext ctx) {
                                                              if (resMessage == 200) {
                                                                Navigator.of(ctx).pop();
                                                                Navigator.of(ctx).pop();
                                                                BlocProvider.of<UserBloc>(context).add(GetUserEvent());
                                                                BlocProvider.of<PDKBloc>(context).add(GetProcessPDKEvent());
                                                              }
                                                            },
                                                          )
                                                      ));
                                                    },
                                                    child: Global.getCardList(pdk[i].kode_pelanggan, pdk[i].branch, pdk[i].cust, pdk[i].date),
                                                  );
                                                },
                                              ) : Container(
                                                  child: Center(
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Image.asset(
                                                              Global.IC_EMPTY,
                                                              height: 68
                                                          ),
                                                          Container(
                                                            padding: const EdgeInsets.only(top:10),
                                                            child: Text(
                                                              "No pending PDK",
                                                              style: Global.getCustomFont(0xffC1C2C3, 15, 'medium'),
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                  )
                                              )
                                          ),
                                        ],
                                      ),
                                      Center(
                                        child: Text(
                                          'approved',
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                            ),
                          ],
                        )
                    ),
                  )
              );
            }
            if (state is FailedUserState || state is NotLoggedInState){
              return Login();
            } else {
              return Container();
            }
          },
        )
    );
  }
}