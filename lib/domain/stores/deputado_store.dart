import 'package:flutter/material.dart';
import 'package:deputados/domain/models/deputados.dart';
import 'package:deputados/domain/repositories/deputado_repository.dart';

class DeputadoStore extends ChangeNotifier {
  final IDeputadoRepository _deputadoRepository;

  DeputadoStore(this._deputadoRepository) {
    getDeputados();
  }

  List<Deputados> _deputados = [];
  List<Deputados> get deputados => _deputados;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<void> getDeputados() async {
    _isLoading = true;
    _errorMessage = '';

    try {
      _deputados = await _deputadoRepository.getDeputados();
    } catch (error) {
      _errorMessage = 'Erro ao carregar os deputados: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
