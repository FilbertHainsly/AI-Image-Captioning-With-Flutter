import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../services/ai_service.dart';
import '../theme/app_theme.dart';
import '../widgets/caption_card.dart';
import '../widgets/image_preview.dart';
import '../widgets/source_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  File? _image;
  String _caption = "";
  bool _isLoading = false;
  bool _isError = false;

  late final AnimationController _fabController;
  late final Animation<double> _fabScale;

  @override
  void initState() {
    super.initState();
    _fabController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fabScale = CurvedAnimation(
      parent: _fabController,
      curve: Curves.elasticOut,
    );
    // Animate FAB in on load
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _fabController.forward();
    });
  }

  @override
  void dispose() {
    _fabController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: source,
      maxWidth: 1920,
      maxHeight: 1920,
      imageQuality: 85,
    );

    if (picked == null) return;

    setState(() {
      _image = File(picked.path);
      _caption = "";
      _isError = false;
    });

    _generateCaption();
  }

  Future<void> _generateCaption() async {
    if (_image == null) return;

    setState(() {
      _isLoading = true;
      _isError = false;
    });

    final result = await AIService.generateCaption(_image!);

    if (!mounted) return;

    setState(() {
      _isLoading = false;
      if (result.isSuccess) {
        _caption = result.caption!;
        _isError = false;
      } else {
        _caption = result.error ?? "Unknown error occurred.";
        _isError = true;
      }
    });
  }

  void _showSourcePicker() {
    SourcePicker.show(
      context,
      onCamera: () => _pickImage(ImageSource.camera),
      onGallery: () => _pickImage(ImageSource.gallery),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: _image == null ? _buildEmptyState() : _buildContent(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: ScaleTransition(
        scale: _fabScale,
        child: Container(
          decoration: BoxDecoration(
            gradient: AppTheme.primaryGradient,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: AppTheme.accentPurple.withValues(alpha: 0.4),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: FloatingActionButton.extended(
            onPressed: _isLoading ? null : _showSourcePicker,
            backgroundColor: Colors.transparent,
            elevation: 0,
            highlightElevation: 0,
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _image == null
                  ? const Icon(Icons.add_a_photo_rounded,
                      key: ValueKey('add'), color: Colors.white)
                  : const Icon(Icons.refresh_rounded,
                      key: ValueKey('refresh'), color: Colors.white),
            ),
            label: Text(
              _image == null ? "Upload Image" : "New Image",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: AppTheme.primaryGradient,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.auto_awesome, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "AI Vision",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                "Describe any image with AI",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Floating icon with glow effect
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.accentPurple.withValues(alpha: 0.3),
                    blurRadius: 40,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: const Icon(
                Icons.image_search_rounded,
                color: Colors.white,
                size: 52,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              "No Image Selected",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 12),
            Text(
              "Take a photo or pick one from your gallery.\nAI will automatically describe what it sees.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    height: 1.6,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          // Image preview
          ImagePreview(imageFile: _image!),

          const SizedBox(height: 20),

          // Caption / Loading / Error
          CaptionCard(
            caption: _caption,
            isLoading: _isLoading,
            isError: _isError,
          ),

          // Retry button on error
          if (_isError && !_isLoading)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: OutlinedButton.icon(
                onPressed: _generateCaption,
                icon: const Icon(Icons.refresh_rounded, size: 18),
                label: const Text("Retry"),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.accentPurple,
                  side: const BorderSide(color: AppTheme.accentPurple),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
