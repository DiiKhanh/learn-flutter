import 'package:flutter/material.dart';
import 'package:my_app/widgets/avatar.dart';
import 'package:my_app/widgets/tag.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final _accountController = TextEditingController(text: 'hoangnguyen18');
  final _nameController = TextEditingController(text: 'Hoang Nguyen');
  final _emailController = TextEditingController(
    text: 'hoang.nguyen@stacktech.org',
  );
  final _phoneController = TextEditingController(text: '+84912885565');
  final _addressController = TextEditingController(
    text: 'Huynh Tan Phat Street, District...',
  );

  String _selectedNationality = 'Vietnam';
  final List<String> _nationalities = [
    'Vietnam',
    'United States',
    'United Kingdom',
    'Japan',
    'Other',
  ];

  @override
  void dispose() {
    _accountController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Edit Account Info',
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
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Header
              Row(
                children: [
                  // Avatar with edit icon
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
                            'Activated',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const TagWidget(text: 'Operator Admin'),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // Form Fields - Single Column
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Account Field (Disabled)
                  _buildFieldLabel('ACCOUNT'),
                  _buildTextField(
                    controller: _accountController,
                    hintText: 'Account username',
                    enabled: false,
                  ),

                  const SizedBox(height: 24),

                  // Name Field
                  _buildFieldLabel('NAME'),
                  _buildTextField(
                    controller: _nameController,
                    hintText: 'Full name',
                  ),

                  const SizedBox(height: 24),

                  // Email Field
                  _buildFieldLabel('EMAIL'),
                  _buildTextField(
                    controller: _emailController,
                    hintText: 'Email address',
                  ),

                  const SizedBox(height: 24),

                  // Phone Number Field
                  _buildFieldLabel('PHONE NUMBER'),
                  _buildTextField(
                    controller: _phoneController,
                    hintText: 'Phone number',
                  ),

                  const SizedBox(height: 24),

                  // Address Field
                  _buildFieldLabel('ADDRESS'),
                  _buildTextField(
                    controller: _addressController,
                    hintText: 'Address',
                  ),

                  const SizedBox(height: 24),

                  // Nationality Field
                  _buildFieldLabel('NATIONALITY'),
                  _buildDropdownField(),
                ],
              ),

              const SizedBox(height: 50),

              // Update Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Handle update profile
                      _updateProfile();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'UPDATE PROFILE',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.grey[600],
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool enabled = true,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: enabled ? Colors.white : Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),
          filled: true,
          fillColor: enabled ? Colors.white : Colors.grey[100],
        ),
        style: TextStyle(
          fontSize: 16,
          color: enabled ? Colors.black : Colors.grey[600],
        ),
        validator:
            enabled
                ? (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  }
                  return null;
                }
                : null,
      ),
    );
  }

  Widget _buildDropdownField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        value: _selectedNationality,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
        items:
            _nationalities.map((String nationality) {
              return DropdownMenuItem<String>(
                value: nationality,
                child: Text(
                  nationality,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
              );
            }).toList(),
        onChanged: (String? newValue) {
          if (newValue != null) {
            setState(() {
              _selectedNationality = newValue;
            });
          }
        },
      ),
    );
  }

  void _updateProfile() {
    // Handle the profile update logic here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile updated successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }
}
