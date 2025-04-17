import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

 
  Stream<String> getloadingMessages(){
     final messages = <String>[
    'Carregando Filmes',   
    'Carregando Informações',
    'Carregando Filmes populares',
    'Isto está demorando mais que o esperado :('
    ];

    return Stream.periodic(const Duration(seconds: 1), (step) => messages[step]).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Espere uns segundos..."),
        const SizedBox(height: 10,),
        const CircularProgressIndicator(strokeWidth: 2,),
        const SizedBox(height: 10,),

        StreamBuilder(
        stream: getloadingMessages(),
        builder: (context, snapshot) {
          if(!snapshot.hasData) return const Text("Carregando teste...");

          return Text(snapshot.data!);
        })
      ],
    ));
  }
}