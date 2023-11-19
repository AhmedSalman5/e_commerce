 abstract class AuthStates {}

 class AuthInitialState extends AuthStates {}

 class ChangeVisiblePasswordLogin extends AuthStates {}

 class ChangeVisiblePasswordSignUp extends AuthStates {}
 //----------------------------------------------------------------
 // Login & Register
 class LoginLoadingState extends AuthStates {}

 class LoginSuccessState extends AuthStates {
   final String uId;
   LoginSuccessState(this.uId);
 }

 class LoginErrorState extends AuthStates {
   final String error;
   LoginErrorState(this.error);
 }

 class RegisterLoadingState extends AuthStates {}

 class RegisterSuccessState extends AuthStates {
   final String uId;
   RegisterSuccessState(this.uId);
 }

 class RegisterErrorState extends AuthStates {
   final String error;
   RegisterErrorState(this.error);
 }

 //----------------------------------------------------------------

 // Create user
 class CreateUserLoadingState extends AuthStates {}

 class CreateUserSuccessState extends AuthStates {
   final String uId;
   CreateUserSuccessState(this.uId);
 }

 class CreateUserErrorState extends AuthStates {
   final String error;
   CreateUserErrorState(this.error);
 }
 //---------------------------------------------------------------------
 class SignOutState extends AuthStates{}
 class ErrorSignOutState extends AuthStates{
   final String error;
   ErrorSignOutState(this.error);
 }
//------------------------------------------------------------------------------
