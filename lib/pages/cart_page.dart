import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../models/cart_item.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final itens = cart.itens.values.toList();

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A2E),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          '🛒 Meu Carrinho',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          if (itens.isNotEmpty)
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    backgroundColor: const Color(0xFF1A1A2E),
                    title: const Text('Limpar carrinho',
                        style: TextStyle(color: Colors.white)),
                    content: const Text(
                      'Deseja remover todos os itens do carrinho?',
                      style: TextStyle(color: Colors.white70),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancelar',
                            style: TextStyle(color: Colors.white54)),
                      ),
                      TextButton(
                        onPressed: () {
                          cart.limparCarrinho();
                          Navigator.pop(context);
                        },
                        child: const Text('Limpar',
                            style: TextStyle(color: Color(0xFFE94560))),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Limpar',
                  style: TextStyle(color: Color(0xFFE94560))),
            ),
        ],
      ),
      body: itens.isEmpty ? _buildVazio() : _buildCarrinho(context, cart, itens),
    );
  }

  Widget _buildVazio() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('🛒', style: TextStyle(fontSize: 72)),
          SizedBox(height: 16),
          Text(
            'Seu carrinho está vazio',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Adicione games para começar!',
            style: TextStyle(color: Colors.white54),
          ),
        ],
      ),
    );
  }

  Widget _buildCarrinho(
      BuildContext context, CartProvider cart, List<CartItem> itens) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: itens.length,
            itemBuilder: (ctx, i) => _CartItemCard(item: itens[i]),
          ),
        ),
        _buildResumo(context, cart),
      ],
    );
  }

  Widget _buildResumo(BuildContext context, CartProvider cart) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color(0xFF1A1A2E),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Itens no carrinho:',
                  style: TextStyle(color: Colors.white70)),
              Text('${cart.quantidadeTotal}',
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total:',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              Text(
                'R\$ ${cart.precoTotal.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: Color(0xFF4ECCA3),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE94560),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    backgroundColor: const Color(0xFF1A1A2E),
                    title: const Text('Pedido confirmado! 🎉',
                        style: TextStyle(color: Colors.white)),
                    content: Text(
                      'Sua compra de R\$ ${cart.precoTotal.toStringAsFixed(2)} foi realizada com sucesso!',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          cart.limparCarrinho();
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: const Text('Ótimo!',
                            style: TextStyle(color: Color(0xFF4ECCA3))),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.payment, color: Colors.white),
              label: const Text(
                'Finalizar Compra',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CartItemCard extends StatelessWidget {
  final CartItem item;
  const _CartItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF533483).withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: const Color(0xFF0F3460),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(item.game.emoji,
                  style: const TextStyle(fontSize: 28)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.game.nome,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  'R\$ ${item.subtotal.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Color(0xFF4ECCA3),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              _IconBtn(
                icon: Icons.remove,
                onTap: () => cart.removerGame(item.game.id),
                color: const Color(0xFFE94560),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  '${item.quantidade}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _IconBtn(
                icon: Icons.add,
                onTap: () => cart.adicionarGame(item.game),
                color: const Color(0xFF4ECCA3),
              ),
            ],
          ),
          const SizedBox(width: 4),
          IconButton(
            onPressed: () => cart.removerTudo(item.game.id),
            icon: const Icon(Icons.delete_outline,
                color: Colors.white38, size: 20),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
}

class _IconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color color;
  const _IconBtn(
      {required this.icon, required this.onTap, required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, color: color, size: 18),
      ),
    );
  }
}
