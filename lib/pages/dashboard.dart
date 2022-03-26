import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decisionapp/widgets/pollWidget.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(14),
        child: Column(
          children: [
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('decisions')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  final docs = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: PollWidget(
                            decisionId: docs[index].id,
                            decisionTitle: docs[index]['title'],
                            pollWeights: docs[index]['pollWeights'],
                            usersWhoVoted: docs[index]['usersWhoVoted'],
                            msgById: docs[index]['uid']),
                      );
                    },
                  );
                }
              },
            ))
          ],
        ),
      ),
    );
  }
}
