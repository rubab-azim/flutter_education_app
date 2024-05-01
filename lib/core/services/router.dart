import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_education_app/core/services/injection_container.dart';
import 'package:flutter_education_app/core/views/page_under_construction.dart';
import 'package:flutter_education_app/src/on_boarding/presentation/cubit/cubit/on_boarding_cubit.dart';
import 'package:flutter_education_app/src/on_boarding/presentation/views/on_boarding_screen.dart';

Route<dynamic> generateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case OnboardingScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (context) => sl<OnBoardingCubit>(),
          child: const OnboardingScreen(),
        ),
        settings: settings,
      );
    default:
      return _pageBuilder(
        (_) => const PageUnderConstruction(),
        settings: settings,
      );
  }
}

PageRouteBuilder<dynamic> _pageBuilder(
  Widget Function(BuildContext) page, {
  required RouteSettings settings,
}) {
  return PageRouteBuilder(
    pageBuilder: (context, _, __) => page(context),
    transitionsBuilder: (_, animation, __, child) =>
        FadeTransition(opacity: animation, child: child),
    settings: settings,
  );
}
