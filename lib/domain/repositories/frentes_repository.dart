import 'package:deputados/domain/models/frente.dart';
import 'package:deputados/domain/models/membro.dart';
import 'package:deputados/domain/services/frentes_service.dart';

abstract class IFrentesRepository {
  Future<List<Frente>> getFrentes({required int pagina, required int itens});
  Future<Frente> getFrenteById(int id);
  Future<List<Membro>> getMembrosByFrenteId(int frenteId);
}

class FrentesRepository implements IFrentesRepository {
  final FrentesService _frentesService;

  FrentesRepository(this._frentesService);

  @override
  Future<List<Frente>> getFrentes(
      {required int pagina, required int itens}) async {
    return _frentesService.getFrentes(
      pagina: pagina,
      itens: itens,
    );
  }

  @override
  Future<Frente> getFrenteById(int id) async {
    return _frentesService.getFrenteById(id);
  }

  @override
  Future<List<Membro>> getMembrosByFrenteId(int frenteId) async {
    return _frentesService.getMembrosByFrenteId(frenteId);
  }

}
