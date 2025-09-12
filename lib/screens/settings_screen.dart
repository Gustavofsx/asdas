import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  String _selectedLanguage = 'Português';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Configurações',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF1E3A8A),
        elevation: 0,
      ),
      body: ListView(
        children: [
          // Seção de Preferências
          _buildSectionHeader('Preferências'),
          
          // Notificações
          _buildSwitchTile(
            title: 'Notificações',
            subtitle: 'Receber alertas sobre estoque baixo',
            value: _notificationsEnabled,
            onChanged: (value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
            icon: Icons.notifications,
          ),
          
          // Modo escuro
          _buildSwitchTile(
            title: 'Modo Escuro',
            subtitle: 'Ativar tema escuro',
            value: _darkModeEnabled,
            onChanged: (value) {
              setState(() {
                _darkModeEnabled = value;
              });
            },
            icon: Icons.dark_mode,
          ),
          
          // Idioma
          _buildListTile(
            title: 'Idioma',
            subtitle: _selectedLanguage,
            icon: Icons.language,
            onTap: () {
              _showLanguageDialog();
            },
          ),
          
          const Divider(),
          
          // Seção de Sistema
          _buildSectionHeader('Sistema'),
          
          // Sobre o app
          _buildListTile(
            title: 'Sobre o App',
            subtitle: 'Versão 1.0.0',
            icon: Icons.info,
            onTap: () {
              _showAboutDialog();
            },
          ),
          
          // Política de privacidade
          _buildListTile(
            title: 'Política de Privacidade',
            subtitle: 'Como seus dados são utilizados',
            icon: Icons.privacy_tip,
            onTap: () {
              // TODO: Implementar navegação para política de privacidade
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Funcionalidade será implementada na próxima etapa'),
                ),
              );
            },
          ),
          
          // Termos de uso
          _buildListTile(
            title: 'Termos de Uso',
            subtitle: 'Condições de utilização do app',
            icon: Icons.description,
            onTap: () {
              // TODO: Implementar navegação para termos de uso
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Funcionalidade será implementada na próxima etapa'),
                ),
              );
            },
          ),
          
          const Divider(),
          
          // Seção de Dados
          _buildSectionHeader('Dados'),
          
          // Exportar dados
          _buildListTile(
            title: 'Exportar Dados',
            subtitle: 'Baixar relatório em CSV',
            icon: Icons.download,
            onTap: () {
              // TODO: Implementar exportação de dados
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Funcionalidade será implementada na próxima etapa'),
                ),
              );
            },
          ),
          
          // Backup automático
          _buildSwitchTile(
            title: 'Backup Automático',
            subtitle: 'Fazer backup dos dados automaticamente',
            value: true,
            onChanged: (value) {
              // TODO: Implementar configuração de backup
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Funcionalidade será implementada na próxima etapa'),
                ),
              );
            },
            icon: Icons.backup,
          ),
          
          const SizedBox(height: 20),
          
          // Botão de limpar dados
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: OutlinedButton.icon(
              onPressed: () {
                _showClearDataDialog();
              },
              icon: const Icon(Icons.delete_forever, color: Colors.red),
              label: const Text(
                'Limpar Todos os Dados',
                style: TextStyle(color: Colors.red),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.red),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF1E3A8A),
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required IconData icon,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFF3B82F6).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: const Color(0xFF1E40AF)),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: const Color(0xFF3B82F6),
      ),
    );
  }

  Widget _buildListTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFF3B82F6).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: const Color(0xFF1E40AF)),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Selecionar Idioma'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: const Text('Português'),
              value: 'Português',
              groupValue: _selectedLanguage,
              onChanged: (value) {
                setState(() {
                  _selectedLanguage = value!;
                });
                Navigator.pop(context);
              },
            ),
            RadioListTile<String>(
              title: const Text('English'),
              value: 'English',
              groupValue: _selectedLanguage,
              onChanged: (value) {
                setState(() {
                  _selectedLanguage = value!;
                });
                Navigator.pop(context);
              },
            ),
            RadioListTile<String>(
              title: const Text('Español'),
              value: 'Español',
              groupValue: _selectedLanguage,
              onChanged: (value) {
                setState(() {
                  _selectedLanguage = value!;
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showAboutDialog() {
    showAboutDialog(
      context: context,
      applicationName: 'Car Shop',
      applicationVersion: '1.0.0',
      applicationIcon: Icon(
        Icons.directions_car,
        size: 48,
        color: const Color(0xFF3B82F6),
      ),
      children: [
        const Text(
          'Sistema de controle de estoque para loja de veículos.\n\n'
          'Desenvolvido com Flutter para a disciplina de Desenvolvimento Mobile.',
        ),
      ],
    );
  }

  void _showClearDataDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Limpar Dados'),
        content: const Text(
          'Tem certeza que deseja limpar todos os dados? '
          'Esta ação não pode ser desfeita.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              // TODO: Implementar limpeza de dados
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Funcionalidade será implementada na próxima etapa'),
                ),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Limpar'),
          ),
        ],
      ),
    );
  }
}
