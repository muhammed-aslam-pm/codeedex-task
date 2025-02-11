import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:codeedex_machinetest/core/constents/app_constants.dart';
import 'package:codeedex_machinetest/models/product_model.dart';
import 'package:codeedex_machinetest/widgets/custom_button.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailScreen({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  // Custom app bar with notification icon
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.background,
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.notifications_active_outlined,
            color: AppColors.button,
          ),
        )
      ],
    );
  }

  // Main body content
  Widget _buildBody() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProductImage(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildProductName(),
                      _buildPriceSection(),
                      const SizedBox(height: 10),
                      _buildDescription(),
                      const SizedBox(height: 10),
                      _buildAvailabilityStatus(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Product image widget
  Widget _buildProductImage() {
    return Image.network(
      product.imageUrl,
      width: double.infinity,
      height: 300.h,
      fit: BoxFit.cover,
    );
  }

  // Product name section
  Widget _buildProductName() {
    return Text(
      product.name,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // Price and discount section
  Widget _buildPriceSection() {
    return Row(
      children: [
        Text(
          '₹ ${product.price}',
          style: const TextStyle(
            fontSize: 18,
            color: Colors.grey,
            decoration: TextDecoration.lineThrough,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          '₹ ${product.offerPrice}',
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ],
    );
  }

  // Product description
  Widget _buildDescription() {
    return Text(
      "Description: ${product.description}",
      style: const TextStyle(fontSize: 16),
    );
  }

  // Availability status
  Widget _buildAvailabilityStatus() {
    return Text(
      product.isAvailable ? "In Stock" : "Out of Stock",
      style: TextStyle(
        fontSize: 16,
        color: product.isAvailable ? Colors.green : Colors.red,
      ),
    );
  }

  // Bottom bar with price and buy button
  Widget _buildBottomBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 20.h),
      height: 88.h,
      decoration: BoxDecoration(
        color: AppColors.background,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, -4),
            blurRadius: 6,
            spreadRadius: 2,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 4),
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.currency_rupee),
              Text(
                product.price.toString(),
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          CustomButton(
            onPressed: () {},
            text: "Buy now",
            isSmall: true,
          ),
        ],
      ),
    );
  }
}
