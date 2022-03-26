import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decisionapp/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:polls/polls.dart';
import 'package:provider/provider.dart';

class PollWidget extends StatefulWidget {
  // final int pollsIndex;
  final String decisionId,
      // currUserUID,

      // annswerid,
      decisionTitle,
      // templateTitle,
      msgById;
  final Map pollWeights, usersWhoVoted;

  const PollWidget({
    Key? key,
    required this.decisionId,
    required this.decisionTitle,
    required this.pollWeights,
    required this.usersWhoVoted,
    required this.msgById,
  }) : super(key: key);

  @override
  _PollWidgetState createState() => _PollWidgetState();
}

class _PollWidgetState extends State<PollWidget> {
  bool longPressed = false;
  User currUser = FirebaseAuth.instance.currentUser!;
  final formKeyPollsTitle = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // final decisionProvider =
    //     Provider.of<DecisionProvider>(context, listen: false);
    // final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return InkWell(
        onLongPress: () {
          setState(() {
            longPressed = !longPressed;
          });
        },
        onTap: () {
          if (longPressed) {
            setState(() {
              longPressed = false;
            });
          }
        },
        child: Container(
          // color: AppColors.primary.withOpacity(longPressed ? 0.3 : 0),
          margin: const EdgeInsets.only(top: 10),
          child: Card(
            shadowColor: Colors.grey.shade600.withOpacity(0.2),
            elevation: 0,
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: BorderSide(color: Colors.grey.shade600.withOpacity(0.3))),
            child: Container(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 30, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.decisionTitle,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      // currUser.uid != widget.msgById
                      //     ? Container()
                      //     : IconButton(
                      //         onPressed: () {
                      //           // showBottomMenu();
                      //         },
                      //         icon: Icon(
                      //           Icons.more_horiz,
                      //           size: 20,
                      //           color: Colors.grey.shade600,
                      //         ))
                    ],
                  ),
                  Polls(
                    iconColor: Colors.black,
                    children: [
                      for (int i = 0;
                          i < widget.pollWeights.keys.toList().length;
                          i++)
                        Polls.options(
                            title: widget.pollWeights.keys.toList()[i],
                            value: (widget.pollWeights.values.toList()[i])
                                .toDouble()) //change value
                    ],
                    allowCreatorVote: true,
                    question: const Text(''),
                    outlineColor: AppColors.primary,

                    currentUser: currUser.uid,
                    creatorID: widget.msgById,

                    voteData:
                        widget.usersWhoVoted, //Users who have already voted
                    leadingBackgroundColor: AppColors.primary.withOpacity(0.6),
                    userChoice: widget.pollWeights.keys
                        .toList()
                        .indexOf(widget.usersWhoVoted[widget.decisionId]),
                    onVoteBackgroundColor: AppColors.primary.withOpacity(0.5),

                    backgroundColor: Colors.transparent,

                    onVote: (choice) async {
                      Map userWhoVoted = widget.usersWhoVoted;
                      Map thisPollweights = widget.pollWeights;
                      var selectedOption =
                          widget.pollWeights.keys.toList()[choice - 1];
                      setState(() {
                        //updating Poll Weights
                        thisPollweights[selectedOption] =
                            thisPollweights[selectedOption] + 1;

                        //Updating people who voted map with their choice
                        userWhoVoted[currUser.uid] =
                            widget.pollWeights.keys.toList()[choice - 1];
                      });

                      //updating everything on Cloud Firestore
                      await FirebaseFirestore.instance
                          .collection('decisions')
                          .doc(widget.decisionId)
                          .update({
                        'pollWeights': thisPollweights,
                        'usersWhoVoted': userWhoVoted
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  // //------------------Delete Pros-Cons----------------
  // deleteDecision() async {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: true, // user must tap button!
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         shape:
  //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //         title: const Text('Delete Polls'),
  //         content: SingleChildScrollView(
  //           child: ListBody(
  //             children: const <Widget>[
  //               Text(
  //                   'Your Polls will be permanently Deleted, Do you wish to confirm?'),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: const Text(
  //               'Delete',
  //               style: TextStyle(color: Colors.red, fontSize: 18),
  //             ),
  //             onPressed: () async {
  //               await FirebaseFirestore.instance
  //                   .collection('decisions')
  //                   .doc(widget.decisionId)
  //                   .collection('answers')
  //                   .doc(widget.annswerid)
  //                   .delete();
  //             },
  //           ),
  //           TextButton(
  //             child: const Text(
  //               'Cancel',
  //               style: TextStyle(fontSize: 18, color: AppColors.primary),
  //             ),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
