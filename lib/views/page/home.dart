import 'package:ediscount/bloc/user/user_bloc.dart';
import 'package:ediscount/views/page/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import '../../../utils/global.dart';
import '../../../utils/global_state.dart';
import '../../bloc/user/user_state.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

final GlobalState store = GlobalState.instance;

class _HomePage extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    BlocProvider.of<UserBloc>(context).add(GetUserEvent());
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserBlocState>(
      builder: (context, state) {
        print(state.toString());
        if(state is LoadingUserState) {
          return Container(
            color: Colors.white,
            child: const Center(
              child: SpinKitDoubleBounce(
                color: Color(0xff77A2D2),
                size: 70,
              ),
            ),
          );
        }
        if (state is GetUserState) {
          store.set("name", state.getUser.nama);
          store.set("username", state.getUser.username);
          store.set("role", state.getUser.role_id);
          store.set("branch", state.getUser.branch_id);
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(95),
              child: AppBar(
                backgroundColor: Color(Global.TOSCA),
                centerTitle: false,
                automaticallyImplyLeading: false,
                toolbarHeight: 85,
                title: Container(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                            icon: const Icon(Icons.person),
                            onPressed: () {
                              print("clicked");
                            },
                          ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                              "Hello, ${state.getUser.nama}!",
                              style: Global.getCustomFont(Global.WHITE, 20, 'book')
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            backgroundColor: Color(Global.BACKGROUND),
            body: Padding(
              padding: const EdgeInsets.only(left: 20, right:20, top: 13),
              child: Column(
                children: [
                  Container(
                    height: 40,
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
                  // BlocBuilder<>()
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        Column(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: Container(
                                  padding: const EdgeInsets.only(top: 6, bottom: 6),
                                  child: Card(
                                      elevation: 0,
                                      shadowColor: const Color(0xffBCBCBC),
                                      // color: Color(color),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15)
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.only(left: 12, top: 7),
                                        child: Column(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.only(top: 3),
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Text("No. Draft: ", style: Global.getCustomFont(Global.BLACK, 14, 'bold')),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(top: 10),
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Text("date", style: Global.getCustomFont(Global.BLACK, 14, 'medium')),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(top: 10),
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Text("jumlah" + " faktur", style: Global.getCustomFont(Global.BLACK, 14, 'medium')),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(top: 10, right: 10),
                                              margin: const EdgeInsets.only(bottom: 10),
                                              child: Align(
                                                alignment: Alignment.centerRight,
                                                child: Text("jumlah" + " faktur", style: Global.getCustomFont(Global.BLACK, 14, 'medium')),
                                              ),
                                            ),
                                          ],
                                        )
                                      )
                                  )
                                )
                              ),
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
                ],
              )
            )
          );
        }
        if (state is FailedUserState || state is NotLoggedInState){
          return Login();
        } else {
          return Container();
        }
      },
    );
  }
}