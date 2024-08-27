import 'package:get/get.dart';

import '../modules/admin/admin_main_category/bindings/admin_main_category_binding.dart';
import '../modules/admin/admin_main_category/views/admin_main_category_view.dart';
import '../modules/admin/admin_sub_category/bindings/admin_sub_category_binding.dart';
import '../modules/admin/admin_sub_category/views/admin_sub_category_view.dart';
import '../modules/admin/admin_users/bindings/admin_users_binding.dart';
import '../modules/admin/admin_users/views/admin_users_view.dart';
import '../modules/admin/change_user_name_password/bindings/ChangeUserNameAndPassBinding.dart';
import '../modules/admin/change_user_name_password/views/change_user_name_and_pass_view.dart';
import '../modules/admin/come_with_me_trips/bindings/come_with_me_trips_binding.dart';
import '../modules/admin/come_with_me_trips/views/come_with_me_trips_view.dart';
import '../modules/admin/dynamic_props/bindings/dynamic_props_binding.dart';
import '../modules/admin/dynamic_props/views/dynamic_props_view.dart';
import '../modules/admin/home/bindings/home_binding.dart';
import '../modules/admin/home/views/home_view.dart';
import '../modules/admin/images_viewer/bindings/images_viewer_binding.dart';
import '../modules/admin/images_viewer/views/images_viewer_view.dart';
import '../modules/admin/pick_me_trips/bindings/pick_me_trips_binding.dart';
import '../modules/admin/pick_me_trips/views/pick_me_trips_view.dart';
import '../modules/admin/reports/attachments/doctor_details/bindings/doctor_details_binding.dart';
import '../modules/admin/reports/attachments/doctor_details/views/doctor_details_view.dart';
import '../modules/admin/reports/attachments/dynamic_ad_details/bindings/dynamic_ad_details_binding.dart';
import '../modules/admin/reports/attachments/dynamic_ad_details/views/dynamic_ad_details_view.dart';
import '../modules/admin/reports/attachments/message/bindings/message_binding.dart';
import '../modules/admin/reports/attachments/message/views/message_view.dart';
import '../modules/admin/reports/attachments/other_user_profile/bindings/other_user_profile_binding.dart';
import '../modules/admin/reports/attachments/other_user_profile/views/other_user_profile_view.dart';
import '../modules/admin/reports/attachments/request_food/bindings/request_food_binding.dart';
import '../modules/admin/reports/attachments/request_food/views/request_food_view.dart';
import '../modules/admin/reports/attachments/single_post/bindings/single_post_binding.dart';
import '../modules/admin/reports/attachments/single_post/views/single_post_view.dart';
import '../modules/admin/reports/bindings/reports_binding.dart';
import '../modules/admin/reports/views/reports_view.dart';
import '../modules/admin/review_ads/bindings/review_ads_binding.dart';
import '../modules/admin/review_ads/views/review_ads_view.dart';
import '../modules/admin/review_come_with_me_trips/bindings/review_come_with_me_trips_binding.dart';
import '../modules/admin/review_come_with_me_trips/views/review_come_with_me_trips_view.dart';
import '../modules/admin/review_food/bindings/review_food_binding.dart';
import '../modules/admin/review_food/views/review_food_view.dart';
import '../modules/admin/review_health/bindings/review_health_binding.dart';
import '../modules/admin/review_health/views/review_health_view.dart';
import '../modules/admin/review_loading/bindings/review_loading_binding.dart';
import '../modules/admin/review_loading/views/review_loading_view.dart';
import '../modules/admin/review_pick_me_trips/bindings/review_pick_me_trips_binding.dart';
import '../modules/admin/review_pick_me_trips/views/review_pick_me_trips_view.dart';
import '../modules/admin/review_restaurant/bindings/review_restaurant_binding.dart';
import '../modules/admin/review_restaurant/views/review_restaurant_view.dart';
import '../modules/admin/review_ride/bindings/review_ride_binding.dart';
import '../modules/admin/review_ride/views/review_ride_view.dart';
import '../modules/admin/single_ad_details/bindings/single_ad_details_binding.dart';
import '../modules/admin/single_ad_details/views/single_ad_details_view.dart';
import '../modules/complaints/bindings/complaints_binding.dart';
import '../modules/complaints/views/complaints_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/monthly_contest/bindings/monthly_contest_binding.dart';
import '../modules/monthly_contest/views/monthly_contest_view.dart';
import '../modules/super_home/add_sub_category/bindings/add_sub_category_binding.dart';
import '../modules/super_home/add_sub_category/views/add_sub_category_view.dart';
import '../modules/super_home/admins/bindings/admins_binding.dart';
import '../modules/super_home/admins/views/admins_view.dart';
import '../modules/super_home/app_manager/bindings/app_manager_binding.dart';
import '../modules/super_home/app_manager/views/app_manager_view.dart';
import '../modules/super_home/app_radio/bindings/app_radio_binding.dart';
import '../modules/super_home/app_radio/views/app_radio_view.dart';
import '../modules/super_home/doctors/bindings/doctors_binding.dart';
import '../modules/super_home/doctors/views/doctors_view.dart';
import '../modules/super_home/dynamic_ads/bindings/dynamic_ads_binding.dart';
import '../modules/super_home/dynamic_ads/views/dynamic_ads_view.dart';
import '../modules/super_home/gifts/bindings/gifts_binding.dart';
import '../modules/super_home/gifts/views/gifts_view.dart';
import '../modules/super_home/loadings/bindings/loadings_binding.dart';
import '../modules/super_home/loadings/views/loadings_view.dart';
import '../modules/super_home/main/bindings/super_home_binding.dart';
import '../modules/super_home/main/views/super_home_view.dart';
import '../modules/super_home/main_category/bindings/main_category_binding.dart';
import '../modules/super_home/main_category/views/main_category_view.dart';
import '../modules/super_home/post_activity/bindings/post_activity_binding.dart';
import '../modules/super_home/post_activity/views/post_activity_view.dart';
import '../modules/super_home/post_feeling/bindings/post_feeling_binding.dart';
import '../modules/super_home/post_feeling/views/post_feeling_view.dart';
import '../modules/super_home/restaurants/bindings/restaurants_binding.dart';
import '../modules/super_home/restaurants/views/restaurants_view.dart';
import '../modules/super_home/riders/bindings/riders_binding.dart';
import '../modules/super_home/riders/views/riders_view.dart';
import '../modules/super_home/running_cost/bindings/running_cost_binding.dart';
import '../modules/super_home/running_cost/views/running_cost_view.dart';
import '../modules/super_home/songs/bindings/songs_binding.dart';
import '../modules/super_home/songs/views/songs_view.dart';
import '../modules/super_home/sub_category/bindings/sub_category_binding.dart';
import '../modules/super_home/sub_category/views/sub_category_view.dart';
import '../modules/super_home/user_details/bindings/user_details_binding.dart';
import '../modules/super_home/user_details/views/user_details_view.dart';
import '../modules/super_home/user_referrals/bindings/user_referrals_binding.dart';
import '../modules/super_home/user_referrals/views/user_referrals_view.dart';
import '../modules/super_home/users/bindings/users_binding.dart';
import '../modules/super_home/users/views/users_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.CHANGEUSERNAMEANDPASS,
      page: () => const ChangeUserNameAndPassView(),
      binding: ChangeUserNameAndPassBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SUPER_HOME,
      page: () => const SuperHomeView(),
      binding: SuperHomeBinding(),
    ),
    GetPage(
      name: _Paths.USERS,
      page: () => UsersView(),
      binding: UsersBinding(),
    ),
    GetPage(
      name: _Paths.USER_DETAILS,
      page: () => UserDetailsView(),
      binding: UserDetailsBinding(),
    ),
    GetPage(
      name: _Paths.APP_MANAGER,
      page: () => AppManagerView(),
      binding: AppManagerBinding(),
    ),
    GetPage(
      name: _Paths.SUB_CATEGORY,
      page: () => SubCategoryView(),
      binding: SubCategoryBinding(),
    ),
    GetPage(
      name: _Paths.MAIN_CATEGORY,
      page: () => MainCategoryView(),
      binding: MainCategoryBinding(),
    ),
    GetPage(
      name: _Paths.ADD_SUB_CATEGORY,
      page: () => AddSubCategoryView(),
      binding: AddSubCategoryBinding(),
    ),
    GetPage(
      name: _Paths.RUNNING_COST,
      page: () => RunningCostView(),
      binding: RunningCostBinding(),
    ),
    GetPage(
      name: _Paths.ADMINS,
      page: () => AdminsView(),
      binding: AdminsBinding(),
    ),
    GetPage(
      name: _Paths.REVIEW_ADS,
      page: () => ReviewAdsView(),
      binding: ReviewAdsBinding(),
    ),
    GetPage(
      name: _Paths.SINGLE_AD_DETAILS,
      page: () => SingleAdDetailsView(),
      binding: SingleAdDetailsBinding(),
    ),
    GetPage(
      name: _Paths.REVIEW_RIDE,
      page: () => ReviewRideView(),
      binding: ReviewRideBinding(),
    ),
    GetPage(
      name: _Paths.IMAGES_VIEWER,
      page: () => ImagesViewerView(),
      binding: ImagesViewerBinding(),
    ),
    GetPage(
      name: _Paths.REVIEW_LOADING,
      page: () => ReviewLoadingView(),
      binding: ReviewLoadingBinding(),
    ),
    GetPage(
      name: _Paths.REVIEW_RESTAURANT,
      page: () => ReviewRestaurantView(),
      binding: ReviewRestaurantBinding(),
    ),
    GetPage(
      name: _Paths.REVIEW_HEALTH,
      page: () => ReviewHealthView(),
      binding: ReviewHealthBinding(),
    ),
    GetPage(
      name: _Paths.REVIEW_FOOD,
      page: () => ReviewFoodView(),
      binding: ReviewFoodBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_MAIN_CATEGORY,
      page: () => AdminMainCategoryView(),
      binding: AdminMainCategoryBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_SUB_CATEGORY,
      page: () => AdminSubCategoryView(),
      binding: AdminSubCategoryBinding(),
    ),
    GetPage(
      name: _Paths.DYNAMIC_PROPS,
      page: () => DynamicPropsView(),
      binding: DynamicPropsBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_USERS,
      page: () => AdminUsersView(),
      binding: AdminUsersBinding(),
    ),
    GetPage(
      name: _Paths.GIFTS,
      page: () => GiftsView(),
      binding: GiftsBinding(),
    ),
    GetPage(
      name: _Paths.POST_ACTIVITY,
      page: () => PostActivityView(),
      binding: PostActivityBinding(),
    ),
    GetPage(
      name: _Paths.POST_FEELING,
      page: () => PostFeelingView(),
      binding: PostFeelingBinding(),
    ),
    GetPage(
      name: _Paths.SONGS,
      page: () => const SongsView(),
      binding: SongsBinding(),
    ),
    GetPage(
      name: _Paths.APP_RADIO,
      page: () => const AppRadioView(),
      binding: AppRadioBinding(),
    ),
    GetPage(
      name: _Paths.DYNAMIC_ADS,
      page: () => const DynamicAdsView(),
      binding: DynamicAdsBinding(),
    ),
    GetPage(
      name: _Paths.RESTAURANTS,
      page: () => RestaurantsView(),
      binding: RestaurantsBinding(),
    ),
    GetPage(
      name: _Paths.RIDERS,
      page: () => RidersView(),
      binding: RidersBinding(),
    ),
    GetPage(
      name: _Paths.LOADINGS,
      page: () => LoadingsView(),
      binding: LoadingsBinding(),
    ),
    GetPage(
      name: _Paths.DOCTORS,
      page: () => DoctorsView(),
      binding: DoctorsBinding(),
    ),
    GetPage(
      name: _Paths.USER_REFERRALS,
      page: () => UserReferralsView(),
      binding: UserReferralsBinding(),
    ),
    GetPage(
      name: _Paths.REPORTS,
      page: () => ReportsView(),
      binding: ReportsBinding(),
    ),
    GetPage(
      name: _Paths.OTHER_USER_PROFILE,
      page: () => OtherUserProfileView(
        userId: Get.arguments as String,
      ),
      binding: OtherUserProfileBinding(),
    ),
    GetPage(
      name: _Paths.SINGLE_POST,
      page: () => SinglePostView(
        postId: Get.arguments as String,
      ),
      binding: SinglePostBinding(),
    ),
    GetPage(
      name: _Paths.DYNAMIC_AD_DETAILS,
      page: () => const DynamicAdDetailsView(),
      binding: DynamicAdDetailsBinding(),
    ),
    GetPage(
      name: _Paths.RESTAURANT_DETAILS,
      page: () => RequestFoodView(restaurantId: Get.arguments),
      binding: RequestFoodBinding(),
    ),
    GetPage(
      name: _Paths.DOCTOR_DETAILS,
      page: () => DoctorDetailsView(),
      binding: DoctorDetailsBinding(),
    ),
    GetPage(
      name: _Paths.MESSAGE,
      page: () => MessageView(),
      binding: MessageBinding(),
    ),
    GetPage(
      name: _Paths.COME_WITH_ME_TRIPS,
      page: () => const ComeWithMeTripsView(),
      binding: ComeWithMeTripsBinding(),
    ),
    GetPage(
      name: _Paths.REVIEW_COME_WITH_ME_TRIPS,
      page: () => const ReviewComeWithMeTripsView(),
      binding: ReviewComeWithMeTripsBinding(),
    ),
    GetPage(
      name: _Paths.PICK_ME_TRIPS,
      page: () => const PickMeTripsView(),
      binding: PickMeTripsBinding(),
    ),
    GetPage(
      name: _Paths.REVIEW_PICK_ME_TRIPS,
      page: () => const ReviewPickMeTripsView(),
      binding: ReviewPickMeTripsBinding(),
    ),
    GetPage(
      name: _Paths.MONTHLY_CONTEST,
      page: () => const MonthlyContestView(),
      binding: MonthlyContestBinding(),
    ),
    GetPage(
      name: _Paths.COMPLAINTS,
      page: () => const ComplaintsView(),
      binding: ComplaintsBinding(),
    ),
  ];
}
