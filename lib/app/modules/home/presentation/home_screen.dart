import 'package:flutter/material.dart';
import 'package:personal_planner/app/modules/week_tasks/widgets/week_tasks_widget.dart';
import 'package:personal_planner/app/modules/week_view/presentation/widgets/week_view_widget.dart';
import 'package:personal_planner/app/shared/constants/size_tokens.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingLarge),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [WeekviewWidget(), WeekTasksWidget()],
        ),
      ),
    );
  }
}
