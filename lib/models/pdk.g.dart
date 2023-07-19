// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pdk.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PDK _$PDKFromJson(Map<String, dynamic> json) => PDK(
      id: json['id'] as int,
      no_register: json['no_register'] as String?,
      branch_id: json['branch_id'] as String,
      kategori_otsuka: json['kategori_otsuka'] as String?,
      kode_pelanggan: json['kode_pelanggan'] as String,
      supplier_id: json['supplier_id'] as String,
      maker: json['maker'] as String,
      description: json['description'] as String?,
      date: DateTime.parse(json['date'] as String),
      user_approve_1: json['user_approve_1'] as String?,
      user_desc_1: json['user_desc_1'] as String?,
      date_approve_1: json['date_approve_1'] == null
          ? null
          : DateTime.parse(json['date_approve_1'] as String),
      user_approve_2: json['user_approve_2'] as String?,
      user_desc_2: json['user_desc_2'] as String?,
      date_approve_2: json['date_approve_2'] == null
          ? null
          : DateTime.parse(json['date_approve_2'] as String),
      user_approve_3: json['user_approve_3'] as String?,
      user_desc_3: json['user_desc_3'] as String?,
      date_approve_3: json['date_approve_3'] == null
          ? null
          : DateTime.parse(json['date_approve_3'] as String),
      user_approve_4: json['user_approve_4'] as String?,
      user_desc_4: json['user_desc_4'] as String?,
      date_approve_4: json['date_approve_4'] == null
          ? null
          : DateTime.parse(json['date_approve_4'] as String),
      user_approve_5: json['user_approve_5'] as String?,
      user_desc_5: json['user_desc_5'] as String?,
      date_approve_5: json['date_approve_5'] == null
          ? null
          : DateTime.parse(json['date_approve_5'] as String),
      user_approve_6: json['user_approve_6'] as String?,
      user_desc_6: json['user_desc_6'] as String?,
      date_approve_6: json['date_approve_6'] == null
          ? null
          : DateTime.parse(json['date_approve_6'] as String),
      final_status: json['final_status'] as bool?,
      no_draft: json['no_draft'] as String,
      rm_otsuka: json['rm_otsuka'] as String?,
      branch: json['branch'] as String,
      maker_name: json['maker_name'] as String,
      approver_1: json['approver_1'] as String,
      approver_2: json['approver_2'] as String,
      approver_3: json['approver_3'] as String,
      approver_4: json['approver_4'] as String,
      approver_5: json['approver_5'] as String,
      approver_6: json['approver_6'] as String,
      cust: json['cust'] as String,
    );

Map<String, dynamic> _$PDKToJson(PDK instance) => <String, dynamic>{
      'id': instance.id,
      'no_register': instance.no_register,
      'branch_id': instance.branch_id,
      'kategori_otsuka': instance.kategori_otsuka,
      'kode_pelanggan': instance.kode_pelanggan,
      'supplier_id': instance.supplier_id,
      'maker': instance.maker,
      'description': instance.description,
      'date': instance.date.toIso8601String(),
      'user_approve_1': instance.user_approve_1,
      'user_desc_1': instance.user_desc_1,
      'date_approve_1': instance.date_approve_1?.toIso8601String(),
      'user_approve_2': instance.user_approve_2,
      'user_desc_2': instance.user_desc_2,
      'date_approve_2': instance.date_approve_2?.toIso8601String(),
      'user_approve_3': instance.user_approve_3,
      'user_desc_3': instance.user_desc_3,
      'date_approve_3': instance.date_approve_3?.toIso8601String(),
      'user_approve_4': instance.user_approve_4,
      'user_desc_4': instance.user_desc_4,
      'date_approve_4': instance.date_approve_4?.toIso8601String(),
      'user_approve_5': instance.user_approve_5,
      'user_desc_5': instance.user_desc_5,
      'date_approve_5': instance.date_approve_5?.toIso8601String(),
      'user_approve_6': instance.user_approve_6,
      'user_desc_6': instance.user_desc_6,
      'date_approve_6': instance.date_approve_6?.toIso8601String(),
      'final_status': instance.final_status,
      'no_draft': instance.no_draft,
      'rm_otsuka': instance.rm_otsuka,
      'branch': instance.branch,
      'maker_name': instance.maker_name,
      'approver_1': instance.approver_1,
      'approver_2': instance.approver_2,
      'approver_3': instance.approver_3,
      'approver_4': instance.approver_4,
      'approver_5': instance.approver_5,
      'approver_6': instance.approver_6,
      'cust': instance.cust,
    };

ListProcessResponse _$ListProcessResponseFromJson(Map<String, dynamic> json) =>
    ListProcessResponse(
      json['message'] as String,
      (json['result'] as List<dynamic>)
          .map((e) => PDK.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListProcessResponseToJson(
        ListProcessResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'result': instance.result,
    };

ListDoneResponse _$ListDoneResponseFromJson(Map<String, dynamic> json) =>
    ListDoneResponse(
      json['message'] as String,
      (json['result'] as List<dynamic>)
          .map((e) => PDK.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListDoneResponseToJson(ListDoneResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'result': instance.result,
    };

DetailPDK _$DetailPDKFromJson(Map<String, dynamic> json) => DetailPDK(
      id: json['id'] as int,
      id_ref: json['id_ref'] as int,
      kode_barang: json['kode_barang'] as String,
      qty: (json['qty'] as num).toDouble(),
      hna: (json['hna'] as num).toDouble(),
      total_sales: (json['total_sales'] as num).toDouble(),
      percent_disc_rn: (json['percent_disc_rn'] as num).toDouble(),
      percent_disc_outlet: (json['percent_disc_outlet'] as num).toDouble(),
      percent_disc_konversi: (json['percent_disc_konversi'] as num).toDouble(),
      total_disc: (json['total_disc'] as num).toDouble(),
      prod_name: json['prod_name'] as String,
    );

Map<String, dynamic> _$DetailPDKToJson(DetailPDK instance) => <String, dynamic>{
      'id': instance.id,
      'id_ref': instance.id_ref,
      'kode_barang': instance.kode_barang,
      'qty': instance.qty,
      'hna': instance.hna,
      'total_sales': instance.total_sales,
      'percent_disc_rn': instance.percent_disc_rn,
      'percent_disc_outlet': instance.percent_disc_outlet,
      'percent_disc_konversi': instance.percent_disc_konversi,
      'total_disc': instance.total_disc,
      'prod_name': instance.prod_name,
    };

DetailPDKResponse _$DetailPDKResponseFromJson(Map<String, dynamic> json) =>
    DetailPDKResponse(
      json['message'] as String,
      (json['result'] as List<dynamic>)
          .map((e) => DetailPDK.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DetailPDKResponseToJson(DetailPDKResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'result': instance.result,
    };

ApprovalResponse _$ApprovalResponseFromJson(Map<String, dynamic> json) =>
    ApprovalResponse(
      json['message'] as String,
    );

Map<String, dynamic> _$ApprovalResponseToJson(ApprovalResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
    };
