mixin LoginMixin {
  String? validatePassword(value) {
                //value = value ?? "";
                value ??= "";
                value = value.replaceAll(" ", ""); //validacion de espacios
                if (value.length < 8) {
                  return "Clave invalida";
                }
                return null; //esta funcion puede devolver un String o un null
              }

  String? validateEmail(value) {
                value ??= "";
                final bool isValid = RegExp(
                  r"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$",
                ).hasMatch(value);
                return !isValid ? "Email invalido" : null;
              }
}