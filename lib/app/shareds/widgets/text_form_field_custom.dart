import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldCustom extends StatelessWidget {
  final String hintText;
  final String labelText;
  final String initialValue;
  final Function(String) onSaved;
  final bool enableInteractiveSelection;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final List<TextInputFormatter> inputFormatters;
  final List<String Function(dynamic)> validators;

  TextFormFieldCustom({
    this.labelText,
    this.hintText,
    this.initialValue,
    this.onSaved,
    this.enableInteractiveSelection = true,
    this.keyboardType = TextInputType.text,
    this.inputFormatters = const <TextInputFormatter>[],
    this.validators,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: Colors.transparent,
      ),
      child: TextFormField(
        onSaved: onSaved,
        initialValue: initialValue,
        enableInteractiveSelection: enableInteractiveSelection,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          fillColor: Colors.white,
          labelText: labelText,
          hintText: hintText,
        ),
        validator: (value) {
          if (validators == null) return null;
          if (validators.length == 0) return null;

          for (var i = 0; i < validators.length; i++) {
            if (validators[i] != null && validators[i](value) != null) {
              return validators[i](value);
            }
          }

          return null;
        },
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        controller: controller,
      ),
    );
  }
}
