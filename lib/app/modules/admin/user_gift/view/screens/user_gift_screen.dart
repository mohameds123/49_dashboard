import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repo/repo.dart';
import '../../view_model/cubit/cubit.dart';
import '../../view_model/cubit/state.dart';
import '../widgets/gift_card.dart';

class UserGiftScreen extends StatefulWidget {
  const UserGiftScreen({super.key});

  @override
  State<UserGiftScreen> createState() => _UserGiftScreenState();
}

class _UserGiftScreenState extends State<UserGiftScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch the data when the screen is initialized
    context.read<GetUsersGiftsCubit>().fetchUserGifts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Gift"),
        backgroundColor: Color(0xff0b1035),
      ),
      body: BlocBuilder<GetUsersGiftsCubit, GetUsersGiftsState>(
        builder: (context, state) {
          if (state is GetUsersGiftsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is GetUsersGiftsSuccess) {
            final userGiftDataList = state.userGitDataList;
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Text(
                        "Sort",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                title: Center(
                                  child: Text(
                                    'Sort Options',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // First Button: A to Z
                                    ElevatedButton(
                                      onPressed: () {
                                        context.read<GetUsersGiftsCubit>().sortGiftsAscending();
                                        Navigator.pop(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                          side: BorderSide(color: Colors.black),
                                        ),
                                      ),
                                      child: Text(
                                        'From A to Z',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    // Second Button: Z to A
                                    ElevatedButton(
                                      onPressed: () {
                                        context.read<GetUsersGiftsCubit>().sortGiftsDescending();
                                        Navigator.pop(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                      ),
                                      child: Text(
                                        'From Z to A',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.sort, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: userGiftDataList.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      final giftData = userGiftDataList.data![index];
                      return GiftCard(giftData: giftData);
                    },
                  ),
                ),
              ],
            );
          } else if (state is GetUsersGiftsError) {
            return Center(child: Text("Error: ${state.error}"));
          } else {
            return Center(child: Text("No data"));
          }
        },
      ),
    );
  }
}
