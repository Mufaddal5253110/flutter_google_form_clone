import 'package:google_form_clone/Models/FormData.dart';

class FormList {
  String title;
  String description;
  List<FormData> formList;

  FormList({
    required this.title,
    required this.description,
    required this.formList,
  });
}
