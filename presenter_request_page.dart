import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../services/auth_exceptionHandler.dart';
import '../../services/firebase_services.dart';

class PresenterRequestPage extends StatelessWidget {
  PresenterRequestPage({Key? key}) : super(key: key);
  // create key state for form builder
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(title: const Text("Presenter request page")),
      body: FormBuilder(
        key: _fbKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                // dropdown list from clubs collection
                FormBuilderImagePicker(
                  name: "image",
                  decoration: InputDecoration(labelText: "Course Image"),
                  imageQuality: 50,
                  maxImages: 1,
                ),
                SizedBox(height: 10),
                FutureBuilder<List<QueryDocumentSnapshot<Object?>>>(
                    future: FirebaseServices().getClubs(),
                    builder: (context, snapshot) {
                      final supervisors = snapshot.data;
                      if (snapshot.hasData) {
                        return FormBuilderDropdown(
                          name: "club",
                          decoration: const InputDecoration(labelText: "Clubs"),
                          validator: FormBuilderValidators.compose(
                              [FormBuilderValidators.required()]),
                          items: supervisors!.map((e) {
                            return DropdownMenuItem(
                              value: e.id,
                              child: Text(e['name']),
                            );
                          }).toList(),
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }),
                SizedBox(height: 10),
                FormBuilderTextField(
                  name: "name",
                  decoration:
                      InputDecoration(labelText: "Training Course Name"),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
                SizedBox(height: 10),
                FormBuilderTextField(
                  name: "topic",
                  decoration: InputDecoration(labelText: "Training Topic"),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
                SizedBox(height: 10),
                FormBuilderTextField(
                  name: "hours",
                  decoration: InputDecoration(labelText: "Hours of Training"),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.numeric(),
                  ]),
                ),
                SizedBox(height: 10),
                FormBuilderTextField(
                  name: "attendee",
                  decoration: InputDecoration(labelText: "Attendees number"),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.numeric(),
                  ]),
                ),
                SizedBox(height: 10),
                FutureBuilder<List<QueryDocumentSnapshot<Object?>>>(
                    future: FirebaseServices().getLocations(),
                    builder: (context, snapshot) {
                      final supervisors = snapshot.data;
                      if (snapshot.hasData) {
                        return FormBuilderDropdown(
                          name: "location",
                          decoration:
                              const InputDecoration(labelText: "Locations"),
                          validator: FormBuilderValidators.compose(
                              [FormBuilderValidators.required()]),
                          items: supervisors!.map((e) {
                            return DropdownMenuItem(
                              value: e.reference,
                              child: Text(e['name']),
                            );
                          }).toList(),
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }),
                SizedBox(height: 10),
                FormBuilderDateTimePicker(
                  name: "time",
                  inputType: InputType.time,
                  decoration: InputDecoration(labelText: "Time"),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
                // check box
                SizedBox(height: 10),
                FormBuilderDateRangePicker(
                  name: 'date_range',
                  firstDate: DateTime.now().add(Duration(days: 3)),
                  lastDate: DateTime(2030),
                  decoration: InputDecoration(
                    labelText: 'Date Range',
                    helperText: 'Helper text',
                    hintText: 'Hint text',
                  ),
                ),
                SizedBox(height: 10),
                FormBuilderCheckboxGroup(
                  name: "luxuries",
                  decoration: InputDecoration(labelText: "Luxuries"),
                  options: [
                    FormBuilderFieldOption(
                      value: 'Computer',
                      child: Text("Computer"),
                    ),
                    FormBuilderFieldOption(
                      value: 'Projector',
                      child: Text("Data Show"),
                    ),
                    FormBuilderFieldOption(
                      value: 'Other',
                      child: Text("Other"),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                FormBuilderTextField(
                  name: 'other',
                  decoration:
                      InputDecoration(labelText: 'If Other, please specify'),
                  validator: (val) {
                    if (_fbKey.currentState?.fields['luxuries']?.value ==
                            'Other' &&
                        (val == null || val.isEmpty)) {
                      return 'Kindly specify your Requirement';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                ButtonTheme(
                    minWidth: 180,
                    height: 50,
                    child: RaisedButton(
                      child: const Text('Submit',
                          style: TextStyle(color: Colors.black, fontSize: 16)),
                      onPressed: () async {
                        _fbKey.currentState?.save();
                        if (_fbKey.currentState!.validate()) {
                          // save data to FirebaseServecies
                          final state = await FirebaseServices()
                              .addNewCourse(_fbKey.currentState?.value);
                          if (state == AuthResultStatus.successful) {
                            Navigator.pop(context);
                          } else {
                            showTopSnackBar(
                              context,
                              CustomSnackBar.error(
                                message:
                                    "Something went wrong. Please check your credentials and try again",
                              ),
                            );
                          }
                        }
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.amber,
                      elevation: 5,
                    )),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
