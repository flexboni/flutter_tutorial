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

### [Aligning widgets](https://flutter.dev/docs/development/ui/layout#aligning-widgets)

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

### [Sizing widgets](https://flutter.dev/docs/development/ui/layout#sizing-widgets)

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

</br>

### [Packing Widget](https://flutter.dev/docs/development/ui/layout#packing-widgets)

By default, a row or column occupies as much space along its main axis as possible, _but if you want to pack the children closely together,_ set its **mainAxisSize** to **MainAxisSize.min**. The following example uses this property to pack the star icons together.

```
Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    Icon(Icons.star, color: Colors.green[500]),
    Icon(Icons.star, color: Colors.green[500]),
    Icon(Icons.star, color: Colors.green[500]),
    Icon(Icons.star, color: Colors.black),
    Icon(Icons.star, color: Colors.black),
  ],
)
```

![image](https://user-images.githubusercontent.com/29271126/98633599-12dbdd00-2365-11eb-85ef-2feff55c049a.png)

[App Source](https://github.com/flexboni/flutter_tutorial/tree/master/examples/development/buildingLayouts/pavlova)

</br>

### [Nesting rows and columns](https://flutter.dev/docs/development/ui/layout#nesting-rows-and-columns)

The layout framework allows you to _nest rows and columns inside of rows and columns as deeply as you need_. Let’s look at the code for the outlined section of the following layout:

![image](https://user-images.githubusercontent.com/29271126/98673896-5b15f200-239b-11eb-902c-375ed463fb01.png)

The outlined section is implemented as two rows. The ratings row contains five stars and the number of reviews. The icons row contains three columns of icons and text.

The widget tree for the ratings row:

![image](https://user-images.githubusercontent.com/29271126/98673990-839dec00-239b-11eb-86d4-3d7ba19f913a.png)

The _ratings_ variable creates a row containing a smaller row of 5 star icons, and text:

```
var stars = Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    Icon(Icons.star, color: Colors.green[500]),
    Icon(Icons.star, color: Colors.green[500]),
    Icon(Icons.star, color: Colors.green[500]),
    Icon(Icons.star, color: Colors.black),
    Icon(Icons.star, color: Colors.black),
  ],
);

final ratings = Container( // <= Here!!
  padding: EdgeInsets.all(20),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      stars,
      Text(
        '170 Reviews',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w800,
          fontFamily: 'Roboto',
          letterSpacing: 0.5,
          fontSize: 20,
        ),
      ),
    ],
  ),
);
```

The icons row, below the ratings row, contains 3 columns; each column contains an icon and two lines of text, as you can see in its widget tree:

![image](https://user-images.githubusercontent.com/29271126/98674239-df687500-239b-11eb-9bb9-835d5128e885.png)

The _iconList_ variable defines the icons row:

```
final descTextStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.w800,
  fontFamily: 'Roboto',
  letterSpacing: 0.5,
  fontSize: 18,
  height: 2,
);

// DefaultTextStyle.merge() allows you to create a default text
// style that is inherited by its child and all subsequent children.
final iconList = DefaultTextStyle.merge(
  style: descTextStyle,
  child: Container(
    padding: EdgeInsets.all(20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Icon(Icons.kitchen, color: Colors.green[500]),
            Text('PREP:'),
            Text('25 min'),
          ],
        ),
        Column(
          children: [
            Icon(Icons.timer, color: Colors.green[500]),
            Text('COOK:'),
            Text('1 hr'),
          ],
        ),
        Column(
          children: [
            Icon(Icons.restaurant, color: Colors.green[500]),
            Text('FEEDS:'),
            Text('4-6'),
          ],
        ),
      ],
    ),
  ),
);
```

The _leftColumn_ variable contains the ratings and icons rows, as well as the title and text that describes the Pavlova:

```
final leftColumn = Container(
  padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
  child: Column(
    children: [
      titleText,
      subTitle,
      ratings,
      iconList,
    ],
  ),
);
```

The left column is placed in a **Container** to constrain its width. Finally, the UI is constructed with the entire row (containing the left column and the image) inside a _Card_.

The _Pavlova image_ is from _Pixabay_. You can embed an image from the net using **Image.network()** but, for this example, the image is saved to an images directory in the project, added to the **pubspec** file, and accessed using **Images.asset()**. For more information, see Adding assets and images.

```
body: Center(
  child: Container(
    margin: EdgeInsets.fromLTRB(0, 40, 0, 30),
    height: 600,
    child: Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 440,
            child: leftColumn,
          ),
          mainImage,
        ],
      ),
    ),
  ),
),
```

---

</br>

## [Common layout widgets](https://flutter.dev/docs/development/ui/layout#common-layout-widgets)

The following widgets fall into two categories: standard widgets from the [widgets library](https://api.flutter.dev/flutter/widgets/widgets-library.html), and specialized widgets from the [Material library](https://api.flutter.dev/flutter/material/material-library.html). Any app can use the widgets library but only Material apps can use the Material Components library.

### [Standard widgets](https://flutter.dev/docs/development/ui/layout#standard-widgets)

* [Container](https://flutter.dev/docs/development/ui/layout#container): Adds padding, margins, borders, background color, or other decorations to a widget.
* [GridView](https://flutter.dev/docs/development/ui/layout#gridView): Lays widgets out as a scrollable grid.
* [ListView](https://flutter.dev/docs/development/ui/layout#listView): Lays widgets out as a scrollable list.
* [Stack](https://flutter.dev/docs/development/ui/layout#stack): Overlaps a widget on top of another.

### [Material widgets](https://flutter.dev/docs/development/ui/layout#material-widgets)

* [Card](https://flutter.dev/docs/development/ui/layout#card): Organizes related info into a box with rounded corners and a drop shadow.
* [ListTile](https://flutter.dev/docs/development/ui/layout#listtile): Organizes up to 3 lines of text, and optional leading and trailing icons, into a row.

### [Container](https://flutter.dev/docs/development/ui/layout#container)

Many layouts make liberal use of **Container**s _to separate widgets using padding, or to add borders or margins_. You can _change the device’s background_ by placing the entire layout into a Container and _changing its background color or image_.

![image](https://user-images.githubusercontent.com/29271126/98676144-9108a580-239e-11eb-8829-5100b565cb5e.png)


#### Summary (Container)

* Add padding, margins, borders
* Change background color or image
* Contains a single child widget, but that child can be a Row, Column, or even the root of a widget tree

#### Examples (Container)

![image](https://user-images.githubusercontent.com/29271126/98676350-d62cd780-239e-11eb-8e82-d218fd0682be.png)

App source: [container](https://github.com/flexboni/flutter_tutorial/tree/master/examples/development/buildingLayouts/container)

---

### [GridView](https://flutter.dev/docs/development/ui/layout#gridview)

Use **GridView** to lay widgets out as _a two-dimensional list_. **GridView** provides two pre-fabricated lists, or you can build your own custom grid. When a **GridView** detects that its contents are too long to fit the render box, it automatically scrolls.

#### Summary (GridView)

* Lays widgets out in a grid
* Detects when the column content exceeds the render box and automatically provides scrolling
* Build your own custom grid, or use one of the provided grids:
  * GridView.count allows you to specify the number of columns
  * GridView.extent allows you to specify the maximum pixel width of a tile

#### Example (Grid)

![image](https://user-images.githubusercontent.com/29271126/98680281-85b87880-23a4-11eb-8777-e6fc12b0954c.png)

Uses GridView.extent to create a grid with tiles a maximum 150 pixels wide.

App source: [grid](https://github.com/flexboni/flutter_tutorial/tree/master/examples/development/buildingLayouts/grid)

---

### [ListView](https://flutter.dev/docs/development/ui/layout#listview)

**ListView**, a column-like widget, automatically provides scrolling when its content is too long for its render box.

#### Summary (ListView)

* A specialized Column for organizing a list of boxes
* Can be laid out horizontally or vertically
* Detects when its content won’t fit and provides scrolling
* Less configurable than Column, but easier to use and supports scrolling

#### Examples (ListView)

![image](https://user-images.githubusercontent.com/29271126/98681866-910ca380-23a6-11eb-9526-804a169518d3.png)

Uses **ListView** to display a list of businesses using **ListTile**s. A **Divider** separates the theaters from the restaurants.

App source: [list](https://github.com/flexboni/flutter_tutorial/tree/master/examples/development/buildingLayouts/list)

---

### [Stack](https://flutter.dev/docs/development/ui/layout#stack)

Use **Stack** to arrange widgets on top of a base widget—often an image. The widgets can completely or partially overlap the base widget.

#### Summary (Stack)

* Use for widgets that overlap another widget
* The first widget in the list of children is the base widget; subsequent children are overlaid on top of that base widget
* A Stack’s content can’t scroll
* You can choose to clip children that exceed the render box

#### Examples (Stack)

![image](https://user-images.githubusercontent.com/29271126/98683079-f90fb980-23a7-11eb-8214-51ac220ec53a.png)

Uses **Stack** to overlay a **Container** (that displays its **Text** on a translucent black background) on top of a **CircleAvatar**. The **Stack** offsets the text using the _alignment_ property and **Alignment**s.

App source: [stack](https://github.com/flexboni/flutter_tutorial/tree/master/examples/development/buildingLayouts/stack)

---

### [Card](https://flutter.dev/docs/development/ui/layout#card)

A **Card**, from the [Material library](https://api.flutter.dev/flutter/material/material-library.html), contains related nuggets of information and can be composed from almost any widget, but is often used with **ListTile**. **Card** has a single child, but its child can be a column, row, list, grid, or other widget that supports multiple children. By default, a **Card** shrinks its size to 0 by 0 pixels. You can use _SizedBox_ to constrain the size of a card.

In Flutter, a **Card** features slightly rounded corners and a drop shadow, giving it a 3D effect. Changing a Card’s _elevation_ property allows you to control the drop shadow effect. Setting the elevation to 24, for example, visually lifts the **Card** further from the surface and causes the shadow to become more dispersed. For a list of supported elevation values, see _Elevation_ in the [Material guidelines](https://material.io/design). Specifying an unsupported value disables the drop shadow entirely.

#### Summary (Card)

* Implements a Material card
* Used for presenting related nuggets of information
* Accepts a single child, but that child can be a Row, Column, or other widget that holds a list of children
* Displayed with rounded corners and a drop shadow
* A Card’s content can’t scroll
* From the Material library

#### Examples (Card)

![image](https://user-images.githubusercontent.com/29271126/98686003-6709b000-23ab-11eb-9922-28e02318c9ed.png)

A **Card** containing 3 **ListTiles** and sized by wrapping it with a **SizedBox**. A _Divider_ separates the first and second ListTiles.

App source: [card](https://github.com/flexboni/flutter_tutorial/tree/master/examples/development/buildingLayouts/card)

---

### [ListTile](https://flutter.dev/docs/development/ui/layout#listtile)

Use **ListTile**, a specialized row widget from the [Material library](https://api.flutter.dev/flutter/material/material-library.html), for an easy way to create a row containing up to 3 lines of text and optional leading and trailing icons. **ListTile** is most commonly used in **Card** or **ListView**, but can be used elsewhere.

#### Summary (ListTile)

* A specialized row that contains up to 3 lines of text and optional icons
* Less configurable than Row, but easier to use
* From the [Material library](https://api.flutter.dev/flutter/material/material-library.html)

#### Examples (ListTile)

![image](https://user-images.githubusercontent.com/29271126/98686003-6709b000-23ab-11eb-9922-28e02318c9ed.png)

A **Card** containing 3 **ListTiles**.

App source: [card](https://github.com/flexboni/flutter_tutorial/tree/master/examples/development/buildingLayouts/card)

---

### [Constraints](https://flutter.dev/docs/development/ui/layout#constraints)

To fully understand Flutter’s layout system, you need to learn how Flutter positions and sizes the components in a layout. For more information, see [Understanding constraints](https://flutter.dev/docs/development/ui/layout/constraints).