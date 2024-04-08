import 'package:deputados/domain/models/deputado.dart';
import 'package:deputados/domain/models/deputados.dart';
import 'package:deputados/domain/models/historico.dart';
import 'package:deputados/domain/models/ocupacao.dart';
import 'package:deputados/domain/services/deputado_service.dart';

abstract class IDeputadoRepository {
  Future<List<Deputados>> getDeputados();
  Future<Deputado> getDeputadoById(int id);
  Future<List<Deputados>> getDeputadosByParams(
      {String? nome, String? partido, String? estado});
  Future<List<Ocupacao>> getOcupacoesByDeputadoId(int id);
  Future<List<Historico>> getHistoricoByDeputadoId(int id);

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

  @override
  Future<List<Ocupacao>> getOcupacoesByDeputadoId(int id) {
    return _deputadoService.getOcupacoesByDeputadoId(id);
  }

  @override
  Future<List<Historico>> getHistoricoByDeputadoId(int id) async {
    return _deputadoService.getHistoricoByDeputadoId(id);
  }
}
