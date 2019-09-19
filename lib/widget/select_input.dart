import 'package:flutter/material.dart';

class SelectInput extends StatefulWidget {
  String hint;
  String value;
  List<String> items;
  ValueChanged onChanged;
  FormFieldValidator<String> validate = null;
  SelectInput(this.value, this.items, this.hint, {Key key, this.onChanged, this.validate}):super(key:key);

  @override
  SelectInputState createState() {
    return new SelectInputState();
  }
}

class SelectInputState extends State<SelectInput> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
        border: Border.all(width: 2.0, color: Colors.black38),
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: widget.items != null && widget.items.length > 0 ? DropdownButtonFormField(
        validator: widget.validate,
        decoration: InputDecoration(
          border: InputBorder.none
        ),
        hint: Text(widget.hint),
        value: widget.value,
        items: widget.items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: widget.onChanged,
      ):DropdownButtonFormField(
        validator: widget.validate,
        decoration: InputDecoration(
          border: InputBorder.none
        ),
        hint: Text(widget.hint),
        items: <String>[widget.hint].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (_) {},
      ),
    );
  }
}