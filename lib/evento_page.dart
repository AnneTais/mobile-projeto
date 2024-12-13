import 'package:flutter/material.dart';

class EventoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Evento'),
      ),
      body: Column(
        children: [
          // Imagem do evento
          Image.network(
            'https://via.placeholder.com/600x300', // URL da imagem do evento
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),

          SizedBox(height: 16), // Espaçamento

          // Título/descrição do evento
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Descrição do Evento',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          Spacer(), // Preenche o espaço restante

          // Botões
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Ação para visualizar a programação
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventProgramScreen(),
                      ),
                    );
                  },
                  child: Text('Visualizar Programação'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50), // Largura total
                  ),
                ),

                SizedBox(height: 16), // Espaçamento entre os botões

                ElevatedButton(
                  onPressed: () {
                    // Ação para inscrever-se no evento
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Inscrição realizada com sucesso!'),
                      ),
                    );
                  },
                  child: Text('Inscrever-se no Evento'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50), // Largura total
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EventProgramScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Programação do Evento'),
      ),
      body: Center(
        child: Text('Aqui vai a programação do evento.'),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: EventoPage(),
  ));
}
