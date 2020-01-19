import 'package:flutter/material.dart';

enum Direction {
  top,
  bottom,
}

class PopMenuWidget extends StatefulWidget {
  ///方向:从上/下弹出
  final Direction direction;

  ///子控件
  final Widget child;

  ///弹出菜单
  final Widget menu;

  ///菜单的展示状态
  ///在setStatus回调中改变
  final bool show;
  const PopMenuWidget({
    Key key,
    this.direction = Direction.top,
    @required this.child,
    this.show = false,
    @required this.menu,
  }) : super(key: key);

  @override
  _PopMenuWidgetState createState() => _PopMenuWidgetState();
}

class _PopMenuWidgetState extends State<PopMenuWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _offsetAnimation;

  ///是否是展示动画状态
  bool get _backGropPanelVisible {
    final AnimationStatus status = _controller.status;

    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  void _toggleBackgropPanelVisbility() {
    print('is visiable=' + _backGropPanelVisible.toString());
    //-关闭 +打开
    _controller.fling(velocity: _backGropPanelVisible ? -1.0 : 1.0);
    print('is visiable=' + _backGropPanelVisible.toString());
  }

  void initState() {
    super.initState();
    _controller =
    AnimationController(duration: Duration(milliseconds: 300), vsync: this)
      ..addStatusListener((status) {
        print(status.toString() + "状态");
      });
  }

  @override
  void didUpdateWidget(PopMenuWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.show != oldWidget.show) {
      _toggleBackgropPanelVisbility();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildContentView();
  }

  Widget _buildContentView() {
    if (widget.direction == Direction.top) {
      _offsetAnimation = Tween<Offset>(
        begin: const Offset(0.0, -1),
        end: Offset.zero,
      ).animate(_controller);
    } else {
      _offsetAnimation = Tween<Offset>(
        begin: const Offset(0.0, 1),
        end: Offset.zero,
      ).animate(_controller);
    }
    return Container(
      child: Stack(
        children: _buildStackChildren(_offsetAnimation),
      ),
    );
  }

  List<Widget> _buildStackChildren(Animation<Offset> panelAnimation) {
    List<Widget> widgetList = [
      widget.child,
    ];
    if (widget.direction == Direction.top) {
      widgetList.add(SlideTransition(
        position: panelAnimation,
        child: widget.menu,
      ));
    } else if (widget.direction == Direction.bottom) {
      widgetList.add(Positioned(
        bottom: 0.0,
        left: 0.0,
        right: 0.0,
        child: SlideTransition(
          position: panelAnimation,
          child: widget.menu,
        ),
      ));
    }

    if (_backGropPanelVisible) {
      widgetList.insert(
        1,
        Opacity(
            opacity: 0.8,
            child: ModalBarrier(
              dismissible: false,
              color: Colors.black45,
            )),
      );
    }
    return widgetList;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
