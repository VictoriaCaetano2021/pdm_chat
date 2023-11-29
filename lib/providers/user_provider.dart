import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pdm_chat/models/user_model.dart';
 
class UserProvider {
 final FirebaseFirestore firebaseFirestore;
 
 UserProvider({required this.firebaseFirestore});
 
  void createUser(String name, String password ){
      print("========2=========");

  UserModel userModel = UserModel(
    name: name,
    password: password
    );
      print("========3=========");

    firebaseFirestore.collection('users').add(userModel.toJson());
  }

Future<bool> isUser(String name, String password) async {
   QuerySnapshot<Map<String, dynamic>> userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('name', isEqualTo: name)
        .get();
      if (userSnapshot.docs.isEmpty) {
      // Nenhum documento encontrado, então podemos adicionar um novo
      print("========1=========");
      return true;
      }else {
      print("========2=========");

        return false;
      }
}

}