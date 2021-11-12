import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

void main() {
  runApp(const MaterialApp(home: SfDataGridDemo()));
}

class SfDataGridDemo extends StatefulWidget {
  const SfDataGridDemo({Key? key}) : super(key: key);

  @override
  _SfDataGridDemoState createState() => _SfDataGridDemoState();
}

class _SfDataGridDemoState extends State<SfDataGridDemo> {
  late EmployeeDataGridSource _employeeDataGridSource;
  List<Employee> _employees = <Employee>[];
  final DataGridController _dataGridController = DataGridController();

  @override
  void initState() {
    super.initState();
    _employees = getEmployeeData();
    _employeeDataGridSource = EmployeeDataGridSource(employees: _employees);
    _dataGridController.selectedRows = [
      _employeeDataGridSource.dataGridRows[0],
      _employeeDataGridSource.dataGridRows[2],
      _employeeDataGridSource.dataGridRows[4]
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('SfDataGrid Demo')),
        body: SfDataGrid(
            source: _employeeDataGridSource,
            controller: _dataGridController,
            selectionMode: SelectionMode.multiple,
            columns: [
              GridColumn(
                  columnName: 'id',
                  label: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      alignment: Alignment.centerRight,
                      child: const Text(
                        'ID',
                        overflow: TextOverflow.ellipsis,
                      ))),
              GridColumn(
                  columnName: 'name',
                  label: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Name',
                        overflow: TextOverflow.ellipsis,
                      ))),
              GridColumn(
                  columnName: 'designation',
                  label: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Designation',
                        overflow: TextOverflow.ellipsis,
                      ))),
              GridColumn(
                  columnName: 'salary',
                  label: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      alignment: Alignment.centerRight,
                      child: const Text(
                        'Salary',
                        overflow: TextOverflow.ellipsis,
                      )))
            ]));
  }
}

class EmployeeDataGridSource extends DataGridSource {
  EmployeeDataGridSource({required List<Employee> employees}) {
    dataGridRows = employees
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: dataGridRow.id),
              DataGridCell<String>(columnName: 'name', value: dataGridRow.name),
              DataGridCell<String>(
                  columnName: 'designation', value: dataGridRow.designation),
              DataGridCell<double>(
                  columnName: 'salary', value: dataGridRow.salary),
            ]))
        .toList();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
          alignment: (dataGridCell.columnName == 'id' ||
                  dataGridCell.columnName == 'salary')
              ? Alignment.centerRight
              : Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            dataGridCell.value.toString(),
            overflow: TextOverflow.ellipsis,
          ));
    }).toList());
  }
}

class Employee {
  Employee(this.id, this.name, this.designation, this.salary);
  int id;
  String name;
  String designation;
  double salary;
}

List<Employee> getEmployeeData() {
  return [
    Employee(10001, 'James', 'Project Lead', 20000),
    Employee(10002, 'Kathryn', 'Manager', 30000),
    Employee(10003, 'Lara', 'Developer', 15000),
    Employee(10004, 'Michael', 'Designer', 15000),
    Employee(10005, 'Martin', 'Developer', 15000),
    Employee(10006, 'Newberry', 'Developer', 15000),
    Employee(10007, 'Balnc', 'Developer', 15000),
    Employee(10008, 'Perry', 'Developer', 15000),
    Employee(10009, 'Gable', 'Developer', 15000),
    Employee(10010, 'Grimes', 'Developer', 15000),
  ];
}
