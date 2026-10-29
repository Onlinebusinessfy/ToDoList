
import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_list/main.dart';

void main() {
  testWidgets('Muestra la lista de tareas', (WidgetTester tester) async {
    await tester.pumpWidget(const TodoApp());

    // Verifica el título y las tareas iniciales
    expect(find.text('To Do List'), findsOneWidget);
    expect(find.text('tarea5'), findsOneWidget);
    expect(find.text('tarea1'), findsOneWidget);

    // Verifica el botón para agregar tareas
    expect(find.text('Ingresa una tarea...'), findsOneWidget);
  });
}
