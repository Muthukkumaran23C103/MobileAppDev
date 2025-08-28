class User {
  final String id;
  final String email;
  final String username;
  final String? profilePicUrl;
  final String? registeredEmail;
  final String? firstName;
  final String? lastName;
  final String? bio;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isActive;
  final bool isVerified;
  final List<String>? interests;
  final Map<String, dynamic>? settings;

  User({
    required this.id,
    required this.email,
    required this.username,
    this.profilePicUrl,
    this.registeredEmail,
    this.firstName,
    this.lastName,
    this.bio,
    required this.createdAt,
    this.updatedAt,
    this.isActive = true,
    this.isVerified = false,
    this.interests,
    this.settings,
  });

  // Create User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      username: json['username']?.toString() ?? '',
      profilePicUrl: json['profilePicUrl']?.toString(),
      registeredEmail: json['registeredEmail']?.toString(),
      firstName: json['firstName']?.toString(),
      lastName: json['lastName']?.toString(),
      bio: json['bio']?.toString(),
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString()) ?? DateTime.now()
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'].toString())
          : null,
      isActive: json['isActive'] ?? true,
      isVerified: json['isVerified'] ?? false,
      interests: json['interests'] != null
          ? List<String>.from(json['interests'])
          : null,
      settings: json['settings'] != null
          ? Map<String, dynamic>.from(json['settings'])
          : null,
    );
  }

  // Convert User to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'profilePicUrl': profilePicUrl,
      'registeredEmail': registeredEmail,
      'firstName': firstName,
      'lastName': lastName,
      'bio': bio,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'isActive': isActive,
      'isVerified': isVerified,
      'interests': interests,
      'settings': settings,
    };
  }

  // Create a copy with updated fields
  User copyWith({
    String? id,
    String? email,
    String? username,
    String? profilePicUrl,
    String? registeredEmail,
    String? firstName,
    String? lastName,
    String? bio,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
    bool? isVerified,
    List<String>? interests,
    Map<String, dynamic>? settings,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
      profilePicUrl: profilePicUrl ?? this.profilePicUrl,
      registeredEmail: registeredEmail ?? this.registeredEmail,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      bio: bio ?? this.bio,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
      isVerified: isVerified ?? this.isVerified,
      interests: interests ?? this.interests,
      settings: settings ?? this.settings,
    );
  }

  // Get display name (firstName lastName, or username, or email)
  String get displayName {
    if (firstName != null && lastName != null) {
      return '$firstName $lastName';
    }
    if (firstName != null) {
      return firstName!;
    }
    return username.isNotEmpty ? username : email.split('@')[0];
  }

  // Get initials for avatar
  String get initials {
    if (firstName != null && lastName != null) {
      return '${firstName![0]}${lastName![0]}'.toUpperCase();
    }
    if (firstName != null) {
      return firstName![0].toUpperCase();
    }
    return username.isNotEmpty
        ? username[0].toUpperCase()
        : email[0].toUpperCase();
  }

  // Check if profile is complete
  bool get isProfileComplete {
    return username.isNotEmpty &&
        email.isNotEmpty &&
        firstName != null &&
        lastName != null;
  }

  // Get full email (for display)
  String get fullEmail => registeredEmail ?? email;

  @override
  String toString() {
    return 'User(id: $id, email: $email, username: $username, displayName: $displayName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User &&
        other.id == id &&
        other.email == email &&
        other.username == username;
  }

  @override
  int get hashCode => id.hashCode ^ email.hashCode ^ username.hashCode;

  // Static factory for creating a guest/anonymous user
  static User guest() {
    return User(
      id: 'guest',
      email: 'guest@example.com',
      username: 'Guest',
      createdAt: DateTime.now(),
      isActive: false,
    );
  }

  // Static factory for creating a new user
  static User create({
    required String email,
    required String username,
    String? firstName,
    String? lastName,
  }) {
    return User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      email: email,
      username: username,
      firstName: firstName,
      lastName: lastName,
      createdAt: DateTime.now(),
    );
  }
}