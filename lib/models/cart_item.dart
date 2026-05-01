import 'game.dart';

class CartItem {
  final Game game;
  int quantidade;

  CartItem({
    required this.game,
    this.quantidade = 1,
  });

  double get subtotal => game.preco * quantidade;
}
