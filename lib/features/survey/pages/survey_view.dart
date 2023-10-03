import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prithvi/config/di/di.dart';

class SurveyView extends ConsumerWidget {
  const SurveyView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final survey = ref.watch(SurveyNotifierProvider);

    return Column(
      children: [Text("${survey.totalEmission}")],
    );
  }
}
