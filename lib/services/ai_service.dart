import 'dart:convert';
import 'package:http/http.dart' as http;

class AIService {
  static const String apiKey = 'REPLACED_BY_USER';


  Future<String> generateResponse(String prompt) async {
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
            "role": "user",
            "content": prompt,
          }
        ],
        "temperature": 0.7,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return data['choices'][0]['message']['content'];
    } else {
      throw Exception(response.body);
    }
  }

  Future<String> recommendJobs({
    required List<String> skills,
    required String education,
    required int experience,
  }) async {
    final prompt = """
Skills: ${skills.join(', ')}
Education: $education
Experience: $experience years

Suggest:
1. Top 5 job roles
2. Expected salary
3. Skills to learn
4. Career roadmap
""";

    return generateResponse(prompt);
  }
}