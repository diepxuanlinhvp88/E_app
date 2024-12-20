import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/core/app_export.dart';
import 'package:untitled/model/Cart/cart_item.dart';
import 'package:untitled/model/order/orders_model.dart';
import 'package:untitled/model/product.dart';
import 'package:untitled/presentation/detail_screen/detail_screen.dart';
import 'package:untitled/presentation/profile_screen/profile_screen.dart';
import 'package:untitled/presentation/search_screen.dart';
import '../presentation/cart_screen/cart_screen.dart';
import '../presentation/menu_screen/menu_screen.dart';
import '../presentation/orders_screen/order_screen.dart';
import '../presentation/splash_screen/splash_screen.dart';
import '../presentation/welcome_onboarding_screen/welcome_onboarding_screen.dart';
import '../presentation/sign_in_screen/sign_in_screen.dart';
import '../presentation/sign_up_screen/sign_up_screen.dart';
import '../presentation/home_screen/home_screen.dart';
import '../presentation/forgot_password_screen/forgot_password.dart';

import 'package:flutter/cupertino.dart';

class AppRoutes {
  static const String initialRoute = '/initialRoute';

  static const String splashScreen = '/splash_screen';

  static const String welcomeOnboardingScreen = '/welcome_onboarding_screen';

  static const String signInScreen = '/sign_in_screen';

  static const String homeScreen = '/home_screen';

  static const String signUpScreen = '/sign_up_screen';

  static const String forgotPasswordScreen = '/forgot_password_screen';

  static const String detailScreen = '/detail_screen';

  static const String cartScreen = '/cart_screen';

  static const String profileScreen = '/profile_screen';

  static const String menuScreen = '/menu_screen';

  static Map<String, WidgetBuilder> routes = {
    initialRoute: (context) => const SplashScreen(),
    splashScreen: (context) => const SplashScreen(),
    signInScreen: (context) => const SignInScreen(),
    homeScreen: (context) => const HomeScreen(),
    signUpScreen: (context) => const SignUpScreen(),
    welcomeOnboardingScreen: (context) => const WelcomeOnboardingScreen(),
    forgotPasswordScreen: (context) => ForgotPasswordScreen(),
    cartScreen: (context) => CartScreen(),
    profileScreen: (context) => ProfileScreen(),
    menuScreen : (context) => SearchScreen(),
  };
}
