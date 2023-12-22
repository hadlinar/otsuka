import 'dart:async';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:ediscount/bloc/user/user_bloc.dart';
import 'package:ediscount/views/page/detail_pending.dart';
import 'package:ediscount/views/page/login.dart';
import 'package:ediscount/views/page/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../utils/global.dart';
import '../../../utils/global_state.dart';
import '../../bloc/pdk/pdk_bloc.dart';
import '../../bloc/user/user_state.dart';
import '../../models/pdk.dart';
import '../../models/user.dart';
import 'detail_done.dart';

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
  List<PDK> donePdk = [];

  List<PDK> searchPdk = [];
  List<PDK> searchDonePdk = [];

  late GlobalKey<ScaffoldState> _scaffoldKey;

  User? user;
  late String check;
  bool fromProfile = false;

  late UserBloc userBloc;
  late PDKBloc pdkBloc;

  late StreamSubscription streamUser;

  TextEditingController searchController = TextEditingController();
  String search = '';

  void filterSearchResults(String query) {
    setState(() {
      searchPdk = pdk.where((item) => item.no_draft.toLowerCase().contains(query.toLowerCase()) || item.kode_pelanggan.toLowerCase().contains(query.toLowerCase()) || item.cust.toLowerCase().contains(query.toLowerCase())).toList();
      searchDonePdk = donePdk.where((item) => item.no_draft.toLowerCase().contains(query.toLowerCase()) || item.kode_pelanggan.toLowerCase().contains(query.toLowerCase()) || item.cust.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  Future refreshData() async {
    print("refresh");
    //
    BlocListener<PDKBloc, PDKBlocState>(
        listener: (context, state) {

          if(state is LoadingPDKState || pdk.isEmpty) {
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
          if (state is GetListProcessState) {
            setState(() {
              pdk = state.getListProcess;
              searchPdk = state.getListProcess;
              print(searchPdk.length);
            });
          }
          if (state is GetListDoneState) {
            setState(() {
              donePdk = state.getListDone;
              searchDonePdk = state.getListDone;
              print(searchDonePdk.length);
            });
          }
        }
    );

  }

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey();
    BlocProvider.of<UserBloc>(context).add(GetUserEvent());
    BlocProvider.of<PDKBloc>(context).add(GetProcessPDKEvent());
    BlocProvider.of<PDKBloc>(context).add(GetDonePDKEvent("oldest"));
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _scaffoldKey.currentState?.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserBlocState>(
      builder: (context, state) {
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
        if(state is GetUserState) {
          return WillPopScope(
            onWillPop: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Global.defaultModal(() {
                    Navigator.pop(context);
                    SystemNavigator.pop();
                  }, context, Global.IC_WARNING, "Are you sure you want to quit the apps?", "Yes", true);
                }
              );
              return Future.value(true);
            },
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Scaffold(
                key: _scaffoldKey,
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
                          stops: const [0, 1],
                          center: Alignment.bottomLeft,
                        )
                    ),
                  ),
                  bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(30.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: fromProfile ? BlocListener<UserBloc, UserBlocState>(
                          listener: (context, state) {
                            if(state is GetUserState) {
                              setState(() {
                                user = state.getUser;
                                check = state.check;
                              });

                              final snackBar = SnackBar(
                                elevation: 0,
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                content: AwesomeSnackbarContent(
                                  title: 'Perhatian!',
                                  message: 'Silahkan ganti password terlebih dahulu',
                                  contentType: ContentType.failure,
                                ),
                                duration: const Duration(seconds: 30),
                              );

                              check == "1" ? ScaffoldMessenger.of(context).showSnackBar(snackBar) : Container();

                            } else {
                              Container();
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 23, bottom: 20),
                            child: Text(
                                "Hello, ${user?.nama}!",
                                style: Global.getCustomFont(Global.WHITE, 20, 'book')
                            ),
                          ),
                        ) : Container(
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
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => ProfilePage(
                                  user!,
                                  reloadPage: (int resMessage, BuildContext ctx, bool fromProf) {
                                    if (resMessage == 200 && fromProf) {
                                      setState(() {
                                        fromProfile = fromProf;
                                      });
                                      BlocProvider.of<UserBloc>(context).add(GetUserEvent());
                                    }
                                  },
                                )
                            ));
                          }
                          if(value == 1) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Global.defaultModal(() {
                                    Navigator.pop(context);
                                    BlocProvider.of<UserBloc>(context).add(LogoutEvent());
                                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                                        builder: (context) => Login()), (Route route) => false);
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
                  child: BlocListener<PDKBloc, PDKBlocState> (
                    listener: (context, state) {
                      if(state is LoadingPDKState) {
                        const Center(
                          child: SizedBox(
                            height: 50,
                            width: 50,
                            child: Center(
                              child: SpinKitDoubleBounce(
                                color: Color(0xff77A2D2),
                                size: 50,
                              ),
                            ),
                          ),
                        );
                      }
                      if(state is GetListProcessState) {
                        setState(() {
                          pdk = state.getListProcess;
                          searchPdk = state.getListProcess;
                        });
                      }
                      if (state is GetListDoneState) {
                        setState(() {
                          donePdk = state.getListDone;
                          searchDonePdk = state.getListDone;
                        });
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20, top: 13),
                      child: Column(
                        children: [
                          Container(
                            height: 40,
                            margin: const EdgeInsets.only(bottom: 10, left: 30, right: 30),
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
                              tabs: const [
                                Tab(
                                    child: Text(
                                      "Pending",
                                      // style: Global.getCustomFont(Global.BLACK, 14, 'book'),
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'book'
                                      ),
                                    )
                                ),
                                Tab(
                                    child: Text(
                                      "Processed",
                                      // style: Global.getCustomFont(Global.BLACK, 14, 'book'),
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'book'
                                      ),
                                    )
                                )
                              ],
                            )
                          ),
                          Expanded(
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                RefreshIndicator(
                                  color: Color(Global.TOSCA),
                                  backgroundColor: Colors.white,
                                  onRefresh: () async {
                                    BlocProvider.of<PDKBloc>(context).add(GetProcessPDKEvent());
                                    BlocProvider.of<PDKBloc>(context).add(GetDonePDKEvent("oldest"));
                                  },
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: SizedBox(
                                              height: 50,
                                              child: Container(
                                                margin: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 2),
                                                child: TextFormField(
                                                  style: Global.getCustomFont(Global.BLACK, 14, 'medium'),
                                                  maxLines: 1,
                                                  controller: searchController,
                                                  onChanged: (text) {
                                                    filterSearchResults(text);
                                                  },
                                                  decoration: InputDecoration(
                                                    labelText: "Search",
                                                    filled: true,
                                                    fillColor: Color(Global.GREY),
                                                    alignLabelWithHint: true,
                                                    enabledBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(10),
                                                        borderSide: BorderSide(
                                                          color: Color(Global.GREY),
                                                        )),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(10),
                                                        borderSide: BorderSide(
                                                          color: Color(Global.GREY),
                                                        )),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            child: Card(
                                              elevation: 0.3,
                                              shadowColor: const Color(0xffBCBCBC),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(8)
                                              ),
                                              child: SizedBox(
                                                width: 28,
                                                height: 38,
                                                child: Image.asset(Global.IC_FILTER),
                                              )
                                            ),
                                            onTap: (){},
                                          )
                                        ],
                                      ),

                                      Expanded(
                                          child: pdk.isNotEmpty ? ListView.builder(
                                            itemCount: searchPdk.length,
                                            scrollDirection: Axis.vertical,
                                            physics: const AlwaysScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemBuilder: (context, i) {
                                              final detailPage = DetailPendingPDK(
                                                searchPdk[i],
                                                state.getUser,
                                                successPostPDK: (int resMessage, BuildContext ctx) {
                                                  if (resMessage == 200) {
                                                    setState(() {
                                                      searchController.text = '';
                                                      BlocProvider.of<PDKBloc>(context).add(GetProcessPDKEvent());
                                                      BlocProvider.of<PDKBloc>(context).add(GetDonePDKEvent("oldest"));
                                                    });
                                                  }
                                                },
                                              );
                                              return InkWell(
                                                onTap: (){
                                                  Navigator.push(context, MaterialPageRoute(
                                                      builder: (context) => detailPage
                                                  ));
                                                },
                                                child: Global.getCardList(searchPdk[i].no_draft, searchPdk[i].branch, searchPdk[i].cust, searchPdk[i].date),
                                              );
                                            },
                                          ) : ListView.builder(
                                            itemCount: 1,
                                            scrollDirection: Axis.vertical,
                                            physics: const AlwaysScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemBuilder: (context, i) {
                                              return Center(
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
                                              );
                                            },
                                          )

                                      ),
                                    ],
                                  )
                                ),
                                RefreshIndicator(
                                    color: Color(Global.TOSCA),
                                    backgroundColor: Colors.white,
                                    onRefresh: () async {
                                      BlocProvider.of<PDKBloc>(context).add(GetProcessPDKEvent());
                                      BlocProvider.of<PDKBloc>(context).add(GetDonePDKEvent("oldest"));
                                    },
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 50,
                                          child: Container(
                                            margin: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                                            child: TextFormField(
                                              style: Global.getCustomFont(Global.BLACK, 14, 'medium'),
                                              maxLines: 1,
                                              controller: searchController,
                                              onChanged: (text) {
                                                filterSearchResults(text);
                                              },
                                              decoration: InputDecoration(
                                                labelText: "Search",
                                                filled: true,
                                                fillColor: Color(Global.GREY),
                                                alignLabelWithHint: true,
                                                enabledBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(10),
                                                    borderSide: BorderSide(
                                                      color: Color(Global.GREY),
                                                    )),
                                                focusedBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(10),
                                                    borderSide: BorderSide(
                                                      color: Color(Global.GREY),
                                                    )),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                            child: donePdk.isNotEmpty ? Container(
                                              margin: const EdgeInsets.only(bottom: 7),
                                              child: ListView.builder(
                                                itemCount: searchDonePdk.length,
                                                scrollDirection: Axis.vertical,
                                                shrinkWrap: true,
                                                itemBuilder: (context, i) {
                                                  final donePage = DetailDonePDK(searchDonePdk[i], state.getUser);
                                                  return InkWell(
                                                    onTap: (){
                                                      Navigator.push(context, MaterialPageRoute(
                                                          builder: (context) => donePage
                                                      ));
                                                    },
                                                    child: Global.getDoneCardList(searchDonePdk[i].kode_pelanggan, searchDonePdk[i].branch, searchDonePdk[i].cust, searchDonePdk[i].date, searchDonePdk[i].final_status),
                                                  );
                                                },
                                              ),
                                            ) : ListView.builder(
                                              itemCount: 1,
                                              scrollDirection: Axis.vertical,
                                              physics: const AlwaysScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemBuilder: (context, i) {
                                                return Center(
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
                                                            "No Processed PDK",
                                                            style: Global.getCustomFont(0xffC1C2C3, 15, 'medium'),
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                );
                                              },
                                            )
                                        ),
                                      ],
                                    )
                                )
                              ]
                            )
                          )
                        ],
                      )
                    )
                  )
                )
              ),
            )
          );
        }
        if(state is FailedUserState || state is NotLoggedInState) {
          return Login();
        }
        else {
          return Container();
        }
      }
    );
  }
}