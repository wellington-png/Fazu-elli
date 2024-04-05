import 'package:deputados/domain/models/deputado.dart';
import 'package:deputados/domain/models/deputados.dart';
import 'package:deputados/domain/services/deputado_service.dart';

abstract class IDeputadoRepository {
  Future<List<Deputados>> getDeputados();
  Future<Deputado> getDeputadoById(int id);
}

class DeputadoRepository implements IDeputadoRepository {
  final DeputadoService _deputadoService;

  DeputadoRepository(this._deputadoService);

  @override
  Future<List<Deputados>> getDeputados() async {
    final deputados = await _deputadoService.getDeputados();
    return deputados;
  }

  @override
  Future<Deputado> getDeputadoById(int id) async {
    final deputado = await _deputadoService.getDeputadoById(id);
    return deputado;
  }
}