# Slide Puzzle: Escape of Cao Cao

This is a puzzle game made on live-stream with Flutter, demonstrating various animation techniques
and targeting mobile, desktop, and the web from a single code base.

The goal of the game is to move "the biggest puzzle piece (Cao Cao)" to the "exit" at the bottom, in
as few steps as possible.

## Release Notes

#### v1.2.0

- Added more levels.
- Added a new 3D animation during level transitions.
- Various UI and UX improvements.

#### v1.1.0

- Added a simple tutorial screen.
- Fixed a bug where the web version was not rendering correctly on mobile browsers.

#### v1.0.0

- Initial release for all platforms.

## Multi-platform

The project is made with Flutter and runs on multiple platforms including Windows, macOS, Linux,
Android, iOS, and the web.

<img alt="multi-platform: a photo of the app running on multiple devices" width="200"
src="https://flutter-challenge.s3.us-west-2.amazonaws.com/hosting/multi-platform.jpg" />

When building for web, make sure to use `canvaskit` renderer for better experience on mobile
browsers. You can do so with `flutter build web --web-renderer canvaskit` command.

## How It's Made

#### Live Stream

<img alt="live-stream: a screenshot of a live coding session" width="200"
src="https://flutter-challenge.s3.us-west-2.amazonaws.com/hosting/live-stream.jpg" />

The creation of the entire project was streamed live. With viewers discussing and voting on things
like color choices, together, the initial version was built in 12 live-stream sessions.

#### Commit History

The "Initial commit" contains the famous "Flutter counter" demo that comes with new Flutter
projects, and 12 subsequent commits correspond to each of the live stream sessions, ranging from
Jan. 26 to Feb. 14, 2022.

After the project is completed on live stream, I then made a few more commits enabling desktop
support, fixing minor issues and updating the README file. The initial version was released on Feb.
22, and a [short video (less than 3 min)](https://www.youtube.com/watch?v=VFiejrt7uTk) explaining
the project was published on the same day.

#### Further Updates

A few more improvements were made after the initial release. These improvements are not covered in
the video, so I'll briefly summarize them here.

##### New Tutorial Dialog

A new "How to Play" screen was added to the game. It's a responsive dialog made with `LayoutBuilder`
and `ConstrainedBox`, and decorated by `CupertinoPopupSurface`. It also used a
`WillPopScope` to allow users to dismiss the dialog with the back button on Android devices.

##### New End-Level Transition

This is my first time trying to simulate 3D objects without any 3rd party tools or plugins in
Flutter. It's made using `Transform` widgets to translate and rotate 6 rectangles to correct places
to form a cuboid. I also created a super basic "design studio" interface to facilitate the
development process.

<img alt="a 3d cube made in flutter" width="200"
src="https://flutter-challenge.s3.us-west-2.amazonaws.com/hosting/cube-3d.gif" />

Further optimizations were made so only up to 3 faces (visible to the viewers) are rendered at a
time. This formed the basis for a new transition animation when a level is completed.

<img alt="a 3d cube made in flutter" width="200"
src="https://flutter-challenge.s3.us-west-2.amazonaws.com/hosting/cao-3d.gif" />

## Web Demo

[![web demo](https://flutter-challenge.s3.us-west-2.amazonaws.com/hosting/web-demo.jpg)](
https://d1qjxjz3vso8bm.cloudfront.net/)

[A playable web version is available](https://d1qjxjz3vso8bm.cloudfront.net/). For the best
experience, please use a desktop browser, or install the mobile app.

## Video Overview

Watch the Video in [English](https://www.youtube.com/watch?v=VFiejrt7uTk)
| [Chinese](https://www.bilibili.com/video/BV1y44y1n73G).

[![video](https://flutter-challenge.s3.us-west-2.amazonaws.com/hosting/video-thumbnail.jpg)](
https://www.youtube.com/watch?v=VFiejrt7uTk)

At a high level, the app can be divided into 3 parts: the background layer, the game board, and the
puzzle pieces. Each puzzle piece also comes with a pair of interlocking attachments and a shadow for
some added depth. They are then stacked as different layers, to make sure they always appear in the
correct order. The color palette is configured as an `InheritedWidget` so its values can be modified
in one place, and easily accessed elsewhere in the widget tree.

The puzzle pieces are made from `AnimatedPositioned`. In Flutter, implicit animation widgets like
these are super easy to use - just give them a duration and an optional curve, and they’ll
automatically animate when their values are changed. For the duration, I first check if the window
size is different from before, and if so, I pass in zero. This is to skip the unwanted animation
when the app is being resized. And for the curve, I use `EaseOut` to simulate physical objects being
slowed down by friction.

To handle user input, I added `GestureDetector`. I used the `onUpdate` event instead of the `onEnd`
event here. This reduces input lag, allowing the game to react before the gesture ends. For the
reset button, I also added a `MouseRegion` widget to make it glow when being hovered.

The step counter is another example of utilizing implicit animations in Flutter. It’s also wrapped
in a `ValueListenableBuilder`, so it can always keep up with the steps. I’ve published this widget
as a package on `pub` and made a video explaining how it was made. If you like this animation, you
can import it to your own project.

The game board is mostly a `Container`. I used a `BackdropFilter` to blur everything behind it, and
a `ShaderMask` to create a beam effect. Since we want the beam to keep dancing around, it’s easier
to use explicit animations with a controller. Also, the exit arrows at the bottom, and the
highlighting effect on texts, are all made with Flutter’s explicit animations.

Lastly, I used a `CustomPaint` for the background. A text-painting version was first implemented but
later scrapped because having to layout texts every frame caused some performance issues on the web.
The simplified version looks similar but performs much better, even on low-end devices.

## What's Next

- [x] Resolve web rendering issue for mobile browsers
- [x] Add a tutorial screen to explain the game
- [x] Add more levels to the game
- [ ] Allow users to select levels
- [ ] Add keyboard support
- [ ] Improve swiping gesture

# Extra Resources

I've been making lots of video tutorials (mostly in Chinese) on Flutter, covering a wide range of
topics and popular questions from viewers. If you are interested, please follow me on "bilibili" so
you won't miss the next live stream or video from me.

### Animations

I've made a total of 19 video tutorials on Flutter Animations, divided into 3 sections: implicit,
explicit and others.

- [How to choose the right animations for your needs](https://www.bilibili.com/video/BV1dt4y117J9)

#### Implicit Animations

- [Get moving with just 2 lines of code](https://www.bilibili.com/video/BV1JZ4y1p7NG)
- [Smooth transitioning between different widgets](https://www.bilibili.com/video/BV1Wk4y167V4)
- [Curves, and more animation widgets](https://www.bilibili.com/video/BV1oC4y1H73Q)
- [DIY with a TweenAnimationBuilder](https://www.bilibili.com/video/BV1Q54y1X72E)
- [Case study: make a flip counter](https://www.bilibili.com/video/BV1Ng4y1B754)
- [Case study: flip counter continued](https://www.bilibili.com/video/BV1EV411C7Zq)

#### Explicit Animations

- [A repeating animation](https://www.bilibili.com/video/BV1Ri4y147ny)
- [What is an AnimationController](https://www.bilibili.com/video/BV1iV411C7oN)
- [Curves and Tween](https://www.bilibili.com/video/BV1LT4y1g7MD)
- [Staggered animations with intervals](https://www.bilibili.com/video/BV1sV411C7fs)
- [DIY with an AnimatedBuilder](https://www.bilibili.com/video/BV15p4y1X7Xp)
- [Case study: coordinating multiple animations](https://www.bilibili.com/video/BV1KQ4y1P7Xf)
- [Case study: multiple animation controllers](https://www.bilibili.com/video/BV1zV411C73b)

#### Other types of Animations

- [Under the hood: animations and tickers](https://www.bilibili.com/video/BV1dz411v76Z)
- [Hero animations](https://www.bilibili.com/video/BV1cC4y1a7u6)
- [CustomPaint: do you wanna build a snowman](https://www.bilibili.com/video/BV135411W7wE)
- [Animate with Rive/Flare](https://www.bilibili.com/video/BV1YK4y1x73S)
- [Bonus: create an asset with Rive tool](https://www.bilibili.com/video/BV1fv411z74W)

### Keys

I've made 7 video tutorials on keys, covering basic concepts such as widgets and elements, 3 types
of local keys, 2 different uses of global keys, and more.

- [Spooky stuff when you forget to use keys](https://www.bilibili.com/video/BV1b54y1z7iD)
- [Widgets, Elements and their States](https://www.bilibili.com/video/BV15k4y1B74z)
- [Three types of LocalKeys](https://www.bilibili.com/video/BV1Jz4y1D7Jp)
- [Two purposes of GlobalKeys](https://www.bilibili.com/video/BV1Hf4y1R7Pf)
- [Case study: make a color sorting game](https://www.bilibili.com/video/BV1uA411v7tk)
- [Case study: use LocalKey in the game](https://www.bilibili.com/video/BV1ia4y1a7Wx)
- [Case study: use GlobalKey in the game](https://www.bilibili.com/video/BV1QD4y1m73g)

### Scrollable

- [ListView and lazy loading](https://www.bilibili.com/video/BV1jT4y1A7cN)
- [Deep dive into the ListView widget](https://www.bilibili.com/video/BV1G54y1y75K)
- [RefreshIndicator and NotificationListener](https://www.bilibili.com/video/BV1Xh411R7UA)
- [Swipe away with the Dismissible widget](https://www.bilibili.com/video/BV1UK4y1a7bg)
- [Case study: a GitHub repo browser](https://www.bilibili.com/video/BV1JA411J7xp)
- [GridView widget](https://www.bilibili.com/video/BV1qK4y187MZ)
- [Even more scrollable widgets](https://www.bilibili.com/video/BV1Wk4y1C76n)

### Asynchronous

- [Event loop, queues, and microtasks](https://www.bilibili.com/video/BV12K4y1Z7Zg)
- [Deep dive into the Future type](https://www.bilibili.com/video/BV18K4y1Z7X3)
- [FutureBuilder widget](https://www.bilibili.com/video/BV165411V7PS)
- [Stream and StreamBuilder widget](https://www.bilibili.com/video/BV1Di4y1V78M)
- [Case study: generate stream from user actions](https://www.bilibili.com/video/BV1t5411G7x1)
- [Case study: listen to our event stream](https://www.bilibili.com/video/BV1nK4y1L7j9)
- [Case study: a good use for StreamTransformer](https://www.bilibili.com/video/BV1gK411G7BH)

### Layout

- [Constraints, size, and positions](https://www.bilibili.com/video/BV1254y1s7Zo)
- [LayoutBuilder and ConstraintBox](https://www.bilibili.com/video/BV1TA411p7ST)
- [Flex: Flexible and non-flexible](https://www.bilibili.com/video/BV1kr4y1K7qW)
- [Stack: Positioned and non-positioned](https://www.bilibili.com/video/BV1Gv4y1Z7fD)
- [What is a Container, really](https://www.bilibili.com/video/BV1jK4y1H71r)
- [CustomMultiChildLayout widget](https://www.bilibili.com/video/BV1ZN411X7nD)
- [Let's make a RenderObject](https://www.bilibili.com/video/BV14y4y177Uv)

### Slivers

- [Welcome to the world of Slivers](https://www.bilibili.com/video/BV1RK4y1R74t)
- [All sorts of sliver lists](https://www.bilibili.com/video/BV1xy4y1W7S6)
- [SliverAppBar widget](https://www.bilibili.com/video/BV1V64y1y75V)
- [More sliver widgets and SliverLayoutBuilder](https://www.bilibili.com/video/BV1Vh411a79Q)
- [Case study: convert a ListView into a sliver](https://www.bilibili.com/video/BV1Mw411o7HF)
- [Case study: SliverPersistentHeader](https://www.bilibili.com/video/BV1154y1H7vL)
- [Case study: Design a page with a SliverAppBar](https://www.bilibili.com/video/BV1xP4y1x78X)

### Coding challenge and follow-ups

(Sometimes I post questions for my viewers and then do follow-up videos to discuss all the creative
solutions I receive, so we can learn from each other.)

- [Pinch-to-zoom gallery with smooth transitions](https://www.bilibili.com/video/BV1cq4y1H7HX)
- [A button that counts down with its border](https://www.bilibili.com/video/BV15b4y1Z7EU)
- [Adaptive watermark overlay with FittedBox](https://www.bilibili.com/video/BV1bU4y1h7yd)
- [Different ways to implement Hollowed Text](https://www.bilibili.com/video/BV1Sb4y1Q7U4)
- [Ink, InkWell, and Material](https://www.bilibili.com/video/BV1RV411v7bX)
- [Creative ways to achieve diagonal layout](https://www.bilibili.com/video/BV13p4y1H7ni)
- [Adaptive banner made with Pythagorean Theorem](https://www.bilibili.com/video/BV1mr4y1K7om)
- [The new and the old material buttons](https://www.bilibili.com/video/BV1vh411y7uH)
- [Different ways to implement the same animation](https://www.bilibili.com/video/BV1Ko4y1o7JB)
- [Different ways to detect screen rotation](https://www.bilibili.com/video/BV1So4y1d7dM)

### Other popular topics

- [What is BuildContext?!](https://www.bilibili.com/video/BV1by4y1t7oG)
- [Flutter Web: common problems and solutions](https://www.bilibili.com/video/BV1DS4y1D7Tw)
- [What is SOUND null safety?](https://www.bilibili.com/video/BV1CL4y1z7p5)
- [Some super useful widgets in Flutter](https://www.bilibili.com/video/BV1dP4y1s7N5)
- [Some less known widgets in Flutter](https://www.bilibili.com/video/BV1Mq4y1U75Y)
- [Flutter 2.0 is here!](https://www.bilibili.com/video/BV1nN411Q7As)
- [WillPopScope and iOS swiping gesture](https://www.bilibili.com/video/BV1dB4y1M72A)
- [Weird tricks about Flutter Hot Reload](https://www.bilibili.com/video/BV1eK4y1m7VX)
- [Hotkeys in Android Studio](https://www.bilibili.com/video/BV1R64y1D79a)
- [Publish a package: animated flip counter](https://www.bilibili.com/video/BV163411q7Yw)
- [Publish a package: interactive chart](https://www.bilibili.com/video/BV1xU4y1F71A)
