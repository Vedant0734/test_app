import 'package:flutter/material.dart';

class OptionTile extends StatefulWidget {
  final String description;
  final bool isSelected;

  const OptionTile(
      {super.key, required this.description, required this.isSelected});

  @override
  State<OptionTile> createState() => _OptionTileState();
}

class _OptionTileState extends State<OptionTile> {
  late bool selected;

  @override
  void initState() {
    selected = widget.isSelected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = !selected;
          print(selected);
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: 10.0,
                  color: Colors.grey.withOpacity(0.3),
                  offset: Offset(3, 6))
            ],
            color: Theme.of(context).brightness == Brightness.dark
                ? selected
                    ? Colors.grey.shade800.withOpacity(0.7)
                    : Colors.black
                : selected
                    ? Colors.grey.shade200.withOpacity(0.7)
                    : Colors.white54,
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            Container(
              height: 15,
              width: 15,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 0.8)),
              child: AnimatedOpacity(
                opacity: selected ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColorDark,
                  ),
                  margin: EdgeInsets.all(1.0),
                ),
              ),
            ),
            const SizedBox(
              width: 25,
            ),
            Text(
              widget.description,
              style: TextStyle(fontSize: 17, color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}

class NoOfQuestionTile extends StatelessWidget {
  final String text;
  final int number;

  const NoOfQuestionTile({super.key, required this.text, required this.number});

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
              "$number",
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
              text,
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
