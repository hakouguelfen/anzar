import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/views/login_screen.dart';
import '../../features/auth/presentation/views/register_screen.dart';
import '../../features/home/presentation/views/home_screen.dart';
import '../../features/home/presentation/views/welcome_screen.dart';
import '../../features/settings/presentation/views/settings_screen.dart';

final goRouter = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: '/',
      name: "welcome",
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: '/setting',
      name: "setting",
      builder: (context, state) => const SettingScreen(),
    ),
    GoRoute(
      path: '/home',
      name: "home",
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/login',
      name: "login",
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      name: "register",
      builder: (context, state) => const RegisterScreen(),
    ),
  ],
);
