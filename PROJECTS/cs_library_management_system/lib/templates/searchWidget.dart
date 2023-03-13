import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;
  final String hintText;
  const SearchWidget({Key? key, required this.text, required this.onChanged, required this.hintText}) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {

  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    const styleActive = TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20, height: 0.9, fontFamily: 'Cambria');
    const styleHint = TextStyle(color: Colors.black54, fontSize: 20, height: 0.9, fontFamily: 'Cambria');
    final style = widget.text.isEmpty ? styleHint : styleActive ;

    return Container(
      height: 45,
      margin: const EdgeInsets.all(46),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(color: Colors.black26,),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        textAlign: TextAlign.start,
        controller: controller,
        decoration: InputDecoration(
          alignLabelWithHint: true,
          icon: Icon(Icons.search, color: style.color,size: 25),
          suffixIcon: widget.text.isNotEmpty
            ? GestureDetector(
            child: Icon(Icons.close, color: style.color,),
            onTap: () {
              controller.clear();
              widget.onChanged('');
              FocusScope.of(context).requestFocus(FocusNode());
            },
          )
              : null,
          hintText: widget.hintText,
          hintStyle: style,
          border: InputBorder.none,
        ),
        style: style,
        onChanged: widget.onChanged,
      ),
    );
  }
}
