import 'package:flutter/material.dart';
import 'package:fridayy_one/business_logic/models/spends_model.dart';
import 'package:fridayy_one/business_logic/utils/api_constants.dart';
import 'package:fridayy_one/business_logic/utils/extensions.dart';
import 'package:fridayy_one/business_logic/utils/routing_constants.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/widgets/rounded_rectangular_button.dart';

class DeleteTransaction extends StatelessWidget {
  const DeleteTransaction({Key? key, required this.spend}) : super(key: key);
  final SpendsModel spend;

  deleteSpend() async {
    final result = await apiService
        .getRequest('${ApiConstants.deleteSpend}/${spend.spendId}');
    if (result.data != null) {
      print(result.data);
      navigationService.removeAllAndPush(
        Routes.homeScreen,
        Routes.splashScreen,
        arguments: {'activePage': 2, 'autoLogin': true},
      );
    } else {
      print(result.exception);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeConfig.getPropHeight(179),
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
        children: [
          Text(
            'Delete this transaction?',
            style: Theme.of(context).textTheme.caption!.copyWith(
                  fontSize: 20,
                  color: Colors.black,
                ),
          ),
          SizedBox(
            height: sizeConfig.getPropHeight(20),
          ),
          Text(
            "${spend.brandName}'s - ₹ ${spend.amount} - ${spend.date!.toDateddMMMyyyy()}",
            style: Theme.of(context).textTheme.caption!.copyWith(
                  fontSize: 16,
                  color: Colors.black,
                ),
          ),
          SizedBox(
            height: sizeConfig.getPropHeight(19),
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
                              : deleteSpend,
                          fillColor: index == 0
                              ? const Color(0xFF2128BD)
                              : Colors.white,
                          size: const Size(
                            165.5,
                            50,
                          ),
                          child: Text(
                            index == 0 ? 'No' : 'Yes',
                            style: index == 0
                                ? Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(color: Colors.white)
                                : null,
                          ),
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
