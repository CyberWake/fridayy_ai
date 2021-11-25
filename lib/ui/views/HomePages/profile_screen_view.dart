import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fridayy_one/business_logic/utils/fridayy_svg.dart';
import 'package:fridayy_one/business_logic/view_models/HomeViewModels/home_screen_holder_view_model.dart';
import 'package:fridayy_one/business_logic/view_models/HomeViewModels/profile_screen_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/views/base_view.dart';
import 'package:fridayy_one/ui/widgets/rounded_rectangular_button.dart';
import 'package:fridayy_one/ui/widgets/shimmer_card.dart';

class ProfileScreenView extends StatelessWidget {
  const ProfileScreenView({Key? key, required this.homeModel})
      : super(key: key);
  final HomeScreenHolderViewModel homeModel;

  Widget dataTile(
    BuildContext context,
    String fieldName,
    String fieldValue,
  ) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: sizeConfig.getPropHeight(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              fieldName,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontSize: 14,
                    color: const Color(0xFF5B667A),
                  ),
            ),
            Text(
              fieldValue,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontSize: 14,
                    color: const Color(0xFF000000),
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buttonTile(BuildContext context, String iconString, String title) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: sizeConfig.getPropHeight(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.string(iconString),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontSize: 14,
                    color: const Color(0xFF000000),
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget heading(BuildContext context, String heading) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: sizeConfig.getPropHeight(10),
      ),
      child: Text(
        heading,
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
              fontSize: 14,
              color: const Color(0xFF94A0B4),
            ),
      ),
    );
  }

  void logout(ProfileScreenViewModel model) {
    showModalBottomSheet(
      context: navigationService.navigatorKey.currentContext!,
      constraints: BoxConstraints(
        maxWidth: sizeConfig.getPropWidth(379),
        minHeight: sizeConfig.getPropHeight(420),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: sizeConfig.getPropHeight(420),
        width: sizeConfig.getPropWidth(379),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(sizeConfig.getPropWidth(16)),
            topRight: Radius.circular(sizeConfig.getPropWidth(16)),
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: sizeConfig.getPropHeight(45)),
              child: Image.asset('assets/images/emoji.png'),
            ),
            Padding(
              padding: EdgeInsets.only(top: sizeConfig.getPropHeight(4)),
              child: Text(
                'Sad to see you leave',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Colors.black, fontSize: 16),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: sizeConfig.getPropHeight(12)),
              child: Text(
                'Confirmation Required!',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.black, fontSize: 20),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: sizeConfig.getPropHeight(8)),
              child: Text(
                'Are you sure you want to deactive your account?',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Colors.black, fontSize: 16),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: sizeConfig.getPropHeight(8)),
              child: Text(
                'You’ll still be able to reactivate your account within 3 Months.',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: sizeConfig.getPropHeight(26)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomRoundRectButton(
                    onTap: () => navigationService.pop(),
                    size: const Size(170, 50),
                    borderColor: const Color(0xFF2128BD),
                    fillColor: const Color(0xFF2128BD),
                    child: Text(
                      'No',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                  CustomRoundRectButton(
                    onTap: model.logout,
                    size: const Size(170, 50),
                    fillColor: Colors.white,
                    borderColor: const Color(0xFF2128BD),
                    child: Text(
                      'Yes',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<ProfileScreenViewModel>(
      onModelReady: (model) => model.init(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: const Color(0xFFF9F9F9),
            centerTitle: false,
            automaticallyImplyLeading: false,
            title: Text(
              "Profile",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 20, color: Colors.black),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(
                  right: sizeConfig.getPropWidth(27),
                ),
                child: InkWell(
                  onTap: homeModel.gotoEditProfile,
                  child: SvgPicture.string(
                    FridayySvg.editIcon,
                  ),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: sizeConfig.getPropWidth(16)),
              child: Column(
                children: [
                  Container(
                    height: sizeConfig.getPropHeight(475),
                    width: sizeConfig.getPropWidth(379),
                    margin: EdgeInsets.only(top: sizeConfig.getPropHeight(16)),
                    padding: EdgeInsets.only(top: sizeConfig.getPropHeight(38)),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFE7ECEE)),
                      borderRadius: BorderRadius.circular(
                        sizeConfig.getPropWidth(16),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: sizeConfig.getPropHeight(104),
                          width: sizeConfig.getPropHeight(104),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[200],
                          ),
                          alignment: Alignment.center,
                          child: model.isBusy
                              ? ShimmerCard(
                                  size: Size(
                                    sizeConfig.getPropWidth(104),
                                    sizeConfig.getPropHeight(104),
                                  ),
                                  isCircle: true,
                                  borderRadius: 10,
                                )
                              : Text(
                                  model.user.userName.substring(0, 1),
                                  style: const TextStyle(fontSize: 42),
                                ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: sizeConfig.getPropHeight(27),
                          ),
                          child: model.isBusy
                              ? ShimmerCard(
                                  size: Size(
                                    sizeConfig.getPropWidth(100),
                                    sizeConfig.getPropHeight(30),
                                  ),
                                  borderRadius: 10,
                                )
                              : Text(
                                  model.user.userName,
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(
                              top: sizeConfig.getPropHeight(13),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: sizeConfig.getPropWidth(20),
                              vertical: sizeConfig.getPropHeight(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                heading(context, 'Personal Information'),
                                const Divider(),
                                model.isBusy
                                    ? ShimmerCard(
                                        size: Size(
                                          sizeConfig.getPropWidth(379),
                                          sizeConfig.getPropHeight(44),
                                        ),
                                        borderRadius: 10,
                                      )
                                    : dataTile(
                                        context,
                                        'Phone Number',
                                        model.user.countryCode! +
                                            model.user.mobile!,
                                      ),
                                const Divider(),
                                model.isBusy
                                    ? ShimmerCard(
                                        size: Size(
                                          sizeConfig.getPropWidth(379),
                                          sizeConfig.getPropHeight(44),
                                        ),
                                        borderRadius: 10,
                                      )
                                    : dataTile(
                                        context,
                                        'E-mail',
                                        model.user.email ?? 'NA',
                                      ),
                                const Divider(),
                                model.isBusy
                                    ? ShimmerCard(
                                        size: Size(
                                          sizeConfig.getPropWidth(379),
                                          sizeConfig.getPropHeight(44),
                                        ),
                                        borderRadius: 10,
                                      )
                                    : dataTile(
                                        context,
                                        'Last Refreshed',
                                        '02:00 18 Oct 2021',
                                      ),
                                const Divider(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: sizeConfig.getPropHeight(267),
                    width: sizeConfig.getPropWidth(379),
                    margin: EdgeInsets.only(top: sizeConfig.getPropHeight(16)),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFE7ECEE)),
                      borderRadius: BorderRadius.circular(
                        sizeConfig.getPropWidth(16),
                      ),
                    ),
                    child: Container(
                      margin: EdgeInsets.only(
                        top: sizeConfig.getPropHeight(10),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: sizeConfig.getPropWidth(20),
                        vertical: sizeConfig.getPropHeight(9),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          heading(context, 'App Settings'),
                          const Divider(),
                          model.isBusy
                              ? ShimmerCard(
                                  size: Size(
                                    sizeConfig.getPropWidth(379),
                                    sizeConfig.getPropHeight(44),
                                  ),
                                  borderRadius: 10,
                                )
                              : buttonTile(
                                  context,
                                  FridayySvg.fridayyLogo,
                                  ' About Us',
                                ),
                          const Divider(),
                          model.isBusy
                              ? ShimmerCard(
                                  size: Size(
                                    sizeConfig.getPropWidth(379),
                                    sizeConfig.getPropHeight(44),
                                  ),
                                  borderRadius: 10,
                                )
                              : buttonTile(
                                  context,
                                  FridayySvg.privacyIcon,
                                  ' Privacy Settings',
                                ),
                          const Divider(),
                          model.isBusy
                              ? ShimmerCard(
                                  size: Size(
                                    sizeConfig.getPropWidth(379),
                                    sizeConfig.getPropHeight(44),
                                  ),
                                  borderRadius: 10,
                                )
                              : buttonTile(
                                  context,
                                  FridayySvg.educationIcon,
                                  ' Terms & Conditions',
                                ),
                          const Divider(),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: sizeConfig.getPropHeight(16),
                    ),
                    child: CustomRoundRectButton(
                      onTap: () => logout(model),
                      fillColor: Colors.white,
                      child: Text(
                        'Deactivate Account',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
