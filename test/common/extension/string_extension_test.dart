import 'package:flutter_test/flutter_test.dart';
import 'package:liushui_app/common/extension/string_extension.dart';

void main() {
  group('StringExtension Tests', () {
    group('isEmptyOrNull', () {
      test('should return true for empty string', () {
        expect(''.isEmptyOrNull, true);
      });

      test('should return false for non-empty string', () {
        expect('hello'.isEmptyOrNull, false);
      });

      test('should return false for whitespace-only string', () {
        expect('   '.isEmptyOrNull, false);
      });
    });

    group('isNotEmptyOrNull', () {
      test('should return true for non-empty string', () {
        expect('hello'.isNotEmptyOrNull, true);
      });

      test('should return false for empty string', () {
        expect(''.isNotEmptyOrNull, false);
      });
    });

    group('toInt', () {
      test('should parse valid integer', () {
        expect('123'.toInt(), 123);
      });

      test('should return null for invalid integer', () {
        expect('abc'.toInt(), null);
      });

      test('should handle negative numbers', () {
        expect('-42'.toInt(), -42);
      });
    });

    group('toDouble', () {
      test('should parse valid double', () {
        expect('3.14'.toDouble(), 3.14);
      });

      test('should return null for invalid double', () {
        expect('abc'.toDouble(), null);
      });
    });

    group('toBool', () {
      test('should return true for "true"', () {
        expect('true'.toBool(), true);
      });

      test('should return true for "TRUE"', () {
        expect('TRUE'.toBool(), true);
      });

      test('should return false for "false"', () {
        expect('false'.toBool(), false);
      });

      test('should return false for other strings', () {
        expect('yes'.toBool(), false);
      });
    });

    group('isEmail', () {
      test('should validate correct email', () {
        expect('test@example.com'.isEmail, true);
      });

      test('should reject invalid email', () {
        expect('invalid-email'.isEmail, false);
      });

      test('should reject email without domain', () {
        expect('test@'.isEmail, false);
      });
    });

    group('isPhoneNumber', () {
      test('should validate correct phone', () {
        expect('13800138000'.isPhoneNumber, true);
      });

      test('should reject invalid phone', () {
        expect('123456'.isPhoneNumber, false);
      });

      test('should reject phone starting with 0', () {
        expect('01234567890'.isPhoneNumber, false);
      });
    });

    group('isUrl', () {
      test('should validate http url', () {
        expect('http://example.com'.isUrl, true);
      });

      test('should validate https url', () {
        expect('https://example.com'.isUrl, true);
      });

      test('should reject invalid url', () {
        expect('not-a-url'.isUrl, false);
      });
    });

    group('hidePhoneNumber', () {
      test('should hide middle digits', () {
        expect('13800138000'.hidePhoneNumber, '138****8000');
      });

      test('should return original if not 11 digits', () {
        expect('12345'.hidePhoneNumber, '12345');
      });
    });

    group('hideEmail', () {
      test('should hide email username', () {
        expect('testuser@example.com'.hideEmail, 'te***@example.com');
      });

      test('should handle short username', () {
        expect('ab@example.com'.hideEmail, 'ab@example.com');
      });
    });

    group('toFixed', () {
      test('should format to 2 decimal places', () {
        expect('3.14159'.toFixed(), '3.14');
      });

      test('should format to custom decimal places', () {
        expect('3.14159'.toFixed(digits: 4), '3.1416');
      });

      test('should return default for empty string', () {
        expect(''.toFixed(), '0.0');
      });
    });
  });
}
