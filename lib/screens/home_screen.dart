import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../providers/vehicle_provider.dart';
import '../widgets/vehicle_card.dart';
import '../widgets/stats_card.dart';
import '../widgets/atoms/custom_button.dart';
import 'vehicle_details_screen.dart';
import 'add_vehicle_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchQuery = '';
  bool _isLoadingApi = false;

  @override
  void initState() {
    super.initState();
    // Carrega dados mockados quando a tela é inicializada
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<VehicleProvider>().loadMockData();
    });
  }

  Future<void> _loadFromApi() async {
    setState(() {
      _isLoadingApi = true;
    });
    
    await context.read<VehicleProvider>().loadVehiclesFromApi();
    
    setState(() {
      _isLoadingApi = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SvgPicture.asset(
                'assets/images/Logo Site.svg',
                height: 48,
                colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF2c3e50),
                Color(0xFF3498db),
              ],
            ),
          ),
        ),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: _loadFromApi,
            icon: _isLoadingApi
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Icon(Icons.refresh),
            tooltip: 'Carregar da API',
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2d3748),
              Color(0xFF1a202c),
            ],
          ),
        ),
        child: Consumer<VehicleProvider>(
          builder: (context, vehicleProvider, child) {
            final vehicles = _searchQuery.isEmpty
                ? vehicleProvider.vehicles
                : vehicleProvider.searchVehicles(_searchQuery);

            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Pesquisar veículos...',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                      filled: true,
                      fillColor: Colors.white.withValues(alpha: 0.1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: StatsCard(
                          title: 'Total de Veículos',
                          value: vehicleProvider.vehicles.length.toString(),
                          icon: Icons.directions_car,
                          color: const Color(0xFF3498db),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: StatsCard(
                          title: 'Em Estoque',
                          value: vehicleProvider.vehicles
                              .where((v) => v.stockQuantity > 0)
                              .length
                              .toString(),
                          icon: Icons.inventory,
                          color: const Color(0xFF2ecc71),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomButton(
                    text: 'Adicionar Veículo',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddVehicleScreen(),
                        ),
                      );
                    },
                    icon: Icons.add,
                    backgroundColor: const Color(0xFF2ecc71),
                    width: double.infinity,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: vehicleProvider.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Color(0xFF3498db),
                            ),
                          ),
                        )
                      : vehicles.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.search_off,
                                    size: 64,
                                    color: Colors.grey[400],
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    _searchQuery.isEmpty
                                        ? 'Nenhum veículo cadastrado'
                                        : 'Nenhum veículo encontrado para ""',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.all(16),
                              itemCount: vehicles.length,
                              itemBuilder: (context, index) {
                                final vehicle = vehicles[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: VehicleCard(
                                    vehicle: vehicle,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => VehicleDetailsScreen(vehicle: vehicle),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
