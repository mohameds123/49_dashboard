import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fourtynine_dashboard/app/modules/users_profile/data/models/all_users_profile_model.dart';
import 'package:fourtynine_dashboard/app/modules/users_profile/data/repos/all_users_repos.dart';
import 'package:fourtynine_dashboard/app/modules/users_profile/presentation/views/widgets/all_users_item_widget.dart';
import 'package:fourtynine_dashboard/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../../../../core/utils/service_locator.dart';
import '../../../../core/widget/custom_text_field_with_background.dart';
import '../manager/users_profile_cubit.dart';
import '../manager/users_profiles_state.dart';

class AllUsersProfilesView extends StatefulWidget {
  AllUsersProfilesView({super.key});

  @override
  State<AllUsersProfilesView> createState() => _AllUsersProfilesViewState();
}

class _AllUsersProfilesViewState extends State<AllUsersProfilesView> {
  var searchController = TextEditingController();

  final ScrollController _scrollController = ScrollController();
  int page = 1;

  @override
  void initState() {
    super.initState();

    // Delay the API call to ensure the widget tree is ready
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final cubit = context.read<AllUsersCubit>();
      await cubit.getAllUsersProfiles(page: page);
      allUsers.addAll(cubit.allUsersProfileModel!.data ?? []);
      print(page.toString() + " gg");
      print(allUsers.length.toString() + " gg");
      setState(() {});
    });

    // Attach the scroll listener to the controller
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      setState(() {
        page++;


      });
      await context.read<AllUsersCubit>().getAllUsersProfiles(page: page);

      allUsers.addAll(context.read<AllUsersCubit>().allUsersProfileModel == null
          ? []
          : context.read<AllUsersCubit>().allUsersProfileModel!.data ?? []);
      setState(() {});
    }
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Dispose the controller when no longer needed
    super.dispose();
  }

  List<UserDataProfileModel> allUsers = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: AllUsersCubit(getIt.get<AllUsersRepos>())
        ..getAllUsersProfiles(page: page),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('All Users'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: CustomTextFieldWithBackground(
                    label: "Search",
                    controller: searchController,
                  ),
                ),
                BlocBuilder<AllUsersCubit, UsersProfilesState>(
                  builder: (context, state) {
                    var cubit = AllUsersCubit.get(context);
                    return Expanded(
                      child: allUsers.isEmpty
                          ? const Center(
                              child: Text(
                                "No Users Here!",
                              ),
                            )
                          : ListView.separated(
                              controller: _scrollController,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, i) => InkWell(
                                  onTap: () {
                                    Get.toNamed(Routes.USERPROFILE);
                                  },
                                  child: AllUsersItemWidget(
                                    userDataProfileModel: allUsers[i],
                                  )),
                              separatorBuilder: (context, i) => SizedBox(
                                    height: 15,
                                  ),
                              itemCount: allUsers.length),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
