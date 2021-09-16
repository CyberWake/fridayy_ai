import 'package:flutter/material.dart';
import 'package:fridayy_one/business_login/utils/custom_painters/onboarding_backgrounds/onboarding_background_two.dart';
import 'package:fridayy_one/services/service_locator.dart';

class OnBoardingPageTwo extends StatefulWidget {
  const OnBoardingPageTwo({Key? key}) : super(key: key);
  @override
  _OnBoardingPageTwoState createState() => _OnBoardingPageTwoState();
}

class _OnBoardingPageTwoState extends State<OnBoardingPageTwo>
    with TickerProviderStateMixin {
  late AnimationController imageAnimator;
  late Animation<double> animation;

  @override
  void initState() {
    imageAnimator = AnimationController(
      duration: const Duration(milliseconds: 750),
      vsync: this,
    )..forward();
    animation = Tween<double>(begin: 121, end: 141).animate(imageAnimator);
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
          right: 0,
          top: sizeConfig.getPropHeight(132),
          child: CustomPaint(
            size: Size(
              sizeConfig.getPropWidth(411),
              sizeConfig.getPropHeight(
                503.83,
              ),
            ),
            painter: OnBoardingBackgroundTwo(),
          ),
        ),
        AnimatedBuilder(
          builder: (context, child) {
            return Positioned(
                top: sizeConfig.getPropHeight(animation.value),
                left: sizeConfig.getPropWidth(42),
                height: sizeConfig.getPropHeight(377.3),
                width: sizeConfig.getPropWidth(360),
                child: child!,);
          },
          animation: animation,
          child: Container(
            alignment: Alignment.topLeft,
            child: Image.asset(
              'assets/images/ob2.png',
              fit: BoxFit.fill,
            ),
          ),
        ),
        Center(
          child: Column(
            children: [
              SizedBox(
                height: sizeConfig.getPropHeight(511),
              ),
              Text(
                "Track your expenses \nautomatically!",
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.center,
              ),
              Text(
                "Our intelligent engine summarizes all \nyour expenses in a jiffy",
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        )
      ],
    );
  }
}
