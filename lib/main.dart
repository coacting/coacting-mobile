import 'dart:async';
import 'package:coacting/push_notifications.dart';
import 'package:coacting/routes.dart';
import 'package:coacting/views/HomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';

const MaterialColor caBlue =
const MaterialColor(0xFF1B57A7, const <int, Color>{
  50: const Color.fromRGBO(27,87,167, 1),
  100: const Color.fromRGBO(27,87,167, 1),
  200: const Color.fromRGBO(27,87,167, 1),
  300: const Color.fromRGBO(27,87,167, 1),
  400: const Color.fromRGBO(27,87,167, 1),
  500: const Color.fromRGBO(27,87,167, 1),
  600: const Color.fromRGBO(27,87,167, 1),
  700: const Color.fromRGBO(27,87,167, 1),
  800: const Color.fromRGBO(27,87,167, 1),
  900: const Color.fromRGBO(27,87,167, 1),
});

void main() async{
//  PushNotificationsManager().init();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: caBlue,
    ),
    initialRoute: '/',
    routes: routes,
  ));
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{
  var _connectionStatus = 'Checking Internet Connection';
  Connectivity connectivity;
  StreamSubscription<ConnectivityResult> subscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connectivity = new Connectivity();
    subscription =
        connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
          _connectionStatus = result.toString();
          if (result == ConnectivityResult.wifi ||
              result == ConnectivityResult.mobile) {
            _connectionStatus = 'Powered By NexusHub Inc.';
            Timer(
                Duration(
                    seconds: 3),
                    ()=>Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                )
            );
          }
          else{
            _connectionStatus = 'Internet Unavailable. Please Try Again!';
          }
          setState(() {});
        });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage('assets/images/app_background.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset('assets/images/coacting_logo_ko.png',
                        scale: 5,
                      ),
                      Text(
                        'CoActing.Org',
                        style: TextStyle(
                          color: Colors.white,
                          height: 2,
                          fontSize: 30.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 20.0)
                    ),
                    Text(
                      '$_connectionStatus',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
