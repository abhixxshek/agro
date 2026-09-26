class FertilizerRecommendationRequest {
  final double temperature;
  final double humidity;
  final double soilMoisture;
  final String soilType;
  final String cropType;
  final double nitrogen;
  final double potassium;
  final double phosphorous;

  FertilizerRecommendationRequest({
    required this.temperature,
    required this.humidity,
    required this.soilMoisture,
    required this.soilType,
    required this.cropType,
    required this.nitrogen,
    required this.potassium,
    required this.phosphorous,
  });

  Map<String, dynamic> toJson() {
    return {
      'temperature': temperature,
      'humidity': humidity,
      'soilMoisture': soilMoisture,
      'soilType': soilType,
      'cropType': cropType,
      'nitrogen': nitrogen,
      'potassium': potassium,
      'phosphorous': phosphorous,
    };
  }
}

class FertilizerRecommendationResponse {
  final String recommendedFertilizer;

  FertilizerRecommendationResponse({required this.recommendedFertilizer});

  factory FertilizerRecommendationResponse.fromJson(Map<String, dynamic> json) {
    return FertilizerRecommendationResponse(
      recommendedFertilizer: json['recommended_fertilizer'] ?? json['recommendation'] ?? 'Unknown',
    );
  }
}
