import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fourtynine_dashboard/app/modules/users_profile/presentation/views/widgets/Label_Val_widget.dart';
import 'package:fourtynine_dashboard/main.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/toast_helper.dart';
import '../../../../core/widget/custom_text_field_with_background.dart';
import '../../../../routes/app_pages.dart';
import '../manager/users_profile_cubit.dart';
import '../manager/users_profiles_state.dart';

class UserProfilesView extends StatelessWidget {
  UserProfilesView({super.key});

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AllUsersCubit, UsersProfilesState>(
      listener: (context, state) async {
        var cubit = AllUsersCubit.get(context);
        if (state is DeleteUserProfileSuccessState) {
          ToastUtils.showToast(
            message: "User Deleted Successfully",
            gravity: ToastGravity.TOP,
            backgroundColor: mainColor,
            fontSize: 18.0,
          );
          Future.delayed(
            const Duration(milliseconds: 500),
            () {
              Get.back();
              Get.back();
              Get.toNamed(Routes.ALLUSERSPROFILES);
            },
          );
        }
      },
      builder: (context, state) {
        var cubit = AllUsersCubit.get(context);
        print(cubit.selectedUserDataProfileModel!.lockedDate.toString() +
            "   Dateeeeee");
        return WillPopScope(
          onWillPop: () async {
            Get.back();
            Get.back();
            Get.toNamed(Routes.ALLUSERSPROFILES);
            return false;
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                  cubit.selectedUserDataProfileModel!.firstName.toString() +
                      " " +
                      cubit.selectedUserDataProfileModel!.lastName.toString()),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: SafeArea(
                child: ListView(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: cubit.selectedUserDataProfileModel!
                                  .userProfile!.profilePictureKey!.mediaKey ??
                              "",
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          // Optional: Placeholder while loading
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                          // Optional: Error widget
                          fit: BoxFit.cover,
                          // Ensures the image fits correctly
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    UserInfoDisplay(
                      label: 'Email:',
                      value: cubit.selectedUserDataProfileModel!.email ?? "",
                      // value: user.email,
                    ),
                    UserInfoDisplay(
                      label: 'Name:',
                      value: cubit.selectedUserDataProfileModel!.firstName
                              .toString() +
                          " " +
                          cubit.selectedUserDataProfileModel!.lastName
                              .toString(),
                      // value: user.username,
                    ),
                    UserInfoDisplay(
                      label: 'Username:',
                      value: cubit.selectedUserDataProfileModel!.username ?? "",
                      // value: user.username,
                    ),
                    if (cubit.selectedUserDataProfileModel!.phone != null)
                      UserInfoDisplay(
                        label: 'Phone Number:',
                        value: cubit.selectedUserDataProfileModel!.phone ?? "",
                        // value: user.phoneNumber,
                      ),
                    // UserInfoDisplay(
                    //   label: 'Date of Sign-in:',
                    //   value: cubit.selectedUserDataProfileModel!.userProfile.,
                    //   // value: user.signInDate,
                    // ),
                    UserInfoDisplay(
                      label: 'Banned:',
                      value:
                          cubit.selectedUserDataProfileModel!.isLocked ?? false
                              ? "Yes"
                              : "No",
                      // value: user.isBlocked ? 'Yes' : 'No',
                    ),
                    if ((cubit.selectedUserDataProfileModel!.isLocked ??
                            false) &&
                        cubit.selectedUserDataProfileModel!.lockedDate != null)
                      UserInfoDisplay(
                        label: 'Banned Till:',

                        value: DateFormat('yyyy-MM-dd – kk:mm')
                            .format(DateTime.parse(cubit
                                    .selectedUserDataProfileModel!.lockedDate
                                    .toString())
                                .toLocal())
                            .toString(),
                        // value: user.BanDays.toString(),
                      ),
                    UserInfoDisplay(
                      label: 'Deleted:',
                      value:
                          cubit.selectedUserDataProfileModel!.isDeleted ?? false
                              ? "Yes"
                              : "No",
                      // value: user.isBlocked ? 'Yes' : 'No',
                    ),
                    const SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: () {
                        // Block/Unblock user logic
                      },
                      child: Text('Block'),
                      // child: Text(user.isBlocked ? 'Unblock User' : 'Block User'),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (cubit.selectedUserDataProfileModel!.isLocked ??
                            false) {
                          await cubit.unLockUserProfile(
                              userId: cubit.selectedUserDataProfileModel!.id);
                          await cubit.getUserProfile(
                              userId: cubit.selectedUserDataProfileModel!.id);
                        } else {
                          var daysController = TextEditingController();
                          showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20)),
                            ),
                            builder: (BuildContext context) {
                              return BlocBuilder<AllUsersCubit,
                                  UsersProfilesState>(
                                builder: (context, state) {
                                  var cubit = AllUsersCubit.get(context);
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        CustomTextFieldWithBackground(
                                          label: "Days",
                                          controller: daysController,
                                          textInputType: TextInputType.number,
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            await cubit.lockUserProfile(
                                                userId: cubit
                                                        .selectedUserDataProfileModel!
                                                        .id ??
                                                    "",
                                                days: int.parse(
                                                    daysController.text));
                                            await cubit.getUserProfile(
                                                userId: cubit
                                                    .selectedUserDataProfileModel!
                                                    .id);
                                            Get.back();
                                          },
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.red)),
                                          child: state
                                                  is LockUserProfileLoadingState
                                              ? const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Colors.white,
                                                  ),
                                                )
                                              : const Text(
                                                  'Ban',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        }
                      },
                      child: state is UnLockUserProfileLoadingState
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: mainColor,
                              ),
                            )
                          : Text(cubit.selectedUserDataProfileModel!.isLocked ??
                                  false
                              ? 'UnBan'
                              : "Ban"),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    if (!(cubit.selectedUserDataProfileModel!.isDeleted ??
                        false))
                      ElevatedButton(
                        onPressed: () async {
                          await cubit.deleteUserProfile(
                              userId:
                                  cubit.selectedUserDataProfileModel!.id ?? "");
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red)),
                        child: state is DeleteUserProfileLoadingState
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                'Delete',
                                style: TextStyle(color: Colors.white),
                              ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
