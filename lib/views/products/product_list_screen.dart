import 'package:codeedex_machinetest/core/constents/app_constants.dart';
import 'package:codeedex_machinetest/views/products/product_list.dart';
import 'package:codeedex_machinetest/widgets/categories_button.dart';
import 'package:codeedex_machinetest/widgets/home_carausel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// `ProductListScreen` - Displays product categories, a search bar, and a product list.

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSearchBar(),
            HomeCarousel(),
            SizedBox(height: 20.h),
            _buildCategoryTabs(),
            SizedBox(height: 20.h),
            _buildTopCategories(),
            _buildAllProducts(),
          ],
        ),
      ),
    );
  }

  /// Builds the App Bar with a logo and notification icon.
  AppBar _buildAppBar() {
    return AppBar(
      titleSpacing: 25,
      backgroundColor: AppColors.background,
      title: Image.asset(
        AppAssets.appLogo,
        height: 20.h,
        width: 108.w,
      ),
      actions: [
        IconButton(
          onPressed: () {}, // TODO: Implement notification functionality
          icon: Icon(
            Icons.notifications_active_outlined,
            color: AppColors.button,
          ),
        )
      ],
    );
  }

  /// Builds a search bar for product search.
  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: SizedBox(
        height: 35.h,
        child: SearchBar(
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 20),
          ),
          leading: Icon(Icons.search, color: AppColors.grey1),
          backgroundColor: WidgetStatePropertyAll(AppColors.background),
          elevation: const WidgetStatePropertyAll(2),
          hintText: "Search Product",
        ),
      ),
    );
  }

  /// Builds two category tabs with images.
  Widget _buildCategoryTabs() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.r),
      child: Row(
        children: [
          _buildHomeTab(image: AppAssets.homeBanner2, text: "Bike Spare Parts"),
          SizedBox(width: 20.w), // Added spacing
          _buildHomeTab(image: AppAssets.homeBanner3, text: "Accessories"),
        ],
      ),
    );
  }

  /// Builds the top categories section with a horizontal scrollable list.
  Widget _buildTopCategories() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 14.h),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: AppColors.background,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Light shadow effect
            offset: const Offset(0, -4), // Moves shadow to the top
            blurRadius: 6,
            spreadRadius: 2,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 4), // Moves shadow to the bottom
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Top Categories",
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 20.h), // Added spacing
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                CategoriesButton(iconPath: AppAssets.tireIcon, title: "Tire"),
                SizedBox(width: 19.w), // Added spacing
                CategoriesButton(
                    iconPath: AppAssets.engineIcon, title: "Engine"),
                SizedBox(width: 19.w),
                CategoriesButton(iconPath: AppAssets.alloyIcon, title: "Alloy"),
                SizedBox(width: 19.w),
                CategoriesButton(
                    iconPath: AppAssets.helmetIcon, title: "Helmet"),
                SizedBox(width: 19.w),
                CategoriesButton(iconPath: AppAssets.seatIcon, title: "Seat"),
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Builds a single home category tab with an image and text.
  Widget _buildHomeTab({required String image, required String text}) {
    return Expanded(
      child: Column(
        children: [
          Container(
            height: 109.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.r),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 10.h), // Added spacing
          Text(
            text,
            style: TextStyle(fontSize: 14.sp, color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }

  /// Builds the product list section.
  Widget _buildAllProducts() {
    return const ProductList();
  }
}
