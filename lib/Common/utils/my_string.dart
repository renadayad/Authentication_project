String validationEmail =
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

String validationName = r'^[a-z A-Z]+$';

String validationPassword =
    r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$";

// String validationNumber = r'(^(?:[+0]9)?[0-9]{10,12}$)';

String validationNumber = r'(?:\+?0*?966)?0?(5[0-9]{8})';
