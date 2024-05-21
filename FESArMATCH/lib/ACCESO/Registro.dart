import 'dart:io';
import 'package:fesarmatch/controladores/ControlDeAutenticacion.dart';
import 'package:fesarmatch/models/persona.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/TextField.dart';

class PantallaRegistro extends StatefulWidget
{
  const PantallaRegistro ({super.key});
  @override
  State<PantallaRegistro> createState() => _PantallaregistroState();
}

class _PantallaregistroState extends State<PantallaRegistro>
{
  TextEditingController emailtextEditingController = TextEditingController();
  TextEditingController PasswordtextEditingController = TextEditingController();
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
  bool showProgressBar = false;
  var authenticationController = AuthenticationController.authController;
  @override
  Widget build (BuildContext context)
  {
    return Scaffold(
      body: Container(
        decoration:BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end:Alignment.bottomCenter,
            colors: [Colors.purpleAccent.shade100,Colors.purple],
          ),
        ),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [

              const SizedBox(
                height: 100,
              ), //SEPARADOR

              const Text(
                "Crear Cuenta",
                style: TextStyle (
                  fontSize: 22,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 100,
              ), //SEPARADOR
              const Text(
                "Para Empezar",
                style: TextStyle (
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 16,
              ), //SEPARADOR

              authenticationController.imageFile == null ?
              const CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage(
                    "images/profile.png"
                ),
                backgroundColor: Colors.purpleAccent,
              ) :
              Container (
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                  image: DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: FileImage(
                      File(
                        authenticationController.imageFile!.path,
                      ),
                    ),
                  )
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () async
                      {
                        await authenticationController.tomarFotoCamara();

                        setState(() {
                          authenticationController.imageFile;
                        });
                      },
                      icon: const Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.grey,
                        size: 30,

                      ),
                  ),
                  const SizedBox(
                    width: 10,

                  ),

                  IconButton(
                    onPressed: ()async
                    {
                      await authenticationController.imagenDeGaleria();
                      setState(() {
                        authenticationController.imageFile;
                      });
                    },
                    icon: const Icon(
                      Icons.image_outlined,
                      color: Colors.grey,
                      size: 30,

                    ),
                  ),
                ],
              ),//SELECTOR DE IMAGEN

              const SizedBox(
                height: 24,
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
                height: 24,
              ), //SEPARADOR

              SizedBox(
                child: Container(
                  width: MediaQuery.of(context).size.width - 36,
                  height: 55,//autoajuste de pantalla
                  child: CustomTextFieldWidget(
                    editingController: emailtextEditingController,
                    labelText: "Correo Aragon",
                    iconData: Icons.email_outlined,
                    isObscure: false,
                  ),
                ),
              ), //CORREO

              const SizedBox(
                height: 24,
              ), //SEPARADOR

              SizedBox(
                child: Container(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 36,
                    height: 55,//autoajuste de pantalla
                    child: CustomTextFieldWidget(
                      editingController: PasswordtextEditingController,
                      labelText: "Contraseña",
                      iconData: Icons.lock_outline,
                      isObscure: true,
                    ),
                  ),
                ),
              ), //CONTRASEÑA

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

              //Delegacion
              SizedBox(
                child: Container(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 36,
                    height: 55,//autoajuste de pantalla
                    child: CustomTextFieldWidget(
                      editingController: delegaciontextEditingController,
                      labelText: "Delegacion / Municipio",
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
                    labelText: "Orientacion",
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
                    labelText: "Semestre: ",
                    iconData: CupertinoIcons.check_mark_circled,
                    isObscure: false,
                  ),
                ),
              ),//RELIGION

              const SizedBox(
                height: 24,
              ), //SEPARADOR

              SizedBox(
                child: Container(
                  width: MediaQuery.of(context).size.width - 36,
                  height: 55,//autoajuste de pantalla
                  child: CustomTextFieldWidget(
                    editingController: ComunidadtextEditingController,
                    labelText: "Comunidad",
                    iconData: CupertinoIcons.check_mark_circled,
                    isObscure: false,
                  ),
                ),
              ),//RELIGION

              const SizedBox(
                height: 24,
              ), //SEPARADOR

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
                    if(authenticationController.imageFile != null)
                    {
                      if(nombretextEditingController.text.trim().isNotEmpty
                          && emailtextEditingController.text.trim().isNotEmpty
                          && PasswordtextEditingController.text.trim().isNotEmpty
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
                       setState(() {
                         showProgressBar = true;
                       });
                       await authenticationController.CreateNewUserAccount(
                          //INFOPERSONAL
                          authenticationController.profileImage!,
                          emailtextEditingController.text.trim(),
                          PasswordtextEditingController.text.trim(),
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




                        );
                       //----------------------------------CREACION DE PERFIL MANUALMENTE----------------------------


                       setState(() {
                         showProgressBar = false;
                         authenticationController.imageFile = null;
                       });

                      }
                      else
                      {
                        Get.snackbar("Uno o Mas Campos Vacios", "Por favor llena toda la informacion");
                      }
                    }
                    else
                    {
                      Get.snackbar("Falta Imagen", "Por favor selecciona una Imagen");
                    }
                  },
                  child: const Center(
                    child: Text("Crear Cuenta",
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

              //CREAR CUENTA BOTON
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Ya tienes una cuenta?",
                    style: TextStyle (
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),

                  InkWell(
                    onTap: (){
                      Get.back();

                    },
                    child: const Text("Inicia Sesión",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,

                      ),
                    ),
                  )
                ],
              ),

              showProgressBar == true
                  ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
              )
                  : Container(),
              const SizedBox(
                height: 50,
              ), //SEPARADOR




            ],

          ),
        ),
      ),
      ),
    );
  }
}