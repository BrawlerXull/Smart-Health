import 'package:flutter/material.dart';
import 'package:smart_health/app/data/utils/constants.dart';

class GridItem extends StatelessWidget {
  final String status;
  final String time;
  final String value;
  final String unit;
  final ImageProvider? image;
  final Color color;
  final String remarks;

  const GridItem({
    Key? key,
    required this.status,
    required this.value,
    required this.unit,
    required this.time,
    required this.image,
    required this.remarks,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        shape: BoxShape.rectangle,
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  status,
                  style: TextStyle(
                    fontSize: 12,
                    color: Constants.textPrimary,
                  ),
                ),
                Text(
                  time,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            (image == null)
                ? Column(
                    children: <Widget>[
                      Text(
                        value,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 35,
                          color: color,
                        ),
                      ),
                      Text(
                        unit,
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Image(
                        image: image!,
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        remarks,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
