import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

class MediBuddyController extends GetxController {
  var script = ''.obs;
  var isGenerating = false.obs;
  final FlutterTts flutterTts = FlutterTts();

  void generateScript(String theme) async {
    isGenerating.value = true;
    await Future.delayed(Duration(seconds: 1)); // Simulate processing
    script.value = """<speak>
          <prosody rate='medium' pitch='medium'>
            Breathe deeply for the next 10 seconds.
            <break time='10s'/>
            Now, gently transition into a meditative state for the next 5 seconds.
            <break time='5s'/>
            Close your eyes and take a deep breath. Imagine yourself in a serene environment, feeling completely at peace.
          </prosody>
        </speak>""";
    isGenerating.value = false;
  }

  void speakText() async {
      await flutterTts.setLanguage("en-US");
      await flutterTts.setPitch(1.0);
      await flutterTts.speak(script.value);
    }
}
