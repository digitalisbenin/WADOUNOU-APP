import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.leftIcon, required this.rightIcon, this.leftCallback});

  final IconData leftIcon;
  final IconData rightIcon;
  final Function? leftCallback;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top * 1.5,
        left: 25,
        right: 25,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: leftCallback != null ? () => leftCallback!() : null,
            child: _buildIcon(leftIcon),
          ),
          
        ],
      ),
    );
  }

  Container _buildIcon(IconData icon) {
    return Container(
            padding: const EdgeInsets.fromLTRB(16, 8, 12, 8),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Center(child: Icon(icon, size: 20,)),
          );
  }
}