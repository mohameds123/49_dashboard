import 'package:flutter/material.dart';
import '../../../user_gift/view/widgets/gift_row.dart';
import '../../data/model/user_wallet_model.dart';

class DataCard extends StatefulWidget {
  final UserWalletDataModel userDataModel;

  DataCard({
    required this.userDataModel,
  });

  @override
  State<DataCard> createState() => _DataCardState();
}

class _DataCardState extends State<DataCard> {
  List<TextEditingController> balanceControllers = [];
  List<TextEditingController> walletControllers = [];
  List<TextEditingController> providerStorageControllers = [];
  List<TextEditingController> refendStorageControllers = [];
  List<TextEditingController> refStorageControllers = [];
  List<TextEditingController> clicksControllers = [];
  List<TextEditingController> numberOfReferralsControllers = [];
  List<TextEditingController> uniqueReferralsControllers = [];
  int? _visibleCardIndex; // Track which card's notification is visible

  @override
  void initState() {
    super.initState();

    // Initialize the controllers with data from the model
    for (var data in widget.userDataModel.data) {
      balanceControllers.add(TextEditingController(text: data.balance.toString()));
      walletControllers.add(TextEditingController(text: data.realAmount.toString()));
      providerStorageControllers.add(TextEditingController(text: data.providerCashBack.toString()));
      refendStorageControllers.add(TextEditingController(text: data.refundStorage.toString()));
      refStorageControllers.add(TextEditingController(text: data.referralStorage.toString()));
      clicksControllers.add(TextEditingController(text: data.freeClickStorage.toString()));
      numberOfReferralsControllers.add(TextEditingController(text: data.referralCount.toString()));
      uniqueReferralsControllers.add(TextEditingController(text: data.uniqueReferralCount.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.userDataModel.data.asMap().entries.map((entry) {
        final index = entry.key;
        final data = entry.value;

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
                // Notification IconButton
                IconButton(
                  onPressed: () {
                    setState(() {
                      _visibleCardIndex = (_visibleCardIndex == index) ? null : index;
                    });
                  },
                  icon: Icon(Icons.notifications_active_outlined, color: Colors.black),
                ),
                // Conditionally display the SentNotify widget
                if (_visibleCardIndex == index) SentNotify(),
                _buildDataRow('User Name', '${data.userId?.firstName ?? ''} ${data.userId?.lastName ?? ''}'),
                GiftAndWalletRowWidget(controller: balanceControllers[index], giftLabel: "Balance: "),
                GiftAndWalletRowWidget(controller: walletControllers[index], giftLabel: "Wallet: "),
                GiftAndWalletRowWidget(controller: providerStorageControllers[index], giftLabel: "Provider Storage: "),
                GiftAndWalletRowWidget(controller: refendStorageControllers[index], giftLabel: "Refend Storage: "),
                GiftAndWalletRowWidget(controller: refStorageControllers[index], giftLabel: "Ref Storage: "),
                GiftAndWalletRowWidget(controller: clicksControllers[index], giftLabel: "Free Clicks Storage: "),
                GiftAndWalletRowWidget(controller: numberOfReferralsControllers[index], giftLabel: "Number of Referrals: "),
                GiftAndWalletRowWidget(controller: uniqueReferralsControllers[index], giftLabel: "Unique Referrals: "),
                SizedBox(
                  height: 16,
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Data was updated successfully'),
                          duration: Duration(seconds: 2), // Display duration
                          backgroundColor: Colors.green, // Optional: Customize the background color
                        ),
                      );
                      // final updatedUserWalletData = UserWalletDataModel(
                      //   status: widget.userDataModel.status,
                      //   data: [
                      //     data.copyWith(
                      //       balance: double.parse(balanceControllers[index].text),
                      //       realAmount: double.parse(walletControllers[index].text),
                      //       providerCashBack: double.parse(providerStorageControllers[index].text),
                      //       refundStorage: int.parse(refendStorageControllers[index].text),
                      //       referralCount: int.parse(numberOfReferralsControllers[index].text),
                      //
                      //       freeClickStorage: int.parse(clicksControllers[index].text),
                      //       uniqueReferralCount:int.parse(uniqueReferralsControllers[index].text),
                      //
                      //       // Add other updated fields here...
                      //     ),
                      //   ],
                      // );
                      //
                      // context.read<UsersWalletCubit>().updateUserAndWallet(
                      //   data.id, // Assuming `id` is the userId
                      //   updatedUserWalletData,
                      // );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, // Button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white), // Text color
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          Text(
            value.toString(),
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget SentNotify() {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Send notify',
            hintStyle: TextStyle(color: Colors.grey),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: BorderSide(color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: BorderSide(color: Colors.grey),
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  // Define your button's action here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
                child: Text(
                  'Send',
                  style: TextStyle(color: Colors.white), // Text color
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
