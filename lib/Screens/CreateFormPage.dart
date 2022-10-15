import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_form_clone/Global/Global.dart';
import 'package:google_form_clone/Models/FormData.dart';
import 'package:google_form_clone/Models/FormList.dart';
import 'package:google_form_clone/Screens/PreviewFormPage.dart';

class CreateFormPage extends StatefulWidget {
  const CreateFormPage({Key? key}) : super(key: key);

  @override
  State<CreateFormPage> createState() => _CreateFormPageState();
}

class _CreateFormPageState extends State<CreateFormPage> {
  List<FormData> _formList = [];
  String _formTitle = "Untitled Form";
  String _description = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Form"),
        actions: [
          if (_formList.length > 0)
            IconButton(
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();
                FormList newForm = FormList(
                    title: _formTitle,
                    description: _description,
                    formList: _formList);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => PreviewFormPage(form: newForm))));
              },
              icon: const Icon(Icons.remove_red_eye),
            ),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: Global.height(context) * 0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    FormData temp = FormData(
                      title: "Untitled Question",
                      formType: FormType.dropdown,
                      options: ["Option 1"],
                      selectedOption: "Option 1",
                    );
                    _formList.add(temp);
                    setState(() {});
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: const [
                          Icon(Icons.arrow_drop_down_circle),
                          SizedBox(width: 5),
                          Text("Dropdown")
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    FormData temp = FormData(
                      title: "Untitled Question",
                      formType: FormType.checkbox,
                      options: ["Option 1"],
                      selectedOption: "Option 1",
                    );
                    _formList.add(temp);
                    setState(() {});
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: const [
                          Icon(Icons.check_box),
                          SizedBox(width: 5),
                          Text("Checkboxes")
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: _formTitle,
                      style: const TextStyle(fontSize: 20),
                      decoration: const InputDecoration(hintText: "Form title"),
                      onChanged: (val) {
                        if (val.trim().isEmpty == true) {
                          _formTitle = "Untitled Form";
                        } else {
                          _formTitle = val;
                        }
                        setState(() {});
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(hintText: "Form description"),
                      onChanged: (val) {
                        if (val.trim().isNotEmpty == true) {
                          _description = val;
                          setState(() {});
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: _formList.length,
            padding: const EdgeInsets.all(20),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: ((context, index) {
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                  padding:const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _formList[index].formType == FormType.checkbox
                                ? "Checkboxes"
                                : "Dropdown",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _formList.removeAt(index);
                              setState(() {});
                            },
                            child: const Icon(Icons.delete),
                          )
                        ],
                      ),
                      TextFormField(
                        initialValue: _formList[index].title,
                        decoration: const InputDecoration(
                          hintText: "Question",
                        ),
                        onChanged: (val) {
                          if (val.trim().isNotEmpty == true) {
                            _formList[index].title = val.trim();
                          } else {
                            _formList[index].title = "Untitled Question";
                          }
                          setState(() {});
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(hintText: "Add Options"),
                        onFieldSubmitted: (val) {
                          if (!_formList[index].options.contains(val.trim())) {
                            _formList[index].options.add(val.trim());
                            setState(() {});
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          ..._formList[index]
                              .options
                              .map(
                                (e) => Row(
                                  children: [
                                    (_formList[index].formType ==
                                            FormType.checkbox)
                                        ? Checkbox(
                                            value: _formList[index]
                                                    .selectedOption ==
                                                e,
                                            onChanged: (val) {
                                              if (val == true) {
                                                _formList[index]
                                                    .selectedOption = e;
                                                setState(() {});
                                              }
                                            },
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0),
                                            child: Text(
                                                "${(_formList[index].options.indexOf(e) + 1)}. "),
                                          ),
                                    Text(e),
                                  ],
                                ),
                              )
                              .toList(),
                        ],
                      )
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
