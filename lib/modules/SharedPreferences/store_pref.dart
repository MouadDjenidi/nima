import 'package:firebase_auth/firebase_auth.dart';
import 'package:nima/core/service/storeServ.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> storeExists() async {
  bool isStore = false;

  await FirebaseAuth.instance.currentUser
      .getIdTokenResult()
      .then((value) => isStore = value.claims["shopmanager"]);
  if (isStore) {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String store = sharedPreferences.getString("store");
    if (store != null) {
      return true;
    } else {
      StoreServ storeServ = new StoreServ();
      var res = await storeServ.defaultUserStore();
      bool isDefaul = await isDefaultStoreExists();
      if(res == 200 && isDefaul) return true;
      return false;
    }
  } else {
    return true;
  }
}

Future<bool> isDefaultStoreExists() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String store = sharedPreferences.getString("store");
  if (store != null) {
    return true;
  } else {
    return false;
  }
}

Future<void> saveDefaultStore(String store) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString("store", store);
}

Future<void> addPreferencesAsString(String key,String value) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString(key, value);
}
