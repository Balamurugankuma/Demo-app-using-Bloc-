import 'package:go_router/go_router.dart';
import 'package:project_1/Features/home/presentation/view/app_drawer.dart';

import '../../Features/auth/presentaion/view/Sigin_page.dart';
import '../../Features/auth/presentaion/view/Sign_Up.dart';
import '../../Features/auth/presentaion/view/Sign_in_password.dart';
import '../../Features/auth/presentaion/view/Sign_up_password.dart';
import '../../Features/auth/presentaion/view/verify.dart';
import '../../Features/home/presentation/view/home_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(path: '/home', builder: (context, _) => const HomePage()),
      GoRoute(path: '/', builder: (context, _) => const SignInPage()),
      GoRoute(
        path: '/SignInPassword',
        builder: (context, _) => const SignInPagePassword(),
      ),
      GoRoute(path: '/SignUp', builder: (context, _) => const SignUpPage()),
      GoRoute(
        path: '/SignUpPassword',
        builder: (context, _) => const SignUpPagePassword(),
      ),
      GoRoute(path: '/Verify', builder: (context, _) => const Verify()),
      GoRoute(path: "/drawer", builder: (context, _) => const AppDrawer()),
    ],
  );
}
