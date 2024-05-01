import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_education_app/core/res/colours.dart';
import 'package:flutter_education_app/core/res/media_res.dart';
import 'package:flutter_education_app/core/views/loading_view.dart';
import 'package:flutter_education_app/core/widgets/gradient_background.dart';
import 'package:flutter_education_app/src/on_boarding/domain/entities/page_content_entity.dart';
import 'package:flutter_education_app/src/on_boarding/presentation/cubit/cubit/on_boarding_cubit.dart';
import 'package:flutter_education_app/src/on_boarding/presentation/widgets/on_boarding_body.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  static const routeName = '/';

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  @override
  void initState() {
    super.initState();
    context.read<OnBoardingCubit>().checkIfUserIsFirstTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GradientBackground(
        image: MediaRes.onBoardingBackground,
        child: BlocConsumer<OnBoardingCubit, OnBoardingState>(
          listener: (context, state) {
            if (state is OnBoardingStatus && state.isFirstTimer) {
              Navigator.pushReplacementNamed(context, '/home');
            } else if (state is UserCached) {
              // TODO(user-cached-handler): navigate user to proper route
            }
          },
          builder: (BuildContext context, OnBoardingState state) {
            if (state is CheckIfUserIsFirstTimer ||
                state is CachingFirstTimer) {
              return const LoadingView();
            }
            return Stack(
              children: [
                PageView(
                  controller: _controller,
                  children: const [
                    OnBoardingBody(content: PageContent.first()),
                    OnBoardingBody(content: PageContent.second()),
                    OnBoardingBody(content: PageContent.third()),
                  ],
                ),
                Align(
                  alignment: const Alignment(0, 0.04),
                  child: SmoothPageIndicator(
                    controller: _controller,
                    count: 3,
                    onDotClicked: (index) {
                      _controller.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeOut,
                      );
                    },
                    effect: const WormEffect(
                      activeDotColor: Colours.primaryColour,
                      dotColor: Colors.white,
                      dotWidth: 10,
                      spacing: 40,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
