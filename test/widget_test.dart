// Tests básicos para la aplicación de órdenes de mantenimiento

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maintenance_app/main.dart';

void main() {
  testWidgets('La aplicación inicia correctamente', (WidgetTester tester) async {
    // Construir la aplicación
    await tester.pumpWidget(const MaintenanceApp());

    // Verificar que el título de la app está presente
    expect(find.text('Sistema de Órdenes de Mantenimiento'), findsOneWidget);

    // Verificar que la sección de bienvenida está presente
    expect(find.text('Bienvenido'), findsOneWidget);

    // Verificar que el formulario está presente
    expect(find.text('Registrar Nueva Orden'), findsOneWidget);

    // Verificar que los campos del formulario están presentes
    expect(find.text('ID de Orden'), findsOneWidget);
    expect(find.text('Técnico Responsable'), findsOneWidget);
    expect(find.text('Área o Equipo'), findsOneWidget);
    expect(find.text('Nivel de Prioridad'), findsOneWidget);
    expect(find.text('Descripción del Trabajo'), findsOneWidget);
  });

  testWidgets('Muestra mensaje cuando no hay órdenes', (WidgetTester tester) async {
    // Construir la aplicación
    await tester.pumpWidget(const MaintenanceApp());

    // Verificar que muestra el mensaje de sin órdenes
    expect(find.text('No hay órdenes registradas'), findsOneWidget);
    expect(find.text('Registra tu primera orden de mantenimiento'), findsOneWidget);
  });

  testWidgets('Validación de campos vacíos', (WidgetTester tester) async {
    // Construir la aplicación
    await tester.pumpWidget(const MaintenanceApp());

    // Scroll hasta el botón si es necesario
    await tester.ensureVisible(find.text('Registrar Orden'));
    
    // Intentar registrar sin llenar los campos
    await tester.tap(find.text('Registrar Orden'));
    await tester.pumpAndSettle();

    // Verificar que aparecen mensajes de error (al menos uno)
    // Los mensajes de error en Flutter suelen mostrarse en Text widgets
    expect(find.textContaining('requerido'), findsWidgets);
  });

  testWidgets('Puede registrar una orden completa', (WidgetTester tester) async {
    // Construir la aplicación
    await tester.pumpWidget(const MaintenanceApp());

    // Llenar el formulario
    await tester.enterText(
      find.widgetWithText(TextFormField, 'ID de Orden'),
      'ORD-001',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Técnico Responsable'),
      'Juan Pérez',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Área o Equipo'),
      'Producción',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Descripción del Trabajo'),
      'Mantenimiento preventivo de máquina cortadora',
    );

    // Registrar la orden
    await tester.tap(find.text('Registrar Orden'));
    await tester.pump();

    // Verificar que la orden fue registrada
    expect(find.text('ORD-001'), findsOneWidget);
    expect(find.text('Juan Pérez'), findsOneWidget);
  });

  testWidgets('Botón limpiar resetea el formulario', (WidgetTester tester) async {
    // Construir la aplicación
    await tester.pumpWidget(const MaintenanceApp());

    // Encontrar el campo de ID de Orden
    final idField = find.ancestor(
      of: find.text('ID de Orden'),
      matching: find.byType(TextFormField),
    );

    // Llenar el campo
    await tester.enterText(idField, 'ORD-001');
    await tester.pump();

    // Verificar que el texto está presente en el campo
    expect(find.text('ORD-001'), findsOneWidget);

    // Hacer scroll para asegurar que el botón Limpiar es visible
    await tester.ensureVisible(find.text('Limpiar'));
    
    // Limpiar el formulario
    await tester.tap(find.text('Limpiar'));
    await tester.pumpAndSettle();

    // Verificar que el campo está vacío - el texto 'ORD-001' ya no debe existir
    expect(find.text('ORD-001'), findsNothing);
  });
}