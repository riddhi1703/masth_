//import 'dart:ffi';

import 'package:Masth_GURU/drafts.dart';
import 'package:Masth_GURU/sos.dart';
//import 'package:Masth_GURU/users.dart';
//import 'package:Masth_GURU/user.dart';
//import 'package:Masth_GURU/utils.dart';
import 'package:Masth_GURU/widget/scrollable_widget.dart';
//import 'package:Masth_GURU/widget/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

void main() {
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.brown),
      home: const SfDataGridDemo()));
}

class SfDataGridDemo extends StatefulWidget {
  const SfDataGridDemo({Key? key}) : super(key: key);

  @override
  _SfDataGridDemoState createState() => _SfDataGridDemoState();
}

class _SfDataGridDemoState extends State<SfDataGridDemo> {
  List<Employee> _employees = <Employee>[];
  late EmployeeDataSource _employeeDataSource;

  get children => null;

  @override
  void initState() {
    super.initState();
    _employees = getEmployeeData();
    _employeeDataSource = EmployeeDataSource(_employees);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(249, 239, 238, 1),
      appBar: AppBar(
        elevation: 15,
        flexibleSpace: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/masti.png'), scale: 10))),
        backgroundColor: Color.fromRGBO(147, 100, 81, 0.576),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50),
                bottomLeft: Radius.circular(50))),
        title: const Text(
          'Student Data',
          style: TextStyle(fontFamily: 'Century Gothic'),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(200),
          child: SizedBox(height: 200),
        ),
      ),
      body: SfDataGrid(source: _employeeDataSource, columns: [
        GridColumn(
          width: 40,
          columnName: 'ID',
          label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text('No.'),
          ),
        ),
        GridColumn(
          columnName: 'name',
          label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text('Name'),
          ),
        ),
        GridColumn(
          columnName: 'Designation',
          label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text('Class'),
          ),
        ),
        GridColumn(
          columnName: 'Section',
          label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text('Section'),
          ),
        ),
        GridColumn(
          columnName: 'button',
          label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text('View Data '),
          ),
        ),
      ]),
    );
  }

  List<Employee> getEmployeeData() {
    return [
      Employee(1, 'James', '7 ', 'A'),
      Employee(2, 'Kathryn', '8', 'B'),
      Employee(3, 'Lara', '9', 'B'),
      Employee(4, 'Michael', '6', 'C'),
      Employee(5, 'Martin', '7', 'D'),
      Employee(6, 'Newberry', '8', 'B'),
      Employee(7, 'Balnc', '9', 'B'),
      Employee(8, 'Perry', '8', 'A'),
      Employee(9, 'Gable', '9', 'A'),
      Employee(10, 'Grimes', '8', 'C'),
    ];
  }
}

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource(List<Employee> employees) {
    buildDataGridRow(employees);
  }

  void buildDataGridRow(List<Employee> employeeData) {
    dataGridRow = employeeData.map<DataGridRow>((employee) {
      return DataGridRow(cells: [
        DataGridCell<int>(columnName: 'id', value: employee.id),
        DataGridCell<String>(columnName: 'name', value: employee.name),
        DataGridCell<String>(
            columnName: 'designation', value: employee.designation),
        DataGridCell<String>(columnName: 'Section', value: employee.Section),
        const DataGridCell<Widget>(columnName: 'button', value: null),
      ]);
    }).toList();
  }

  List<DataGridRow> dataGridRow = <DataGridRow>[];

  @override
  List<DataGridRow> get rows => dataGridRow.isEmpty ? [] : dataGridRow;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
          alignment: Alignment.center,
          child: dataGridCell.columnName == 'button'
              ? LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                  return ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromRGBO(121, 85, 72, 1)),
                      ),
                      onPressed: () {
                        // showDialog(
                        //     context: context,
                        //     builder: (context) => AlertDialog(
                        //         content: SizedBox(
                        //             height: 100,
                        //             child: Column(
                        //               mainAxisAlignment:
                        //                   MainAxisAlignment.spaceBetween,
                        //               children: [
                        //                 Text(
                        //                     'Employee ID: ${row.getCells()[0].value.toString()}'),
                        //                 Text(
                        //                     'Employee Name: ${row.getCells()[1].value.toString()}'),
                        //                 Text(
                        //                     'Employee Designation: ${row.getCells()[2].value.toString()}'),
                        //               ],
                        //             ))));
                      },
                      child: const Text('Data'));
                })
              : Text(dataGridCell.value.toString()));
    }).toList());
  }
}

class Employee {
  Employee(this.id, this.name, this.designation, this.Section);
  final int id;
  final String name;
  final String designation;
  final String Section;
}

// class SortablePage extends StatefulWidget {
//   @override
//   _SortablePageState createState() => _SortablePageState();
// }

// class _SortablePageState extends State<SortablePage> {
//   late List<User> users;
//   int? sortColumnIndex;
//   bool isAscending = false;

//   @override
//   void initState() {
//     super.initState();

//     this.users = List.of(allUsers);
//   }

//   @override
//   Widget build(BuildContext context) => Scaffold(
//         body: ScrollableWidget(child: buildDataTable()),
//       );

//   Widget buildDataTable() {
//     final columns = ['First Name', 'Last Name', 'Age'];

//     return DataTable(
//       sortAscending: isAscending,
//       sortColumnIndex: sortColumnIndex,
//       columns: getColumns(columns),
//       rows: getRows(users),
//     );
//   }

//   List<DataColumn> getColumns(List<String> columns) => columns
//       .map((String column) => DataColumn(
//             label: Text(column),
//             onSort: onSort,
//           ))
//       .toList();

//   List<DataRow> getRows(List<User> users) => users.map((User user) {
//         final cells = [user.firstName, user.lastName, user.age];

//         return DataRow(cells: getCells(cells));
//       }).toList();

//   List<DataCell> getCells(List<dynamic> cells) =>
//       cells.map((data) => DataCell(Text('$data'))).toList();

//   void onSort(int columnIndex, bool ascending) {
//     if (columnIndex == 0) {
//       users.sort((user1, user2) =>
//           compareString(ascending, user1.firstName, user2.firstName));
//     } else if (columnIndex == 1) {
//       users.sort((user1, user2) =>
//           compareString(ascending, user1.lastName, user2.lastName));
//     } else if (columnIndex == 2) {
//       users.sort((user1, user2) =>
//           compareString(ascending, '${user1.age}', '${user2.age}'));
//     }

//     setState(() {
//       this.sortColumnIndex = columnIndex;
//       this.isAscending = ascending;
//     });
//   }

//   int compareString(bool ascending, String value1, String value2) =>
//       ascending ? value1.compareTo(value2) : value2.compareTo(value1);
// }
// import 'package:datatable_selectable_example/model/country.dart';
// import 'package:datatable_selectable_example/utils.dart';
// import 'package:datatable_selectable_example/widget/flag_widget.dart';
// import 'package:datatable_selectable_example/widget/scrollable_widget.dart';
// import 'package:flutter/material.dart';

//
// import 'package:flutter/material.dart';
// import 'user.dart';

// class DataTableDemo extends StatefulWidget {
//   DataTableDemo() : super();

//   final String title = "Data Table Flutter Demo";

//   @override
//   DataTableDemoState createState() => DataTableDemoState();
// }

// class DataTableDemoState extends State<DataTableDemo> {
  
//   // late List<User> users;
//   // late List<User> selectedUsers;
//   // late bool sort;

//   @override
//   Widget build(BuildContext context) => Scaffold(
//         // appBar: AppBar(
//         //     title: Text(MyApp.'Title'),
//         //     ),
//         backgroundColor: Color.fromRGBO(249, 239, 238, 1),

//         body: Center(
//           child: Table(
//             border: TableBorder.all(),
//             columnWidths: {
//               0: FractionColumnWidth(0.20),
//               1: FractionColumnWidth(0.25),
//               2: FractionColumnWidth(0.25),
//               3: FractionColumnWidth(0.25),
//               4: FractionColumnWidth(0.25),
//             },
//             children: [
//               buildRow(['No.', ' Name ', 'Class', 'Section', 'View Data'],
//                   isHeader: true),
//               buildRow(['1', 'Mahesh ', '10', 'A',   children: <Widget>[new ElevatedButton(onPressed(){})]]),
//               buildRow(['2', 'Pawan ', '10', 'C', 'w']),
//               buildRow(['3', 'Naveen ', '7', 'B', 'w']),
//               buildRow(['4', 'Arjun ', '8', 'D', 'w']),
//               buildRow(['5', 'Nithin ', '8', 'C', 'w']),
//             ],
//           ),
//         ),
//       );
//   TableRow buildRow(List<String> cells, {bool isHeader = false}) => TableRow(
//           children: cells.map((cell) {
//         final style = TextStyle(
//           fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
//         );
//         return Padding(
//           padding: const EdgeInsets.all(12),
//           child: Center(child: Text(cell, style: style)),
//         );
//       }).toList());
// }
//   void initState() {
//     sort = false;
//     selectedUsers = [];
//     users = User.getUsers();
//     super.initState();
//   }

//   onSortColum(int columnIndex, bool ascending) {
//     if (columnIndex == 0) {
//       if (ascending) {
//         users.sort((a, b) => a.firstName.compareTo(b.firstName));
//       } else {
//         users.sort((a, b) => b.firstName.compareTo(a.firstName));
//       }
//     }
//   }

//   onSelectedRow(bool selected, User user) async {
//     setState(() {
//       if (selected) {
//         selectedUsers.add(user);
//       } else {
//         selectedUsers.remove(user);
//       }
//     });
//   }

//   deleteSelected() async {
//     setState(() {
//       if (selectedUsers.isNotEmpty) {
//         List<User> temp = [];
//         temp.addAll(selectedUsers);
//         for (User user in temp) {
//           users.remove(user);
//           selectedUsers.remove(user);
//         }
//       }
//     });
//   }

//   SingleChildScrollView dataBody() {
//     return SingleChildScrollView(
//       scrollDirection: Axis.vertical,
//       child: DataTable(
//         sortAscending: sort,
//         sortColumnIndex: 0,
//         columns: [
//           DataColumn(
//               label: Text("FIRST NAME"),
//               numeric: false,
//               tooltip: "This is First Name",
//               onSort: (columnIndex, ascending) {
//                 setState(() {
//                   sort = !sort;
//                 });
//                 onSortColum(columnIndex, ascending);
//               }),
//           DataColumn(
//             label: Text("LAST NAME"),
//             numeric: false,
//             tooltip: "This is Last Name",
//           ),
//           // DataColumn(
//           //   label: Text("ROLL NO."),
//           //   numeric: true,
//           //   tooltip: "This is roll no.",
//           // ),
//         ],
//         rows: users
//             .map(
//               (user) => DataRow(
//                   selected: selectedUsers.contains(user),
//                   onSelectChanged: (b) {
//                     print("Onselect");
//                     onSelectedRow(b!, user);
//                   },
//                   cells: [
//                     DataCell(
//                       Text(user.firstName),
//                       onTap: () {
//                         print('Selected ${user.firstName}');
//                       },
//                     ),
//                     DataCell(
//                       Text(user.lastName),
//                     ),
//                   ]),
//             )
//             .toList(),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Column(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.center,
//         verticalDirection: VerticalDirection.down,
//         children: <Widget>[
//           Expanded(
//             child: dataBody(),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               Padding(
//                 padding: EdgeInsets.all(20.0),
//                 child: OutlinedButton(
//                   child: Text('SELECTED ${selectedUsers.length}'),
//                   onPressed: () {},
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(20.0),
//                 child: OutlinedButton(
//                   child: Text('DELETE SELECTED'),
//                   onPressed: selectedUsers.isEmpty
//                       ? null
//                       : () {
//                           deleteSelected();
//                         },
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
