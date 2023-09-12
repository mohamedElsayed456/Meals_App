import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/favorites_provider.dart';
import 'package:meals_app/providers/filters_provider.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/main_drawer.dart';


const kInitialFilters = {
    Filter.glutenFree:false,
    Filter.lactosefree:false,
    Filter.vegeterian:false,
    Filter.vegan:false,
  };

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen>createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen>{
  int selectedpageindex=0;

  void selectpage(int index){
    setState((){
      selectedpageindex=index;
    });
  }
  void setSCreen(String identifier)async{
    Navigator.of(context).pop();
    if(identifier=='Filters'){
         await Navigator.of(context).push<Map<Filter,bool>>(
          MaterialPageRoute(
            builder:(ctx)=>const FiltersScreen(),
          ),
       );
    }
  }

  @override
  Widget build(BuildContext context){
   final availableMeals = ref.watch(favoritesMealsProvider);

    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
      );
    var activePageTitle='Categories';

    if(selectedpageindex==1){
      final favoriteMeals=ref.watch(favoritesMealsProvider);
      activePage = MealsScreen(
         meals:favoriteMeals,
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