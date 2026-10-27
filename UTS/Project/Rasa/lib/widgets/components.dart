import 'package:flutter/material.dart';
import '../models/meal.dart';

const accent = Color(0xFFB74423);
const ink = Color(0xFF242C28);

class FoodImage extends StatelessWidget {
  final String url;
  final BoxFit fit;
  const FoodImage(this.url, {super.key, this.fit = BoxFit.cover});
  @override
  Widget build(BuildContext context) => Image.network(url, fit: fit,
    width: double.infinity, height: double.infinity,
    loadingBuilder: (context, child, progress) => progress == null ? child
      : const ColoredBox(color: Color(0xFFF1E7DC), child: Center(
        child: SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2)))),
    errorBuilder: (_, __, ___) => const ColoredBox(color: Color(0xFFF1E7DC),
      child: Center(child: Icon(Icons.restaurant, size: 40, color: accent))));
}

class MealTile extends StatelessWidget {
  final Meal meal;
  final VoidCallback onTap;
  const MealTile({super.key, required this.meal, required this.onTap});
  @override
  Widget build(BuildContext context) => Card(
    clipBehavior: Clip.antiAlias, margin: EdgeInsets.zero,
    child: InkWell(onTap: onTap, child: Column(
      crossAxisAlignment: CrossAxisAlignment.start, children: [
        AspectRatio(aspectRatio: 1.4, child: FoodImage(meal.image)),
        Padding(padding: const EdgeInsets.all(12), child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(meal.name, maxLines: 2, overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
            const SizedBox(height: 6),
            Text(meal.area.isNotEmpty ? meal.area : 'Lihat resep',
              style: const TextStyle(color: accent, fontSize: 12)),
          ])),
      ])));
}

class FailureView extends StatelessWidget {
  final Object error;
  final VoidCallback retry;
  const FailureView({super.key, required this.error, required this.retry});
  @override
  Widget build(BuildContext context) => Center(child: Padding(
    padding: const EdgeInsets.all(24), child: Column(mainAxisSize: MainAxisSize.min,
    children: [const Icon(Icons.cloud_off_outlined, size: 44, color: accent),
      const SizedBox(height: 16), Text(error.toString(), textAlign: TextAlign.center),
      const SizedBox(height: 12), FilledButton(onPressed: retry, child: const Text('Coba lagi'))])));
}

class RecipeGrid extends StatelessWidget {
  final List<Meal> meals;
  final void Function(Meal) onTap;
  const RecipeGrid({super.key, required this.meals, required this.onTap});
  @override
  Widget build(BuildContext context) => LayoutBuilder(builder: (context, size) {
    final columns = size.maxWidth < 350 ? 1 : size.maxWidth < 650 ? 2 : 3;
    // Fixed extent grows with text scale rather than clipping large labels.
    final textScale = MediaQuery.textScalerOf(context).scale(16) / 16;
    final tileWidth = (size.maxWidth - 40 - (columns - 1) * 14) / columns;
    return GridView.builder(padding: const EdgeInsets.all(20),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: columns,
        crossAxisSpacing: 14, mainAxisSpacing: 14,
        mainAxisExtent: tileWidth / 1.4 + 40 + 60 * textScale),
      itemCount: meals.length, itemBuilder: (_, i) => MealTile(meal: meals[i],
        onTap: () => onTap(meals[i])));
  });
}
