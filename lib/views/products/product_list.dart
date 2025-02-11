import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:codeedex_machinetest/core/constents/app_constants.dart';
import 'package:codeedex_machinetest/models/product_model.dart';
import 'package:codeedex_machinetest/viewmodels/product_viewmodel.dart';
import 'package:codeedex_machinetest/views/products/product_details_screen.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _initializeData();
    _setupScrollController();
  }

  // Initialize product data on screen load
  void _initializeData() {
    Future.delayed(Duration.zero, () {
      context.read<ProductViewModel>().fetchProducts();
    });
  }

  // Setup scroll controller for pagination
  void _setupScrollController() {
    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  // Handle scroll events for pagination
  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      context.read<ProductViewModel>().fetchProducts(isLoadMore: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0.r),
      child: Column(
        children: [
          _buildHeader(),
          _buildProductGrid(),
        ],
      ),
    );
  }

  // Header section with title and view all button
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "All Products",
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text("View All"),
        ),
      ],
    );
  }

  // Main product grid with loading states
  Widget _buildProductGrid() {
    return Consumer<ProductViewModel>(
      builder: (context, viewModel, _) {
        if (viewModel.isLoading && viewModel.products.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return GridView.builder(
          shrinkWrap: true,
          controller: _scrollController,
          padding: EdgeInsets.all(8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.7,
          ),
          itemCount: viewModel.products.length + (viewModel.isLoading ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == viewModel.products.length) {
              return const Center(child: CircularProgressIndicator());
            }
            return _buildProductItem(viewModel.products[index]);
          },
        );
      },
    );
  }

  // Individual product card widget
  Widget _buildProductItem(ProductModel product) {
    return InkWell(
      onTap: () => _navigateToProductDetail(product),
      child: Card(
        color: AppColors.grey1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProductImage(product),
            _buildProductInfo(product),
          ],
        ),
      ),
    );
  }

  // Product image with error handling
  Widget _buildProductImage(ProductModel product) {
    return Expanded(
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
        child: Image.network(
          product.imageUrl,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => const Icon(
            Icons.image_not_supported,
            size: 50,
          ),
        ),
      ),
    );
  }

  // Product information section (name and price)
  Widget _buildProductInfo(ProductModel product) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            "₹${product.offerPrice}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            "₹${product.price}",
            style: const TextStyle(decoration: TextDecoration.lineThrough),
          ),
        ],
      ),
    );
  }

  // Navigation to product detail screen
  void _navigateToProductDetail(ProductModel product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailScreen(product: product),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
