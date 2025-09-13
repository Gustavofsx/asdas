import 'package:flutter/foundation.dart';
import '../models/vehicle.dart';
import '../services/api_service.dart';

class VehicleProvider with ChangeNotifier {
  List<Vehicle> _vehicles = [];
  bool _isLoading = false;
  String _error = '';

  List<Vehicle> get vehicles => _vehicles;
  bool get isLoading => _isLoading;
  String get error => _error;

  // Dados mockados para demonstração
  void loadMockData() {
    _isLoading = true;
    notifyListeners();

    // Simulando delay de carregamento
    Future.delayed(const Duration(seconds: 1), () {
      _vehicles = [
        Vehicle(
          id: '1',
          brand: 'Toyota',
          model: 'Corolla',
          year: 2023,
          color: 'Prata',
          price: 125000.00,
          stockQuantity: 5,
          description: 'Sedan compacto com excelente economia de combustível',
          imageUrl: 'https://via.placeholder.com/300x200/4CAF50/FFFFFF?text=Toyota+Corolla',
          createdAt: DateTime.now().subtract(const Duration(days: 30)),
        ),
        Vehicle(
          id: '2',
          brand: 'Honda',
          model: 'Civic',
          year: 2023,
          color: 'Preto',
          price: 118000.00,
          stockQuantity: 3,
          description: 'Sedan esportivo com design moderno',
          imageUrl: 'https://via.placeholder.com/300x200/2196F3/FFFFFF?text=Honda+Civic',
          createdAt: DateTime.now().subtract(const Duration(days: 25)),
        ),
        Vehicle(
          id: '3',
          brand: 'Volkswagen',
          model: 'Golf',
          year: 2023,
          color: 'Branco',
          price: 135000.00,
          stockQuantity: 2,
          description: 'Hatchback premium com tecnologia avançada',
          imageUrl: 'https://via.placeholder.com/300x200/FF9800/FFFFFF?text=VW+Golf',
          createdAt: DateTime.now().subtract(const Duration(days: 20)),
        ),
        Vehicle(
          id: '4',
          brand: 'Ford',
          model: 'Focus',
          year: 2023,
          color: 'Azul',
          price: 98000.00,
          stockQuantity: 7,
          description: 'Hatchback compacto ideal para cidade',
          imageUrl: 'https://via.placeholder.com/300x200/9C27B0/FFFFFF?text=Ford+Focus',
          createdAt: DateTime.now().subtract(const Duration(days: 15)),
        ),
      ];
      _isLoading = false;
      _error = '';
      notifyListeners();
    });
  }

  // Carrega veículos da API
  Future<void> loadVehiclesFromApi() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      final vehicles = await ApiService.fetchVehicles();
      _vehicles = vehicles;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Adiciona veículo via API
  Future<bool> addVehicleFromApi(Map<String, dynamic> vehicleData) async {
    _isLoading = true;
    notifyListeners();

    try {
      print('Dados recebidos no Provider: $vehicleData'); // Debug
      
      // Simula criação de veículo localmente (já que a API não salva realmente)
      final newVehicle = Vehicle(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        brand: vehicleData['brand'] ?? '',
        model: vehicleData['model'] ?? '',
        year: vehicleData['year'] ?? 2023,
        color: vehicleData['color'] ?? '',
        price: vehicleData['price'] ?? 0.0,
        stockQuantity: vehicleData['stockQuantity'] ?? 0,
        description: vehicleData['description'] ?? '',
        imageUrl: vehicleData['imageUrl'] ?? 'https://via.placeholder.com/400x300?text=Sem+Imagem',
        createdAt: DateTime.now(),
      );
      
      print('Veículo criado: ${newVehicle.brand} ${newVehicle.model} - Imagem: ${newVehicle.imageUrl}'); // Debug
      
      _vehicles.add(newVehicle);
      _isLoading = false;
      notifyListeners();
      
      print('Veículo adicionado com sucesso: ${newVehicle.id}'); // Debug
      return true;
    } catch (e) {
      print('Erro ao adicionar veículo: $e'); // Debug
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Atualiza veículo via API
  Future<bool> updateVehicleFromApi(String id, Map<String, dynamic> vehicleData) async {
    _isLoading = true;
    notifyListeners();

    try {
      final vehicle = await ApiService.updateVehicle(id, vehicleData);
      if (vehicle != null) {
        final index = _vehicles.indexWhere((v) => v.id == id);
        if (index != -1) {
          _vehicles[index] = vehicle;
          _isLoading = false;
          notifyListeners();
          return true;
        }
      }
      _error = 'Erro ao atualizar veículo na API';
      _isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Remove veículo via API
  Future<bool> removeVehicleFromApi(String id) async {
    _isLoading = true;
    notifyListeners();

    try {
      final success = await ApiService.deleteVehicle(id);
      if (success) {
        _vehicles.removeWhere((vehicle) => vehicle.id == id);
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _error = 'Erro ao remover veículo da API';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void addVehicle(Vehicle vehicle) {
    _vehicles.add(vehicle);
    notifyListeners();
  }

  void updateVehicle(Vehicle vehicle) {
    final index = _vehicles.indexWhere((v) => v.id == vehicle.id);
    if (index != -1) {
      _vehicles[index] = vehicle;
      notifyListeners();
    }
  }

  void removeVehicle(String id) {
    _vehicles.removeWhere((vehicle) => vehicle.id == id);
    notifyListeners();
  }

  void updateStockQuantity(String id, int newQuantity) {
    final index = _vehicles.indexWhere((v) => v.id == id);
    if (index != -1) {
      _vehicles[index] = _vehicles[index].copyWith(stockQuantity: newQuantity);
      notifyListeners();
    }
  }

  List<Vehicle> searchVehicles(String query) {
    if (query.isEmpty) return _vehicles;
    
    return _vehicles.where((vehicle) {
      final searchLower = query.toLowerCase();
      return vehicle.brand.toLowerCase().contains(searchLower) ||
             vehicle.model.toLowerCase().contains(searchLower) ||
             vehicle.color.toLowerCase().contains(searchLower) ||
             vehicle.year.toString().contains(searchLower);
    }).toList();
  }

  void clearError() {
    _error = '';
    notifyListeners();
  }
}
