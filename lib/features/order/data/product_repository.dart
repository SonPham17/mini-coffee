import 'package:mini_coffee/core/exceptions/timeout_exception.dart';
import 'package:mini_coffee/features/order/data/models/product_model.dart';

abstract class ProductRepository {
  Future<ProductModel?> getInfoProduct();
}

class ProductRepositoryImpl implements ProductRepository {
  @override
  Future<ProductModel?> getInfoProduct() async {
    try {
      // call api
      await Future.delayed(const Duration(seconds: 3));

      final productModel = ProductModel.fromJson(mockupJson);

      return productModel;
    } on TimeOutException catch (e) {
      print(e);
    }
    return null;
  }
}

final mockupJson =  {
  'name': 'Flat White',
  'image': 'https://media-cldnry.s-nbcnews.com/image/upload/t_nbcnews-fp-1200-630,f_auto,q_auto:best/newscms/2019_33/2203981/171026-better-coffee-boost-se-329p.jpg',
  'description': 'Freshly-ground beans and steamed milk',
  'price': 125,
  'listOptionProducts': [
    {
      'name': 'MILK',
      'isRequired': true,
      'minSelect': 1,
      'listSub': [
        {'name': 'Full Milk', 'price': 0},
        {'name': 'Skim Milk', 'price': 0},
        {'name': 'Soy Milk', 'price': 20}
      ]
    }
  ]
};
