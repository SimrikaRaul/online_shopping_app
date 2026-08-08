import 'package:flutter/material.dart';

class TopCategoryButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

   TopCategoryButton({
    super.key,
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected
                  ?  Color(0xff3E302C)
                  : Colors.grey.shade100,
              border: Border.all(
                color: isSelected
                    ?  Color(0xff3E302C)
                    : Colors.transparent,
                width: 2,
              ),
            ),
            child: Icon(
              icon,
              color: isSelected
                  ? Colors.white
                  : Colors.grey.shade500,
              size: 26,
            ),
          ),
           SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 13,
              color: isSelected
                  ? Colors.black
                  : Colors.grey,
              fontWeight: isSelected
                  ? FontWeight.w600
                  : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}