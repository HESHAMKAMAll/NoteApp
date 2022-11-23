import 'package:flutter/material.dart';

class Me extends StatelessWidget {
  const Me({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Material(
            color: Colors.white12,
            borderRadius: BorderRadius.circular(17),
            elevation: 30,
            child: TextFormField(
              maxLines: 12,
              keyboardType: TextInputType.text,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: '''
                
                
"Hesham Kamal Mohamed"

Software Engineer
Flutter Developer
linkedin: https://www.linkedin.com/feed/
Email: heshamkamal422@gmail.com
                ''',
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(17),
                    borderSide: const BorderSide(color: Colors.white12)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(17),
                    borderSide: const BorderSide(color: Colors.white12)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
