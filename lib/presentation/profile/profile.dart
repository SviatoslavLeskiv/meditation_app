import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meditation_app/presentation/login/login.dart';
import 'package:meditation_app/presentation/profile/widget/edit_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  final SharedPreferences preferences;

  const ProfilePage({
    super.key,
    required this.preferences,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String name;
  Uint8List? image;

  @override
  void initState() {
    name = widget.preferences.getString('name') ?? 'Optimus Prime';
    final imageString = widget.preferences.getString("image");
    if (imageString != null) {
      image = base64Decode(imageString);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF589AAF).withOpacity(0.1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                height: 150,
                width: 150,
                child: InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: () async {
                    final ImagePicker picker = ImagePicker();
                    // Pick an image.
                    final XFile? choseImage =
                        await picker.pickImage(source: ImageSource.gallery);
                    if (choseImage != null) {
                      image = await choseImage.readAsBytes();
                      String base64Image = base64Encode(image!);

                      widget.preferences.setString("image", base64Image);
                      setState(() {});
                    }
                  },
                  child: image != null
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          height: 150,
                          width: 150,
                          clipBehavior: Clip.antiAlias,
                          child: Image.memory(
                            image!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Center(
                          child: Container(
                            height: 160,
                            width: 160,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.black.withOpacity(0.1),
                            ),
                            child: const Icon(
                              Icons.person,
                              size: 135,
                            ),
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 20),
              EditButton(
                isLoaded: true,
                title: "Імʼя",
                text: name,
              ),
              const SizedBox(height: 20),
              const EditButton(
                isLoaded: true,
                title: "Пошта",
                text: 'john.doe@gmail.com',
              ),
              const SizedBox(height: 20),
              const Spacer(),
              FractionallySizedBox(
                widthFactor: 1,
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => const LoginPage(
                          isLogout: true,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(239, 252, 122, 122),
                  ),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: Text(
                      'Вийти'.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  widget.preferences.remove('name');
                  widget.preferences.remove('password');
                  widget.preferences.remove('image');
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => const LoginPage(
                        isLogout: true,
                      ),
                    ),
                  );
                  setState(() {});
                },
                child: Text(
                  'Видалити акаунт?'.toUpperCase(),
                  style: const TextStyle(
                    color: Color.fromARGB(239, 252, 122, 122),
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // func(){
  //    return showAppDialog(
  //         context,
  //         child: AppDialogFrame(
  //     title: widget.title,
  //     negativeButtonText: context.s.cancel,
  //     positiveButtonText: context.s.save,
  //     onNegativePress: context.router.pop,
  //     onPositivePress: () {
  //       if (!_verification()) return;
  //       if (widget.onPositivePress != null) {
  //         widget.onPositivePress!(_emailController.text);
  //       }
  //       context.router.pop();
  //     },
  //     onBackgroundPress: () {
  //       _emailFocusNode.unfocus();
  //     },
  //     body: _buildBody(context),
  //   );
  //       );
  // }
}
