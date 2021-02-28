import 'package:flutter/material.dart';

class InfoEmptyList extends StatelessWidget {
  final String message;
  final IconData iconData;
  const InfoEmptyList({
    @required this.message,
    @required this.iconData,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Column(
            children: [
              Text(
                message,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 20),
              Icon(
                iconData,
                size: 40,
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
