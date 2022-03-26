import 'package:decisionapp/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/providers/templateProvider.dart';

Widget templateButton(BuildContext context, String text) {
  // final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
  return Consumer<TemplateProvider>(
    builder: (context, model, child) => Container(
      margin: const EdgeInsets.only(right: 10, top: 10),
      child: Container(
        height: 50,
        child: ElevatedButton.icon(
          style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
              elevation: MaterialStateProperty.all(0),
              backgroundColor: MaterialStateProperty.all(Colors.grey.shade800)),
          onPressed: () {
            model.addPollOptions(['', '']);
            model.addPollWeights({});
          },
          icon: Icon(
            Icons.add,
            color: Colors.black,
          ),
          label: Text(
            text,
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
        ),
      ),
    ),
  );
}

class PollsContainer extends StatefulWidget {
  final int i;

  const PollsContainer({
    Key? key,
    required this.i,
  }) : super(key: key);

  @override
  _PollsContainerState createState() => _PollsContainerState();
}

class _PollsContainerState extends State<PollsContainer> {
  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return Consumer<TemplateProvider>(
      builder: (context, model, child) => Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.grey.shade600.withOpacity(0.3))),
        elevation: 0,
        margin: const EdgeInsets.only(top: 20, bottom: 20),
        color: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      textCapitalization: TextCapitalization.sentences,
                      cursorColor: AppColors.primary,
                      maxLines: 2,
                      minLines: 1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please give a title to the Polls.';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        model.addPollTitle(value!);
                      },
                      style: const TextStyle(fontSize: 18),
                      decoration: const InputDecoration(
                          hintText: 'Add Polls Title',
                          hintStyle: TextStyle(fontSize: 18),
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none)),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  for (int j = 0; j < model.pollsOptions[widget.i].length; j++)
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(children: [
                        IconButton(
                            onPressed: () {
                              if (model.pollsOptions[widget.i].length != 2) {
                                model.removePollOptionsAtIndex(widget.i, j);
                              }
                            },
                            icon: const Icon(Icons.remove_circle_outline)),
                        Expanded(
                            child: TextFormField(
                          textCapitalization: TextCapitalization.sentences,
                          cursorColor: AppColors.primary,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter an option';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            model.pollsOptions[widget.i][j] = (value);
                            model.pollsWeights[widget.i][value] = 0;
                          },
                          decoration: InputDecoration(
                              hintText: 'Enter Option',
                              // hintText: 'Option ${index + 1}',
                              border: InputBorder.none),
                        )),
                      ]),
                    )
                ],
              ),
              const SizedBox(height: 10),
              TextButton(
                  onPressed: () {
                    if (model.pollsOptions[widget.i].length != 5) {
                      model.addPollOptionIndex(widget.i);
                    }
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.add_circle_outline,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Add Option',
                        style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
