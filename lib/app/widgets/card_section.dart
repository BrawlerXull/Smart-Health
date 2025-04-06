import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_health/app/data/utils/constants.dart';
import 'package:smart_health/app/widgets/custom_clipper.dart';

class CardSection extends StatelessWidget {
  final String title;
  final String value;
  final String unit;
  final String time;
  final ImageProvider image;
  final bool isDone;

  const CardSection({
    Key? key,
    required this.title,
    required this.value,
    required this.unit,
    required this.time,
    required this.image,
    this.isDone = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final secondaryColor = Theme.of(context).colorScheme.secondary;

    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: const EdgeInsets.only(right: 15.0),
        width: 240,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          shape: BoxShape.rectangle,
          color: Colors.white,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Positioned(
              child: ClipPath(
                clipper: MyCustomClipper(clipType: ClipType.semiCircle),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Constants.lightBlue.withOpacity(0.1),
                  ),
                  height: 120,
                  width: 120,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Image(
                        image: image,
                        width: 24,
                        height: 24,
                        color: secondaryColor,
                      ),
                      Text(
                        time,
                        style: TextStyle(
                          fontSize: 15,
                          color: Constants.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              title,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Constants.textPrimary,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              '$value $unit',
                              style: TextStyle(
                                fontSize: 15,
                                color: Constants.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          debugPrint("Button clicked. Handle button setState");
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            color: isDone ? secondaryColor : Color(0xFFF0F4F8),
                          ),
                          width: 44,
                          height: 44,
                          child: Center(
                            child: Icon(
                              Icons.check,
                              color: isDone ? Colors.white : secondaryColor,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
