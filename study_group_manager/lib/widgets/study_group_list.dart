import 'package:flutter/material.dart';
import '../models/study_group.dart';
import '../utils/app_colors.dart';
import '../utils/app_constants.dart';
import '../widgets/study_group_card.dart';

class StudyGroupList extends StatefulWidget {
  final String category;

  const StudyGroupList({
    super.key,
    required this.category,
  });

  @override
  State<StudyGroupList> createState() => _StudyGroupListState();
}

class _StudyGroupListState extends State<StudyGroupList> {
  List<StudyGroup> _studyGroups = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStudyGroups();
  }

  void _loadStudyGroups() {
    // Simulate loading delay
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _studyGroups = _getSampleStudyGroups(widget.category);
        _isLoading = false;
      });
    });
  }

  List<StudyGroup> _getSampleStudyGroups(String category) {
    switch (category) {
      case AppConstants.categoryAI:
        return [
          StudyGroup(
            id: '1',
            title: 'Machine Learning Fundamentals',
            description: 'Learn the basics of ML algorithms and implementation with hands-on projects and real-world examples.',
            category: category,
            memberCount: 25,
            createdBy: 'instructor1',
            createdAt: DateTime.now().subtract(const Duration(days: 5)),
            tags: ['Machine Learning', 'Python', 'Algorithms'],
          ),
          StudyGroup(
            id: '2',
            title: 'Deep Learning with TensorFlow',
            description: 'Advanced neural network architectures, training techniques, and TensorFlow implementation.',
            category: category,
            memberCount: 18,
            createdBy: 'instructor2',
            createdAt: DateTime.now().subtract(const Duration(days: 3)),
            tags: ['Deep Learning', 'TensorFlow', 'Neural Networks'],
          ),
          StudyGroup(
            id: '3',
            title: 'Natural Language Processing',
            description: 'Text processing, sentiment analysis, language models, and modern NLP techniques.',
            category: category,
            memberCount: 32,
            createdBy: 'instructor3',
            createdAt: DateTime.now().subtract(const Duration(days: 1)),
            tags: ['NLP', 'Text Analysis', 'Language Models'],
          ),
        ];
      case AppConstants.categoryDEV:
        return [
          StudyGroup(
            id: '4',
            title: 'Flutter Mobile Development',
            description: 'Build beautiful cross-platform mobile apps with Flutter and Dart programming language.',
            category: category,
            memberCount: 40,
            createdBy: 'instructor4',
            createdAt: DateTime.now().subtract(const Duration(days: 4)),
            tags: ['Flutter', 'Mobile', 'Dart'],
          ),
          StudyGroup(
            id: '5',
            title: 'Full Stack Web Development',
            description: 'Complete web development course covering React, Node.js, databases, and deployment.',
            category: category,
            memberCount: 35,
            createdBy: 'instructor5',
            createdAt: DateTime.now().subtract(const Duration(days: 2)),
            tags: ['React', 'Node.js', 'Full Stack'],
          ),
          StudyGroup(
            id: '6',
            title: 'Cloud Native Applications',
            description: 'Learn to build and deploy applications using Docker, Kubernetes, and cloud services.',
            category: category,
            memberCount: 22,
            createdBy: 'instructor6',
            createdAt: DateTime.now().subtract(const Duration(hours: 12)),
            tags: ['Cloud', 'Docker', 'Kubernetes'],
          ),
        ];
      case AppConstants.categoryOS:
        return [
          StudyGroup(
            id: '7',
            title: 'Linux System Administration',
            description: 'Master Linux commands, shell scripting, server management, and system optimization.',
            category: category,
            memberCount: 28,
            createdBy: 'instructor7',
            createdAt: DateTime.now().subtract(const Duration(days: 6)),
            tags: ['Linux', 'System Admin', 'Shell Scripting'],
          ),
          StudyGroup(
            id: '8',
            title: 'Operating System Concepts',
            description: 'Fundamentals of OS design, processes, memory management, and file systems.',
            category: category,
            memberCount: 42,
            createdBy: 'instructor8',
            createdAt: DateTime.now().subtract(const Duration(days: 7)),
            tags: ['OS Theory', 'Processes', 'Memory Management'],
          ),
          StudyGroup(
            id: '9',
            title: 'Windows Server Management',
            description: 'Windows Server setup, Active Directory, PowerShell automation, and enterprise management.',
            category: category,
            memberCount: 19,
            createdBy: 'instructor9',
            createdAt: DateTime.now().subtract(const Duration(days: 2)),
            tags: ['Windows Server', 'Active Directory', 'PowerShell'],
          ),
        ];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundLight,
      child: _isLoading
          ? const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryGreen),
        ),
      )
          : _studyGroups.isEmpty
          ? const Center(
        child: Text(
          'No study groups found',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.textSecondary,
          ),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _studyGroups.length,
        itemBuilder: (context, index) {
          return StudyGroupCard(
            studyGroup: _studyGroups[index],
            onTap: () {
              _showStudyGroupDetails(_studyGroups[index]);
            },
          );
        },
      ),
    );
  }

  void _showStudyGroupDetails(StudyGroup studyGroup) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(studyGroup.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(studyGroup.description),
            const SizedBox(height: 16),
            Text(
              'Members: ${studyGroup.memberCount}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryGreen,
              ),
            ),
            if (studyGroup.tags != null) ...[
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: studyGroup.tags!.map((tag) => Chip(
                  label: Text(
                    tag,
                    style: const TextStyle(fontSize: 12),
                  ),
                  backgroundColor: AppColors.primaryGreenLight,
                )).toList(),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Joined study group!'),
                  backgroundColor: AppColors.primaryGreen,
                ),
              );
            },
            child: const Text('Join Group'),
          ),
        ],
      ),
    );
  }
}