import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:textless/textless.dart';

import '../../../../core/widget/custom_text_field_with_background.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/user_details_controller.dart';

class UserDetailsView extends GetView<UserDetailsController> {
  const UserDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${controller.profile.fullName} Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 10),
              _buildSingleDetail('Name', controller.profile.fullName),
              _buildSingleDetail(
                'Email',
                controller.profile.email,
              ),
              _buildSingleDetail('Phone', controller.profile.phone ?? ''),
              _buildSingleDetail(
                'Provider',
                controller.profile.provider.toString(),
              ),
              _buildSingleDetail(
                  'Gender',
                  controller.profile.isMale == true
                      ? 'Male'
                      : controller.profile.isMale == false
                          ? 'Female'
                          : ''),
              _buildSingleDetail(
                'Country',
                controller.profile.country,
                onChange: (v) => controller.profile.country = v,
              ),
              _buildSingleDetail(
                'Balance',
                controller.profile.wallet.balance.toString(),
                onChange: (v) => controller.profile.wallet.balance =
                    double.tryParse(v) ?? controller.profile.wallet.balance,
              ),
              _buildSingleDetail(
                'Start Balance',
                controller.profile.wallet.startBalance.toString(),
                onChange: (v) => controller.profile.wallet.startBalance =
                    double.tryParse(v) ??
                        controller.profile.wallet.startBalance,
              ),
              _buildSingleDetail('Balance After Five',
                  controller.profile.wallet.fiveYears.toString()),
              _buildSingleDetail(
                'Gross Money',
                controller.profile.wallet.grossMoney.toString(),
                onChange: (v) => controller.profile.wallet.grossMoney =
                    double.tryParse(v) ?? controller.profile.wallet.grossMoney,
              ),
              _buildSingleDetail(
                'Profit',
                controller.profile.wallet.profit.toString(),
                onChange: (v) => controller.profile.wallet.profit =
                    double.tryParse(v) ?? controller.profile.wallet.profit,
              ),
              _buildSingleDetail(
                'Ten Years',
                controller.profile.wallet.tenYears.toString(),
                onChange: (v) => controller.profile.wallet.tenYears =
                    double.tryParse(v) ?? controller.profile.wallet.tenYears,
              ),
              _buildSingleDetail(
                'Five Years',
                controller.profile.wallet.fiveYears.toString(),
                onChange: (v) => controller.profile.wallet.fiveYears =
                    double.tryParse(v) ?? controller.profile.wallet.fiveYears,
              ),
              _buildSingleDetail(
                'Provider Cash Back',
                controller.profile.wallet.providerCasBack.toString(),
                onChange: (v) => controller.profile.wallet.providerCasBack =
                    double.tryParse(v) ??
                        controller.profile.wallet.providerCasBack,
              ),
              _buildSingleDetail(
                'Refund Storage',
                controller.profile.wallet.refundStorage.toString(),
                onChange: (v) => controller.profile.wallet.refundStorage =
                    double.tryParse(v) ??
                        controller.profile.wallet.refundStorage,
              ),
              _buildSingleDetail(
                'Free Click Storage',
                controller.profile.wallet.freeClickStorage.toString(),
                onChange: (v) => controller.profile.wallet.freeClickStorage =
                    double.tryParse(v) ??
                        controller.profile.wallet.freeClickStorage,
              ),
              _buildSingleDetail(
                'Referral Storage',
                controller.profile.wallet.referralStorage.toString(),
                onChange: (v) => controller.profile.wallet.referralStorage =
                    double.tryParse(v) ??
                        controller.profile.wallet.referralStorage,
              ),
              _buildSingleDetail(
                'Referral Cash Back',
                controller.profile.wallet.referralCashBack.toString(),
                onChange: (v) => controller.profile.wallet.referralCashBack =
                    double.tryParse(v) ??
                        controller.profile.wallet.referralCashBack,
              ),
              _buildSingleDetail(
                'Total Payment',
                controller.profile.wallet.totalPayment.toString(),
                onChange: (v) => controller.profile.wallet.totalPayment =
                    double.tryParse(v) ??
                        controller.profile.wallet.totalPayment,
              ),
              _buildSingleDetail(
                'Total Cash Back',
                controller.profile.wallet.totalCashBack.toString(),
                onChange: (v) => controller.profile.wallet.totalCashBack =
                    double.tryParse(v) ??
                        controller.profile.wallet.totalCashBack,
              ),
              _buildSingleDetail(
                'Today Gift',
                controller.profile.wallet.todayGift.toString(),
                onChange: (v) => controller.profile.wallet.todayGift =
                    int.tryParse(v) ?? controller.profile.wallet.todayGift,
              ),
              _buildSingleDetail(
                'Last Gift',
                controller.profile.wallet.lastGift.toString(),
                onChange: (v) => controller.profile.wallet.lastGift = v,
              ),
              _buildSingleDetail(
                'Total Likes',
                controller.profile.wallet.totalLikes.toString(),
                onChange: (v) => controller.profile.wallet.totalLikes =
                    int.tryParse(v) ?? controller.profile.wallet.totalLikes,
              ),
              _buildSingleDetail(
                'Total Views',
                controller.profile.wallet.totalViews.toString(),
                onChange: (v) => controller.profile.wallet.totalViews =
                    int.tryParse(v) ?? controller.profile.wallet.totalViews,
              ),
              _buildSingleDetail(
                'Total Shares',
                controller.profile.wallet.totalShares.toString(),
                onChange: (v) => controller.profile.wallet.totalShares =
                    int.tryParse(v) ?? controller.profile.wallet.totalShares,
              ),
              _buildSingleDetail(
                'Months',
                controller.profile.wallet.months.toString(),
                onChange: (v) => controller.profile.wallet.months =
                    int.tryParse(v) ?? controller.profile.wallet.months,
              ),
              _buildSingleDetail(
                'Monthly Balance',
                controller.profile.wallet.monthlyBalance.toString(),
                onChange: (v) => controller.profile.wallet.monthlyBalance =
                    double.tryParse(v) ??
                        controller.profile.wallet.monthlyBalance,
              ),
              InkWell(
                onTap: () => Get.toNamed(Routes.USER_REFERRALS,
                    arguments: controller.profile),
                child: _buildSingleDetail(
                  'Referral Count',
                  controller.profile.referralCount.toString(),
                ),
              ),
              MaterialButton(
                child: 'Save'.text,
                textColor: Colors.white,
                minWidth: double.infinity,
                color: Get.theme.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onPressed: controller.showSaveDialog,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSingleDetail(String label, String value,
      {ValueChanged<String>? onChange}) {
    return Column(
      children: [
        CustomTextFieldWithBackground(
          label: label,
          enable: onChange != null,
          initValue: value,
          onChange: onChange,
        ),
        Divider(),
      ],
    );
  }
}
