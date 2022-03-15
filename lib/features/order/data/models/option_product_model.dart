class OptionProductModel {
  String? name;
  bool? isRequired;
  int? minSelect;
  List<SubProductOptionModel>? listSub;

  OptionProductModel(
      {this.name, this.isRequired, this.minSelect, this.listSub});

  OptionProductModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    isRequired = json['isRequired'];
    minSelect = json['minSelect'];
    if (json['listSub'] != null) {
      listSub = <SubProductOptionModel>[];
      json['listSub'].forEach((v) {
        listSub?.add(SubProductOptionModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['isRequired'] = isRequired;
    data['minSelect'] = minSelect;
    data['listSub'] = listSub;
    return data;
  }
}

class SubProductOptionModel {
  String? name;
  double? price;
  bool? isSelected;

  SubProductOptionModel({this.name, this.price, this.isSelected});

  SubProductOptionModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    isSelected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['price'] = price;
    return data;
  }
}
