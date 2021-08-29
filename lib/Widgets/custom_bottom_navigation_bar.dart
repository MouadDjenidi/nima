import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frino_icons/frino_icons.dart';
import 'package:nima/modules/screens/home_page.dart';
import 'package:nima/modules/screens/map_page.dart';
import 'package:nima/modules/screens/store_list.dart';
import 'package:nima/modules/screens/test.dart';
import 'package:nima/modules/screens/vendor_promo_products.dart';
import 'package:provider/provider.dart';
import 'package:nima/constants/app_constants.dart';
import 'package:nima/modules/providers/Bottom_Navigation_Bar_Provider.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  CustomBottomNavigationBar({Key key}) : super(key: key);

  @override
  _CustomBottomNavigationBar createState() => _CustomBottomNavigationBar();
}

class _CustomBottomNavigationBar extends State<CustomBottomNavigationBar> {
  Future<List<Widget>> currentTab;
  bool isShopManager = false;

  @override
  void initState() {
    super.initState();
    currentTab = currentTabList();
  }

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
      child: FutureBuilder<List<Widget>>(
        future: currentTab,
        builder: (context,  snapshot) {
          if (snapshot.hasData) {
            return  Scaffold(
              body: snapshot.data[provider.currentIndex],
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
                  isVendor == true
                      ? BottomNavigationBarItem(
                          activeIcon: Icon(
                            FrinoIcons.f_basket_2,
                            color: activeIconColor,
                          ),
                          icon: Icon(FrinoIcons.f_basket_2),
                          title: Text("Produits"))
                      : BottomNavigationBarItem(
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
            );
          }
          return Container(
            color: Colors.white,
            child: Center(
              child: Material(
                child:Text("chargement..." , style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),), 
              ),
              
              
               
            ),
          );
        },
      ),
    );
  }

  Future<List<Widget>> currentTabList() async {
    await FirebaseAuth.instance.currentUser.getIdTokenResult().then((value) => isShopManager = value.claims["shopmanager"]);
    var currentTab = [
      MyHomePage(),
      MyHomePage(),
      VendorPromoProducts(),
      //isShopManager == true ? VendorPromoProducts() : MyMapPage(),
      StoreList(),
      LogOutPage()
    ];
    return currentTab;
  }
  
}
