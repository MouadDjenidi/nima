import 'package:flutter/material.dart';
import 'package:frino_icons/frino_icons.dart';
import 'package:provider/provider.dart';
import 'package:nima/constants/app_constants.dart';
import 'package:nima/modules/providers/Bottom_Navigation_Bar_Provider.dart';


class CustomBottomNavigationBar extends StatefulWidget {
  CustomBottomNavigationBar({Key key}) : super(key: key);

  @override
  _CustomBottomNavigationBar createState() => _CustomBottomNavigationBar();
}

class _CustomBottomNavigationBar extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BottomNavigationBarProvider>(context);
    return Container(
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 15,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Scaffold(
        body: currentTab[provider.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: provider.currentIndex,
          onTap: (index) {
            provider.currentIndex = index;
          },
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                activeIcon: Icon(
                  FrinoIcons.f_home,
                  color: activeIconColor,
                ),
                icon: Icon(FrinoIcons.f_home),
                title: Text("Accueil")),
            BottomNavigationBarItem(
                activeIcon: Icon(
                  FrinoIcons.f_shop,
                  color: activeIconColor,
                ),
                icon: Icon(FrinoIcons.f_shop),
                title: Text("Supérette")),
        //---------condition-----------        
            isVendor == true ?   
            BottomNavigationBarItem(
                activeIcon: Icon(
                  FrinoIcons.f_basket_2,
                  color: activeIconColor,
                ),
                icon: Icon(FrinoIcons.f_basket_2),
                title: Text("Produits")) :
            BottomNavigationBarItem(
                activeIcon: Icon(
                  FrinoIcons.f_mark,
                  color: activeIconColor,
                ),
                icon: Icon(FrinoIcons.f_mark),
                title: Text("Carte")),
        //-------- end codndition --------        
            BottomNavigationBarItem(
                activeIcon: Icon(
                  FrinoIcons.f_bulb,
                  color: activeIconColor,
                ),
                icon: Icon(FrinoIcons.f_bulb),
                title: Text("Offre")),
            BottomNavigationBarItem(
                activeIcon: Icon(
                  FrinoIcons.f_bell,
                  color: activeIconColor,
                ),
                icon: Icon(FrinoIcons.f_bell),
                title: Text("Notification"))
          ],
        ),
      ),
    );
  }
}
