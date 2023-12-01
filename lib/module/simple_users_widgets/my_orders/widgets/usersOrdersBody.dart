import 'package:flutter/material.dart';

class UsersOrdersBody extends StatefulWidget {
  const UsersOrdersBody({super.key});

  @override
  State<UsersOrdersBody> createState() => _UsersOrdersBodyState();
}

class _UsersOrdersBodyState extends State<UsersOrdersBody> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Mes Commandes"),
    );
  }
}
