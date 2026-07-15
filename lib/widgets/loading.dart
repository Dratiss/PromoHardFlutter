import 'package:flutter/material.dart';
import '../main.dart'; // Importando AppColors

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.goldAccent,
      ),
    );
  }
}
