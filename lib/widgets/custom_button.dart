import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function customFunction;
  final String buttonName;
  const CustomButton({Key? key, required this.customFunction,required this.buttonName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: () {
          customFunction();
        },
        child:  Text(buttonName,
            style:const TextStyle(fontFamily: 'kodachan', fontSize: 19)),
      ),
    );
  }
}
