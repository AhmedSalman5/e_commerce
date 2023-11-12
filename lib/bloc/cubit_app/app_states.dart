abstract class AppStates {}

class AppInitialState extends AppStates {}

class CategoriesLoadingState extends AppStates {}

class CategoriesSuccessState extends AppStates {}

class CategoriesErrorState extends AppStates {
  final String error;
  CategoriesErrorState(this.error);
}
class ChangeFavoriteProduct extends AppStates{}

 class MinusItemCounter extends AppStates{}
 class PlusItemCounter extends AppStates{}
 class RatingItemCounter extends AppStates{}


 class AddCartLisState extends AppStates{}
 class RemoveCartLisState extends AppStates{}
// class CategoriesLoadingState extends AppStates{}
// class CategoriesLoadingState extends AppStates{}
// class CategoriesLoadingState extends AppStates{}

