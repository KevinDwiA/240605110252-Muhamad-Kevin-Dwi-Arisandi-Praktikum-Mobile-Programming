import 'package:flutter_test/flutter_test.dart';
import 'package:tasbih_getx/viewmodel/tasbih_controller.dart';

void main() {
  test('Hitungan berhenti di 33 dan progress maksimum 100 persen', () {
    final controller = TasbihController();
    for (var i = 0; i < 40; i++) {
      controller.incrementCounter();
    }
    expect(controller.counter.value, 33);
    expect(controller.progress.value, 100);
  });

  test('Reset dari hitungan sebagian mengembalikan kedua nilai ke nol', () {
    final controller = TasbihController();
    controller.incrementCounter();
    expect(controller.progress.value, closeTo(100 / 33, 0.0001));
    controller.resetCounter();
    expect(controller.counter.value, 0);
    expect(controller.progress.value, 0);
  });
}
