import 'package:flutter_test/flutter_test.dart';
import 'package:liushui_app/common/utils/event_bus.dart';

void main() {
  late EventBus eventBus;

  setUp(() {
    eventBus = EventBus();
    eventBus.clear();
  });

  group('EventBus Tests', () {
    test('should register and emit events', () {
      String? receivedValue;
      eventBus.on('testEvent', (arg) {
        receivedValue = arg as String?;
      });

      eventBus.emit('testEvent', 'Hello');

      expect(receivedValue, 'Hello');
    });

    test('should support multiple listeners for same event', () {
      int callCount = 0;
      eventBus.on('multiEvent', (_) => callCount++);
      eventBus.on('multiEvent', (_) => callCount++);

      eventBus.emit('multiEvent');

      expect(callCount, 2);
    });

    test('should remove specific listener', () {
      int callCount = 0;
      void listener(Object? arg) => callCount++;

      eventBus.on('removeTest', listener);
      eventBus.emit('removeTest');
      expect(callCount, 1);

      eventBus.off('removeTest', listener);
      eventBus.emit('removeTest');
      expect(callCount, 1);
    });

    test('should remove all listeners for an event', () {
      int callCount = 0;
      eventBus.on('clearTest', (_) => callCount++);
      eventBus.on('clearTest', (_) => callCount++);

      eventBus.off('clearTest');
      eventBus.emit('clearTest');

      expect(callCount, 0);
    });

    test('should handle emit with no listeners gracefully', () {
      expect(() => eventBus.emit('nonExistent'), returnsNormally);
    });

    test('should pass argument to listener', () {
      Map<String, dynamic>? receivedData;
      eventBus.on('dataEvent', (arg) {
        receivedData = arg as Map<String, dynamic>?;
      });

      eventBus.emit('dataEvent', {'id': 1, 'name': 'Test'});

      expect(receivedData, {'id': 1, 'name': 'Test'});
    });

    test('should clear all events', () {
      int callCount = 0;
      eventBus.on('event1', (_) => callCount++);
      eventBus.on('event2', (_) => callCount++);

      eventBus.clear();

      eventBus.emit('event1');
      eventBus.emit('event2');

      expect(callCount, 0);
    });

    test('should support enum as event name', () {
      String? result;
      eventBus.on(TestEvent.refresh, (arg) {
        result = 'refreshed';
      });

      eventBus.emit(TestEvent.refresh);

      expect(result, 'refreshed');
    });
  });
}

enum TestEvent { refresh, update, delete }
