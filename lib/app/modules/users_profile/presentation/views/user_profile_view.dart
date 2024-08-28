import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fourtynine_dashboard/app/modules/users_profile/data/repos/all_users_repos.dart';
import 'package:fourtynine_dashboard/app/modules/users_profile/presentation/views/widgets/Label_Val_widget.dart';

import '../../../../core/utils/service_locator.dart';
import '../manager/users_profile_cubit.dart';

class UserProfilesView extends StatelessWidget {
  UserProfilesView({super.key});

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: AllUsersCubit(getIt.get<AllUsersRepos>()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('User Name'),
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
                      imageUrl:
                          "https://static.vecteezy.com/system/resources/previews/000/439/863/original/vector-users-icon.jpg" ??
                              "",
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      // Optional: Placeholder while loading
                      errorWidget: (context, url, error) => Icon(Icons.error),
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
                  value: "mrezk319@gmail.com",
                  // value: user.email,
                ),
                UserInfoDisplay(
                  label: 'Username:',
                  value: "Muhammed Rezk",
                  // value: user.username,
                ),
                UserInfoDisplay(
                  label: 'Phone Number:',
                  value: "+201280609696",
                  // value: user.phoneNumber,
                ),
                UserInfoDisplay(
                  label: 'Date of Sign-in:',
                  value: "20/2/2020",
                  // value: user.signInDate,
                ),
                UserInfoDisplay(
                  label: 'Blocked:',
                  value: 'Yes',
                  // value: user.isBlocked ? 'Yes' : 'No',
                ),
                UserInfoDisplay(
                  label: 'Pan Days:',
                  value: "5",
                  // value: user.panDays.toString(),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Block/Unblock user logic
                  },
                  child: Text('Block User'),
                  // child: Text(user.isBlocked ? 'Unblock User' : 'Block User'),
                ),
                SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                  onPressed: () {
                    // Pan user logic
                  },
                  child: Text('Pan User'),
                ),
                SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                  onPressed: () {
                    // Delete user logic
                  },
                  child: Text(
                    'Delete User',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
