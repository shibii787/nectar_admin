import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nectar_admin/core/common/colors.dart';
import 'package:nectar_admin/feature/controller/addingController.dart';
import 'package:nectar_admin/model/user_model.dart';

import '../../../../main.dart';

class AppUsers extends ConsumerStatefulWidget {
  const AppUsers({super.key});

  @override
  ConsumerState<AppUsers> createState() => _AppUsersState();
}

class _AppUsersState extends ConsumerState<AppUsers> {

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).size.width > 840 ? Scaffold(
      backgroundColor: theColors.beige,
      appBar: AppBar(
        backgroundColor: theColors.third,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("USERS",style: TextStyle(
          color: theColors.primaryColor,
            fontWeight: FontWeight.w600,
          letterSpacing: 1
        ),),
      ),
      body: Padding(
        padding: EdgeInsets.all(w*0.03),
        child: Consumer(builder: (context, ref, child) {

          var users = ref.watch(userStreamProvider);
          return users.when(
              data: (data) {

                final source = DataSource(
                    userSnap: data,
                    context: context,
                    ref: ref);

                if(data.docs.isEmpty){
                  return const Center(
                      child: Text("NO DATA AVAILABLE.......")
                    );
                }

                return SingleChildScrollView(
                  child: SizedBox(
                    width: w * 0.8,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
                      child: PaginatedDataTable(
                        showEmptyRows: false,
                        checkboxHorizontalMargin: Checkbox.width,
                        columnSpacing: 20,
                        showCheckboxColumn: true,
                        horizontalMargin: 10,
                        headingRowColor: WidgetStateProperty.all(theColors.third),
                        rowsPerPage: 10,
                        arrowHeadColor: Colors.black,
                        columns: const [
                          DataColumn(label: Text("Sl No",style: TextStyle(
                            color: Colors.white
                          ),)),
                          DataColumn(label: Text("Name",style: TextStyle(
                              color: Colors.white))),
                          DataColumn(label: Text("ID",style: TextStyle(
                              color: Colors.white))),
                          DataColumn(label: Text("Email",style: TextStyle(
                              color: Colors.white))),
                          DataColumn(label: Text("Phone",style: TextStyle(
                              color: Colors.white))),
                        ],
                        source: source,
                      ),
                    ),
                  ),
                );
              },
              error: (error, stackTrace) {
                return Text(error.toString(),
                  style: const TextStyle(
                    color: Colors.black
                  ),);
              },
              loading: () {
                return  const Center(
                  child: Column(
                    children: [
                      Text("loading",style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold
                      )),
                      SizedBox(height: 10),
                      CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    ],
                  ),
                );
              },
          );

        },),
      ),
    ) : Container(color: theColors.third);
  }
}

class DataSource extends DataTableSource{
  QuerySnapshot userSnap;
  final BuildContext context;
  final WidgetRef ref;
  DataSource({
    required this.userSnap,
    required this.context,
    required this.ref,
  });

  @override
  DataRow? getRow(int index) {

    UserModel userModel =
    UserModel.fromMap(userSnap.docs[index].data() as Map<String,dynamic>
    );

    return DataRow(
        cells: [
          DataCell(
            SizedBox(
              width: w*0.04,
            child: Text("${index + 1}"),
            )
          ),
          DataCell(
            SizedBox(width: w*0.1,
            child: Text(userModel.name),
            )
          ),
          DataCell(
            SizedBox(width: w*0.08,
            child: Text(userModel.id),
            )
          ),
          DataCell(
            SizedBox(width: w*0.12,
            child: Text(userModel.email),
            )
          ),
          DataCell(
            SizedBox(width: w*0.08,
            child: Text(userModel.phoneNumber.toString()),
            )
          ),
    ]);

  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => userSnap.docs.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
  
}