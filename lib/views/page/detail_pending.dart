import 'package:ediscount/views/page/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

import '../../bloc/pdk/pdk_bloc.dart';
import '../../models/pdk.dart';
import '../../models/user.dart';
import '../../utils/global.dart';
import '../../widget/customer_text_field.dart';

class DetailPendingPDK extends StatefulWidget {
  PDK pdk;
  User user;
  SuccessPostPDK? successPostPDK;

  DetailPendingPDK(this.pdk, this.user, {this.successPostPDK});

  @override
  State<StatefulWidget> createState() {
    return _DetailPendingPDKPage();
  }
}

typedef SuccessPostPDK = void Function(int resultMessage, BuildContext context);

class _DetailPendingPDKPage extends State<DetailPendingPDK> {
  late List<DetailPDK> detailPDK = [];
  TextEditingController notesController = TextEditingController();
  late List<TextEditingController> listDiscController = [];
  late List<double> disc = [];
  String notes = '';
  bool _val = false;
  bool _discChanged = false;

  final currencyFormatter = NumberFormat('#,##0', 'ID');

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PDKBloc>(context).add(GetDetailPDKEvent(widget.pdk.id.toString()));
  }

  @override
  void dispose() {
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector (
        onTap: () {
      FocusScope.of(context).requestFocus(FocusNode());
    },
    child: Scaffold(
        appBar:AppBar(
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
              "PDK Detail",
              style: Global.getCustomFont(Global.WHITE, 15, 'medium')
          ),
          actions: [
            PopupMenuButton(
                itemBuilder: (context){
                  return [
                    const PopupMenuItem<int>(
                      value: 0,
                      child: Text("PDK Info"),
                    ),
                  ];
                },
                onSelected:(value){
                  if(value == 0){
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            content: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Table(
                                    columnWidths: const <int, TableColumnWidth> {
                                      0: FixedColumnWidth(90),
                                      2: FixedColumnWidth(124),
                                    },
                                    children: [
                                      TableRow(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(4),
                                              child: Text(
                                                  "Draft No.",
                                                  style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(4),
                                              child: Text(
                                                  widget.pdk.no_draft,
                                                  style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                              ),
                                            )
                                          ]
                                      ),
                                      TableRow(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(4),
                                              child: Text(
                                                  "PDK Maker",
                                                  style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(4),
                                              child: Text(
                                                  widget.pdk.maker,
                                                  style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                              ),
                                            )
                                          ]
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                    );
                  }
                }
            ),
          ],
        ),
        backgroundColor: Color(Global.BACKGROUND),
        body: BlocListener<PDKBloc, PDKBlocState>(
          listener: (context, state) {
            print(state.toString());
            if(state is LoadingPDKState) {
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
            if(state is SuccessPostApproveState) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Global.defaultModal(() {
                      Navigator.pop(context);
                      widget.successPostPDK!(200, context);
                    }, context, Global.IC_CHECK, "Approved", "Ok", false);
                  }
              );
            }
            if(state is SuccessPostRejectState) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Global.defaultModal(() {
                      widget.successPostPDK!(200, context);
                    }, context, Global.IC_CHECK, "Rejected", "Ok", false);
                  }
              );
            }
            if(state is GetDetailState) {
              setState(() {
                detailPDK = state.getPDKDetail;
                disc = [];
                listDiscController = [
                  for (int i = 0; i < detailPDK.length; i++)
                    TextEditingController()
                ];

                for(int i = 0; i < detailPDK.length; i++) {
                  listDiscController[i].text = detailPDK[i].percent_disc_rn.toString();
                  disc.add(detailPDK[i].percent_disc_rn);
                }
              });
            }
            else {
              Container();
            }
          },
          child: SingleChildScrollView(
            child: Container(
                margin: const EdgeInsets.only(top: 13, left: 19, right: 19, bottom: 13),
                child: Column(
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 1.1,
                        child: Card(
                            color: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(7),
                                    child: Table(
                                      columnWidths: const <int, TableColumnWidth> {
                                        0: FixedColumnWidth(120),
                                        1: FixedColumnWidth(178),
                                      },
                                      children: [
                                        TableRow(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(4),
                                                child: Text(
                                                    "Proposed by",
                                                    style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.all(4),
                                                child: Text(
                                                    "CABANG ${widget.pdk.branch}",
                                                    style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                ),
                                              )
                                            ]
                                        ),
                                        TableRow(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(4),
                                                child: Text(
                                                    "Date created",
                                                    style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.all(4),
                                                child: Text(
                                                    DateFormat('d MMM yyyy').format(widget.pdk.date),
                                                    style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                ),
                                              )
                                            ]
                                        ),
                                        TableRow(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(4),
                                                child: Text(
                                                    "Customer Code",
                                                    style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.all(4),
                                                child: Text(
                                                    widget.pdk.kode_pelanggan,
                                                    style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                ),
                                              )
                                            ]
                                        ),
                                        TableRow(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(4),
                                                child: Text(
                                                    "Customer Name",
                                                    style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.all(4),
                                                child: Text(
                                                    widget.pdk.cust,
                                                    style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                ),
                                              )
                                            ]
                                        ),
                                        TableRow(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(4),
                                                child: Text(
                                                    "Description",
                                                    style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.all(4),
                                                child: Text(
                                                    widget.pdk.description!,
                                                    style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                ),
                                              )
                                            ]
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                        )
                    ),
                    widget.user.role_id > 1 ? SizedBox(
                        width: MediaQuery.of(context).size.width / 1.1,
                        child: Card(
                            color: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Container(
                                padding: const EdgeInsets.all(7),
                                child: Column(
                                  children: [
                                    widget.user.role_id >= 2 ? Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        child: Table(
                                          columnWidths: const <int, TableColumnWidth> {
                                            0: FixedColumnWidth(120),
                                            1: FixedColumnWidth(178),
                                          },
                                          children: [
                                            TableRow(
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets.only(top: 4, left: 4, right: 4, bottom: 8),
                                                    child: Text(
                                                        "Approved by",
                                                        style: Global.getCustomFont(Global.DARK_GREY, 13, 'bold')
                                                    ),
                                                  ),
                                                  Container()
                                                ]
                                            ),
                                            widget.user.role_id >= 2 ? TableRow(
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets.all(4),
                                                    child: Text(
                                                        "Branch Manager",
                                                        style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: const EdgeInsets.all(4),
                                                    child: Text(
                                                        widget.pdk.approver_1,
                                                        style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                    ),
                                                  )
                                                ]
                                            ) : TableRow(),
                                            widget.user.role_id >= 2 ? TableRow(
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
                                                    child: Text(
                                                        "Notes",
                                                        style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
                                                    child: Text(
                                                        "",
                                                        style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                    ),
                                                  )
                                                ]
                                            ) : TableRow(),
                                          ],
                                        ),
                                      ),
                                    ) : Container(),
                                    widget.user.role_id >= 2 ? Container(
                                      margin: const EdgeInsets.all(7),
                                      padding: const EdgeInsets.all(7),
                                      width: MediaQuery.of(context).size.width / 1.1,
                                      decoration: BoxDecoration(
                                        color: const Color(0xffE7ECF2),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Text(
                                          widget.pdk.user_desc_1!,
                                          style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                      ),
                                    ) : Container(),

                                    widget.user.role_id >= 3 ?Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        child: Table(
                                          columnWidths: const <int, TableColumnWidth> {
                                            0: FixedColumnWidth(120),
                                            1: FixedColumnWidth(178),
                                          },
                                          children: [
                                            widget.user.role_id >= 3 ? TableRow(
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets.all(4),
                                                    child: Text(
                                                        "Otsuka Indonesia (Branch)",
                                                        style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: const EdgeInsets.all(4),
                                                    child: Text(
                                                        widget.pdk.approver_2,
                                                        style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                    ),
                                                  )
                                                ]
                                            ) : TableRow(),
                                            widget.user.role_id >= 3 ? TableRow(
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
                                                    child: Text(
                                                        "Notes",
                                                        style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
                                                    child: Text(
                                                        "",
                                                        style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                    ),
                                                  )
                                                ]
                                            ) : TableRow(),
                                          ],
                                        ),
                                      ),
                                    ) : Container(),
                                    widget.user.role_id >= 3 ? Container(
                                      margin: const EdgeInsets.all(7),
                                      padding: const EdgeInsets.all(7),
                                      width: MediaQuery.of(context).size.width / 1.1,
                                      decoration: BoxDecoration(
                                        color: const Color(0xffE7ECF2),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Text(
                                          widget.pdk.user_desc_2!,
                                          style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                      ),
                                    ) : Container(),

                                    widget.user.role_id >= 4 ?Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        child: Table(
                                          columnWidths: const <int, TableColumnWidth> {
                                            0: FixedColumnWidth(120),
                                            1: FixedColumnWidth(178),
                                          },
                                          children: [
                                            widget.user.role_id >= 4 ? TableRow(
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets.all(4),
                                                    child: Text(
                                                        "Otsuka Indonesia (Branch)",
                                                        style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: const EdgeInsets.all(4),
                                                    child: Text(
                                                        widget.pdk.approver_3,
                                                        style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                    ),
                                                  )
                                                ]
                                            ) : TableRow(),
                                            widget.user.role_id >= 4 ? TableRow(
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
                                                    child: Text(
                                                        "Notes",
                                                        style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
                                                    child: Text(
                                                        "",
                                                        style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                    ),
                                                  )
                                                ]
                                            ) : TableRow(),
                                          ],
                                        ),
                                      ),
                                    ) : Container(),
                                    widget.user.role_id >= 4 ? Container(
                                      margin: const EdgeInsets.all(7),
                                      padding: const EdgeInsets.all(7),
                                      width: MediaQuery.of(context).size.width / 1.1,
                                      decoration: BoxDecoration(
                                        color: const Color(0xffE7ECF2),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Text(
                                          widget.pdk.user_desc_3!,
                                          style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                      ),
                                    ) : Container(),

                                    widget.user.role_id >= 5 ? Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        child: Table(
                                          columnWidths: const <int, TableColumnWidth> {
                                            0: FixedColumnWidth(120),
                                            1: FixedColumnWidth(178),
                                          },
                                          children: [
                                            widget.user.role_id >= 5 ? TableRow(
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets.all(4),
                                                    child: Text(
                                                        "Otsuka Indonesia (Branch)",
                                                        style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: const EdgeInsets.all(4),
                                                    child: Text(
                                                        widget.pdk.approver_4,
                                                        style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                    ),
                                                  )
                                                ]
                                            ) : TableRow(),
                                            widget.user.role_id >= 5 ? TableRow(
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
                                                    child: Text(
                                                        "Notes",
                                                        style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
                                                    child: Text(
                                                        "",
                                                        style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                    ),
                                                  )
                                                ]
                                            ) : TableRow(),
                                          ],
                                        ),
                                      ),
                                    ) : Container(),
                                    widget.user.role_id >= 5 ? Container(
                                      margin: const EdgeInsets.all(7),
                                      padding: const EdgeInsets.all(7),
                                      width: MediaQuery.of(context).size.width / 1.1,
                                      decoration: BoxDecoration(
                                        color: const Color(0xffE7ECF2),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Text(
                                          widget.pdk.user_desc_4!,
                                          style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                      ),
                                    ) : Container(),

                                    widget.user.role_id >= 6 ?Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        child: Table(
                                          columnWidths: const <int, TableColumnWidth> {
                                            0: FixedColumnWidth(120),
                                            1: FixedColumnWidth(178),
                                          },
                                          children: [
                                            widget.user.role_id >= 6 ? TableRow(
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets.all(4),
                                                    child: Text(
                                                        "Otsuka Indonesia (Branch)",
                                                        style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: const EdgeInsets.all(4),
                                                    child: Text(
                                                        widget.pdk.approver_5,
                                                        style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                    ),
                                                  )
                                                ]
                                            ) : TableRow(),
                                            widget.user.role_id >= 6 ? TableRow(
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
                                                    child: Text(
                                                        "Notes",
                                                        style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
                                                    child: Text(
                                                        "",
                                                        style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                    ),
                                                  )
                                                ]
                                            ) : TableRow(),
                                          ],
                                        ),
                                      ),
                                    ) : Container(),
                                    widget.user.role_id >= 6 ? Container(
                                      margin: const EdgeInsets.all(7),
                                      padding: const EdgeInsets.all(7),
                                      width: MediaQuery.of(context).size.width / 1.1,
                                      decoration: BoxDecoration(
                                        color: const Color(0xffE7ECF2),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Text(
                                          widget.pdk.user_desc_5!,
                                          style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                      ),
                                    ) : Container(),



                                  ],
                                ),
                              ),
                        )
                    ) : Container(),
                    ListView.builder(
                        itemCount: detailPDK?.length,
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, i) {
                          return Card(
                              elevation: 0,
                              shadowColor: const Color(0xffBCBCBC),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Container(
                                  padding: const EdgeInsets.only(left: 8, top: 4, right: 8, bottom: 8),
                                  child: Column(
                                    children: [
                                      Container(
                                          padding: const EdgeInsets.only(top: 3),
                                          child: Table(
                                            columnWidths: const <int, TableColumnWidth> {
                                              0: FixedColumnWidth(140),
                                              2: FixedColumnWidth(124),
                                            },
                                            children: [
                                              TableRow(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Text(
                                                          "Item Product",
                                                          style: Global.getCustomFont(Global.DARK_GREY, 13, 'bold')
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.only(left: 4, top: 4, right: 4, bottom: 8),
                                                      child: Text(
                                                          detailPDK[i].prod_name,
                                                          style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                      ),
                                                    )
                                                  ]
                                              ),
                                              TableRow(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.only(top: 4, left: 4),
                                                      child: Text(
                                                          "Sales",
                                                          style: Global.getCustomFont(Global.DARK_GREY, 13, 'bold')
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Text(
                                                          "",
                                                          style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                      ),
                                                    )
                                                  ]
                                              ),
                                            ],
                                          )
                                      ),
                                      const Divider(
                                        color: Color(0xff9A9B9F),
                                        thickness: 0.2,
                                      ),
                                      Container(
                                          padding: const EdgeInsets.only(top: 3),
                                          child: Table(
                                            columnWidths: const <int, TableColumnWidth> {
                                              0: FixedColumnWidth(140),
                                              2: FixedColumnWidth(124),
                                            },
                                            children: [
                                              TableRow(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Text(
                                                          "Qty",
                                                          style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Text(
                                                          detailPDK[i].qty.toString(),
                                                          style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                      ),
                                                    )
                                                  ]
                                              ),
                                              TableRow(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Text(
                                                          "HNA",
                                                          style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Text(
                                                          currencyFormatter.format(detailPDK[i].hna).toString(),
                                                          style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                      ),
                                                    )
                                                  ]
                                              ),
                                              TableRow(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Text(
                                                          "Total Sales (Rp)",
                                                          style: Global.getCustomFont(Global.DARK_GREY, 13, 'bold')
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.only(top: 4, left: 4, right: 4, bottom: 8),
                                                      child: Text(
                                                          currencyFormatter.format(detailPDK[i].total_sales).toString(),
                                                          style: Global.getCustomFont(Global.BLACK, 13, 'bold')
                                                      ),
                                                    )
                                                  ]
                                              ),
                                              TableRow(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.only(top: 4, left: 4),
                                                      child: Text(
                                                          "Discount",
                                                          style: Global.getCustomFont(Global.DARK_GREY, 13, 'bold')
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Text(
                                                          "",
                                                          style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                      ),
                                                    )
                                                  ]
                                              ),
                                            ],
                                          )
                                      ),
                                      const Divider(
                                        color: Color(0xff9A9B9F),
                                        thickness: 0.2,
                                      ),
                                      Container(
                                          padding: const EdgeInsets.only(top: 3),
                                          child: Table(
                                            columnWidths: const <int, TableColumnWidth> {
                                              0: FixedColumnWidth(140),
                                              2: FixedColumnWidth(124),
                                            },
                                            children: [
                                              TableRow(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Text(
                                                          "Rajawali Nusindo",
                                                          style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text(
                                                              "${listDiscController[i].text} %",
                                                              style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                          ),
                                                          widget.user.role_id == 3 ? InkWell(
                                                            onTap: (){
                                                              showDialog(
                                                                context: context,
                                                                builder: (BuildContext context) {
                                                                  return AlertDialog(
                                                                    shape: const RoundedRectangleBorder(
                                                                        borderRadius: BorderRadius.all(Radius.circular(10)
                                                                        )
                                                                    ),
                                                                    content: SizedBox(
                                                                      width: 322,
                                                                      child: Column(
                                                                        mainAxisSize: MainAxisSize.min,
                                                                        children: <Widget>[
                                                                          CustomTextField(label: "Discount", controller: listDiscController[i]),
                                                                          Align(
                                                                            alignment: Alignment.center,
                                                                            child: Container(
                                                                              padding: const EdgeInsets.only(left: 18, right: 18),
                                                                              color: Colors.white,
                                                                              child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                                  children: [
                                                                                    SizedBox(
                                                                                      width: 83,
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
                                                                                          onPressed: () {
                                                                                            Navigator.of(context).pop();
                                                                                          },
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
                                                                                            setState(() {
                                                                                              _discChanged = true;
                                                                                              disc[i] = double.parse(listDiscController[i].text);
                                                                                            });
                                                                                            Navigator.of(context).pop();
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
                                                                    ),
                                                                  );
                                                                }
                                                              );
                                                            },
                                                            child: Text(
                                                                "change",
                                                                style: TextStyle(
                                                                  decoration: TextDecoration.underline,
                                                                  color: Color(Global.BLUE),
                                                                  fontSize: 13,
                                                                  fontFamily: 'book'
                                                                )
                                                            ),
                                                          ) : Container(),
                                                        ],
                                                      )

                                                    )
                                                  ]
                                              ),
                                              TableRow(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Text(
                                                          "Otsuka Indonesia",
                                                          style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Text(
                                                          "",
                                                          style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                      ),
                                                    )
                                                  ]
                                              ),
                                              TableRow(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.only(top:4, right: 4, bottom: 4, left: 20),
                                                      child: Text(
                                                          "Outlet",
                                                          style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Text(
                                                          "${detailPDK[i].percent_disc_outlet} %",
                                                          style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                      ),
                                                    )
                                                  ]
                                              ),
                                              TableRow(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.only(top:4, right: 4, bottom: 4, left: 20),
                                                      child: Text(
                                                          "Goods Bonus Conversion",
                                                          style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Text(
                                                          "${detailPDK[i].percent_disc_konversi} %",
                                                          style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                      ),
                                                    )
                                                  ]
                                              ),
                                              TableRow(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Text(
                                                          "Total Discount",
                                                          style: Global.getCustomFont(Global.DARK_GREY, 13, 'bold')
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.only(top: 4, left: 4, right: 4, bottom: 8),
                                                      child: Text(
                                                          "${double.parse(listDiscController[i].text) + detailPDK[i].percent_disc_konversi + detailPDK[i].percent_disc_outlet} %",
                                                          style: Global.getCustomFont(Global.BLACK, 13, 'bold')
                                                      ),
                                                    )
                                                  ]
                                              ),
                                            ],
                                          )
                                      ),
                                    ],
                                  )
                              )
                          );
                        }
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 1.1,
                        child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            elevation: 0,
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(7),
                                  child: TextFormField(
                                    style: Global.getCustomFont(Global.BLACK, 13, 'medium'),
                                    maxLines: 5,
                                    maxLength: 200,
                                    controller: notesController,
                                    onChanged: (text) {
                                      notes = text;
                                      setState(() {
                                        notes == "" ? _val = true : _val = false;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      labelText: "Notes",
                                      errorText: _val ? 'Notes can\'t be empty' : null,
                                      alignLabelWithHint: true,
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius .circular(10),
                                          borderSide: BorderSide()),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 18, right: 18, top: 9, bottom: 9),
                                    margin: const EdgeInsets.only(bottom: 5),
                                    color: Colors.white,
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
                                                onPressed: () {
                                                  setState(() {
                                                    notes == "" ? _val = true : _val = false;
                                                  });
                                                  if(_val == false) {
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext context) {
                                                          return Global.defaultModal(() {
                                                            Navigator.pop(context);
                                                            BlocProvider.of<PDKBloc>(context).add(
                                                                PostRejectPDKEvent(
                                                                    notesController.text,
                                                                    DateTime.now().toString(),
                                                                    widget.pdk.id,
                                                                    widget.pdk.kategori_otsuka!,
                                                                    widget.user.branch_id.toString()
                                                                )
                                                            );
                                                          }, context, Global.IC_WARNING, "Are you sure you want to reject this PDK?", "Yes", true);
                                                        }
                                                    );
                                                  }
                                                },
                                                child: Text(
                                                  "Reject",
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
                                                  setState(() {
                                                    notes == "" ? _val = true : _val = false;
                                                  });
                                                  if(_val == false) {
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext context) {
                                                          return Global.defaultModal(() {
                                                            Navigator.pop(context);
                                                            (_discChanged) ? (
                                                              widget.user.role_id == 3 ? ({
                                                                for(int i=0; i < disc.length; i++) {
                                                                  BlocProvider.of<PDKBloc>(context).add(
                                                                      PostApprovePDKEvent(
                                                                        notesController.text,
                                                                        DateTime.now().toString(),
                                                                        widget.pdk.id,
                                                                        widget.pdk.kategori_otsuka!,
                                                                        widget.pdk.branch_id,
                                                                        disc[i].toString(),
                                                                        detailPDK[i].id
                                                                      )
                                                                  )
                                                                },
                                                                _discChanged = false
                                                              }) : ({
                                                                BlocProvider.of<PDKBloc>(context).add(
                                                                    PostApprovePDKEvent(
                                                                        notesController.text,
                                                                        DateTime.now().toString(),
                                                                        widget.pdk.id,
                                                                        widget.pdk.kategori_otsuka!,
                                                                        widget.pdk.branch_id,
                                                                        '0.0',
                                                                        0
                                                                    )
                                                                ),
                                                              })
                                                            ) : (
                                                                BlocProvider.of<PDKBloc>(context).add(
                                                                    PostApprovePDKEvent(
                                                                        notesController.text,
                                                                        DateTime.now().toString(),
                                                                        widget.pdk.id,
                                                                        widget.pdk.kategori_otsuka!,
                                                                        widget.pdk.branch_id,
                                                                        '0.0',
                                                                        0
                                                                    )
                                                                )
                                                            );
                                                          }, context, Global.IC_WARNING, "Are you sure you want to approve this PDK?", "Yes", true);
                                                        }
                                                    );
                                                  }
                                                },
                                                child: const Text(
                                                  "Approve",
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
                            )
                        )
                    ),
                  ],
                )
            ),
          )
        )
      )
    );
  }

}