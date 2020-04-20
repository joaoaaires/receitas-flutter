import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldCustom extends StatelessWidget {
  String labelText;
  String initialValue;
  Function(String) onSaved;
  bool enableInteractiveSelection;
  TextInputType keyboardType;
  TextEditingController controller;
  List<TextInputFormatter> inputFormatters;
  List<String Function(dynamic)> validators;

  TextFormFieldCustom({
    @required this.labelText,
    this.initialValue,
    this.onSaved,
    this.enableInteractiveSelection : true,
    this.keyboardType: TextInputType.text,
    this.inputFormatters: const <TextInputFormatter>[],
    this.validators,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      initialValue: initialValue,
      enableInteractiveSelection: enableInteractiveSelection,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: labelText,
      ),
      validator: (value) {
        if (validators == null) return null;
        if (validators.length == 0) return null;

        for (int i = 0; i < validators.length; i++) {
          if (validators[i] != null && validators[i](value) != null)
            return validators[i](value);
        }

        return null;
      },
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      controller: controller,
    );
  }
}
