import 'dart:convert';
import 'package:alenlachu_app/data/common/models/awareness/awareness_model.dart';
import 'package:http/http.dart' as http;

class AwarenessService {
  static const String baseUrl =
      'http://192.168.7.212:3000'; // Replace with your backend base URL

  // Create an Awareness Entry
  Future<AwarenessModel> createAwareness(AwarenessModel awareness) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/awareness'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(awareness.toJson()),
    );

    if (response.statusCode == 201) {
      return AwarenessModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create awareness entry');
    }
  }

  // Get All Awareness Entries
  Future<List<AwarenessModel>> getAwarenessEntries() async {
    final response = await http.get(Uri.parse('$baseUrl/api/awareness'));

    if (response.statusCode == 200) {
      Iterable list = jsonDecode(response.body);
      return list.map((model) => AwarenessModel.fromJson(model)).toList();
    } else {
      throw Exception('Failed to load awareness entries');
    }
  }

  // Get Awareness Entry by ID
  Future<AwarenessModel> getAwarenessById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/api/awareness/$id'));

    if (response.statusCode == 200) {
      return AwarenessModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get awareness entry');
    }
  }

  // Update Awareness Entry
  Future<AwarenessModel> updateAwareness(
      AwarenessModel updatedAwareness) async {
    final response = await http.put(
      Uri.parse('$baseUrl/api/awareness/${updatedAwareness.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(updatedAwareness.toJson()),
    );

    if (response.statusCode == 200) {
      return AwarenessModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update awareness entry');
    }
  }

  // Delete Awareness Entry
  Future<void> deleteAwareness(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/api/awareness/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete awareness entry');
    }
  }
}
