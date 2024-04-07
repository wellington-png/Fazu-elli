import 'package:flutter/material.dart';
import 'package:deputados/domain/models/deputados.dart';
import 'package:deputados/domain/models/deputado.dart';
import 'package:deputados/domain/repositories/deputado_repository.dart';

class DeputadoStore extends ChangeNotifier {
  final IDeputadoRepository _deputadoRepository;

  DeputadoStore(this._deputadoRepository);

  List<Deputados> _deputados = [];
  List<Deputados> get deputados => _deputados;

  Deputado? _deputado;
  Deputado? get deputado => _deputado;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<void> _fetchDeputados(
      Future<List<Deputados>> Function() fetchFunction) async {
    _isLoading = true;
    _errorMessage = '';

    try {
      _deputados = await fetchFunction();
    } catch (error) {
      _errorMessage = 'Erro ao carregar os deputados: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getDeputados() async {
    await _fetchDeputados(() => _deputadoRepository.getDeputados());
  }

  Future<void> getDeputadosByParams(
      {String? nome, String? partido, String? estado}) async {
    clearAll();
    await _fetchDeputados(() => _deputadoRepository.getDeputadosByParams(
          nome: nome,
          partido: partido,
          estado: estado,
        ));
  }

  Future<void> getDeputadoById(int id) async {
    _isLoading = true;
    _errorMessage = '';

    try {
      _deputado = await _deputadoRepository.getDeputadoById(id);
    } catch (error) {
      _errorMessage = 'Erro ao carregar o deputado: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearDeputado() {
    _deputado = null;
    notifyListeners();
  }

  void clearErrorMessage() {
    _errorMessage = '';
    notifyListeners();
  }

  void clearAll() {
    _deputados = [];
    _deputado = null;
    _errorMessage = '';
    notifyListeners();
  }

  @override
  void dispose() {
    clearAll();
    super.dispose();
  }
}
