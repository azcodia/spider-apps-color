import 'package:flutter/material.dart';
import 'package:painting/widget/modal_bottom_sheet.dart';
import 'package:painting/widget/modal_bottom_sheet_fix.dart';

class BottomMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.red
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.menu, color: Colors.white),
                onPressed: () async {
                  showModalBottomSheetApp(
                    context: context,
                    builder: (context) {
                      return ModalBottomSheet();
                    }
                  );
                },
              )
            ],
          ),
        ),
      );
  }
}