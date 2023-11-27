import 'package:flutter/material.dart';

import '../banco/banco.dart';

import 'PaginaUsuario.dart';

class Login extends StatelessWidget {
  //isso ta certo? credo
  //porque não funciona a entrada de texto?? sera que é a IDE online que faz isso??
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  
  var banco;

  @override
  Widget build(BuildContext context) {
     banco = Banco(falhaConexao);
    return Scaffold(
      appBar: AppBar(
        title: Text('Página de Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _loginController,
              decoration: InputDecoration(
                labelText: 'Login',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                executa(context);
               },
              child: Text('Entrar'),
            ),
          ],
        ),
      ),
    );
  }

  executa(BuildContext context) async {
    // String comando = "select id_user from tb_user where login_user='victoria' and login_pass='123'";
    String login = _loginController.text;
    String pass = _passwordController.text;
    String comando = "select id_user from tb_user where login_user='$login' and login_pass='$pass'";

    print(comando);
    // await banco?.query(comando, imprime, falhaConexao);

    await banco?.query(comando, (num_registros, result) {

          print(result);
          if(result!.length == 1){
          final primeiroRegistro = result![0];
        
          // Acessa o valor do campo "id_user"
          final userId = primeiroRegistro["tb_user"]["id_user"];
          print(userId);

            // Redirecionar para a página desejada
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PaginaUsuario(
                  login: login,
                  senha: pass,
                  idUser: userId,
                ),
              ),
            );

          }else{
            showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Erro'),
            content: Text('Usuário não existe'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
          }
        }, falhaConexao);

  }


  falhaConexao(e) {
    print("Não foi possivel conectar-se ao banco - $e");
  }
}
