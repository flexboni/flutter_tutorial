# Lifecycle

A Flutter application is just a combination of **Stateful** and **Stateless** Widgets. In this post, we are going to explain basic lifecycle.

## Table of contents
* [The lifecycle of the StatefulWidget](#The-lifecycle-of-the-StatefulWidget)  
* [mounted(true/false)](#mountedtruefalse)
* [initState](#initstate)
* [didChangeDependencies()](#didchangedependencies)
* [build()](#build)
* [didUpdateWidget(Widget oldWidget)](#didupdatewidgetwidget-oldwidget)
* [setState()](#setstate)
* [deactivate()](#deactivate)
* [dispose()](#dispose)
* [Reference](#Reference)

## The lifecycle of the StatefulWidget

A stateful widget has the following lifecycle stages:

![image](https://user-images.githubusercontent.com/29271126/99327719-e3c1f000-28bd-11eb-9eef-91aba0486dde.png)

### createState()

When we create a stateful widget, the framework instruct to **createState()** method. The **createState()** method returns an instance of their associated state as shown above.

```
@override
_MyWidgetState createState() => _MyWidgetState();
```

### mounted(true/false)

Once we create a State object, the framework mounted the **State** object by associating it with a **BuildContext** before calling **initState()** method. All widgets have a bool _mounted_ property. It is turned true when the **buildContext** is assigend.

```
bool get mounted => _element != null;
```

You can use this property when a method in your state calls **setState()**. But it isn't clear when or how the mothod will be called. Let say, it will call in response ot a stream. You can use 

```
if (mounted) {
  ...
}
```

to make sure the **State** exists before calling **setState()**

### initState()

This is the first method called when a *stateful widget* is created after the class constructor. The **initState()** is called only once. It must called **super.initState()**. Here, you can initialize data, properties and subscribe to Streams or any other object that could change the data on this widget.

```
@override
initState() {
  super.initState();
  // TO DO
}
```

### didChangeDependencies()

This method is *called immediately* after **initState()** method on the first time the widget is built.

```
@override
@mustCallSuper
void didChangeDependencies() {
// TO DO
}
```

It will also be called whenever an object that this widget depends on data from is called. For example, if it relies on an Inherited Widget, which updates.

The build method is always called after **didChangedDependencies** is called, so this is rarely needed.

### build()

It shows the part of the user interface represented by the widget. The framework calls this method in several different situations:
* After calling **initState()** method.
* The framework always calls **build()** method after calling **didUpdateWidget**.
* After receiving a call for **setState** to update the screen.

```
@override
Widget build(BuildContext context, MyButtonState state) {
  return Container(color: const Color(0xFF2DBD3A));
}
```

### didUpdateWidget(Widget oldWidget)

If the parend widget change configuration and has to rebuild this widget. But it's being rebuild with the same _runtimeType_, then **didUpdateWidget()** method is called. The framework updates the widget property of this state object to refer to the new widget and then call this method with the previous widget as an argument.

```
@mustCallSuper
@protected
void didUpdateWidget(convariant T oldWidget) {
  // TO DO
}
```

### setState()

This method is called from the framework and the developer. We can change the internal state of a **State** object and make the change in a function that you pass to **setState**. The setState notifies the framework that the internal state of current object has changed in a way that might impact the user intercafe, which cause the framework to call the build method for this **State** object.

```
@override
_MyWidgetState createState() => _MyWidgetState();
```

### deactivate()

This is called when **State** is removed from the widgets tree, but it might be reinserted before the current frame change is finished. This method exists because **State** objects can be moved from one point in a tree to another.

```
@protected
@mustCallSuper
void deactivate() {
  // TO DO
}
```

### dispose()

This is called when the **State** object is removed permanently. Here you can unsubscribe and cancel all animations, streams, etc.

```
@protected
@mustCallSuper
void dispose() {
  assert(_debugLifecycleState == _StateLifecycle.ready);
  assert(() {
    _debugLifecycleState = _StateLifecycle.defunct;
    return ture;
  });
}
```

## Reference

* https://www.developerlibs.com/2019/12/flutter-lifecycle-widgets.html
* https://www.xspdf.com/help/51642948.html