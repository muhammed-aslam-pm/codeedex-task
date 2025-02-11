import 'package:codeedex_machinetest/core/constents/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final String text;
  final bool isLoading;
  final bool isSmall;

  const CustomButton(
      {Key? key,
      required this.onPressed,
      required this.text,
      this.isLoading = false,
      this.isSmall = false})
      : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.isLoading ? null : widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: widget.isSmall ? 137.w : 252.w,
        height: widget.isSmall ? 40.h : 36.h,
        decoration: BoxDecoration(
          color:
              _isPressed ? AppColors.button.withOpacity(0.8) : AppColors.button,
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            if (_isPressed)
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 4),
                blurRadius: 6,
              )
          ],
        ),
        alignment: Alignment.center,
        child: widget.isLoading
            ? SizedBox(
                width: 20.sp,
                height: 20.sp,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppColors.textSecondary),
                ),
              )
            : Text(
                widget.text,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
      ),
    );
  }
}
