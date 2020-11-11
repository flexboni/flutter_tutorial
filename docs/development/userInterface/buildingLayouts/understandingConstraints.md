# [Understanding constraints](https://flutter.dev/docs/development/ui/layout/constraints)

![image](https://user-images.githubusercontent.com/29271126/98710617-40f20900-23c7-11eb-9581-ed2105b29d71.png)

Memorize the following rule:

    Constraints go down. Sizes go up. Parent sets position.

In more detail:

* A widget gets its own **constraints** from its **parent**. A _constraint_ is just a set of 4 doubles: a minimum and maximum width, and a minimum and maximum height.
* Then the widget goes through its own list of children. One by one, the widget tells its children what their constraints are (which can be different for each child), and then asks each child what size it wants to be.
* Then, the widget positions its children (horizontally in the x axis, and vertically in the y axis), one by one.
* And, finally, the widget tells its parent about its own size (within the original constraints, of course).

For example, if a composed widget contains a column with some padding, and wants to lay out its two children as follows:

![image](https://user-images.githubusercontent.com/29271126/98711133-f45afd80-23c7-11eb-806d-459371763348.png)

The negotiation goes something like this:

    Widget: “Hey parent, what are my constraints?”

    Parent: “You must be from 80 to 300 pixels wide, and 30 to 85 tall.”

    Widget: “Hmmm, since I want to have 5 pixels of padding, then my children can have at most 290 pixels of width and 75 pixels of height.”

    Widget: “Hey first child, You must be from 0 to 290 pixels wide, and 0 to 75 tall.”

    First child: “OK, then I wish to be 290 pixels wide, and 20 pixels tall.”

    Widget: “Hmmm, since I want to put my second child below the first one, this leaves only 55 pixels of height for my second child.”

    Widget: “Hey second child, You must be from 0 to 290 wide, and 0 to 55 tall.”

    Second child: “OK, I wish to be 140 pixels wide, and 30 pixels tall.”

    Widget: “Very well. My first child has position x: 5 and y: 5, and my second child has x: 80 and y: 25.”

    Widget: “Hey parent, I’ve decided that my size is going to be 300 pixels wide, and 60 pixels tall.”

## Limitations

Flutter’s layout engine has a few important limitations:

* A widget can decide its own size only within the constraints given to it by its parent. This means a widget usually **can’t have any size it wants.**

* A widget **can’t know and doesn’t decide its own position in the screen,** since it’s the widget’s parent who decides the position of the widget.

* Since the parent’s size and position, in its turn, also depends on its own parent, it’s impossible to precisely define the size and position of any widget without taking into consideration the tree as a whole.

