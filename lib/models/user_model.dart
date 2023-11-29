import 'package:cloud_firestore/cloud_firestore.dart';
 
class UserModel {
 String name;
 String password;
 
 UserModel(
     {required this.name, required this.password});
 
 Map<String, dynamic> toJson() {
   return {
     'name': name,
     'password': password,
   };
 }
 
 factory UserModel.fromDocument(DocumentSnapshot documentSnapshot) {
   String name = documentSnapshot.get('name');
   String password = documentSnapshot.get('password');
 
   return UserModel(name: name, password: password);
 }
}