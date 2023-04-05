import 'package:flutter/material.dart';
import 'package:login_register_methods/layout/main_layout_screen.dart';

import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';

class UsernameScreen extends StatelessWidget {

  final formKey = GlobalKey<FormState>();
  var usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 22.0),
                    children: [
                      const TextSpan(
                        text: "What should we call ",
                      ),
                      TextSpan(
                        text: "you?",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 22.0,
                            color: secondaryColor,
                            fontStyle: FontStyle.italic),
                      ),
                    ]),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Your @username is unique. You can always change it later.",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontSize: 18.0),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                child: defaultTextFromField(
                  hintText: "@username",
                  controller: usernameController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if(value!.isEmpty){
                      return "username can't be empty";
                    }
                    return null;
                  },
                ),
              ),
              const Spacer(),
              Container(
                child: defaultButton(
                  text: "Create Account",
                  onPress: () {
                    if (formKey.currentState!.validate()) {
                      navigatePushDelete(context, widget: MainLayoutScreen());
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
