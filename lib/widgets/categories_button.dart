import 'package:codeedex_machinetest/core/constents/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesButton extends StatelessWidget {
  final String iconPath;
  final String title;
  const CategoriesButton({
    super.key,
    required this.iconPath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10.h,
      children: [
        CircleAvatar(
          radius: 30.r,
          backgroundColor: AppColors.grey1,
          child: Image.asset(iconPath),
        ),
        Text(
          title,
          style: TextStyle(fontSize: 16.sp, color: AppColors.textPrimary),
        )
      ],
    );
  }
}
