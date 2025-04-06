import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_health/app/data/service/posture_monitoring_service.dart';


class PostureTrackerController extends GetxController {
  // Instantiate the enhanced posture service.
  final PostureMonitoringService _monitoringService = PostureMonitoringService();

  // Reactive variables for the UI.
  final Rx<Color> uiColor = const Color(0xFF30BFC7).obs;
  final RxBool postureValid = true.obs;
  final RxDouble qualityScore = 100.0.obs;
  final RxInt goodTime = 0.obs;
  final RxInt badTime = 0.obs;

  Timer? _metricUpdateTimer;

  @override
  void onInit() {
    super.onInit();
    
    // Start the posture monitoring.
    _monitoringService.beginMonitoring();

    // Listen to the UI color updates.
    _monitoringService.uiColorStream.listen((color) {
      uiColor.value = color;
    });

    // Listen to posture validity updates.
    _monitoringService.postureValidityStream.listen((isValid) {
      postureValid.value = isValid;
    });

    // Listen to quality score updates.
    _monitoringService.qualityScoreStream.listen((score) {
      qualityScore.value = score;
    });

    // Update posture metrics (goodTime and badTime) periodically.
    _metricUpdateTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      final metrics = _monitoringService.getPostureMetrics();
      goodTime.value = metrics['goodTime'] ?? 0;
      badTime.value = metrics['badTime'] ?? 0;
    });
  }

  @override
  void onClose() {
    _metricUpdateTimer?.cancel();
    _monitoringService.dispose();
    super.onClose();
  }
}
