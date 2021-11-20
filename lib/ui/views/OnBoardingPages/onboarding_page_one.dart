import 'package:flutter/material.dart';
import 'package:fridayy_one/business_logic/utils/custom_painters/onboarding_backgrounds/onboarding_bacground_one.dart';
import 'package:fridayy_one/services/service_locator.dart';

class OnBoardingPageOne extends StatefulWidget {
  const OnBoardingPageOne({Key? key}) : super(key: key);
  @override
  _OnBoardingPageOneState createState() => _OnBoardingPageOneState();
}

class _OnBoardingPageOneState extends State<OnBoardingPageOne>
    with TickerProviderStateMixin {
  late AnimationController imageAnimator;
  late Animation<double> animation;

  @override
  void initState() {
    imageAnimator = AnimationController(
      duration: const Duration(milliseconds: 750),
      vsync: this,
    )..forward();
    animation = Tween<double>(begin: 250, end: 270).animate(imageAnimator);
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
          bottom: sizeConfig.getPropHeight(154),
          child: CustomPaint(
            size: Size(
              sizeConfig.getPropWidth(411),
              sizeConfig.getPropHeight(
                217.82,
              ),
            ),
            painter: OnBoardingBackgroundOne(),
          ),
        ),
        AnimatedBuilder(
          builder: (context, child) {
            return Positioned(
              top: sizeConfig.getPropHeight(animation.value),
              left: sizeConfig.getPropWidth(85),
              height: sizeConfig.getPropHeight(449.85),
              width: sizeConfig.getPropWidth(261.78),
              child: child!,
            );
          },
          animation: animation,
          child: Container(
            alignment: Alignment.topLeft,
            child: Image.asset(
              'assets/images/ob1.png',
            ),
          ),
        ),
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: sizeConfig.getPropHeight(92),
              ),
              Text(
                "Easy way to \nmanage your offers",
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.center,
              ),
              Text(
                "Manage all your offers at one place\nwith ease",
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
