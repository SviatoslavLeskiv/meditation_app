import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meditation_app/main.dart';
import 'package:meditation_app/presentation/login/widget/alert_dialogue.dart';
import 'package:meditation_app/presentation/login/widget/text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

const defaultColor = Color(0xFF589AAF);

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late SharedPreferences _preferences;

  String? _name;
  String? _password;

  bool _isRegister = false;
  bool _isLogin = false;

  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();

  final _nameFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _repeatPasswordFocus = FocusNode();

  @override
  void initState() {
    initSharedPreferences();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    _nameFocus.dispose();
    _passwordFocus.dispose();
    _repeatPasswordFocus.dispose();
    super.dispose();
  }

  void initSharedPreferences() async {
    _preferences = await SharedPreferences.getInstance();
    _name = _preferences.getString('name');
    _password = _preferences.getString('password');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFF589AAF).withOpacity(0.1),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Center(
                child: SvgPicture.asset(
                  'assets/logo.svg',
                  height: 100,
                ),
              ),
              const Text(
                'Meditation',
                style: TextStyle(
                  color: defaultColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 40),
              BorderedTextField(
                labelText: 'Імʼя',
                hintText: '',
                maxLength: 100,
                isError: false,
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.email],
                textCapitalization: TextCapitalization.none,
                controller: _nameController,
                focusNode: _nameFocus,
              ),
              const SizedBox(height: 10),
              BorderedTextField.passcode(
                labelText: 'Пароль',
                hintText: '',
                isError: false,
                controller: _passwordController,
                focusNode: _passwordFocus,
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 85,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: _isRegister ? 1 : 0,
                  child: BorderedTextField.passcode(
                    labelText: 'Повторіть пароль',
                    hintText: '',
                    isError: false,
                    controller: _repeatPasswordController,
                    focusNode: _repeatPasswordFocus,
                  ),
                ),
              ),
              const Spacer(),
              FractionallySizedBox(
                widthFactor: 1,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_isRegister) {
                      if (_nameController.text.trim().length < 2) {
                        showAppDialog(
                          context,
                          actions: {'Ok': () => Navigator.pop(context)},
                          subtitle: 'Введіть правильно ваше імʼя!',
                          title: "Ой",
                        );
                      } else {
                        if (_passwordController.text ==
                            _repeatPasswordController.text) {
                          await _preferences.setString(
                            'name',
                            _nameController.text.trim(),
                          );
                          await _preferences.setString(
                            'password',
                            _passwordController.text.trim(),
                          );
                          _name = _nameController.text.trim();
                          _password = _passwordController.text.trim();
                          _isRegister = false;
                          _passwordController.clear();
                          _repeatPasswordController.clear();
                          setState(() {});
                        } else {
                          showAppDialog(
                            context,
                            actions: {'Ok': () => Navigator.pop(context)},
                            subtitle: 'Паролі не збігаються!',
                            title: "Ой",
                          );
                        }
                      }
                    } else {
                      _isLogin = true;
                      setState(() {});
                      Future.delayed(const Duration(seconds: 2))
                          .whenComplete(() {
                        final success = _name == _nameController.text.trim() &&
                            _password == _passwordController.text;
                        if (success) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_) =>
                                  const BottomNavigationBarExample(),
                            ),
                          );
                        } else {
                          showAppDialog(
                            context,
                            actions: {'Ok': () => Navigator.pop(context)},
                            subtitle: 'Перевірте, будь ласка, імʼя та пароль!',
                            title: "Ой",
                          );
                        }
                        _isLogin = false;
                        setState(() {});
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: defaultColor,
                  ),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: _isLogin
                        ? const CupertinoActivityIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            _isRegister
                                ? 'Зареєструватись'.toUpperCase()
                                : 'Увійти'.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  _isRegister = !_isRegister;
                  setState(() {});
                },
                child: Text(
                  (_isRegister ? 'Вже маєте акаунт?' : 'Зареєструватись')
                      .toUpperCase(),
                  style: const TextStyle(
                    color: defaultColor,
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
