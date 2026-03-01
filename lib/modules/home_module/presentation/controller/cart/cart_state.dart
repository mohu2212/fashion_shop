import 'package:fashion_shop/modules/home_module/domain/entity/cart_item_entity.dart';

class CartState {
  final List<CartItemEntity> items;

  const CartState({this.items = const []});

  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice => items.fold(0, (sum, item) => sum + item.totalPrice);

  CartState copyWith({List<CartItemEntity>? items}) {
    return CartState(items: items ?? this.items);
  }
}
