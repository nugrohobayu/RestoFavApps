import 'package:flutter/material.dart';

class WarningMessage extends StatelessWidget {
  final String message;
  final String image;
  final VoidCallback? onPressed;
  final bool isButtonVisible;
  const WarningMessage({
    Key? key,
    required this.message,
    required this.image,
    this.onPressed,
    this.isButtonVisible = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            image,
            color: Colors.red,
            width: 100,
            height: 100,
          ),
          Text(
            message,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.none),
          ),
          isButtonVisible
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: onPressed,
                      child: const Text(
                        "Refresh",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
