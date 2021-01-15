import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jitney_app/providers/user.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:jitney_app/screens/home.dart';
import 'package:provider/provider.dart';
import 'package:jitney_app/providers/app.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//import 'package:jitney/helpers/constants.dart';


void main () async{
WidgetsFlutterBinding.ensureInitialized();
  return runApp(MultiProvider(
    providers: [
    ChangeNotifierProvider<AppProvider>.value(
      value: AppProvider.initialize()
      ),
    ChangeNotifierProvider.value(value: UserProvider.initialize()),
  ],
    child:MaterialApp(
      debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.yellow,
        ),
        title: "J!tney",
        home: MyApp()),
    
  ));
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("check if any error occured")],
            ),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return HomeScreen(title: 'J!tney');
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [CircularProgressIndicator()],
          ),
        );
      },
    );
  }


}