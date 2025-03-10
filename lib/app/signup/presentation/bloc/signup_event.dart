sealed class SignupEvent {}
 
 final class UserNameChangedEvent extends SignupEvent {
   final String name;
   UserNameChangedEvent({required this.name});
 }
 
 final class UserEmailChangedEvent extends SignupEvent {
   final String email;
   UserEmailChangedEvent({required this.email});
 }
 
 final class UserPasswordChangedEvent extends SignupEvent {
   final String password;
   UserPasswordChangedEvent({required this.password});
 }
 
 final class UserUrlImageChangedEvent extends SignupEvent {
   final String image;
   UserUrlImageChangedEvent({required this.image});
 }
 
 final class UserSubmitEvent extends SignupEvent {
   UserSubmitEvent();
 }
 
 final class GetUserEvent extends SignupEvent {
   final String id;
   GetUserEvent(this.id);
 }