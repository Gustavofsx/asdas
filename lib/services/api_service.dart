import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/vehicle.dart';

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  static const String vehiclesEndpoint = '/posts';

  // Simula busca de veículos da API
  static Future<List<Vehicle>> fetchVehicles() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl$vehiclesEndpoint'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        
        // Converte os dados da API para o formato de veículos
        return data.take(10).map((json) {
          final id = json['id'] as int;
          return Vehicle(
            id: id.toString(),
            brand: _getRandomBrand(),
            model: _getRandomModel(),
            year: 2020 + (id % 4),
            color: _getRandomColor(),
            price: 30000.0 + (id * 5000),
            stockQuantity: (id % 10) + 1,
            description: json['body'] ?? 'Descrição do veículo',
            imageUrl: 'https://picsum.photos/400/300?random=$id',
            createdAt: DateTime.now().subtract(Duration(days: id)),
          );
        }).toList();
      } else {
        throw Exception('Falha ao carregar veículos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro na conexão: $e');
    }
  }

  // Simula busca de um veículo específico
  static Future<Vehicle?> fetchVehicleById(String id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl$vehiclesEndpoint/$id'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final vehicleId = data['id'] as int;
        
        return Vehicle(
          id: vehicleId.toString(),
          brand: _getRandomBrand(),
          model: _getRandomModel(),
          year: 2020 + (vehicleId % 4),
          color: _getRandomColor(),
          price: 30000.0 + (vehicleId * 5000),
          stockQuantity: (vehicleId % 10) + 1,
          description: data['body'] ?? 'Descrição do veículo',
          imageUrl: 'https://picsum.photos/400/300?random=$vehicleId',
          createdAt: DateTime.now().subtract(Duration(days: vehicleId)),
        );
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Simula criação de um novo veículo
  static Future<Vehicle?> createVehicle(Map<String, dynamic> vehicleData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$vehiclesEndpoint'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'title': '${vehicleData['brand']} ${vehicleData['model']}',
          'body': vehicleData['description'],
          'userId': 1,
        }),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> data = json.decode(response.body);
        
        return Vehicle(
          id: data['id'].toString(),
          brand: vehicleData['brand'],
          model: vehicleData['model'],
          year: vehicleData['year'],
          color: vehicleData['color'],
          price: vehicleData['price'],
          stockQuantity: vehicleData['stockQuantity'],
          description: vehicleData['description'],
          imageUrl: vehicleData['imageUrl'],
          createdAt: DateTime.now(),
        );
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Simula atualização de um veículo
  static Future<Vehicle?> updateVehicle(String id, Map<String, dynamic> vehicleData) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl$vehiclesEndpoint/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'id': int.parse(id),
          'title': '${vehicleData['brand']} ${vehicleData['model']}',
          'body': vehicleData['description'],
          'userId': 1,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        
        return Vehicle(
          id: data['id'].toString(),
          brand: vehicleData['brand'],
          model: vehicleData['model'],
          year: vehicleData['year'],
          color: vehicleData['color'],
          price: vehicleData['price'],
          stockQuantity: vehicleData['stockQuantity'],
          description: vehicleData['description'],
          imageUrl: vehicleData['imageUrl'],
          createdAt: DateTime.now(),
        );
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Simula exclusão de um veículo
  static Future<bool> deleteVehicle(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl$vehiclesEndpoint/$id'),
        headers: {'Content-Type': 'application/json'},
      );

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  // Métodos auxiliares para gerar dados aleatórios
  static String _getRandomBrand() {
    final brands = ['Toyota', 'Honda', 'Volkswagen', 'Ford', 'Chevrolet', 'Nissan', 'Hyundai', 'Kia'];
    return brands[DateTime.now().millisecond % brands.length];
  }

  static String _getRandomModel() {
    final models = ['Corolla', 'Civic', 'Golf', 'Focus', 'Cruze', 'Sentra', 'Elantra', 'Forte'];
    return models[DateTime.now().millisecond % models.length];
  }

  static String _getRandomColor() {
    final colors = ['Branco', 'Preto', 'Prata', 'Azul', 'Vermelho', 'Cinza', 'Verde', 'Dourado'];
    return colors[DateTime.now().millisecond % colors.length];
  }
}
