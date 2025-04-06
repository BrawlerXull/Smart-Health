import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostureMonitoringService {
  // Stream controllers to broadcast posture validity, quality, and UI color updates.
  final StreamController<bool> _postureValidityController = StreamController<bool>.broadcast();
  final StreamController<double> _qualityScoreController = StreamController<double>.broadcast();
  final StreamController<Color> _uiColorController = StreamController<Color>.broadcast();

  Stream<bool> get postureValidityStream => _postureValidityController.stream;
  Stream<double> get qualityScoreStream => _qualityScoreController.stream;
  Stream<Color> get uiColorStream => _uiColorController.stream;

  // Internal state variables
  bool _isPostureValid = true;
  double _qualityScore = 100.0;
  int _goodPostureTime = 0;
  int _badPostureTime = 0;

  // Calibration reference values (default to Earth’s gravity on Z-axis)
  double _refX = 0.0;
  double _refY = 0.0;
  double _refZ = 9.8;
  bool _isCalibrated = false;

  // Tolerance thresholds for determining posture quality
  double _angleTolerance = 20.0;
  double _magnitudeTolerance = 1.5;

  // Current operation mode (sitting, standing, walking)
  String _mode = "sitting";

  // Subscriptions and timers
  StreamSubscription<AccelerometerEvent>? _sensorSubscription;
  Timer? _minuteTimer;

  // UI colors for feedback
  final Color _colorGood = const Color(0xFF30BFC7);
  final Color _colorBad = const Color(0xFFE57373);

  // Buffer for accelerometer events for filtering purposes
  final List<Vector3> _dataBuffer = [];
  final int _bufferLimit = 15;

  /// Begins monitoring the accelerometer for posture changes.
  Future<void> beginMonitoring() async {
    await _loadCalibrationData();

    try {
      _sensorSubscription = accelerometerEvents.listen(
        (AccelerometerEvent event) {
          _processSensorData(event);
        },
        onError: (error) {
          print("Sensor error: $error");
        },
      );
    } catch (e) {
      print("Error initializing sensor: $e");
    }

    // Update posture duration counters every minute.
    _minuteTimer = Timer.periodic(const Duration(minutes: 1), (_) {
      if (_isPostureValid) {
        _goodPostureTime++;
      } else {
        _badPostureTime++;
      }
    });

    // Set initial UI color.
    _uiColorController.add(_colorGood);
  }

  /// Runs calibration for the given [mode] (e.g., "sitting").
  Future<void> runCalibration(String mode) async {
    _mode = mode;
    List<AccelerometerEvent> samples = [];
    int sampleCount = 30; // Collect about 3 seconds of data.
    Completer<void> calibrationCompleter = Completer<void>();

    late StreamSubscription<AccelerometerEvent> calibrationSub;
    calibrationSub = accelerometerEvents.listen((event) {
      samples.add(event);
      if (samples.length >= sampleCount) {
        calibrationSub.cancel();
        calibrationCompleter.complete();
      }
    });

    await calibrationCompleter.future;

    // Use median values as the reference posture.
    samples.sort((a, b) => a.x.compareTo(b.x));
    _refX = samples[samples.length ~/ 2].x;

    samples.sort((a, b) => a.y.compareTo(b.y));
    _refY = samples[samples.length ~/ 2].y;

    samples.sort((a, b) => a.z.compareTo(b.z));
    _refZ = samples[samples.length ~/ 2].z;

    _isCalibrated = true;
    await _saveCalibrationData();
  }

  /// Processes incoming accelerometer data.
  void _processSensorData(AccelerometerEvent event) {
    if (!_isCalibrated) return;

    _dataBuffer.add(Vector3(event.x, event.y, event.z));
    if (_dataBuffer.length > _bufferLimit) {
      _dataBuffer.removeAt(0);
    }

    // Apply median filter to reduce noise.
    Vector3 filtered = _applyMedianFilter();

    // Compute differences relative to calibrated reference.
    double angleDiff = _computeAngleDifference(filtered.x, filtered.y, filtered.z);
    double magnitudeDiff = _computeMagnitudeDifference(filtered.x, filtered.y, filtered.z);

    // Convert differences into quality percentages.
    double angleQuality = 100 - (angleDiff / _angleTolerance * 100).clamp(0.0, 100.0);
    double magnitudeQuality = 100 - (magnitudeDiff / _magnitudeTolerance * 100).clamp(0.0, 100.0);

    // Combine using a weighted sum.
    double newScore = (angleQuality * 0.7) + (magnitudeQuality * 0.3);
    // Smooth the quality score with previous value.
    _qualityScore = _qualityScore * 0.7 + newScore * 0.3;

    // Determine threshold based on the current mode.
    double threshold = _mode == "standing"
        ? 75.0
        : _mode == "walking"
            ? 65.0
            : 70.0;

    bool validPosture = _qualityScore >= threshold;
    if (validPosture != _isPostureValid) {
      _isPostureValid = validPosture;
      _postureValidityController.add(_isPostureValid);
      _uiColorController.add(_isPostureValid ? _colorGood : _colorBad);
    }

    _qualityScoreController.add(_qualityScore);
  }

  /// Computes the angle difference between the current reading and the reference.
  double _computeAngleDifference(double x, double y, double z) {
    Vector3 currentVec = Vector3(x, y, z).normalized();
    Vector3 refVec = Vector3(_refX, _refY, _refZ).normalized();
    double dotProd = (currentVec.x * refVec.x) + (currentVec.y * refVec.y) + (currentVec.z * refVec.z);
    dotProd = dotProd.clamp(-1.0, 1.0);
    double radians = math.acos(dotProd);
    return radians * 180 / math.pi;
  }

  /// Computes the absolute difference in magnitude between the current and reference vectors.
  double _computeMagnitudeDifference(double x, double y, double z) {
    double currentMag = math.sqrt(x * x + y * y + z * z);
    double refMag = math.sqrt(_refX * _refX + _refY * _refY + _refZ * _refZ);
    return (currentMag - refMag).abs();
  }

  /// Applies a median filter on the buffered sensor data.
  Vector3 _applyMedianFilter() {
    if (_dataBuffer.isEmpty) return Vector3(0, 0, 0);
    List<double> xs = _dataBuffer.map((v) => v.x).toList()..sort();
    List<double> ys = _dataBuffer.map((v) => v.y).toList()..sort();
    List<double> zs = _dataBuffer.map((v) => v.z).toList()..sort();
    int mid = _dataBuffer.length ~/ 2;
    return Vector3(xs[mid], ys[mid], zs[mid]);
  }

  /// Saves calibration data persistently.
  Future<void> _saveCalibrationData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('refX', _refX);
    await prefs.setDouble('refY', _refY);
    await prefs.setDouble('refZ', _refZ);
    await prefs.setString('mode', _mode);
    await prefs.setBool('calibrated', true);
  }

  /// Loads previously saved calibration data.
  Future<void> _loadCalibrationData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isCalibrated = prefs.getBool('calibrated') ?? false;
    if (_isCalibrated) {
      _refX = prefs.getDouble('refX') ?? 0.0;
      _refY = prefs.getDouble('refY') ?? 0.0;
      _refZ = prefs.getDouble('refZ') ?? 9.8;
      _mode = prefs.getString('mode') ?? "sitting";

      // Adjust tolerances based on the mode.
      if (_mode == "sitting") {
        _angleTolerance = 15.0;
        _magnitudeTolerance = 1.0;
      } else if (_mode == "standing") {
        _angleTolerance = 10.0;
        _magnitudeTolerance = 0.8;
      } else if (_mode == "walking") {
        _angleTolerance = 25.0;
        _magnitudeTolerance = 2.5;
      }
    }
  }

  /// Returns a summary of the current posture metrics.
  Map<String, dynamic> getPostureMetrics() {
    return {
      'postureValid': _isPostureValid,
      'qualityScore': _qualityScore,
      'goodTime': _goodPostureTime,
      'badTime': _badPostureTime,
      'calibrated': _isCalibrated,
      'mode': _mode,
    };
  }

  /// Clean up subscriptions and controllers.
  void dispose() {
    _sensorSubscription?.cancel();
    _minuteTimer?.cancel();
    _postureValidityController.close();
    _qualityScoreController.close();
    _uiColorController.close();
  }
}

/// Simple 3D vector class with a normalization helper.
class Vector3 {
  final double x, y, z;
  Vector3(this.x, this.y, this.z);

  double get length => math.sqrt(x * x + y * y + z * z);

  Vector3 normalized() {
    double len = length;
    if (len > 0) {
      return Vector3(x / len, y / len, z / len);
    }
    return Vector3(0, 0, 0);
  }
}
