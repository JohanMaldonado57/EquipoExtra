import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fesarmatch/accountSettingsScreen/account_settings_Screen.dart';
import 'package:fesarmatch/global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slider/carousel.dart';
import 'package:get/get.dart';

class UserDetailScreen extends StatefulWidget {

  String? userID;

  UserDetailScreen({super.key, this.userID,});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {

  String  nombre= '';
  String  edad= '';
  String  numero= '';
  String  ciudad= '';
  String  delegacion= '';
  String  descripcion= '';
  String  Quebuscas= '';

  //apariencia
  String  altura= '';
  String  peso= '';
  String  tipoCuerpo= '';

  //lifestyle
  String  bebes= '';
  String  fumas= '';
  String  ECivil= '';
  String  Hijos= '';
  String  carrera= '';
  String  trabajo= '';
  String  ViveCon= '';
  String  Intenciones= '';

  //cultura

  String  Nacionalidad= '';
  String  Educacion= '';
  String  Idioma= '';
  String  semestre = '';
  String  Orientacion = '';
  String  Comunidad = '';

  String urlImage1 = 'https://firebasestorage.googleapis.com/v0/b/fesarmatch.appspot.com/o/Place%20Holder%2F1%20(6).jpg?alt=media&token=05ad11ee-e066-4753-8309-489aafc00ca6';
  String urlImage2 = 'https://firebasestorage.googleapis.com/v0/b/fesarmatch.appspot.com/o/Place%20Holder%2F1%20(6).jpg?alt=media&token=05ad11ee-e066-4753-8309-489aafc00ca6';
  String urlImage3 = 'https://firebasestorage.googleapis.com/v0/b/fesarmatch.appspot.com/o/Place%20Holder%2F1%20(6).jpg?alt=media&token=05ad11ee-e066-4753-8309-489aafc00ca6';
  String urlImage4 = 'https://firebasestorage.googleapis.com/v0/b/fesarmatch.appspot.com/o/Place%20Holder%2F1%20(6).jpg?alt=media&token=05ad11ee-e066-4753-8309-489aafc00ca6';
  String urlImage5 = 'https://firebasestorage.googleapis.com/v0/b/fesarmatch.appspot.com/o/Place%20Holder%2F1%20(6).jpg?alt=media&token=05ad11ee-e066-4753-8309-489aafc00ca6';

  ObtenerInfoUsuario() async {
    await FirebaseFirestore.instance
        .collection("Usuarios")
        .doc(widget.userID)
        .get()
        .then((snapshot)
    {
      if(snapshot.exists)
      {
        if(snapshot.data()!["urlImage1"] !=null){
         setState(() {
           urlImage1 = snapshot.data()!["urlImage1"];
           urlImage2 = snapshot.data()!["urlImage2"];
           urlImage3 = snapshot.data()!["urlImage3"];
           urlImage4 = snapshot.data()!["urlImage4"];
           urlImage5 = snapshot.data()!["urlImage5"];
         });
        }
        setState(() {
          nombre = snapshot.data()!['nombre'] ?? '';
          edad = snapshot.data()!["Edad"].toString() ?? '';
          numero = snapshot.data()!["numero"].toString() ?? '';
          ciudad = snapshot.data()!["ciudad"] ?? '';
          delegacion = snapshot.data()!["delegacion"] ?? '';
          descripcion = snapshot.data()!["Descripcion"] ?? '';
          Quebuscas = snapshot.data()!["LoQueBuscas"] ?? '';

          altura = snapshot.data()!["Altura"] ?? '';
          peso = snapshot.data()!["peso"] ?? '';
          tipoCuerpo = snapshot.data()!["TipoCuerpo"] ?? '';

          bebes = snapshot.data()!["Bebes?"] ?? '';
          fumas= snapshot.data()!["Fumas"] ?? '';
          ECivil= snapshot.data()!["Estado Civil"] ?? '';
          Hijos= snapshot.data()!["TienesHijos"] ?? '';
          carrera= snapshot.data()!["Carrera"] ?? '';
          trabajo= snapshot.data()!["Trabajo"] ?? '';
          ViveCon= snapshot.data()!["ViveCon"] ?? '';
          Intenciones= snapshot.data()!["Intenciones"] ?? '';

          Nacionalidad= snapshot.data()!["Nacionalidad"] ?? '';
          Educacion= snapshot.data()!["Educacion"] ?? '';
          Idioma = snapshot.data()!["Idioma"] ?? '';
          semestre = snapshot.data()!["semestre"] ?? '';
          Orientacion = snapshot.data()!["Orientacion"] ?? '';

        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ObtenerInfoUsuario();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "User Profile",
          style: TextStyle(
            color: Colors.white,

          ),
        ),
        centerTitle: true,
        //automaticallyImplyLeading: widget.userID == currentUserID ? false : true,
        leading: widget.userID != currentUserID ? IconButton(
          onPressed: ()
          {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_outlined, size: 30,),
        ) : Container(),
        actions: [
          widget.userID == currentUserID ?
          Row(
            children: [
              IconButton(
                onPressed: (){
                  Get.to(AccountSettingsScreen());
                },
                icon: const Icon(
                  Icons.edit_note,
                  size: 30,
                ),
              ),
              IconButton(
                  onPressed: (){
                    FirebaseAuth.instance.signOut();
                  },
                  icon: const Icon(
                    Icons.logout,
                    size: 30,
                  ),
                ),
            ],
          ): Container(),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Carousel(
                    indicatorBarColor: Colors.purpleAccent.withOpacity(0.3),
                    autoScrollDuration:const Duration(seconds: 2),
                    animationPageDuration: const Duration(milliseconds: 500),
                    activateIndicatorColor: Colors.purple,
                    animationPageCurve: Curves.easeIn,
                    indicatorBarHeight: 30,
                    indicatorHeight: 10,
                    indicatorWidth: 10,
                    unActivatedIndicatorColor: Colors.grey,
                    stopAtEnd: false,
                    autoScroll: true,
                    items: [
                      Image.network(urlImage1, fit: BoxFit.cover,),
                      Image.network(urlImage2, fit: BoxFit.cover,),
                      Image.network(urlImage3, fit: BoxFit.cover,),
                      Image.network(urlImage4, fit: BoxFit.cover,),
                      Image.network(urlImage5, fit: BoxFit.cover,),

                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10.0,),

              //personalInfo
              const SizedBox(height: 30,),

              const Align(
                alignment: Alignment.topLeft,
                child: Text("Informacion Personal: ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,

                ),
                ),
              ),
              const Divider(
                color: Colors.white,
                thickness: 2,
              ),
              Container(
                color:Colors.black,
                padding: const EdgeInsets.all(20.0),
                child: Table(
                  children: [
                    //nombre
                    TableRow(
                      children: [
                        const Text(
                          "Nombre: ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          nombre,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ) ,
                        )
                      ],
                    ),

                    const TableRow(
                      children: [
                        Text(""),
                        Text(""),
                      ],
                    ),

                    //Edad
                    TableRow(
                      children: [
                        const Text(
                          "Edad: ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          edad,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ) ,
                        )
                      ],
                    ),

                    const TableRow(
                      children: [
                        Text(""),
                        Text(""),
                      ],
                    ),

                   //numero
                    TableRow(
                      children: [
                        const Text(
                          "numero: ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          numero,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ) ,
                        )
                      ],
                    ),

                    const TableRow(
                      children: [
                        Text(""),
                        Text(""),
                      ],
                    ),

                    //ciudad
                    TableRow(
                      children: [
                        const Text(
                          "ciudad: ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          ciudad,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ) ,
                        )
                      ],
                    ),

                    const TableRow(
                      children: [
                        Text(""),
                        Text(""),
                      ],
                    ),

                    //delegacion
                    TableRow(
                      children: [
                        const Text(
                          "Delegacion: ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          delegacion,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ) ,
                        )
                      ],
                    ),

                    const TableRow(
                      children: [
                        Text(""),
                        Text(""),
                      ],
                    ),

                    //Descripcion
                    TableRow(
                      children: [
                        const Text(
                          "Descripcion: ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          descripcion,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ) ,
                        )
                      ],
                    ),

                    const TableRow(
                      children: [
                        Text(""),
                        Text(""),
                      ],
                    ),

                    //Loquebuscas
                    TableRow(
                      children: [
                        const Text(
                          "Busca: ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          Quebuscas,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ) ,
                        )
                      ],
                    ),

                    const TableRow(
                      children: [
                        Text(""),
                        Text(""),
                      ],
                    ),

                  ],
                ),

              ),


              const SizedBox(height: 30,),

              const Align(
                alignment: Alignment.topLeft,
                child: Text("Apariencia: ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,

                  ),
                ),
              ),
              const Divider(
                color: Colors.white,
                thickness: 2,
              ),
              Container(
                color:Colors.black,
                padding: const EdgeInsets.all(20.0),
                child: Table(
                  children: [
                    ///altura
                    TableRow(
                      children: [
                        const Text(
                          "Altura:  ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          altura,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ) ,
                        ),
                      ],
                    ),
                    const TableRow(
                      children: [
                        Text(""),
                        Text(""),
                      ],
                    ),
                    //Peso
                    TableRow(
                      children: [
                        const Text(
                          "Peso: ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          peso,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ) ,
                        ),
                      ],
                    ),
                    const TableRow(
                      children: [
                        Text(""),
                        Text(""),
                      ],
                    ),
                    //Tipo cuerpo
                    TableRow(
                      children: [
                        const Text(
                          "Tipo De Cuerpo: ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          tipoCuerpo,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ) ,
                        )
                      ],
                    ),
                    const TableRow(
                      children: [
                        Text(""),
                        Text(""),
                      ],
                    ),
                  ],
                ),

              ),


              const SizedBox(height: 30,),

              const Align(
                alignment: Alignment.topLeft,
                child: Text("Estilo de Vida: ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,

                  ),
                ),
              ),
              const Divider(
                color: Colors.white,
                thickness: 2,
              ),
              Container(
                color:Colors.black,
                padding: const EdgeInsets.all(20.0),
                child: Table(
                  children: [
                    //Bebida
                    TableRow(
                      children: [
                        const Text(
                          "Tomas Alcohol: ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          bebes,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ) ,
                        )
                      ],
                    ),

                    const TableRow(
                      children: [
                        Text(""),
                        Text(""),
                      ],
                    ),

                    //fuma
                    TableRow(
                      children: [
                        const Text(
                          "Fuma: ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          fumas,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ) ,
                        )
                      ],
                    ),

                    const TableRow(
                      children: [
                        Text(""),
                        Text(""),
                      ],
                    ),

                    //ECivil
                    TableRow(
                      children: [
                        const Text(
                          "Estado Civil: ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          ECivil,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ) ,
                        )
                      ],
                    ),

                    //Hijos
                    TableRow(
                      children: [
                        const Text(
                          "Tienes Hijos?: ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          Hijos,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ) ,
                        )
                      ],
                    ),

                    //Carrera
                    TableRow(
                      children: [
                        const Text(
                          "Carrera: ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          carrera,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ) ,
                        )
                      ],
                    ),

                    //Trabajo
                    TableRow(
                      children: [
                        const Text(
                          "Trabajo: ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          trabajo,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ) ,
                        )
                      ],
                    ),
                    //Vive
                    TableRow(
                      children: [
                        const Text(
                          "Vive Con: ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          ViveCon,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ) ,
                        )
                      ],
                    ),


                    //Intenciones
                    TableRow(
                      children: [
                        const Text(
                          "Intenciones: ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          Intenciones,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ) ,
                        )
                      ],
                    ),


                  ],
                ),

              ),


              const SizedBox(height: 30,),

              const Align(
                alignment: Alignment.topLeft,
                child: Text("Cultura: ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,

                  ),
                ),
              ),
              const Divider(
                color: Colors.white,
                thickness: 2,
              ),
              Container(
                color:Colors.black,
                padding: const EdgeInsets.all(20.0),
                child: Table(
                  children: [
                    //NAC
                    TableRow(
                      children: [
                        const Text(
                          "Nacionalidad: ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          Nacionalidad,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ) ,
                        )
                      ],
                    ),

                    //Edu
                    TableRow(
                      children: [
                        const Text(
                          "Educacion: ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          Educacion,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ) ,
                        )
                      ],
                    ),

                    //Idio
                    TableRow(
                      children: [
                        const Text(
                          "Idioma: ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          Idioma,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ) ,
                        )
                      ],
                    ),

                    //Semestre
                    TableRow(
                      children: [
                        const Text(
                          "Semestre: ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          semestre,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ) ,
                        )
                      ],
                    ),

                    //Orientacion
                    TableRow(
                      children: [
                        const Text(
                          "Orientación: ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          Orientacion,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ) ,
                        )
                      ],
                    ),

                    //Orientacion
                    TableRow(
                      children: [
                        const Text(
                          "Comunidad: ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          Comunidad,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ) ,
                        )
                      ],
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
}
