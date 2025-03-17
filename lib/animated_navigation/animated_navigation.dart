import 'package:emerald_beauty/routes/apps_routes.dart';
import 'package:flutter/material.dart';

class AnimatedNavigation {
  static PageRouteBuilder bottomSlide(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 600),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0); // Start from the bottom
        const end = Offset.zero; // End at the original position
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  static PageRouteBuilder bloomNavigation(BuildContext context,
      {String? routeName, Widget? page, Object? arguments}) {
    // If routeName is provided, use it, otherwise, use the page widget directly
    final builder = routeName != null
        ? AppsRoutes.routes[routeName]
        : (page != null ? (BuildContext context) => page : null);

    if (builder == null) {
      throw Exception("Route not found or page widget not provided.");
    }

    return PageRouteBuilder(
      transitionDuration:
          const Duration(milliseconds: 600), // Animation duration
      pageBuilder: (context, animation, secondaryAnimation) {
        // If routeName is used, build from AppRoutes.routes, otherwise, return the widget directly
        return routeName != null ? builder(context) : page!;
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = 0.0;
        const end = 1.0;
        const curve = Curves.easeInOut;

        var tween = Tween<double>(begin: begin, end: end)
            .chain(CurveTween(curve: curve));
        var fadeAnimation = animation.drive(tween);

        return FadeTransition(
          opacity: fadeAnimation,
          child: ScaleTransition(
            scale: animation.drive(tween),
            child: child,
          ),
        );
      },
    );
  }
}
