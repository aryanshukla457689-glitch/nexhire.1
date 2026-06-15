import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/job_model.dart';

class JobService {
  static const String apiKey = 'REPLACED_BY_USER';

  Future<String> getJobRecommendations({
    required List<String> skills,
    required String education,
    required int experience,
  }) async {
    final response = await http.post(
      Uri.parse('https://api.groq.com/openai/v1/chat/completions'),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "model": "llama-3.3-70b-versatile",
        "messages": [
          {
            "role": "system",
            "content": "You are an expert career advisor."
          },
          {
            "role": "user",
            "content": """
Skills: ${skills.join(', ')}
Education: $education
Experience: $experience years

Suggest:
1. Top 5 job roles
2. Expected salary
3. Skills to learn
4. Career roadmap
"""
          }
        ],
        "temperature": 0.7
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'];
    }

    throw Exception('Failed to get recommendations');
  }

  Future<List<JobModel>> searchJobs(String query) async {
    // This is a placeholder for searching jobs. 
    final List<Map<String, dynamic>> jobs = [
      {
        'id': '1',
        'title': 'Flutter Developer',
        'company': 'Tech Corp',
        'location': 'Remote',
        'description': 'Building amazing apps',
        'salary': '\$80k - \$120k',
        'jobType': 'Full-time',
        'applyUrl': 'https://example.com/apply',
        'skills': ['Flutter', 'Dart', 'Firebase'],
      },
      {
        'id': '2',
        'title': 'Dart Engineer',
        'company': 'App Studio',
        'location': 'New York',
        'description': 'Focusing on backend',
        'salary': '\$90k - \$130k',
        'jobType': 'Contract',
        'applyUrl': 'https://example.com/apply2',
        'skills': ['Dart', 'Server-side'],
      },
    ];

    return jobs.map((json) => JobModel.fromMap(json)).toList();
  }
}
