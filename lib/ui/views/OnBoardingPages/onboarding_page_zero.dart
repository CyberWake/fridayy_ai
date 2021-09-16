import 'package:flutter/material.dart';
import 'package:fridayy_one/business_login/utils/custom_painters/onboarding_backgrounds/onboarding_background_zero.dart';
import 'package:fridayy_one/services/service_locator.dart';

class OnBoardingPageZero extends StatefulWidget {
  const OnBoardingPageZero({Key? key}) : super(key: key);
  @override
  _OnBoardingPageZeroState createState() => _OnBoardingPageZeroState();
}

class _OnBoardingPageZeroState extends State<OnBoardingPageZero>
    with TickerProviderStateMixin {
  late AnimationController imageAnimator;
  late Animation<double> animation;

  @override
  void initState() {
    imageAnimator = AnimationController(
      duration: const Duration(milliseconds: 750),
      vsync: this,
    )..forward();
    animation = Tween<double>(begin: 45, end: 65).animate(imageAnimator);
    imageAnimator.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    imageAnimator.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 0,
          top: sizeConfig.getPropHeight(132),
          child: CustomPaint(
            size: Size(
              sizeConfig.getPropWidth(411),
              sizeConfig.getPropHeight(
                503.83,
              ),
            ),
            painter: OnBoardingBackgroundZero(),
          ),
        ),
        AnimatedBuilder(
          builder: (context, child) {
            return Positioned(
              top: sizeConfig.getPropHeight(animation.value),
              left: sizeConfig.getPropWidth(20),
              height: sizeConfig.getPropHeight(449.85),
              width: sizeConfig.getPropWidth(261.78),
              child: child!,
            );
          },
          animation: animation,
          child: Container(
            alignment: Alignment.topLeft,
            child: Image.asset(
              'assets/images/ob0.png',
            ),
          ),
        ),
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Enjoy recommended offers",
                style: Theme.of(context).textTheme.headline5,
              ),
              Text(
                "Our intelligent engine curates \noffers just for you",
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: sizeConfig.getPropHeight(168),
              ),
            ],
          ),
        )
      ],
    );
  }
}
