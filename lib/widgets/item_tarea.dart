// Samuel Dominguez Lopez
// Fecha: 28/10/2026
// Matricula: 23030296

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ItemTarea extends StatelessWidget {
  final String tarea;
  final int index;
  final VoidCallback onEditar;
  final VoidCallback onBorrar;

  const ItemTarea({
    super.key,
    required this.tarea,
    required this.index,
    required this.onEditar,
    required this.onBorrar,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey('$index-$tarea'),

      // Al deslizar hacia un lado aparece la opción de editar.
      startActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.25,
        children: [
          SlidableAction(
            onPressed: (_) => onEditar(),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Editar',
          ),
        ],
      ),

      // Al deslizar hacia el otro lado aparece la opción de borrar.
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.25,
        children: [
          SlidableAction(
            onPressed: (_) => onBorrar(),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Borrar',
          ),
        ],
      ),

      // Diseño de la fila con el nombre y el icono para arrastrar.
      child: Container(
        height: 64,
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: Color(0xFFEEEEEE),
            ),
          ),
        ),
        child: Row(
          children: [
            const SizedBox(width: 24),
            Expanded(
              child: Text(
                tarea,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black87,
                ),
              ),
            ),

            // Permito arrastrar la tarea para cambiar su posición.
            ReorderableDragStartListener(
              index: index,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Icon(
                  Icons.drag_handle,
                  color: Colors.black38,
                  size: 32,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
