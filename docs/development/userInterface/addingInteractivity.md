# [Adding interactivity to your Flutter app](https://flutter.dev/docs/development/ui/interactive)

## What you’ll learn

* How to respond to taps.
* How to create a custom widget.
* The difference between stateless and stateful widgets.

How do you modify your app to make it react to user input? you’ll modify an icon to make it tappable by creating a custom stateful widget that manages two stateless widgets.

The [building layouts tutorial](https://flutter.dev/docs/development/ui/layout/tutorial) showed you how to create the layout for the following screenshot.

![image](https://user-images.githubusercontent.com/29271126/98765756-2dc05700-2422-11eb-9bd3-95c514f6d141.png)

When the app first launches, the star is solid red, indicating that this lake has previously been favorited. The number next to the star indicates that 41 people have favorited this lake. After completing this tutorial, tapping the star removes its favorited status, replacing the solid star with an outline and decreasing the count. Tapping again favorites the lake, drawing a solid star and increasing the count.

![image](https://user-images.githubusercontent.com/29271126/98766400-6ceea800-2422-11eb-8dd1-b33672b56c5b.png)

To accomplish this, you’ll create a single custom widget that includes both the star and the count, which are themselves widgets. Tapping the star changes state for both widgets, so the same widget should manage both.

## [Stateful and stateless widgets](https://flutter.dev/docs/development/ui/interactive#stateful-and-stateless-widgets)

A _stateless widget_ never changes. **Icon**, **IconButton**, and **Text** are examples of stateless widgets. Stateless widgets subclass **StatelessWidget**.

A _stateful widget_ is dynamic: for example, it can change its appearance in response to events triggered by user interactions or when it receives data. **Checkbox**, **Radio**, **Slider**, **InkWell**, **Form**, and **TextField** are examples of stateful widgets. Stateful widgets subclass **StatefulWidget**.

A widget’s state is stored in a **State** object, separating the widget’s state from its appearance. The state consists of values that can change, like a slider’s current value or whether a checkbox is checked. When the widget’s state changes, the state object calls _setState()_, telling the framework to redraw the widget.

## [Creating a stateful widget](https://flutter.dev/docs/development/ui/interactive#creating-a-stateful-widget)

### What's the point?

* A stateful widget is implemented by two classes: a subclass of StatefulWidget and a subclass of State.
* The state class contains the widget’s mutable state and the widget’s build() method.
* When the widget’s state changes, the state object calls setState(), telling the framework to redraw the widget.

Implementing a custom stateful widget requires creating two classes:

* A subclass of StatefulWidget that defines the widget.
* A subclass of State that contains the state for that widget and defines the widget’s build() method.

### [Step 1: Decide which object manages the widget’s state](https://flutter.dev/docs/development/ui/interactive#step-1-decide-which-object-manages-the-widgets-state)

A widget’s state can be managed in several ways, but in our example the widget itself, _FavoriteWidget_, will manage its own state. In this example, toggling the star is an isolated action that doesn’t affect the parent widget or the rest of the UI, so the widget can handle its state internally.

### [Step 2: Subclass StatefulWidget](https://flutter.dev/docs/development/ui/interactive#step-2-subclass-statefulwidget)

The _FavoriteWidget_ class manages its own state, so it overrides **createState()** to create a **State** object. The framework calls **createState()** when it wants to build the widget. In this example, **createState()** returns an instance of *_FavoriteWidgetState*, which you’ll implement in the next step.

#### lib/main.dart (FavoriteWidget)

```
class FavoriteWidget extends StatefulWidget {
  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}
```

    Note: Members or classes that start with an underscore (_) are private. For more information, see [Libraries and visibility](https://dart.dev/guides/language/language-tour#libraries-and-visibility), a section in the [Dart language tour](https://dart.dev/guides/language/language-tour).

### [Step 3: Subclass State](https://flutter.dev/docs/development/ui/interactive#step-3-subclass-state)

The __FavoriteWidgetState_ class stores the mutable data that can change over the lifetime of the widget. When the app first launches, the UI displays a solid red star, indicating that the lake has “favorite” status, along with 41 likes.

These values are stored in the _isFavorited and _favoriteCount fields:

#### lib/main.dart (_FavoriteWidgetState fields)

```
class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = true;
  int _favoriteCount = 41;
  // ···
}
```

The class also defines a **build()** method, which creates a row containing a red **IconButton**, and **Text**. You use **IconButton** (instead of Icon) because it has an _onPressed_ property that defines the callback function (_toggleFavorite) for handling a tap.

You’ll define the callback function next.

#### lib/main.dart (_FavoriteWidgetState build)

```
class _FavoriteWidgetState extends State<FavoriteWidget> {
  // ···
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(0),
          child: IconButton(
            padding: EdgeInsets.all(0),
            alignment: Alignment.centerRight,
            icon: (_isFavorited ? Icon(Icons.star) : Icon(Icons.star_border)),
            color: Colors.red[500],
            onPressed: _toggleFavorite,
          ),
        ),
        SizedBox(
          width: 18,
          child: Container(
            child: Text('$_favoriteCount'),
          ),
        ),
      ],
    );
  }
}
```

The __toggleFavorite()_ method, which is called when the **IconButton** is pressed, calls **setState().** Calling **setState()** is critical, because this tells the framework that the widget’s state has changed and that the widget should be redrawn.

The function argument to **setState()** toggles the UI between these two states:

* A star icon and the number 41
* A star_border icon and the number 40

```
void _toggleFavorite() {
  setState(() {
    if (_isFavorited) {
      _favoriteCount -= 1;
      _isFavorited = false;
    } else {
      _favoriteCount += 1;
      _isFavorited = true;
    }
  });
}
```

### [Step 4: Plug the stateful widget into the widget tree](https://flutter.dev/docs/development/ui/interactive#step-4-plug-the-stateful-widget-into-the-widget-tree)

Add your custom stateful widget to the widget tree in the app’s **build()** method. First, locate the code that creates the **Icon** and **Text**, and delete it.

In the same location, create the stateful widget:

#### layout/lakes/{step6 → interactive}/lib/main.dart

```
 @@ -10,2 +5,2 @@    
  class MyApp extends StatelessWidget {            
    @override            
 @@ -38,11 +33,7 @@    
                ],            
              ),            
            ),            
-           Icon(            
+           FavoriteWidget(),            
-             Icons.star,            
-             color: Colors.red[500],            
-           ),            
-           Text('41'),            
          ],            
        ),            
      );            
 @@ -114,3 +105,5 @@    
            ),            
          ),            
        ],            
+     );            
+   }
```

---

</br>

## [Managing state](https://flutter.dev/docs/development/ui/interactive#managing-state)

### What's the point?

* There are different approaches for managing state.
* You, as the widget designer, choose which approach to use.
* If in doubt, start by managing state in the parent widget.

Who manages the stateful widget’s state? The answer is… it depends. There are several valid ways to make your widget interactive. You, as the widget designer, make the decision based on how you expect your widget to be used.

Here are the most common ways to manage state:

* [The widget manages its own state](https://flutter.dev/docs/development/ui/interactive#self-managed)
* [The parent manages the widget’s state](https://flutter.dev/docs/development/ui/interactive#parent-managed)
* [A mix-and-match approach](https://flutter.dev/docs/development/ui/interactive#mix-and-match)

How do you decide which approach to use? The following principles should help you decide:

* If the state in question is user data, for example the checked or unchecked mode of a checkbox, or the position of a slider, then the state is best managed by the parent widget.

* If the state in question is aesthetic, for example an animation, then the state is best managed by the widget itself.

_If in doubt, start by managing state in the parent widget._

### [The widget manages its own state](https://flutter.dev/docs/development/ui/interactive#the-widget-manages-its-own-state)

Sometimes it makes the most sense for the widget to manage its state internally. For example, **ListView** automatically scrolls when its content exceeds the render box. Most developers using **ListView** don’t want to manage ListView’s scrolling behavior, so **ListView** itself manages its scroll offset.

The *_TapboxAState* class:

* Manages state for *TapboxA*.
* Defines the *_active* boolean which determines the box’s current color.
* Defines the *_handleTap()* function, which updates *_active* when the box is tapped and calls the **setState()** function to update the UI.
* Implements all interactive behavior for the widget.

```
// TapboxA manages its own state.

//------------------------- TapboxA ----------------------------------

class TapboxA extends StatefulWidget {
  TapboxA({Key key}) : super(key: key);

  @override
  _TapboxAState createState() => _TapboxAState();
}

class _TapboxAState extends State<TapboxA> {
  bool _active = false;

  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        child: Center(
          child: Text(
            _active ? 'Active' : 'Inactive',
            style: TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
          color: _active ? Colors.lightGreen[700] : Colors.grey[600],
        ),
      ),
    );
  }
}

//------------------------- MyApp ----------------------------------

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Demo'),
        ),
        body: Center(
          child: TapboxA(),
        ),
      ),
    );
  }
}
```

App source: [tapboxA](https://github.com/flexboni/flutter_tutorial/tree/master/examples/development/addingInteractivity/managingState/tapboxA)

---

</br>

### [The parent widget manages the widget’s state](https://flutter.dev/docs/development/ui/interactive#the-parent-widget-manages-the-widgets-state)

Often it makes the most sense for the parent widget to manage the state and tell its child widget when to update. For example, **IconButton** allows you to treat an icon as a tappable button. **IconButton** is a stateless widget because we decided that the parent widget needs to know whether the button has been tapped, so it can take appropriate action.

In the following example, TapboxB exports its state to its parent through a callback. Because TapboxB doesn’t manage any state, it subclasses StatelessWidget.

The ParentWidgetState class:

* Manages the _active state for TapboxB.
* Implements _handleTapboxChanged(), the method called when the box is tapped.
* When the state changes, calls setState() to update the UI.

The TapboxB class:

* Extends StatelessWidget because all state is handled by its parent.
* When a tap is detected, it notifies the parent.

```
// ParentWidget manages the state for TapboxB.

//------------------------ ParentWidget --------------------------------

class ParentWidget extends StatefulWidget {
  @override
  _ParentWidgetState createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  bool _active = false;

  void _handleTapboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TapboxB(
        active: _active,
        onChanged: _handleTapboxChanged,
      ),
    );
  }
}

//------------------------- TapboxB ----------------------------------

class TapboxB extends StatelessWidget {
  TapboxB({Key key, this.active: false, @required this.onChanged})
      : super(key: key);

  final bool active;
  final ValueChanged<bool> onChanged;

  void _handleTap() {
    onChanged(!active);
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        child: Center(
          child: Text(
            active ? 'Active' : 'Inactive',
            style: TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
          color: active ? Colors.lightGreen[700] : Colors.grey[600],
        ),
      ),
    );
  }
}
```

App source: [tapboxB](https://github.com/flexboni/flutter_tutorial/tree/master/examples/development/addingInteractivity/managingState/tapboxB)

    Tip: When creating API, consider using the '@required' annotation for any parameters that your code relies on. To use '@required', import the foundation library (which re-exports Dart’s meta.dart)

---

</br>

### [A mix-and-match approach](https://flutter.dev/docs/development/ui/interactive#a-mix-and-match-approach)

For some widgets, a mix-and-match approach makes the most sense. In this scenario, the stateful widget manages some of the state, and the parent widget manages other aspects of the state.

In the *TapboxC* example, on tap down, a dark green border appears around the box. On tap up, the border disappears and the box’s color changes. *TapboxC* exports its *_active* state to its parent but manages its *_highlight* state internally. This example has two **State** objects, *_ParentWidgetState* and *_TapboxCState*.

The *_ParentWidgetState* object:

* Manages the _active state.
* Implements _handleTapboxChanged(), the method called when the box is tapped.
* Calls setState() to update the UI when a tap occurs and the _active state changes.

The _TapboxCState object:

* Manages the _highlight state.
* The GestureDetector listens to all tap events. As the user taps down, it adds the highlight (implemented as a dark green border). As the user releases the tap, it removes the highlight.
* Calls setState() to update the UI on tap down, tap up, or tap cancel, and the _highlight state changes.
* On a tap event, passes that state change to the parent widget to take appropriate action using the widget property.

```
//---------------------------- ParentWidget ----------------------------

class ParentWidget extends StatefulWidget {
  @override
  _ParentWidgetState createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  bool _active = false;

  void _handleTapboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TapboxC(
        active: _active,
        onChanged: _handleTapboxChanged,
      ),
    );
  }
}

//----------------------------- TapboxC ------------------------------

class TapboxC extends StatefulWidget {
  TapboxC({Key key, this.active: false, @required this.onChanged})
      : super(key: key);

  final bool active;
  final ValueChanged<bool> onChanged;

  _TapboxCState createState() => _TapboxCState();
}

class _TapboxCState extends State<TapboxC> {
  bool _highlight = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _highlight = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTap() {
    widget.onChanged(!widget.active);
  }

  Widget build(BuildContext context) {
    // This example adds a green border on tap down.
    // On tap up, the square changes to the opposite state.
    return GestureDetector(
      onTapDown: _handleTapDown, // Handle the tap events in the order that
      onTapUp: _handleTapUp, // they occur: down, up, tap, cancel
      onTap: _handleTap,
      onTapCancel: _handleTapCancel,
      child: Container(
        child: Center(
          child: Text(widget.active ? 'Active' : 'Inactive',
              style: TextStyle(fontSize: 32.0, color: Colors.white)),
        ),
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
          color:
              widget.active ? Colors.lightGreen[700] : Colors.grey[600],
          border: _highlight
              ? Border.all(
                  color: Colors.teal[700],
                  width: 10.0,
                )
              : null,
        ),
      ),
    );
  }
}
```

App source: [tapboxC](https://github.com/flexboni/flutter_tutorial/tree/master/examples/development/addingInteractivity/managingState/tapboxC)

An alternate implementation might have exported the highlight state to the parent while keeping the active state internal, but if you asked someone to use that tap box, they’d probably complain that it doesn’t make much sense. The developer cares whether the box is active. The developer probably doesn’t care how the highlighting is managed, and prefers that the tap box handles those details.

