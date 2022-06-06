import 'package:app/main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../constants/constants.dart';
import '../../services/firebase_services.dart';
import '../widgets/widgets.dart';

class ModificationPage extends StatelessWidget {
  const ModificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        leading: const SizedBox(),
        actions: const [
          AppBarBackButton(),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (auth.currentUser?.photoURL != null)
                  Container(
                    color: kPrimaryColor,
                    child: Center(
                      child: CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(
                            auth.currentUser?.photoURL ?? ''),
                        radius: ScreenUtil().setHeight(45),
                      ),
                    ),
                  ),
                if (auth.currentUser?.photoURL == null)
                  Container(
                    color: kPrimaryColor,
                    child: Center(
                      child: CircleAvatar(
                        backgroundImage:
                            const AssetImage('assets/image/user.png'),
                        radius: ScreenUtil().setHeight(45),
                      ),
                    ),
                  ),
                SizedBox(width: kDefaultHorizontalPadding),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${auth.currentUser!.displayName ?? 'User'}',
                      style: TextStyle(
                        fontSize: kUsernameFontSize,
                        color: kSecondaryColor,
                      ),
                    ),
                    SizedBox(height: kDefaultVerticalPadding * 0.2),
                    Text(
                      '${auth.currentUser!.email ?? 'Email'}',
                      style: TextStyle(
                        fontSize: kTextFontSize,
                        color: kSecondaryColor,
                      ),
                    ),
                    SizedBox(height: kDefaultVerticalPadding * 0.2),
                    Text(
                      '${auth.currentUser!.phoneNumber ?? '05050 5050'}',
                      style: TextStyle(
                        fontSize: kTextFontSize,
                        color: kSecondaryColor,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Divider(
                    color: kSecondaryColor.withOpacity(0.5),
                    height: 0.05,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: modificationOptions.length,
                    itemBuilder: (context, index) {
                      return OptionListTile(
                        icon: modificationOptions[index]['icon'],
                        title: modificationOptions[index]['title'],
                        titleColor: kSecondaryColor,
                        dividerColor: kSecondaryColor.withOpacity(0.5),
                        onPressed: () async {
                          switch (index) {
                            case 0:
                              // pick image and save it to user collection
                              ImagePicker picker = ImagePicker();
                              picker
                                  .pickImage(source: ImageSource.gallery)
                                  .then((image) async {
                                print('picked ${image}');
                                if (image != null) {
                                  final state = await FirebaseServices()
                                      .updateUserImage(image.path);
                                  if (state) {
                                    showTopSnackBar(
                                        context,
                                        CustomSnackBar.success(
                                            message:
                                                'Image updated successfully'));
                                  } else {
                                    showTopSnackBar(
                                        context,
                                        CustomSnackBar.error(
                                            message: 'Image update failed'));
                                  }
                                }
                              });
                              break;
                            case 1: // update email
                              final _emailController = TextEditingController();
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Update Email'),
                                      content: TextField(
                                        controller: _emailController,
                                        decoration: InputDecoration(
                                          hintText: 'Enter new email',
                                        ),
                                      ),
                                      actions: [
                                        FlatButton(
                                          child: Text('Cancel'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        FlatButton(
                                          child: Text('Update'),
                                          onPressed: () async {
                                            if (_emailController.text != null) {
                                              final state =
                                                  await FirebaseServices()
                                                      .updateUserEmail(
                                                          _emailController
                                                              .text);
                                              if (state) {
                                                showTopSnackBar(
                                                    context,
                                                    CustomSnackBar.success(
                                                        message:
                                                            'Email updated'));
                                              } else {
                                                showTopSnackBar(
                                                    context,
                                                    CustomSnackBar.error(
                                                        message:
                                                            'Email update failed'));
                                              }
                                            }
                                          },
                                        ),
                                      ],
                                    );
                                  });
                              break;
                            case 2:
                              // update password
                              final _passwordController =
                                  TextEditingController();
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Update Password'),
                                      content: TextField(
                                        controller: _passwordController,
                                        decoration: InputDecoration(
                                          hintText: 'Enter new password',
                                        ),
                                      ),
                                      actions: [
                                        FlatButton(
                                          child: Text('Cancel'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        FlatButton(
                                          child: Text('Update'),
                                          onPressed: () async {
                                            if (_passwordController.text !=
                                                null) {
                                              try {
                                                await auth.currentUser!
                                                    .updatePassword(
                                                        _passwordController
                                                            .text);
                                                showTopSnackBar(
                                                    context,
                                                    CustomSnackBar.success(
                                                        message:
                                                            'Password updated'));
                                              } catch (e) {
                                                showTopSnackBar(
                                                    context,
                                                    CustomSnackBar.error(
                                                        message:
                                                            'Password update failed'));
                                              }
                                            }
                                          },
                                        ),
                                      ],
                                    );
                                  });
                              break;
                            case 3:
                              // update name
                              final _nameController = TextEditingController();
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Update Name'),
                                      content: TextField(
                                        controller: _nameController,
                                        decoration: InputDecoration(
                                          hintText: 'Enter new name',
                                        ),
                                      ),
                                      actions: [
                                        FlatButton(
                                          child: Text('Cancel'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        FlatButton(
                                          child: Text('Update'),
                                          onPressed: () async {
                                            if (_nameController.text != null) {
                                              try {
                                                await auth.currentUser!
                                                    .updateDisplayName(
                                                        _nameController.text);
                                                showTopSnackBar(
                                                    context,
                                                    CustomSnackBar.success(
                                                        message:
                                                            'Name updated'));
                                                final name =
                                                    await FirebaseServices()
                                                        .updateUserName(
                                                            _nameController
                                                                .text);
                                              } catch (e) {
                                                showTopSnackBar(
                                                    context,
                                                    CustomSnackBar.error(
                                                        message:
                                                            'Name update failed'));
                                              }
                                            }
                                          },
                                        ),
                                      ],
                                    );
                                  });
                              break;
                            case 4:
                              break;
                            default:
                              break;
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
