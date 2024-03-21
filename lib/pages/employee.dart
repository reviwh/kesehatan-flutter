import 'package:flutter/material.dart';
import 'package:kesehatan/models/employee.dart';
import 'package:kesehatan/models/general_response.dart';
import 'package:kesehatan/theme/theme.dart';
import 'package:http/http.dart' as http;
import 'package:kesehatan/utils/constant.dart';
import 'package:kesehatan/widgets/dialog_button.dart';

class EmployeePage extends StatefulWidget {
  const EmployeePage({super.key});

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  List<Employee> data = [];
  TextEditingController searchController = TextEditingController();

  bool isLoading = true;

  Future<void> getEmployee() async {
    setState(() {
      isLoading = true;
    });

    try {
      http.Response res = await http.get(Uri.parse("$url/employee"));
      setState(() {
        isLoading = false;
        data.clear();
        data.addAll(employeeFromJson(res.body));
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      });
    }
  }

  Future<void> searchEmployee(String q) async {
    setState(() {
      isLoading = true;
    });

    try {
      http.Response res = await http.post(
        Uri.parse("$url/employee/search"),
        body: {'q': q},
      );
      setState(() {
        isLoading = false;
        data.clear();
        data.addAll(employeeFromJson(res.body));
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      });
    }
  }

  Future<void> createEmployee(
    String name,
    String noBp,
    String email,
    String noHp,
  ) async {
    setState(() {
      isLoading = true;
    });

    try {
      http.Response res = await http.post(Uri.parse("$url/employee/insert"),
          body: {'name': name, 'no_bp': noBp, 'email': email, 'no_hp': noHp});

      GeneralResponse data = generalResponseFromJson(res.body);
      if (data.success) {
        setState(() {
          isLoading = false;
          Navigator.pop(context);
          searchEmployee(searchController.text);
        });
      } else {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(data.message)));
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      });
    }
  }

  Future<void> updateEmployee(
    String name,
    String noBp,
    String email,
    String noHp,
  ) async {
    setState(() {
      isLoading = true;
    });

    try {
      http.Response res = await http.post(Uri.parse("$url/employee/update"),
          body: {'name': name, 'no_bp': noBp, 'email': email, 'no_hp': noHp});

      GeneralResponse data = generalResponseFromJson(res.body);
      if (data.success) {
        setState(() {
          isLoading = false;
          Navigator.pop(context);
          searchEmployee(searchController.text);
        });
      } else {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(data.message)));
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      });
    }
  }

  Future<void> deleteEmployee(String noBp) async {
    setState(() {
      isLoading = true;
    });

    try {
      http.Response res =
          await http.get(Uri.parse("$url/employee/delete/$noBp"));

      GeneralResponse data = generalResponseFromJson(res.body);

      if (data.success) {
        setState(() {
          isLoading = false;
          Navigator.pop(context);
          searchEmployee(searchController.text);
        });
      } else {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(data.message)));
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getEmployee();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context, builder: (context) => employeeActionDialog());
        },
        child: Icon(Icons.person_add_rounded, color: darkGreen),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    style: regular16pt,
                    onSubmitted: (value) {
                      searchEmployee(value);
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(4.0),
                      suffixIcon: Icon(
                        Icons.search_rounded,
                        color: textGrey,
                      ),
                      hintText: 'Search Employee',
                      hintStyle: heading6.copyWith(color: textGrey),
                      border:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    searchEmployee(searchController.text);
                  },
                  icon: Icon(
                    Icons.refresh_rounded,
                    color: textGrey,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : data.isEmpty
                    ? Center(
                        child: Text(
                          'No data found',
                          style: heading2,
                        ),
                      )
                    : ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => employeeDialog(data[index]),
                            );
                          },
                          child: ListTile(
                            title: Text(data[index].name, style: heading5),
                            subtitle: Text(data[index].email),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) =>
                                            employeeActionDialog(
                                                data: data[index]));
                                  },
                                  icon: Icon(
                                    Icons.edit_rounded,
                                    color: textGrey,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) =>
                                            deleteEmployeeDialog(data[index]));
                                  },
                                  icon: Icon(
                                    Icons.delete_rounded,
                                    color: textGrey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
          ),
        ],
      ),
    );
  }

  Widget employeeDialog(Employee data) {
    return AlertDialog(
      title: Text(
        data.name,
        style: heading2,
      ),
      content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "No. BP",
              style: heading6.copyWith(fontSize: 14),
            ),
            Text(
              data.noBp,
              style: heading5,
            ),
            const SizedBox(height: 8),
            Text(
              "Email",
              style: heading6.copyWith(fontSize: 14),
            ),
            Text(
              data.email,
              style: heading5,
            ),
            const SizedBox(height: 8),
            Text(
              "No. HP",
              style: heading6.copyWith(fontSize: 14),
            ),
            Text(
              data.noHp.isEmpty ? "-" : data.noHp,
              style: heading5,
            ),
          ]),
    );
  }

  Widget employeeActionDialog({Employee? data}) {
    GlobalKey<FormState> keyForm = GlobalKey<FormState>();
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController noBpController = TextEditingController();
    TextEditingController noHpController = TextEditingController();

    if (data != null) {
      nameController.text = data.name;
      emailController.text = data.email;
      noHpController.text = data.noHp;
    }

    return AlertDialog(
      title: Text(
        data?.name == null ? 'Add Employee' : 'Edit Employee',
        style: heading2,
      ),
      content: Form(
        key: keyForm,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: textWhiteGrey,
                  borderRadius: BorderRadius.circular(14)),
              child: TextFormField(
                controller: nameController,
                validator: (value) {
                  return value!.isEmpty ? "Name can't be empty" : null;
                },
                style: regular16pt,
                decoration: InputDecoration(
                    hintText: 'Name',
                    hintStyle: heading6.copyWith(color: textGrey),
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none)),
              ),
            ),
            const SizedBox(height: 8),
            if (data == null)
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: textWhiteGrey,
                        borderRadius: BorderRadius.circular(14)),
                    child: TextFormField(
                      controller: noBpController,
                      validator: (value) {
                        return value!.isEmpty ? "No. BP can't be empty" : null;
                      },
                      style: regular16pt,
                      decoration: InputDecoration(
                          hintText: 'No. BP',
                          hintStyle: heading6.copyWith(color: textGrey),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none)),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            Container(
              decoration: BoxDecoration(
                  color: textWhiteGrey,
                  borderRadius: BorderRadius.circular(14)),
              child: TextFormField(
                controller: emailController,
                validator: (value) {
                  return value!.isEmpty ? "Email can't be empty" : null;
                },
                keyboardType: TextInputType.emailAddress,
                style: regular16pt,
                decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: heading6.copyWith(color: textGrey),
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none)),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                  color: textWhiteGrey,
                  borderRadius: BorderRadius.circular(14)),
              child: TextFormField(
                controller: noHpController,
                keyboardType: TextInputType.phone,
                style: regular16pt,
                decoration: InputDecoration(
                    hintText: 'No. HP',
                    hintStyle: heading6.copyWith(color: textGrey),
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none)),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
      actions: [
        CustomDialogButton(
          onTap: () {
            if (keyForm.currentState!.validate()) {
              if (data == null) {
                createEmployee(
                  nameController.text,
                  noBpController.text,
                  emailController.text,
                  noHpController.text,
                );
              } else {
                updateEmployee(
                  nameController.text,
                  data.noBp,
                  emailController.text,
                  noHpController.text,
                );
              }
            }
          },
          textValue: 'Submit',
          textColor: Colors.white,
          buttonColor: primary,
        ),
        CustomDialogButton(
          onTap: () {
            Navigator.pop(context);
          },
          textValue: 'Cancel',
          textColor: Colors.white,
          buttonColor: Colors.red.shade400,
        )
      ],
    );
  }

  Widget deleteEmployeeDialog(Employee data) {
    return AlertDialog(
        title: Text(
          'Delete ${data.name}',
          style: heading2,
        ),
        content: Text(
          'Are you sure want to delete ${data.name}?',
        ),
        actions: [
          // Expanded(
          //   flex: 1,
          //   child: CustomPrimaryButton(
          //     onTap: () {
          //       deleteEmployee(data.noBp);
          //     },
          //     textValue: "Yes",
          //     textColor: Colors.white,
          //     buttonColor: Colors.red.shade400,
          //   ),
          // ),
          // Expanded(
          //   flex: 1,
          //   child: CustomPrimaryButton(
          //     onTap: () {
          //       Navigator.pop(context);
          //     },
          //     textValue: "No",
          //     textColor: Colors.black,
          //     buttonColor: Colors.grey.shade400,
          //   ),
          // )

          CustomDialogButton(
            onTap: () {
              deleteEmployee(data.noBp);
            },
            textValue: "Yes",
            buttonColor: Colors.red.shade400,
          ),
          CustomDialogButton(
            onTap: () {
              Navigator.pop(context);
            },
            textValue: "No",
            textColor: Colors.black,
            buttonColor: Colors.grey.shade400,
          ),
        ]);
  }
}
