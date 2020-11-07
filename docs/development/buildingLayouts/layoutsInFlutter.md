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

[Material Example](https://github.com/flexboni/flutter_tutorial/tree/master/examples/development/buildingLayouts/materialApp)

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

By default a non-Material app doesn’t include an
*AppBar**, title, or background color. If you want these features in a non-Material app, _you have to build them yourself._

[non-Material Example](https://github.com/flexboni/flutter_tutorial/tree/master/examples/development/buildingLayouts/nonMaterialApp)

</br>

## [Lay out multiple widgets vertically and horizontally](https://flutter.dev/docs/development/ui/layout#lay-out-multiple-widgets-vertically-and-horizontally)

You can use a **Row** widget to arrange widgets horizontally, and a **Column** widget to arrange widgets vertically.

### What's the point?

* Row and Column are two of the most commonly used layout patterns.
* Row and Column each take a list of child widgets.
* A child widget can itself be a Row, Column, or other complex widget.
* You can specify how a Row or Column aligns its children, both vertically and horizontally.
* You can stretch or constrain specific child widgets.
* You can specify how child widgets use the Row’s or Column’s available space.

This layout is organized as a Row. The row contains two children: a column on the left, and an image on the right:

![image](https://user-images.githubusercontent.com/29271126/98202990-8ac99200-1f76-11eb-84d5-5e0fc0f42a82.png)

The left column’s widget tree nests rows and columns.

![image](https://user-images.githubusercontent.com/29271126/98203108-cb291000-1f76-11eb-8b1c-60554a272800.png)


    Note> Row and Column are basic primitive widgets for  horizontal and vertical layouts—these low-level widgets allow for maximum customization. Flutter also offers specialized, higher level widgets that might be sufficient for your needs.

</br>

## [Aligning widgets](https://flutter.dev/docs/development/ui/layout#aligning-widgets)

You control how a row or column aligns its children using the **mainAxisAlignment** and **crossAxisAlignment** properties. _For a row_, _the main axis runs horizontally_ and the cross axis runs vertically. _For a column_, _the main axis runs vertically_ and the cross axis runs horizontally.

![image](https://user-images.githubusercontent.com/29271126/98203986-7b4b4880-1f78-11eb-871f-0dc9f0c6dad4.png)

### Row & Column Example

[App Source](https://github.com/flexboni/flutter_tutorial/tree/master/examples/development/buildingLayouts/rowColumn)

Each of the 3 images is 100 pixels wide. The render box (in this case, the entire screen) is more than 300 pixels wide, so setting the main axis alignment to spaceEvenly divides the free horizontal space evenly between, before, and after each image.

```
Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    Image.asset('images/pic1.jpg'),
    Image.asset('images/pic2.jpg'),
    Image.asset('images/pic3.jpg'),
  ],
);
```

Columns work the same way as rows. The following example shows a column of 3 images, each is 100 pixels high. The height of the render box (in this case, the entire screen) is more than 300 pixels, so setting the main axis alignment to spaceEvenly divides the free vertical space evenly between, above, and below each image.

```
Column(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    Image.asset('images/pic1.jpg'),
    Image.asset('images/pic2.jpg'),
    Image.asset('images/pic3.jpg'),
  ],
);
```

</br>

## [Sizing widgets]()

When a layout is too large to fit a device, a yellow and black striped pattern appears along the affected edge.

![image](https://user-images.githubusercontent.com/29271126/98370168-7b813c00-207d-11eb-8a3a-a2b6b352f053.png)

Widgets can be sized to fit within a row or column by using the **Expanded** widget. To fix the previous example where the row of images is too wide for its render box, wrap each image with an **Expanded** widget.

```
Row(
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    Expanded(
      child: Image.asset('images/pic1.jpg'),
    ),
    Expanded(
      child: Image.asset('images/pic2.jpg'),
    ),
    Expanded(
      child: Image.asset('images/pic3.jpg'),
    ),
  ],
);
```

![image](https://user-images.githubusercontent.com/29271126/98443807-30d0f400-2151-11eb-8842-fc8911667159.png)

[App Source](https://github.com/flexboni/flutter_tutorial/tree/master/examples/development/buildingLayouts/sizing)

Perhaps you want a widget to occupy twice as much space as its siblings. For this, use the **Expanded** widget _flex_ property, an integer that determines the _flex_ factor for a widget. The default _flex_ factor is 1. The following code sets the _flex_ factor of the middle image to 2:

![image](https://user-images.githubusercontent.com/29271126/98443839-72619f00-2151-11eb-9c28-ad7bc4741b47.png)

[App Source](https://github.com/flexboni/flutter_tutorial/tree/master/examples/development/buildingLayouts/sizing2)


// Sizing widgets

