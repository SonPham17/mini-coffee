import 'package:get_it/get_it.dart';
import 'package:mini_coffee/features/order/data/product_repository.dart';

final injector = GetIt.instance;

Future<void> init() async {
  _initRepository();
}

void _initRepository() {
  injector.registerFactory(() => ProductRepositoryImpl());
}
