# Introduction to widgets

## [Basic widgets](https://flutter.dev/docs/development/ui/widgets-intro#basic-widgets)

### [Text](https://api.flutter.dev/flutter/widgets/Text-class.html)

The **Text** widget let you create a run of styled text within your application

### [Row](https://api.flutter.dev/flutter/widgets/Row-class.html) &  [Column](https://api.flutter.dev/flutter/widgets/Column-class.html)

These flex widgets let you create flexible layouts in both the horizontal **(Row)** and vertical **(Column)** directions. The design of these objects is based on the web’s flexbox layout model.

### [Stack](https://api.flutter.dev/flutter/widgets/Stack-class.html)

Instead of being linearly oriented (either horizontally or vertically), a **Stack** widget lets you place widgets on top of each other in paint order. You can then use the Positioned widget on children of a **Stack** to position them relative to the top, right, bottom, or left edge of the stack. Stacks are based on the web’s absolute positioning layout model.

### [Container](https://api.flutter.dev/flutter/widgets/Container-class.html)

The Container widget lets you create a rectangular visual element. A container can be decorated with a BoxDecoration, such as a background, a border, or a shadow. A Container can also have margins, padding, and constraints applied to its size. In addition, a Container can be transformed in three dimensional space using a matrix.

### [For example](https://github.com/flexboni/flutter_tutorial/blob/master/lib/devmain1.dart) <- Click

Below are some simple widgets that combine these and other widgets:

#### build

Dir : lib -> devmain1.dart

If you wanna build the source, change 'devmain1.dart' to 'main.dart'

</br>

## [Using Material components](https://flutter.dev/docs/development/ui/widgets-intro#using-material-components)

A Material app starts with the MaterialApp widget, which builds a number of useful widgets at the root of your app, including a Navigator, which manages a stack of widgets identified by strings, also known as “routes”. The Navigator lets you transition smoothly between screens of your application. 

## [For example](https://github.com/flexboni/flutter_tutorial/blob/master/lib/devmain2.dart) <- Click

Using the MaterialApp widget is entirely optional but a good practice.

#### build

Dir : lib -> devmain2.dart

If you wanna build the source, change 'devmain2.dart' to 'main.dart'

The Scaffold widget takes a number of different widgets as named arguments, each of which are placed in the Scaffold layout in the appropriate place

</br>

## [Handling Gesture](https://flutter.dev/docs/development/ui/widgets-intro#handling-gestures)

The first step in building an interactive application is to detect input gestures.

## [For example](https://github.com/flexboni/flutter_tutorial/blob/master/lib/devmain3.dart) <- Click

#### build

Dir : lib -> devmain3.dart

If you wanna build the source, change 'devmain3.dart' to 'main.dart'

When the user taps the **Container**, the **GestureDetector** calls its _onTap()_ callback, in this case printing a message to the console. You can use **GestureDetector** to detect a variety of input gestures, including taps, drags, and scales.

Many widgets use a **GestureDetector** to provide optional callbacks for other widgets which have _onPressed()_ callback.

</br>

## [Changing widgets in response to input](https://flutter.dev/docs/development/ui/widgets-intro#changing-widgets-in-response-to-input)

Stateless widgets receive arguments from their parent widget, which they store in _final_ member variables. When a widget is asked to _build()_, it uses these stored values to derive new arguments for the widgets it creates.

In order to build more complex experiences—for example, to react in more interesting ways to user input—applications typically carry some _state_. Flutter uses **StatefulWidgets** to capture this idea. **StatefulWidgets** are special widgets that know how to generate _State_ objects, which are then used to hold state.

## [For example](https://github.com/flexboni/flutter_tutorial/blob/master/lib/devmain4.dart) <- Click

Using the **ElevatedButton** mentioned earlier.

You might wonder why StatefulWidget and State are separate objects. In Flutter, these two types of objects have different life cycles. Widgets are temporary objects, used to construct a presentation of the application in its current state. State objects, on the other hand, are persistent between calls to build(), allowing them to remember information.

The example above accepts user input and directly uses the result in its build() method. In more complex applications, different parts of the widget hierarchy might be responsible for different concerns.

In Flutter, change notifications flow “up” the widget hierarchy by way of callbacks, while current state flows “down” to the stateless widgets that do presentation. The common parent that redirects this flow is the State.

#### build

Dir : lib -> devmain4.dart

If you wanna build the source, change 'devmain4.dart' to 'main.dart'

## [For example](https://github.com/flexboni/flutter_tutorial/blob/master/lib/devmain5.dart) <- Click

The following slightly more complex example shows how this works in practice:

Notice the creation of two new stateless widgets, cleanly separating the concerns of displaying the counter **(CounterDisplay)** and changing the counter **(CounterIncrementor)**.

Although the net result is the same as the previous example, the separation of responsibility allows greater complexity to be _encapsulated in the individual_ widgets, while maintaining simplicity in the parent.

#### build

Dir : lib -> devmain5.dart

If you wanna build the source, change 'devmain5.dart' to 'main.dart'

</br>

## [Bringing it all together](https://flutter.dev/docs/development/ui/widgets-intro#bringing-it-all-together)

What follows is a more complete example that brings together these concepts: A hypothetical shopping application displays various products offered for sale, and maintains a shopping cart for intended purchases.

## [For example](https://github.com/flexboni/flutter_tutorial/blob/master/lib/ShoppingListItem.dart)

Start by defining the presentation class, **ShoppingListItem**:

The **ShoppingListItem** widget follows a common pattern for stateless widgets. It stores the values it receives in its constructor in final member variables, which it then uses during its **build()** function. For example, the **inCart** boolean toggles between two visual appearances: one that uses the primary color from the current theme, and another that uses gray.

When the user taps the list item, the widget doesn’t modify its **inCart** value directly. Instead, the widget calls the **onCartChanged** function it received from its parent widget. This pattern lets you store state higher in the widget hierarchy, which causes the state to persist for longer periods of time. In the extreme, the state stored on the widget passed to **runApp()** persists for the lifetime of the application.

When the parent receives the **onCartChanged** callback, the parent updates its internal state, which triggers the parent to rebuild and create a new instance of **ShoppingListItem** with the new **inCart** value. Although the parent creates a new instance of **ShoppingListItem** when it rebuilds, that operation is cheap because the framework compares the newly built widgets with the previously built widgets and applies only the differences to the underlying RenderObject.

Here’s an example parent widget that stores mutable state:

## [For example](https://github.com/flexboni/flutter_tutorial/blob/master/lib/shoppingmain.dart) <- Click

#### build

Dir : lib -> shoppingmain.dart

If you wanna build the source, change 'shoppingmain.dart' to 'main.dart'

The ShoppingList class extends StatefulWidget, which means this widget stores mutable state. When the ShoppingList widget is first inserted into the tree, the framework calls the createState() function to create a fresh instance of _ShoppingListState to associate with that location in the tree. (Notice that subclasses of State are typically named with leading underscores to indicate that they are private implementation details.) When this widget’s parent rebuilds, the parent creates a new instance of ShoppingList, but the framework reuses the _ShoppingListState instance that is already in the tree rather than calling createState again.

To access properties of the current ShoppingList, the _ShoppingListState can use its widget property. If the parent rebuilds and creates a new ShoppingList, the _ShoppingListState rebuilds with the new widget value. If you wish to be notified when the widget property changes, override the didUpdateWidget() function, which is passed an oldWidget to let you compare the old widget with the current widget.

When handling the onCartChanged callback, the _ShoppingListState mutates its internal state by either adding or removing a product from _shoppingCart. To signal to the framework that it changed its internal state, it wraps those calls in a setState() call. Calling setState marks this widget as dirty and schedules it to be rebuilt the next time your app needs to update the screen. If you forget to call setState when modifying the internal state of a widget, the framework won’t know your widget is dirty and might not call the widget’s build() function, which means the user interface might not update to reflect the changed state. By managing state in this way, you don’t need to write separate code for creating and updating child widgets. Instead, you simply implement the build function, which handles both situations.

