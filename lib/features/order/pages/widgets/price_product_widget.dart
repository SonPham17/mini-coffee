import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_coffee/features/order/data/models/product_model.dart';

import '../../bloc/add_product_cubit.dart';

class PriceProduct extends StatelessWidget {
  final ProductModel? productModel;

  const PriceProduct({Key? key, this.productModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final addProductCubit = BlocProvider.of<AddProductCubit>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '\$ ${productModel!.price}',
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
              onPressed: () {
                addProductCubit.decreaseProduct();
              },
              icon: const Icon(Icons.remove_circle),
              iconSize: 35,
              color: productModel!.amount == 1 ? Colors.grey : Colors.brown),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              '${productModel!.amount}',
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add_circle),
            iconSize: 35,
            color: Colors.brown,
            onPressed: () {
              addProductCubit.increaseProduct();
            },
          ),
        ],
      ),
    );
  }
}
