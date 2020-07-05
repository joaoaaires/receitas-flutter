import 'package:cloud_firestore/cloud_firestore.dart';

import 'ingrediente.dart';
import 'modo_preparo.dart';

class Receita {
  String titulo;
  List<Ingrediente> ingredientes = [];
  List<ModoPreparo> modosPreparo = [];
  DocumentReference reference;

  Receita();

  Receita.fromDocument(DocumentSnapshot doc) {
    titulo = doc["titulo"];
    var jsonIngredientes = doc["ingredientes"];
    for (var jsonIngrediente in jsonIngredientes) {
      ingredientes.add(Ingrediente.fromMap(jsonIngrediente));
    }
    var jsonModosPreparo = doc["modosPreparo"];
    for (var jsonModoPreparo in jsonModosPreparo) {
      modosPreparo.add(ModoPreparo.fromMap(jsonModoPreparo));
    }
    reference = doc.reference;
  }

  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{
      "titulo": titulo,
    };
    json['ingredientes'] = ingredientes
        .map(
          (element) => element.toJson(),
        )
        .toList();
    json['modosPreparo'] = modosPreparo
        .map(
          (element) => element.toJson(),
        )
        .toList();
    return json;
  }
}
