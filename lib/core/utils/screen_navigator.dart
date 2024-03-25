class ScreenNavigator {
  static void resetRoute(context) => context.popUntilRoot();
  static void replaceWith(context, screen) => context.replace(screen);
  static void goto(context, screen) => context.push(screen);
  static void goback(context) => context.maybePop();
  static void goHome(context) => context.popUntilRoot();
}
