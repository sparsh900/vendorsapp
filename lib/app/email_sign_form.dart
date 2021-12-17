import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:vendors_app/app/email_sign_in_bloc.dart';
import 'package:vendors_app/app/email_sign_in_model.dart';
import 'package:vendors_app/app/validators.dart';
import 'package:vendors_app/common_widgets/form_submit_button.dart';
import 'package:vendors_app/main.dart';
import 'package:vendors_app/services/auth.dart';


class EmailSignInForm extends StatefulWidget{
  EmailSignInForm({@required this.bloc});
  final EmailSignInBloc bloc;

  static Widget create(BuildContext context)
  {
    final AuthBase auth = Provider.of(context,listen: false);
    return Provider(
      create: (context) => EmailSignInBloc(auth: auth),
      child: Consumer<EmailSignInBloc>(
        builder: (context,bloc,_) => EmailSignInForm(bloc: bloc,),
      ),
      dispose: (context,bloc) => bloc.dispose(),
    );
  }
  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _emailEditingComplete(EmailSignInModel model) {
    final newFocus = model.emailValidator.isValid(model.email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _toggleFormType() {
    widget.bloc.toggleFormType();
    _emailController.clear();
    _passwordController.clear();
    FocusScope.of(context).requestFocus(_emailFocusNode);
  }

  void _submit() async {
    print(
        'email : ${_emailController.text}, password: ${_passwordController.text}');

    try {
      await widget.bloc.submit();
    } on PlatformException catch(e) {
      print(e.toString());
      showPlatformDialog(
        context: context,
        builder: (context) {
          return PlatformAlertDialog(
            title: Text('Sign In Failed'),
            content: Text(EmailAndPasswordValidators.message(e)),
            actions: <Widget>[
              PlatformDialogAction(
                child: PlatformText('OK'),
                onPressed: Navigator.of(context).pop,
              )
            ],
          );
        },
      );
    }
  }

  List<Widget> _buildChildren(EmailSignInModel model) {

    return [
      _buildEmailTextField(model),
      SizedBox(height: 8.0),
      _buildPasswordTextField(model),
      SizedBox(height: 8.0),
      FormSubmitButton(
        text: model.primaryButtonText,
        onPressed: model.canSubmit ? _submit : null,
      ),
      SizedBox(height: 8.0),
      FlatButton(
        child: Text(model.secondaryButtonText),
        onPressed: model.isLoading ? null : _toggleFormType,
      ),
    ];
  }

  TextField _buildPasswordTextField(EmailSignInModel model) {

    return TextField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      decoration: InputDecoration(
        icon: Icon(Icons.lock_open,color: petColor),
        labelText: 'Password',
        errorText: model.passwordErrorText,
        enabled: model.isLoading == false,
      ),
      obscureText: true,
      textInputAction: TextInputAction.done,
      onEditingComplete: _submit,
      onChanged: widget.bloc.updatePassword,
    );
  }

  TextField _buildEmailTextField(EmailSignInModel model) {

    return TextField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      decoration: InputDecoration(
          icon: Icon(Icons.email,color: petColor),
          labelText: 'Email',
          hintText: 'test@test.com',
          errorText: model.emailErrorText,
          enabled: model.isLoading == false),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onEditingComplete: () => _emailEditingComplete(model),
      onChanged: widget.bloc.updateEmail,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: StreamBuilder<EmailSignInModel>(
        stream: widget.bloc.modelStream,
        initialData: EmailSignInModel(),
        builder: (context, snapshot) {
          final EmailSignInModel model = snapshot.data;
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _buildChildren(model),
          );
        }
      ),
    );
  }

}
