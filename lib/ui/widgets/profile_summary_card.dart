import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_with_getx/ui/controllers/auth_controller.dart';
import 'package:task_manager_with_getx/ui/screens/edit_profile_screen.dart';
import 'package:task_manager_with_getx/ui/screens/login_screen.dart';

class ProfileSummaryCard extends StatefulWidget {
  const ProfileSummaryCard({
    super.key,
    this.enableOnTap = true,
  });

  final bool enableOnTap;

  @override
  State<ProfileSummaryCard> createState() => _ProfileSummaryCardState();
}

class _ProfileSummaryCardState extends State<ProfileSummaryCard> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authController) {
      Uint8List imageBytes =
          const Base64Decoder().convert(authController.user?.photo ?? "");
      return ListTile(
        onTap: () {
          if (widget.enableOnTap) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const EditProfileScreen(),
              ),
            );
          }
        },
        leading: CircleAvatar(
          child: authController.user?.photo == null
              ? const Icon(CupertinoIcons.person_alt_circle_fill)
              : ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.memory(
                    imageBytes,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
        title: Text(
          fullName(authController),
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        subtitle: Text(
          authController.user?.email ?? "",
          style: const TextStyle(color: Colors.white),
        ),
        trailing: IconButton(
            onPressed: () async {
              await AuthController.clearAuthData();
              Get.offAll(const LoginScreen());
            },
            icon: const Icon(
              CupertinoIcons.square_arrow_right,
              color: Colors.white,
            )),
        tileColor: Colors.green,
      );
    });
  }

  String fullName(AuthController authController) {
    return '${authController.user?.firstName ?? ''} ${authController.user?.lastName ?? ''}';
  }
}
