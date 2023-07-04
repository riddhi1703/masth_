import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SendMail extends StatefulWidget {
  const SendMail({Key? key}) : super(key: key);

  @override
  State<SendMail> createState() => _SendMailState();
}

class _SendMailState extends State<SendMail> {
  TextEditingController recipientController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: recipientController,
              decoration: InputDecoration(
                hintText: "Recipient",
              ),
            ),
            TextFormField(
              controller: subjectController,
              decoration: InputDecoration(
                hintText: "Subject",
              ),
            ),
            TextFormField(
              controller: bodyController,
              decoration: InputDecoration(
                hintText: "Body",
              ),
            ),
            GestureDetector(
              onTap: () async {
                String recipient = recipientController.text;
                String subject = subjectController.text;
                String body = bodyController.text;

                final Uri email = Uri(
                  scheme: 'mailto',
                  path: recipient,
                  query: 'subject=' + Uri.encodeComponent(subject) + '&body=' + Uri.encodeComponent(body),
                );

                if(await canLaunchUrl(email)) {
                  await launchUrl(email);
                } else {
                  debugPrint('Error');
                }
              },
              child: Container(
                height: 50,
                width: 120,
                color: Colors.orange,
                child: Center(
                  child: Text("Send"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
