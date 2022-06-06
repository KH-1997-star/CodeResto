import 'package:code_resto/utils/colors.dart';
import 'package:code_resto/utils/functions.dart';
import 'package:flutter/material.dart';

class RadioButtonWidget extends StatefulWidget {
  final bool clicked;
  final dynamic title, prix;
  final Function(
    dynamic item,
    dynamic prix,
  ) onChoice;

  final int qteMax;
  const RadioButtonWidget({
    Key? key,
    required this.title,
    required this.onChoice,
    this.clicked = false,
    required this.qteMax,
    this.prix,
  }) : super(key: key);

  @override
  State<RadioButtonWidget> createState() => _RadioButtonWidgetState();
}

class _RadioButtonWidgetState extends State<RadioButtonWidget> {
  bool clicked = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 300,
      child: Padding(
        padding: const EdgeInsets.only(left: 45),
        child: InkWell(
          onTap: () {
            widget.onChoice(widget.title, widget.prix);
            // iPrint(widget.clicked);
          },
          child: Row(
            children: [
              Container(
                alignment: Alignment.center,
                child: Container(
                  child: widget.clicked
                      ? Container(
                          height: 7,
                          width: 7,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        )
                      : const SizedBox(),
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                    color: !widget.clicked ? myWhite : myBlack,
                    shape: BoxShape.circle,
                  ),
                ),
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  border: Border.all(width: 1.5),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(
                width: 18,
              ),
              Text(widget.title),
            ],
          ),
        ),
      ),
    );
  }
}
