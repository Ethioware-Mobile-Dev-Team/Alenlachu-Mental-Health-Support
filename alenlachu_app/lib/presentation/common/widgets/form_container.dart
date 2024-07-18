import 'package:flutter/material.dart';

class FormContainer extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
  final TextInputType? inputType;
  final bool? isPasswordField;
  final bool? isReadOnly;
  final Icon? prefixIcon;
  final Icon? sufixIcon;
  final double? width;
  final String? Function(String?)? validator;
  const FormContainer(
      {super.key,
      required this.controller,
      required this.validator,
      this.hintText,
      this.labelText,
      this.inputType,
      this.isPasswordField,
      this.isReadOnly,
      this.prefixIcon,
      this.sufixIcon,
      this.width});

  @override
  State<FormContainer> createState() => _FormContainerState();
}

class _FormContainerState extends State<FormContainer> {
  bool _obscureText = true;

  void _updateObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.09,
      width: MediaQuery.of(context).size.width * 0.85,
      child: TextFormField(
        validator: widget.validator,
        controller: widget.controller,
        keyboardType: widget.inputType,
        obscureText: widget.isPasswordField == true ? _obscureText : false,
        readOnly: widget.isReadOnly == true ? true : false,
        decoration: InputDecoration(
            prefixIcon: widget.prefixIcon,
            labelText: widget.labelText,
            suffix: widget.isPasswordField == true
                ? (_obscureText
                    ? GestureDetector(
                        onTap: _updateObscureText,
                        child: const Icon(Icons.visibility_off))
                    : GestureDetector(
                        onTap: _updateObscureText,
                        child: const Icon(Icons.visibility)))
                : widget.sufixIcon),
      ),
    );
  }
}
