
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechController extends GetxController {
  final SpeechToText speech = SpeechToText();

  var isListening = false.obs;
  var text = "".obs;

  Future<void> startListening() async {
    bool available = await speech.initialize();

    if (available) {
      isListening.value = true;

      speech.listen(
        onResult: (result) {
          text.value = result.recognizedWords;
        },
      );
    }
  }

  void stopListening() {
    speech.stop();
    isListening.value = false;
  }
}