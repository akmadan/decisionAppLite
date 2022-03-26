import 'package:decisionapp/services/authFunctions.dart';
import 'package:decisionapp/services/providers/templateProvider.dart';
import 'package:decisionapp/widgets/addPolls.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDecision extends StatefulWidget {
  const AddDecision({Key? key}) : super(key: key);

  @override
  _AddDecisionState createState() => _AddDecisionState();
}

class _AddDecisionState extends State<AddDecision> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TemplateProvider>(
        builder: (context, model, child) => Container(
          padding: EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // TextField(
                //   decoration: InputDecoration(hintText: 'Enter Decision Title'),
                // ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    model.pollsOptions.isNotEmpty
                        ? Container()
                        : templateButton(context, 'Polls'),
                  ],
                ),
                Column(
                  children: [
                    for (int i = 0; i < model.pollsOptions.length; i++)
                      PollsContainer(i: i)
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          submitDecision(
                              model.pollsTitle[0], model.pollsWeights[0]);
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Decision Added')));
                        }
                      },
                      child: Text('Submit')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
