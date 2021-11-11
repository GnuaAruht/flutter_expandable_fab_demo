import 'dart:math';
import 'package:flutter/material.dart';
import 'fab_menu_item.dart';

const buttonSize = 50.0;

class ExpandableFab extends StatefulWidget {
  final List<FabMenuItem> fabMenuItems;
  const ExpandableFab({Key? key, required this.fabMenuItems})
      : assert(
            fabMenuItems.length >= 2, 'Menu items must be at least 2 items.'),
        super(key: key);

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 300));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Flow(
        delegate: ExpandableFabDeletate(controller: _controller),
        children: [
          MainFab(
              iconData: Icons.menu,
              onTap: () {
                _controller.isCompleted
                    ? _controller.reverse()
                    : _controller.forward();
              },
              controller: _controller),
          ...widget.fabMenuItems
              .map((item) => SizedBox(
                    width: buttonSize,
                    height: buttonSize,
                    child: FloatingActionButton(
                      onPressed: () {
                        item.onPressed();
                        _controller.reverse();
                      },
                      child: Icon(item.icon),
                    ),
                  ))
              .toList()
        ]);
  }
}

class MainFab extends StatelessWidget {
  final IconData iconData;
  final VoidCallback onTap;
  final AnimationController controller;

  const MainFab(
      {Key? key,
      required this.iconData,
      required this.onTap,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return SizedBox(
            width: buttonSize,
            height: buttonSize,
            child: FloatingActionButton(
              onPressed: onTap,
              child: controller.isCompleted
                  ? const Icon(
                      Icons.close,
                      key: ValueKey('Close icon'),
                    )
                  : Icon(
                      iconData,
                      key: const ValueKey('IconData icon'),
                    ),
            ));
      },
    );
  }
}

class ExpandableFabDeletate extends FlowDelegate {
  final AnimationController controller;
  final y = 70.0;

  ExpandableFabDeletate({required this.controller})
      : super(repaint: controller);

  @override
  void paintChildren(FlowPaintingContext context) {
    final size = context.size;
    final xStart = size.width - buttonSize;
    final yStart = size.height - buttonSize;
    final childCount = context.childCount;
    for (int i = childCount - 1; i >= 0; i--) {
      final dy = yStart - (i * y * controller.value);

      context.paintChild(
        i,
        transform: Matrix4.identity()
          ..translate(xStart, dy, 0)
          ..translate(buttonSize / 2, buttonSize / 2)
          ..rotateZ(2 * pi * controller.value)
          ..scale(i == 0 ? 1.0 : max(controller.value, 0.8))
          ..translate(-buttonSize / 2, -buttonSize / 2),
      );
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) => true;
}
