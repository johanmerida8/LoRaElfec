// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';




class TabsWeb extends StatefulWidget {
  final title;
  const TabsWeb (this.title,{Key? key}) : super(key: key);

  @override
  _TabsWebState createState() => _TabsWebState();
}

class _TabsWebState extends State<TabsWeb> {

  
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_){
        setState(() {
          isSelected = true;
        });
        /* print("Entered"); */
      },
      onExit: (_){
        setState(() {
          isSelected = false;
        });
        /* print("Exit"); */
      },
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 100),
        curve: Curves.elasticIn,
        style: isSelected
        ? GoogleFonts.roboto(
          shadows: [
            Shadow(
              color: Colors.black, 
              offset: Offset(0, -7),
          ),
          ],
          fontSize: 25.0,
          color: Colors.transparent,
          decoration: TextDecoration.underline,
          decorationThickness: 2,
          decorationColor: Colors.tealAccent
        ):
        GoogleFonts.roboto(
          color: Colors.black,
          fontSize: 23.0
        ),
        child: Text(
          widget.title
          
        ),
      ),
    );
  }
}


class SansBold extends StatelessWidget {
  final text;
  final size;

  const SansBold (this.text, this.size,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.openSans(
        fontSize: size, fontWeight: FontWeight.bold
      ),
    );
  }
}


class Sans extends StatelessWidget {
  final text;
  final size;

  const Sans (this.text, this.size,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.openSans(
        fontSize: size, 
      ),
    );
  }
}

class TextForm extends StatelessWidget {
  final heading;
  final width;
  final hintText;
  final maxLines;

  const TextForm (
    {Key? key, 
    @required this.heading, 
    @required this.width, 
    @required this.hintText, 
    this.maxLines}) 
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Sans(heading, 16.0),
        SizedBox(height: 5),
        SizedBox(
          width: width,
          child: TextFormField(
            
            maxLines: maxLines==null?null:maxLines,
            decoration: InputDecoration(
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.teal),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.tealAccent, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              hintText: hintText,
              hintStyle: GoogleFonts.poppins(fontSize: 14),
            ),   
          ), 
        ),
      ],
    );
  }
}

class AnimatedCardWeb extends StatefulWidget {
  final imagePath;
  final text;
  final fit;
  final reverse;
  const AnimatedCardWeb (
    {Key? key,
    @required this.imagePath,
    @required this.text, 
    this.fit, this.reverse}) 
    : super(key: key);

  @override
  _AnimatedCardWebState createState() => _AnimatedCardWebState();
}

class _AnimatedCardWebState extends State<AnimatedCardWeb> 
    with SingleTickerProviderStateMixin{
  late AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 4),
  )..repeat(reverse: true);

  late Animation<Offset> _animation = Tween(
    begin: widget.reverse==true ? Offset(0, 0.08): Offset.zero,
    end: widget.reverse==true ? Offset.zero : Offset(0, 0.08),
  ).animate(_controller);
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return SlideTransition(position: _animation,
    child: Card(
        elevation: 30.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(color: Colors.tealAccent),
        ),
        shadowColor: Colors.tealAccent,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Image.asset(
                widget.imagePath,
                width: 200,
                height: 200,
                fit: widget.fit == null?null:widget.fit,
              ),
              SizedBox(height: 10.0),
              SansBold(widget.text, 15.0),
            ],
          ),
        ),
      ),
    );
  }
}