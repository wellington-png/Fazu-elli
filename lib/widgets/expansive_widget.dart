import 'package:flutter/material.dart';

class ExpansiveWidget extends StatefulWidget {
  final Widget? child;
  final String title;
  const ExpansiveWidget({super.key, required this.title, required this.child});

  @override
  State<ExpansiveWidget> createState() => _ExpansiveWidgetState();
}

class _ExpansiveWidgetState extends State<ExpansiveWidget> {

  bool isVisable = true;

  void onToggleProfile() {
    setState(() {
      isVisable = !isVisable;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                widget.title,
                style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
              ),
            ),
            IconButton(
              onPressed: onToggleProfile,
              icon: Icon(
                isVisable
                    ? Icons.keyboard_arrow_down
                    : Icons.keyboard_arrow_up,
                size: 40,
              ),
            )
          ],
        ),
        isVisable
            ? Column(
                children: [
                  widget.child!,
                ],
              )
            : Container(),
      ],
    );
  }
}
