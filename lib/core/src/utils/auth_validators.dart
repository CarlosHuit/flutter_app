
class StatusValidator {
  final bool hasError;
  final String error;
  StatusValidator({this.hasError, this.error});
}


class AuthValidators {




  static StatusValidator validateFirstName(String firstName) {

    bool isValid = firstName.trim().length >= 3;
    
    if ( !isValid ) {
      return StatusValidator(
        hasError: true,
        error: 'Tu nombre debe tener al menos 3 caracteres'
      );
    }

    return StatusValidator(hasError: false, error: '');
  }


  static StatusValidator validateLastName(String lastName) {

    bool isValid = lastName.trim().length >= 3;
    
    if ( !isValid ) {

      return StatusValidator(
        hasError: true,
        error: 'Tu apellido debe tener al menos 3 caracteres'
      );

    }

    return StatusValidator(hasError: false, error: '');
  }


  static StatusValidator validateEmail( String email ) {

    final RegExp emailPattern = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    final bool isValidEmail = emailPattern.hasMatch(email.trim());

    if ( !isValidEmail )
      return StatusValidator(hasError: true, error: 'Ingresa un correo electrónico válido');
    
    return StatusValidator(hasError: false, error: '');

  }


  static StatusValidator validatePassword(String password) {

    final RegExp pattern = new RegExp(r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?!.*\s).*$', caseSensitive: true );
    final bool meetsPattern = pattern.hasMatch(password.trim());
    final bool hasMinLength = password.trim().length >= 8;


    if (!meetsPattern && !hasMinLength)
      return StatusValidator(hasError:  true, error: 'Al menos 8 caracteres, una letra mayúscula y un número');
    

    if (!meetsPattern && hasMinLength)
      return StatusValidator(hasError:  true, error: 'Al menos una letra mayúscula y un número');


    if (meetsPattern && !hasMinLength)
      return StatusValidator(hasError:  true, error: 'Al menos 8 caracteres');


    return StatusValidator(hasError: false, error: '');
  }


  static StatusValidator validatePasswordValidator(String password, String passwordValidator) {

    final bool areEquals = password == passwordValidator;

    if ( !areEquals )
      return StatusValidator(hasError: true, error: 'Las contraseñas no coinciden, vuelve a intentarlo');

    return StatusValidator(hasError: false, error: '');

  }
  



}