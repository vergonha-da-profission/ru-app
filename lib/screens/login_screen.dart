import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ru/bloc/authentication/authentication_bloc.dart';
import 'package:ru/bloc/login/login_bloc.dart';
import 'package:ru/util/screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends Screen {
  LoginBloc _loginBloc;

  @override
  dispose() {
    _loginBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    _loginBloc = LoginBloc(
      authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: (context) => _loginBloc,
        child: Container(
          color: Color(0xFFFFFF),
          child: ListView(
            children: [
              _MainImage(),
              Container(
                padding: _Const.formMargin,
                margin: const EdgeInsets.only(top: 30),
                child: Text(
                  'Bem vindo,',
                  style: GoogleFonts.roboto(
                      fontSize: 40,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF3c3c3c)),
                ),
              ),
              Container(
                padding: _Const.formMargin,
                margin: const EdgeInsets.only(top: 8),
                child: Text(
                  'Entre para continuar!',
                  style: GoogleFonts.roboto(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF939393),
                  ),
                ),
              ),
              SizedBox(height: 60),
              MyCustomForm(loginBloc: _loginBloc),
            ],
          ),
        ),
      ),
    );
  }
}

class _MainImage extends StatelessWidget {
  const _MainImage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .05),
        child: Container(
          height: _Const.imageWidth,
          width: _Const.imageHeight,
          child: Container(
            child: CachedNetworkImage(
              imageUrl: _Const.imageName,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        ),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  final LoginBloc loginBloc;

  const MyCustomForm({Key key, this.loginBloc}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState.validate()) {
      // Scaffold.of(context).showSnackBar(
      //     SnackBar(content: Text('Enviando informações')));
      this.widget.loginBloc.add(
            LoginButtonPressed(
              username: _usernameController.text,
              password: _passwordController.text,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state is LoginFailure) {
          final message = state.error.contains('incorrect')
              ? "Usuário ou senha incorretos"
              : state.error;

          _passwordController.clear();
          _onWidgetDidBuild(() {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: Colors.red,
              ),
            );
          });
        }

        return Container(
          margin: _Const.formMargin,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _UsernameInput(_usernameController),
                SizedBox(height: 20),
                _PasswordInput(_passwordController),
                _LoginFormButton(submitForm: _submitForm),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }
}

class _LoginFormButton extends StatelessWidget {
  const _LoginFormButton({
    Key key,
    @required this.submitForm,
  }) : super(key: key);

  final Function submitForm;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        padding: _Const.buttonOutterPading,
        margin: EdgeInsets.only(top: 30),
        child: FlatButton(
          color: Color(_Const.buttonBackgroundColor),
          onPressed: submitForm,
          child: Container(
            width: MediaQuery.of(context).size.width * .9,
            height: _Const.buttonHeight,
            child: Center(
              child: Text(_Const.buttonText, style: _Const.buttonStyle),
            ),
          ),
        ),
      ),
    );
  }
}

abstract class _Const {
  static const buttonBackgroundColor = 0xFF939393;
  static const buttonOutterPading = const EdgeInsets.symmetric(vertical: 16.0);
  static const double buttonHeight = 60;
  static const String buttonText = "Entrar";
  static final buttonStyle = GoogleFonts.notoSans(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Color(0xAA43414e),
  );

  static const double imageHeight = 150;
  static const double imageWidth = 100;
  static const String imageName =
      'https://avatars0.githubusercontent.com/u/71855737?s=400&u=76011f1a14e05ffb46bcf1e701c374300c4d1b54&v=4';
  static const formMargin = const EdgeInsets.symmetric(horizontal: 40);

  static const String passwordHint = 'Escreva sua senha';
  static const String loginHint = 'Login';

  static final inputHintStyle = GoogleFonts.notoSans(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Color(0xFF939393),
  );
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput(
    this.passwordController, {
    Key key,
  }) : super(key: key);

  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    bool _showText = false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Senha',
          style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        StatefulBuilder(builder: (BuildContext context, setState) {
          return TextFormField(
            controller: passwordController,
            obscureText: !_showText,
            decoration: InputDecoration(
              enabledBorder: new UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFF939393),
                  width: 1,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.orange,
                  width: 1,
                ),
              ),
              suffixIcon: IconButton(
                onPressed: () => setState(() => _showText = !_showText),
                icon: Icon(
                  _showText
                      ? Icons.visibility_off_outlined
                      : Icons.remove_red_eye_outlined,
                  color: Color(_Const.buttonBackgroundColor),
                ),
              ),
              hintText: _Const.passwordHint,
              hintStyle: _Const.inputHintStyle,
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Digite uma senha válida.';
              }
              return null;
            },
            textInputAction: TextInputAction.done,
            onEditingComplete: () {
              FocusScope.of(context).unfocus();
            },
          );
        }),
      ],
    );
  }
}

class _UsernameInput extends StatelessWidget {
  const _UsernameInput(
    this.usernameController, {
    Key key,
  }) : super(key: key);

  final TextEditingController usernameController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Usuário',
            style:
                GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w500)),
        TextFormField(
          controller: usernameController,
          autofocus: true,
          decoration: InputDecoration(
            enabledBorder: new UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF939393),
                width: 1,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.orange,
                width: 1,
              ),
            ),
            hintText: _Const.loginHint,
            hintStyle: _Const.inputHintStyle,
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Por favor, digite um idUFFS ou um CPF válido.';
            }
            return null;
          },
          textInputAction: TextInputAction.next,
          onEditingComplete: () => FocusScope.of(context).nextFocus(),
        ),
      ],
    );
  }
}
