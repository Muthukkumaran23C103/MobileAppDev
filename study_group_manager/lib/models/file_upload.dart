// Custom enums to avoid conflicts with file_picker package
enum UploadFileStatus {
  pending,
  uploading,
  completed,
  failed,
  deleted,
}

enum UploadFileType {
  document,
  image,
  video,
  presentation,
  spreadsheet,
  archive,
  other,
}

class FileUpload {
  final String id;
  final String fileName;
  final String originalName; // REQUIRED
  final String filePath;
  final String? remotePath;
  final int fileSize;
  final String mimeType;
  final String extension; // REQUIRED
  final UploadFileType fileType; // REQUIRED
  final UploadFileStatus status;
  final String uploadedBy;
  final String studyGroupId;
  final DateTime uploadedAt;
  final DateTime? completedAt;
  final String? thumbnailUrl;
  final String? downloadUrl;

  FileUpload({
    required this.id,
    required this.fileName,
    required this.originalName, // REQUIRED
    required this.filePath,
    this.remotePath,
    required this.fileSize,
    required this.mimeType,
    required this.extension, // REQUIRED
    required this.fileType, // REQUIRED
    this.status = UploadFileStatus.pending,
    required this.uploadedBy,
    required this.studyGroupId,
    required this.uploadedAt,
    this.completedAt,
    this.thumbnailUrl,
    this.downloadUrl,
  });

  // Get formatted file size
  String get formattedSize {
    if (fileSize < 1024) {
      return '${fileSize} B';
    } else if (fileSize < 1024 * 1024) {
      return '${(fileSize / 1024).toStringAsFixed(1)} KB';
    } else {
      return '${(fileSize / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
  }

  // Get time since upload
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(uploadedAt);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else {
      return 'Just uploaded';
    }
  }

  // Check if file is image
  bool get isImage => fileType == UploadFileType.image;

  // Check if file is document
  bool get isDocument => fileType == UploadFileType.document;

  @override
  String toString() {
    return 'FileUpload(id: $id, fileName: $fileName, size: $formattedSize)';
  }
}