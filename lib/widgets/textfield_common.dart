import 'package:flutter/material.dart';
import 'package:todos/config/themes/apptheme.dart';

class TextFiller extends StatefulWidget {
  final TextEditingController newController;
  final String textFieldTitle;
  final bool obsecure;
  final String? value;
  final TextInputAction keyboardAction;
  final IconData iconToShow;
  final int? min;
  final int? max;

  const TextFiller(
      {super.key,
      required this.newController,
      required this.textFieldTitle,
      required this.obsecure,
      required this.value,
      this.keyboardAction = TextInputAction.next,
      required this.iconToShow,
      this.min,
      this.max});

  @override
  // ignore: library_private_types_in_public_api
  _TextFillerState createState() => _TextFillerState();
}

class _TextFillerState extends State<TextFiller> {
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = widget.newController;

    if (widget.value != null) {
      _textController.text = widget.value!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      obscureText: widget.obsecure,
      minLines: widget.min ?? 1,
      maxLines: widget.max ?? 1,
      textInputAction: widget.keyboardAction,
      style: const TextStyle(color: Colors.black),
      textAlign: TextAlign.center,
      controller: _textController,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        focusColor: AppTheme.greenColor,
        hintText: widget.textFieldTitle,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppTheme.greenColor,
          ),
          borderRadius: BorderRadius.circular(18),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppTheme.greenColor),
          borderRadius: BorderRadius.circular(18),
        ),
        prefixIcon: Icon(widget.iconToShow),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: AppTheme.greenColor),
        ),
      ),
    );
  }
}
