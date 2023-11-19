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


class AddFavoriteState extends AppStates{}
class RemoveFavoriteState extends AppStates{}

class UserDataLoadingState extends AppStates{}
class UserDataSuccessState extends AppStates{}
class UserDataErrorState extends AppStates{
  final String error;
  UserDataErrorState(this.error);
}

class ImageProfileSuccessState extends AppStates{}
class ImageProfileErrorState extends AppStates{}




