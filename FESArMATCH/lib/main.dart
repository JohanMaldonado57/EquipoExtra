import 'package:fesarmatch/ACCESO/login.dart';
import 'package:fesarmatch/controladores/ControlDeAutenticacion.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyBO6Y32tN5RzQZMD76QWTAu75q3oXjtpN8",
        appId: "1:428993682155:android:13a12a33b717bd05157cae",
        messagingSenderId: "428993682155",
        projectId: "fesarmatch",
        storageBucket: 'fesarmatch.appspot.com'
    )
  ).then((value){
    Get.put(AuthenticationController());
  } );

  runApp(const MyApp());

}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'FESrMATCH',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.transparent,
    ),
      home: Container (
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purpleAccent.shade100, Colors.purple],
          ),
        ),
        child:  pantallalogin(), //Seleccion de pantalla de inicio en este caso login
      )

    );
  }
}

