import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../viewmodel/tasbih_controller.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TasbihController>();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 119, 210, 145),
      body: SafeArea(
        // Scroll menjaga tombol dapat dijangkau pada layar pendek/landscape.
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Langkah f semula: Text('0'). Langkah h: pantau nilai Rx.
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Obx(() => Text(
                          '${controller.counter.value.round()}',
                          key: const Key('counter'),
                          style: const TextStyle(fontSize: 250),
                        )),
                      ),
                    ),
                    Obx(() => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: LinearProgressIndicator(
                        key: const Key('progress'),
                        value: controller.progress.value / 100,
                        backgroundColor: Colors.white54,
                        color: Colors.amberAccent.shade400,
                        minHeight: 15,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    )),
                    const SizedBox(height: 75),
                    // Langkah i: tombol dihubungkan ke metode controller.
                    Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        key: const Key('increment'),
                        onTap: controller.incrementCounter,
                        child: const Padding(
                          padding: EdgeInsets.all(30),
                          child: Icon(Icons.fingerprint, size: 100,
                            semanticLabel: 'Tambah hitungan tasbih'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key('reset'),
        onPressed: controller.resetCounter,
        tooltip: 'Reset hitungan',
        backgroundColor: Colors.white,
        child: const Icon(Icons.refresh_outlined, color: Colors.black),
      ),
    );
  }
}
