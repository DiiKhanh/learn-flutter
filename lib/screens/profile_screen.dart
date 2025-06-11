import 'package:flutter/material.dart';
import 'package:my_app/screens/edit_profile_screen.dart';
import 'package:my_app/widgets/avatar.dart';
import 'package:my_app/widgets/info_card.dart';
import 'package:my_app/widgets/separator.dart';
import 'package:my_app/widgets/tag.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header
            Row(
              children: [
                // Avatar
                const Avatar(text: 'L'),
                const SizedBox(width: 20),
                // Name and Status
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Lucy Harvester',
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
                        child: const Text(
                          'Deactivated',
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
              content: '+86123562912',
            ),
            const SizedBox(height: 20),

            InfoCardWidget(
              icon: Icons.email,
              iconColor: Colors.teal,
              title: 'EMAIL',
              content: 'bingo.yang@stacktech.org',
            ),
            const SizedBox(height: 20),

            // Address and Nationality
            InfoCardWidget(
              icon: Icons.home,
              iconColor: Colors.teal,
              title: 'ADDRESS',
              content: 'Lu Bu Zhao Yun, Guang Chou District, Shanghai City',
            ),
            const SizedBox(height: 20),
            InfoCardWidget(
              icon: Icons.public,
              iconColor: Colors.teal,
              title: 'NATIONALITY',
              content: 'China',
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
                        () => (Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const EditProfileScreen(),
                          ),
                        )),
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
