import 'package:busfinder_api/api.dart';
import 'package:flutter/material.dart';

class BusStopList extends StatelessWidget {
  const BusStopList({
    super.key,
    required this.stops,
    required this.onReorder,
    required this.onDelete,
  });

  final List<BusStopResponseDto> stops;
  final ReorderCallback onReorder;
  final ValueChanged<int> onDelete;

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      itemCount: stops.length,
      buildDefaultDragHandles: false,
      onReorder: onReorder,
      itemBuilder: (context, index) {
        final stop = stops[index];
        return ListTile(
          key: ValueKey(stop.id),
          title: Text(stop.name),
          leading: ReorderableDragStartListener(
            index: index,
            child: const Icon(Icons.drag_handle),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => onDelete(index),
          ),
        );
      },
    );
  }
}
