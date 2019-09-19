import 'package:flutter/material.dart';

class InputFormBlock extends StatelessWidget {
  TextEditingController controller;
  String title;
  bool isTextArea = false;
  bool isNumber = false;
  FormFieldValidator<String> validation = null;

  InputFormBlock(this.title, {this.controller, this.validation, this.isTextArea, this.isNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style:TextStyle(fontSize: 20.0)),
          SizedBox(height: 5.0),
          TextFormField(
            style:TextStyle(fontSize: 18.0, color: Colors.black),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(12.0),
              border: OutlineInputBorder(borderSide: BorderSide(width: 1.0))
            ),
            keyboardType: (isNumber == null || isNumber != true) ? TextInputType.text:TextInputType.phone,
            controller: controller,
            validator: validation,
            maxLines: (isTextArea == null || isTextArea != true) ? 1:4,
          ) 
        ],
      ),
    );
  }
}