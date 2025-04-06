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
            Take a deep breath and relax for the next 10 seconds, clearing your mind of distractions.
            <break time='10s'/>
            Now, gently shift your attention to the task ahead. Focus on the subject you're studying, and let your mind absorb the material for the next 5 seconds.
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
