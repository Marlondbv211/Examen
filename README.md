Sistema de Órdenes de Mantenimiento - Flutter
Aplicación Flutter de una sola pantalla para gestionar órdenes de mantenimiento.
✨ Características Implementadas
🎨 Diseño y Tema

✅ Material 3 implementado
✅ Tema personalizado con colores azules
✅ Cards con bordes redondeados y elevación
✅ Campos de entrada con estilo personalizado

📝 Funcionalidades
Registro de Órdenes

ID de Orden: Campo de texto validado (mínimo 3 caracteres)
Técnico Responsable: Campo de texto validado (mínimo 3 caracteres)
Área o Equipo: Campo de texto obligatorio
Nivel de Prioridad: Dropdown con 4 niveles:

🟢 Baja
🟠 Media
🟤 Alta
🔴 Crítica


Descripción del Trabajo: Campo de texto multilínea (mínimo 10 caracteres)

Visualización

Lista de órdenes registradas con información resumida
Tarjetas con código de colores según prioridad
Indicador visual de orden seleccionada
Mensaje amigable cuando no hay órdenes

Gestión

✅ Consultar detalle: Click en cualquier tarjeta
✅ Eliminar orden: Botón de eliminar con confirmación
✅ Panel de detalle: Muestra toda la información de la orden seleccionada

🔒 Validaciones Implementadas

ID de Orden:

No puede estar vacío
Mínimo 3 caracteres


Técnico Responsable:

No puede estar vacío
Mínimo 3 caracteres


Área o Equipo:

No puede estar vacío


Prioridad:

Selección obligatoria (valor por defecto: Media)


Descripción:

No puede estar vacía
Mínimo 10 caracteres



🎯 Organización del Código
Widgets Reutilizables

CustomTextField: Campo de texto personalizado con validación
OrderCard: Tarjeta para mostrar resumen de orden
OrderDetailCard: Panel de detalle completo de la orden

Secciones de la Pantalla

Sección de Presentación (_buildWelcomeSection):

Bienvenida al usuario
Contador de órdenes registradas


Sección de Captura (_buildRegistrationSection):

Formulario completo de registro
Botones de acción (Registrar y Limpiar)


Sección de Visualización (_buildVisualizationSection):

Lista de órdenes
Panel de detalle de orden seleccionada



🏗️ Estructura del Proyecto
maintenance_app/
├── lib/
│   └── main.dart          # Aplicación completa
├── pubspec.yaml           # Dependencias
└── README.md              # Este archivo
🚀 Cómo Ejecutar

Asegúrate de tener Flutter instalado:

bash   flutter --version

Navega al directorio del proyecto:

bash   cd maintenance_app

Obtén las dependencias:

bash   flutter pub get

Ejecuta la aplicación:

bash   flutter run
📱 Uso de la Aplicación
Registrar una Orden

Completa todos los campos del formulario
Selecciona el nivel de prioridad
Click en "Registrar Orden"
La orden aparecerá en la lista

Consultar Detalle

Click en cualquier tarjeta de la lista
El panel de detalle se mostrará debajo
Click en la "X" para cerrar el detalle

Eliminar una Orden

Click en el icono de eliminar (🗑️) en la tarjeta
Confirma la eliminación en el diálogo
La orden se eliminará de la lista

Limpiar el Formulario

Click en el botón "Limpiar" para resetear todos los campos

🎨 Características de Diseño

Indicadores visuales de prioridad:

Iconos específicos por nivel
Colores diferenciados
Badges con bordes


Feedback al usuario:

SnackBars para confirmación de acciones
Diálogos de confirmación para eliminación
Validación en tiempo real en formularios


Responsividad:

ScrollView para contenido largo
Cards adaptables
Layout organizado por secciones



✅ Cumplimiento de Requisitos

✅ Una sola pantalla (todo en MaintenanceScreen)
✅ Material 3 implementado
✅ Tema personalizado
✅ Validaciones en todos los campos
✅ No permite registros incompletos
✅ Visualización de órdenes registradas
✅ Consulta de detalle
✅ Eliminación de órdenes
✅ Widgets reutilizables (CustomTextField, OrderCard, OrderDetailCard)
✅ Código limpio y organizado
✅ Sin navegación entre pantallas
✅ Sin APIs ni bases de datos
✅ Compila sin errores

📊 Modelo de Datos
dartclass MaintenanceOrder {
  final String id;              // ID único generado automáticamente
  final String orderId;         // ID de la orden (ingresado por usuario)
  final String technician;      // Técnico responsable
  final String area;            // Área o equipo
  final String priority;        // Nivel de prioridad
  final String description;     // Descripción del trabajo
  final DateTime createdAt;     // Fecha de creación
}
🎯 Funciones Principales

_submitOrder(): Valida y registra una nueva orden
_deleteOrder(String id): Elimina una orden
_showOrderDetails(MaintenanceOrder order): Muestra el detalle
_clearForm(): Limpia el formulario
_getPriorityColor(String priority): Retorna el color según prioridad
_getPriorityIcon(String priority): Retorna el icono según prioridad

🔄 Estado de la Aplicación
La aplicación mantiene su estado usando:

List<MaintenanceOrder> _orders: Lista de todas las órdenes
MaintenanceOrder? _selectedOrder: Orden actualmente seleccionada
Controllers para los campos de texto
_selectedPriority: Prioridad seleccionada en el dropdown

💡 Mejoras Implementadas

UX mejorada:

Confirmación antes de eliminar
Mensajes de éxito/error
Estado visual de selección


Validaciones robustas:

Trim en todos los inputs
Longitud mínima validada
Mensajes de error claros


Diseño profesional:

Consistencia visual
Jerarquía de información clara
Uso efectivo del color