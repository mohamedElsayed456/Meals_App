import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/Filters_screen.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/main_drawer.dart';


const kInitialFilters={
    Filter.glutenFree:false,
    Filter.lactosefree:false,
    Filter.vegeterian:false,
    Filter.vegan:false,
  };

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen>createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen>{
  int selectedpageindex=0;
  final List<Meal> favoriteMeals=[];
  Map<Filter,bool>selectFilters=kInitialFilters;

  void showInfoMessage(String message){
     ScaffoldMessenger.of(context).clearSnackBars();
     ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:Text(message)
        )
        );
  }

  void toggleMealFavoritestatus(Meal meal){
    final isExisting=favoriteMeals.contains(meal);

    if(isExisting){
      setState(() {
        favoriteMeals.remove(meal);
      });
      showInfoMessage('Meal is no longer a favorite');
    }
    else{
      setState(() {
        favoriteMeals.add(meal);
      });
      showInfoMessage('Marked as a favorite');
     }
  }

  void selectpage(int index){
    setState((){
      selectedpageindex=index;
    });
  }
  void setSCreen(String identifier)async{
    Navigator.of(context).pop();
    if(identifier=='Filters'){
        final result=await Navigator.of(context).push<Map<Filter,bool>>(
          MaterialPageRoute(
            builder:(ctx)=>FiltersScreen(currentFilters:selectFilters,),
          ),
          );
          setState(() {
            selectFilters = result?? kInitialFilters;
          });
    }
  }

  @override
  Widget build(BuildContext context){
   final availableMeals=dummyMeals.where((meal){
    if(selectFilters[Filter.glutenFree]! && !meal.isGlutenFree){
      return false;
    }
    if(selectFilters[Filter.lactosefree]! && !meal.isLactoseFree){
      return false;
    }
    if(selectFilters[Filter.vegeterian]! && !meal.isVegetarian){
      return false;
    }
    if(selectFilters[Filter.vegan]! && !meal.isVegan){
      return false;
    }
    return true;
   }).toList();

    Widget activePage = CategoriesScreen(
      onToggleFavorite: toggleMealFavoritestatus,
      availableMeals: availableMeals,
      );
    var activePageTitle='Categories';

    if(selectedpageindex==1){
      activePage = MealsScreen(
         meals:favoriteMeals,
         onToggleFavorite: toggleMealFavoritestatus,
         );
      activePageTitle='Your Favorites';
    }
    return Scaffold(
      appBar: AppBar(
        title:Text(activePageTitle),
      ),
       drawer:MainDrawer(onSelectScreen:setSCreen),

        body:activePage,
        bottomNavigationBar: BottomNavigationBar(
          onTap: selectpage,
          currentIndex: selectedpageindex ,
          items:const [
            BottomNavigationBarItem(
              icon: Icon(Icons.set_meal),
              label:'Categories' ,
              ),
              BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label:'Favorites' ,
              ),
          ],
       ),
    );
  }
}