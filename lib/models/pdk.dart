import 'package:json_annotation/json_annotation.dart';
part 'pdk.g.dart';

@JsonSerializable()
class PDK {
  int id;
  String? no_register;
  String branch_id;
  String kategori_otsuka;
  String kode_pelanggan;
  String supplier_id;
  String maker;
  String? description;
  DateTime date;
  String? user_approve_1;
  String? user_desc_1;
  DateTime? date_approve_1;
  String? user_approve_2;
  String? user_desc_2;
  DateTime? date_approve_2;
  String? user_approve_3;
  String? user_desc_3;
  DateTime? date_approve_3;
  String? user_approve_4;
  String? user_desc_4;
  DateTime? date_approve_4;
  String? user_approve_5;
  String? user_desc_5;
  DateTime? date_approve_5;
  String? user_approve_6;
  String? user_desc_6;
  DateTime? date_approve_6;
  bool? final_status;
  String no_draft;
  String? rm_otsuka;
  int level;
  String segmen;
  String branch;
  String maker_name;
  String approver_1;
  String approver_2;
  String approver_3;
  String approver_4;
  String approver_5;
  String approver_6;
  String cust;

  PDK({
    required this.id,
    required this.no_register,
    required this.branch_id,
    required this.kategori_otsuka,
    required this.kode_pelanggan,
    required this.supplier_id,
    required this.maker,
    this.description,
    required this.date,
    this.user_approve_1,
    this.user_desc_1,
    this.date_approve_1,
    this.user_approve_2,
    this.user_desc_2,
    this.date_approve_2,
    this.user_approve_3,
    this.user_desc_3,
    this.date_approve_3,
    this.user_approve_4,
    this.user_desc_4,
    this.date_approve_4,
    this.user_approve_5,
    this.user_desc_5,
    this.date_approve_5,
    this.user_approve_6,
    this.user_desc_6,
    this.date_approve_6,
    this.final_status,
    required this.no_draft,
    this.rm_otsuka,
    required this.level,
    required this.segmen,
    required this.branch,
    required this.maker_name,
    required this.approver_1,
    required this.approver_2,
    required this.approver_3,
    required this.approver_4,
    required this.approver_5,
    required this.approver_6,
    required this.cust
  });



  factory PDK.fromJson(Map<String, dynamic> json) => _$PDKFromJson(json);
}

@JsonSerializable()
class ListProcessResponse {
  String message;
  List<PDK> result;

  ListProcessResponse(this.message, this.result);

  factory ListProcessResponse.fromJson(Map<String, dynamic> json) => _$ListProcessResponseFromJson(json);
}

@JsonSerializable()
class ListDoneResponse {
  String message;
  List<PDK> result;

  ListDoneResponse(this.message, this.result);

  factory ListDoneResponse.fromJson(Map<String, dynamic> json) => _$ListDoneResponseFromJson(json);
}

@JsonSerializable()
class DetailPDK {
  int id;
  int id_ref;
  String kode_barang;
  int qty;
  String hna;
  String total_sales;
  String percent_disc_rn;
  String percent_disc_outlet;
  String percent_disc_konversi;
  String total_disc;
  String prod_name;

  DetailPDK({
    required this.id,
    required this.id_ref,
    required this.kode_barang,
    required this.qty,
    required this.hna,
    required this.total_sales,
    required this.percent_disc_rn,
    required this.percent_disc_outlet,
    required this.percent_disc_konversi,
    required this.total_disc,
    required this.prod_name
  });

  factory DetailPDK.fromJson(Map<String, dynamic> json) => _$DetailPDKFromJson(json);
}

@JsonSerializable()
class DetailPDKResponse {
  String message;
  List<DetailPDK> result;

  DetailPDKResponse(this.message, this.result);

  factory DetailPDKResponse.fromJson(Map<String, dynamic> json) => _$DetailPDKResponseFromJson(json);
}

@JsonSerializable()
class ApprovalResponse {
  String message;

  ApprovalResponse(this.message);

  factory ApprovalResponse.fromJson(Map<String, dynamic> json) => _$ApprovalResponseFromJson(json);
}