import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/configs/ui/dimens.dart';
import 'package:my_app/cubits/profile_cubit.dart';
import 'package:my_app/data/models/user_model.dart';
import 'package:my_app/widgets/avatar.dart';
import 'package:my_app/widgets/dropdown_field_info.dart';
import 'package:my_app/widgets/tag.dart';
import 'package:my_app/widgets/text_field_info.dart';
import 'package:my_app/widgets/text_label_info.dart';

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
  late final TextEditingController _nationalityController;

  final List<String> _nationalities = [
    'Vietnam',
    'United States',
    'United Kingdom',
    'Japan',
    'China',
    'San Antonio',
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
    _nationalityController = TextEditingController();

    context.read<ProfileCubit>().loadProfile('4');
  }

  @override
  void dispose() {
    _accountController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _nationalityController.dispose();
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
            _nationalityController.text = state.nationality;
          }
        },
        builder: (context, state) {
          if (state is EditProfileLoading || state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(Dimens.padding),
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
                        const TextLabelInfo(label: 'ACCOUNT'),
                        TextFieldInfo(
                          controller: _accountController,
                          hintText: 'Account username',
                          enabled: false,
                        ),

                        const SizedBox(height: 24),

                        // Name Field
                        const TextLabelInfo(label: 'NAME'),
                        TextFieldInfo(
                          controller: _nameController,
                          hintText: 'Full name',
                        ),

                        const SizedBox(height: 24),

                        // Email Field
                        const TextLabelInfo(label: 'EMAIL'),
                        TextFieldInfo(
                          controller: _emailController,
                          hintText: 'Email address',
                        ),

                        const SizedBox(height: 24),

                        // Phone Number Field
                        const TextLabelInfo(label: 'PHONE NUMBER'),
                        TextFieldInfo(
                          controller: _phoneController,
                          hintText: 'Phone number',
                        ),

                        const SizedBox(height: 24),

                        // Address Field
                        const TextLabelInfo(label: 'ADDRESS'),
                        TextFieldInfo(
                          controller: _addressController,
                          hintText: 'Address',
                        ),

                        const SizedBox(height: 24),

                        // Nationality Field
                        const TextLabelInfo(label: 'NATIONALITY'),
                        DropdownFieldInfo(
                          items: _nationalities,
                          value: _nationalityController.text,
                          onChanged: (value) {
                            _onChangeNationlity(value);
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 50),

                    // Update Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _onUpdateProfile,
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

  void _onChangeNationlity(String? newValue) {
    _nationalityController.text = newValue!;
  }

  void _onUpdateProfile() {
    if (_formKey.currentState!.validate()) {
      final user = UserModel(
        username: _accountController.text,
        name: Name(_nameController.text, ''),
        email: _emailController.text,
        phone: _phoneController.text,
        address: Address(_nationalityController.text, _addressController.text),
      );
      context.read<ProfileCubit>().updateProfile(request: user);
    }
  }
}
