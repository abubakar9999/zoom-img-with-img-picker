import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:photo_view/photo_view.dart';

class FullPageImg extends StatefulWidget {
  FullPageImg({Key? key}) : super(key: key);

  @override
  State<FullPageImg> createState() => _FullPageImgState();
}

class _FullPageImgState extends State<FullPageImg> {

 






  String? imgpath;
  ImageSource imgsorce = ImageSource.camera;
  bool isvisiblae=true;

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Center(
          child: Container(
            height: 200,
            width: 200,
            child: imgpath == null
                ? Container(height: 200,width: 200,child: const Icon(Icons.people,size: 40,))
                :InkWell(
                onDoubleTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(imgpath)));
                },

                  
                  child: Hero(
                    tag: "imageHero",
                    child: Image.file(File(imgpath!,))))
                
                
               
                
                
               
          ),
        ),
       

        Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton.icon(
                    onPressed: () {


                      _pickimg();
                      imgsorce = ImageSource.camera;
                    

                      
                     
                    },
                    icon: const Icon(Icons.camera),
                    label: const Text("Camera")),
                TextButton.icon(
                    onPressed: () {
                      imgsorce = ImageSource.gallery;
                      _pickimg();
                     

                    },
                    icon: const Icon(Icons.photo),
                    label: const Text("Gallary")),
              ],
            )




      ],),
    );
  }

  void _pickimg() async {
    final pickimg = await ImagePicker()
        .pickImage(source:imgsorce, preferredCameraDevice: CameraDevice.rear);
    if (pickimg != null) {
      setState(() {
        imgpath = pickimg.path;
      
      });
    }
  }

  }
class DetailScreen extends StatelessWidget {
  String ?img;
  DetailScreen(this.img);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: PhotoView(
              imageProvider:FileImage(File(img!,)) ,
             )
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}