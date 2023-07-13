import 'package:ediscount/bloc/user/user_bloc.dart';
import 'package:ediscount/views/page/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import '../../../utils/global.dart';
import '../../../utils/global_state.dart';
import '../../bloc/pdk/pdk_bloc.dart';
import '../../bloc/user/user_state.dart';
import '../../models/pdk.dart';

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
    BlocProvider.of<UserBloc>(context).add(GetUserEvent());
    BlocProvider.of<PDKBloc>(context).add(GetProcessPDKEvent());
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return
      BlocBuilder<UserBloc, UserBlocState>(
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
                    margin: const EdgeInsets.only(bottom:10),
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
                                      onTap: (){},
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
                                // SingleChildScrollView(
                                //     child: Container(
                                //         padding: const EdgeInsets.only(top: 6, bottom: 6),
                                //         child: Global.getCardList(noDraft, String cabang, String cust, DateTime date)
                                //     )
                                // ),
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
            )
          );
        }
        if (state is FailedUserState || state is NotLoggedInPDKState){
          return Login();
        } else {
          return Container();
        }
      },
    );
  }
}