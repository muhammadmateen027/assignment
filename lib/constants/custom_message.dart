import 'package:flutter/material.dart';

class CustomMessageScreen extends StatelessWidget {
  final Function onPressed;
  final String heading;
  final double width;
  final double height;
  final String message;
  final String imageStr;

  const CustomMessageScreen({
    Key key,
    @required this.heading,
    @required this.width,
    @required this.height,
    @required this.message,
    @required this.imageStr,
    @required this.onPressed,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height / 2,
        alignment: Alignment.center,
        child: GestureDetector(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: width,
                height: width / 3,
                child: Image(image: AssetImage('$imageStr')),
              ),

              Container(
                width: width,
                alignment: Alignment.center,
                child: Text(
                  "$heading",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                  ),
                ),
              ),

              Container(
                width: width,
                alignment: Alignment.center,
                child: Text(
                  "$message",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                      fontSize: 14.0,
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}