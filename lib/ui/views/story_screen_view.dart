import 'dart:convert';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fridayy_one/business_login/models/user_overview_model.dart';
import 'package:fridayy_one/business_login/utils/fridayy_svg.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:story/story_page_view/story_page_view.dart';
import 'package:url_launcher/url_launcher.dart';

class StoryScreenView extends StatefulWidget {
  const StoryScreenView(
      {Key? key, required this.offers, required this.startIndex,})
      : super(key: key);
  final List<NotifiedOffers> offers;
  final int startIndex;

  @override
  State<StoryScreenView> createState() => _StoryScreenViewState();
}

class _StoryScreenViewState extends State<StoryScreenView> {
  late ValueNotifier<IndicatorAnimationCommand> indicatorAnimationController;
  late List brandData = [];
  @override
  void initState() {
    super.initState();
    loadAssets();
    indicatorAnimationController = ValueNotifier<IndicatorAnimationCommand>(
        IndicatorAnimationCommand.resume,);
  }

  loadAssets() async {
    final String data = await DefaultAssetBundle.of(
      navigationService.navigatorKey.currentContext!,
    ).loadString("assets/brand_data.json");
    brandData = jsonDecode(data) as List;
    setState(() {});
  }

  @override
  void dispose() {
    indicatorAnimationController.dispose();
    super.dispose();
  }

  Widget getOfferImage(
    BuildContext context, {
    required String name,
  }) {
    for (int i = 0; i < brandData.length; i++) {
      if (brandData[i]['brandName'].toString() == name) {
        return Image.memory(
          base64.decode(brandData[i]['brandImg'].toString().split(',').last),
          scale: 1,
        );
      }
    }
    return Image.network('');
  }

  Widget offerInfo(BuildContext context, String infoName, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          infoName,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontSize: 13,
                color: const Color(0xFF71828A),
              ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontSize: 13,
                color: const Color(0xFF71828A),
              ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoryPageView(
        initialPage: widget.startIndex,
        itemBuilder: (context, pageIndex, storyIndex) {
          final storyOffer = widget.offers[pageIndex].offers;
          return Stack(
            children: [
              Positioned.fill(
                child: Container(color: Colors.black),
              ),
              Center(
                child: SizedBox(
                  height: sizeConfig.getPropHeight(555),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        height: sizeConfig.getPropHeight(192),
                        width: sizeConfig.getPropWidth(336),
                        padding: EdgeInsets.symmetric(
                          horizontal: sizeConfig.getPropWidth(20),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            sizeConfig.getPropHeight(8),
                          ),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  top: sizeConfig.getPropHeight(20),),
                              height: sizeConfig.getPropHeight(49),
                              width: sizeConfig.getPropWidth(113),
                              child: getOfferImage(context,
                                  name: storyOffer!.brandName,),
                            ),
                            Text(
                              storyOffer.rewardType == 'DISCOUNT'
                                  ? '${storyOffer.rewardAmount} %OFF'
                                  : 'Rs. ${storyOffer.rewardAmount}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                            ),
                            Expanded(
                              child: Text(
                                storyOffer.body,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      fontSize: 12,
                                      color: const Color(0xFF9399A3),
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: sizeConfig.getPropHeight(9),
                      ),
                      Container(
                        height: sizeConfig.getPropHeight(192),
                        width: sizeConfig.getPropWidth(336),
                        padding: EdgeInsets.symmetric(
                          horizontal: sizeConfig.getPropWidth(20),
                          vertical: sizeConfig.getPropHeight(20),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            sizeConfig.getPropHeight(8),
                          ),
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Offer Details',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(fontSize: 14, color: Colors.black),
                            ),
                            offerInfo(
                              context,
                              'Coupon Code',
                              storyOffer.code ?? storyOffer.link ?? 'NA',
                            ),
                            offerInfo(
                              context,
                              'Offer Validity',
                              storyOffer.expiryDate ?? "Never Expiring",
                            ),
                            offerInfo(
                              context,
                              'Other info',
                              storyOffer.rewardDescription ?? "NA",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
        gestureItemBuilder: (context, pageIndex, storyIndex) {
          final storyOffer = widget.offers[pageIndex].offers;
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
                      if (storyOffer!.code != null) {
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
        indicatorAnimationController: indicatorAnimationController,
        initialStoryIndex: (pageIndex) {
          if (pageIndex == 0) {
            return 0;
          }
          return 0;
        },
        pageLength: widget.offers.length,
        storyLength: (int pageIndex) {
          return 1;
        },
        onPageLimitReached: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
