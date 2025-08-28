import '../utils/app_constants.dart';

class StudyGroup {
  final String id;
  final String title;
  final String description;
  final String category; // 'AI', 'DEV', 'OS'
  final int memberCount;
  final int maxMembers;
  final String createdBy;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final List<String>? tags;
  final String? imageUrl;
  final String? meetingLink;
  final DateTime? nextMeetingDate;
  final bool isActive;
  final bool isPublic;
  final bool isPremium;
  final double? rating;
  final int ratingCount;
  final Map<String, dynamic>? settings;
  final List<String>? admins;
  final List<String>? members;

  StudyGroup({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.memberCount,
    this.maxMembers = 50,
    required this.createdBy,
    required this.createdAt,
    this.updatedAt,
    this.tags,
    this.imageUrl,
    this.meetingLink,
    this.nextMeetingDate,
    this.isActive = true,
    this.isPublic = true,
    this.isPremium = false,
    this.rating,
    this.ratingCount = 0,
    this.settings,
    this.admins,
    this.members,
  });

  // Create StudyGroup from JSON
  factory StudyGroup.fromJson(Map<String, dynamic> json) {
    return StudyGroup(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      category: json['category']?.toString() ?? AppConstants.categoryAI,
      memberCount: json['memberCount'] ?? 0,
      maxMembers: json['maxMembers'] ?? 50,
      createdBy: json['createdBy']?.toString() ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString()) ?? DateTime.now()
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'].toString())
          : null,
      tags: json['tags'] != null
          ? List<String>.from(json['tags'])
          : null,
      imageUrl: json['imageUrl']?.toString(),
      meetingLink: json['meetingLink']?.toString(),
      nextMeetingDate: json['nextMeetingDate'] != null
          ? DateTime.tryParse(json['nextMeetingDate'].toString())
          : null,
      isActive: json['isActive'] ?? true,
      isPublic: json['isPublic'] ?? true,
      isPremium: json['isPremium'] ?? false,
      rating: json['rating']?.toDouble(),
      ratingCount: json['ratingCount'] ?? 0,
      settings: json['settings'] != null
          ? Map<String, dynamic>.from(json['settings'])
          : null,
      admins: json['admins'] != null
          ? List<String>.from(json['admins'])
          : null,
      members: json['members'] != null
          ? List<String>.from(json['members'])
          : null,
    );
  }

  // Convert StudyGroup to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'memberCount': memberCount,
      'maxMembers': maxMembers,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'tags': tags,
      'imageUrl': imageUrl,
      'meetingLink': meetingLink,
      'nextMeetingDate': nextMeetingDate?.toIso8601String(),
      'isActive': isActive,
      'isPublic': isPublic,
      'isPremium': isPremium,
      'rating': rating,
      'ratingCount': ratingCount,
      'settings': settings,
      'admins': admins,
      'members': members,
    };
  }

  // Create a copy with updated fields
  StudyGroup copyWith({
    String? id,
    String? title,
    String? description,
    String? category,
    int? memberCount,
    int? maxMembers,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? tags,
    String? imageUrl,
    String? meetingLink,
    DateTime? nextMeetingDate,
    bool? isActive,
    bool? isPublic,
    bool? isPremium,
    double? rating,
    int? ratingCount,
    Map<String, dynamic>? settings,
    List<String>? admins,
    List<String>? members,
  }) {
    return StudyGroup(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      memberCount: memberCount ?? this.memberCount,
      maxMembers: maxMembers ?? this.maxMembers,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      tags: tags ?? this.tags,
      imageUrl: imageUrl ?? this.imageUrl,
      meetingLink: meetingLink ?? this.meetingLink,
      nextMeetingDate: nextMeetingDate ?? this.nextMeetingDate,
      isActive: isActive ?? this.isActive,
      isPublic: isPublic ?? this.isPublic,
      isPremium: isPremium ?? this.isPremium,
      rating: rating ?? this.rating,
      ratingCount: ratingCount ?? this.ratingCount,
      settings: settings ?? this.settings,
      admins: admins ?? this.admins,
      members: members ?? this.members,
    );
  }

  // Get category display name
  String get categoryDisplayName {
    return AppConstants.categoryDisplayNames[category] ?? category;
  }

  // Get formatted member count
  String get memberCountText {
    if (memberCount == 1) {
      return '1 member';
    }
    return '$memberCount members';
  }

  // Check if group is full
  bool get isFull {
    return memberCount >= maxMembers;
  }

  // Get availability text
  String get availabilityText {
    if (isFull) {
      return 'Full';
    }
    final remaining = maxMembers - memberCount;
    return '$remaining spots left';
  }

  // Get rating text
  String get ratingText {
    if (rating == null || ratingCount == 0) {
      return 'No ratings';
    }
    return '${rating!.toStringAsFixed(1)} (${ratingCount} reviews)';
  }

  // Check if user can join
  bool canUserJoin(String userId) {
    return isActive &&
        isPublic &&
        !isFull &&
        !(members?.contains(userId) ?? false);
  }

  // Check if user is admin
  bool isUserAdmin(String userId) {
    return createdBy == userId || (admins?.contains(userId) ?? false);
  }

  // Check if user is member
  bool isUserMember(String userId) {
    return members?.contains(userId) ?? false;
  }

  // Get formatted tags for display
  String get tagsText {
    if (tags == null || tags!.isEmpty) {
      return '';
    }
    return tags!.join(', ');
  }

  // Get time since creation
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '${months} month${months > 1 ? 's' : ''} ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else {
      return 'Just created';
    }
  }

  @override
  String toString() {
    return 'StudyGroup(id: $id, title: $title, category: $category, members: $memberCount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is StudyGroup &&
        other.id == id &&
        other.title == title &&
        other.category == category;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ category.hashCode;

  // Static factory for creating a new study group
  static StudyGroup create({
    required String title,
    required String description,
    required String category,
    required String createdBy,
    List<String>? tags,
    int maxMembers = 50,
  }) {
    return StudyGroup(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      category: category,
      memberCount: 1, // Creator is the first member
      maxMembers: maxMembers,
      createdBy: createdBy,
      createdAt: DateTime.now(),
      tags: tags,
      admins: [createdBy],
      members: [createdBy],
    );
  }

  // Static method to get sample study groups for each category
  static List<StudyGroup> getSampleGroups() {
    final now = DateTime.now();

    return [
      // AI Category
      StudyGroup(
        id: '1',
        title: 'Machine Learning Fundamentals',
        description: 'Learn the basics of ML algorithms and implementation with hands-on projects and real-world examples.',
        category: AppConstants.categoryAI,
        memberCount: 25,
        createdBy: 'instructor1',
        createdAt: now.subtract(const Duration(days: 5)),
        tags: ['Machine Learning', 'Python', 'Algorithms'],
        rating: 4.8,
        ratingCount: 12,
      ),
      StudyGroup(
        id: '2',
        title: 'Deep Learning with TensorFlow',
        description: 'Advanced neural network architectures, training techniques, and TensorFlow implementation.',
        category: AppConstants.categoryAI,
        memberCount: 18,
        createdBy: 'instructor2',
        createdAt: now.subtract(const Duration(days: 3)),
        tags: ['Deep Learning', 'TensorFlow', 'Neural Networks'],
        rating: 4.9,
        ratingCount: 8,
      ),
      StudyGroup(
        id: '3',
        title: 'Natural Language Processing',
        description: 'Text processing, sentiment analysis, language models, and modern NLP techniques.',
        category: AppConstants.categoryAI,
        memberCount: 32,
        createdBy: 'instructor3',
        createdAt: now.subtract(const Duration(days: 1)),
        tags: ['NLP', 'Text Analysis', 'Language Models'],
        rating: 4.7,
        ratingCount: 15,
      ),

      // DEV Category
      StudyGroup(
        id: '4',
        title: 'Flutter Mobile Development',
        description: 'Build beautiful cross-platform mobile apps with Flutter and Dart programming language.',
        category: AppConstants.categoryDEV,
        memberCount: 40,
        createdBy: 'instructor4',
        createdAt: now.subtract(const Duration(days: 4)),
        tags: ['Flutter', 'Mobile', 'Dart'],
        rating: 4.9,
        ratingCount: 20,
      ),
      StudyGroup(
        id: '5',
        title: 'Full Stack Web Development',
        description: 'Complete web development course covering React, Node.js, databases, and deployment.',
        category: AppConstants.categoryDEV,
        memberCount: 35,
        createdBy: 'instructor5',
        createdAt: now.subtract(const Duration(days: 2)),
        tags: ['React', 'Node.js', 'Full Stack'],
        rating: 4.6,
        ratingCount: 18,
      ),
      StudyGroup(
        id: '6',
        title: 'Cloud Native Applications',
        description: 'Learn to build and deploy applications using Docker, Kubernetes, and cloud services.',
        category: AppConstants.categoryDEV,
        memberCount: 22,
        createdBy: 'instructor6',
        createdAt: now.subtract(const Duration(hours: 12)),
        tags: ['Cloud', 'Docker', 'Kubernetes'],
        rating: 4.8,
        ratingCount: 10,
      ),

      // OS Category
      StudyGroup(
        id: '7',
        title: 'Linux System Administration',
        description: 'Master Linux commands, shell scripting, server management, and system optimization.',
        category: AppConstants.categoryOS,
        memberCount: 28,
        createdBy: 'instructor7',
        createdAt: now.subtract(const Duration(days: 6)),
        tags: ['Linux', 'System Admin', 'Shell Scripting'],
        rating: 4.7,
        ratingCount: 14,
      ),
      StudyGroup(
        id: '8',
        title: 'Operating System Concepts',
        description: 'Fundamentals of OS design, processes, memory management, and file systems.',
        category: AppConstants.categoryOS,
        memberCount: 42,
        createdBy: 'instructor8',
        createdAt: now.subtract(const Duration(days: 7)),
        tags: ['OS Theory', 'Processes', 'Memory Management'],
        rating: 4.5,
        ratingCount: 22,
      ),
      StudyGroup(
        id: '9',
        title: 'Windows Server Management',
        description: 'Windows Server setup, Active Directory, PowerShell automation, and enterprise management.',
        category: AppConstants.categoryOS,
        memberCount: 19,
        createdBy: 'instructor9',
        createdAt: now.subtract(const Duration(days: 2)),
        tags: ['Windows Server', 'Active Directory', 'PowerShell'],
        rating: 4.4,
        ratingCount: 9,
      ),
    ];
  }
}