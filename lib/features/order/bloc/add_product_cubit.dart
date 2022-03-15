import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mini_coffee/features/order/bloc/add_product_state.dart';
import 'package:mini_coffee/features/order/data/models/option_product_model.dart';
import 'package:mini_coffee/features/order/data/product_repository.dart';

class AddProductCubit extends Cubit<AddProductState> {
  final ProductRepository productRepository;

  AddProductCubit(this.productRepository) : super(AddProductState());

  void getInfoProduct() async {
    try {
      final product = await productRepository.getInfoProduct();
      if (product != null) {
        emit(state.copyWith(productModel: product));
        calculateTotalPrice();
        emit(state.copyWith());
        return;
      }
      emit(GetProductFailed());
    } catch (e) {
      emit(GetProductFailed());
    }
  }

  void increaseProduct() {
    final product = state.productModel;
    product!.amount = (product.amount ?? 1) + 1;
    calculateTotalPrice();
    emit(state.copyWith());
  }

  void decreaseProduct() {
    final product = state.productModel;
    if (product!.amount! > 1) {
      product.amount = (product.amount ?? 1) - 1;
      calculateTotalPrice();
      emit(state.copyWith());
    }
  }

  void onChangeSelectSub(SubProductOptionModel subProductOptionModel,
      OptionProductModel optionProductModel) {
    final reqSelect = optionProductModel.minSelect ?? 1;
    int lengthSelected = optionProductModel.listSub!
        .where((e) => (e.isSelected ?? false))
        .length;
    bool preSelect = subProductOptionModel.isSelected ?? false;
    if (!preSelect) {
      subProductOptionModel.isSelected = true;
      optionProductModel.listSub?.forEach((sub) {
        if (sub != subProductOptionModel &&
            lengthSelected >= reqSelect &&
            sub.isSelected!) {
          sub.isSelected = false;
          lengthSelected--;
        }
      });
      calculateTotalPrice();
      emit(state.copyWith());
    }
  }

  void calculateTotalPrice() {
    double totalSubPrice = 0;
    state.productModel!.listOptionProducts?.forEach((option) {
      option.listSub?.forEach((sub) {
        if (sub.isSelected!) {
          totalSubPrice += sub.price ?? 0;
        }
      });
    });

    final calculatePrice =
        state.productModel!.price! * (state.productModel!.amount ?? 1) +
            totalSubPrice;
    state.productModel!.totalPrice = calculatePrice;
  }

  void addToCart() {
    bool validate = true;
    state.productModel?.listOptionProducts?.forEach((option) {
      final reqSelect = option.minSelect ?? 1;
      int lengthSelected =
          option.listSub!.where((e) => (e.isSelected ?? false)).length;
      if (reqSelect != lengthSelected && option.isRequired!) {
        validate = false;
        Fluttertoast.showToast(msg: 'You must choose $reqSelect option');
      }
    });
    if (validate) {
      Fluttertoast.showToast(msg: 'Add to cart success!');
    }
  }
}
