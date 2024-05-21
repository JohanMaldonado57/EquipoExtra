import 'dart:io';
//import 'dart:js_interop';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fesarmatch/ACCESO/login.dart';
import 'package:fesarmatch/HomeScreen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fesarmatch/models/persona.dart' as personaModelo;

class AuthenticationController extends GetxController
{
  @override
  void initState() {
    Future<Map<String, dynamic>> loadUserData() async {
      var userDoc = await FirebaseFirestore.instance.collection('Usuarios').doc(FirebaseAuth.instance.currentUser!.uid).get();
      return userDoc.data() ?? {};
    }
  }
  Future<Map<String, dynamic>> loadUserData() async {
    var userDoc = await FirebaseFirestore.instance.collection('Usuarios').doc(FirebaseAuth.instance.currentUser!.uid).get();
    return userDoc.data() ?? {};
  }

  static AuthenticationController authController = Get.find();
  late Rx<User?> firebaseCurrentUser;

  late Rx<File?> pickedFile;
  File? get profileImage => pickedFile.value;
  XFile? imageFile;

  imagenDeGaleria() async
  {
    imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (imageFile != null)
      {
        Get.snackbar("Imagen de Perfil", "Imagen de perfil cargada correctamente");
      }
      pickedFile = Rx<File?>(File (imageFile!.path));
  }

  tomarFotoCamara() async
  {
    imageFile = await ImagePicker().pickImage(source: ImageSource.camera);

    if (imageFile != null)
    {
      Get.snackbar("Imagen de Perfil", "La Imagen se Capturo correctamente");
    }
    pickedFile = Rx<File?>(File (imageFile!.path));
  }

  Future <String> subirImagenAAlmacenamiento(File imageFile) async
  {
    final newMetadata = SettableMetadata(
      contentType: "image/jpeg",
    );
    Reference referenceStorage = FirebaseStorage.instance.ref()
        .child("Imagenes Perfil")
        .child(FirebaseAuth.instance.currentUser!.uid);


    UploadTask task = referenceStorage.putFile(imageFile,newMetadata);
    TaskSnapshot snapshot = await task;

    String URLImagenDescarga = await snapshot.ref.getDownloadURL();
    return URLImagenDescarga;
  }

  CreateNewUserAccount(
      File imagenPerfil, String email, String password,
      String  nombre, String  edad,
      String  numero, String  ciudad, String delegacion,
      String  descripcion, String  Quebuscas,

      String altura, String peso, String tipoCuerpo,

      String bebes, String fumas, String ECivil,
      String Hijos, String carrera,
      String trabajo, String ViveCon,
      String Intenciones,

      String Nacionalidad, String Educacion, String Idioma,
      String semestre, String Orientacion, String Comunidad,) async
  {
    try
    {
      //Autenticacion con correo y contraseña
      UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password:password
      );
      //Guardar Imagen
      String URLImagenDescarga = await subirImagenAAlmacenamiento(imagenPerfil);

      //Guardar Informacion
      personaModelo.Persona personaInstance = personaModelo.Persona(
        uid: FirebaseAuth.instance.currentUser!.uid,
        imagenPerfil: URLImagenDescarga,
        email: email,
        password: password,
        nombre: nombre,
        edad: int.parse(edad),
        numero: numero,
        ciudad:ciudad,
        delegacion: delegacion,
        descripcion: descripcion,
        Quebuscas:Quebuscas,
        FechaPublicada: DateTime.now().millisecondsSinceEpoch,

        //Apariencia
        altura: altura,
        peso: peso,
        tipoCuerpo: tipoCuerpo,

        //Estilo de Vida

        bebes: bebes,
        fumas: fumas,
        ECivil: ECivil,
        Hijos: Hijos,
        carrera: carrera,
        trabajo: trabajo,
        ViveCon: ViveCon,
        Intenciones: Intenciones,

        //Cultura
        Nacionalidad: Nacionalidad,
        Educacion: Educacion,
        Idioma: Idioma,
        semestre:semestre,
        Orientacion: Orientacion,
        Comunidad: Comunidad,




      );
      await FirebaseFirestore.instance.collection("Usuarios")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(personaInstance.toJson());

      Get.snackbar("Cuenta Creada Exitosamente", "Has creado tu cuenta en FESArMATCH");
      Get.to(HomeScreen());
    }
    catch(errorMsg)
    {
      Get.snackbar("La creacion de la cuenta Ha fallado ", "Un Error a ocurrido: $errorMsg");
    }
  }

  loginUser(String emailUser, String PasswordUser) async{
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailUser,
          password: PasswordUser
      );
      Get.snackbar("Inicio de Sesión Correcto", "Has Iniciado Sesion dentro de FESArMATCH :D ");

      Get.to(HomeScreen());

    }
    catch(errorMsg){
      Get.snackbar("Fallo Inicio de Sesión", "Un error: $errorMsg");
    }
  }

  comprobarSiUsuarioEstaLoggeado(User? currentUser){
    if(currentUser == null){
      Get.to(pantallalogin());

    }
    else {
      Get.to(HomeScreen());
    }
  }

  @override
  void onReady(){
    super.onReady();

    firebaseCurrentUser = Rx<User?>(FirebaseAuth.instance.currentUser);
    firebaseCurrentUser.bindStream(FirebaseAuth.instance.authStateChanges()); //reconocer si la cuenta esta abierta

    ever(firebaseCurrentUser, comprobarSiUsuarioEstaLoggeado);
  }
}
