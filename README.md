An indicator ui package inspired by [this video](https://www.youtube.com/watch?v=zEqTjB-OJVI) and [CL app](https://apps.apple.com/jp/app/cl-%E3%82%B7%E3%83%BC%E3%82%A8%E3%83%AB/id1508298355).

## Features
### Demo
https://user-images.githubusercontent.com/30540303/147690694-2fb49ac4-ae13-4749-8c3a-dc29ea435974.mp4


## Getting started

Add this package to your dependency. (pubspec.yaml)

## Usage

### A simple usage

```dart
CometIndicator.simple(
  baseColor: Colors.pinkAccent,
  radius: 70,
  strokeWidth: 3,
  indicatorRatio: 0.7,
  dotRadius: 4,
  duration: const Duration(seconds: 2),
)
```

### More customizable usage

```dart
CometIndicator.custom(
  indicatorColors: [
    Colors.red,
    Colors.blue,
    Colors.yellow,
    Colors.yellow.withOpacity(0),
  ],
  indicatorColorStops: const [0, 0.2, 0.7, 1.0],
  dotColor: Colors.pinkAccent,
  radius: 70,
  strokeWidth: 3,
  indicatorRatio: 0.5,
  dotRadius: 4,
  duration: const Duration(seconds: 2),
)
```
