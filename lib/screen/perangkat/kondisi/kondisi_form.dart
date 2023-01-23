import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class FormTambahKondisi extends StatefulWidget {
  const FormTambahKondisi({Key? key}) : super(key: key);

  @override
  State<FormTambahKondisi> createState() => _FormTambahKondisiState();
}

class _FormTambahKondisiState extends State<FormTambahKondisi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Get.back();
            },
          ),
          // actions: [
          //   IconButton(
          //     icon: const Icon(
          //       Icons.arrow_forward,
          //       size: 24,
          //     ),
          //     onPressed: () {
          //       // Navigator.of(context).push(MaterialPageRoute(
          //       //     builder: (context) => const PerangkatDetail()));
          //     },
          //   ),
          //   IconButton(
          //     icon: const Icon(
          //       Icons.manage_accounts,
          //       size: 24,
          //     ),
          //     onPressed: () {
          //       // Navigator.of(context).push(MaterialPageRoute(
          //       //     builder: (context) => const PerangkatDetail()));
          //     },
          //   ),
          // ],
          title: const Text('Kondisi Perangkat'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Masukkan Kondisi perangkat',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              Form(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Masukkan Kondisi Perangkat',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 0.0),
                        ),
                        border: OutlineInputBorder()),
                    onFieldSubmitted: (value) {
                      setState(() {
                        // firstName = value.capitalize();
                        // firstNameList.add(firstName);
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        // firstName = value.capitalize();
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 3) {
                        return 'First Name must contain at least 3 characters';
                      } else if (value.contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                        return 'First Name cannot contain special characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField(
                      decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.0),
                          ),
                          border: OutlineInputBorder()),
                      items: const [
                        DropdownMenuItem(
                          child: Text("ASUS"),
                          value: 1,
                        ),
                        DropdownMenuItem(
                          child: Text("Lenovo"),
                          value: 2,
                        )
                      ],
                      hint: const Text(
                          "Pilih Status Keaktifan Kondisi perangkat"),
                      onChanged: (value) {
                        setState(() {
                          // measure = value;
                          // measureList.add(measure);
                        });
                      },
                      onSaved: (value) {
                        setState(() {
                          // measure = value;
                        });
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(60)),
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      // if (_formKey.currentState!.validate()) {
                      //   _submit();
                      // }
                    },
                    child: const Text("Tambah perangkat"),
                  ),
                ],
              ))
            ],
          ),
        ));
  }
}
