import '../data/models/product_model.dart';

class AddProductState {
  final ProductModel? productModel;

  AddProductState({this.productModel});

  AddProductState copyWith({ProductModel? productModel}) => AddProductState(
        productModel: productModel ?? this.productModel,
      );
}

class GetProductFailed extends AddProductState{}