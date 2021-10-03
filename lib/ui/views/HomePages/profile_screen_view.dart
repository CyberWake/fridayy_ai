import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fridayy_one/business_login/utils/fridayy_svg.dart';
import 'package:fridayy_one/business_login/view_models/HomeViewModels/home_screen_holder_view_model.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/widgets/rounded_rectangular_button.dart';

class ProfileScreenView extends StatelessWidget {
  const ProfileScreenView({Key? key, required this.homeModel})
      : super(key: key);
  final HomeScreenHolderViewModel homeModel;

  Widget dataTile(BuildContext context, String fieldName, String fieldValue) {
    return Row(
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
    );
  }

  Widget heading(BuildContext context, String heading) {
    return Text(
      heading,
      style: Theme.of(context).textTheme.bodyText2!.copyWith(
            fontSize: 14,
            color: const Color(0xFF94A0B4),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
              onTap: homeModel.gotoNotifications,
              child: SvgPicture.string(
                FridayySvg.editIcon,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: sizeConfig.getPropWidth(16)),
        child: Column(
          children: [
            Container(
              height: sizeConfig.getPropHeight(178),
              width: sizeConfig.getPropWidth(379),
              margin: EdgeInsets.only(top: sizeConfig.getPropHeight(16)),
              padding: EdgeInsets.only(top: sizeConfig.getPropHeight(11.5)),
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
                      borderRadius: BorderRadius.circular(
                        sizeConfig.getPropWidth(16),
                      ),
                      color: Colors.grey[200],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: sizeConfig.getPropHeight(24),
                    ),
                    child: Text(
                      'Alexandra Bill',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: sizeConfig.getPropHeight(364),
              width: sizeConfig.getPropWidth(379),
              margin: EdgeInsets.only(top: sizeConfig.getPropHeight(16)),
              padding: EdgeInsets.symmetric(
                horizontal: sizeConfig.getPropWidth(20),
                vertical: sizeConfig.getPropHeight(20),
              ),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFE7ECEE)),
                borderRadius: BorderRadius.circular(
                  sizeConfig.getPropWidth(16),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  heading(context, 'Personal Information'),
                  const Divider(),
                  dataTile(context, 'Phone Number', '+917985434483'),
                  const Divider(),
                  dataTile(context, 'E-mail', 'kirana@gmail.com'),
                  const Divider(),
                  heading(context, 'Device Information'),
                  const Divider(),
                  dataTile(context, 'Primary Device', 'Samsung A50'),
                  const Divider(),
                  dataTile(context, 'App Version', '2.25.0(152)'),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: sizeConfig.getPropHeight(16),
              ),
              child: CustomRoundRectButton(
                onTap: () {},
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
    );
  }
}
