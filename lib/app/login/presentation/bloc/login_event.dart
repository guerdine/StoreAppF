sealed class LoginEvent {}


class EmailChangedEvent extends LoginEvent{
  final String email;
  EmailChangedEvent({required this.email});
}

class PasswordChangedEvent extends LoginEvent{
  final String password;
  PasswordChangedEvent({required this.password});
}

class SubmitEvent extends LoginEvent{
  SubmitEvent();
}