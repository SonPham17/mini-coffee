import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_coffee/features/order/bloc/add_product_cubit.dart';

class OptionProduct extends StatelessWidget {
  const OptionProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final addProductCubit = BlocProvider.of<AddProductCubit>(context);
    final productModel = addProductCubit.state.productModel;
    return ListView.builder(
      itemBuilder: (context, index) {
        final option = productModel!.listOptionProducts?[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                color: Colors.grey.withOpacity(0.6),
                width: double.infinity,
                padding: const EdgeInsets.only(
                    left: 15, right: 15, bottom: 25, top: 25),
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: '${option!.name ?? ''} OPTION',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: option.isRequired! ? '  (REQUIRED)' : '')
                  ]),
                )),
            option.minSelect != null && option.minSelect! > 0
                ? Container(
                    color: Colors.grey.withOpacity(0.8),
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 10, bottom: 10),
                    width: double.infinity,
                    child: Text('Please select ${option.minSelect} item',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  )
                : const SizedBox(),
            ListView.separated(
              separatorBuilder: (context, indexSub) => const Divider(),
              itemBuilder: (context, indexSub) {
                final sub = option.listSub?[indexSub];
                return GestureDetector(
                  onTap: (){
                    addProductCubit.onChangeSelectSub(sub!,option);
                  },
                  child: RadioListTile<bool>(
                    controlAffinity: ListTileControlAffinity.trailing,
                    title: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: '${sub!.name}',
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: sub.price != null && sub.price! > 0
                                ? ' (\$${sub.price})'
                                : '',
                            style: const TextStyle(color: Colors.grey))
                      ]),
                    ),
                    value: true,
                    groupValue: sub.isSelected!,
                    onChanged: null,
                  ),
                );
              },
              itemCount: option.listSub?.length ?? 0,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
            ),
          ],
        );
      },
      itemCount: productModel!.listOptionProducts?.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
    );
  }
}
