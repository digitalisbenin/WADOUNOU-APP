import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/module/restaurants_page/presentation/home/homePage/widgets/service_widgets/bookings/widgets/all_user_booking.dart';
import 'package:flutter/material.dart';

class AllBookingsScreen extends StatefulWidget {
  const AllBookingsScreen({super.key});

  static String routeName = 'booking_list_page';

  @override
  State<AllBookingsScreen> createState() => _AllBookingsScreenState();
}

class _AllBookingsScreenState extends State<AllBookingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kOnBoardingBackgroundColor,
        iconTheme: const IconThemeData(color: kWhite),
        title: const Text('Mes Reservations', style: TextStyle(color: kWhite),),
        centerTitle: true,
      ),
      body: const AllUserBookingsPage(),
    );
  }
}
