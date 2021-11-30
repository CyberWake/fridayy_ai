import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fridayy_one/business_logic/models/spends_model.dart';
import 'package:fridayy_one/business_logic/utils/api_constants.dart';
import 'package:fridayy_one/business_logic/utils/constants.dart';
import 'package:fridayy_one/business_logic/utils/extensions.dart';
import 'package:fridayy_one/business_logic/utils/fridayy_svg.dart';
import 'package:fridayy_one/business_logic/utils/routing_constants.dart';
import 'package:fridayy_one/services/service_locator.dart';
import 'package:fridayy_one/ui/widgets/popups/spends/card_type.dart';
import 'package:fridayy_one/ui/widgets/popups/spends/category_type.dart';
import 'package:fridayy_one/ui/widgets/popups/spends/delete_transaction.dart';
import 'package:fridayy_one/ui/widgets/rounded_rectangular_button.dart';

class EditSpendView extends StatefulWidget {
  const EditSpendView({Key? key, required this.spendInfo}) : super(key: key);
  final SpendsModel spendInfo;

  @override
  State<EditSpendView> createState() => _EditSpendViewState();
}

class _EditSpendViewState extends State<EditSpendView> {
  late SpendsModel spendInfo;
  final TextEditingController brandNameController = TextEditingController();
  Widget buildItems({
    required String svgImage,
    required String label,
    Function()? onTap,
    bool editable = false,
  }) {
    return Expanded(
      child: InkWell(
        onTap: !editable ? null : onTap,
        child: Padding(
          padding: EdgeInsets.only(
            left: sizeConfig.getPropWidth(12),
          ),
          child: Row(
            children: [
              Container(
                height: sizeConfig.getPropWidth(44),
                width: sizeConfig.getPropWidth(44),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border:
                      Border.all(width: 0.5, color: const Color(0xFF2128BD)),
                ),
                child: SvgPicture.string(
                  svgImage,
                  height: 36,
                  width: 36,
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: sizeConfig.getPropWidth(28),
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  label,
                  style:
                      Theme.of(navigationService.navigatorKey.currentContext!)
                          .textTheme
                          .caption!
                          .copyWith(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                ),
              ),
              const Spacer(),
              if (editable) SvgPicture.string(FridayySvg.arrowRight),
            ],
          ),
        ),
      ),
    );
  }

  showDeletePopUp(SpendsModel spend) async {
    showModalBottomSheet(
      context: navigationService.navigatorKey.currentContext!,
      constraints: BoxConstraints(
        maxWidth: sizeConfig.getPropWidth(379),
        minHeight: sizeConfig.getPropHeight(351),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
        child: Center(
          child: DeleteTransaction(spend: spendInfo),
        ),
      ),
    );
  }

  showCategoryPopUp() async {
    showModalBottomSheet(
      context: navigationService.navigatorKey.currentContext!,
      constraints: BoxConstraints(
        maxWidth: sizeConfig.getPropWidth(379),
        minHeight: sizeConfig.getPropHeight(351),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
        child: Center(
          child: CategoryTypePopUp(
            onTap: (value) {
              print('running');
              spendInfo.categoryId = value;
              navigationService.pop();
              setState(() {});
            },
          ),
        ),
      ),
    );
  }

  showPaymentTypePopUp() async {
    showModalBottomSheet(
      context: navigationService.navigatorKey.currentContext!,
      constraints: BoxConstraints(
        maxWidth: sizeConfig.getPropWidth(379),
        minHeight: sizeConfig.getPropHeight(351),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
        child: Center(
          child: CardTypePopUp(
            onTap: (value) {
              print('running');
              spendInfo.paymentType = value;
              navigationService.pop();
              setState(() {});
            },
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    spendInfo = widget.spendInfo;
    brandNameController.text = spendInfo.brandName.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color(0xFFF9F9F9),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.grey,
            size: 20,
          ),
          onPressed: () => navigationService.pop(),
        ),
        title: Text(
          widget.spendInfo.brandName!,
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
              onTap: () {},
              child: SvgPicture.string(
                FridayySvg.notificationIcon,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: sizeConfig.getPropHeight(70),
            padding: EdgeInsets.symmetric(
              horizontal: sizeConfig.getPropWidth(45),
            ),
            color: const Color(0xFFF9F9F9),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rs. ${widget.spendInfo.amount.toString()}',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            fontSize: 20,
                            color: const Color(0xFF2128BD),
                          ),
                    ),
                    Text(
                      widget.spendInfo.date!.toDate(),
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                    ),
                  ],
                ),
                const Spacer(),
                InkWell(
                  onTap: () => showDeletePopUp(spendInfo),
                  child: SvgPicture.string(
                    FridayySvg.deleteIcon,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SizedBox(
              height: sizeConfig.getPropHeight(670),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: sizeConfig.getPropHeight(91),
                      width: sizeConfig.getPropWidth(379),
                      margin: EdgeInsets.only(
                        top: sizeConfig.getPropHeight(16),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: sizeConfig.getPropWidth(32),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          sizeConfig.getPropWidth(16),
                        ),
                        border: Border.all(
                          color: const Color(0xFFE7ECEE),
                        ),
                      ),
                      child: Row(
                        children: [
                          CachedNetworkImage(
                            imageUrl:
                                'https://friday-images.s3.ap-south-1.amazonaws.com/${spendInfo.brandId}.jpeg',
                            imageBuilder: (context, imageProvider) => Container(
                              width: sizeConfig.getPropHeight(44),
                              height: sizeConfig.getPropHeight(44),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  width: 0.5,
                                  color: const Color(0xFF2128BD),
                                ),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                sizeConfig.getPropWidth(8),
                                sizeConfig.getPropHeight(4),
                                sizeConfig.getPropWidth(8),
                                sizeConfig.getPropHeight(16),
                              ),
                              child: TypeAheadField<Map<String, String>>(
                                getImmediateSuggestions: true,
                                textFieldConfiguration: TextFieldConfiguration(
                                  controller: brandNameController,
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(color: Colors.black),
                                  decoration: InputDecoration(
                                    labelText: 'Edit Brand Name',
                                    labelStyle: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                          fontSize: 12,
                                        ),
                                  ),
                                ),
                                suggestionsCallback: (pattern) async {
                                  final List<Map<String, String>> suggestions =
                                      [];
                                  brandBrandIds.forEach((element) {
                                    if (element['brand_name']!
                                        .toLowerCase()
                                        .startsWith(pattern.toLowerCase())) {
                                      suggestions.add(element);
                                    }
                                  });
                                  return suggestions;
                                },
                                itemBuilder: (context, suggestion) {
                                  return ListTile(
                                    leading: CachedNetworkImage(
                                      imageUrl:
                                          'https://friday-images.s3.ap-south-1.amazonaws.com/${suggestion['brand_id']}.jpeg',
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        width: sizeConfig.getPropHeight(44),
                                        height: sizeConfig.getPropHeight(44),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                    title: Text(
                                      suggestion['brand_name'].toString(),
                                    ),
                                  );
                                },
                                onSuggestionSelected: (suggestion) {
                                  brandNameController.text =
                                      suggestion['brand_name'].toString();
                                  setState(() {
                                    spendInfo.brandName =
                                        brandNameController.text;
                                    spendInfo.brandId =
                                        suggestion['brand_id'].toString();
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: sizeConfig.getPropHeight(91),
                      width: sizeConfig.getPropWidth(379),
                      margin: EdgeInsets.only(
                        top: sizeConfig.getPropHeight(16),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: sizeConfig.getPropWidth(32),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          sizeConfig.getPropWidth(16),
                        ),
                        border: Border.all(
                          color: const Color(0xFFE7ECEE),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: sizeConfig.getPropWidth(44),
                            width: sizeConfig.getPropWidth(44),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                width: 0.5,
                                color: const Color(0xFF2128BD),
                              ),
                            ),
                            child: SvgPicture.string(
                              FridayySvg.amountIcon,
                              height: 36,
                              width: 36,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                sizeConfig.getPropWidth(8),
                                sizeConfig.getPropHeight(4),
                                sizeConfig.getPropWidth(8),
                                sizeConfig.getPropHeight(16),
                              ),
                              child: TextFormField(
                                initialValue: spendInfo.amount.toString(),
                                keyboardType: TextInputType.number,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(color: Colors.black),
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    setState(() {
                                      spendInfo.amount = double.parse(value);
                                    });
                                  }
                                },
                                onFieldSubmitted: (value) {
                                  if (value.isNotEmpty) {
                                    setState(() {
                                      spendInfo.amount = double.parse(value);
                                    });
                                  }
                                },
                                decoration: InputDecoration(
                                  labelText: 'Edit Amount',
                                  labelStyle: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                        fontSize: 12,
                                      ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: sizeConfig.getPropHeight(252),
                      width: sizeConfig.getPropWidth(379),
                      margin: EdgeInsets.symmetric(
                        horizontal: sizeConfig.getPropWidth(16),
                        vertical: sizeConfig.getPropHeight(16),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: sizeConfig.getPropWidth(20),
                        vertical: sizeConfig.getPropHeight(10),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          sizeConfig.getPropWidth(16),
                        ),
                        border: Border.all(
                          color: const Color(0xFFE7ECEE),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildItems(
                            svgImage: spendInfo.categoryId!.getSvg(),
                            label: spendInfo.categoryId!.getName(),
                            editable: true,
                            onTap: showCategoryPopUp,
                          ),
                          const Divider(),
                          buildItems(
                            svgImage: spendInfo.paymentType!.getSvg(),
                            label: spendInfo.paymentType!,
                            editable: true,
                            onTap: showPaymentTypePopUp,
                          ),
                          const Divider(),
                          buildItems(
                            svgImage: FridayySvg.messageIcon,
                            label: spendInfo.address!,
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(
                          sizeConfig.getPropWidth(16),
                          0,
                          sizeConfig.getPropWidth(16),
                          sizeConfig.getPropHeight(16),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            sizeConfig.getPropWidth(16),
                          ),
                          border: Border.all(
                            color: const Color(0xFFE7ECEE),
                          ),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: sizeConfig.getPropWidth(20),
                            vertical: sizeConfig.getPropHeight(20),
                          ),
                          child: Text(
                            spendInfo.body!,
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(bottom: sizeConfig.getPropHeight(16)),
                      child: CustomRoundRectButton(
                        onTap: () async {
                          final result = await apiService.putRequest(
                            '${ApiConstants.updateSpend}/${spendInfo.spendId}',
                            {
                              "amount": spendInfo.amount,
                              "brand_name": spendInfo.brandName,
                              "brand_id": spendInfo.brandId,
                              "payment_type": spendInfo.paymentType,
                              "category_id": spendInfo.categoryId,
                            },
                          );
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
                        },
                        fillColor: Colors.white,
                        child: Text(
                          'Save transaction',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
