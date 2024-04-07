import 'package:flutter/material.dart';
import 'package:deputados/domain/models/frente.dart';
import 'package:deputados/domain/models/membro.dart';
import 'package:deputados/domain/repositories/frentes_repository.dart';

class FrentesStore extends ChangeNotifier {
  final IFrentesRepository _frentesRepository;

  FrentesStore(this._frentesRepository);

  List<Frente> _frentes = [];
  List<Frente> get frentes => _frentes;

  Frente? _frente;
  Frente? get frente => _frente;

  List<Membro> _membros = []; // Lista de membros
  List<Membro> get membros => _membros;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<void> getFrentes() async {
    _isLoading = true;
    _errorMessage = '';

    try {
      _frentes = await _frentesRepository.getFrentes();
    } catch (error) {
      _errorMessage = 'Erro ao carregar as frentes: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getFrenteById(int id) async {
    _isLoading = true;
    _errorMessage = '';

    try {
      _frente = await _frentesRepository.getFrenteById(id);
    } catch (error) {
      _errorMessage = 'Erro ao carregar a frente: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getMembrosByFrenteId(int frenteId) async {
    // Método para obter membros pelo ID da frente
    _isLoading = true;
    _errorMessage = '';

    try {
      _membros = await _frentesRepository.getMembrosByFrenteId(frenteId);
    } catch (error) {
      _errorMessage = 'Erro ao carregar os membros: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
