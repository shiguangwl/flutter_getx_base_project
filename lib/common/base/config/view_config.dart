import 'refresh_position.dart';

class ViewConfig {
  final bool addHorizontalPadding;
  final double horizontalPadding;
  final bool useScaffold;
  final bool enableDownRefresh;

  ViewConfig({
    this.addHorizontalPadding = false,
    this.horizontalPadding = 0,
    this.useScaffold = true,
    this.enableDownRefresh = false,
  });
}

class RefreshableConfig extends ViewConfig {
  final bool enableUpRefresh;
  final RefreshPosition refreshPosition;
  final bool pinHeader;

  RefreshableConfig({
    this.enableUpRefresh = true,
    super.addHorizontalPadding = false,
    super.horizontalPadding = 0,
    super.useScaffold = true,
    super.enableDownRefresh = true,
    this.refreshPosition = RefreshPosition.aboveHeader,
    this.pinHeader = false,
  });
}
