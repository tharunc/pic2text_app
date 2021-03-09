import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String result = '';
  File image;
  ImagePicker imagePicker;

  fromGallery() async {
    PickedFile pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
    image = File(pickedFile.path);
    setState(() {
      image;

      performImageLabelling();
    });

  }
  fromCamera() async {
    PickedFile pickedFile = await imagePicker.getImage(source: ImageSource.camera);
    image = File(pickedFile.path);
    setState(() {
      image;
      performImageLabelling();
    });

  }

  performImageLabelling() async{
    final FirebaseVisionImage firebaseVisionImage = FirebaseVisionImage.fromFile(image);
    final TextRecognizer recognizer = FirebaseVision.instance.textRecognizer();

    VisionText visionText = await recognizer.processImage(firebaseVisionImage);

    result = '';

    setState(() {
      for(TextBlock block in visionText.blocks)
        {
          final String txt = block.text;
          for(TextLine line in block.lines)
            {
              for(TextElement element in line.elements)
                {
                  result += element.text + ' ';
                }
            }
          result += '\n\n';
        }
    });
  }

  @override
  void initState(){
    super.initState();
    imagePicker = ImagePicker();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        title: Text('PIC 2 TEXT',
        style: GoogleFonts.lato(fontWeight: FontWeight.bold),),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xFF64E8DE),Color(0xFF8A64EB)],
            begin: Alignment.bottomRight,
            end: Alignment.bottomLeft)
          ),
        ),
    ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(left:10.0, top:10.0, right:15.0, bottom:10.0),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: SelectableText(result,
                    style: GoogleFonts.lato(fontWeight: FontWeight.bold,fontSize: 16.0),
                    textAlign: TextAlign.justify,),
                  ),
                ),
                decoration: BoxDecoration(
                    color: Color(0xFFDBE3E9),
                    borderRadius: BorderRadius.circular(10.0)),
                height: 300,
                width: 370.0,
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: FlatButton(
                  onPressed: (){
                    fromGallery();
                  },
                  onLongPress: (){
                    fromCamera();
                  },
                  child: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      child: image!=null ? Image.file(image, width: 140,height: 192,fit: BoxFit.fill,)
                          : Container(
                        width: 240,
                        height: 200,
                        child: Icon(Icons.photo_camera, size: 100, color: Colors.grey,),
                      ),

                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text('Tap the Camera Icon for Gallery.\nLong Press Camera Icon for Camera.',
            style: GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 16,color: Color(0xFFDBE3E9)),
            )
          ],
        ),
      ),
    );
  }

}


