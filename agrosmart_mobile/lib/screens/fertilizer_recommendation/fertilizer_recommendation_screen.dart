import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/config/app_constants.dart';
import '../../app/routes/app_routes.dart';
import '../../app/theme/app_colors.dart';
import '../../core/utils/validators.dart';
import '../../core/widgets/app_drawer.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_card.dart';
import '../../core/widgets/custom_dropdown.dart';
import '../../core/widgets/custom_text_field.dart';
import '../../core/widgets/result_card.dart';
import '../../data/models/fertilizer_recommendation_model.dart';
import '../../providers/fertilizer_provider.dart';

class FertilizerRecommendationScreen extends StatefulWidget {
  const FertilizerRecommendationScreen({super.key});

  @override
  State<FertilizerRecommendationScreen> createState() => _FertilizerRecommendationScreenState();
}

class _FertilizerRecommendationScreenState extends State<FertilizerRecommendationScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedSoilType = AppConstants.soilTypes[0];
  String? _selectedCropType = AppConstants.cropTypes[0];

  final _tempController = TextEditingController(text: '26');
  final _humidityController = TextEditingController(text: '52');
  final _moistureController = TextEditingController(text: '38');
  final _nitrogenController = TextEditingController(text: '37');
  final _potassiumController = TextEditingController(text: '0');
  final _phosphorousController = TextEditingController(text: '0');

  @override
  void dispose() {
    _tempController.dispose();
    _humidityController.dispose();
    _moistureController.dispose();
    _nitrogenController.dispose();
    _potassiumController.dispose();
    _phosphorousController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate() && _selectedSoilType != null && _selectedCropType != null) {
      final req = FertilizerRecommendationRequest(
        temperature: double.parse(_tempController.text),
        humidity: double.parse(_humidityController.text),
        soilMoisture: double.parse(_moistureController.text),
        soilType: _selectedSoilType!,
        cropType: _selectedCropType!,
        nitrogen: double.parse(_nitrogenController.text),
        potassium: double.parse(_potassiumController.text),
        phosphorous: double.parse(_phosphorousController.text),
      );

      Provider.of<FertilizerProvider>(context, listen: false).recommendFertilizer(req);
    }
  }

  @override
  Widget build(BuildContext context) {
    final fertilizerProvider = Provider.of<FertilizerProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Fertilizer Recommendation'),
      ),
      drawer: const AppDrawer(currentRoute: AppRoutes.fertilizerRecommend),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Optimal Fertilizer Advice',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 6),
            const Text(
              'Get precise fertilizer recommendations based on soil type, crop requirements, and nutrient deficiencies.',
              style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 20),

            if (fertilizerProvider.result != null) ...[
              ResultCard(
                title: 'Recommended Fertilizer',
                icon: Icons.science,
                onReset: () => fertilizerProvider.reset(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'RECOMMENDED SOLUTION',
                            style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            fertilizerProvider.result!.recommendedFertilizer,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Application Guidance:',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 8),
                    _buildGuidelineItem('Apply in split doses during early morning or late evening.'),
                    _buildGuidelineItem('Ensure soil moisture is maintained before applying fertilizer.'),
                    _buildGuidelineItem('Combine with organic compost for enhanced soil structure.'),
                  ],
                ),
              ),
            ] else ...[
              CustomCard(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomDropdown<String>(
                        label: 'Soil Type',
                        value: _selectedSoilType,
                        items: AppConstants.soilTypes,
                        itemLabelBuilder: (item) => item,
                        onChanged: (val) => setState(() => _selectedSoilType = val),
                      ),
                      const SizedBox(height: 14),
                      CustomDropdown<String>(
                        label: 'Crop Type',
                        value: _selectedCropType,
                        items: AppConstants.cropTypes,
                        itemLabelBuilder: (item) => item,
                        onChanged: (val) => setState(() => _selectedCropType = val),
                      ),
                      const Divider(height: 32),
                      CustomTextField(
                        controller: _tempController,
                        label: 'Temperature',
                        suffixText: '°C',
                        keyboardType: TextInputType.number,
                        validator: FormValidators.validateTemperature,
                      ),
                      const SizedBox(height: 12),
                      CustomTextField(
                        controller: _humidityController,
                        label: 'Humidity',
                        suffixText: '%',
                        keyboardType: TextInputType.number,
                        validator: FormValidators.validateHumidity,
                      ),
                      const SizedBox(height: 12),
                      CustomTextField(
                        controller: _moistureController,
                        label: 'Soil Moisture',
                        suffixText: '%',
                        keyboardType: TextInputType.number,
                        validator: (v) => FormValidators.validateRange(v, 'Soil Moisture', 0, 100, '%'),
                      ),
                      const SizedBox(height: 12),
                      CustomTextField(
                        controller: _nitrogenController,
                        label: 'Nitrogen (N)',
                        suffixText: 'kg/ha',
                        keyboardType: TextInputType.number,
                        validator: FormValidators.validateNitrogen,
                      ),
                      const SizedBox(height: 12),
                      CustomTextField(
                        controller: _potassiumController,
                        label: 'Potassium (K)',
                        suffixText: 'kg/ha',
                        keyboardType: TextInputType.number,
                        validator: FormValidators.validatePotassium,
                      ),
                      const SizedBox(height: 12),
                      CustomTextField(
                        controller: _phosphorousController,
                        label: 'Phosphorous (P)',
                        suffixText: 'kg/ha',
                        keyboardType: TextInputType.number,
                        validator: FormValidators.validatePhosphorus,
                      ),
                      const SizedBox(height: 24),
                      CustomButton(
                        text: 'Get Fertilizer Advice',
                        icon: Icons.science,
                        isLoading: fertilizerProvider.isLoading,
                        onPressed: _submit,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildGuidelineItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: AppColors.primary, size: 18),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary))),
        ],
      ),
    );
  }
}
