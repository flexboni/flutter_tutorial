# [Layouts in Flutter](https://flutter.dev/docs/development/ui/layout)

## What's the point?

* Widgets are classes used to build UIs.
* Widgets are used for both layout and UI elements.
* Compose simple widgets to build complex widgets.

The core of Flutter’s layout mechanism is widgets. In Flutter, almost everything is a widget—even layout models are widgets. You create a layout by composing widgets to build more complex widgets.

![image](https://user-images.githubusercontent.com/29271126/98070536-b9773800-1ea4-11eb-8288-e1f760b8339e.png)

The second screenshot displays the visual layout, showing a row of 3 columns where each column contains an icon and a label.

![image](https://user-images.githubusercontent.com/29271126/98070643-dad82400-1ea4-11eb-89f8-475ec99a51ca.png)

[Container](https://api.flutter.dev/flutter/widgets/Container-class.html) is a widget class that allows you to customize its child widget. Use a Container when you want to add padding, margins, borders, or background color, to name some of its capabilities.

</br>

## [Lay out a widget](https://flutter.dev/docs/development/ui/layout#lay-out-a-widget)

How do you layout a single widget in Flutter? This section shows you how to create and display a simple widget. It also shows the entire code for a simple Hello World app.

### [1. Select a layout widget](https://flutter.dev/docs/development/ui/layout#1-select-a-layout-widget)

Choose from a variety of layout widgets based on how you want to align or constrain the visible widget, as these characteristics are typically passed on to the contained widget.

This example uses Center which centers its content horizontally and vertically.

### [2. Create a visible widget](https://flutter.dev/docs/development/ui/layout#2-create-a-visible-widget)

#### For example

create a Text widget:

```
Text('Hello World'),
```

Create an Image widget:

```
Image.asset(
  'images/lake.jpg',
  fit: BoxFit.cover,
),
```

Create an Icon widget:

```
Icon(
  Icons.star,
  color: Colors.red[500],
),
```

### [3. Add the visible widget to the layout widget
](https://flutter.dev/docs/development/ui/layout#3-add-the-visible-widget-to-the-layout-widget)

All layout widgets have either of the following:

* A _child_ property if they take a single child—for example, Center or Container
* A _children_ property if they take a list of widgets—for example, **Row**, **Column**, **ListView**, or **Stack**.

### [4. Add the layout widget to the page
](https://flutter.dev/docs/development/ui/layout#4-add-the-layout-widget-to-the-page)

A Flutter app is itself a widget, and most widgets have a **build()** method. Instantiating and returning a widget in the app’s **build()** method displays the widget.

#### [Material apps](https://flutter.dev/docs/development/ui/layout#material-apps)

For a _Material_ app, you can use a **Scaffold** widget; it provides a default banner, background color, and has API for adding drawers, snack bars, and bottom sheets.

Then you can add the **Center** widget _directly to the body property_ for the home page.

```
// lib/main.dart (MyApp)

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter layout demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter layout demo'),
        ),
        body: Center( // <--- here
          child: Text('Hello World'),
        ),
      ),
    );
  }
```

[Material Example](https://github.com/flexboni/flutter_tutorial/blob/master/lib/materialmain1.dart)

#### [Non-Material apps](https://flutter.dev/docs/development/ui/layout#non-material-apps)

For a _non-Material_ app, you can add the **Center** widget to the app’s **build()** method:

```
// lib/main.dart (MyApp)

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Center( // <--- here
        child: Text(
          'Hello World',
          textDirection: TextDirection.ltr,
          style: TextStyle(
            fontSize: 32,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
```

By default a non-Material app doesn’t include an **AppBar**, title, or background color. If you want these features in a non-Material app, _you have to build them yourself._

[non-Material Example](https://github.com/flexboni/flutter_tutorial/blob/master/lib/nonmaterialmain1.dart)
