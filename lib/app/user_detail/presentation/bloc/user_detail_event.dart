sealed class UserDetailEvent {}
 
 final class GetUsersEvent extends UserDetailEvent {
   GetUsersEvent();
 }
 
 final class UserLogoutEvent extends UserDetailEvent {
   UserLogoutEvent();
 }