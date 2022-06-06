import 'package:flutter/cupertino.dart';

class CostumPageRoute extends PageRouteBuilder {
  final Widget child;
  final AxisDirection? direction;
  final int? myDuration;
  CostumPageRoute({
    required this.child,
    this.direction = AxisDirection.up,
    this.myDuration,
  }) : super(
          transitionDuration: Duration(milliseconds: myDuration ?? 500),
          reverseTransitionDuration: Duration(milliseconds: myDuration ?? 500),
          pageBuilder: (context, animation, secondryAnimation) => child,
        );
  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
          Animation<double> secondryAnimation, Widget child) =>
      SlideTransition(
        position: Tween<Offset>(
          begin: getBeginOffset(),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );

  Offset getBeginOffset() {
    Offset? myOffset;
    switch (direction ?? AxisDirection.down) {
      case AxisDirection.up:
        myOffset = const Offset(0, 1);
        return myOffset;
      case AxisDirection.down:
        myOffset = const Offset(0, -1);
        return myOffset;
      case AxisDirection.left:
        myOffset = const Offset(1, 0);
        return myOffset;
      case AxisDirection.right:
        myOffset = const Offset(-1, 0);
        return myOffset;
    }
  }
}
