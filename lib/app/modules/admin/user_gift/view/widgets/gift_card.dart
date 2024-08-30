import 'package:flutter/material.dart';
import '../../data/model/model.dart';
import 'gift_row.dart';

class GiftCard extends StatelessWidget {
  final UserGiftDataModel giftData;

  const GiftCard({Key? key, required this.giftData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "${giftData.firstName ?? ''} ${giftData.lastName ?? ''}",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                Spacer(),
                GiftAndWalletRowWidget(
                  controller: TextEditingController(
                    text: giftData.totalGifts?.toString() ?? '0',
                  ),
                  giftLabel: "Total Gifts: ",
                ),
              ],
            ),
            SizedBox(height: 16),
            ...giftData.competitionsWallets?.map((wallet) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    GiftAndWalletRowWidget(
                      controller: TextEditingController(
                        text: wallet.amount?.toString() ?? '0',
                      ),
                      giftLabel: wallet.competitionId?.nameEn ?? 'Gift',
                    ),
                    Spacer(),
                  ],
                ),
              );
            }).toList() ??
                [],
          ],
        ),
      ),
    );
  }
}
