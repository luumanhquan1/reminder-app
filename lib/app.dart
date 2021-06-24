import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ghichu/routes.dart';
import 'common/constants/route_constants.dart';
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String get initialRoute {
    return RouteList.homePage;
  }
  @override
  Widget build(BuildContext context) {
     return ScreenUtilInit(
      designSize: Size(414, 896),
      builder: () => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textSelectionHandleColor: Colors.amberAccent,
            fontFamily: 'MS'),

        routes: Routes.getAll(),
        initialRoute: initialRoute,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
  @override
  void dispose() {

    super.dispose();
  }
}


