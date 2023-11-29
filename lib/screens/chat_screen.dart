import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
 
 import 'package:pdm_chat/providers/chat_provider.dart';
 import 'package:pdm_chat/models/message_model.dart';
 import 'package:pdm_chat/widgets/input_message.dart';
 import 'package:pdm_chat/widgets/message_bubble.dart';

 
class ChatScreen extends StatefulWidget {
 const ChatScreen({Key? key}) : super(key: key);
 
 @override
 State<ChatScreen> createState() => _ChatScreenState();
}
 
class _ChatScreenState extends State<ChatScreen> {
 final ChatProvider chatProvider =
     ChatProvider(firebaseFirestore: FirebaseFirestore.instance);
 
 final TextEditingController messageEditingController =
     TextEditingController();
 
 List<QueryDocumentSnapshot> messageList = [];
 
 final ScrollController scrollController = ScrollController();
 
 currentUser(context) => ModalRoute.of(context)?.settings.arguments as String;
 
 void sendMessage(String message) {
   if (message.isNotEmpty) {
     messageEditingController.clear();
     chatProvider.sendMessage(message.trim(), currentUser(context));
     scrollController.animateTo(0,
         duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
   }
 }
 
 @override
 Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: const Color(0XFF36393f),
     appBar: AppBar(
       centerTitle: true,
       backgroundColor: const Color(0XFF23272a),
       elevation: 1,
       title: const Text('My.chat', style: TextStyle(fontSize: 16)),
     ),
     body: Stack(
       children: <Widget>[
         Column(
           children: <Widget>[
             Flexible(
               child: StreamBuilder<QuerySnapshot>(
                 stream: chatProvider.getMessageList(),
                 builder: (BuildContext context,
                     AsyncSnapshot<QuerySnapshot> snapshot) {
                   if (snapshot.hasData) {
                     messageList = snapshot.data!.docs;
 
                     if (messageList.isNotEmpty) {
                       return ListView.builder(
                           padding: const EdgeInsets.all(10),
                           itemCount: messageList.length,
                           reverse: true,
                           controller: scrollController,
                           itemBuilder: (context, index) =>
                               _buildItem(index, messageList[index]));
                     } else {
                       return const Center(
                         child: Text('Sem mensagens...',
                             style: TextStyle(
                               color: Colors.white,
                               fontSize: 20,
                             )),
                       );
                     }
                   } else {
                     return const Center(
                       child: CircularProgressIndicator(
                         color: Colors.blue,
                       ),
                     );
                   }
                 },
               ),
             ),
             InputMessageWidget(
               messageEditingController: messageEditingController,
               handleSubmit: sendMessage,
             ),
           ],
         )
       ],
     ),
     drawer: UserProfileDrawer(),
   );
 }
 
 _buildItem(int index, DocumentSnapshot? documentSnapshot) {
   if (documentSnapshot != null) {
     final chatMessage = MessageModel.fromDocument(documentSnapshot);
     final isMe = chatMessage.author == currentUser(context);
 
     return MessageBubbleWidget(chatMessage: chatMessage, isMe: isMe);
   }
 }
}

class UserProfileDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Color(0XFF36393f),
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              'Nome do Usuário',
              style: TextStyle(color: Colors.white),
            ),
            accountEmail: Text(
              'email@example.com',
              style: TextStyle(color: Colors.white),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/user_profile_image.jpg'), // Substitua pelo caminho da imagem do usuário
            ),
            decoration: BoxDecoration(
              color: Color(0xff2f3136),
              border: Border(
                bottom: BorderSide(
                  color: Colors.black26,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
