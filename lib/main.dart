import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_coffee/features/order/bloc/add_product_cubit.dart';
import 'package:mini_coffee/features/order/data/product_repository.dart';
import 'package:mini_coffee/injector_container.dart' as di;

import 'features/order/pages/add_product_page.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<AddProductCubit>(
          create: (context) =>
              AddProductCubit(di.injector<ProductRepositoryImpl>()),
          child: const AddProductPage()),
    );
  }
}
