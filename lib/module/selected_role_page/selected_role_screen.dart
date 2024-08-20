import 'dart:convert';
import 'package:digitalis_restaurant_app/core/constants/constant.dart';
import 'package:digitalis_restaurant_app/core/model/Role/role_list_class.dart';
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:digitalis_restaurant_app/module/screens/signup/sign_up_page.dart';
import 'package:digitalis_restaurant_app/module/selected_role_page/selected_role_screen_background.dart';
import 'package:digitalis_restaurant_app/module/start/presentation/landing/presentation/landing_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class SelectedRoleScreen extends StatefulWidget {
  const SelectedRoleScreen({Key? key}) : super(key: key);

  static String routeName = '/select_role';

  @override
  State<SelectedRoleScreen> createState() => _SelectedRoleScreenState();
}

class _SelectedRoleScreenState extends State<SelectedRoleScreen> {
  late Future<List<Map<String, String>>> roles;
  String selectedRole = '';
  String? selectedRoleId;
  bool roleSelected = false;

  @override
  void initState() {
    super.initState();
    roles = fetchRoles();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, String>>>(
      future: roles,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return const Scaffold(
            body: Center(
              child: Text('Error: Unable to connect to server.'),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Scaffold(
            body: Center(
              child: Text('Error: No roles available.'),
            ),
          );
        } else {
          final roleList = snapshot.data!;
          return Stack(
            children: [
              const SelectedRoleScreenBackground(),
              Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  actions: const [
                    Padding(
                      padding: EdgeInsets.only(right: 15.0),
                      child: CircleAvatar(
                        backgroundImage:
                            AssetImage("assets/images/WADOUNOU 01.jpg"),
                        radius: 30,
                      ),
                    ),
                  ],
                ),
                backgroundColor: Colors.transparent,
                body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.3),
                        width: double.infinity,
                        height: SizeConfig.screenHeight * 0.06,
                        decoration: BoxDecoration(
                          color: Colors.grey[600]!.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        /*decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black38,
                              offset: Offset(0.0, 0.0),
                              blurRadius: 6,
                              spreadRadius: 0.0,
                            )
                          ],
                        ),*/
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DropdownButtonFormField<String>(
                              isDense: true,
                              icon: const Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: kWhite,
                              ),
                              value: roleSelected ? selectedRole : null,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedRole = newValue!;
                                  selectedRoleId = roleList.firstWhere(
                                    (role) => role['name'] == selectedRole,
                                  )['id'];
                                  // Enregistre l'ID du rôle sélectionné
                                  GetStorage().write('role_id', selectedRoleId);
                                  print(
                                      'Selected Role: $selectedRole, Role ID: $selectedRoleId');
                                });
                              },

                              dropdownColor: Colors.grey[600]!.withOpacity(0.5),
                              items: [
                                if (!roleSelected)
                                  const DropdownMenuItem(
                                      value: null,
                                      child: Text(
                                        'Sélectionner un rôle',
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: kWhite),
                                      )),
                                ...roleList.map((role) {
                                  return DropdownMenuItem<String>(
                                    value: role['name'],
                                    child: Text(role['name'] ?? 'Unknown', style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: kWhite),),
                                  );
                                })
                              ],
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.only(left: 10.0, right: 10.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (selectedRole.isNotEmpty)
                        ElevatedButton(
                          onPressed: () {
                            if (selectedRoleId != null) {
                              Navigator.pushNamed(
                                context,
                                SignUpScreen.routeName,
                                arguments: selectedRoleId,
                              );
                            }
                          },
                          child: Text(
                            'Continuer en tant que $selectedRole',
                            style: const TextStyle(fontSize: 18.0),
                          ),
                        ),
                      if (selectedRole.isEmpty)
                        const Text(
                          'Selectionnez un rôle pour continuer',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
