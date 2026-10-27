import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../services/meal_api.dart';
import '../widgets/components.dart';
import 'meal_list_screen.dart';
import 'meal_detail_screen.dart';

class HomeData {
  final List<MealCategory> categories;
  final List<Meal> meals;
  const HomeData(this.categories, this.meals);
}
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  final api = MealApi();
  late Future<HomeData> result;
  @override
  void initState() { super.initState(); result = fetch(); }
  Future<HomeData> fetch() async {
    final values = await Future.wait<Object>([api.categories(), api.search('chicken')]);
    return HomeData(values[0] as List<MealCategory>, values[1] as List<Meal>);
  }
  void retry() => setState(() => result = fetch());
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('rasa.', style: TextStyle(fontSize: 30,
      fontWeight: FontWeight.w900, color: accent)), actions: [IconButton(
        tooltip: 'Cari resep', onPressed: () => Navigator.push(context,
          MaterialPageRoute<void>(builder: (_) => const MealListScreen())),
        icon: const Icon(Icons.search))]),
    body: FutureBuilder<HomeData>(future: result, builder: (context, snapshot) {
      if (snapshot.connectionState != ConnectionState.done) {
        return const Center(child: CircularProgressIndicator());
      }
      if (snapshot.hasError) return FailureView(error: snapshot.error!, retry: retry);
      final data = snapshot.data!;
      return Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 1000),
        child: RefreshIndicator(onRefresh: () async {
          final next = fetch(); setState(() => result = next);
          try { await next; } catch (_) { /* FutureBuilder displays the error. */ }
        }, child: ListView(physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32), children: [
            Container(padding: const EdgeInsets.all(24), decoration: BoxDecoration(
              color: const Color(0xFF243C30), borderRadius: BorderRadius.circular(26)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('DARI DAPUR DUNIA', style: TextStyle(color: Color(0xFFF0C38E),
                  letterSpacing: 2, fontSize: 11)),
                const SizedBox(height: 12),
                const Text('Temukan rasa,\nciptakan cerita.', style: TextStyle(color: Colors.white,
                  fontWeight: FontWeight.w800, fontSize: 30, height: 1.15)),
                const SizedBox(height: 12),
                const Text('Jelajahi resep untuk ide masak berikutnya.',
                  style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 20),
                FilledButton.icon(style: FilledButton.styleFrom(backgroundColor: const Color(0xFFF0C38E),
                  foregroundColor: ink), onPressed: () => Navigator.push(context,
                    MaterialPageRoute<void>(builder: (_) => const MealListScreen())),
                  icon: const Icon(Icons.explore_outlined), label: const Text('Mulai jelajah')),
              ])),
            const SizedBox(height: 28),
            const Text('Pilih seleramu', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 22)),
            const SizedBox(height: 14),
            SizedBox(height: 120, child: ListView.separated(scrollDirection: Axis.horizontal,
              itemCount: data.categories.length, separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, i) {
                final cat = data.categories[i];
                return SizedBox(width: 110, child: Material(color: Colors.white,
                  borderRadius: BorderRadius.circular(18), clipBehavior: Clip.antiAlias,
                  child: InkWell(onTap: () => Navigator.push(context, MaterialPageRoute<void>(
                    builder: (_) => MealListScreen(category: cat.name))),
                    child: Column(children: [SizedBox(height: 75, child: FoodImage(cat.image,
                      fit: BoxFit.contain)), Padding(padding: const EdgeInsets.all(8),
                      child: Text(cat.name, maxLines: 1, overflow: TextOverflow.ellipsis))]))));
              })),
            const SizedBox(height: 28),
            const Text('Inspirasi ayam', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 22)),
            const SizedBox(height: 14),
            ...data.meals.take(6).map((meal) => Padding(padding: const EdgeInsets.only(bottom: 14),
              child: Card(clipBehavior: Clip.antiAlias, margin: EdgeInsets.zero,
                child: InkWell(onTap: () => Navigator.push(context, MaterialPageRoute<void>(
                  builder: (_) => MealDetailScreen(id: meal.id))),
                  child: Row(children: [SizedBox(width: 100, height: 110, child: FoodImage(meal.image)),
                    Expanded(child: Padding(padding: const EdgeInsets.all(14), child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, children: [Text(meal.name,
                        maxLines: 2, overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 6), Text(meal.area, style: const TextStyle(color: accent))]))),
                    const Padding(padding: EdgeInsets.only(right: 12), child: Icon(Icons.arrow_forward_ios, size: 16)),
                  ]))))),
            const SizedBox(height: 12),
            const Text('Data dan foto dari TheMealDB API', textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54, fontSize: 12)),
          ]))));
    }));
}
