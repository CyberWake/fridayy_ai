import 'package:flutter/material.dart';
import 'package:fridayy_one/business_logic/utils/custom_painters/fridayy_logo/ring_dark_inner.dart';
import 'package:fridayy_one/business_logic/utils/custom_painters/fridayy_logo/ring_dark_outer.dart';
import 'package:fridayy_one/business_logic/utils/custom_painters/fridayy_logo/ring_light_inner.dart';
import 'package:fridayy_one/business_logic/utils/custom_painters/fridayy_logo/ring_light_outer.dart';
import 'package:fridayy_one/business_logic/utils/routing_constants.dart';
import 'package:fridayy_one/business_logic/view_models/splash_screen_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/views/base_view.dart';
import 'package:fridayy_one/ui/widgets/draw.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController ringDarkOuter;
  late AnimationController ringLightOuter;
  late AnimationController ringDarkInner;
  late AnimationController ringLightInner;
  late AnimationController colorExpand;
  late Animation<double> animation;
  final isForward = ValueNotifier<bool>(true);

  @override
  void initState() {
    ringDarkOuter = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..forward();
    ringLightOuter = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..forward();
    ringDarkInner = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..forward();
    ringLightInner = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..forward();
    ringLightInner.addListener(() {
      if (ringLightInner.isCompleted) {
        colorExpand.forward();
      }
    });
    colorExpand = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..addListener(() {
        if (colorExpand.isCompleted) {
          if (isForward.value) {
            setState(() {
              isForward.value = false;
            });
            colorExpand.reverse().whenComplete(() async {
              final key = await localDatabaseService.fetchAuthKey();
              print(key);
              navigationService.pushReplacementScreen(
                key == "null" ? Routes.homeScreen : Routes.onBoardingScreen,
                arguments: {
                  'autoLogin': true,
                },
              );
            });
          }
        }
      });
    animation = Tween<double>(begin: 0, end: 800).animate(colorExpand);
    super.initState();
  }

  @override
  void dispose() {
    ringDarkOuter.dispose();
    ringLightOuter.dispose();
    ringDarkInner.dispose();
    ringLightInner.dispose();
    colorExpand.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    sizeConfig.init(context);
    return BaseView<SplashScreenViewModel>(
      onModelReady: (model) => model.init(),
      builder: (context, model, child) {
        return Scaffold(
          body: Stack(
            children: [
              Center(
                child: RotationTransition(
                  turns: Tween(begin: 0.0, end: 2.0).animate(ringDarkOuter),
                  child: Draw(
                    squareSize: 169,
                    painter: LogoRingLightOuter(),
                  ),
                ),
              ),
              Center(
                child: RotationTransition(
                  turns: Tween(begin: 2.0, end: 0.0).animate(ringLightOuter),
                  child: Draw(
                    squareSize: 162,
                    painter: LogoRingDarkOuter(),
                  ),
                ),
              ),
              Center(
                child: RotationTransition(
                  turns: Tween(begin: 0.0, end: 1.0).animate(ringDarkInner),
                  child: Draw(
                    squareSize: 149,
                    painter: LogoRingLightInner(),
                  ),
                ),
              ),
              Center(
                child: RotationTransition(
                  turns: Tween(begin: 1.0, end: 0.0).animate(ringLightInner),
                  child: Draw(
                    squareSize: 142,
                    painter: LogoRingDarkInner(),
                  ),
                ),
              ),
              Center(
                child: AnimatedBuilder(
                  animation: animation,
                  builder: (context, child) {
                    return Container(
                      height: animation.value,
                      width: animation.value,
                      decoration: BoxDecoration(
                        color: isForward.value
                            ? const Color(0xff2128bd).withOpacity(1.0)
                            : const Color(0xffc7c9ee).withOpacity(1.0),
                        borderRadius:
                            BorderRadius.circular(823 - animation.value),
                      ),
                      child: Container(),
                      //height: sizeConfig.screenHeight,//animation.value,
                      //width: sizeConfig.screenHeight,//animation.value,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
