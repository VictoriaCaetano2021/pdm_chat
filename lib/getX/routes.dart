import 'package:get/get.dart';
import 'package:pdm_chat/screens/chat_screen.dart';
import 'package:pdm_chat/screens/enter_room_screen.dart';
import 'package:pdm_chat/screens/new_user_screen.dart';

appRoutes() => [
      GetPage(
        name: '/',
        page: () => EnterRoomScreen(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/chat',
        page: () => ChatScreen(),
        middlewares: [MyMiddelware()],
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/register',
        page: () => NewUserScreen(),
        middlewares: [MyMiddelware()],
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 500),
      ),
    ];

class MyMiddelware extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    print(page?.name);
    return super.onPageCalled(page);
  }
}