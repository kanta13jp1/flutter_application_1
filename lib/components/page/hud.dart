import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/molecules/indicator.dart';

class _InheritedWidget extends InheritedWidget {
  _InheritedWidget({
    Key? key,
    required Widget child,
    required this.state,
  }) : super(key: key, child: child);

  final _HUDState state;

  @override
  bool updateShouldNotify(covariant _InheritedWidget oldWidget) {
    return false;
  }
}

class HUD extends StatefulWidget {
  final bool shown;
  final bool barrierEnabled;
  final Widget? child;

  const HUD({
    Key? key,
    required this.child,
    required this.shown,
    this.barrierEnabled = true,
  }) : super(key: key);

  @override
  _HUDState createState() => _HUDState();

  static _HUDState of(BuildContext context) {
    final exactType = context
        .getElementForInheritedWidgetOfExactType<_InheritedWidget>()
        ?.widget;
    final stateWidget = exactType as _InheritedWidget?;
    final state = stateWidget?.state;
    if (state == null) {
      throw AssertionError('''
      Not found HUD from this context: $context
      The context should contains HUD widget into current widget tree
      ''');
    }
    return state;
  }
}

class _HUDState extends State<HUD> {
  bool _shown = false;
  show() {
    setState(() {
      _shown = true;
    });
  }

  hide() {
    setState(() {
      _shown = false;
    });
  }

  bool get shown => widget.shown || _shown;

  @override
  Widget build(BuildContext context) {
    return _InheritedWidget(child: _body(context), state: this);
  }

  Widget _body(BuildContext context) {
    final child = widget.child;
    if (child == null) {
      return _hud(context);
    }
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        child,
        _hud(context),
      ],
    );
  }

  Widget _hud(BuildContext context) {
    return IgnorePointer(
      ignoring: !shown,
      child: Stack(
        children: [
          if (shown) ...[
            if (widget.barrierEnabled)
              Visibility(
                visible: shown,
                child: ModalBarrier(
                  color: Colors.black.withOpacity(0.08),
                ),
              ),
            Center(child: Indicator()),
          ],
        ],
      ),
    );
  }
}
