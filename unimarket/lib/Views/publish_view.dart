import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

late List<CameraDescription> cameras;

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CameraApp(),
    );
  }
}



class PublishView extends StatefulWidget {
  const PublishView({super.key});

  @override
  State<PublishView> createState() => _PublishViewState();
}

class _PublishViewState extends State<PublishView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: 
          Column(
            children: [
              Text("Publish a New Product", style: TextStyle(color: Colors.black, fontSize: 22.0, fontWeight: FontWeight.bold)),
              Divider(height: 5, thickness:3, indent: 50, endIndent: 50, color: Colors.deepOrange,),
              MyApp()
            ],
          )
      ),
    );
  }
}


class CameraApp extends StatefulWidget {
  const CameraApp({super.key});

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = CameraController(cameras[0], ResolutionPreset.max);
    _controller.initialize().then((_) {
      if(!mounted){
        return;
      }
      setState(() {
        
      });
    }).catchError((Object e) {
      if(e is CameraException){
        switch (e.code){
          case 'CameraAccessDenied':
            print('Access was denied');
            break;
          default:
            print(e.description);
            break;
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          Container(
            height: double.infinity,
            child: CameraPreview(_controller),
          ),

          RawMaterialButton(
            onPressed: () async{
              if(!_controller.value.isInitialized){
                return null;
              }
              if(_controller.value.isTakingPicture){
                return null;
              }
              try{
                await _controller.setFlashMode(FlashMode.auto);
                XFile picture = await _controller.takePicture();
              } on CameraException catch (e){
                debugPrint("Error occured while taking picture: $e");
                return null;
              }
            },
            child: Text("Take picture"),
           )
        ],
      ),
    );
  }
}