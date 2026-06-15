import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/ai_service.dart';
import '../../utils/theme.dart';

class AIRecommendationScreen extends StatefulWidget {
  const AIRecommendationScreen({super.key});

  @override
  State<AIRecommendationScreen> createState() => _AIRecommendationScreenState();
}

class _AIRecommendationScreenState extends State<AIRecommendationScreen> {
  final TextEditingController _skillsController = TextEditingController();
  final TextEditingController _educationController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final AIService _aiService = AIService();

  String _result = '';
  bool _isLoading = false;

  @override
  void dispose() {
    _skillsController.dispose();
    _educationController.dispose();
    _experienceController.dispose();
    super.dispose();
  }

  Future<void> _getRecommendations() async {
    if (_skillsController.text.trim().isEmpty ||
        _educationController.text.trim().isEmpty ||
        _experienceController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _result = '';
    });

    try {
      final skills = _skillsController.text.split(',').map((e) => e.trim()).toList();
      final experience = int.tryParse(_experienceController.text) ?? 0;

      final response = await _aiService.recommendJobs(
        skills: skills,
        education: _educationController.text.trim(),
        experience: experience,
      );

      setState(() {
        _result = response;
      });
    } catch (e) {
      setState(() {
        _result = 'Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('AI Career Analysis'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 32),
            _buildInputCard(),
            const SizedBox(height: 32),
            if (_isLoading) _buildLoadingState(),
            if (_result.isNotEmpty) _buildResultCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Personalized Roadmap 🗺️',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Let our AI analyze your profile and suggest the best career path for you.',
          style: TextStyle(color: Colors.grey, fontSize: 15),
        ),
      ],
    );
  }

  Widget _buildInputCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        children: [
          TextField(
            controller: _skillsController,
            decoration: const InputDecoration(
              labelText: 'Current Skills',
              hintText: 'e.g. Flutter, Dart, SQL',
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _educationController,
            decoration: const InputDecoration(
              labelText: 'Education',
              hintText: 'e.g. B.Tech in Computer Science',
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _experienceController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Experience (Years)',
              hintText: 'e.g. 2',
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _getRecommendations,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                padding: EdgeInsets.zero,
              ),
              child: Ink(
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'Analyze My Career',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 40),
          const CircularProgressIndicator(),
          const SizedBox(height: 20),
          Text(
            'AI is processing your profile...',
            style: GoogleFonts.plusJakartaSans(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildResultCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppTheme.primaryColor.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome_rounded, color: AppTheme.primaryColor),
              const SizedBox(width: 12),
              Text(
                'AI Recommendations',
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppTheme.primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SelectableText(
            _result,
            style: const TextStyle(
              fontSize: 15,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
