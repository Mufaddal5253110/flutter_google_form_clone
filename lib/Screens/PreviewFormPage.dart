import 'package:flutter/material.dart';
import 'package:google_form_clone/Global/Global.dart';
import 'package:google_form_clone/Models/FormData.dart';
import 'package:google_form_clone/Models/FormList.dart';

class PreviewFormPage extends StatefulWidget {
  final FormList form;
  const PreviewFormPage({
    Key? key,
    required this.form,
  }) : super(key: key);

  @override
  State<PreviewFormPage> createState() => _PreviewFormPageState();
}

class _PreviewFormPageState extends State<PreviewFormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Form Preview"),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(Global.width(context) * 0.05),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                padding: const EdgeInsets.all(15.0),
                width: Global.width(context) * 0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.form.title,
                      style: const TextStyle(fontSize: 25),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      widget.form.description,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Column(
            children: widget.form.formList
                .map(
                  (formdata) => Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Container(
                      padding: const EdgeInsets.all(15.0),
                      width: Global.width(context) * 0.9,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            formdata.title,
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 10),
                          (formdata.formType == FormType.checkbox)
                              ? ListView(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    ...formdata.options
                                        .map(
                                          (op) => Row(
                                            children: [
                                              Checkbox(
                                                value:
                                                    formdata.selectedOption ==
                                                        op,
                                                onChanged: (val) {
                                                  if (val == true) {
                                                    formdata.selectedOption =
                                                        op;
                                                    setState(() {});
                                                  }
                                                },
                                              ),
                                              Text(op),
                                            ],
                                          ),
                                        )
                                        .toList(),
                                  ],
                                )
                              : DropdownButton(
                                  value: formdata.selectedOption,
                                  items: formdata.options
                                      .map(
                                        (e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(e),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (String? val) {
                                    formdata.selectedOption = val!;
                                    setState(() {});
                                  },
                                )
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
