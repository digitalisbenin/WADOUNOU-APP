
import 'package:digitalis_restaurant_app/core/model/Deliver_person/deliver_person.dart';
import 'package:digitalis_restaurant_app/module/account/account_view_page.dart';
import 'package:digitalis_restaurant_app/module/account/add_delivery_person/add_delivery_person_page.dart';
import 'package:digitalis_restaurant_app/module/account/add_meal/add_meal_page.dart';
import 'package:digitalis_restaurant_app/module/account/delivery_list_view/delivery_person_listview_page.dart';
import 'package:digitalis_restaurant_app/module/account/orders/make_order_screen.dart';
import 'package:digitalis_restaurant_app/module/account/orders/orders_screen.dart';
import 'package:digitalis_restaurant_app/module/account/orders/pending_orders/doned_orders_view_page.dart';
import 'package:digitalis_restaurant_app/module/account/orders/waiting_orders/orders_page_view.dart';
import 'package:digitalis_restaurant_app/module/account/profile/edit_restaurant_info/edit_restaurant_info.dart';
import 'package:digitalis_restaurant_app/module/account/profile/edit_user_profil/edit_profile_page.dart';
import 'package:digitalis_restaurant_app/module/account/profile/profil.dart';
import 'package:digitalis_restaurant_app/module/account/reservations/doned_booking/doned_reservation_view_page.dart';
import 'package:digitalis_restaurant_app/module/account/reservations/make_reservations/make_reservation_screen.dart';
import 'package:digitalis_restaurant_app/module/account/reservations/reservations_screen.dart';
import 'package:digitalis_restaurant_app/module/account/reservations/waiting_booking/waiting_reservation_page.dart';
import 'package:digitalis_restaurant_app/module/account/subscription/subscription_page.dart';
import 'package:digitalis_restaurant_app/module/cart/cart_screen.dart';
import 'package:digitalis_restaurant_app/module/create_restaurant/create_restaurant_page.dart';
import 'package:digitalis_restaurant_app/module/forgot_password/forgot_password_page.dart';
import 'package:digitalis_restaurant_app/module/forgot_password/widgets/forgot_password_body.dart';
import 'package:digitalis_restaurant_app/module/forgot_password/widgets/new_password_widgets/new_password_widget_page.dart';
import 'package:digitalis_restaurant_app/module/register_delivery_person_pages/account_view_delivery_person/accoun_view_delivery_person.dart';
import 'package:digitalis_restaurant_app/module/register_delivery_person_pages/account_view_delivery_person/options_routs/account/delivery_person_edit_profile_page.dart';
import 'package:digitalis_restaurant_app/module/register_delivery_person_pages/account_view_delivery_person/options_routs/affiliate_restaurant/affiliate_restaurant_page.dart';
import 'package:digitalis_restaurant_app/module/register_delivery_person_pages/account_view_delivery_person/options_routs/delivery_status/delivery_status_page.dart';
import 'package:digitalis_restaurant_app/module/register_delivery_person_pages/account_view_delivery_person/options_routs/delivery_status/done_delivery_page.dart';
import 'package:digitalis_restaurant_app/module/register_delivery_person_pages/account_view_delivery_person/options_routs/delivery_status/pending_deliver_page.dart';
import 'package:digitalis_restaurant_app/module/register_delivery_person_pages/register_as_delivery_person/register_delivery_person.dart';
import 'package:digitalis_restaurant_app/module/register_delivery_person_pages/register_as_delivery_person/widgets/register_delivery_person_success.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/restaurants_details/all_meals/all_meals_screen.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/restaurants_details/widgets/restaurants_new_items/other_arrivals_widgets/widgets/daily_food_details_page.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/restaurants_details/widgets/restaurants_new_items/restaurant_other_arrivals_page.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/restaurants_details/widgets/restaurants_new_items/restaurants_new_arrivals_page.dart';
import 'package:digitalis_restaurant_app/module/screens/login/login_page.dart';
import 'package:digitalis_restaurant_app/module/screens/signup/sign_up_page.dart';
import 'package:digitalis_restaurant_app/module/simple_users_widgets/my_bookings/userBookingsPage.dart';
import 'package:digitalis_restaurant_app/module/simple_users_widgets/my_orders/usersOdersPage.dart';
import 'package:digitalis_restaurant_app/module/start/presentation/landing/presentation/landing_screen.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/home_screen.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/restaurants_details/restaurant_body.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/item_details_page.dart';
import 'package:digitalis_restaurant_app/module/start/presentation/onBoarding_screen/on_boarding_screen.dart';
import 'package:digitalis_restaurant_app/module/start/presentation/splash_screen/splash_screen.dart';
import 'package:digitalis_restaurant_app/widgets/restaurant_created_successfully.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  OnBoardingScreen.routeName: (context) => const OnBoardingScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  LandingScreen.routeName: (context) => const LandingScreen(),
  ItemDetailsPage.routeName: (context) => const ItemDetailsPage(),
  CartPage.routeName: (context) => const CartPage(),
  /* RestaurantBody.routeName: (context) => RestaurantBody(), */
  LoginPage.routeName: (context) => const LoginPage(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  CreateRestaurant.routeName: (context) => const CreateRestaurant(),
  RestaurantCreatedSuccessfully.routeName: (context) => const RestaurantCreatedSuccessfully(),
  AccountViewPage.routeName: (context) => const AccountViewPage(),
  AddMealPage.routeName: (context) => const AddMealPage(),
  AddDeliveryPersonPage.routeName: (context) => const AddDeliveryPersonPage(),

  DeliveryPersonListviewPage.routeName: (context) {
    List<DeliverPerson> selectedDeliverPersons = [];
    return DeliveryPersonListviewPage(selectedDeliverPersons: selectedDeliverPersons);
  },

  OrdersPageView.routeName: (context) => const OrdersPageView(),
  WaitingReservationPage.routeName: (context) => const WaitingReservationPage(),
  DonedOrdersViewPage.routeName: (context) => const DonedOrdersViewPage(),
  DonedReservationViewPage.routeName: (context) => const DonedReservationViewPage(),
  EditProfilePage.routeName: (context) => const EditProfilePage(),
  SubscriptionPage.routeName: (context) => const SubscriptionPage(),
  ReservationsScreens.routeName: (context) => ReservationsScreens(),
  OrdersScreens.routeName: (context) => const OrdersScreens(),
  ProfilePage.routeName: (context) => const ProfilePage(),
  EditRestaurantPage.routeName: (context) => const EditRestaurantPage(),
  RegisterDeliveryPerson.routeName: (context) => const RegisterDeliveryPerson(),
  RegisterDeliveryPersonSuccess.routeName: (context) => const RegisterDeliveryPersonSuccess(),
  AccountViewDeliveryPerson.routeName : (context) => const AccountViewDeliveryPerson(),
  MakeReservationScreen.routeName : (context) => const MakeReservationScreen(),
  DeliveryPersonEditProfilePage.routeName : (context) => const DeliveryPersonEditProfilePage(),
  DeliveryStatusPage.routeName : (context) => const DeliveryStatusPage(),
  PendingDeliveryPage.routeName : (context) => const PendingDeliveryPage(),
  DoneDeliveryPage.routeName : (context) => const DoneDeliveryPage(),
  AffiliateRestaurantPage.routeName : (context) => const AffiliateRestaurantPage(),
  ForgotPasswordPage.routeName : (context) => const ForgotPasswordPage(),
  NewPasswordWidgetPage.routeName : (context) => const NewPasswordWidgetPage(),
  UsersOrdersPage.routeName : (context) => const UsersOrdersPage(),
  UsersBookingsPage.routeName : (context) => const UsersBookingsPage(),
  RestaurantsNewArrivalPages.routeName : (context) => const RestaurantsNewArrivalPages(),
  RestaurantsOtherArrivalPages.routeName : (context) => const RestaurantsOtherArrivalPages(),
  MakeOrderScreen.routeName : (context) => const MakeOrderScreen(),
  DailyFoodDetailPage.routeName : (context) => const DailyFoodDetailPage(),
  AllMealsScreen.routeName : (context) => const AllMealsScreen(),



};
