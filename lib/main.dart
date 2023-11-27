import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Salary Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SalaryCalculator(),
    );
  }
}

class SalaryCalculator extends StatefulWidget {
  @override
  _SalaryCalculatorState createState() => _SalaryCalculatorState();
}

class _SalaryCalculatorState extends State<SalaryCalculator> {
  TextEditingController employeeController = TextEditingController();
  TextEditingController basicSalaryController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController allowanceController = TextEditingController();
  TextEditingController otherEarningsController = TextEditingController();
  TextEditingController otController = TextEditingController();
  TextEditingController welfareController = TextEditingController();
  TextEditingController otherContributionsController = TextEditingController();

  bool epfCheckboxValue = false;

  double grossSalary = 0.0;
  double totalDeduction = 0.0;
  double netSalary = 0.0;

  // Variables to store user input for Paysheet Header
  String employeeName = '';
  double enteredBasicSalary = 0.0;
  String enteredDesignation = '';
  double enteredAllowance = 0.0;
  double enteredOtherEarnings = 0.0;
  double enteredOT = 0.0;
  bool enteredEPFCheckboxValue = false;
  double enteredWelfareContribution = 0.0;
  double enteredOtherContributions = 0.0;

  void _calculateSalary() {
    // Store user input for Paysheet Header
    employeeName = employeeController.text;
    enteredBasicSalary = double.tryParse(basicSalaryController.text) ?? 0.0;
    enteredDesignation = designationController.text;
    enteredAllowance = double.tryParse(allowanceController.text) ?? 0.0;
    enteredOtherEarnings = double.tryParse(otherEarningsController.text) ?? 0.0;
    enteredOT = double.tryParse(otController.text) ?? 0.0;
    enteredEPFCheckboxValue = epfCheckboxValue;
    enteredWelfareContribution = double.tryParse(welfareController.text) ?? 0.0;
    enteredOtherContributions = double.tryParse(otherContributionsController.text) ?? 0.0;

    double basicSalary = enteredBasicSalary;
    double allowance = enteredAllowance;
    double otherEarnings = enteredOtherEarnings;
    double ot = enteredOT;

    grossSalary = basicSalary + allowance + otherEarnings + ot;

    if (enteredEPFCheckboxValue) {
      double epf = basicSalary * 0.12; // Assuming EPF is 12% of the basic salary
      totalDeduction = epf +
          (enteredWelfareContribution) +
          (enteredOtherContributions);
    } else {
      totalDeduction =
          (enteredWelfareContribution) +
              (enteredOtherContributions);
    }

    netSalary = grossSalary - totalDeduction;

    setState(() {});
  }

  void _clearFields() {
    employeeController.clear();
    basicSalaryController.clear();
    designationController.clear();
    allowanceController.clear();
    otherEarningsController.clear();
    otController.clear();
    welfareController.clear();
    otherContributionsController.clear();
    epfCheckboxValue = false;
    grossSalary = 0.0;
    totalDeduction = 0.0;
    netSalary = 0.0;

    // Clear user input for Paysheet Header
    employeeName = '';
    enteredBasicSalary = 0.0;
    enteredDesignation = '';
    enteredAllowance = 0.0;
    enteredOtherEarnings = 0.0;
    enteredOT = 0.0;
    enteredEPFCheckboxValue = false;
    enteredWelfareContribution = 0.0;
    enteredOtherContributions = 0.0;

    setState(() {});
  }

  void paysheetHeader() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Employee Name: $employeeName'),
                Text('Designation: $enteredDesignation'),
                Text('Net Income: $netSalary'),
                Divider(),
                Table(
                  children: [
                    buildTableRow('Basic Salary', enteredBasicSalary),
                    
                    buildTableRow('Gross Salary', grossSalary),
                    
                    buildTableRow('Total Deduction', totalDeduction),
                  ],
                ),
                Divider(),
                Table(
                  children: [
                    buildTableRow('Company', 'XXX Company Pvt(Ltd.)'),
                    buildTableRow('Net Salary', netSalary),
                    buildTableRow('Allowance', enteredAllowance),
                    buildTableRow('Other Allowance', enteredOtherEarnings),
                    buildTableRow('Over Time', enteredOT),
                    buildTableRow('EPF Employee 12%', enteredEPFCheckboxValue),
                    buildTableRow('Welfare Contribution', enteredWelfareContribution),
                    buildTableRow('Other Contribution', enteredOtherContributions),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  TableRow buildTableRow(String label, dynamic value) {
    return TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(label),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(':'),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('$value'),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Salary Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: ListView(
                children: [
                  Text(
                    'Employee Information',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  buildTextField('Employee', employeeController),
                  SizedBox(height: 10),
                  buildTextField('Basic Salary', basicSalaryController),
                  SizedBox(height: 10),
                  buildTextField('Designation', designationController),
                  SizedBox(height: 20),
                  Text(
                    'Earnings',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  buildTextField('Allowance', allowanceController),
                  SizedBox(height: 10),
                  buildTextField('Other Earnings', otherEarningsController),
                  SizedBox(height: 10),
                  buildTextField('OT', otController),
                  SizedBox(height: 10),
                  Text('Gross Salary: $grossSalary'),
                  SizedBox(height: 20),
                  Text(
                    'Deduction',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Checkbox(
                        value: epfCheckboxValue,
                        onChanged: (value) {
                          setState(() {
                            epfCheckboxValue = value ?? false;
                          });
                        },
                      ),
                      Text('EPF Employee Amount'),
                    ],
                  ),
                  SizedBox(height: 10),
                  buildTextField('Welfare Contribution', welfareController),
                  SizedBox(height: 10),
                  buildTextField('Other Contributions', otherContributionsController),
                  SizedBox(height: 10),
                  Text('Total Deduction: $totalDeduction'),
                  SizedBox(height: 20),
                  Text('Net Salary: $netSalary'),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: _calculateSalary,
                        child: Text('Calculate'),
                      ),
                      ElevatedButton(
                        onPressed: _clearFields,
                        child: Text('Clear'),
                      ),
                      ElevatedButton(
                        onPressed: paysheetHeader,
                        child: Text('Paysheet Header'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.grey),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Paysheet Header", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text("Employee Name: $employeeName"),
                    Text("Designation: $enteredDesignation"),
                    Text("Net Income: $netSalary"),
                    Divider(),
                    Table(
                      children: [
                        buildTableRow('Basic Salary', enteredBasicSalary),
                        
                        buildTableRow('Gross Salary', grossSalary),
                        
                        buildTableRow('Total Deduction', totalDeduction),
                      ],
                    ),
                    Divider(),
                    Table(
                      children: [
                        buildTableRow('Company', 'XXX Company Pvt(Ltd.)'),
                        buildTableRow('Net Salary', netSalary),
                        buildTableRow('Allowance', enteredAllowance),
                        buildTableRow('Other Allowance', enteredOtherEarnings),
                        buildTableRow('Over Time', enteredOT),
                        buildTableRow('EPF Employee 12%', enteredEPFCheckboxValue),
                        buildTableRow('Welfare Contribution', enteredWelfareContribution),
                        buildTableRow('Other Contribution', enteredOtherContributions),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      controller: controller,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
    );
  }
}
