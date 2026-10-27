import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../services/meal_api.dart';
import '../widgets/components.dart';
import 'meal_detail_screen.dart';

class MealListScreen extends StatefulWidget {
  final String? category;
  const MealListScreen({super.key, this.category});
  @override
  State<MealListScreen> createState() => _MealListScreenState();
}
class _MealListScreenState extends State<MealListScreen> {
  final api = MealApi();
  final searchController = TextEditingController();
  late Future<List<Meal>> result;
  String query = '';
  @override
  void initState() { super.initState(); result = fetch(); }
  Future<List<Meal>> fetch() async {
    if (widget.category == null) return api.search(query.isEmpty ? 'chicken' : query);
    // category results have no instructions: detail always requests lookup.php.
    final meals = await api.byCategory(widget.category!);
    return query.isEmpty ? meals : meals.where((meal) =>
      meal.name.toLowerCase().contains(query.toLowerCase())).toList();
  }
  void load() => setState(() => result = fetch());
  @override
  void dispose() { searchController.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(widget.category ?? 'Cari resep')),
    body: Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 1000),
      child: Column(children: [
        Padding(padding: const EdgeInsets.fromLTRB(20, 12, 20, 0), child: TextField(
          controller: searchController, textInputAction: TextInputAction.search,
          onSubmitted: (value) { query = value.trim(); load(); },
          decoration: InputDecoration(hintText: 'Cari nama resep (bahasa Inggris)',
            suffixIcon: IconButton(tooltip: 'Cari', icon: const Icon(Icons.search),
              onPressed: () { query = searchController.text.trim(); load(); })))),
        if (widget.category != null) const Padding(padding: EdgeInsets.all(12),
          child: Text('Pencarian dibatasi pada kategori ini.')),
        Expanded(child: FutureBuilder<List<Meal>>(future: result, builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) return FailureView(error: snapshot.error!, retry: load);
          final meals = snapshot.data ?? [];
          if (meals.isEmpty) return const Center(child: Text('Resep tidak ditemukan. Coba kata lain.'));
          return RecipeGrid(meals: meals, onTap: (meal) => Navigator.push(context,
            MaterialPageRoute<void>(builder: (_) => MealDetailScreen(id: meal.id))));
        })),
      ]))));
}
