import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shopping/features/cart/data/repository/cart_item_repository_impl.dart';
import 'package:shopping/features/cart/domain/repository/cart_item_repository.dart';
import 'package:shopping/features/cart/presentation/notifier/cart_notifier.dart';

final cartBoxProvider = Provider<Box>((ref) {
  return Hive.box('cart');
});

final cartRepositoryProvider = Provider<CartItemRepository>((ref) {
  final cartBox = ref.watch(cartBoxProvider);
  return CartItemRepositoryImpl(cartBox);
});

final cartNotifierProvider =
    StateNotifierProvider<CartNotifier, CartState>((ref) {
  final repository = ref.watch(cartRepositoryProvider);
  return CartNotifier(repository);
});
