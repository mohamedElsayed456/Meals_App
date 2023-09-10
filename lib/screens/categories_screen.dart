import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget{
  const CategoriesScreen({
    super.key,
    required this.onToggleFavorite,
    required this.availableMeals,
    });

  final void Function(Meal meal) onToggleFavorite;
  final List<Meal>availableMeals;


  void selectCategory(BuildContext context,Category category){
    final filteredMeals = availableMeals.where((meal) => meal.categories.contains(category.id)).toList();

    Navigator.of(context).push(
        MaterialPageRoute(
      builder:(ctx)=>MealsScreen(
        title:category.title,
        meals:filteredMeals,
        onToggleFavorite: onToggleFavorite,
        ), 
       ),
     );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
        padding:const EdgeInsets.all(20),
        gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:2,
          childAspectRatio: 3/2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          ),
          children: [
              // availableCategories.map((category) => CategoryGridItem(category: category)).toList()
            for(final category in availableCategories)
              CategoryGridItem(
                category: category,
                onSelectCategory:(){
                  selectCategory(context, category);
                },
              ),
          ],
    );
  }
}