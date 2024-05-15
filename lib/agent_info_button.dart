import 'package:flutter/material.dart';

class agentInfoButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;

  const agentInfoButton({
    required this.buttonText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: 200,
        height: 50,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: const BeveledRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            side: const BorderSide(
              color: Colors.white, // Set the color of the border
              width: .5, // Set the width of the border
            ),
          ),
          child: Text(
            buttonText,
            style: TextStyle(
              color: Theme.of(context).textTheme.titleMedium!.color,
              fontFamily: Theme.of(context).textTheme.titleSmall!.fontFamily,
              fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
            ),
          ),
        ),
      ),
    );
  }
}
