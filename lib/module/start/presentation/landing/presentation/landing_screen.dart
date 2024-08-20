import 'package:digitalis_restaurant_app/module/start/presentation/landing/presentation/widgets/landing_screen.body.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key, this.selectedRoleId});

  final String? selectedRoleId;

  static String routeName = '/landing';

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
   Widget build(BuildContext context) {
    final selectedRoleId = ModalRoute.of(context)?.settings.arguments as String?;
    print('Received role ID: $selectedRoleId'); // Pour déboguer
    return Scaffold(
      body: LandingScreenBody(selectedRoleId: selectedRoleId),
    );
  }
}