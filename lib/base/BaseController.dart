import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'loadState/abstract_page_status.dart';

abstract class BaseController extends GetxController
    implements AbstractPageStatus {
  PageState _state = PageState.LOADING;

  @override
  get state => _state;

  @override
  set state(PageState value) {
    _state = value;
    update();
  }

  @override
  void loadData(bool isLoadMore) {}

  void success() {
    state = PageState.SUCCESS;
  }

  void error() {
    state = PageState.ERROR;
  }

  void empty() {
    state = PageState.EMPTY;
  }
}