import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {

  final  bloodGroups =['A+','A-','B+','O-','O+','AB-','AB+'];
  String ? selectGroup;

  final CollectionReference donor = FirebaseFirestore.instance.collection('donor');
  void addDoner(){
    final data ={
      "name":donerName.text,
      "phone":doneerPhone.text,
      "group": selectGroup,
    };
    donor.add(data);
  }
  TextEditingController donerName = TextEditingController();
  TextEditingController doneerPhone = TextEditingController();
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text(
            'Add Donors',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: donerName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Donor Name'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: doneerPhone,
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Phone Number'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField(
                decoration: const InputDecoration(
                  label: Text("select blood group")
                ),
                  items:bloodGroups
                      .map((e) => DropdownMenuItem(
                  child: Text(e),
                      value: e,
                  ))
                      .toList(),
                  onChanged: (val){
                selectGroup=val as String?;
              }),
            ),
            ElevatedButton(
                onPressed: (){
              addDoner();
              Navigator.pop(context);
            },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all( const Size(double.infinity, 50)),
                  backgroundColor: MaterialStateProperty.all(Colors.red)
                ),
                child: const Text('Submit',style: TextStyle(
                  fontSize: 20
                ),))
          ],
        ),
      ),
    );
  }
}
