import 'package:flutter/material.dart';
import '../models/vehicle.dart';

class VehicleDetailsScreen extends StatelessWidget {
  final Vehicle vehicle;

  const VehicleDetailsScreen({
    super.key,
    required this.vehicle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${vehicle.brand} ${vehicle.model}'),
        backgroundColor: const Color(0xFF1E3A8A),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // TODO: Implementar edição
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Funcionalidade será implementada na próxima etapa'),
                ),
              );
            },
            tooltip: 'Editar Veículo',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagem do veículo
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                vehicle.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: Icon(
                      Icons.directions_car,
                      size: 100,
                      color: Colors.grey[600],
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título principal
                  Text(
                    '${vehicle.brand} ${vehicle.model}',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Ano e cor
                  Text(
                    '${vehicle.year} • ${vehicle.color}',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Preço
                  Container(
                    padding: const EdgeInsets.all(16),
                                         decoration: BoxDecoration(
                       color: const Color(0xFF10B981).withValues(alpha: 0.1),
                       borderRadius: BorderRadius.circular(12),
                       border: Border.all(
                         color: const Color(0xFF10B981).withValues(alpha: 0.3),
                       ),
                     ),
                    child: Row(
                      children: [
                                                 Icon(
                           Icons.attach_money,
                           color: const Color(0xFF059669),
                           size: 32,
                         ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Preço',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                                                         Text(
                               'R\$ ${vehicle.price.toStringAsFixed(2)}',
                               style: TextStyle(
                                 fontSize: 28,
                                 fontWeight: FontWeight.bold,
                                 color: const Color(0xFF059669),
                               ),
                             ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Informações do estoque
                  _buildInfoSection(
                    'Informações do Estoque',
                    [
                      _buildInfoRow('Quantidade em Estoque', '${vehicle.stockQuantity} unidades'),
                      _buildInfoRow('Status', vehicle.stockQuantity > 0 ? 'Em Estoque' : 'Sem Estoque'),
                      _buildInfoRow('Data de Cadastro', _formatDate(vehicle.createdAt)),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Descrição
                  _buildInfoSection(
                    'Descrição',
                    [
                      _buildInfoRow('Detalhes', vehicle.description),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Ações
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // TODO: Implementar ajuste de estoque
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Funcionalidade será implementada na próxima etapa'),
                              ),
                            );
                          },
                          icon: const Icon(Icons.inventory),
                          label: const Text('Ajustar Estoque'),
                                                     style: ElevatedButton.styleFrom(
                             backgroundColor: const Color(0xFF3B82F6),
                             foregroundColor: Colors.white,
                             padding: const EdgeInsets.symmetric(vertical: 16),
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(12),
                             ),
                           ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            // TODO: Implementar exclusão
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Funcionalidade será implementada na próxima etapa'),
                              ),
                            );
                          },
                          icon: const Icon(Icons.delete),
                          label: const Text('Excluir'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red[600],
                            side: BorderSide(color: Colors.red[600]!),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}
