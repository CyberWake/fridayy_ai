import 'package:flutter/material.dart';
import 'package:fridayy_one/business_logic/models/user_overview_model.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/widgets/custom_text_field_with_title/custom_textfield.dart';
import 'package:fridayy_one/ui/widgets/rounded_rectangular_button.dart';

class TellUsDialog extends StatefulWidget {
  const TellUsDialog({
    Key? key,
    required this.offerInfo,
  }) : super(key: key);
  final OfferInfo offerInfo;

  @override
  State<TellUsDialog> createState() => _TellUsDialogState();
}

class _TellUsDialogState extends State<TellUsDialog> {
  final TextEditingController controller = TextEditingController();
  final List<bool> itemCheckedStatus = [
    false,
    false,
    false,
    false,
  ];
  final List<String> itemTitles = [
    'Offer not working',
    'Offer already expired',
    'Wrong labelling',
    'Other',
  ];

  Widget _buildCheckBoxWithText(
    BuildContext context,
    String title,
    int itemIndex,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          checkColor: Colors.white,
          activeColor: const Color(0xFF2128BD),
          value: itemCheckedStatus[itemIndex],
          tristate: true,
          onChanged: (state) {
            setState(() {
              itemCheckedStatus[itemIndex] = state ?? false;
            });
          },
        ),
        SizedBox(
          height: sizeConfig.getPropWidth(4),
        ),
        Expanded(
          child: Text(
            title,
            style: Theme.of(navigationService.navigatorKey.currentContext!)
                .textTheme
                .caption!
                .copyWith(
                  fontSize: 14,
                  color: Colors.black,
                ),
          ),
        ),
      ],
    );
  }

  void sendOfferFeedBack() {
    // TODO: send offer feedback api call and then close the popup
    navigationService.showSnackBar('Feedback received by us Thank you!');
    navigationService.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeConfig.getPropHeight(351),
      width: sizeConfig.getPropWidth(379),
      padding: EdgeInsets.symmetric(
        horizontal: sizeConfig.getPropWidth(20),
        vertical: sizeConfig.getPropHeight(20),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          sizeConfig.getPropWidth(16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Tell us what’s happening',
            style: Theme.of(context).textTheme.caption!.copyWith(
                  fontSize: 16,
                  color: Colors.black,
                ),
          ),
          Text(
            'Tick all that apply',
            style: Theme.of(context).textTheme.caption!.copyWith(
                  fontSize: 12,
                  color: const Color(0xFF6A6A6A),
                ),
          ),
          SizedBox(
            height: sizeConfig.getPropHeight(16),
          ),
          SizedBox(
            height: sizeConfig.getPropHeight(100),
            width: sizeConfig.getPropWidth(350),
            child: Column(
              children: List.generate(
                4,
                (index) => Flexible(
                  fit: FlexFit.loose,
                  child: _buildCheckBoxWithText(
                    context,
                    itemTitles[index],
                    index,
                  ),
                ),
              ),
            ),
          ),
          CustomTextFieldWithTitle(
            controller: controller,
            title: '',
            hintText:
                'Describe the issue you’re facing so that we can understand it better.',
            keyboardType: TextInputType.multiline,
            validator: (String? value) {},
            textInputAction: TextInputAction.done,
            filledColor: const Color(0xFFF0F0F0),
            style: Theme.of(context)
                .textTheme
                .caption!
                .copyWith(fontSize: 12, color: const Color(0xFF6A6A6A)),
          ),
          SizedBox(
            height: sizeConfig.getPropHeight(16),
          ),
          SizedBox(
            height: sizeConfig.getPropHeight(50),
            child: Row(
              children: List.generate(
                3,
                (index) => index == 1
                    ? SizedBox(
                        width: sizeConfig.getPropWidth(7),
                      )
                    : Flexible(
                        fit: FlexFit.loose,
                        child: CustomRoundRectButton(
                          onTap: index == 0
                              ? () => navigationService.pop()
                              : sendOfferFeedBack,
                          fillColor: Colors.white,
                          size: const Size(
                            165.5,
                            50,
                          ),
                          child: Text(index == 0 ? 'Cancel' : 'Send'),
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
