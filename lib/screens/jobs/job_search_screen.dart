import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/job_model.dart';
import '../../services/job_service.dart';
import '../../app/routes.dart';
import '../../utils/theme.dart';

class JobSearchScreen extends StatefulWidget {
  const JobSearchScreen({super.key});

  @override
  State<JobSearchScreen> createState() => _JobSearchScreenState();
}

class _JobSearchScreenState extends State<JobSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final JobService _jobService = JobService();

  List<JobModel> _jobs = [];
  bool _isLoading = false;
  String _error = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _searchJobs() async {
    if (_searchController.text.trim().isEmpty) return;

    setState(() {
      _isLoading = true;
      _error = '';
      _jobs.clear();
    });

    try {
      final result = await _jobService.searchJobs(_searchController.text.trim());
      setState(() {
        _jobs = result;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Find Your Opportunity'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          _buildSearchHeader(),
          _buildFilterChips(),
          Expanded(
            child: _isLoading
                ? _buildShimmerLoading()
                : _jobs.isEmpty
                    ? _buildEmptyState()
                    : _buildJobList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchHeader() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Hero(
        tag: 'search_bar',
        child: Material(
          color: Colors.transparent,
          child: TextField(
            controller: _searchController,
            onSubmitted: (_) => _searchJobs(),
            decoration: InputDecoration(
              hintText: 'Job title, company or keywords',
              prefixIcon: const Icon(Icons.search_rounded, color: AppTheme.primaryColor),
              suffixIcon: IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 18),
                ),
                onPressed: _searchJobs,
              ),
              filled: true,
              fillColor: Theme.of(context).cardColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    final filters = ['All', 'Full-time', 'Remote', 'Contract', 'Internship'];
    return SizedBox(
      height: 40,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: FilterChip(
              label: Text(filters[index]),
              selected: index == 0,
              onSelected: (val) {},
              backgroundColor: Theme.of(context).cardColor,
              selectedColor: AppTheme.primaryColor.withOpacity(0.2),
              checkmarkColor: AppTheme.primaryColor,
              labelStyle: GoogleFonts.plusJakartaSans(
                color: index == 0 ? AppTheme.primaryColor : Colors.grey,
                fontWeight: index == 0 ? FontWeight.bold : FontWeight.normal,
                fontSize: 13,
              ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              side: BorderSide.none,
            ),
          );
        },
      ),
    );
  }

  Widget _buildJobList() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: _jobs.length,
      itemBuilder: (context, index) {
        final job = _jobs[index];
        return _buildJobCard(job);
      },
    );
  }

  Widget _buildJobCard(JobModel job) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () => Navigator.pushNamed(context, AppRoutes.jobDetail, arguments: job),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(Icons.business_rounded, color: AppTheme.primaryColor, size: 30),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            job.title,
                            style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            job.company,
                            style: GoogleFonts.plusJakartaSans(
                              color: AppTheme.primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.bookmark_border_rounded, color: Colors.grey),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    _buildIconLabel(Icons.location_on_outlined, job.location),
                    const SizedBox(width: 16),
                    _buildIconLabel(Icons.access_time_rounded, job.jobType),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      job.salary,
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        minimumSize: const Size(0, 40),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Apply'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconLabel(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey),
        const SizedBox(width: 6),
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            color: Colors.grey,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Widget _buildShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: 5,
        itemBuilder: (_, __) => Container(
          height: 180,
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.search_off_rounded, size: 80, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            'Search for jobs to get started',
            style: GoogleFonts.plusJakartaSans(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
