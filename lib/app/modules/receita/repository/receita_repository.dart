import 'package:cloud_firestore/cloud_firestore.dart';

import '../../shared/helper/shared_preferences_helper.dart';
import '../model/receita.dart';

class ReceitaRepository {
  final Firestore _firestore = Firestore.instance;
  final SharedPreferencesHelper _sharedPreferencesHelper;

  ReceitaRepository(this._sharedPreferencesHelper);

  Future<void> create(Map<String, dynamic> data) async {
    var uid = await _sharedPreferencesHelper.getId();
    var reference = await _firestore.collection(uid).add(data);
    print('>>>>>>>>> ${reference.documentID}');
  }

  Future<Stream<List<Receita>>> read() async {
    var uid = await _sharedPreferencesHelper.getId();
    return _firestore.collection(uid).snapshots().map((query) {
      return query.documents.map((doc) => Receita.fromDocument(doc)).toList();
    });
  }

  Future<void> update(
      DocumentReference reference, Map<String, dynamic> data) async {
    await reference.updateData(data);
    print('>>>>>>>>> ${reference.documentID}');
  }

  Future<void> delete(DocumentReference reference) async {
    await reference.delete();
  }
}
