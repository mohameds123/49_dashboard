
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:textless/textless.dart';

import '../../../../core/widget/custom_text_field_with_background.dart';
import '../controllers/app_manager_controller.dart';

class AppManagerView extends GetView<AppManagerController> {
  const AppManagerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Manager'),
        centerTitle: true,
      ),
      body: Obx(
        () {
          if (controller.appManagerModel.value == null)
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          else {
            final appManager = controller.appManagerModel.value!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextFieldWithBackground(
                        label: 'Request Storage',
                        initValue: appManager.requestStorage.toString(),
                        onChange: (v) => appManager.requestStorage =
                            double.tryParse(v) ?? appManager.requestStorage,
                        textInputType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextFieldWithBackground(
                        label: 'Call Storage',
                        initValue: appManager.callStorage.toString(),
                        onChange: (v) => appManager.callStorage =
                            double.tryParse(v) ?? appManager.callStorage,
                        textInputType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextFieldWithBackground(
                        label: 'Any Storage',
                        initValue: appManager.anyStorage.toString(),
                        onChange: (v) => appManager.anyStorage =
                            double.tryParse(v) ?? appManager.anyStorage,
                        textInputType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextFieldWithBackground(
                        label: 'Like Storage',
                        initValue: appManager.likeStorage.toString(),
                        onChange: (v) => appManager.likeStorage =
                            double.tryParse(v) ?? appManager.likeStorage,
                        textInputType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextFieldWithBackground(
                        label: 'View Storage',
                        initValue: appManager.viewStorage.toString(),
                        onChange: (v) => appManager.viewStorage =
                            double.tryParse(v) ?? appManager.viewStorage,
                        textInputType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextFieldWithBackground(
                        label: 'Share Storage',
                        initValue: appManager.shareStorage.toString(),
                        onChange: (v) => appManager.shareStorage =
                            double.tryParse(v) ?? appManager.shareStorage,
                        textInputType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextFieldWithBackground(
                        label: 'Request Portion',
                        initValue: appManager.requestPortion.toString(),
                        onChange: (v) => appManager.requestPortion =
                            double.tryParse(v) ?? appManager.requestPortion,
                        textInputType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextFieldWithBackground(
                        label: 'Call Portion',
                        initValue: appManager.callPortion.toString(),
                        onChange: (v) => appManager.callPortion =
                            double.tryParse(v) ?? appManager.callPortion,
                        textInputType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextFieldWithBackground(
                        label: 'Any Portion',
                        initValue: appManager.anyPortion.toString(),
                        onChange: (v) => appManager.anyPortion =
                            double.tryParse(v) ?? appManager.anyPortion,
                        textInputType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextFieldWithBackground(
                        label: 'Like Portion',
                        initValue: appManager.likePortion.toString(),
                        onChange: (v) => appManager.likePortion =
                            double.tryParse(v) ?? appManager.likePortion,
                        textInputType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextFieldWithBackground(
                        label: 'View Portion',
                        initValue: appManager.viewPortion.toString(),
                        onChange: (v) => appManager.viewPortion =
                            double.tryParse(v) ?? appManager.viewPortion,
                        textInputType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextFieldWithBackground(
                        label: 'Share Portion',
                        initValue: appManager.sharePortion.toString(),
                        onChange: (v) => appManager.sharePortion =
                            double.tryParse(v) ?? appManager.sharePortion,
                        textInputType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextFieldWithBackground(
                        label: 'Referral Gift',
                        initValue: appManager.referralGift.toString(),
                        onChange: (v) => appManager.referralGift =
                            double.tryParse(v) ?? appManager.referralGift,
                        textInputType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextFieldWithBackground(
                        label: 'Free Click Gift',
                        initValue: appManager.freeClickGift.toString(),
                        onChange: (v) => appManager.freeClickGift =
                            double.tryParse(v) ?? appManager.freeClickGift,
                        textInputType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextFieldWithBackground(
                        label: 'Step Value',
                        initValue: appManager.stepValue.toString(),
                        onChange: (v) => appManager.stepValue =
                            double.tryParse(v) ?? appManager.stepValue,
                        textInputType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextFieldWithBackground(
                        label: 'Max Day Gift',
                        initValue: appManager.maxDayGift.toString(),
                        onChange: (v) => appManager.maxDayGift =
                            double.tryParse(v) ?? appManager.maxDayGift,
                        textInputType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextFieldWithBackground(
                        label: 'Tax',
                        initValue: appManager.tax.toString(),
                        onChange: (v) => appManager.tax =
                            double.tryParse(v) ?? appManager.tax,
                        textInputType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextFieldWithBackground(
                        label: 'Vat',
                        initValue: appManager.vat.toString(),
                        onChange: (v) => appManager.vat =
                            double.tryParse(v) ?? appManager.vat,
                        textInputType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextFieldWithBackground(
                        label: 'Gross Money',
                        initValue: appManager.grossMoney.toString(),
                        onChange: (v) => appManager.grossMoney =
                            double.tryParse(v) ?? appManager.grossMoney,
                        textInputType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextFieldWithBackground(
                        label: 'Total OverHead',
                        initValue: appManager.totalOverHead.toString(),
                        onChange: (v) => appManager.totalOverHead =
                            double.tryParse(v) ?? appManager.totalOverHead,
                        textInputType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextFieldWithBackground(
                        label: 'OverHead Constant',
                        initValue: appManager.overHeadConstant.toString(),
                        onChange: (v) => appManager.overHeadConstant =
                            double.tryParse(v) ?? appManager.overHeadConstant,
                        textInputType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextFieldWithBackground(
                        label: 'PayMob Cuts',
                        initValue: appManager.payMobCuts.toString(),
                        onChange: (v) => appManager.payMobCuts =
                            double.tryParse(v) ?? appManager.payMobCuts,
                        textInputType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextFieldWithBackground(
                        label: 'PayMob Constant',
                        initValue: appManager.payMobConstant.toString(),
                        onChange: (v) => appManager.payMobConstant =
                            double.tryParse(v) ?? appManager.payMobConstant,
                        textInputType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextFieldWithBackground(
                        label: 'PayMob Portion',
                        initValue: appManager.payMobPortion.toString(),
                        onChange: (v) => appManager.payMobPortion =
                            double.tryParse(v) ?? appManager.payMobPortion,
                        textInputType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextFieldWithBackground(
                        label: 'Total Amounts',
                        initValue: appManager.totalAmounts.toString(),
                        onChange: (v) => appManager.totalAmounts =
                            double.tryParse(v) ?? appManager.totalAmounts,
                        textInputType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextFieldWithBackground(
                        label: 'Running Cost',
                        initValue: appManager.runningCost.toString(),
                        onChange: (v) => appManager.runningCost =
                            double.tryParse(v) ?? appManager.runningCost,
                        textInputType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextFieldWithBackground(
                        label: 'Interest',
                        initValue: appManager.interest.toString(),
                        onChange: (v) => appManager.interest =
                            double.tryParse(v) ?? appManager.interest,
                        textInputType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextFieldWithBackground(
                        label: 'Total Government Fees',
                        initValue: appManager.totalGovernmentFees.toString(),
                        onChange: (v) => appManager.totalGovernmentFees =
                            double.tryParse(v) ??
                                appManager.totalGovernmentFees,
                        textInputType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextFieldWithBackground(
                        label: 'Welcome Gift',
                        initValue: appManager.welcomeGift.toString(),
                        onChange: (v) => appManager.welcomeGift =
                            double.tryParse(v) ?? appManager.welcomeGift,
                        textInputType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextFieldWithBackground(
                        label: 'Forty Nine Storage',
                        initValue: appManager.fortyNineStorage.toString(),
                        onChange: (v) => appManager.fortyNineStorage =
                            double.tryParse(v) ?? appManager.fortyNineStorage,
                        textInputType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextFieldWithBackground(
                        label: 'Drug Analysis Phone',
                        initValue:
                            appManager.rideDrugAnalysisCenterPhone.toString(),
                        onChange: (v) =>
                            appManager.rideDrugAnalysisCenterPhone = v,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextFieldWithBackground(
                        label: 'Drug Analysis Location',
                        initValue: appManager.rideDrugAnalysisCenterLocation
                            .toString(),
                        onChange: (v) =>
                            appManager.rideDrugAnalysisCenterLocation = v,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextFieldWithBackground(
                        label: 'Tech Ex. Phone',
                        initValue: appManager
                            .rideTechnicalExaminationCenterPhone
                            .toString(),
                        onChange: (v) =>
                            appManager.rideTechnicalExaminationCenterPhone = v,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextFieldWithBackground(
                        label: 'Tech Ex. Location',
                        initValue: appManager
                            .rideTechnicalExaminationCenterLocation
                            .toString(),
                        onChange: (v) => appManager
                            .rideTechnicalExaminationCenterLocation = v,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextFieldWithBackground(
                        label: 'Gift Portion',
                        initValue: appManager.giftPortion.toString(),
                        onChange: (v) => appManager.giftPortion =
                            double.tryParse(v) ?? appManager.giftPortion,
                        textInputType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextFieldWithBackground(
                        label: 'Gift Provider Portion',
                        initValue: appManager.giftProviderPortion.toString(),
                        onChange: (v) => appManager.giftProviderPortion =
                            double.tryParse(v) ??
                                appManager.giftProviderPortion,
                        textInputType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextFieldWithBackground(
                        label: 'Gift Payment Factor',
                        initValue: appManager.giftPaymentFactor.toString(),
                        onChange: (v) => appManager.giftPaymentFactor =
                            double.tryParse(v) ?? appManager.giftPaymentFactor,
                        textInputType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextFieldWithBackground(
                        label: 'Ride Area Distance',
                        initValue: appManager.rideAreaDistance.toString(),
                        onChange: (v) => appManager.rideAreaDistance =
                            double.tryParse(v) ?? appManager.rideAreaDistance,
                        textInputType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextFieldWithBackground(
                        label: 'Ride Request Duration',
                        initValue: appManager.rideRequestDuration.toString(),
                        onChange: (v) => appManager.rideRequestDuration =
                            double.tryParse(v) ?? appManager.rideRequestDuration,
                        textInputType: TextInputType.number,
                      ),
                    ),
                    ValueBuilder<bool?>(
                      initialValue: appManager.rideCriminalRecord,
                      onUpdate: (v) => appManager.rideCriminalRecord = v!,
                      builder: (value, update) => SwitchListTile(
                        title: 'Ride Criminal Record'.text,
                        value: value!,
                        onChanged: update,
                      ),
                    ),
                    ValueBuilder<bool?>(
                      initialValue: appManager.rideDugAnalysis,
                      onUpdate: (v) => appManager.rideDugAnalysis = v!,
                      builder: (value, update) => SwitchListTile(
                        title: 'Ride Dug Analysis'.text,
                        value: value!,
                        onChanged: update,
                      ),
                    ),
                    ValueBuilder<bool?>(
                      initialValue: appManager.rideTechnicalExamination,
                      onUpdate: (v) => appManager.rideTechnicalExamination = v!,
                      builder: (value, update) => SwitchListTile(
                        title: 'Ride Technical Examination'.text,
                        value: value!,
                        onChanged: update,
                      ),
                    ),
                    const SizedBox(height: 10),
                    MaterialButton(
                      child: 'Save'.text,
                      color: Get.theme.primaryColor,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minWidth: double.infinity,
                      onPressed: controller.saveData,
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
