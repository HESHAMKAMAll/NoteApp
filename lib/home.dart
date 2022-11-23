import 'package:flutter/material.dart';
import 'package:sqfnote/edit_note.dart';
import 'package:sqfnote/sqflite.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  SqlDb sqlDb =   SqlDb();
  List notes = [];

  Future readData()async{
    List<Map> response = await sqlDb.readData("SELECT * FROM notes");
    notes.addAll(response);
    if(mounted){
      setState(() {});
    }
  }





  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();

@override
  void initState() {
    readData();
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.pink,
          onPressed: (){
            showDialog(context: context, builder: (context){
              return AlertDialog(
                backgroundColor: Colors.pink,
                content: SizedBox(
                  height: 200,
                    child: ListView(
                      children:
                      [
                        Form(
                          key: formstate,
                          child: Column(
                            children:
                            [
                              Material(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(17),
                                elevation: 40,
                                child: TextFormField(
                                  controller: note,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(17),
                                        borderSide: const BorderSide(color: Colors.white12)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(17),
                                        borderSide: const BorderSide(color: Colors.white12)),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Material(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(17),
                                elevation: 40,
                                child: TextFormField(
                                  controller: title,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(17),
                                        borderSide: const BorderSide(color: Colors.white12)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(17),
                                        borderSide: const BorderSide(color: Colors.white12)),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              MaterialButton(
                                  onPressed: ()async{
                                    int response = await sqlDb.insertData('''
                                    INSERT INTO notes (note, title)
                                    VALUES ("${note.text}", "${title.text}")
                                    ''');
                                    if(response>0){
                                      // ignore: use_build_context_synchronously
                                      Navigator.pushAndRemoveUntil(context,
                                          MaterialPageRoute(builder: (context) => const Home(),), (route) => false);
                                    }
                                  },
                                  color: Colors.black,
                                  elevation: 30,
                                  child: const Text('ADD')),
                            ],
                          ),
                        ),
                      ],
                    )),
              );
            });
          },
          child: const Icon(Icons.add,color: Colors.white,)),
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Center(child: Text('ملاحظاتي')),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children:
        [
          ListView.builder(
                  itemCount: notes.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, i) {
                    return Dismissible(
                        onDismissed: (direction) async {
                          int response = await await sqlDb.deleteData("DELETE FROM 'notes' WHERE id = ${notes[i]['id']}");
                          if(response > 0){
                            notes.removeWhere((element) => element['id'] == notes[i]['id']);
                          }
                        },
                        key: UniqueKey(),
                        child: Card(
                          child: ListTile(
                            title: Text("${notes[i]['note']}"),
                            subtitle: Text("${notes[i]['title']}"),
                            trailing: IconButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => EditNotes(
                                id: notes[i]['id'],
                                note: notes[i]['note'],
                                title: notes[i]['title'],
                              ),));
                            },
                            icon: const Icon(Icons.edit)),
                      ),
                    ));
                  },
                )

        ],
      ),
    );
  }
}