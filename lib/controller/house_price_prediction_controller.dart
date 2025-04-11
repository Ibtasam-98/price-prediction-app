import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/app_colors.dart';

class HousePricePredictionController extends GetxController {
  var area = 1000.0.obs;
  var bedrooms = 2.obs;
  var bathrooms = 1.obs;
  var stories = 1.obs;
  var mainroad = 'yes'.obs;
  var guestroom = 'no'.obs;
  var basement = 'no'.obs;
  var hotwaterheating = 'no'.obs;
  var airconditioning = 'no'.obs;
  var parking = 1.obs;
  var prefarea = 'no'.obs;
  var furnishingstatus = 'furnished'.obs;
  var predictedPrice = 0.0.obs;
  var priceClassification = ''.obs; // Add price classification
  var isLoading = false.obs;
  var isPredicting = false.obs;

  Future<void> predictPrice(BuildContext context) async {
    if (area.value <= 0 ||
        bedrooms.value <= 0 ||
        bathrooms.value <= 0 ||
        stories.value <= 0 ||
        parking.value < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter valid values.')),
      );
      return;
    }

    isPredicting.value = true;

    final apiUrl = Uri.parse('http://127.0.0.1:5000/predict');
    try {
      print('API Request: ${jsonEncode({
        'area': area.value,
        'bedrooms': bedrooms.value,
        'bathrooms': bathrooms.value,
        'stories': stories.value,
        'mainroad_yes': mainroad.value == 'yes' ? 1 : 0,
        'guestroom_yes': guestroom.value == 'yes' ? 1 : 0,
        'basement_yes': basement.value == 'yes' ? 1 : 0,
        'hotwaterheating_yes': hotwaterheating.value == 'yes' ? 1 : 0,
        'airconditioning_yes': airconditioning.value == 'yes' ? 1 : 0,
        'parking': parking.value,
        'prefarea_yes': prefarea.value == 'yes' ? 1 : 0,
        'furnishing_choice': furnishingstatus.value == 'furnished'
            ? 0
            : furnishingstatus.value == 'semi-furnished'
            ? 1
            : 2,
      })}');
      final response = await http.post(
        apiUrl,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'area': area.value,
          'bedrooms': bedrooms.value,
          'bathrooms': bathrooms.value,
          'stories': stories.value,
          'mainroad_yes': mainroad.value == 'yes' ? 1 : 0,
          'guestroom_yes': guestroom.value == 'yes' ? 1 : 0,
          'basement_yes': basement.value == 'yes' ? 1 : 0,
          'hotwaterheating_yes': hotwaterheating.value == 'yes' ? 1 : 0,
          'airconditioning_yes': airconditioning.value == 'yes' ? 1 : 0,
          'parking': parking.value,
          'prefarea_yes': prefarea.value == 'yes' ? 1 : 0,
          'furnishing_choice': furnishingstatus.value == 'furnished'
              ? 0
              : furnishingstatus.value == 'semi-furnished'
              ? 1
              : 2,
        }),
      );
      print('API Response: ${response.body}');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        predictedPrice.value = data['predicted_price'];
        priceClassification.value = data['price_classification'];
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to fetch prediction: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      print('API Error: $e');
    } finally {
      Future.delayed(Duration(seconds: 5), () {
        isPredicting.value = false;
      });
    }
  }}
