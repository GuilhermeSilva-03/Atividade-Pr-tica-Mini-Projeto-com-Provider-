import 'package:flutter/foundation.dart';
import '../models/game.dart';
import '../models/cart_item.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _itens = {};

  Map<String, CartItem> get itens => {..._itens};

  int get quantidadeTotal =>
      _itens.values.fold(0, (soma, item) => soma + item.quantidade);

  double get precoTotal =>
      _itens.values.fold(0.0, (soma, item) => soma + item.subtotal);

  bool contemGame(String id) => _itens.containsKey(id);

  void adicionarGame(Game game) {
    if (_itens.containsKey(game.id)) {
      _itens[game.id]!.quantidade++;
    } else {
      _itens[game.id] = CartItem(game: game);
    }
    notifyListeners();
  }

  void removerGame(String id) {
    if (!_itens.containsKey(id)) return;

    if (_itens[id]!.quantidade > 1) {
      _itens[id]!.quantidade--;
    } else {
      _itens.remove(id);
    }
    notifyListeners();
  }

  void removerTudo(String id) {
    _itens.remove(id);
    notifyListeners();
  }

  void limparCarrinho() {
    _itens.clear();
    notifyListeners();
  }
}
