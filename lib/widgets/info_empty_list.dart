import 'package:flutter/material.dart';

class InfoEmptyList extends StatelessWidget {
  final String message;
  const InfoEmptyList({
    @required this.message,
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
              Image.asset(
                'assets/images/info.png',
                height: 120,
                width: 120,
              ),
              SizedBox(height: 20),
              Text(
                message,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
