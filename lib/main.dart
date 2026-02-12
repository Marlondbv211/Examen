import 'package:flutter/material.dart';

void main() {
  runApp(const MaintenanceApp());
}

class MaintenanceApp extends StatelessWidget {
  const MaintenanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistema de Mantenimiento',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2196F3),
          brightness: Brightness.light,
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Colors.grey.shade50,
        ),
      ),
      home: const MaintenanceScreen(),
    );
  }
}

class MaintenanceOrder {
  final String id;
  final String orderId;
  final String technician;
  final String area;
  final String priority;
  final String description;
  final DateTime createdAt;

  MaintenanceOrder({
    required this.id,
    required this.orderId,
    required this.technician,
    required this.area,
    required this.priority,
    required this.description,
    required this.createdAt,
  });
}

class MaintenanceScreen extends StatefulWidget {
  const MaintenanceScreen({super.key});

  @override
  State<MaintenanceScreen> createState() => _MaintenanceScreenState();
}

class _MaintenanceScreenState extends State<MaintenanceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _orderIdController = TextEditingController();
  final _technicianController = TextEditingController();
  final _areaController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  String _selectedPriority = 'Media';
  final List<String> _priorities = ['Baja', 'Media', 'Alta', 'Crítica'];
  
  final List<MaintenanceOrder> _orders = [];
  MaintenanceOrder? _selectedOrder;

  @override
  void dispose() {
    _orderIdController.dispose();
    _technicianController.dispose();
    _areaController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitOrder() {
    if (_formKey.currentState!.validate()) {
      final newOrder = MaintenanceOrder(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        orderId: _orderIdController.text.trim(),
        technician: _technicianController.text.trim(),
        area: _areaController.text.trim(),
        priority: _selectedPriority,
        description: _descriptionController.text.trim(),
        createdAt: DateTime.now(),
      );

      setState(() {
        _orders.insert(0, newOrder);
        _clearForm();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✓ Orden registrada exitosamente'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _clearForm() {
    setState(() {
      _orderIdController.clear();
      _technicianController.clear();
      _areaController.clear();
      _descriptionController.clear();
      _selectedPriority = 'Media';
    });
    _formKey.currentState?.reset();
  }

  void _deleteOrder(String id) {
    setState(() {
      _orders.removeWhere((order) => order.id == id);
      if (_selectedOrder?.id == id) {
        _selectedOrder = null;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Orden eliminada'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _showOrderDetails(MaintenanceOrder order) {
    setState(() {
      _selectedOrder = order;
    });
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'Baja':
        return Colors.green;
      case 'Media':
        return Colors.orange;
      case 'Alta':
        return Colors.deepOrange;
      case 'Crítica':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getPriorityIcon(String priority) {
    switch (priority) {
      case 'Baja':
        return Icons.arrow_downward;
      case 'Media':
        return Icons.remove;
      case 'Alta':
        return Icons.arrow_upward;
      case 'Crítica':
        return Icons.warning;
      default:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sistema de Órdenes de Mantenimiento'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Sección de Presentación
              _buildWelcomeSection(),
              const SizedBox(height: 24),

              // Sección de Captura
              _buildRegistrationSection(),
              const SizedBox(height: 24),

              // Sección de Visualización
              _buildVisualizationSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(
              Icons.build_circle,
              size: 48,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bienvenido',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Registra y gestiona órdenes de mantenimiento',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Total de órdenes: ${_orders.length}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRegistrationSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.add_circle,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Registrar Nueva Orden',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // ID de Orden
              CustomTextField(
                controller: _orderIdController,
                label: 'ID de Orden',
                icon: Icons.tag,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'El ID de orden es requerido';
                  }
                  if (value.trim().length < 3) {
                    return 'El ID debe tener al menos 3 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // Técnico
              CustomTextField(
                controller: _technicianController,
                label: 'Técnico Responsable',
                icon: Icons.person,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'El nombre del técnico es requerido';
                  }
                  if (value.trim().length < 3) {
                    return 'El nombre debe tener al menos 3 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // Área/Equipo
              CustomTextField(
                controller: _areaController,
                label: 'Área o Equipo',
                icon: Icons.location_on,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'El área o equipo es requerido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // Prioridad
              DropdownButtonFormField<String>(
                value: _selectedPriority,
                decoration: InputDecoration(
                  labelText: 'Nivel de Prioridad',
                  prefixIcon: Icon(
                    _getPriorityIcon(_selectedPriority),
                    color: _getPriorityColor(_selectedPriority),
                  ),
                ),
                items: _priorities.map((priority) {
                  return DropdownMenuItem(
                    value: priority,
                    child: Row(
                      children: [
                        Icon(
                          _getPriorityIcon(priority),
                          color: _getPriorityColor(priority),
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(priority),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedPriority = value!;
                  });
                },
              ),
              const SizedBox(height: 12),

              // Descripción
              CustomTextField(
                controller: _descriptionController,
                label: 'Descripción del Trabajo',
                icon: Icons.description,
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'La descripción es requerida';
                  }
                  if (value.trim().length < 10) {
                    return 'La descripción debe tener al menos 10 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Botones
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _submitOrder,
                      icon: const Icon(Icons.save),
                      label: const Text('Registrar Orden'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  OutlinedButton.icon(
                    onPressed: _clearForm,
                    icon: const Icon(Icons.clear),
                    label: const Text('Limpiar'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVisualizationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.list_alt,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 8),
            Text(
              'Órdenes Registradas',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        if (_orders.isEmpty)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.inbox,
                      size: 64,
                      color: Colors.grey.shade300,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No hay órdenes registradas',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.grey.shade600,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Registra tu primera orden de mantenimiento',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey.shade500,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _orders.length,
            itemBuilder: (context, index) {
              final order = _orders[index];
              final isSelected = _selectedOrder?.id == order.id;

              return OrderCard(
                order: order,
                isSelected: isSelected,
                onTap: () => _showOrderDetails(order),
                onDelete: () => _showDeleteConfirmation(order),
                getPriorityColor: _getPriorityColor,
                getPriorityIcon: _getPriorityIcon,
              );
            },
          ),

        // Detalle de orden seleccionada
        if (_selectedOrder != null) ...[
          const SizedBox(height: 16),
          OrderDetailCard(
            order: _selectedOrder!,
            onClose: () {
              setState(() {
                _selectedOrder = null;
              });
            },
            getPriorityColor: _getPriorityColor,
            getPriorityIcon: _getPriorityIcon,
          ),
        ],
      ],
    );
  }

  void _showDeleteConfirmation(MaintenanceOrder order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar Eliminación'),
        content: Text(
          '¿Estás seguro de eliminar la orden "${order.orderId}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              _deleteOrder(order.id);
            },
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }
}

// Widget reutilizable para campos de texto
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final String? Function(String?)? validator;
  final int maxLines;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.validator,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
      ),
      maxLines: maxLines,
      validator: validator,
    );
  }
}

// Widget reutilizable para tarjetas de órdenes
class OrderCard extends StatelessWidget {
  final MaintenanceOrder order;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final Color Function(String) getPriorityColor;
  final IconData Function(String) getPriorityIcon;

  const OrderCard({
    super.key,
    required this.order,
    required this.isSelected,
    required this.onTap,
    required this.onDelete,
    required this.getPriorityColor,
    required this.getPriorityIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: isSelected ? 4 : 1,
      color: isSelected
          ? Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3)
          : null,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: getPriorityColor(order.priority).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: getPriorityColor(order.priority),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          getPriorityIcon(order.priority),
                          size: 14,
                          color: getPriorityColor(order.priority),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          order.priority,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: getPriorityColor(order.priority),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: onDelete,
                    color: Colors.red,
                    iconSize: 20,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                order.orderId,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.person, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    order.technician,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(width: 16),
                  const Icon(Icons.location_on, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      order.area,
                      style: Theme.of(context).textTheme.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                order.description,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade700,
                    ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget reutilizable para detalle de orden
class OrderDetailCard extends StatelessWidget {
  final MaintenanceOrder order;
  final VoidCallback onClose;
  final Color Function(String) getPriorityColor;
  final IconData Function(String) getPriorityIcon;

  const OrderDetailCard({
    super.key,
    required this.order,
    required this.onClose,
    required this.getPriorityColor,
    required this.getPriorityIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.tertiaryContainer.withValues(alpha: 0.3),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Detalle de la Orden',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: onClose,
                  iconSize: 20,
                ),
              ],
            ),
            const Divider(height: 24),
            _buildDetailRow(
              context,
              'ID de Orden',
              order.orderId,
              Icons.tag,
            ),
            const SizedBox(height: 12),
            _buildDetailRow(
              context,
              'Técnico Responsable',
              order.technician,
              Icons.person,
            ),
            const SizedBox(height: 12),
            _buildDetailRow(
              context,
              'Área o Equipo',
              order.area,
              Icons.location_on,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  getPriorityIcon(order.priority),
                  size: 20,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(width: 8),
                Text(
                  'Prioridad: ',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: getPriorityColor(order.priority).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: getPriorityColor(order.priority),
                    ),
                  ),
                  child: Text(
                    order.priority,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: getPriorityColor(order.priority),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildDetailRow(
              context,
              'Fecha de Registro',
              _formatDate(order.createdAt),
              Icons.calendar_today,
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.description,
                  size: 20,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Descripción:',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        order.description,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: Colors.grey.shade600,
        ),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}