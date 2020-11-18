# Flutter for Android developers

## What is the equivalent of a View in Flutter?

In Flutter, the rough equivalent to a **View** is a **Widget**.</br>
Widgets or their state change, Flutter's framework creates a new tree of widget instances.</br>
Android View is drawn once and does not redraw until _invalidate_ is called.</br>
Flutter's Widgets adr lightweight, in part due to their immutablilty. Because they aren't views themselves, and aren't directly drawing anythin, but rather are a description of the UI and its semantics that get "inflated" into actual view objects under the hood.

In Android, you update your views by directly mutating them.

However, In Flutter, Widgets are immutable and are not updated directly, instead you have to work with the widget's state.

## How do I update widgets?

### StatelessWidget

A StatelessWidget is just what it sounds like a widget with no state information. It is useful when the part of the user interface you are describing does not depend on anything other than the configuration information in object.

    ex) In Android, this is smilar to placing an 'ImageView'  with your logo. The logo not going to change during runtime, so use a StatelessWidget in Flutter.

```
    Text(
        'I like Flutter!',
        style: TextStyle(fontWeight: fontWeight.bold),
    );
```

### StatefulWidget

If you wanna dynamically change the UI based on date received after making an HTTP call or user interaction then you have to work with **StatefulWidget** and tell the Flutter framework that the widget's _State_ has been updated so it can update that widget.

### Important things

At the core, bothe stateless and stateful widgets behave the same. They rebuild every frame, the difference is **the StatefulWidget** has a _State_ object that stores state data across frames and restores it.

### Remember the rule!!

If a widget changes (because of user interactions, for example) it's _stateful_.

However, if a widget reacts to change, the containing parent widget can still be _stateless_ if it doesn't itself react to change.

### StatelessWidget + StatefulWidget Example

If you wanna make "I Like Flutter" change dynamically when cliking a FloatingActionButton, achieve this, wrap the 'Text' widget in a StatefulWidget and update it when the user clicks the button.

### For build

Dir : lib -> main2.dart

If you wanna build the source, change 'main2.dart' to 'main.dart'

</br>

## How do i add or remove a component from my layout?

Widgets are immutable there is no direct equivalent to 'addChild()'. Instead, you can pass a function to the parent that returns a widget, and control that child' creation with a boolean flag.

### Example

How you can toggle between two widgets when you click on a FloatingActionButton!

#### For build

Dir : lib -> main3.dart

If you wanna build the source, change 'main3.dart' to 'main.dart'

</br>

## How do i animate a widget?

### In Android

Create animations using XML, or call the 'animate()' method on a view.

### In Flutter

Animate widgets using the animation library by wrapping widgets inside an animated widget.</br>
Use an 'AnimationController' which is an 'Animation< double>' that can pause, seek, stop and reverse the animation. It requires a 'Ticker' that signals when [vsync](https://dict.naver.com/search.nhn?dicQuery=vsync&query=vsync&target=dic&ie=utf8&query_utf=&isOnlyViewEE=) happens, and produces a linear interpolation between 0 and 1 on each frame while it's running.

### For example

The following example shows how to write a **FadeTransition** that fades the widget into a logo when you press the **FloatingActionButton**:

#### For build

Dir : lib -> main4.dart

If you wanna build the source, change 'main4.dart' to 'main.dart'

### For more information

See [Animation & Motion widgets](https://flutter.dev/docs/development/ui/widgets/animation), the [Animations tutorial](https://flutter.dev/docs/development/ui/animations/tutorial), and the [Animations overview](https://flutter.dev/docs/development/ui/animations).





https://flutter.dev/docs/get-started/flutter-for/android-devs#how-do-i-use-a-canvas-to-drawpaint