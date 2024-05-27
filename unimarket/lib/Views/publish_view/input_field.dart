import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputField extends StatelessWidget {

  final String label;
  final IconData? icon;
  final FormFieldValidator? validator;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormat;
  final TextInputType? inputType;
  final int? maxLines;
  final int? maxLength;

  const InputField({super.key,
    this.label = "label",
    this.icon,
    this.validator,
    this.controller,
    this.inputFormat,
    this.inputType,
    this.maxLines,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: TextFormField(
        validator: validator,
        controller: controller,
        inputFormatters: inputFormat,
        keyboardType: inputType,
        maxLines: maxLines,
        maxLength: maxLength,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        
        decoration: InputDecoration(
      
          label: Text(label),
          hintText: label,
          prefixIcon: Icon(icon),
          
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(.3),
              width: 1.5
            )
          ),
      
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Colors.indigo.withOpacity(.4),
              width: 2
            )
          ),

          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Colors.red.shade900,
              width: 1
            )
          ),

          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Colors.red.shade900,
              width: 2
            )
          ),
      
        ),
      ),
    );
  }
}