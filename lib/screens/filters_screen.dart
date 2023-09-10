import 'package:flutter/material.dart';
// import 'package:meals_app/screens/tabs_screen.dart';
// import 'package:meals_app/widgets/main_drawer.dart';

enum Filter{
  glutenFree,
  lactosefree,
  vegeterian,
  vegan,
}

class FiltersScreen extends StatefulWidget{
  const FiltersScreen({super.key,required this.currentFilters});

  final Map<Filter,bool>currentFilters;

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
var glutenFreeFilterSet=false;
var lactoseFreeFilterSet=false;
var vegeterianFilterSet=false;
var veganFilterSet=false;

@override
  void initState() {
    glutenFreeFilterSet=widget.currentFilters[Filter.glutenFree]!;
    lactoseFreeFilterSet=widget.currentFilters[Filter.lactosefree]!;
    vegeterianFilterSet=widget.currentFilters[Filter.vegeterian]!;
    veganFilterSet=widget.currentFilters[Filter.vegan]!;
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Your Filters'),
      ),
      // drawer:MainDrawer(
      //     onSelectScreen:(identifier){
      //     Navigator.of(context).pop();
      //     if(identifier=='meals'){
      //    Navigator.of(context).push(
      //     MaterialPageRoute(
      //       builder:(ctx)=>const TabsScreen(),
      //      ),
      //     );
      //    }
      //   }
      // ),
      body:WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop({
            Filter.glutenFree:glutenFreeFilterSet,
            Filter.lactosefree:lactoseFreeFilterSet,
            Filter.vegeterian:vegeterianFilterSet,
            Filter.vegan:veganFilterSet,
          });
          return false;
        },
        child: Column(
          children:[
            SwitchListTile(
              value:glutenFreeFilterSet,
              onChanged:(isChecked){
                setState((){
                  glutenFreeFilterSet = isChecked;
                });
              },
              title: Text(
                'Gluten-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                   color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              subtitle: Text(
                'Only include gluten-free meals. ',
                 style: Theme.of(context).textTheme.labelMedium!.copyWith(
                   color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              activeColor:Theme.of(context).colorScheme.tertiary,
              contentPadding:const EdgeInsets.only(left: 34,right: 22),
              ),
      
              SwitchListTile(
              value:lactoseFreeFilterSet,
              onChanged:(isChecked){
                setState((){
                  lactoseFreeFilterSet = isChecked;
                });
              },
              title: Text(
                'Lactose-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                   color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              subtitle: Text(
                'Only include lactose-free meals. ',
                 style: Theme.of(context).textTheme.labelMedium!.copyWith(
                   color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              activeColor:Theme.of(context).colorScheme.tertiary,
              contentPadding:const EdgeInsets.only(left: 34,right: 22),
              ),
      
              SwitchListTile(
              value:vegeterianFilterSet,
              onChanged:(isChecked){
                setState((){
                  vegeterianFilterSet = isChecked;
                });
              },
              title: Text(
                'Vegeterian',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                   color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              subtitle:Text(
                'Only include vegeterian meals.',
                 style: Theme.of(context).textTheme.labelMedium!.copyWith(
                   color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              activeColor:Theme.of(context).colorScheme.tertiary,
              contentPadding:const EdgeInsets.only(left: 34,right: 22),
              ),
      
              SwitchListTile(
              value:veganFilterSet,
              onChanged:(isChecked){
                setState((){
                  veganFilterSet = isChecked;
                });
              },
              title: Text(
                'Vegen',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                   color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              subtitle:Text(
                'Only include vegan meals. ',
                 style:Theme.of(context).textTheme.labelMedium!.copyWith(
                   color:Theme.of(context).colorScheme.onBackground,
                ),
              ),
              activeColor:Theme.of(context).colorScheme.tertiary,
              contentPadding:const EdgeInsets.only(left: 34,right: 22),
              ),
          ],
        ),
      ),
    );
  }
}