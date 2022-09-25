import 'package:flutter/material.dart';
import 'package:travinia/presentation/shared_widgets/custom_text.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LargeHeadText(text: "PROFILE"),
      ),
    );
  }
}
