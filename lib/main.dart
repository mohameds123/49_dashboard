import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'app/core/constants.dart';
import 'app/core/custom_dio/dio_manager.dart';
import 'app/modules/admin/change_user_name_password/controllers/change_user_name_and_pass_controller.dart';
import 'app/modules/admin/user_gift/data/repo/repo.dart';
import 'app/modules/admin/user_gift/view_model/cubit/cubit.dart';
import 'app/routes/app_pages.dart';
import 'firebase_options.dart';

const Color mainColor = Color(0xff0b1035);

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final token =
      await AppConstants.storage.read(key: AppConstants.tokenStorageKey);
  final isSuperAdmin =
      await AppConstants.storage.read(key: AppConstants.isSuperAdminStorageKey);
  DioManager.setUpDioOptions(token: token);

  runApp(
    MultiBlocProvider(
        providers: [
        BlocProvider(
        create: (context) => GetUsersGiftsCubit(adminUserGift: AdminUserGift()),
  ),
      ],
      child: GetMaterialApp(
        title: "49 Dashboard",
        debugShowCheckedModeBanner: false,
        initialRoute: token != null && isSuperAdmin != null
            ? Routes.SUPER_HOME
            : token != null
                ? Routes.HOME
                : Routes.LOGIN,
        getPages: AppPages.routes,
        //defaultTransition: Transition.cupertino,
        theme: ThemeData(
          primaryColor: Color(0xff0b1035),
          iconTheme: IconThemeData(color: Colors.white),
          actionIconTheme: ActionIconThemeData(
            drawerButtonIconBuilder: (BuildContext context) {
              return Icon(
                Icons.menu,
                color: Colors.white,
              );
            },
            backButtonIconBuilder: (BuildContext context) {
              return Icon(
                Icons.arrow_back,
                color: Colors.white,
              );
            },
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Color(0xff0b1035),
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
  );
}
