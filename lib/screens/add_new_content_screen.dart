import 'package:flutter/material.dart';
import 'package:netflix_clone/Database/DatabaseManager.dart';
import 'package:netflix_clone/models/content_model.dart';
import 'package:netflix_clone/screens/nav_screen.dart';
import 'package:netflix_clone/widgets/custom_app_bar.dart';
import 'package:netflix_clone/widgets/responsive.dart';

class AddNewContentScreen extends StatefulWidget {






  @override
  _AddNewContentScreenState createState() => _AddNewContentScreenState();
}

class _AddNewContentScreenState extends State<AddNewContentScreen> {

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Responsive(
        mobile: _MobileAddNewContentScreen(),
        desktop: _MobileAddNewContentScreen(),
    );
  }
}

class _MobileAddNewContentScreen extends StatefulWidget {








  @override
  __MobileAddNewContentScreenState createState() => __MobileAddNewContentScreenState();
}

class __MobileAddNewContentScreenState extends State<_MobileAddNewContentScreen> {

  TextEditingController _contentName = TextEditingController();
  TextEditingController _imgUrl = TextEditingController();

  TextEditingController _videoUrl = TextEditingController();
  TextEditingController _description = TextEditingController();

  String dropdownValue = 'Previews';







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
                          'Add new content',
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

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
                        child: FlatButton(
                            onPressed: () {
                              DatabaseManager().storeContent(
                                  _contentName.text.trim(),
                                  _imgUrl.text.trim(),
                                  _videoUrl.text.trim(),
                                  _description.text.trim(),
                                  dropdownValue.trim()
                              );
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Content added'),));
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => NavScreen()),
                              );
                            },
                            child: Container(
                              height: 40.0,
                              width: 160.0,

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.blueAccent,
                              ),
                              child: Center(
                                child: Text(
                                  'Add now',
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
                ),
              ),
            ),
          ),
        ],

      ),
    );
  }
}

