import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/Database/DatabaseManager.dart';
import 'package:netflix_clone/screens/nav_screen.dart';
import 'package:netflix_clone/widgets/custom_app_bar.dart';

class UpdateContentScreen extends StatefulWidget {

  final String contentName;
  final String imgUrl;
  final String videoUrl;
  final String description;
  final String gotDropDownValue;
  final String id;

  const UpdateContentScreen({Key? key, required this.contentName, required this.imgUrl, required this.videoUrl, required this.description, required this.gotDropDownValue, required this.id}) : super(key: key);




  @override
  _UpdateContentScreenState createState() => _UpdateContentScreenState();
}

class _UpdateContentScreenState extends State<UpdateContentScreen> {
  TextEditingController _contentName = TextEditingController();
  TextEditingController _imgUrl = TextEditingController();

  TextEditingController _videoUrl = TextEditingController();
  TextEditingController _description = TextEditingController();

  bool isLoading = false;








  String dropdownValue = 'Previews';
  String id = '';

  initializeFields(){
    setState(() {
      _contentName.text = widget.contentName;
      _imgUrl.text = widget.imgUrl;
      _videoUrl.text = widget.videoUrl;
      _description.text = widget.description;
      dropdownValue = widget.gotDropDownValue;
      id = widget.id;
    });
  }

  @override
  void initState() {
    initializeFields();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [

          Image.asset(
            "assets/images/background.jpg",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),

          Scaffold(
            extendBodyBehindAppBar: false,

            appBar: PreferredSize(
                preferredSize: Size(MediaQuery.of(context).size.width, 50.0),
                child: CustomAppBar2()

            ),
            body: SingleChildScrollView(
              child: Center(
                child: Container(
                  width: (MediaQuery.of(context).size.width > 800) ? MediaQuery.of(context).size.width * 0.6 : MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                        child: Text(
                          'Update Content',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                        child: TextField(
                          controller: _contentName,

                          style: TextStyle(
                              color: Colors.white
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFF3A3737),
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(5.0),
                              ),
                            ),
                            labelText: 'Content name',
                            labelStyle: TextStyle(color: Colors.white),

                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                        child: TextField(
                          controller: _imgUrl,

                          style: TextStyle(
                              color: Colors.white
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFF3A3737),
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(5.0),
                              ),
                            ),
                            labelText: 'Image url',
                            labelStyle: TextStyle(color: Colors.white),

                          ),
                        ),
                      ),



                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                        child: TextField(
                          controller: _videoUrl,

                          style: TextStyle(
                              color: Colors.white
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFF3A3737),
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(5.0),
                              ),
                            ),
                            labelText: 'Video url',
                            labelStyle: TextStyle(color: Colors.white),

                          ),
                        ),
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                              child: TextField(

                                maxLines: 5,
                                keyboardType: TextInputType.multiline,
                                controller: _description,


                                style: TextStyle(
                                    color: Colors.white
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xFF3A3737),
                                  border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(5.0),
                                    ),
                                  ),

                                  labelText: 'Description',
                                  labelStyle: TextStyle(color: Colors.white),


                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                        child: Row(
                          children: [
                            Text(
                              'Type of content: ',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),

                            SizedBox(width: 10.0,),


                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 0),
                              color: Color(0xFF3A3737),
                              child: DropdownButton<String>(
                                hint: Text(dropdownValue, style: TextStyle(color: Colors.white),),

                                focusColor: Colors.black,
                                dropdownColor: Color(0xFF3A3737),
                                style: TextStyle(
                                  color: Colors.white,
                                ),

                                items: <String>['Previews', 'Originals', 'Classics'].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,

                                    child: new Text(
                                      value,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    dropdownValue = value!;
                                  });
                                  print(dropdownValue);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      Wrap(
                        children: [

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
                            child: FlatButton(
                                onPressed: () async{
                                  setState(() {
                                    isLoading = true;
                                  });
                                  int response = await DatabaseManager().updateContent(
                                      _contentName.text.trim(),
                                      widget.id,
                                      _imgUrl.text.trim(),
                                      _videoUrl.text.trim(),
                                      _description.text.trim(),
                                      dropdownValue.trim()
                                  );
                                  setState(() {
                                    isLoading = false;
                                  });
                                  print(DateTime.now());
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:  (response == 0) ? Text('Content updated') : Text('Some error occurred'),));
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => NavScreen()),
                                  );
                                },
                                child: Container(
                                  height: 40.0,
                                  width: 200.0,

                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    color: Colors.blueAccent,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Update Content',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ),
                                )),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
                            child: FlatButton(
                                onPressed: () async{
                                  setState(() {
                                    isLoading = true;
                                  });
                                  int response = await DatabaseManager().deleteContent(id);

                                  setState(() {
                                    isLoading = false;
                                  });
                                  print(DateTime.now());
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:  (response == 0) ? Text('Content deleted') : Text('Some error occurred'),));
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => NavScreen()),
                                  );
                                },
                                child: Container(
                                  height: 40.0,
                                  width: 200.0,

                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    color: Colors.redAccent,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Delete Content',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ),
                                )),
                          ),
                        ],
                      ),

                      (isLoading) ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ) : SizedBox(height: 1.0,)




                    ],
                  ),
                ),
              ),
            ),
          )
        ],

      ),
    );
  }
}
