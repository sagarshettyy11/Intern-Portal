import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/controllers/navigation_controller.dart';
import 'package:intern_portal/services/users/student_services.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';
import 'package:intern_portal/widgets/bottom_navigation.dart';
import 'package:file_picker/file_picker.dart';

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

  final List<String> modes = ['On-Site', 'Remote', 'Hybrid'];

  final List<String> categories = [
    '7 days',
    '10 days',
    '15 days',
    '1 months',
    '1.5 months',
    '2 months',
    '2.5 months',
    '3 months',
    '4 months',
    '6 months',
    '6 + months',
  ];

  final List<String> industries = [
    'Information Technology',
    'Software Development',
    'Banking & Finance',
    'Automobile',
    'Aerospace',
    'Pharmaceutical',
    'Telecommunications',
    'Retail & E-Commerce',
    'Hospitality',
    'Government / PSU',
    'Other',
  ];

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
            _SectionHeader(icon: Icons.grid_view_rounded, title: "Company Details"),
            SizedBox(height: 14),
            _FieldLabel("COMPANY NAME"),
            _TextField(controller: companyController, hint: "e.g. Acme Corp"),
            SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _FieldLabel("SELECT CATEGORY"),
                      DropdownButtonFormField<String>(
                        initialValue: selectedCategory,
                        hint: Text("Choose..."),
                        items: categories.map((item) {
                          return DropdownMenuItem(value: item, child: Text(item));
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedCategory = value;
                          });
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 13),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _FieldLabel("INDUSTRY"),
                      DropdownButtonFormField<String>(
                        isExpanded: true,
                        initialValue: selectedIndustry,
                        hint: Text("Choose..."),
                        items: industries.map((item) {
                          return DropdownMenuItem(value: item, child: Text(item));
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedIndustry = value;
                          });
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 13),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 14),
            _FieldLabel("INTERNSHIP DOMAIN"),
            _TextField(controller: domainController, hint: "e.g. App Developer"),
            SizedBox(height: 14),
            Row(
              children: [
                Expanded(child: _FieldLabel("START DATE")),
                SizedBox(width: 12),
                Expanded(child: _FieldLabel("END DATE")),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: _TextField(
                    hint: "From",
                    controller: startDateController,
                    readOnly: true,
                    onTap: () => _selectDate(context, startDateController),
                    suffixIcon: Icon(Icons.calendar_today_outlined),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _TextField(
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
            _FieldLabel("PHONE"),
            _TextField(controller: phoneController, hint: "+1 (555) 000-0000"),
            SizedBox(height: 14),
            _FieldLabel("ADDRESS"),
            _TextField(controller: addressController, hint: "Full office address"),
            SizedBox(height: 14),
            _FieldLabel("COMPANY DESCRIPTION"),
            SizedBox(
              height: 90,
              child: TextField(
                maxLines: null,
                expands: true,
                controller: descController,
                decoration: InputDecoration(
                  hintText: "Briefly describe what the company does",
                  hintStyle: GoogleFonts.inter(color: Colors.grey[400], fontSize: 13),
                  contentPadding: EdgeInsets.all(14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xFF3B6EF0)),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),
            _SectionHeader(icon: Icons.person_outline_rounded, title: "Industry Guide Details"),
            SizedBox(height: 14),
            _FieldLabel("GUIDE NAME"),
            _TextField(controller: guideNameController, hint: "John Doe"),
            SizedBox(height: 14),
            _FieldLabel("EMAIL ADDRESS"),
            _TextField(controller: guideEmailController, hint: "john.doe@company.com"),
            SizedBox(height: 14),
            _FieldLabel("PHONE"),
            _TextField(controller: guidePhoneController, hint: "+1 (555) 000-0000"),
            SizedBox(height: 24),
            _SectionHeader(icon: Icons.description_outlined, title: "Documentation"),
            SizedBox(height: 14),
            _FieldLabel("OFFER LETTER"),
            GestureDetector(
              onTap: pickFile,
              child: Container(
                height: 130,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.cloud_upload_outlined, color: Color(0xFF3B6EF0), size: 36),
                    SizedBox(height: 8),
                    Text(
                      selectedFile != null ? selectedFile!.name : "Click to upload file",
                      style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 13, color: Colors.black87),
                    ),
                    SizedBox(height: 4),
                    Text(
                      selectedFile != null
                          ? "${(selectedFile!.size / 1024).toStringAsFixed(2)} KB"
                          : "PDF, PNG, JPG (Max 5MB)",
                      style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),
            ),
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
                      debugPrint(res.toString());
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
                        debugPrint("SUCCESS");
                      } else {
                        debugPrint(res['message']);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF3B6EF0),
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
            SizedBox(height: 20),
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

class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  const _SectionHeader({required this.icon, required this.title});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Color(0xFF3B6EF0), size: 22),
        SizedBox(width: 8),
        Text(
          title,
          style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
      ],
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String label;
  const _FieldLabel(this.label);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: Colors.grey[500],
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final bool readOnly;
  final VoidCallback? onTap;
  final Widget? suffixIcon;
  const _TextField({required this.hint, this.controller, this.readOnly = false, this.onTap, this.suffixIcon});
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(color: Colors.grey[400], fontSize: 13),
        suffixIcon: suffixIcon,
        contentPadding: EdgeInsets.symmetric(vertical: 13, horizontal: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xFF3B6EF0)),
        ),
      ),
    );
  }
}
