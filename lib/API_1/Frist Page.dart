import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:apl/API_1/view_data.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class Home extends StatefulWidget {
  var  data;
  Home([this.data]);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final TextEditingController _name = TextEditingController();
  final TextEditingController _contact = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  Connectivity con = Connectivity();
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  
  List  hobby=[], cityList=["Surat","Ahmedabad","Vapi","Valsad","Bombey"];
  Map data={};
  bool temp = true,im=false,h1=false,h2=false,h3=false,ch=false;
  String gender='', imgs='';
  String? city;
  int Id=0;

  conection() {
    con.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.mobile || event == ConnectivityResult.wifi) {
        temp = true;
      } else {
        temp = false;
      }
      setState(() {});
    });
  }

  add_contact(name,contact,email,pass,hob,gender,city,img) async{
    var url = Uri.parse('https://deviksite.000webhostapp.com/API%201/add_contact.php');
    var response = await http.post(url, body: {'name': '$name', 'contact': '$contact', 'email': '$email', 'password': '$pass',
    'hobby': '$hob','gender': '$gender', 'city': '$city', 'image': '$img'});

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Response body : ${response.body}')));

    if (response.statusCode == 200) {
      print("Success............${response.statusCode}");
      setState(() {});
    } else if (response.statusCode == 404) {
      print("server not found............${response.statusCode}");
    } else if (response.statusCode == 500) {
      print("server not responding............${response.statusCode}");
    } else {
      print("some other error or might be CORS policy error........${response.statusCode}");
    }
  }

  update_contact(id,name,contact,email,pass,hob,gender,city,img,imgs,ch) async{
    try
    {
      print(img);
      print(imgs);
      var url1 = Uri.parse('https://deviksite.000webhostapp.com/API%201/update_contact.php');
      var response1 = await http.post(url1, body: {'id' : '$id', 'name': '$name', 'contact': '$contact', 'email': '$email', 'password': '$pass',
        'hobby': '$hob','gender': '$gender', 'city': '$city', 'oldimg': '$imgs','newimg': '$img','change' : '$ch'});
      var res = jsonDecode(response1.body);

      if(res['result']=='Done'){ ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Record Updated'),));}
      else {  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Something went wrong'),));}
    }
    catch (e) { print(e);}
  }

  permission() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
        Permission.storage,
      ].request();
    }
  }
  
  @override
  void initState() {
    conection();
    permission();
    super.initState();
    data = widget.data ?? {};
    print(data);

    if(data.isNotEmpty)
    {
      Id = int.parse(data['id']);
      _name.text = data['name'];
      _contact.text = data['contact'];
      _email.text = data['email'];
      _pass.text = data['password'];
      city = data['city'];
      gender = data['gender'];
      imgs = data['image'];
      print(imgs);

      // if(data['gender'].toString().contains("Male")){gender="Male";}
      // if(data['gender'].toString().contains("Female")){gender="Female";}

      if(data['hobby'].toString().contains("Cricket")) { h1=true; hobby.add("Cricket");}
      if(data['hobby'].toString().contains("Gaming")) { h2=true; hobby.add("Gaming");}
      if(data['hobby'].toString().contains("Other")) { h3=true; hobby.add("Other");}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: const Text("API Calling"),
        actions: [(Id > 0) ? IconButton(onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) { return Home();},)), icon: Icon(Icons.add_circle_outline_sharp)) : Container()],),
      body: (temp) ?
           SingleChildScrollView(
             child: Column(
               children: [
                  InkWell(
                    onTap: () {
                      image_upload();
                    },
                    child: (im)
                          ? Container(
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.cyan, width: 3),
                                  borderRadius: BorderRadius.circular(500)),
                              child: CircleAvatar(
                                  radius: 50, backgroundImage: FileImage(File(image!.path))),
                            )
                          : (Id > 0)
                              ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                    backgroundColor: Colors.black, radius: 50,
                                    backgroundImage: NetworkImage("https://deviksite.000webhostapp.com/API%201/${data['image']}")),
                              )
                              :const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                  backgroundColor: Colors.black, radius: 50,
                                  child: Icon(Icons.add, size: 50, color: Colors.white,)),
                            )),
                  Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.only(left: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.cyan)),
                    child: TextField(
                        controller: _name,
                        decoration: const InputDecoration(
                            hintText: "Enter Name", border: InputBorder.none)),
                  ),
                  Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.cyan)),
                      child: TextField(
                          controller: _contact,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                              hintText: "Enter Contact", border: InputBorder.none)),
                  ),
                  Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.cyan)),
                      child: TextField(
                          controller: _email,
                          decoration: const InputDecoration(
                              hintText: "Enter Email", border: InputBorder.none)),
                  ),
                  Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.cyan)),
                      child: TextField(
                          controller: _pass,
                          decoration: const InputDecoration(
                              hintText: "Enter Password", border: InputBorder.none)),
                  ),
                  
                  Container(
                    margin:const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    child: Row(
                      children: [
                        const Text("Hobby",style:TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                        Checkbox(value: h1, onChanged: (value) {
                          h1 = value!;
                          (h1=value) ? hobby.add("Cricket") : hobby.remove("Cricket");
                          setState(() {});
                        }),
                        const Text("Cricket"),

                        Checkbox(value: h2, onChanged: (value) {
                          h2 = value!;
                          (h2=value) ? hobby.add("Gaming") : hobby.remove("Gaming");
                          setState(() {});
                        }),
                        const Text("Gaming"),

                        Checkbox(value: h3, onChanged: (value) {
                          h3 = value!;
                          (h3=value) ? hobby.add("Other") : hobby.remove("Other");
                          setState(() {});
                        }),
                        const Text("Other"),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    child: Row(
                      children: [
                        const Text("Gender",style:TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                         RadioMenuButton(
                        value: "Male",
                        groupValue: gender,
                        onChanged: (value) {
                          gender = value!;
                          setState(() {});
                        },
                        child:const Text("Male")),
                    RadioMenuButton(
                        value: "Female",
                        groupValue: gender,
                        onChanged: (value) {
                          gender = value!;
                          setState(() {});
                        },
                        child:const Text("Female")),
                      ],
                    ),
                  ),
                  Card(margin:const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                    child: DropdownButton(
                      isExpanded: true,underline: Container(),
                      hint: const Text("Select City"),
                      value: city,
                      items: cityList.map( (e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Text("$e"));
                    }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          city = newValue as String?;
                        });
                    },),
                  ),
                 
                  Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            String name = _name.text;
                            String contact = _contact.text;
                            String email = _email.text;
                            String pass = _pass.text;
                            String hob = hobby.join("/");

                            print(name);
                            print(contact);
                            print(email);
                            print(pass);
                            print(hob);
                            print(gender);
                            print(city);
                            String img = '';
                            if (im) {
                               img = base64Encode(await image!.readAsBytes());
                              ch = true;
                            }

                            if(Id>0)
                            {
                              update_contact(Id, name, contact,email,pass,hob,gender,city,img,imgs,ch);
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) { return const ViewData();},));
                            }
                            else
                            {
                              if (name.isEmpty || contact.isEmpty)
                              {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enter Name & Contact")));
                              }
                              else if (email.isEmpty || pass.isEmpty)
                              {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enter Email & Password")));
                              }
                              else if(hobby.isEmpty)
                              {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Select Hobby")));
                              }
                              else if(gender.isEmpty)
                              {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Select Gender")));
                              }
                              else if(city==null)
                              {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Select City")));
                              }
                              else if(im==false)
                              {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Pick Image")));
                              }
                              else
                              {
                                add_contact(name,contact,email,pass,hob,gender,city,img);
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) { return  ViewData();},));
                              }
                            }
                            // _name.clear();
                            // _contact.clear();
                          }, child: Text((Id>0) ? "Update" : "Add")),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {return const ViewData();},));
                          },
                          child: const Text("View")),
                    ],
                  )
                   ],
                 ),
           )
          : Center(
            child: Container( alignment: Alignment.center,
              width: 280,height: 50,
              decoration: BoxDecoration(
                  color: Colors.amber,
                  border: Border.all(color: Colors.amber.shade700),
                  borderRadius: BorderRadius.circular(15)),
              child: Row( mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.signal_wifi_statusbar_connected_no_internet_4_sharp),
                  SizedBox(width: 20,),
                  Text("No Internet Connection..",style: TextStyle(fontSize: 18),),
                ],
              ),
            ),
          ),
    );
  }

  image_upload(){
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title : const Text("You can choose camera or Gallery image"),
        actions: [
          IconButton(
            onPressed: () async {
              image = await _picker.pickImage(source: ImageSource.camera);
              if (image != null) {
                im = true;
              }
              Navigator.pop(context);
              setState(() {});
            },
            icon: const Icon(Icons.camera_alt_outlined),
          ),
          IconButton(
            onPressed: () async {
              image = await _picker.pickImage(
                  source: ImageSource.gallery);
              if (image != null) {
                im = true;
              }
              Navigator.pop(context);
              setState(() {});
            },
            icon: const Icon(Icons.image),
          ),
          IconButton(
            onPressed: () async {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close),
          ),
        ],
      );
    },);
  }
}
