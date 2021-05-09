import 'package:flutter/material.dart';
import 'package:nima/constants/app_constants.dart';

class BottomNavigationBarProvider with ChangeNotifier {
  int _currentIndex = defualtIndex;

  get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
