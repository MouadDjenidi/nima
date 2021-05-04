import 'package:flutter/material.dart';
import 'package:frino_icons/frino_icons.dart';


class CustomBottomNavigationBar extends StatefulWidget {
  CustomBottomNavigationBar({Key key}) : super(key: key);

  @override
  _CustomBottomNavigationBar createState() => _CustomBottomNavigationBar();
}

class _CustomBottomNavigationBar extends State<CustomBottomNavigationBar> {
   
   int _selectedTabIndex = 0; 

  _changeIndex(int index) {
    setState(() {
      _selectedTabIndex = index; 
    }); 
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
       margin: EdgeInsets.only(left: 2, right: 2 , bottom: 2,),
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
        child : ClipRRect(
        
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(40),
          topLeft:  Radius.circular(40),
          bottomLeft: Radius.circular(40), 
          bottomRight:Radius.circular(40), 
        ),
        
        child: BottomNavigationBar( 
        currentIndex: _selectedTabIndex, 
        onTap: _changeIndex, 
        type: BottomNavigationBarType.fixed, 
        items: [
          BottomNavigationBarItem(icon: Icon(FrinoIcons.f_home), title: Text("Accueil") ), 
          BottomNavigationBarItem(icon: Icon(FrinoIcons.f_shop), title: Text("Supérette")), 
          BottomNavigationBarItem(icon: Icon(FrinoIcons.f_mark), title: Text("Carte")), 
          BottomNavigationBarItem(icon: Icon(FrinoIcons.f_bulb), title: Text("Offre")),
          BottomNavigationBarItem(icon: Icon(FrinoIcons.f_bell), title: Text("Notification")) 
        ], 
      ),
     ),
    );
  }
}