#!/bin/bash

echo "Run pub get"
flutter pub get

echo "Run build runner"
flutter packages pub run build_runner build --delete-conflicting-outputs
