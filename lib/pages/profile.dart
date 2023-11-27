import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/colors/app_colors.dart';
import 'package:myapp/pages/custom_widgets.dart';

class ProfilePage extends ConsumerWidget {
  ProfilePage({Key? key}) : super(key: key);

  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppBar(
        isOnProfilePage: true,
      ),
      backgroundColor: AppColors.backgroundColor,
    );
  }
}