import 'package:flutter/material.dart';

class EnderecoScreen extends StatefulWidget {
  @override
  _EnderecoScreenState createState() => _EnderecoScreenState();
}

class _EnderecoScreenState extends State<EnderecoScreen> {
  final _telefoneController = TextEditingController();
  final _bairroController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _complementoController = TextEditingController();
  String _tempoEntrega = '';
  bool _formPreenchido = false;

  void _atualizarTempoEntrega() {
    if (_bairroController.text.isNotEmpty &&
        _enderecoController.text.isNotEmpty) {
      setState(() {
        _tempoEntrega = "Seu pedido chegará em aproximadamente 40 minutos.";
        _formPreenchido = true;
      });
    } else {
      setState(() {
        _tempoEntrega = '';
        _formPreenchido = false;
      });
    }
  }

  void _showFinalizarPedidoButton() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Método de pagamento selecionado!'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            'Pedido concluído! O Seu pedido chegará em aproximadamente 40 minutos, bom apetite!')),
                  );
                  Navigator.of(context).pop(); // Fechar o modal
                },
                child: Text('Finalizar Pedido'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Endereço de Entrega')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _telefoneController,
              decoration: InputDecoration(labelText: 'Telefone'),
              keyboardType: TextInputType.phone,
            ),
            TextField(
              controller: _bairroController,
              decoration: InputDecoration(labelText: 'Bairro'),
              onChanged: (_) => _atualizarTempoEntrega(),
            ),
            TextField(
              controller: _enderecoController,
              decoration: InputDecoration(labelText: 'Endereço'),
              onChanged: (_) => _atualizarTempoEntrega(),
            ),
            TextField(
              controller: _complementoController,
              decoration: InputDecoration(labelText: 'Complemento'),
            ),
            SizedBox(height: 20),
            if (_tempoEntrega.isNotEmpty)
              Text(_tempoEntrega,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Spacer(),
            if (_formPreenchido)
              ElevatedButton(
                onPressed: () {
                  // Navegar para a tela de pagamento
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Escolha o método de pagamento'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              title: Text('Cartão de Crédito/Débito'),
                              onTap: () {
                                Navigator.of(context).pop();
                                _showFinalizarPedidoButton();
                              },
                            ),
                            ListTile(
                              title: Text('Pix'),
                              onTap: () {
                                Navigator.of(context).pop();
                                _showFinalizarPedidoButton();
                              },
                            ),
                            ListTile(
                              title: Text('Dinheiro'),
                              onTap: () {
                                Navigator.of(context).pop();
                                _showFinalizarPedidoButton();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Text('Escolher Forma de Pagamento'),
              ),
          ],
        ),
      ),
    );
  }
}
