import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/colors/app_colors.dart';
import 'package:myapp/models/user_model.dart';
import 'package:myapp/providers/user_model_provider.dart';

class ComparisonScreen extends ConsumerWidget {
  final UserModel friend;
  const ComparisonScreen({super.key, required this.friend});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userSchedule = ref.read(userModelProvider).schedule;
    final friendSchedule = friend.schedule;
    return Dialog(
        alignment: Alignment.center,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        child: DefaultTextStyle(
          style: const TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.bold,
            fontSize: 13.0,
            letterSpacing: 1.5,
            height: 1.0,
            color: Colors.white,
          ),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.themeColor,
                    Colors.black,
                  ],
                ),
              ),
              child: Container(
                  child: Column(
                children: [],
              ))),
        ));
  }
}
