import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../view_model/cubit/get_users_model_state.dart';
import '../../view_model/cubit/get_users_wallet_cubit.dart';
import '../widgets/user_card.dart';


class AdminUserWalletScreen extends StatefulWidget {
  const AdminUserWalletScreen({super.key});

  @override
  State<AdminUserWalletScreen> createState() => _AdminUserWalletScreenState();
}

class _AdminUserWalletScreenState extends State<AdminUserWalletScreen> {
  bool _isSentNotifyVisible = false;

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context)=>UsersWalletCubit()..getUserWallet(),
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text('Users Wallet'),
            backgroundColor: Color(0xff0b1035),
            actions: [IconButton(onPressed: (){
              setState(() {
                _isSentNotifyVisible = !_isSentNotifyVisible;
      
              });
      
            }, icon:Icon( Icons.notifications_active_outlined,color: Colors.white,)),
            ],
          ),
        body: SingleChildScrollView(
          child: Column(
            children: [
          
              if (_isSentNotifyVisible) Padding(
                padding: const EdgeInsets.all(16),
                child: SentNotify(),
              ),
              SizedBox(height: 16,),
              SizedBox(
                height: 700,
                child: BlocBuilder<UsersWalletCubit, GetUsersWalletState>(
                  builder: (context, state){
                    if (state is GetUsersWalletLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is GetUsersWalletSuccess) {
                      // Display the user wallet data
                      final userWallet = state.userWalletModel;
                      return ListView.builder(
                        itemCount: userWallet.data.length,
                        itemBuilder: (context, index) {
                          return DataCard(
                            userDataModel: userWallet,
                          );

                        },
                      );
                    } else if (state is GetUsersWalletError) {
                      return Center(child: Text('Error:${state.error}'));
                    } else {
                      return Center(child: Text('No data available'));
                    }
                  },

                ),
              ),
            ],
          ),
        ),
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
