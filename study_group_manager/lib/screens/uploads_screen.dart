import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart' as picker; // Alias to avoid conflicts
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../utils/app_colors.dart';
import '../models/file_upload.dart';

class UploadsScreen extends StatefulWidget {
  const UploadsScreen({super.key});

  @override
  State<UploadsScreen> createState() => _UploadsScreenState();
}

class _UploadsScreenState extends State<UploadsScreen> {
  List<FileUpload> _uploadedFiles = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadSampleFiles();
  }

  void _loadSampleFiles() {
    setState(() {
      _uploadedFiles = [
        // FIXED: Added all required parameters
        FileUpload(
          id: '1',
          fileName: 'machine_learning_notes.pdf',
          originalName: 'Machine Learning - Complete Notes.pdf', // ADDED
          filePath: '/path/to/file1.pdf',
          fileSize: 2048576,
          mimeType: 'application/pdf',
          extension: 'pdf', // ADDED
          fileType: UploadFileType.document, // ADDED
          status: UploadFileStatus.completed,
          uploadedBy: '1',
          studyGroupId: '1',
          uploadedAt: DateTime.now().subtract(const Duration(days: 1)),
        ),
        FileUpload(
          id: '2',
          fileName: 'flutter_tutorial.docx',
          originalName: 'Flutter Development Tutorial.docx', // ADDED
          filePath: '/path/to/file2.docx',
          fileSize: 1536000,
          mimeType: 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
          extension: 'docx', // ADDED
          fileType: UploadFileType.document, // ADDED
          status: UploadFileStatus.completed,
          uploadedBy: '1',
          studyGroupId: '4',
          uploadedAt: DateTime.now().subtract(const Duration(hours: 3)),
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Uploads'),
        backgroundColor: AppColors.primaryGreen,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: AppColors.primaryGreen,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Column(
              children: [
                const Text(
                  'UPLOADS',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: _pickAndUploadFile,
                  icon: const Icon(Icons.upload_file),
                  label: const Text('UPLOAD FILES'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.primaryGreen,
                  ),
                ),
              ],
            ),
          ),

          // Files List
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _uploadedFiles.length,
              itemBuilder: (context, index) {
                final file = _uploadedFiles[index];
                return Card(
                  child: ListTile(
                    title: Text(file.fileName),
                    subtitle: Text(file.formattedSize),
                    leading: const Icon(Icons.file_copy),
                    trailing: Text(file.timeAgo),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickAndUploadFile() async {
    try {
      // FIXED: Use picker.FileType to avoid conflict
      picker.FilePickerResult? result = await picker.FilePicker.platform.pickFiles(
        type: picker.FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'txt', 'jpg', 'png'],
        allowMultiple: false,
      );

      if (result != null && result.files.single.path != null) {
        final file = result.files.first;

        setState(() {
          _isLoading = true;
        });

        await Future.delayed(const Duration(seconds: 1));

        // FIXED: Added all required parameters
        final newFileUpload = FileUpload(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          fileName: file.name,
          originalName: file.name, // ADDED
          filePath: file.path!,
          fileSize: file.size,
          mimeType: file.extension ?? 'unknown',
          extension: file.extension ?? '', // ADDED
          fileType: _getFileTypeFromExtension(file.extension ?? ''), // ADDED
          uploadedBy: context.read<AuthService>().currentUser?.id ?? '1',
          studyGroupId: '1',
          uploadedAt: DateTime.now(),
          status: UploadFileStatus.completed,
        );

        setState(() {
          _uploadedFiles.insert(0, newFileUpload);
          _isLoading = false;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('File uploaded successfully!')),
          );
        }
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error picking file')),
        );
      }
    }
  }

  // Helper method to determine file type
  UploadFileType _getFileTypeFromExtension(String extension) {
    final ext = extension.toLowerCase();
    if (['pdf', 'doc', 'docx', 'txt'].contains(ext)) {
      return UploadFileType.document;
    } else if (['jpg', 'png', 'jpeg', 'gif'].contains(ext)) {
      return UploadFileType.image;
    } else {
      return UploadFileType.other;
    }
  }
}