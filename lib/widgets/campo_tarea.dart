// Samuel Dominguez Lopez
// Fecha: 28/10/2026
// Matricula: 23030296

import 'package:flutter/material.dart';

class CampoTarea extends StatelessWidget {
  final TextEditingController controlador;
  final VoidCallback onAgregar;

  const CampoTarea({
    super.key,
    required this.controlador,
    required this.onAgregar,
  });

  @override
  Widget build(BuildContext context) { // Construyo el campo de texto y el botón para agregar tareas.
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controlador,
              onSubmitted: (_) => onAgregar(),
              decoration: const InputDecoration(
                // Texto que aparece antes de escribir.
                hintText: 'Ingresa una tarea...',
                hintStyle: TextStyle(
                  color: Colors.black54,
                  fontSize: 20,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
            width: 42,
            height: 42,
            child: ElevatedButton(
              // Ejecuto la función para agregar la tarea.
              onPressed: onAgregar,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF80A9F5),
                foregroundColor: Colors.white,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Icon(Icons.add, size: 27),
            ),
          ),
        ],
      ),
    );
  }
}
