import 'package:app/services/auth_exceptionHandler.dart';
import 'package:app/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class AddNewClub extends StatelessWidget {
  AddNewClub({Key? key}) : super(key: key);
  // add key to form buider state
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Add new club")),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FormBuilder(
              key: _fbKey,
              child: Column(children: <Widget>[
                // upload image
                FormBuilderImagePicker(
                  name: "image",
                  decoration: InputDecoration(labelText: "Club Image"),
                  imageQuality: 50,
                  maxImages: 1,
                ),
                // space
                SizedBox(height: 10),
                FormBuilderTextField(
                  name: "name",
                  decoration: InputDecoration(labelText: "Name"),
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required()],
                  ),
                ),
                // space
                SizedBox(height: 10),
                FormBuilderTextField(
                  name: "description",
                  decoration: InputDecoration(labelText: "Description"),
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required()],
                  ),
                ),
                // space
                SizedBox(height: 10),
                FormBuilderTextField(
                  name: "id",
                  decoration: InputDecoration(labelText: "Id"),
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required()],
                  ),
                ),
                // space
                SizedBox(height: 10),
                // drop down list from firebase
                FutureBuilder<List<QueryDocumentSnapshot<Object?>>>(
                    future: FirebaseServices().getSupervisor(),
                    builder: (context, snapshot) {
                      final supervisors = snapshot.data;
                      if (snapshot.hasData) {
                        return FormBuilderDropdown(
                          name: "supervisor",
                          decoration: InputDecoration(labelText: "Supervisor"),
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
                        return CircularProgressIndicator();
                      }
                    }),
                // space
                SizedBox(height: 10),
                FormBuilderTextField(
                  name: "email",
                  decoration: InputDecoration(labelText: "Email"),
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(),
                      FormBuilderValidators.email()
                    ],
                  ),
                ),
                // space
                SizedBox(height: 10),
                FormBuilderTextField(
                  name: "president",
                  decoration: InputDecoration(labelText: "President"),
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required()],
                  ),
                ),
                // space
                SizedBox(height: 10),
                ButtonTheme(
                    minWidth: 180,
                    height: 50,
                    child: RaisedButton(
                      child: const Text('Create a new Club',
                          style: TextStyle(color: Colors.black, fontSize: 16)),
                      onPressed: () async {
                        _fbKey.currentState?.save();
                        if (_fbKey.currentState!.validate()) {
                          // save data to FirebaseServecies
                          final state = await FirebaseServices()
                              .addNewClub(_fbKey.currentState?.value);
                          if (state == AuthResultStatus.successful) {
                            Navigator.pop(context);
                          } else {
                            print("error");
                          }
                        }
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.amber,
                      elevation: 5,
                    ))
              ])),
        ));
  }
}
