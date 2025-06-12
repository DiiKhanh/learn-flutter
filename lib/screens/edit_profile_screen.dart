import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/cubits/profile_cubit.dart';
import 'package:my_app/widgets/avatar.dart';
import 'package:my_app/widgets/tag.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _accountController;
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _addressController;
  // late final TextEditingController _selectedNationality;

  String _selectedNationality = 'Vietnam';
  final List<String> _nationalities = [
    'Vietnam',
    'United States',
    'United Kingdom',
    'Japan',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    _accountController = TextEditingController();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();
    // _selectedNationality = TextEditingController();

    context.read<ProfileCubit>().loadProfile();
  }

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
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is EditProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is EditProfileUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is ProfileLoaded) {
            _accountController.text = state.username;
            _nameController.text = state.name;
            _emailController.text = state.email;
            _phoneController.text = state.phone;
            _addressController.text = state.address;
          }
        },
        builder: (context, state) {
          if (state is EditProfileLoading || state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Header
                    Row(
                      children: [
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
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              TagWidget(text: state.role),
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
                            context.read<ProfileCubit>().updateProfile(
                              name: _nameController.text,
                              email: _emailController.text,
                              phone: _phoneController.text,
                              address: _addressController.text,
                              nationality: _selectedNationality,
                            );
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
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
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
            _selectedNationality = newValue;
          }
        },
      ),
    );
  }
}
