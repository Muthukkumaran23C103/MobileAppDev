import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../services/auth_service.dart';
import '../utils/app_colors.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _usernameController = TextEditingController();
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    final authService = context.read<AuthService>();
    _usernameController.text = authService.userDisplayName;
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.primaryGreen,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Consumer<AuthService>(
        builder: (context, authService, child) {
          final user = authService.currentUser;
          if (user == null) {
            return const Center(
              child: Text('No user data available'),
            );
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                // Profile Header Card
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.primaryGreen,
                        AppColors.primaryGreenLight,
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      children: [
                        // Profile Picture
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.white,
                              backgroundImage: user.profilePicUrl != null
                                  ? NetworkImage(user.profilePicUrl!)
                                  : null,
                              child: user.profilePicUrl == null
                                  ? const Icon(
                                Icons.person,
                                size: 50,
                                color: AppColors.primaryGreen,
                              )
                                  : null,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  onPressed: _changeProfilePicture,
                                  icon: const Icon(
                                    Icons.camera_alt,
                                    color: AppColors.primaryGreen,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Username
                        Text(
                          user.username,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Email
                        Text(
                          user.email,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Profile Actions
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      // Change Profile Picture Button
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: _changeProfilePicture,
                          icon: const Icon(Icons.camera_alt),
                          label: const Text('CHANGE PROFILE PIC'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.primaryGreen,
                            side: const BorderSide(
                              color: AppColors.primaryGreen,
                              width: 2,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Change Username Button
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: _changeUsername,
                          icon: const Icon(Icons.edit),
                          label: const Text('CHANGE USER NAME'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.primaryGreen,
                            side: const BorderSide(
                              color: AppColors.primaryGreen,
                              width: 2,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Logout Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: _logout,
                          icon: const Icon(Icons.logout),
                          label: const Text('LOGOUT'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _changeProfilePicture() async {
    final ImagePicker picker = ImagePicker();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change Profile Picture'),
        content: const Text('Choose how you want to select your profile picture'),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              final XFile? image = await picker.pickImage(
                source: ImageSource.camera,
                maxWidth: 512,
                maxHeight: 512,
              );
              if (image != null) {
                _updateProfilePicture(image.path);
              }
            },
            child: const Text('Camera'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              final XFile? image = await picker.pickImage(
                source: ImageSource.gallery,
                maxWidth: 512,
                maxHeight: 512,
              );
              if (image != null) {
                _updateProfilePicture(image.path);
              }
            },
            child: const Text('Gallery'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Future<void> _updateProfilePicture(String imagePath) async {
    final authService = context.read<AuthService>();

    // In a real app, you would upload the image to your server
    // and get back a URL. For demo purposes, we'll just show success.
    final success = await authService.updateProfile(
      authService.userDisplayName,
      imagePath, // In reality, this would be the uploaded image URL
    );

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile picture updated successfully!'),
          backgroundColor: AppColors.primaryGreen,
        ),
      );
    }
  }

  void _changeUsername() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change Username'),
        content: TextField(
          controller: _usernameController,
          decoration: const InputDecoration(
            labelText: 'New Username',
            border: OutlineInputBorder(),
          ),
          maxLength: 20,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final newUsername = _usernameController.text.trim();
              if (newUsername.isNotEmpty) {
                Navigator.pop(context);
                final authService = context.read<AuthService>();
                final success = await authService.updateProfile(
                  newUsername,
                  authService.currentUser?.profilePicUrl,
                );

                if (success && mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Username updated successfully!'),
                      backgroundColor: AppColors.primaryGreen,
                    ),
                  );
                }
              }
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              final authService = context.read<AuthService>();
              await authService.logout();

              if (mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                      (route) => false,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}