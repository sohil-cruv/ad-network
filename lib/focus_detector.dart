import 'package:flutter/widgets.dart';
import 'package:visibility_detector/visibility_detector.dart';

class FocusDetector extends StatefulWidget {
  const FocusDetector({
    Key? key,
    this.onFocusGained,
    this.onFocusLost,
    this.onForegroundGained,
    this.onForegroundLost,
    required this.child,
  }) : super(key: key);

  /// Called when the widget becomes visible or enters foreground while visible.
  final VoidCallback? onFocusGained;

  /// Called when the widget becomes invisible or enters background while visible.
  final VoidCallback? onFocusLost;

  /// Called when the app entered the foreground while the widget is visible.
  final VoidCallback? onForegroundGained;

  /// Called when the app is sent to background while the widget was visible.
  final VoidCallback? onForegroundLost;

  final Widget child;

  @override
  _FocusDetectorState createState() => _FocusDetectorState();
}

class _FocusDetectorState extends State<FocusDetector>
    with WidgetsBindingObserver {
  final _visibilityDetectorKey = UniqueKey();

  bool _isWidgetVisible = false;

  bool _isAppInForeground = true;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _notifyPlaneTransition(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _notifyPlaneTransition(AppLifecycleState state) {
    if (!_isWidgetVisible) {
      return;
    }

    final isAppResumed = state == AppLifecycleState.resumed;
    final wasResumed = _isAppInForeground;
    if (isAppResumed && !wasResumed) {
      _isAppInForeground = true;
      _notifyFocusGain();
      _notifyForegroundGain();
      return;
    }

    final isAppPaused = state == AppLifecycleState.paused;
    if (isAppPaused && wasResumed) {
      _isAppInForeground = false;
      _notifyFocusLoss();
      _notifyForegroundLoss();
    }
  }

  void _notifyVisibilityStatusChange(double newVisibleFraction) {
    if (!_isAppInForeground) {
      return;
    }

    final wasFullyVisible = _isWidgetVisible;
    final isFullyVisible = newVisibleFraction == 1;
    if (!wasFullyVisible && isFullyVisible) {
      _isWidgetVisible = true;
      _notifyFocusGain();
    }

    final isFullyInvisible = newVisibleFraction == 0;
    if (wasFullyVisible && isFullyInvisible) {
      _isWidgetVisible = false;
      _notifyFocusLoss();
    }
  }

  void _notifyFocusGain() {
    final onFocusGained = widget.onFocusGained;
    if (onFocusGained != null) {
      onFocusGained();
    }
  }

  void _notifyFocusLoss() {
    final onFocusLost = widget.onFocusLost;
    if (onFocusLost != null) {
      onFocusLost();
    }
  }

  void _notifyForegroundGain() {
    final onForegroundGained = widget.onForegroundGained;
    if (onForegroundGained != null) {
      onForegroundGained();
    }
  }

  void _notifyForegroundLoss() {
    final onForegroundLost = widget.onForegroundLost;
    if (onForegroundLost != null) {
      onForegroundLost();
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: _visibilityDetectorKey,
      onVisibilityChanged: (visibilityInfo) {
        _notifyVisibilityStatusChange(visibilityInfo.visibleFraction);
      },
      child: widget.child,
    );
  }
}
