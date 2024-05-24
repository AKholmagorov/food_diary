import 'package:flutter/src/painting/image_resolution.dart';
import 'package:food_diary/temp/gigachat_model_types.dart';
import 'package:food_diary/temp/interface_ai_model.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class GigaChatModel implements IAIModel {
  @override
  late String name;
  
  @override
  AssetImage image = AssetImage('assets/GigaChat Pro.jpg');

  @override
  Future<String> getRecommendation(int period) async {
    return ApiService().sendPrompt('Как же так?');
  }

  GigaChatModel(GigaChatModelType modelType) {
    switch (modelType) {
      case GigaChatModelType.Lite:
        this.name = 'GigaChat Lite';
      case GigaChatModelType.LitePlus:
        this.name = 'GigaChat Lite+';
      case GigaChatModelType.Pro:
        this.name = 'GigaChat Pro';
      default:
        this.name = 'NULL';
    }
  }
}

class ApiService {
  final String oauthUrl = 'https://ngw.devices.sberbank.ru:9443/api/v2/oauth';
  final String chatUrl = 'https://gigachat.devices.sberbank.ru/api/v1/chat/completions';
  final String authorizationData = '';
  final String rqUID = '';
  String? accessToken;

  Future<void> fetchAccessToken() async {
    try {
      final response = await http.post(
        Uri.parse(oauthUrl),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Accept': 'application/json',
          'RqUID': '$rqUID',
          'Authorization': 'Basic $authorizationData',
        },
        body: 'scope=GIGACHAT_API_PERS',
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        accessToken = data['access_token'];
      } else {
        throw Exception('Failed to fetch access token');
      }
    } catch (e) {
      print('Error fetching access token: $e');
      rethrow;
    }
  }

  Future<String> sendPrompt(String prompt) async {
    if (accessToken == null) {
      await fetchAccessToken();
    }

    try {
      final response = await http.post(
        Uri.parse(chatUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode({
          'model': 'GigaChat',
          'messages': [
            {'role': 'user', 'content': prompt}
          ],
          'temperature': 1.0,
          'top_p': 0.1,
          'n': 1,
          'stream': false,
          'max_tokens': 512,
          'repetition_penalty': 1,
        }),
      );

      if (response.statusCode == 401) {
        await fetchAccessToken();
        return sendPrompt(prompt);
      }

      return jsonDecode(response.body)['choices'][0]['message']['content'];
    } catch (e) {
      print('Error sending prompt: $e');
      rethrow;
    }
  }
}