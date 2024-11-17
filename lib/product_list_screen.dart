// lib/product_list_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'carrinho.dart';
import 'index.dart';
import 'checkout.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      final response = await http.get(
        Uri.parse('https://d835-191-220-146-106.ngrok-free.app/products'),
        headers: {
          'ngrok-skip-browser-warning': 'true', // Ignora a página de aviso
          'Content-Type':
              'application/json', // Garante que estamos solicitando JSON
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> productJson = json.decode(response.body);
        print('JSON recebido: $productJson');
        print(productJson); // Verifica os dados recebidos

        setState(() {
          products = productJson.map((data) => Product.fromJson(data)).toList();
        });

        print(products); // Verifica os objetos Product criados
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Erro ao buscar produtos: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar produtos.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Produtos Coloniais'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CheckoutScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text('\$${product.price}'),
            leading: Image.network(product.imageUrl),
            trailing: IconButton(
              icon: Icon(Icons.add_shopping_cart),
              onPressed: () {
                cart.addToCart(product);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content:
                          Text('${product.name} foi adicionado ao carrinho!')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
