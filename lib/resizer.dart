import 'package:flutter/material.dart';

const double ballRadius = 7.5;

class ImageManager extends StatefulWidget {
  final Widget child;
  final bool isSelected;
  const ImageManager(
      {super.key, required this.child, required this.isSelected});

  @override
  _ImageManagerState createState() => _ImageManagerState();
}

class _ImageManagerState extends State<ImageManager> {
  double _x = 0;
  double _y = 0;

  double _height = 200;
  double _width = 300;

  final double _aspectRatio = 200 / 300;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Positioned(
          top: _y,
          left: _x,
          child: GestureDetector(
            onPanUpdate: (DragUpdateDetails details) {
              if (!widget.isSelected) return;
              setState(() {
                _x += details.delta.dx;
                _y += details.delta.dy;
              });
            },
            child: SizedBox(
              height: _height,
              width: _width,
              child: widget.child,
            ),
          ),
        ),

        // top left
        if (widget.isSelected)
          Positioned(
            top: _y - ballRadius,
            left: _x - ballRadius,
            child: Ball(
              onDrag: (double dx, double dy) {
                final double newWidth = _width - dx;
                final double newHeight = newWidth * _aspectRatio;
                if (newWidth < 30) return;
                if (newHeight < 30) return;

                setState(() {
                  _y = _y + (_height - newHeight);
                  _x = _x + dx;
                  _width = newWidth;
                  _height = newHeight;
                });
              },
            ),
          ),
        // top middle
        if (widget.isSelected)
          Positioned(
            top: _y - ballRadius,
            left: _x + _width / 2 - ballRadius,
            child: Ball(
              onDrag: (double dx, double dy) {
                final double newHeight = _height - dy;
                if (newHeight < 30) return;
                setState(() {
                  // Calculate the new height based on the drag direction
                  // Prevent the newHeight from becoming negative or too small
                  if (newHeight > 0) {
                    _height = newHeight;
                    // Move the Y position to resize the widget upwards or downwards
                    _y += dy;
                  }
                });
              },
            ),
          ),

        // top right
        if (widget.isSelected)
          Positioned(
            top: _y - ballRadius,
            left: _x + _width - ballRadius,
            child: Ball(
              onDrag: (double dx, double dy) {
                setState(() {
                  final double newWidth = _width + dx;
                  final double newHeight = newWidth * _aspectRatio;
                  final double heightChange =
                      _height - newHeight; // Calculate the height change

                  if (newWidth < 30) return;
                  if (newHeight < 30) return;

                  // Update width and height
                  _width = newWidth;
                  _height = newHeight;
                  // Adjust y position to maintain the top edge in place
                  _y += heightChange;
                });
              },
            ),
          ),

        // middle left
        if (widget.isSelected)
          Positioned(
            top: _y + _height / 2 - ballRadius,
            left: _x - ballRadius,
            child: Ball(
              onDrag: (double dx, double dy) {
                final double newWidth = _width - dx;
                if (newWidth < 30) return;

                setState(() {
                  _x = _x + dx;
                  _width = newWidth;
                });
              },
            ),
          ),
        // middle right
        if (widget.isSelected)
          Positioned(
            top: _y + _height / 2 - ballRadius,
            left: _x + _width - ballRadius,
            child: Ball(
              onDrag: (double dx, double dy) {
                final double newWidth = _width + dx;
                if (newWidth < 30) return;
                setState(() {
                  _width = newWidth;
                });
              },
            ),
          ),

        // bottom left
        if (widget.isSelected)
          Positioned(
            top: _y + _height - ballRadius,
            left: _x - ballRadius,
            child: Ball(
              onDrag: (double dx, double dy) {
                final double newHeight = _height + dy;
                final double newWidth = newHeight / _aspectRatio;
                if (newWidth < 30) return;
                if (newHeight < 30) return;
                setState(() {
                  _x = _x + (_width - newWidth);
                  _width = newWidth;
                  _height = newHeight;
                });
              },
            ),
          ),

        // bottom middle
        if (widget.isSelected)
          Positioned(
            top: _y + _height - ballRadius,
            left: _x + _width / 2 - ballRadius,
            child: Ball(
              onDrag: (double dx, double dy) {
                final double newHeight =
                    _height + dy; // Adjust height based on dy
                if (newHeight < 30) return;
                setState(() {
                  // Ensure newHeight is positive to prevent invalid dimensions
                  if (newHeight > 0) {
                    _height = newHeight;
                  } else {
                    // Optionally, handle the case where newHeight would be invalid
                    // For example, set a minimum height if desired
                    _height = 0; // Or set to a minimum valid height
                  }
                });
              },
            ),
          ),
        // bottom right
        if (widget.isSelected)
          Positioned(
            top: _y + _height - ballRadius,
            left: _x + _width - ballRadius,
            child: Ball(
              onDrag: (double dx, double dy) {
                setState(() {
                  final double newWidth = _width + dx;
                  final double newHeight = newWidth * _aspectRatio;
                  if (newWidth < 30) return;
                  if (newHeight < 30) return;

                  _width = newWidth;
                  _height = newHeight;
                });
              },
            ),
          ),
      ],
    );
  }
}

class Ball extends StatelessWidget {
  final Function onDrag;

  const Ball({
    super.key,
    required this.onDrag,
  });

  void _onDragUpdate(DragUpdateDetails details) {
    onDrag(details.delta.dx, details.delta.dy);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _onDragUpdate,
      child: Container(
        height: 2 * ballRadius,
        width: 2 * ballRadius,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(ballRadius),
          border: Border.all(
            width: 3,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
