import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fesarmatch/HomeScreen/home_screen.dart';
import 'package:fesarmatch/global.dart';
import 'package:fesarmatch/widgets/TextField.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({super.key});

  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {

  bool uploading = false, next = false;
  final List<File> _image = [];
  List<String> urlList = [];
  double val = 0;

  TextEditingController nombretextEditingController = TextEditingController();
  TextEditingController EdadtextEditingController = TextEditingController();
  TextEditingController NumerotextEditingController = TextEditingController();
  TextEditingController CiudadtextEditingController = TextEditingController();
  TextEditingController delegaciontextEditingController = TextEditingController();
  TextEditingController DESCRIPCIONtextEditingController = TextEditingController();
  TextEditingController BUSCANDOAtextEditingController = TextEditingController();
  //FISICO
  TextEditingController AlturatextEditingController = TextEditingController();
  TextEditingController PesotextEditingController = TextEditingController();
  TextEditingController tipodecuerpotextEditingController = TextEditingController();
  //ESTILO DE VIDA
  TextEditingController BebetextEditingController = TextEditingController();
  TextEditingController fumatextEditingController = TextEditingController();
  TextEditingController estadoCiviltextEditingController = TextEditingController();
  TextEditingController HijostextEditingController = TextEditingController();
  TextEditingController carreratextEditingController = TextEditingController();
  TextEditingController trabajotextEditingController = TextEditingController();
  TextEditingController ViviendoContextEditingController = TextEditingController();
  TextEditingController IntencionesheadingtextEditingController = TextEditingController();
  //CULTURA
  TextEditingController NacionalidadtextEditingController = TextEditingController();
  TextEditingController EducaciontextEditingController = TextEditingController();
  TextEditingController IdiomastextEditingController = TextEditingController();
  TextEditingController semestretextEditingController = TextEditingController();
  TextEditingController OrientaciontextEditingController = TextEditingController();
  TextEditingController ComunidadtextEditingController = TextEditingController();


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

  chooseImage() async{
    XFile ? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image.add(File(pickedFile!.path));
    });
  }

  uploadImages() async
  {
    int i = 1;
    for(var img in _image){
      setState(() {
        val = i / _image.length;
      });
      var refImages = FirebaseStorage.instance
      .ref()
      .child("images/${DateTime.now().millisecondsSinceEpoch.toString()}.jpg");

      await refImages.putFile(img)
      .whenComplete(() async
      {
       await refImages.getDownloadURL()
       .then((urlImage)
       {
         urlList.add(urlImage);
         i++;
       });
      });
    }
  }

  retrieveUserData() async
  {
    await FirebaseFirestore.instance
        .collection("Usuarios")
        .doc(currentUserID)
        .get()
        .then((snapshot)
    {
      if(snapshot.exists)
      {
        setState(() {

          nombre = snapshot.data()!['nombre'] ?? '';
          nombretextEditingController.text = nombre;
          edad = snapshot.data()!["Edad"].toString() ?? '';
          EdadtextEditingController.text = edad;
          numero = snapshot.data()!["numero"].toString() ?? '';
          NumerotextEditingController.text = numero;
          ciudad = snapshot.data()!["ciudad"] ?? '';
          CiudadtextEditingController.text = ciudad;
          delegacion = snapshot.data()!["delegacion"] ?? '';
          delegaciontextEditingController.text = delegacion;
          descripcion = snapshot.data()!["Descripcion"] ?? '';
          DESCRIPCIONtextEditingController.text = descripcion;
          Quebuscas = snapshot.data()!["LoQueBuscas"] ?? '';
          BUSCANDOAtextEditingController.text = Quebuscas;

          altura = snapshot.data()!["Altura"] ?? '';
          AlturatextEditingController.text = altura;
          peso = snapshot.data()!["peso"] ?? '';
          PesotextEditingController.text = peso;
          tipoCuerpo = snapshot.data()!["TipoCuerpo"] ?? '';
          tipodecuerpotextEditingController.text = tipoCuerpo;

          bebes = snapshot.data()!["Bebes?"] ?? '';
          BebetextEditingController.text = bebes;
          fumas= snapshot.data()!["Fumas"] ?? '';
          fumatextEditingController.text = fumas;
          ECivil= snapshot.data()!["Estado Civil"] ?? '';
          estadoCiviltextEditingController.text = ECivil;
          Hijos= snapshot.data()!["TienesHijos"] ?? '';
          HijostextEditingController.text = Hijos;
          carrera= snapshot.data()!["Carrera"] ?? '';
          carreratextEditingController.text = carrera;
          trabajo= snapshot.data()!["Trabajo"] ?? '';
          trabajotextEditingController.text = trabajo;
          ViveCon= snapshot.data()!["ViveCon"] ?? '';
          ViviendoContextEditingController.text = ViveCon;
          Intenciones= snapshot.data()!["Intenciones"] ?? '';
          IntencionesheadingtextEditingController.text = Intenciones;
          Nacionalidad= snapshot.data()!["Nacionalidad"] ?? '';
          NacionalidadtextEditingController.text = Nacionalidad;
          Educacion= snapshot.data()!["Educacion"] ?? '';
          EducaciontextEditingController.text = Educacion;
          Idioma = snapshot.data()!["Idioma"] ?? '';
          IdiomastextEditingController.text = Idioma;
          semestre = snapshot.data()!["semestre"] ?? '';
          semestretextEditingController.text = semestre;
          Orientacion = snapshot.data()!["Orientacion"] ?? '';
          OrientaciontextEditingController.text = Orientacion;
          Comunidad = snapshot.data()!["Comunidad"] ?? '';
          ComunidadtextEditingController.text = Comunidad;

        });
      }
    });
  }

  updateUserDataToFirestoreDatabase(
      String  nombre, String  edad,
      String  numero, String  ciudad, String  delegacion,
      String  descripcion, String  Quebuscas,

      String altura, String peso, String tipoCuerpo,

      String bebes, String fumas, String ECivil,
      String Hijos, String carrera,
      String trabajo, String ViveCon,
      String Intenciones,

      String Nacionalidad, String Educacion, String Idioma,
      String semestre, String Orientacion, String Comunidad,
      ) async
  {
    showDialog(
        context: context,
        builder: (context)
        {
          return const AlertDialog(
            content: SizedBox(
              height: 200,
              child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Subiendo Imagenes ...")
                    ],
                  )
              
              ),
            ),
          );
        }
    );
    await uploadImages();

    await FirebaseFirestore.instance.collection("Usuarios")
        .doc(currentUserID)
        .update(
      {
        'nombre': nombre,
        'edad': int.parse(edad),
        'numero': numero,
        'ciudad':ciudad,
        'delegacion': delegacion,
        'descripcion': descripcion,
        'Quebuscas':Quebuscas,

        'altura': altura,
        'peso': peso,
        'tipoCuerpo': tipoCuerpo,

        'bebes': bebes,
        'fumas': fumas,
        'ECivil': ECivil,
        'Hijos': Hijos,
        'carrera': carrera,
        'trabajo': trabajo,
        'ViveCon': ViveCon,
        'Intenciones': Intenciones,

        'Nacionalidad': Nacionalidad,
        'Educacion': Educacion,
        'Idioma': Idioma,
        'semestre':semestre,
        'Orientacion': Orientacion,

        'urlImage1': urlList[0].toString(),
        'urlImage2': urlList[1].toString(),
        'urlImage3': urlList[2].toString(),
        'urlImage4': urlList[3].toString(),
        'urlImage5': urlList[4].toString(),

      });
    Get.snackbar("Actualizado", "Tu cuenta se actualizo con éxito");
    Get.to(HomeScreen());

    setState(() {
      uploading = false;
      _image.clear();
      urlList.clear();
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    retrieveUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          next ? "Informacion del Perfil" : "Elige 5 Imagenes",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        actions: [
          next
          ? Container()
              : IconButton(
              onPressed: ()
              {
                if(_image.length == 5)
                  {
                    setState(() {
                      uploading = true;
                      next = true;
                    });
                  }
                else
                {
                  Get.snackbar("5 Imagenes", "Elige 5 imagenes");
                }
              },
            icon: const Icon(Icons.navigate_next_outlined, size: 36,),
          )
        ],
      ),
      body: next ?
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              const SizedBox(
                height: 20,
              ), //SEPARADOR

              //--------------INFORMACION PERSONAL--------------------
              const Text(
                "Informacion Personal: ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 24,
              ), //SEPARADOR

              SizedBox(
                child: Container(
                  width: MediaQuery.of(context).size.width - 36,
                  height: 55,//autoajuste de pantalla
                  child: CustomTextFieldWidget(
                    editingController: nombretextEditingController,
                    labelText: "Nombre",
                    iconData: Icons.person_outline,
                    isObscure: false,
                  ),
                ),
              ),//NOMBRE


              const SizedBox(
                height: 50,
              ), //SEPARADOR

              //EDAD
              SizedBox(
                child: Container(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 36,
                    height: 55,//autoajuste de pantalla
                    child: CustomTextFieldWidget(
                      editingController: EdadtextEditingController,
                      labelText: "EDAD",
                      iconData: Icons.numbers,
                      isObscure: false,
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 50,
              ), //SEPARADOR

              //NUMERO
              SizedBox(
                child: Container(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 36,
                    height: 55,//autoajuste de pantalla
                    child: CustomTextFieldWidget(
                      editingController: NumerotextEditingController,
                      labelText: "Número Celular",
                      iconData: Icons.phone,
                      isObscure: false,
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 50,
              ), //SEPARADOR

              //CIUDAD
              SizedBox(
                child: Container(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 36,
                    height: 55,//autoajuste de pantalla
                    child: CustomTextFieldWidget(
                      editingController: CiudadtextEditingController,
                      labelText: "Ciudad",
                      iconData: Icons.location_city,
                      isObscure: false,
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 50,
              ), //SEPARADOR

              //delegacion
              SizedBox(
                child: Container(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 36,
                    height: 55,//autoajuste de pantalla
                    child: CustomTextFieldWidget(
                      editingController: delegaciontextEditingController,
                      labelText: "Delegación",
                      iconData: Icons.map_outlined,
                      isObscure: false,
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 50,
              ), //SEPARADOR

              //DESCRIPCION
              SizedBox(
                child: Container(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 36,
                    height: 55,//autoajuste de pantalla
                    child: CustomTextFieldWidget(
                      editingController: DESCRIPCIONtextEditingController,
                      labelText: "Describete",
                      iconData: Icons.text_fields,
                      isObscure: false,
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 50,
              ), //SEPARADOR

              //QUEBUSCASDEUNAPERSONA
              SizedBox(
                child: Container(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 36,
                    height: 55,//autoajuste de pantalla
                    child: CustomTextFieldWidget(
                      editingController: BUSCANDOAtextEditingController,
                      labelText: "Que buscas de una Persona",
                      iconData: Icons.face,
                      isObscure: false,
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 50,
              ), //SEPARADOR


              //---------------APARIENCIA ----------------

              const Text(
                "Apariencia: ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 24,
              ), //SEPARADOR

              SizedBox(
                child: Container(
                  width: MediaQuery.of(context).size.width - 36,
                  height: 55,//autoajuste de pantalla
                  child: CustomTextFieldWidget(
                    editingController: AlturatextEditingController,
                    labelText: "Altura",
                    iconData: Icons.insert_chart,
                    isObscure: false,
                  ),
                ),
              ),//ALTURA

              const SizedBox(
                height: 24,
              ), //SEPARADOR

              SizedBox(
                child: Container(
                  width: MediaQuery.of(context).size.width - 36,
                  height: 55,//autoajuste de pantalla
                  child: CustomTextFieldWidget(
                    editingController: PesotextEditingController,
                    labelText: "PESO",
                    iconData: Icons.table_chart,
                    isObscure: false,
                  ),
                ),
              ),//PESO

              const SizedBox(
                height: 24,
              ), //SEPARADOR

              SizedBox(
                child: Container(
                  width: MediaQuery.of(context).size.width - 36,
                  height: 55,//autoajuste de pantalla
                  child: CustomTextFieldWidget(
                    editingController: tipodecuerpotextEditingController,
                    labelText: "Tipo de Cuerpo",
                    iconData: Icons.type_specimen,
                    isObscure: false,
                  ),
                ),
              ),//TIPODECUERPO

              //-------------------ESTILODEVIDA--------------------------

              const Text(
                "Estilo de Vida: ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 24,
              ), //SEPARADOR

              SizedBox(
                child: Container(
                  width: MediaQuery.of(context).size.width - 36,
                  height: 55,//autoajuste de pantalla
                  child: CustomTextFieldWidget(
                    editingController: BebetextEditingController,
                    labelText: "Bebes?",
                    iconData: Icons.local_drink_outlined,
                    isObscure: false,
                  ),
                ),
              ),//BEBE?

              const SizedBox(
                height: 24,
              ), //SEPARADOR

              SizedBox(
                child: Container(
                  width: MediaQuery.of(context).size.width - 36,
                  height: 55,//autoajuste de pantalla
                  child: CustomTextFieldWidget(
                    editingController: fumatextEditingController,
                    labelText: "Fumas ?",
                    iconData: Icons.smoking_rooms,
                    isObscure: false,
                  ),
                ),
              ),//FUMAS

              const SizedBox(
                height: 24,
              ), //SEPARADOR

              SizedBox(
                child: Container(
                  width: MediaQuery.of(context).size.width - 36,
                  height: 55,//autoajuste de pantalla
                  child: CustomTextFieldWidget(
                    editingController: estadoCiviltextEditingController,
                    labelText: "ESTADO CIVIL",
                    iconData: Icons.person_2,
                    isObscure: false,
                  ),
                ),
              ),//ESTADOCIVIL

              const SizedBox(
                height: 24,
              ), //SEPARADOR

              SizedBox(
                child: Container(
                  width: MediaQuery.of(context).size.width - 36,
                  height: 55,//autoajuste de pantalla
                  child: CustomTextFieldWidget(
                    editingController: HijostextEditingController,
                    labelText: "¿Tienes Hijos?",
                    iconData: CupertinoIcons.person_3_fill,
                    isObscure: false,
                  ),
                ),
              ),//HIJOS

              const SizedBox(
                height: 24,
              ), //SEPARADOR


              SizedBox(
                child: Container(
                  width: MediaQuery.of(context).size.width - 36,
                  height: 55,//autoajuste de pantalla
                  child: CustomTextFieldWidget(
                    editingController: carreratextEditingController,
                    labelText: "Carrera ",
                    iconData: CupertinoIcons.collections_solid,
                    isObscure: false,
                  ),
                ),
              ),//CARRERA

              const SizedBox(
                height: 24,
              ), //SEPARADOR

              SizedBox(
                child: Container(
                  width: MediaQuery.of(context).size.width - 36,
                  height: 55,//autoajuste de pantalla
                  child: CustomTextFieldWidget(
                    editingController: trabajotextEditingController,
                    labelText: "TRABAJO",
                    iconData: CupertinoIcons.bag_fill,
                    isObscure: false,
                  ),
                ),
              ),//TRABAJO

              const SizedBox(
                height: 24,
              ), //SEPARADOR

              SizedBox(
                child: Container(
                  width: MediaQuery.of(context).size.width - 36,
                  height: 55,//autoajuste de pantalla
                  child: CustomTextFieldWidget(
                    editingController: ViviendoContextEditingController,
                    labelText: "Con quien vives",
                    iconData: Icons.home,
                    isObscure: false,
                  ),
                ),
              ),//CONQUIENVIVES

              const SizedBox(
                height: 24,
              ), //SEPARADOR


              SizedBox(
                child: Container(
                  width: MediaQuery.of(context).size.width - 36,
                  height: 55,//autoajuste de pantalla
                  child: CustomTextFieldWidget(
                    editingController: IntencionesheadingtextEditingController,
                    labelText: "Intenciones en la App",
                    iconData: Icons.person_pin_outlined,
                    isObscure: false,
                  ),
                ),
              ),//INTENCIONES
              const SizedBox(
                height: 24,
              ), //SEPARADOR

              //-------------------CULTURA--------------------------

              const Text(
                "Valores Culturales",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 24,
              ), //SEPARADOR

              SizedBox(
                child: Container(
                  width: MediaQuery.of(context).size.width - 36,
                  height: 55,//autoajuste de pantalla
                  child: CustomTextFieldWidget(
                    editingController: NacionalidadtextEditingController,
                    labelText: "Nacionalidad",
                    iconData: Icons.flag_circle_outlined,
                    isObscure: false,
                  ),
                ),
              ),//NACIONALIDAD

              const SizedBox(
                height: 24,
              ), //SEPARADOR

              SizedBox(
                child: Container(
                  width: MediaQuery.of(context).size.width - 36,
                  height: 55,//autoajuste de pantalla
                  child: CustomTextFieldWidget(
                    editingController: IdiomastextEditingController,
                    labelText: "Idiomas",
                    iconData: Icons.translate,
                    isObscure: false,
                  ),
                ),
              ),//IDIOMAS

              const SizedBox(
                height: 24,
              ), //SEPARADOR


              SizedBox(
                child: Container(
                  width: MediaQuery.of(context).size.width - 36,
                  height: 55,//autoajuste de pantalla
                  child: CustomTextFieldWidget(
                    editingController: EducaciontextEditingController,
                    labelText: "Grado de Estudios",
                    iconData: Icons.history_edu,
                    isObscure: false,
                  ),
                ),
              ),//ESTUDIOS

              const SizedBox(
                height: 24,
              ), //SEPARADOR

              SizedBox(
                child: Container(
                  width: MediaQuery.of(context).size.width - 36,
                  height: 55,//autoajuste de pantalla
                  child: CustomTextFieldWidget(
                    editingController: OrientaciontextEditingController,
                    labelText: "Orientacion:",
                    iconData: CupertinoIcons.person_3_fill,
                    isObscure: false,
                  ),
                ),
              ),//ETNIA

              const SizedBox(
                height: 24,
              ), //SEPARADOR

              SizedBox(
                child: Container(
                  width: MediaQuery.of(context).size.width - 36,
                  height: 55,//autoajuste de pantalla
                  child: CustomTextFieldWidget(
                    editingController: semestretextEditingController,
                    labelText: "Semestre:",
                    iconData: CupertinoIcons.check_mark_circled,
                    isObscure: false,
                  ),
                ),
              ),//RELIGION

              const SizedBox(
                height: 24,
              ),

              SizedBox(
                child: Container(
                  width: MediaQuery.of(context).size.width - 36,
                  height: 55,//autoajuste de pantalla
                  child: CustomTextFieldWidget(
                    editingController: ComunidadtextEditingController,
                    labelText: "Comunidad:",
                    iconData: CupertinoIcons.check_mark_circled,
                    isObscure: false,
                  ),
                ),
              ),//RELIGION

              const SizedBox(
                height: 24,
              ),

              Container(
                width: MediaQuery.of(context).size.width - 36,
                height: 55,//autoajuste de pantalla
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    )
                ),
                child: InkWell(
                  onTap: () async
                  {
                    if(nombretextEditingController.text.trim().isNotEmpty
                        && EdadtextEditingController.text.trim().isNotEmpty
                        && NumerotextEditingController.text.trim().isNotEmpty
                        && CiudadtextEditingController.text.trim().isNotEmpty
                        && delegaciontextEditingController.text.trim().isNotEmpty
                        && DESCRIPCIONtextEditingController.text.trim().isNotEmpty
                        && BUSCANDOAtextEditingController.text.trim().isNotEmpty
                        //FISICO
                        && AlturatextEditingController.text.trim().isNotEmpty
                        && PesotextEditingController.text.trim().isNotEmpty
                        && tipodecuerpotextEditingController.text.trim().isNotEmpty
                        //ESTILO DE VIDA
                        && BebetextEditingController.text.trim().isNotEmpty
                        && fumatextEditingController.text.trim().isNotEmpty
                        && estadoCiviltextEditingController.text.trim().isNotEmpty
                        && HijostextEditingController.text.trim().isNotEmpty
                        && carreratextEditingController.text.trim().isNotEmpty
                        && trabajotextEditingController.text.trim().isNotEmpty
                        && ViviendoContextEditingController.text.trim().isNotEmpty
                        && IntencionesheadingtextEditingController.text.trim().isNotEmpty

                        && NacionalidadtextEditingController.text.trim().isNotEmpty
                        && EducaciontextEditingController.text.trim().isNotEmpty
                        && IdiomastextEditingController.text.trim().isNotEmpty
                        && semestretextEditingController.text.trim().isNotEmpty
                        && OrientaciontextEditingController.text.trim().isNotEmpty
                        && ComunidadtextEditingController.text.trim().isNotEmpty



                    )
                    {
                      _image.length > 0 ?
                      await updateUserDataToFirestoreDatabase(
                        //INFOPERSONAL
                        nombretextEditingController.text.trim(),
                        EdadtextEditingController.text.trim(),
                        NumerotextEditingController.text.trim(),
                        CiudadtextEditingController.text.trim(),
                        delegaciontextEditingController.text.trim(),
                        DESCRIPCIONtextEditingController.text.trim(),
                        BUSCANDOAtextEditingController.text.trim(),
                        //APARIEnCIA
                        AlturatextEditingController.text.trim(),
                        PesotextEditingController.text.trim(),
                        tipodecuerpotextEditingController.text.trim(),
                        //ESTILO DE VIDA
                        BebetextEditingController.text.trim(),
                        fumatextEditingController.text.trim(),
                        estadoCiviltextEditingController.text.trim(),
                        HijostextEditingController.text.trim(),
                        carreratextEditingController.text.trim(),
                        trabajotextEditingController.text.trim(),
                        ViviendoContextEditingController.text.trim(),
                        IntencionesheadingtextEditingController.text.trim(),
                        //CULTURA
                        NacionalidadtextEditingController.text.trim(),
                        EducaciontextEditingController.text.trim(),
                        IdiomastextEditingController.text.trim(),
                        semestretextEditingController.text.trim(),
                        OrientaciontextEditingController.text.trim(),
                          ComunidadtextEditingController.text.trim(),
                      ) : null;

                    }
                    else
                    {
                      Get.snackbar("Uno o Mas Campos Vacios", "Por favor llena toda la informacion");
                    }
                  },
                  child: const Center(
                    child: Text("Actualizar Datos",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),

                    ),
                  ),
                ),
              ), //BOTON DE LOGUEO

              const SizedBox(
                height: 24,
              ), //SEPARADOR


            ],
          ),
        ),
      )
          :
      Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            child: GridView.builder(
              itemCount: _image.length +1,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
              ),
              itemBuilder: (context, index)
              {
                return index == 0
                ? Container(
                  color: Colors.white30,
                  child: Center (
                    child: IconButton(
                      onPressed: ()
                      {
                        if(_image.length < 5)
                          {
                            !uploading ? chooseImage() : null;
                          }
                        else
                          {
                            setState(() {
                              uploading == true;
                            });
                            Get.snackbar("5 Imagenes Seleccionadas", "Ya seleccionaste las Imagenes");
                          }
                      },
                      icon: const Icon(Icons.add),
                    ),
                  ),
                )
                : Container(
                  margin: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    image: DecorationImage (
                     image :FileImage(
                      _image[index - 1],
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
