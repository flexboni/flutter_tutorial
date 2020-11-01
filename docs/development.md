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