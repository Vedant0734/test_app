import 'package:flutter/material.dart';

class OptionTile extends StatefulWidget {
  final String description;
  final bool isSelected;

  const OptionTile({super.key, required this.description, required this.isSelected});

  @override
  State<OptionTile> createState() => _OptionTileState();
}

class _OptionTileState extends State<OptionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Container(
            height: 28,
            width: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: widget.isSelected ? Border.all(
                  width: 1.5,
                  color: widget.isSelected 
                          ? Theme.of(context).brightness == Brightness.dark ? Colors.grey.withOpacity(0.7)
                          : Colors.black54.withOpacity(0.7)
                      : Colors.grey,
                ) : const Border.fromBorderSide(BorderSide.none),
              color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey.shade800.withOpacity(0.7)
                      : Colors.grey.shade200.withOpacity(0.7),
              borderRadius: BorderRadius.circular(24)
            ),
            // child: Text(
            //   widget.option,
            //   style: TextStyle(
            //     color: widget.optionSelected == widget.description
            //         ? Colors.white
            //         : Colors.grey,
            //   ),
            // ),
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            widget.description,
            style: TextStyle(fontSize: 17, color: Colors.black54),
          )
        ],
      ),
    );
  }
}

class NoOfQuestionTile extends StatefulWidget {
  final String text;
  final int number;

  NoOfQuestionTile({required this.text, required this.number});

  @override
  _NoOfQuestionTileState createState() => _NoOfQuestionTileState();
}

class _NoOfQuestionTileState extends State<NoOfQuestionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14),
                    bottomLeft: Radius.circular(14)),
                color: Colors.blue),
            child: Text(
              "${widget.number}",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(14),
                  bottomRight: Radius.circular(14),
                ),
                color: Colors.black54),
            child: Text(
              widget.text,
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
