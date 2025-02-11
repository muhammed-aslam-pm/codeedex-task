import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:codeedex_machinetest/core/constents/app_constants.dart';
import 'package:codeedex_machinetest/core/utils/validators.dart';
import 'package:codeedex_machinetest/viewmodels/auth_viemodel.dart';
import 'package:codeedex_machinetest/views/products/product_list_screen.dart';
import 'package:codeedex_machinetest/widgets/custom_button.dart';
import 'package:codeedex_machinetest/widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      // final authViewModel = context.read<AuthViewModel>();
      // final success = await authViewModel.login(
      //   _emailController.text,
      //   _passwordController.text,
      // );

      // if (success && mounted) {
      //   _navigateToProductList();
      // }
      _navigateToProductList();
    }
  }

  void _navigateToProductList() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const ProductListScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.loginBg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.h, vertical: 60.w),
              child: Stack(
                children: [
                  _buildBackgroundImage(),
                  _buildLoginForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        width: 263.w,
        height: 263.h,
        margin: EdgeInsets.only(top: 60.h),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.loginBgImage),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Consumer<AuthViewModel>(
        builder: (context, authViewModel, _) => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildWelcomeText(),
            Spacer(),
            _buildLoginSection(authViewModel),
            _buildSignUpSection(authViewModel),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeText() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'Welcome Back !',
        style: TextStyle(
          fontSize: 40.sp,
          fontWeight: FontWeight.w800,
          color: AppColors.textSecondary,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildLoginSection(AuthViewModel authViewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Log-in',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.left,
        ),
        SizedBox(height: 20.h),
        _buildLoginFields(),
        if (authViewModel.error.isNotEmpty) _buildErrorMessage(authViewModel),
        SizedBox(height: 20.h),
        Center(
          child: CustomButton(
            isLoading: authViewModel.isLoading,
            onPressed: () => _handleLogin(context),
            text: 'Login',
          ),
        ),
      ],
    );
  }

  Widget _buildLoginFields() {
    return Column(
      children: [
        CustomTextField(
          controller: _emailController,
          labelText: 'E-Mail',
          hintText: 'Enter mail id',
          keyboardType: TextInputType.emailAddress,
          validator: Validators.validateEmail,
        ),
        SizedBox(height: 16.h),
        CustomTextField(
          controller: _passwordController,
          labelText: 'Password',
          hintText: 'Enter password',
          obscureText: true,
          validator: Validators.validatePassword,
        ),
        SizedBox(height: 10.h),
        _buildForgetPassword(),
      ],
    );
  }

  Widget _buildForgetPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        'Forget Password?',
        style: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 14.sp,
        ),
      ),
    );
  }

  Widget _buildErrorMessage(AuthViewModel authViewModel) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: Colors.red.shade700, size: 20.sp),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              authViewModel.error,
              style: TextStyle(
                color: Colors.red.shade700,
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpSection(AuthViewModel authViewModel) {
    return Opacity(
      opacity: authViewModel.isLoading ? 0.5 : 1.0,
      child: IgnorePointer(
        ignoring: authViewModel.isLoading,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an account? ",
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14.sp,
              ),
            ),
            Text(
              'Sign-up',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.textSecondary,
                fontSize: 15.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
