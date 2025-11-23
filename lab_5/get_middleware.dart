// file: main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    title: 'GetX Middleware Transition Example',
    initialRoute: '/',
    getPages: [
      GetPage(name: '/', page: () => FirstScreen()),
      GetPage(
        name: '/second',
        page: () => SecondScreen(),
        // Attach custom middleware
        middlewares: [MyTransitionMiddleware()],
        transition: Transition.fade, // fallback if middleware not used
      ),
    ],
  ));
}

// Custom Middleware to set a transition
class MyTransitionMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    print('Navigating to $route using custom middleware');
    return null; // continue navigation
  }

  @override
  GetPageBuilder? onPageBuildStart(GetPageBuilder? page) {
    return page;
  }

  @override
  GetPage? onPageCalled(GetPage? page) {
    print('onPageCalled: ${page?.name}');
    return page;
  }

  @override
  GetPageBuilder onPageBuild(GetPageBuilder page) {
    return () => page().obs.value;
  }

  @override
  List<Bindings>? onBindingsStart(List<Bindings>? bindings) {
    return bindings;
  }

  @override
  Route? onPageRouteStart(Route? route) {
    return route;
  }

  @override
  GetPageRoute onPageRoute(GetPageRoute route) {
    // Add custom transition here
    return GetPageRoute(
      page: route.page,
      settings: route.settings,
      transition: Transition.rightToLeftWithFade, // custom transition
      curve: Curves.easeInOut,
      transitionDuration: Duration(milliseconds: 600),
    );
  }
}

// First Screen with button to navigate
class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('First Screen')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.toNamed('/second'); // Navigate using named route
          },
          child: Text('Go to Second Screen'),
        ),
      ),
    );
  }
}

// Second Screen with back button
class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back(); // Go back
          },
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.back(); // Go back
          },
          child: Text('Go Back'),
        ),
      ),
    );
  }
}
