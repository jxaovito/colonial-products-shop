import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'carrinho.dart';
import 'endereco_screen.dart';

class CheckoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Checkout')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.cartItems.length,
              itemBuilder: (context, index) {
                final product = cart.cartItems[index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text('R\$${product.price}'),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_circle, color: Colors.red),
                    onPressed: () {
                      cart.removeFromCart(product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                '${product.name} foi removido do carrinho!')),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          Text('Total: R\$${cart.totalAmount.toStringAsFixed(2)}'),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Navegar para a tela de Endereço de Entrega
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EnderecoScreen()),
              );
            },
            child: Text('Escolher Endereço de Entrega'),
          ),
        ],
      ),
    );
  }
}
