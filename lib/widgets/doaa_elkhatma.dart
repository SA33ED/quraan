import 'package:flutter/material.dart';
import 'package:quraan/screens/doaa_screen.dart';

class DoaaElkhatma extends StatelessWidget {
  const DoaaElkhatma({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DoaaScreen(),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(top: 32),
        child: Container(
          alignment: Alignment.center,
          child: const Column(
            children: [
              Text(
                "دعاء الخاتمه",
                style: TextStyle(
                  fontSize: 100,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 3,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
