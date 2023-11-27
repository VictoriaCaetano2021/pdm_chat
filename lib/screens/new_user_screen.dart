//lcriação de usuário

//igual enterRoomScren preencher duas vezes a senha
//fazer upload da foto de perfil

import 'package:flutter/material.dart';
import 'package:get/get.dart';
 
class NewUserScreen extends StatelessWidget {
 NewUserScreen({Key? key}) : super(key: key);
 
 final TextEditingController _nicknameEditingController =
     TextEditingController();
  final TextEditingController _passwordEditingController =
     TextEditingController();
 
 @override
 Widget build(BuildContext context) {
   return GestureDetector(
     onTap: () => FocusScope.of(context).unfocus(),
     child: Scaffold(
       backgroundColor: const Color(0XFF23272a),
       body: Center(
         child: Padding(
           padding: const EdgeInsets.all(12.0),
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
               const Text(
                 'Seu nikname será...',
                 style: TextStyle(fontSize: 20, color: Colors.white),
               ),
                const SizedBox(height: 12),
                _nicknameInput(),
                const SizedBox(height: 12),
                _passwordInput(),
                const SizedBox(height: 12),
                _enterButton(context),
                const SizedBox(height: 12),
                _newUserLink(context),
             ],
           ),
         ),
       ),
     ),
   );
 }
 
 Widget _nicknameInput() {
   return TextFormField(
     textInputAction: TextInputAction.done,
     controller: _nicknameEditingController,
     onChanged: (value) {},
     cursorColor: const Color(0xff9b84ec),
     style: const TextStyle(color: Colors.white),
     decoration: const InputDecoration(
       floatingLabelBehavior: FloatingLabelBehavior.never,
       contentPadding: EdgeInsets.all(20.0),
       filled: true,
       fillColor: Color(0xff2f3136),
       labelText: 'Nickname',
       suffixText: 'Nickname',
       hintStyle: TextStyle(color: Colors.white54),
       labelStyle: TextStyle(color: Colors.white54),
       enabledBorder: OutlineInputBorder(
         borderSide: BorderSide(color: Colors.black26),
       ),
       focusedBorder: OutlineInputBorder(
         borderSide: BorderSide(color: Color(0xff9b84ec), width: 1),
         borderRadius: BorderRadius.all(Radius.circular(8.0)),
       ),
       border: OutlineInputBorder(
         borderSide: BorderSide(color: Colors.red, width: 5),
         borderRadius: BorderRadius.all(Radius.circular(8.0)),
         gapPadding: 8.0,
       ),
     ),
   );
 }

 Widget _passwordInput() {
   return TextFormField(
     textInputAction: TextInputAction.done,
     controller: _passwordEditingController,
     onChanged: (value) {},
     cursorColor: const Color(0xff9b84ec),
     style: const TextStyle(color: Colors.white),
     decoration: const InputDecoration(
       floatingLabelBehavior: FloatingLabelBehavior.never,
       contentPadding: EdgeInsets.all(20.0),
       filled: true,
       fillColor: Color(0xff2f3136),
       labelText: 'Password',
       suffixText: 'Password',
       hintStyle: TextStyle(color: Colors.white54),
       labelStyle: TextStyle(color: Colors.white54),
       enabledBorder: OutlineInputBorder(
         borderSide: BorderSide(color: Colors.black26),
       ),
       focusedBorder: OutlineInputBorder(
         borderSide: BorderSide(color: Color(0xff9b84ec), width: 1),
         borderRadius: BorderRadius.all(Radius.circular(8.0)),
       ),
       border: OutlineInputBorder(
         borderSide: BorderSide(color: Colors.red, width: 5),
         borderRadius: BorderRadius.all(Radius.circular(8.0)),
         gapPadding: 8.0,
       ),
     ),
   );
 }
 
Widget _newUserLink(context) {
  return GestureDetector(
    onTap: () {
      // Navega para a tela de cadastro
      Get.toNamed('/register');
    },
    child: Text(
      'Ainda não tem uma conta? Cadastre-se!',
      style: TextStyle(fontSize: 16, color: Colors.blue),
    ),
  );
}

 Widget _enterButton(context) {
   return Row(
     children: [
       Expanded(
         child: ElevatedButton(
           onPressed: () {
             if(_passwordEditingController.text=='123456'){//senha hadcode para validar -> buscar posteriomente no firabase se o login existe
              // Utilizando GetX para navegar para a rota '/chat' e passar argumentos
              Get.toNamed('/chat', arguments: _nicknameEditingController.text, );
              _nicknameEditingController.clear();
             }
           },
           child: const Text('Entrar'),
           style: ElevatedButton.styleFrom(
             textStyle: const TextStyle(
               fontSize: 14,
               fontWeight: FontWeight.w500,
             ),
             primary: const Color(0xff9b84ec),
           ),
         ),
       ),
     ],
   );
 }
}