// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

ProductToDartModel welcomeFromJson(String str) => ProductToDartModel.fromJson(json.decode(str));

String welcomeToJson(ProductToDartModel data) => json.encode(data.toJson());

class ProductToDartModel {
  ProductToDartModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory ProductToDartModel.fromJson(Map<String, dynamic> json) => ProductToDartModel(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data!.toJson(),
  };
}

class Data {
  Data({
    this.products,
  });

  List<Product>? products;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "products": List<dynamic>.from(products!.map((x) => x.toJson())),
  };
}

class Product {
  Product({
    this.prodImage,
    this.prodId,
    this.prodCode,
    this.barCode,
    this.prodName,
    this.uom,
    this.unitId,
    this.prodCombo,
    this.isFocused,
    this.groupIds,
    this.categoryIds,
    this.unitFromValue,
    this.unitToValue,
    this.uomAlternateName,
    this.uomAlternateId,
    this.underWarranty,
    this.groupId,
    this.catId,
    this.prodHsnId,
    this.prodHsnCode,
    this.prodShortName,
    this.prodPrice,
    this.prodMrp,
    this.prodBuy,
    this.prodSell,
    this.prodFreeItem,
    this.prodRkPrice,
  });

  String? prodImage;
  String? prodId;
  String? prodCode;
  String? barCode;
  String? prodName;
  String? uom;
  String? unitId;
  String? prodCombo;
  String? isFocused;
  String? groupIds;
  String? categoryIds;
  String? unitFromValue;
  String? unitToValue;
  String? uomAlternateName;
  String? uomAlternateId;
  String? underWarranty;
  String? groupId;
  String? catId;
  String? prodHsnId;
  String? prodHsnCode;
  String? prodShortName;
  String? prodPrice;
  String? prodMrp;
  String? prodBuy;
  String? prodSell;
  String? prodFreeItem;
  String? prodRkPrice;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    prodImage: json["prodImage"],
    prodId: json["prodId"],
    prodCode: json["prodCode"],
    barCode: json["barCode"],
    prodName: json["prodName"],
    uom: json["UOM"],
    unitId: json["unit_id"],
    prodCombo: json["prod_combo"],
    isFocused: json["is_focused"],
    groupIds: json["group_ids"],
    categoryIds: json["category_ids"],
    unitFromValue: json["unit_from_value"],
    unitToValue: json["unit_to_value"],
    uomAlternateName: json["uom_alternate_name"],
    uomAlternateId: json["uom_alternate_id"],
    underWarranty: json["under_warranty"],
    groupId: json["groupId"],
    catId: json["catId"],
    prodHsnId: json["prodHsnId"],
    prodHsnCode: json["prodHsnCode"],
    prodShortName: json["prodShortName"],
    prodPrice: json["prodPrice"],
    prodMrp: json["prodMrp"],
    prodBuy: json["prodBuy"],
    prodSell: json["prodSell"],
    prodFreeItem: json["prodFreeItem"],
    prodRkPrice: json["prodRkPrice"],
  );

  Map<String, dynamic> toJson() => {
    "prodImage": prodImage,
    "prodId": prodId,
    "prodCode": prodCode,
    "barCode": barCode,
    "prodName": prodName,
    "UOM": uom,
    "unit_id": unitId,
    "prod_combo": prodCombo,
    "is_focused": isFocused,
    "group_ids": groupIds,
    "category_ids": categoryIds,
    "unit_from_value": unitFromValue,
    "unit_to_value": unitToValue,
    "uom_alternate_name": uomAlternateName,
    "uom_alternate_id": uomAlternateId,
    "under_warranty": underWarranty,
    "groupId": groupId,
    "catId": catId,
    "prodHsnId": prodHsnId,
    "prodHsnCode": prodHsnCode,
    "prodShortName": prodShortName,
    "prodPrice": prodPrice,
    "prodMrp": prodMrp,
    "prodBuy": prodBuy,
    "prodSell": prodSell,
    "prodFreeItem": prodFreeItem,
    "prodRkPrice": prodRkPrice,
  };
}
