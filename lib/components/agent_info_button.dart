import 'package:flutter/material.dart';

class AgentInfoButton extends StatelessWidget {
  final String buttonText;
  final Color? backgroundColor;
  final VoidCallback? onPressed;

  const AgentInfoButton({
    required this.buttonText,
    this.backgroundColor,
    this.onPressed,
    super.key,
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
            backgroundColor: backgroundColor,
          ),
          child: Text(
            buttonText,
            style: TextStyle(
              color: Colors.white,
              fontFamily: Theme.of(context).textTheme.titleSmall!.fontFamily,
              fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
            ),
          ),
        ),
      ),
    );
  }
}
