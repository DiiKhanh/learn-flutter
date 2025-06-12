import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/configs/navigation.dart';
import 'package:my_app/cubits/profile_cubit.dart';
import 'package:my_app/widgets/avatar.dart';
import 'package:my_app/widgets/info_card.dart';
import 'package:my_app/widgets/separator.dart';
import 'package:my_app/widgets/tag.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Staff Profile',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Header
                  Row(
                    children: [
                      // Avatar
                      Avatar(text: state.username.substring(0, 1)),
                      const SizedBox(width: 20),
                      // Name and Status
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.name,
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 0,
                                vertical: 2,
                              ),
                              child: Text(
                                state.active.name.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Contact Information
                  InfoCardWidget(
                    icon: Icons.phone,
                    iconColor: Colors.teal,
                    title: 'PHONE NUMBER',
                    content: state.phone,
                  ),
                  const SizedBox(height: 20),

                  InfoCardWidget(
                    icon: Icons.email,
                    iconColor: Colors.teal,
                    title: 'EMAIL',
                    content: state.email,
                  ),
                  const SizedBox(height: 20),

                  // Address and Nationality
                  InfoCardWidget(
                    icon: Icons.home,
                    iconColor: Colors.teal,
                    title: 'ADDRESS',
                    content: state.address,
                  ),
                  const SizedBox(height: 20),
                  InfoCardWidget(
                    icon: Icons.public,
                    iconColor: Colors.teal,
                    title: 'NATIONALITY',
                    content: state.nationality,
                  ),
                  const SizedBox(height: 20),
                  const Separator(color: Colors.grey),
                  const SizedBox(height: 20),

                  // Roles Section
                  const Text(
                    'Roles',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 15),

                  const TagWidget(text: 'FINANCE'),

                  const SizedBox(height: 20),
                  const Separator(color: Colors.grey),
                  const SizedBox(height: 20),

                  // Action Section
                  const Text(
                    'Action',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: _buildActionButton(
                          text: 'Edit Roles',
                          backgroundColor: Colors.white,
                          textColor: Colors.teal,
                          onPressed:
                              () => (Navigator.of(
                                context,
                              ).pushNamed(Navigation.editProfileScreen)),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: _buildActionButton(
                          text: 'Reset Account',
                          backgroundColor: Colors.white,
                          textColor: Colors.teal,
                          onPressed: () => (),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else if (state is ProfileError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: Text('No data profile'));
        },
      ),
    );
  }

  Widget _buildActionButton({
    required String text,
    required Color backgroundColor,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: BorderSide(color: textColor.withValues(alpha: .3), width: 1),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        child: Text(text),
      ),
    );
  }
}
