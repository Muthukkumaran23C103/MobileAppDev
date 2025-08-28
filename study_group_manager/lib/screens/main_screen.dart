import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../utils/app_colors.dart';
import '../utils/app_constants.dart';
import 'profile_screen.dart';
import 'uploads_screen.dart';
import '../widgets/study_group_list.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text(
          'Study Groups',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: AppColors.primaryGreen,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          // Profile button
          Consumer<AuthService>(
            builder: (context, authService, child) {
              return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ProfileScreen(),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white.withOpacity(0.2),
                    child: authService.currentUser?.profilePicUrl != null
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        authService.currentUser!.profilePicUrl!,
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 24,
                          );
                        },
                      ),
                    )
                        : const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 3.0,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          labelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
          tabs: const [
            Tab(text: 'AI'),
            Tab(text: 'DEV'),
            Tab(text: 'OS'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          StudyGroupList(category: AppConstants.categoryAI),
          StudyGroupList(category: AppConstants.categoryDEV),
          StudyGroupList(category: AppConstants.categoryOS),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const UploadsScreen(),
            ),
          );
        },
        backgroundColor: AppColors.primaryGreen,
        foregroundColor: Colors.white,
        child: const Icon(Icons.upload_file),
      ),
    );
  }
}