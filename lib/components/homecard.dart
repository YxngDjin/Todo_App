import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Homecard extends StatelessWidget {
  final String iconpath;
  final String text;
  final int number;
  final Color color;

  const Homecard({
    super.key,
    required this.iconpath,
    required this.text,
    required this.number,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(iconpath, width: 30, height: 30),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    number.toString(),
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 5),
                  Text(
                    text,
                    style: TextStyle(fontSize: 19, color: Colors.grey.shade700),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
