import 'package:mini_coffee/features/order/data/models/option_product_model.dart';

class ProductModel {
  String? image;
  String? name;
  String? description;
  double? price;
  List<OptionProductModel>? listOptionProducts;
  int? amount;
  double? totalPrice;

  ProductModel(
      {this.name,
      this.description,
      this.price,
      this.listOptionProducts,
      this.amount,
      this.totalPrice});

  ProductModel.fromJson(Map<String, dynamic> json) {
    amount ??= 1;
    name = json['name'];
    image = json['image'];
    description = json['description'];
    price = json['price'];
    totalPrice = json['totalPrice'];
    if (json['listOptionProducts'] != null) {
      listOptionProducts = <OptionProductModel>[];
      json['listOptionProducts'].forEach((v) {
        listOptionProducts?.add(OptionProductModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['image'] = image;
    data['description'] = description;
    data['price'] = price;
    data['totalPrice'] = totalPrice;
    data['listOptionProducts'] = listOptionProducts;
    return data;
  }
}
