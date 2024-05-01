import 'package:flutter/material.dart';
import 'package:flutter_education_app/core/extension/context_extension.dart';
import 'package:flutter_education_app/core/res/colours.dart';
import 'package:flutter_education_app/core/res/fonts.dart';
import 'package:flutter_education_app/src/on_boarding/domain/entities/page_content_entity.dart';

class OnBoardingBody extends StatelessWidget {
  const OnBoardingBody({required this.content, super.key});

  final PageContent content;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          content.image,
          height: context.height * 0.4,
        ),
        Padding(
          padding: const EdgeInsets.all(20).copyWith(bottom: 0),
          child: Column(
            children: [
              Text(
                content.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontFamily: Fonts.aeonik,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: context.height * 0.02,
              ),
              Text(
                content.description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontFamily: Fonts.aeonik,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: context.height * 0.05,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 17),
                  backgroundColor: Colours.primaryColour,
                  foregroundColor: Colors.white,
                ),
                onPressed: () async {
                  //TODO (get-started): impplement this functionaltiy
                  //cache user
                  //push them to appropriate screen
                },
                child: const Text(
                  'Get Started',
                  style: TextStyle(
                    fontFamily: Fonts.aeonik,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
