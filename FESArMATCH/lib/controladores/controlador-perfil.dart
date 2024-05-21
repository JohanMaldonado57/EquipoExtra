import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fesarmatch/global.dart';
import 'package:fesarmatch/models/persona.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class ControladorPerfil extends GetxController {
  final Rx<List<Persona>> usersProfileList = Rx<List<Persona>>([]);

  List<Persona> get allUsersProfileList => usersProfileList.value;

  @override
  void onInit() {
    super.onInit();
    
    usersProfileList.bindStream(
      FirebaseFirestore.instance.collection("Usuarios")
          .where("uid", isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .snapshots()
          .map((QuerySnapshot queryDataSnapshot)
      {
        List<Persona> profilesList = [];

        for(var eachProfile in queryDataSnapshot.docs)
        {
          profilesList.add(Persona.fromDataSnapshot(eachProfile));
        }
        return profilesList;
      })
    );
    // Cargar los datos de usuario al inicializar el controlador
    //loadUserData();
  }

  /*Future<List<Persona>> loadUserData() async {
    try {
      // Obtener una referencia a la colección de usuarios en Firestore
      CollectionReference usersRef = FirebaseFirestore.instance.collection('Usuarios');

      // Obtener todos los documentos de la colección de usuarios
      QuerySnapshot querySnapshot = await usersRef.get();

      // Transformar los documentos en objetos Persona y retornar la lista de perfiles
      List<Persona> profilesList = querySnapshot.docs.map((doc) => Persona.fromdataSnapshot(doc)).toList();
      return profilesList;
    } catch (error) {
      // Manejar cualquier error que ocurra durante la carga de datos
      print('Error al cargar los datos de usuario: $error');
      return []; // Devolver una lista vacía en caso de error
    }
  }*/

  favoriteSendAndFavoriteReceived(String toUserID, String senderName ) async{
    var document = await FirebaseFirestore.instance
        .collection("Usuarios")
        .doc(toUserID).collection("favoriteReceived").doc(currentUserID)
        .get();

    if(document.exists){
      //remover usuario de la lista de favoritos de la persona
      await FirebaseFirestore.instance
          .collection("Usuarios")
          .doc(toUserID).collection("favoriteReceived").doc(currentUserID)
          .delete();

      await FirebaseFirestore.instance
          .collection("Usuarios")
          .doc(currentUserID).collection("favoriteSent").doc(toUserID)
          .delete();

    }
    else  //marcar como favorito //favorito en base de datos
    {
      await FirebaseFirestore.instance
          .collection("Usuarios")
          .doc(toUserID).collection("favoriteReceived").doc(currentUserID)
          .set({});

      await FirebaseFirestore.instance
          .collection("Usuarios")
          .doc(currentUserID).collection("favoriteSent").doc(toUserID)
          .set({});
    }
    update();


  }

  likeSendAndLikeReceived(String toUserID, String senderName ) async{
    var document = await FirebaseFirestore.instance
        .collection("Usuarios")
        .doc(toUserID).collection("likeReceived").doc(currentUserID)
        .get();

    //removerlike de database
    if(document.exists){
      //remover usuario de la lista de likes de la persona
      await FirebaseFirestore.instance
          .collection("Usuarios")
          .doc(toUserID).collection("likeReceived").doc(currentUserID)
          .delete();

      await FirebaseFirestore.instance
          .collection("Usuarios")
          .doc(currentUserID).collection("likeSent").doc(toUserID)
          .delete();

    }
    else  //marcar como like //like en base de datos
        {
      await FirebaseFirestore.instance
          .collection("Usuarios")
          .doc(toUserID).collection("likeReceived").doc(currentUserID)
          .set({});

      await FirebaseFirestore.instance
          .collection("Usuarios")
          .doc(currentUserID).collection("likeSent").doc(toUserID)
          .set({});
    }
    update();


  }

  ViewSentAndViewReceived(String toUserID, String senderName ) async{
    var document = await FirebaseFirestore.instance
        .collection("Usuarios")
        .doc(toUserID).collection("viewReceived").doc(currentUserID)
        .get();

    if(document.exists){
      print ("Ya en la lista de vistos");
    }
    else  //marcar como visto //visto en base de datos
        {
      await FirebaseFirestore.instance
          .collection("Usuarios")
          .doc(toUserID).collection("viewReceived").doc(currentUserID)
          .set({});

      await FirebaseFirestore.instance
          .collection("Usuarios")
          .doc(currentUserID).collection("viewSent").doc(toUserID)
          .set({});
    }
    update();


  }
}



