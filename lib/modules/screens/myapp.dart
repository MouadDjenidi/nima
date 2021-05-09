import 'package:flutter/material.dart';
import 'package:nima/Widgets/custom_bottom_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:nima/modules/providers/Bottom_Navigation_Bar_Provider.dart';

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'nima',
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
     // onGenerateRoute: router.generateRoute,
      //initialRoute: HomeViewRoute,
       home: ChangeNotifierProvider<BottomNavigationBarProvider>(
        child: CustomBottomNavigationBar(),
        create: ( context) => BottomNavigationBarProvider(),
      ),
    );
  }


}
