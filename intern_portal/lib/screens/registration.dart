import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/controllers/navigation_controller.dart';
import 'package:intern_portal/data/student/registeration_data.dart';
import 'package:intern_portal/screens/dashboard.dart';
import 'package:intern_portal/services/users/student_services.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';
import 'package:intern_portal/widgets/bottom_navigation.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intern_portal/widgets/common_widgets/common_widgets.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});
  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final jobTitleController = TextEditingController();
  final companyController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final descController = TextEditingController();
  final domainController = TextEditingController();
  final guideNameController = TextEditingController();
  final guideEmailController = TextEditingController();
  final guidePhoneController = TextEditingController();
  String? selectedCategory;
  String? selectedMode;
  String? selectedIndustry;
  PlatformFile? selectedFile;

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      String formatted = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      controller.text = formatted;
    }
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg'],
    );
    if (result != null) {
      setState(() {
        selectedFile = result.files.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(title: "Internship Registration", showBack: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: Color(0xFFEFF4FF),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Color(0xFFBDD4FF)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline, color: Color(0xFF3B6EF0), size: 18),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "You can track approval status in the Requests Status section after submitting.",
                      style: GoogleFonts.inter(fontSize: 13, color: Color(0xFF3B6EF0), height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 22),
            SectionHeader(icon: Icons.grid_view_rounded, title: "Company Details"),
            SizedBox(height: 14),
            FieldLabel(label: "COMPANY NAME"),
            CustomTextField(controller: companyController, hint: "e.g. Acme Corp"),
            SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FieldLabel(label: "SELECT CATEGORY"),
                      CustomDropdown(
                        value: selectedCategory,
                        hint: "Choose...",
                        items: categories,
                        onChanged: (value) {
                          setState(() {
                            selectedCategory = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FieldLabel(label: "INDUSTRY"),
                      CustomDropdown(
                        value: selectedIndustry,
                        hint: "Choose...",
                        items: industries,
                        onChanged: (value) {
                          setState(() {
                            selectedIndustry = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FieldLabel(label: "JOB TITLE"),
                      CustomTextField(controller: jobTitleController, hint: "e.g. Mobile App Developer"),
                    ],
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FieldLabel(label: "WORK MODE"),
                      CustomDropdown(
                        value: selectedMode,
                        hint: "Choose...",
                        items: modes,
                        onChanged: (value) {
                          setState(() {
                            selectedMode = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 14),
            FieldLabel(label: "INTERNSHIP DOMAIN"),
            CustomTextField(controller: domainController, hint: "e.g. App Developer"),
            SizedBox(height: 14),
            Row(
              children: [
                Expanded(child: FieldLabel(label: "START DATE")),
                SizedBox(width: 12),
                Expanded(child: FieldLabel(label: "END DATE")),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    hint: "From",
                    controller: startDateController,
                    readOnly: true,
                    onTap: () => _selectDate(context, startDateController),
                    suffixIcon: Icon(Icons.calendar_today_outlined),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomTextField(
                    hint: "To",
                    controller: endDateController,
                    readOnly: true,
                    onTap: () => _selectDate(context, endDateController),
                    suffixIcon: Icon(Icons.calendar_today_outlined),
                  ),
                ),
              ],
            ),
            SizedBox(height: 14),
            FieldLabel(label: "PHONE"),
            CustomTextField(controller: phoneController, hint: "+1 (555) 000-0000"),
            SizedBox(height: 14),
            FieldLabel(label: "ADDRESS"),
            CustomTextField(controller: addressController, hint: "Full office address"),
            SizedBox(height: 14),
            FieldLabel(label: "COMPANY DESCRIPTION"),
            CustomTextField(
              controller: descController,
              hint: "Briefly describe what the company does",
              height: 90,
              maxLines: 3,
            ),
            SizedBox(height: 24),
            SectionHeader(icon: Icons.person_outline_rounded, title: "Industry Guide Details"),
            SizedBox(height: 14),
            FieldLabel(label: "GUIDE NAME"),
            CustomTextField(controller: guideNameController, hint: "John Doe"),
            SizedBox(height: 14),
            FieldLabel(label: "EMAIL ADDRESS"),
            CustomTextField(controller: guideEmailController, hint: "john.doe@company.com"),
            SizedBox(height: 14),
            FieldLabel(label: "PHONE"),
            CustomTextField(controller: guidePhoneController, hint: "+1 (555) 000-0000"),
            SizedBox(height: 24),
            SectionHeader(icon: Icons.description_outlined, title: "Documentation"),
            SizedBox(height: 14),
            FieldLabel(label: "OFFER LETTER", icon: Icons.attach_file),
            FileUploadBox(file: selectedFile, onTap: pickFile),
            SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () async {
                      final res = await StudentServices.submitForm(
                        formAction: "draft",
                        companyName: companyController.text,
                        category: selectedCategory ?? "",
                        industry: selectedIndustry ?? "",
                        mode: selectedMode ?? "",
                        jobtitle: jobTitleController.text,
                        phone: phoneController.text,
                        address: addressController.text,
                        description: descController.text,
                        domain: domainController.text,
                        fromDate: startDateController.text,
                        toDate: endDateController.text,
                        guideName: guideNameController.text,
                        guideEmail: guideEmailController.text,
                        guidePhone: guidePhoneController.text,
                        file: selectedFile,
                      );
                      if (res['success'] == true) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Draft saved successfully")));
                        await Future.delayed(Duration(seconds: 1));
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DashboardPage()));
                      } else {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(res['message'] ?? "Something went wrong")));
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      side: BorderSide(color: Colors.grey[400]!),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    child: Text(
                      "Save Draft",
                      style: GoogleFonts.inter(color: Colors.black87, fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      final res = await StudentServices.submitForm(
                        formAction: "submit",
                        companyName: companyController.text,
                        category: selectedCategory ?? "",
                        industry: selectedIndustry ?? "",
                        phone: phoneController.text,
                        address: addressController.text,
                        mode: selectedMode ?? "",
                        jobtitle: jobTitleController.text,
                        description: descController.text,
                        domain: domainController.text,
                        fromDate: startDateController.text,
                        toDate: endDateController.text,
                        guideName: guideNameController.text,
                        guideEmail: guideEmailController.text,
                        guidePhone: guidePhoneController.text,
                        file: selectedFile,
                      );
                      if (res['success'] == true) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text("Application submitted successfully")));
                        await Future.delayed(Duration(seconds: 1));
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DashboardPage()));
                      } else {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(res['message'] ?? "Something went wrong")));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF0000FF),
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      elevation: 0,
                    ),
                    child: Text(
                      "Submit Application",
                      style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: 1,
        onTap: (index) => BottomNavController.onItemTapped(context, index),
      ),
    );
  }
}
