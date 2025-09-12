# Car Shop - Sistema de Controle de Estoque

##  Sobre o Projeto

**Car Shop** é um sistema de controle de estoque desenvolvido para lojas de veículos, criado como parte da disciplina de Desenvolvimento Mobile com Dart e Flutter. O aplicativo oferece uma interface moderna e intuitiva para gerenciar o inventário de veículos, incluindo funcionalidades de cadastro, consulta, edição e controle de estoque.

##  Objetivos

- **Controle de Estoque**: Gerenciar quantidade e status dos veículos em estoque
- **Interface Moderna**: Design responsivo e intuitivo seguindo as melhores práticas de UX/UI
- **Navegação Fluida**: Sistema de rotas e navegação entre telas implementado
- **Gerenciamento de Estado**: Uso do Provider para gerenciar o estado da aplicação
- **Consumo de API**: Integração com APIs externas para dados reais
- **Formulários Validados**: Sistema completo de validação de dados

##  Funcionalidades Implementadas

###  Etapa 1 - Estrutura Inicial e Layout Base

- [x] **Configuração Inicial**: Projeto Flutter configurado com dependências necessárias
- [x] **Navegação e Rotas**: Sistema de navegação entre 3 telas principais
- [x] **Estrutura de Layouts**: Telas com layout básico usando widgets fundamentais
- [x] **Tela Principal (Home)**: Dashboard com lista de veículos e estatísticas
- [x] **Tela de Detalhes**: Visualização completa das informações do veículo
- [x] **Tela de Configurações**: Preferências e configurações do sistema
- [x] **Navegação Inferior**: Bottom navigation bar para alternar entre telas

###  Etapa 2 - UI/UX Básico, Consumo de API e Validação de Formulários

- [x] **Atomic Design**: Implementação de widgets atômicos e moleculares
  - [x] **Átomos**: CustomButton, CustomTextField
  - [x] **Moléculas**: VehicleForm (formulário completo de veículo)
- [x] **Microinterações**: Animações e feedback visual
  - [x] **VehicleCard**: Animação de escala ao tocar
  - [x] **Botões**: Estados de loading e feedback visual
  - [x] **Campos de entrada**: Animações de foco e validação
- [x] **Acessibilidade (WCAG)**: 
  - [x] **Semantics**: Labels e hints para leitores de tela
  - [x] **Contraste**: Cores com contraste adequado
  - [x] **Navegação**: Suporte a navegação por teclado
- [x] **Consumo de API**:
  - [x] **JSONPlaceholder**: Integração com API RESTful
  - [x] **FutureBuilder**: Tratamento de dados assíncronos
  - [x] **Tratamento de Erros**: Feedback visual para erros de API
- [x] **Formulários e Validação**:
  - [x] **Formulário Completo**: 8 campos com validação
  - [x] **Validação em Tempo Real**: Feedback imediato ao usuário
  - [x] **Validações Específicas**: Ano, preço, estoque com regras específicas
- [x] **Tela de Adicionar Veículo**: Interface completa para cadastro

###  Funcionalidades para Próximas Etapas

- [ ] **Edição de Veículos**: Modificar informações existentes
- [ ] **Exclusão de Veículos**: Remover veículos do estoque
- [ ] **Persistência de Dados**: Integração com banco de dados local
- [ ] **Notificações**: Alertas sobre estoque baixo
- [ ] **Relatórios**: Exportação de dados e relatórios
- [ ] **Filtros Avançados**: Busca por múltiplos critérios

##  Arquitetura do Projeto

`
lib/
 main.dart                 # Ponto de entrada da aplicação
 models/                   # Modelos de dados
    vehicle.dart         # Modelo do veículo
 providers/                # Gerenciamento de estado
    vehicle_provider.dart # Provider para veículos
 screens/                  # Telas da aplicação
    home_screen.dart     # Tela principal
    vehicle_details_screen.dart # Detalhes do veículo
    settings_screen.dart # Configurações
    add_vehicle_screen.dart # Adicionar veículo
 widgets/                  # Widgets reutilizáveis
    atoms/               # Widgets atômicos (Atomic Design)
       custom_button.dart
       custom_text_field.dart
    molecules/           # Widgets moleculares (Atomic Design)
       vehicle_form.dart
    vehicle_card.dart    # Card do veículo
    stats_card.dart      # Card de estatísticas
 services/                 # Serviços externos
    api_service.dart     # Serviço de API
 utils/                    # Utilitários e helpers
`

##  Tecnologias Utilizadas

- **Flutter**: Framework de desenvolvimento mobile
- **Dart**: Linguagem de programação
- **Provider**: Gerenciamento de estado
- **Material Design 3**: Sistema de design do Google
- **HTTP**: Para integrações com APIs
- **Shared Preferences**: Para persistência local
- **Flutter SVG**: Para ícones vetoriais

##  Telas Implementadas

### 1. **Tela Principal (Home)**
- Dashboard com estatísticas do estoque
- Lista de veículos com cards informativos
- Barra de pesquisa funcional
- Botão para adicionar novos veículos
- Botão para carregar dados da API
- Indicadores visuais de status do estoque

### 2. **Tela de Detalhes do Veículo**
- Informações completas do veículo
- Imagem em destaque
- Dados técnicos e comerciais
- Ações para editar e excluir
- Controle de estoque

### 3. **Tela de Adicionar Veículo**
- Formulário completo com validação
- 8 campos com validação específica
- Feedback visual em tempo real
- Integração com API
- Design responsivo e acessível

### 4. **Tela de Configurações**
- Preferências do usuário
- Configurações do sistema
- Informações sobre o aplicativo
- Opções de backup e exportação

##  Design e UX

### **Atomic Design**
- **Átomos**: Componentes básicos reutilizáveis (botões, campos de texto)
- **Moléculas**: Combinações de átomos (formulários, cards)
- **Organismos**: Seções complexas da interface

### **Microinterações**
- **Animações de Toque**: Feedback visual ao interagir com elementos
- **Estados de Loading**: Indicadores visuais durante carregamento
- **Transições Suaves**: Animações entre estados e telas
- **Feedback Imediato**: Resposta visual instantânea às ações

### **Acessibilidade (WCAG)**
- **Semantics**: Labels descritivos para leitores de tela
- **Contraste**: Cores com contraste adequado (4.5:1 mínimo)
- **Tamanho de Toque**: Elementos com área mínima de 44x44 pixels
- **Navegação**: Suporte completo a navegação por teclado
- **Legibilidade**: Tipografia clara e tamanhos adequados

### **Material Design 3**
- Interface moderna e consistente
- Cores: Paleta baseada em azul para transmitir confiança
- Tipografia: Roboto para melhor legibilidade
- Cards: Layout em cards para melhor organização visual
- Responsividade: Adaptação para diferentes tamanhos de tela
- Ícones: Uso consistente de ícones Material Design

##  Integração com API

### **JSONPlaceholder**
- **Endpoint**: https://jsonplaceholder.typicode.com/posts
- **Métodos**: GET, POST, PUT, DELETE
- **Tratamento de Erros**: Feedback visual para falhas de conexão
- **Loading States**: Indicadores durante requisições
- **Dados Simulados**: Conversão de dados da API para formato de veículos

### **Funcionalidades da API**
- **Buscar Veículos**: Lista completa de veículos
- **Buscar por ID**: Veículo específico
- **Criar Veículo**: Adicionar novo veículo
- **Atualizar Veículo**: Modificar veículo existente
- **Excluir Veículo**: Remover veículo do sistema

##  Validação de Formulários

### **Campos Validados**
1. **Marca**: Campo obrigatório
2. **Modelo**: Campo obrigatório
3. **Ano**: Número entre 1900 e ano atual + 1
4. **Cor**: Campo obrigatório
5. **Preço**: Número maior que zero
6. **Estoque**: Número não negativo
7. **Descrição**: Campo obrigatório
8. **URL da Imagem**: Campo obrigatório

### **Validações Implementadas**
- **Tempo Real**: Validação durante digitação
- **Mensagens Específicas**: Feedback claro sobre erros
- **Prevenção de Envio**: Formulário só é enviado se válido
- **Estados Visuais**: Campos com erro destacados visualmente

##  Dados de Exemplo

O sistema inclui dados mockados para demonstração:
- Toyota Corolla 2023
- Honda Civic 2023
- Volkswagen Golf 2023
- Ford Focus 2023

Cada veículo possui informações completas incluindo preço, quantidade em estoque, descrição e imagem.

##  Como Executar

1. **Clone o repositório**:
   `ash
   git clone [URL_DO_REPOSITORIO]
   cd car_shop
   `

2. **Instale as dependências**:
   `ash
   flutter pub get
   `

3. **Execute o aplicativo**:
   `ash
   flutter run
   `

##  Pré-requisitos

- Flutter SDK 3.8.1 ou superior
- Dart SDK
- Android Studio / VS Code
- Emulador Android ou dispositivo físico
- Conexão com internet (para consumo de API)

##  Dependências

`yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  http: ^1.1.0
  provider: ^6.1.1
  shared_preferences: ^2.2.2
  intl: ^0.19.0
  flutter_svg: ^2.0.9
`

##  Notas de Desenvolvimento

### **Arquitetura**
- **Estado**: Gerenciado com Provider para simplicidade e eficiência
- **Navegação**: Implementada com MaterialPageRoute e BottomNavigationBar
- **Widgets**: Componentes reutilizáveis seguindo Atomic Design
- **Responsividade**: Layout adaptativo para diferentes dispositivos
- **Acessibilidade**: Implementação completa de diretrizes WCAG

### **Padrões de Código**
- **Atomic Design**: Organização hierárquica de componentes
- **Separação de Responsabilidades**: Código organizado por funcionalidade
- **Reutilização**: Widgets atômicos e moleculares reutilizáveis
- **Manutenibilidade**: Código limpo e bem documentado

##  Disciplina

**DSWM IV TA (2025-2)**  
**Professor**: Giovane Galvão  
**Período**: 6º Período  
**Semestre**: 2025.2

##  Desenvolvedores

- José Afonso Machado da Cruz
- Luis Gustavo Romanichen Domingues
- Gustavo Ferreira dos Santos

##  Cronograma

- **Entrega Parcial 1**: 22/08/2025 
- **Entrega Parcial 2**: 05/09/2025 
- **Apresentação Final**: 13/09/2025 

##  Conquistas da Etapa 2

### **UI/UX**
-  Implementação completa do Atomic Design
-  Microinterações fluidas e responsivas
-  Acessibilidade seguindo diretrizes WCAG
-  Design responsivo e moderno

### **Funcionalidades Técnicas**
-  Consumo de API RESTful funcional
-  Formulários com validação completa
-  Tratamento de erros robusto
-  Estados de loading bem implementados

### **Qualidade do Código**
-  Arquitetura limpa e organizada
-  Componentes reutilizáveis
-  Documentação completa
-  Padrões de desenvolvimento consistentes

**Car Shop** - Controle de Estoque para Lojas de Veículos 
