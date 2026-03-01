import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fashion_shop/modules/home_module/domain/entity/product_entity.dart';
import 'package:fashion_shop/modules/home_module/domain/entity/cart_item_entity.dart';
import 'package:fashion_shop/modules/home_module/presentation/controller/cart/cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState());

  void addToCart(ProductEntity product) {
    final items = List<CartItemEntity>.from(state.items);
    final index = items.indexWhere((e) => e.product.id == product.id);

    if (index != -1) {
      items[index] = items[index].copyWith(quantity: items[index].quantity + 1);
    } else {
      items.add(CartItemEntity(product: product));
    }

    emit(state.copyWith(items: items));
  }

  void removeFromCart(int productId) {
    final items = state.items.where((e) => e.product.id != productId).toList();
    emit(state.copyWith(items: items));
  }

  void updateQuantity(int productId, int quantity) {
    if (quantity <= 0) {
      removeFromCart(productId);
      return;
    }

    final items = List<CartItemEntity>.from(state.items);
    final index = items.indexWhere((e) => e.product.id == productId);

    if (index != -1) {
      items[index] = items[index].copyWith(quantity: quantity);
      emit(state.copyWith(items: items));
    }
  }

  void clearCart() {
    emit(const CartState());
  }
}
