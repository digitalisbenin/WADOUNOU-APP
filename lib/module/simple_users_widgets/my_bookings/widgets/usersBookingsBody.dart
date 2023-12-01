import 'package:flutter/material.dart';

class UsersBookingsBody extends StatefulWidget {
  const UsersBookingsBody({super.key});

  @override
  State<UsersBookingsBody> createState() => _UsersBookingsBodyState();
}

class _UsersBookingsBodyState extends State<UsersBookingsBody> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Mes Réservations"),
    );
  }
}
