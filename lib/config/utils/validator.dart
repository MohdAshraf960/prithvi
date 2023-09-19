class Validator{
  static String? requiredValidator
    (String? value){
      if(value == null || value.isEmpty){
        return "This field is required";
      }
      return null;
    }
} 