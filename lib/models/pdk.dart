import 'package:json_annotation/json_annotation.dart';
part 'pdk.g.dart';

// {
// "id": 77,
// "no_register": null,
// "branch_id": "44",
// "kategori_otsuka": "S",
// "kode_pelanggan": "30000231",
// "supplier_id": "10002",
// "maker": "baguss",
// "description": "",
// "date": "2023-07-07T01:18:53.000Z",
// "user_approve_1": null,
// "user_desc_1": null,
// "date_approve_1": null,
// "user_approve_2": null,
// "user_desc_2": null,
// "date_approve_2": null,
// "user_approve_3": null,
// "user_desc_3": null,
// "date_approve_3": null,
// "user_approve_4": null,
// "user_desc_4": null,
// "date_approve_4": null,
// "user_approve_5": null,
// "user_desc_5": null,
// "date_approve_5": null,
// "user_approve_6": null,
// "user_desc_6": null,
// "date_approve_6": null,
// "final_status": null,
// "no_draft": "0005/REQ-RN/BGR/VII/2023",
// "rm_otsuka": "Tiur"
// },

@JsonSerializable()
class PDK {
  int id;
  String? no_register;
  String branch_id;
  String? kategori_otsuka;
  String kode_pelanggan;
  String supplier_id;
  String maker;
  String description;
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
  String no_draft;
  String rm_otsuka;
  String branch;
  String cust;

  PDK({
    required this.id,
    required this.no_register,
    required this.branch_id,
    this.kategori_otsuka,
    required this.kode_pelanggan,
    required this.supplier_id,
    required this.maker,
    required this.description,
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
    required this.no_draft,
    required this.rm_otsuka,
    required this.branch,
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