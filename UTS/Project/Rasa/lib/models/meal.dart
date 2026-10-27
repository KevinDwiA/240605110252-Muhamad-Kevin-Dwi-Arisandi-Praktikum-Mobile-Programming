class Meal {
  final String id, name, image, category, area, instructions;
  final List<String> ingredients;
  const Meal({required this.id, required this.name, required this.image,
    this.category = '', this.area = '', this.instructions = '',
    this.ingredients = const []});

  factory Meal.fromJson(Map<String, dynamic> json) {
    final ingredients = <String>[];
    for (var i = 1; i <= 20; i++) {
      final ingredient = (json['strIngredient$i'] as String? ?? '').trim();
      final measure = (json['strMeasure$i'] as String? ?? '').trim();
      if (ingredient.isNotEmpty) {
        ingredients.add(measure.isEmpty ? ingredient : '$measure $ingredient');
      }
    }
    return Meal(id: json['idMeal'] as String, name: json['strMeal'] as String,
      image: json['strMealThumb'] as String? ?? '',
      category: json['strCategory'] as String? ?? '',
      area: json['strArea'] as String? ?? '',
      instructions: json['strInstructions'] as String? ?? '',
      ingredients: ingredients);
  }
}

class MealCategory {
  final String name, image;
  const MealCategory({required this.name, required this.image});
  factory MealCategory.fromJson(Map<String, dynamic> json) => MealCategory(
    name: json['strCategory'] as String,
    image: json['strCategoryThumb'] as String? ?? '');
}
