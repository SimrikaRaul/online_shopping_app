import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Widget? child;
  final String? text;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color borderColor;
  final double borderRadius;       
  final double? width;             
  final double height;              
  final TextStyle? textStyle;       

  const CustomElevatedButton({
    super.key,
    this.child,
    this.text,
    this.onPressed,
    this.backgroundColor = Colors.red,
    this.foregroundColor = Colors.white,
    this.borderColor = Colors.transparent,
    this.borderRadius = 12,        
    this.width,                     
    this.height = 50,               
    this.textStyle,                 
  }) : assert(child != null || text != null, "Provide either child or text");

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width * 0.95,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          side: BorderSide(color: borderColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: child ?? Text(
          text ?? "",
          style: textStyle ?? const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}