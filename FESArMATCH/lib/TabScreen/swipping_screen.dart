
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fesarmatch/TabScreen/User_detalles_screen.dart';
import 'package:fesarmatch/controladores/controlador-perfil.dart';
import 'package:fesarmatch/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/persona.dart';

class SwippingScreen extends StatefulWidget {
  const SwippingScreen({super.key});

  @override
  State<SwippingScreen> createState() => _SwippingScreenState();
}

class _SwippingScreenState extends State<SwippingScreen> {

  ControladorPerfil controladorPerfil = Get.put(ControladorPerfil());
  String senderName = "";

  readCurrentUserData() async {
    await FirebaseFirestore.instance
        .collection("Usuarios")
        .doc(currentUserID)
        .get()
        .then((dataSnapshot){
          setState(() {
            senderName = dataSnapshot.data()!["nombre"].toString();
          });
    });
  }

  startChatInWhatsApp(String receiverPhoneN) async{
    var androidUrl= "whatsapp://send?phone=$receiverPhoneN&text= Hola Nos hemos encontrado en FESArMatch.";

    try
    {
      await launchUrl((Uri.parse(androidUrl)));
    }
    on Exception
    {
      showDialog(
        context: context,
          builder: (BuildContext context)
          {
            return AlertDialog(
              title: const Text("No se Encontro WhatsApp"),
              content: const Text("WhatsApp no esta Instalado."),
              actions: [
                TextButton(
                    onPressed: ()
                    {
                      Get.back();
                    },
                  child: const Text("OK"),
                    ),
              ],
            );
          }
      );
    }
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    readCurrentUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx((){
        return PageView.builder(
          itemCount: controladorPerfil.allUsersProfileList.length,
          controller: PageController(initialPage: 0, viewportFraction:  1),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index){
            final eachProfileInfo = controladorPerfil.allUsersProfileList[index];

            return DecoratedBox(
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage (
                      eachProfileInfo.imagenPerfil.toString(),
                    ),
                    fit: BoxFit.cover,
                  )
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(

                  children: [

                    //filter icon boton
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: IconButton(
                          onPressed: ()
                          {

                          },
                          icon: const Icon(
                            Icons.filter_list,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),

                    //user data
                    GestureDetector(
                      onTap: (){

                        controladorPerfil.ViewSentAndViewReceived(
                          eachProfileInfo.uid.toString(),
                          senderName,
                        );

                        //send user to profile Person userDetailScreen
                        Get.to(UserDetailScreen(
                          userID: eachProfileInfo.uid.toString(),));

                      },
                      child: Column(
                        children: [
                          //nombre
                          Text(
                            eachProfileInfo.nombre.toString(),
                            style: const TextStyle(
                              color: Colors.purpleAccent,
                              fontSize: 24,
                              letterSpacing: 4,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          //age n city
                          Text(
                            eachProfileInfo.edad.toString()+"•"+ eachProfileInfo.ciudad.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              letterSpacing: 4,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          //profession
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              ElevatedButton(
                                onPressed: (){},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white30,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)
                                  ),
                                ),
                                child: Text(
                                  eachProfileInfo.carrera.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),

                              const SizedBox(
                                width: 6,
                              ),

                              ElevatedButton(
                                onPressed: (){},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white30,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)
                                  ),
                                ),
                                child: Text(
                                  //TODO Cambiar religion por semestre
                                  eachProfileInfo.semestre.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          //pais y etnia
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              ElevatedButton(
                                onPressed: (){},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white30,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)
                                  ),
                                ),
                                child: Text(
                                  //TODO Cambiar por Delegacion
                                  eachProfileInfo.delegacion.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),

                              const SizedBox(
                                width: 6,
                              ),

                              ElevatedButton(
                                onPressed: (){},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white30,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)
                                  ),
                                ),
                                child: Text(
                                  //TODO: cambiar por Orienteacion
                                  eachProfileInfo.Orientacion.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),

                              const SizedBox(
                                width: 6,
                              ),

                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 14,
                    ),

                    //imagen botones
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        GestureDetector(
                          onTap: ()
                          {
                            controladorPerfil.favoriteSendAndFavoriteReceived(
                              eachProfileInfo.uid.toString(),
                              senderName,

                            );
                          },
                          child: Image.asset(
                            "images/favorito.png",
                            width: 60,
                          ),
                        ),

                        GestureDetector(
                          onTap: ()
                          {
                            startChatInWhatsApp(eachProfileInfo.numero.toString());
                          },
                          child: Image.asset(
                            "images/chat.png",
                            width: 90,
                          ),
                        ),

                        GestureDetector(
                          onTap: ()
                          {
                            controladorPerfil.likeSendAndLikeReceived(
                              eachProfileInfo.uid.toString(),
                              senderName,
                            );

                          },
                          child: Image.asset(
                            "images/likecorazon.png",
                            width: 60,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      }),

    );
  }
} 