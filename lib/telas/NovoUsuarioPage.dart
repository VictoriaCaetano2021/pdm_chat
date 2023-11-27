import 'package:flutter/material.dart';

import '../banco/banco.dart';

class NovoUsuarioPage extends StatelessWidget {
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
        title: Text('Página de Cadastro Usuário'),
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
                // executa(context);
                adicionarUsuario(context);
               },
              child: Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
  void falhaConexao(e) {
    print("Não foi possível conectar-se ao banco - $e");
  }
  // void adicionarUsuario(BuildContext context) async {
  //    // String comando = "select id_user from tb_user where login_user='victoria' and login_pass='123'";
  //   String login = _loginController.text;
  //   String pass = _passwordController.text;
  //   String comando = "insert into tb_user(login_user,login_pass) values ('$login','$pass')";

  //   Banco banco = Banco(falhaConexao);
  //   print(comando);
  //   await banco.query(comando, (numRegistros, result) {}, falhaConexao);
  //   await banco.fecha();

  // }

  void adicionarUsuario(BuildContext context) async {
  String login = _loginController.text;
  String pass = _passwordController.text;

  Banco banco = Banco(falhaConexao);

  // Verificar se o usuário já existe
  String consulta = "SELECT id_user FROM tb_user WHERE login_user = '$login'";
  await banco.query(consulta, (numRegistros, result) async {
    if (numRegistros > 0) {
      // Usuário já existe, exibir mensagem de erro
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Erro'),
            content: Text('Já existe um usuário com esse login.'),
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
    } else {
      // Usuário não existe, inserir novo usuário
      String insert = "INSERT INTO tb_user (login_user, login_pass) VALUES ('$login', '$pass')";
      print(insert);

      Banco banco2 = Banco(falhaConexao);;
      await banco2.query(insert, (numRegistros, result) {
        // Usuário inserido com sucesso, exibir mensagem de sucesso
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Sucesso'),
              content: Text('Faça login com seu novo usuário.'),
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
      }, falhaConexao);
      banco2.fecha();
    }
  }, falhaConexao);

  await banco.fecha();
}

}