import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:nima/Utils/custom_snack_bar.dart';
import 'package:nima/Utils/geo_location.dart';
import 'package:nima/Widgets/custom_app_bar.dart';
import 'package:nima/Widgets/custom_store_form.dart';
import 'package:nima/Widgets/custom_text.dart';
import 'package:nima/constants/app_constants.dart';
import 'package:nima/core/service/storeServ.dart';
import 'package:nima/modules/SharedPreferences/store_pref.dart';
import 'package:nima/modules/models/model_store.dart';
import 'package:nima/modules/screens/store_form_map.dart';
import 'package:nima/modules/screens/welcome_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class StoreForm extends StatefulWidget {
  @override
  _StoreForm createState() => _StoreForm();
}

class _StoreForm extends State<StoreForm> {
  StoreServ storeServ;

  final TextEditingController storeNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController geoPiontsController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController urlController = TextEditingController();

  var _storeFormKey = GlobalKey<FormState>();
  LatLng currentPosition;
  GeoLocation geoLocation;
  CustomSnackBar customSnackBar;
  bool progress = false;

  @override
  void initState() {
    super.initState();
    customSnackBar = new CustomSnackBar();
    if(FirebaseAuth.instance.currentUser != null){
       emailController.text = FirebaseAuth.instance.currentUser.email;
    }
    myCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: CustomAppBar(
          leading: Icon(
            Icons.store,
            color: Colors.black45,
            size: 25,
          ),
          actionIcons: [
            IconButton(
              icon: Icon(
                Icons.add_location,
                color: Colors.blue[400],
                size: 25,
              ),
              onPressed: () {
                storeFormMap();
              },
            ),
            IconButton(
              icon: Icon(
                Icons.restore_page_rounded,
                color: Colors.blue[400],
                size: 25,
              ),
              onPressed: () {
                resetForm();
              },
            ),
            SizedBox(
              width: 5,
            )
          ],
          title: CustomText(
            method: CustomTextAppBar(
              text: 'Nouveau magasin',
            ),
          ),
          appBar: AppBar(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: false,
          child: Column(
            children: <Widget>[
              Form(
                key: _storeFormKey,
                child: new Column(
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    CustomStoreForm(
                        storeNameController: storeNameController,
                        descriptionController: descriptionController,
                        geoPiontsController: geoPiontsController,
                        emailController: emailController,
                        phoneController: phoneController,
                        urlController: urlController),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: ButtonTheme(
                        minWidth: MediaQuery.of(context).size.width,
                        child: ButtonTheme(
                            buttonColor: Colors.blue[400],
                            minWidth: MediaQuery.of(context).size.width,
                            height: 40,
                            child: RaisedButton(
                              onPressed: () {
                                //------------------------------- new button action ------------------------------------
                                if (_storeFormKey.currentState.validate()) {
                                  newStore();
                                }
                                //------------------------------- End Of new button action -----------------------------------
                              },
                              child: Text(
                                '+ magasin',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Visibility(
                        visible: progress,
                        child: LinearProgressIndicator(
                          backgroundColor: Colors.transparent,
                          valueColor: AlwaysStoppedAnimation(Colors.blue[400]),
                          minHeight: 3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> myCurrentPosition() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      geoLocation = new GeoLocation();
      currentPosition = await geoLocation.currentPosition();
      if (currentPosition != null) {
        String address = await geoLocation.geoPointsAddress(currentPosition);
        geoPiontsController.text = address;
      }
    } else {
      customSnackBar.snackBarWarning(context, 'connexion réseau indisponible',
          Colors.blue[400].withOpacity(0.7));
    }
  }

  Future<void> newStore() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      //--------------- set store object ----------------
      bool isDefaultStore = await isDefaultStoreExists();
      Store store = new Store();
      store.storeId = null;
      store.storeName = storeNameController.text;
      if (currentPosition != null) {
        store.storeGeopointLatitude = currentPosition.latitude;
        store.storeGeopointLongitude = currentPosition.longitude;
      }
      store.storeUrl = urlController.text;
      store.storeImage = "test";
      store.description = descriptionController.text;
      store.isdefault = !isDefaultStore;
      store.email = emailController.text;
      store.phone = phoneController.text;
      store.userId = FirebaseAuth.instance.currentUser.uid;
      //-------------------------------------------------
      // print(jsonEncode(store.toJson()));
      setState(() {
        progress = true;
      });
      storeServ = new StoreServ();
      var res = await storeServ.createStore(store);
      setState(() {
        progress = false;
      });
      if (res == 200) {
        defualtIndex = 4;
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => AuthenticationWrapper(),
            ));
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Attention!"),
                content: Text("magasin n'a pas été sauvegardé !"),
                actions: [
                  TextButton(
                    child: Text("Ok"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      }
    } else {
      customSnackBar.snackBarWarning(context, 'connexion réseau indisponible',
          Colors.blue[400].withOpacity(0.7));
    }
  }

  void resetForm() {
    storeNameController.clear();
    descriptionController.clear();
    myCurrentPosition();
    emailController.text = FirebaseAuth.instance.currentUser.email;
    phoneController.clear();
    urlController.clear();
  }

  Future<void> storeFormMap() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      var res = await Permission.location.serviceStatus;
      if (res.isDisabled) {
        Location.instance.requestService();
      }
      if (res.isEnabled) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => StoreFormMap(),
            ));
      }
    } else {
      customSnackBar.snackBarWarning(context, 'connexion réseau indisponible',
          Colors.blue[400].withOpacity(0.7));
    }
  }
}
