import 'package:deputados/domain/models/deputado.dart';
import 'package:deputados/domain/models/deputados.dart';
import 'package:deputados/domain/services/deputado_service.dart';

abstract class IDeputadoRepository {
  Future<List<Deputados>> getDeputados();
  Future<Deputado> getDeputadoById(int id);
  Future<List<Deputados>> getDeputadosByParams(
      {String? nome, String? partido, String? estado});
}

class DeputadoRepository implements IDeputadoRepository {
  final DeputadoService _deputadoService;

  DeputadoRepository(this._deputadoService);

  @override
  Future<List<Deputados>> getDeputados() async {
    return _deputadoService.getDeputados();
  }

  @override
  Future<List<Deputados>> getDeputadosByParams(
      {String? nome, String? partido, String? estado}) async {
    return _deputadoService.getDeputadosByParams(
        nome: nome, partido: partido, estado: estado);
  }

  @override
  Future<Deputado> getDeputadoById(int id) async {
    return _deputadoService.getDeputadoById(id);
  }
}
