import 'package:flutter/material.dart';
import 'package:jitney_app/helpers/style.dart';
import 'package:jitney_app/locators/service_locator.dart';
import 'package:jitney_app/providers/user.dart';
import 'package:jitney_app/screens/home.dart';
import 'package:jitney_app/screens/login.dart';
import 'package:jitney_app/screens/splash.dart';
import 'package:provider/provider.dart';
import 'package:jitney_app/providers/app.dart';
import 'package:jitney_app/helpers/constants.dart';


void main () async{
WidgetsFlutterBinding.ensureInitialized();
setupLocator();

  return runApp(MultiProvider(
    providers: [
    ChangeNotifierProvider<AppProvider>.value(
      value: AppProvider()
      ),
    ChangeNotifierProvider.value(value: UserProvider.initialize()),
  ],
    child:MaterialApp(
      debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: orange  ),
        title: "J!tney",
        home: MyApp()),
    
  ));
}

class MyApp extends StatelessWidget {
   @override
  Widget build(BuildContext context) {
    UserProvider auth = Provider.of<UserProvider>(context);

    return FutureBuilder(
      // Initialize FlutterFire:
      future: initialization,
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
          switch (auth.status) {
            case Status.Uninitialized:
              return Splash();
            case Status.Unauthenticated:
            case Status.Authenticating:
              return LoginScreen();
            case Status.Authenticated:
              return HomeScreen();
            default:
              return LoginScreen();
          }
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