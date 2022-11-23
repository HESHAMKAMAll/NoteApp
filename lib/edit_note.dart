import 'package:flutter/material.dart';
import 'package:sqfnote/home.dart';
import 'package:sqfnote/me.dart';
import 'package:sqfnote/sqflite.dart';

class EditNotes extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final note;
  // ignore: prefer_typing_uninitialized_variables
  final title;
  // ignore: prefer_typing_uninitialized_variables
  final id;
  const EditNotes({Key? key, this.note, this.title, this.id}) : super(key: key);
  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  SqlDb sqlDb =   SqlDb();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();

  @override
  void initState() {
    note.text = widget.note;
    title.text = widget.title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('تعديل الملاحظه'),
        actions:
        [
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Me(),));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
              [
                Text('About Me',style: TextStyle(fontSize: 10)),
                Icon(Icons.info_outline),
              ],
            ),
          ),

        ],
      ),
      body: ListView(
        children:
        [
          Form(
            key: formstate,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children:
                [
                  Material(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(17),
                    elevation: 30,
                    child: TextFormField(
                      maxLines: 3,
                      controller: note,
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.center,
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
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(17),
                    elevation: 30,
                    child: TextFormField(
                      maxLines: 14,
                      controller: title,
                      keyboardType: TextInputType.text,
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
                    height: 30,
                  ),
                  MaterialButton(
                      onPressed: ()async{
                        int response = await sqlDb.updateData('''
                            UPDATE notes SET 
                            note = "${note.text}",
                            title = "${title.text}"
                            WHERE id = ${widget.id}
                        ''');
                        if(response>0){
                          // ignore: use_build_context_synchronously
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context) => const Home(),), (route) => false);
                        }
                      },
                      color: Colors.pink,
                      elevation: 30,
                      child: const Text('Edit')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
