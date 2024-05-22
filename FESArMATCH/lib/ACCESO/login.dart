import 'package:fesarmatch/ACCESO/Registro.dart';
import 'package:fesarmatch/controladores/ControlDeAutenticacion.dart';
import 'package:fesarmatch/widgets/TextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class pantallalogin extends StatefulWidget {
  const pantallalogin ({super.key});

  @override
  State<pantallalogin> createState() => _pantallaloginState();
}

class _pantallaloginState extends State <pantallalogin> {
  TextEditingController emailtextEditingController = TextEditingController();
  TextEditingController PasswordtextEditingController = TextEditingController();
  bool showProgressBar= false;
  var controllerAuth = AuthenticationController.authController;

  @override

  Widget build (BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [

              const SizedBox(
                height: 90,

              ), //SEPARADOR

              Image.asset(
                "images/fesarmatch2.jpeg",
                width: 180,

              ),
              const Text(
                "FESArMATCH",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight:FontWeight.bold
                ),
              ),

              const Text(
                  "Encontremos tu proxima pareja",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(
                height: 100,

              ), //SEPARADOR
              const Text(
                  "INICIA SESION",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.normal
                  ),
              ),

            const SizedBox(
              height: 28,
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
             ), //ESPACIO PARA CORREO

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
              ), //ESPACIO PARA CONTRASEÑA

              const SizedBox(
                height: 50,
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
                  onTap: () async{
                    if(emailtextEditingController.text.trim().isNotEmpty
                    && PasswordtextEditingController.text.trim().isNotEmpty ){
                      setState(() {
                        showProgressBar=true;
                      });

                     await controllerAuth.loginUser(
                          emailtextEditingController.text.trim(),
                          PasswordtextEditingController.text.trim()
                      );
                      setState(() {
                        showProgressBar=false;
                      });

                    }
                    else{
                      Get.snackbar("Faltan Correo o contraseña", "Llenar todos los campos");
                    }
                  },
                  child: const Center(
                    child: Text("Login",
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
                  const Text("No Tienes una cuenta?",
                  style: TextStyle (
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  ),

                  InkWell(
                    onTap: (){
                      Get.to(const PantallaRegistro());

                    },
                    child: const Text(" Crea una Cuenta",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,

                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 50,
              ), //SEPARADOR

              showProgressBar == true
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
                    )
                  : Container(),



            ],
          )
        ),
      ),
    );
  }
}