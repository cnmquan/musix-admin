import 'package:flutter/material.dart';

class MessagePopup extends StatelessWidget {
  final String title;
  final String? description;
  const MessagePopup({
    Key? key,
    required this.title,
    this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}
