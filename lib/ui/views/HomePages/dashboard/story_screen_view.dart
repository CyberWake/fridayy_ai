import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fridayy_one/business_logic/models/user_overview_model.dart';
import 'package:fridayy_one/business_logic/utils/fridayy_svg.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/widgets/display_offer.dart';
import 'package:story/story_page_view/story_page_view.dart';
import 'package:url_launcher/url_launcher.dart';

class StoryScreenView extends StatelessWidget {
  const StoryScreenView({
    Key? key,
    required this.offers,
    required this.startIndex,
  }) : super(key: key);
  final List<OffersByBrand> offers;
  final int startIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoryPageView(
        initialPage: startIndex,
        itemBuilder: (context, pageIndex, storyIndex) {
          final storyOffer = offers[pageIndex].offers![storyIndex];
          return Stack(
            children: [
              Positioned.fill(
                child: Container(color: Colors.black),
              ),
              Center(
                child: DisplayOffer(
                  offerInfo: storyOffer,
                  brandId: offers[pageIndex].brandId,
                ),
              )
            ],
          );
        },
        gestureItemBuilder: (context, pageIndex, storyIndex) {
          final storyOffer = offers[pageIndex].offers![storyIndex];
          return Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    color: Colors.white,
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              Positioned(
                bottom: sizeConfig.getPropHeight(0),
                left: sizeConfig.getPropWidth(38),
                width: sizeConfig.getPropWidth(335),
                height: sizeConfig.getPropHeight(94),
                child: GestureDetector(
                  onVerticalDragUpdate: (details) async {
                    final position = MediaQuery.of(context).size.height -
                        details.globalPosition.dy;
                    if (!position.isNegative) {
                      navigationService.pop();
                      if (storyOffer.code != null) {
                        FlutterClipboard.copy(storyOffer.code!).whenComplete(
                          () => navigationService
                              .showSnackBar('Coupon Code copied'),
                        );
                      } else if (storyOffer.link != null) {
                        await canLaunch(storyOffer.link!)
                            ? await launch(storyOffer.link!)
                            : navigationService
                                .showSnackBar('Failed to open link');
                      }
                    }
                  },
                  child: Column(
                    children: [
                      SvgPicture.string(FridayySvg.arrowUpIcon),
                      const Text(
                        'Swipe Up to claim this offer',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        //  indicatorAnimationController: indicatorAnimationController,
        initialStoryIndex: (pageIndex) {
          if (pageIndex == 0) {
            return 0;
          }
          return 0;
        },
        pageLength: offers.length,
        storyLength: (int pageIndex) {
          return offers[pageIndex].offers!.length;
        },
        onPageLimitReached: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
