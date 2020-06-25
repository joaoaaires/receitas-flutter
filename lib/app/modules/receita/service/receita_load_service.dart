import '../../shared/helper/database_helper.dart';

import '../model/ingrediente.dart';
import '../model/modo_preparo.dart';
import '../model/receita.dart';
import '../repository/ingrediente_repository.dart';
import '../repository/modo_preparo_repository.dart';
import '../repository/receita_repository.dart';

class ReceitaLoadService {
  ReceitaRepository _receitaRepository;
  IngredienteRepository _ingredienteRepository;
  ModoPreparoRepository _modoPreparoRepository;

  ReceitaLoadService(DatabaseHelper databaseHelper) {
    _receitaRepository = ReceitaRepository(databaseHelper);
    _ingredienteRepository = IngredienteRepository(databaseHelper);
    _modoPreparoRepository = ModoPreparoRepository(databaseHelper);
  }

  void update(List jsonReceitas) async {
    try {
      for (var jsonReceita in jsonReceitas) {
        var receita = Receita.fromMapHttp(jsonReceita);
        var receitaBd = await _receitaRepository.readByIdServer(
          receita.idserver ?? 0,
        );
        receita.id = receitaBd?.id ?? 0;

        if (receita.id != null && receita.id != 0) {
          receita.id = await _receitaRepository.update(receita);
        } else {
          receita.id = await _receitaRepository.create(receita);
        }

        var jsonIngredientes = jsonReceita['ingredientes'] as List;
        for (var jsonIngrediente in jsonIngredientes) {
          var ingrediente = Ingrediente.fromMapHttp(jsonIngrediente);
          var ingredienteBd = await _ingredienteRepository.readByIdServer(
            ingrediente.idserver ?? 0,
          );

          ingrediente.idreceita = receita.id;
          ingrediente.id = ingredienteBd?.id ?? 0;

          if (ingrediente.id != null && ingrediente.id != 0) {
            await _ingredienteRepository.update(ingrediente);
          } else {
            await _ingredienteRepository.create(ingrediente);
          }
        }

        var jsonModosPreparo = jsonReceita['modosPreparo'] as List;
        for (var jsonModoPreparo in jsonModosPreparo) {
          var modoPreparo = ModoPreparo.fromMapHttp(jsonModoPreparo);
          var modoPreparoBd = await _modoPreparoRepository.readByIdServer(
            modoPreparo.idserver ?? 0,
          );

          modoPreparo.idreceita = receita.id;
          modoPreparo.id = modoPreparoBd?.id ?? 0;

          if (modoPreparo.id != null && modoPreparo.id != 0) {
            await _modoPreparoRepository.update(modoPreparo);
          } else {
            await _modoPreparoRepository.create(modoPreparo);
          }
        }
      }
    } on Exception catch (e) {
      print(e);
    }
  }
}
