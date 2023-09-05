import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class UpdateUser extends StatefulWidget {
  const UpdateUser({Key? key}) : super(key: key);

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {

  final  bloodGroups =['A+','A-','B+','O-','O+','AB-','AB+'];
  String ? selectGroup;

  final CollectionReference donor = FirebaseFirestore.instance.collection('donor');

  TextEditingController donerName = TextEditingController();
  TextEditingController doneerPhone = TextEditingController();
  void  updatedoner(docId){
    final data={
      'name':donerName.text,
      'phone':doneerPhone.text,
      'group':selectGroup
    };
    donor.doc(docId).update(data).then((value) => Navigator.pop(context));

  }
  @override

  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    donerName.text=args['name'];
    doneerPhone.text=args['phone'];
    selectGroup=args['group'];
    final docId= args['id'];
    return Scaffold(
      appBar: AppBar(
        title:  const Text(
            'Update Doner',
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
                  label:  Text('Phone Number'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField(
                value: selectGroup,
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
                 updatedoner(docId);

                },
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all( const Size(double.infinity, 50)),
                    backgroundColor: MaterialStateProperty.all(Colors.red)
                ),
                child:  const Text('Update',style: TextStyle(
                    fontSize: 20
                ),))
          ],
        ),
      ),
    );
  }
}
