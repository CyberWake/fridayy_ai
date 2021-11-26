import 'package:flutter/material.dart';

class OfferInfoTile extends StatelessWidget {
  const OfferInfoTile({Key? key, required this.infoName, this.value})
      : super(key: key);
  final String infoName;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              infoName,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontSize: 13,
                    color: const Color(0xFF71828A),
                  ),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Text(
              value ?? "NA",
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontSize: 13,
                    color: const Color(0xFF71828A),
                  ),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
