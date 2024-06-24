import 'package:flutter/material.dart';

class FormContainer extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
  final TextInputType? inputType;
  final bool? isPasswordField;
  final bool? isReadOnly;
  final Icon? prefixIcon;
  final double? width;
  const FormContainer(
      {super.key,
      required this.controller,
      this.hintText,
      this.labelText,
      this.inputType,
      this.isPasswordField,
      this.isReadOnly,
      this.prefixIcon,
      this.width});

  @override
  State<FormContainer> createState() => _FormContainerState();
}

class _FormContainerState extends State<FormContainer> {
  bool _obscureText = true;

  @override
  void dispose() {
    super.dispose();
    widget.controller.dispose();
  }

  void _updateObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.09,
      width: MediaQuery.of(context).size.width,
      child: TextFormField(
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
                        child: GestureDetector(
                            onTap: _updateObscureText,
                            child: const Icon(Icons.visibility_off)))
                    : const Icon(Icons.visibility))
                : null,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(25))),
      ),
    );
  }
}
