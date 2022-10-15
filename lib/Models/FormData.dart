enum FormType {
  checkbox,
  dropdown,
}

class FormData {
  FormType formType;
  List<String> options;
  String title;
  String selectedOption;

  FormData({
    required this.title,
    required this.formType,
    required this.options,
    required this.selectedOption,
  });
}
