import 'package:get/get.dart';

// Langkah g: logika terpisah dari tampilan; .obs membuat data reaktif.
class TasbihController extends GetxController {
  final counter = 0.0.obs;
  final progress = 0.0.obs;
  final double maxCount = 33;

  void incrementCounter() {
    if (counter.value < maxCount) {
      counter.value++;
      progress.value = (counter.value / maxCount) * 100;
    }
  }

  void resetCounter() {
    counter.value = 0;
    progress.value = 0;
  }
}
