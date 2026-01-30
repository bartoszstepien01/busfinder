import 'package:flutter/material.dart';

class BusStopTile extends StatelessWidget {
  final String stopName;
  final bool isFirst;
  final bool isLast;

  const BusStopTile({
    super.key,
    required this.stopName,
    required this.isFirst,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 60,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    width: 2,
                    color: isFirst ? Colors.transparent : Colors.white,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2.5),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 2,
                    color: isLast ? Colors.transparent : Colors.white,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 18),
              alignment: Alignment.centerLeft,
              child: Text(
                stopName,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
