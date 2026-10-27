import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../services/meal_api.dart';
import '../widgets/components.dart';

class MealDetailScreen extends StatefulWidget {
  final String id;
  const MealDetailScreen({super.key, required this.id});
  @override
  State<MealDetailScreen> createState() => _MealDetailScreenState();
}
class _MealDetailScreenState extends State<MealDetailScreen> {
  late Future<Meal> result;
  @override
  void initState() { super.initState(); result = MealApi().detail(widget.id); }
  void retry() => setState(() => result = MealApi().detail(widget.id));
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Detail resep')),
    body: FutureBuilder<Meal>(future: result, builder: (context, snapshot) {
      if (snapshot.connectionState != ConnectionState.done) {
        return const Center(child: CircularProgressIndicator());
      }
      if (snapshot.hasError) return FailureView(error: snapshot.error!, retry: retry);
      final meal = snapshot.data!;
      return Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 800),
        child: ListView(padding: const EdgeInsets.fromLTRB(20, 8, 20, 32), children: [
          ClipRRect(borderRadius: BorderRadius.circular(24),
            child: AspectRatio(aspectRatio: 1.5, child: FoodImage(meal.image))),
          const SizedBox(height: 24),
          Text(meal.name, style: Theme.of(context).textTheme.headlineMedium
            ?.copyWith(fontWeight: FontWeight.w800, color: ink)),
          const SizedBox(height: 12),
          Wrap(spacing: 8, children: [if (meal.category.isNotEmpty)
            Chip(avatar: const Icon(Icons.restaurant_menu, size: 16), label: Text(meal.category)),
            if (meal.area.isNotEmpty) Chip(avatar: const Icon(Icons.public, size: 16),
              label: Text(meal.area))]),
          const SizedBox(height: 20),
          const Text('Bahan-bahan', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          if (meal.ingredients.isEmpty) const Text('Bahan belum tersedia.'),
          ...meal.ingredients.map((ingredient) => Padding(padding: const EdgeInsets.only(bottom: 10),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Icon(Icons.check_circle_outline, size: 20, color: accent),
              const SizedBox(width: 10), Expanded(child: Text(ingredient))]))),
          const SizedBox(height: 24),
          const Text('Cara memasak', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          SelectableText(meal.instructions.trim().isEmpty ? 'Instruksi belum tersedia.'
            : meal.instructions, style: const TextStyle(height: 1.7, fontSize: 16)),
          const SizedBox(height: 24),
          const Text('Resep dan foto: TheMealDB. Isi resep mengikuti bahasa sumber (Inggris).',
            style: TextStyle(fontSize: 12, color: Colors.black54)),
        ])));
    }));
}
