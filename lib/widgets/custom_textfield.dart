import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool isTextObscured;
  final String? hintText;
  final IconData? leadingIcon;

  const CustomTextfield(
      {Key? key,
      required this.controller,
      required this.validator,
      required this.isTextObscured,
      required this.leadingIcon,
      required this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
         Icon(leadingIcon),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: TextFormField(
          validator: validator,
          obscureText: isTextObscured,
          controller: controller,
          decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(fontFamily: 'kodachan')),
        )),
      ],
    );
  }
}
