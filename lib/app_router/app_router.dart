import 'package:go_router/go_router.dart';
import 'package:quokka/screens/login/login_screen.dart';
import 'package:quokka/screens/qotd/qotd_screen.dart';
import 'package:quokka/screens/quote_search/quote_search_screen.dart';

class RouteName {
  static const login = "login";
  static const qotd = "qotd";
  static const quote_search = "/quote_search";
}

class RoutePath {
  static const login = "/login";
  static const qotd = "/qotd";
  static const quote_search = "/quote_search";
}

GoRouter appRouter({required String initialLocation}) {
  return GoRouter(
    routes: [
      GoRoute(
        name: RouteName.login,
        path: RoutePath.login,
        builder: (context, state) => const LoginBlocProvider(),
      ),
      GoRoute(
        name: RouteName.qotd,
        path: RoutePath.qotd,
        builder: (context, state) => const QotdBlocProvider(),
      ),
      GoRoute(
        name: RouteName.quote_search,
        path: RoutePath.quote_search,
        builder: (context, state) => const QuoteSearchBlocProvider(),
      ),
    ],
    initialLocation: initialLocation,
  );
}
