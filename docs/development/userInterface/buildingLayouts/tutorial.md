# [Tutorial](https://flutter.dev/docs/development/ui/layout/tutorial)

## What you’ll learn

* How Flutter’s layout mechanism works.
* How to lay out widgets vertically and horizontally.
* How to build a Flutter layout.

App source: [tutorial](https://github.com/flexboni/flutter_tutorial/tree/master/examples/development/buildingLayouts/tutorial)

This is a guide to building layouts in Flutter. You’ll build the layout for the following app:

![image](https://user-images.githubusercontent.com/29271126/98753876-b6ca9480-2408-11eb-84a4-1c1e7c23ac53.png)

## [Step 0: Create the app base code](https://flutter.dev/docs/development/ui/layout/tutorial#step-0-create-the-app-base-code)

Make sure to set up your environment, then do the following:

1. [Create a basic “Hello World” Flutter app.](https://flutter.dev/docs/get-started/codelab#step-1-create-the-starter-flutter-app)
2. Change the app bar title and the app title as follows:

```
    @override            
    Widget build(BuildContext context) {            
      return MaterialApp(            
 -      title: 'Welcome to Flutter',            
 +      title: 'Flutter layout demo',            
        home: Scaffold(            
          appBar: AppBar(            
 -          title: Text('Welcome to Flutter'),            
 +          title: Text('Flutter layout demo'),            
          ),            
          body: Center(            
            child: Text('Hello World'),
```

## [Step 1: Diagram the layout](https://flutter.dev/docs/development/ui/layout/tutorial#step-1-diagram-the-layout)

The first step is to break the layout down to its basic elements:

*   Identify the rows and columns.
*   Does the layout include a grid?
*   Are there overlapping elements?
*   Does the UI need tabs?
*   Notice areas that require alignment, padding, or borders.

First, identify the larger elements. In this example, four elements are arranged into a column: an image, two rows, and a block of text.

![image](https://user-images.githubusercontent.com/29271126/98754050-28a2de00-2409-11eb-8e12-b1ec37a84616.png)

Next, diagram each row. The first row, called the Title section, has 3 children: a column of text, a star icon, and a number. Its first child, the column, contains 2 lines of text. That first column takes a lot of space, so it must be wrapped in an Expanded widget.

![image](https://user-images.githubusercontent.com/29271126/98754062-35273680-2409-11eb-94bc-689d8621cfda.png)

The second row, called the Button section, also has 3 children: each child is a column that contains an icon and text.

![image](https://user-images.githubusercontent.com/29271126/98754087-43755280-2409-11eb-9851-d83c8e4f82fc.png)

Once the layout has been diagrammed, it’s easiest to take a bottom-up approach to implementing it. To minimize the visual confusion of deeply nested layout code, place some of the implementation in variables and functions.

## [Step 2: Implement the title row](https://flutter.dev/docs/development/ui/layout/tutorial#step-2-implement-the-title-row)

First, you’ll build the left column in the title section. Add the following code at the top of the **build()** method of the _MyApp_ class:

### lib/main.dart (titleSection)

```
Widget titleSection = Container(
  padding: const EdgeInsets.all(32),
  child: Row(
    children: [
      Expanded(
        /*1*/
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*2*/
            Container(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                'Oeschinen Lake Campground',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              'Kandersteg, Switzerland',
              style: TextStyle(
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
      /*3*/
      Icon(
        Icons.star,
        color: Colors.red[500],
      ),
      Text('41'),
    ],
  ),
);
```

1. Putting a **Column** inside an **Expanded** widget stretches the column to use all remaining free space in the row. Setting the _crossAxisAlignment_ property to _CrossAxisAlignment.start_ positions the column at the start of the row.
2. Putting the first row of text inside a **Container** enables you to add padding. The second child in the **Column**, also text, displays as grey.
3. The last two items in the title row are a star icon, painted red, and the text “41”. The entire row is in a **Container** and padded along each edge by 32 pixels.

Add the title section to the app body like this:

### {../base → step2}/lib/main.dart

```
     return MaterialApp(            
       title: 'Flutter layout demo',            
       home: Scaffold(            
         appBar: AppBar(            
           title: Text('Flutter layout demo'),            
         ),            
   -     body: Center(            
   -       child: Text('Hello World'),            
   +     body: Column(            
   +       children: [            
   +         titleSection,            
   +       ],            
         ),            
       ),            
     );
```

## [Step 3: Implement the button row](https://flutter.dev/docs/development/ui/layout/tutorial#step-3-implement-the-button-row)

The button section contains 3 columns that use the same layout—an icon over a row of text. The columns in this row are evenly spaced, and the text and icons are painted with the primary color.

Since the code for building each column is almost identical, create a private helper method named _buildButtonColumn()_, which takes a color, an **Icon** and **Text**, and returns a column with its widgets painted in the given color.

### lib/main.dart (_buildButtonColumn)

```
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ···
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}   
```

The function adds the icon directly to the column. The text is inside a Container with a top-only margin, separating the text from the icon.

Build the row containing these columns by calling the function and passing the color, Icon, and text specific to that column. Align the columns along the main axis using **MainAxisAlignment.spaceEvenly** to arrange the free space evenly before, between, and after each column.

Add the following code just below the titleSection declaration inside the build() method:

### lib/main.dart (buttonSection)

```
Color color = Theme.of(context).primaryColor;

Widget buttonSection = Container(
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      _buildButtonColumn(color, Icons.call, 'CALL'),
      _buildButtonColumn(color, Icons.near_me, 'ROUTE'),
      _buildButtonColumn(color, Icons.share, 'SHARE'),
    ],
  ),
);
```

## [Step 4: Implement the text section](https://flutter.dev/docs/development/ui/layout/tutorial#step-4-implement-the-text-section)

Define the text section as a variable. Put the text in a **Container** and add padding along each edge.

Add the following code just below the _buttonSection_ declaration:

### lib/main.dart (textSection)

```
Widget textSection = Container(
  padding: const EdgeInsets.all(32),
  child: Text(
    'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
        'Alps. Situated 1,578 meters above sea level, it is one of the '
        'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
        'half-hour walk through pastures and pine forest, leads you to the '
        'lake, which warms to 20 degrees Celsius in the summer. Activities '
        'enjoyed here include rowing, and riding the summer toboggan run.',
    softWrap: true,
  ),
);
```

By setting softwrap to true, text lines will fill the column width before wrapping at a word boundary.

Add the text section to the body:

### {step3 → step4}/lib/main.dart

```
@@ -59,3 +72,3 @@    
  return MaterialApp(            
    title: 'Flutter layout demo',            
    home: Scaffold(            
@@ -66,6 +79,7 @@
    children: [            
      titleSection,            
      buttonSection,            
+     textSection,            
      ],            
    ),            
  ),
```

## [Step 5: Implement the image section](https://flutter.dev/docs/development/ui/layout/tutorial#step-5-implement-the-image-section)

Three of the four column elements are now complete, leaving only the image.

Add the image file to the example:

* Create an images directory at the top of the project.
* Add [lake.jpg.](https://raw.githubusercontent.com/flutter/website/master/examples/layout/lakes/step5/images/lake.jpg)
* Update the _pubspec.yaml_ file to include an assets tag. This makes the image available to your code.

### {step4 → step5}/pubspec.yaml

```
@@ -17,3 +17,5 @@    
  flutter:            
    uses-material-design: true            
+   assets:            
+     - images/lake.jpg
```

Now you can reference the image from your code:

### {step4 → step5}/lib/main.dart

```
@@ -77,6 +77,12 @@    
  ),            
  body: Column(            
    children: [            
+     Image.asset(            
+       'images/lake.jpg',            
+       width: 600,            
+       height: 240,            
+       fit: BoxFit.cover,            
+     ),            
      titleSection,            
      buttonSection,            
      textSection,
```

BoxFit.cover tells the framework that the image should be as small as possible but cover its entire render box.

## [Step 6: Final touch](https://flutter.dev/docs/development/ui/layout/tutorial#step-6-final-touch)

In this final step, arrange all of the elements in a **ListView**, rather than a **Column**, because a **ListView** supports app body scrolling when the app is run on a small device.

### {step5 → step6}/lib/main.dart

```
@@ -72,13 +77,13 @@    
 return MaterialApp(            
   title: 'Flutter layout demo',            
   home: Scaffold(            
     appBar: AppBar(            
       title: Text('Flutter layout demo'),            
     ),            
-    body: Column(            
+    body: ListView(            
       children: [            
         Image.asset(            
           'images/lake.jpg',            
           width: 600,            
           height: 240,            
           fit: BoxFit.cover,
```

