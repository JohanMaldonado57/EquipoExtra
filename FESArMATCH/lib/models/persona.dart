import 'package:cloud_firestore/cloud_firestore.dart';

class Persona {
  String ? uid;
  String ? imagenPerfil;
  String ? email;
  String ? password;
  String ? nombre;
  int ? edad;
  String ? numero;
  String ? ciudad;
  String ? delegacion;
  String ? descripcion;
  String ? Quebuscas;
  int ? FechaPublicada;

  //apariencia
  String ? altura;
  String ? peso;
  String ? tipoCuerpo;

  //lifestyle
  String ? bebes;
  String ? fumas;
  String ? ECivil;
  String ? Hijos;
  String ? carrera;
  String ? trabajo;
  String ? ViveCon;
  String ? Intenciones;

  //cultura

  String ? Nacionalidad;
  String ? Educacion;
  String ? Idioma;
  String ? semestre;
  String ? Orientacion;
  String ? Comunidad;

  Persona({
    this.uid,
    this.imagenPerfil,
    this.email,
    this.password,
    this.nombre,
    this.edad,
    this.numero,
    this.ciudad,
    this.delegacion,
    this.descripcion,
    this.Quebuscas,
    this.FechaPublicada,

    this.altura,
    this.peso,
    this.tipoCuerpo,

    this.bebes,
    this.fumas,
    this.ECivil,
    this.Hijos,
    this.carrera,
    this.trabajo,
    this.ViveCon,
    this.Intenciones,

    this.Nacionalidad,
    this.Educacion,
    this.Idioma,
    this.semestre,
    this.Orientacion,
    this.Comunidad,
  });

  static Persona fromDataSnapshot(DocumentSnapshot snapshot)
  {
    var dataSnapshot = snapshot.data() as Map<String, dynamic>;
    return Persona(
      uid: dataSnapshot["uid"],
      imagenPerfil: dataSnapshot["imagenPerfil"],
      email: dataSnapshot["Correo"],
      password:  dataSnapshot["Contraseña"],
      nombre: dataSnapshot["nombre"],
      edad: dataSnapshot["Edad"],
      numero:  dataSnapshot["numero"],
      ciudad:  dataSnapshot["ciudad"],
      delegacion:  dataSnapshot["delegacion"],
      descripcion:  dataSnapshot["Descripcion"],
      Quebuscas:  dataSnapshot["Intenciones"],
      FechaPublicada:  dataSnapshot["Published Date Time"],

      altura:  dataSnapshot["Altura"],
      peso:  dataSnapshot["Peso"],
      tipoCuerpo:  dataSnapshot["TipoCuerpo"],

      bebes:  dataSnapshot["Bebes?"],
      fumas:  dataSnapshot["Fumas?"],
      ECivil:  dataSnapshot["Estado Civil"],
      Hijos:  dataSnapshot["Hijos"],
      carrera:  dataSnapshot["Carrera"],
      trabajo:  dataSnapshot["Trabajo"],
      ViveCon:  dataSnapshot["Con quien Vives"],
      Intenciones:  dataSnapshot["Intenciones"],

      Nacionalidad:  dataSnapshot["Nacionalidad"],
      Educacion:  dataSnapshot["Educacion"],
      Idioma:  dataSnapshot["Idioma"],
      semestre:  dataSnapshot["semestre"],
      Orientacion:  dataSnapshot["Orientacion"],
      Comunidad: dataSnapshot["Comunidad"],
    );

  }

  Map<String, dynamic> toJson() =>
      {
        "uid": uid,
        "imagenPerfil": imagenPerfil,
        "email": email,
        "providerld": password,
        "nombre": nombre,
        "Edad": edad,
        "numero": numero,
        "ciudad": ciudad,
        "delegacion": delegacion,
        "Descripcion": descripcion,
        "LoQueBuscas": Quebuscas,
        "FechaPublicada":FechaPublicada,

        "Altura": altura,
        "peso": peso,
        "TipoCuerpo": tipoCuerpo,

        "Bebes?":bebes,
        "Fumas":fumas,
        "Estado Civil": ECivil,
        "TienesHijos" : Hijos,
        "Carrera": carrera,
        "Trabajo": trabajo,
        "ViveCon": ViveCon,
        "Intenciones": Intenciones,

        "Nacionalidad": Nacionalidad,
        "Educacion" : Educacion,
        "Idioma": Idioma,
        "semestre": semestre,
        "Orientacion": Orientacion,
        "Comunidad" : Comunidad,

      };
}