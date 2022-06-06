import 'package:code_resto/utils/functions.dart';
import 'package:flutter/material.dart';

class LeadingScreen extends StatefulWidget {
  const LeadingScreen({Key? key}) : super(key: key);

  @override
  State<LeadingScreen> createState() => _LeadingScreenState();
}

class _LeadingScreenState extends State<LeadingScreen> {
  Future<void> isConnected() async {
    var r = await getCurrentToken();

    r == null
        ? Navigator.pushNamed(context, '/first_screen')
        : Navigator.pushNamed(context, '/home_screen');
  }

  @override
  void initState() {
    super.initState();
    isConnected();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
