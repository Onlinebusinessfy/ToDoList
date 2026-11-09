// Samuel Dominguez Lopez
// Fecha: 28/10/2026
// Matricula: 23030296

import 'package:flutter/material.dart';
import 'widgets/campo_tarea.dart';
import 'widgets/item_tarea.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoPage(),
    );
  }
}

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TextEditingController controlador = TextEditingController();

  // Aquí guardo las tareas que aparecen al iniciar la app.
  final List<String> tareas = [
    'tarea5',
    'tarea1',
    'tarea4',
    'tarea2',
    'tarea3',
  ];

  // Agrego la tarea si no existe y limpio el campo.
  void agregarTarea() {
    final texto = controlador.text.trim();

    if (texto.isEmpty) return;

    // Verifico si la tarea ya existe.
    if (tareas.any(
      (tarea) => tarea.toLowerCase() == texto.toLowerCase(),
    )) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Esta tarea ya existe.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      tareas.add(texto);
      controlador.clear();
    });
  }

  // Abro una ventana para cambiar el nombre de la tarea.
  void editarTarea(int index) {
    final editor = TextEditingController(text: tareas[index]);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar tarea'),
        content: TextField(
          controller: editor,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Ingresa una tarea...',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              final nuevoTexto = editor.text.trim();

              if (nuevoTexto.isEmpty) return;

              // Verifico que no exista otra tarea con el mismo nombre.
              if (tareas.asMap().entries.any(
                (entry) =>
                    entry.key != index &&
                    entry.value.toLowerCase() == nuevoTexto.toLowerCase(),
              )) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Esta tarea ya existe.'),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }

              setState(() {
                tareas[index] = nuevoTexto;
              });

              Navigator.pop(context);
              editor.dispose();
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    ).then((_) {
      editor.dispose();
    });
  }

  // Quito de la lista la tarea seleccionada.
  void borrarTarea(int index) {
    setState(() {
      tareas.removeAt(index);
    });
  }

  @override
  void dispose() {
    controlador.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'To Do List',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 26,
            fontWeight: FontWeight.normal,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 3,
        shadowColor: Colors.black26,
      ),
      body: Column(
        children: [
          // Muestro el campo y el botón para agregar tareas.
          CampoTarea(
            controlador: controlador,
            onAgregar: agregarTarea,
          ),
          const Divider(
            height: 1,
            color: Color(0xFFEEEEEE),
          ),

          // Muestro las tareas y permito cambiar su orden.
          Expanded(
            child: ReorderableListView.builder(
              buildDefaultDragHandles: false,
              padding: EdgeInsets.zero,
              itemCount: tareas.length,
              onReorder: (oldIndex, newIndex) {
                setState(() {
                  if (newIndex > oldIndex) newIndex--;

                  // Muevo la tarea a la posición seleccionada.
                  final tarea = tareas.removeAt(oldIndex);
                  tareas.insert(newIndex, tarea);
                });
              },
              itemBuilder: (context, index) {
                return ItemTarea(
                  key: ValueKey('fila-$index-${tareas[index]}'),
                  tarea: tareas[index],
                  index: index,
                  onEditar: () => editarTarea(index),
                  onBorrar: () => borrarTarea(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
