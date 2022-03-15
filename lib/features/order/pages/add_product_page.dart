import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_coffee/features/order/bloc/add_product_cubit.dart';
import 'package:mini_coffee/features/order/bloc/add_product_state.dart';
import 'package:mini_coffee/features/order/pages/widgets/option_product_widget.dart';
import 'package:mini_coffee/features/order/pages/widgets/price_product_widget.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<AddProductCubit>(context).getInfoProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AddProductCubit, AddProductState>(
        builder: (context, state) {
          if (state.productModel == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is GetProductFailed) {
            return const Center(
              child: Text('Get Product Error'),
            );
          }

          final product = state.productModel!;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Image.network(product.image ?? '',
                        width: double.infinity, fit: BoxFit.cover),
                    IconButton(
                      icon: Container(
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.grey,
                        ),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30,bottom: 15),
                  child: Text(
                    product.name ?? '',
                    style: const TextStyle(fontSize: 23),
                  ),
                ),
                Text(
                  product.description ?? '',
                  style: const TextStyle(fontSize: 13),
                ),
                const SizedBox(height: 20),
                const Divider(),
                PriceProduct(
                  productModel: state.productModel,
                ),
                OptionProduct(),
                GestureDetector(
                  onTap: (){
                    BlocProvider.of<AddProductCubit>(context).addToCart();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 20,right: 20,top: 40,bottom: 20),
                    padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: Colors.brown
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.shopping_cart,color: Colors.white,),
                        Expanded(child: Center(child: Text('ADD ${state.productModel!.amount} TO CART',style: const TextStyle(color: Colors.white),))),
                        Text('\$ ${state.productModel!.totalPrice ?? 0}',style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
