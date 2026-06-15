import 'package:flutter/material.dart';

import '../models/job_model.dart';

class JobCard extends StatelessWidget {
  final JobModel job;
  final VoidCallback? onTap;

  const JobCard({
    super.key,
    required this.job,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                job.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                job.company,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 10),

              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 18,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(job.location),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Row(
                children: [
                  const Icon(
                    Icons.work_outline,
                    size: 18,
                  ),
                  const SizedBox(width: 4),
                  Text(job.jobType),
                ],
              ),

              const SizedBox(height: 8),

              Row(
                children: [
                  const Icon(
                    Icons.currency_rupee,
                    size: 18,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(job.salary),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              if (job.skills.isNotEmpty)
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: job.skills.take(4).map((skill) {
                    return Chip(
                      label: Text(
                        skill,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    );
                  }).toList(),
                ),

              const SizedBox(height: 12),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: onTap,
                  child: const Text(
                    'View Details',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}