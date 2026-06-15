class ApiConstants {
  // =========================
  // GROQ API
  // =========================

  static const String groqBaseUrl =
      'https://api.groq.com/openai/v1/chat/completions';

  // Replace with your API key
  static const String groqApiKey =
      'REPLACED_BY_USER';

  // Recommended Model
  static const String groqModel =
      'llama-3.3-70b-versatile';

  // =========================
  // JOB SEARCH API
  // =========================

  // Add later if using JSearch/Adzuna/etc.
  static const String jobApiBaseUrl = '';

  static const String jobApiKey = '';

  // =========================
  // REQUEST SETTINGS
  // =========================

  static const int connectTimeout = 30;

  static const int receiveTimeout = 30;
}