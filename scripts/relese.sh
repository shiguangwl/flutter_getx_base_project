#!/bin/bash
# 打包安卓 arm64-v8a
flutter build apk --release  --dart-define-from-file=env/prod.json --target-platform android-arm64

# 打包安卓 armeabi-v7a
# flutter build apk --release --target-platform android-arm

# 打包安卓 x86
# flutter build apk --release --target-platform android-x86

# 打包安卓 x86_64
# flutter build apk --release --target-platform android-x64
