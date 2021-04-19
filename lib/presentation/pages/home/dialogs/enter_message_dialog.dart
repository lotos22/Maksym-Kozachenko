import 'package:flutter/material.dart';
import 'package:toptal_test/utils/localizations.dart';

class EnterMessageDialog extends StatelessWidget {
  final nameController = TextEditingController();
  final String? label;
  EnterMessageDialog(this.label);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                  labelText: label,
                  border: OutlineInputBorder()),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, nameController.text);
              },
              child:
                  Text(AppLocalizations.of(context).dialog_add_restaurant_ok),
            )
          ],
        ),
      ),
    );
  }
}
