import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  const SectionHeader({super.key, required this.icon, required this.title});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Color(0xFF3B6EF0), size: 22, fontWeight: FontWeight.bold),
        SizedBox(width: 8),
        Text(
          title,
          style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ],
    );
  }
}

class FieldLabel extends StatelessWidget {
  final String label;
  final IconData? icon;
  const FieldLabel({super.key, required this.label, this.icon});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          if (icon != null) ...[Icon(icon, size: 14, color: Colors.grey[600]), SizedBox(width: 4)],
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final IconData? icon;
  final String hint;
  final TextEditingController? controller;
  final bool readOnly;
  final VoidCallback? onTap;
  final Widget? suffixIcon;
  final double? height;
  final int? maxLines;
  final bool expands;
  const CustomTextField({
    super.key,
    this.icon,
    required this.hint,
    this.controller,
    this.readOnly = false,
    this.onTap,
    this.suffixIcon,
    this.height,
    this.maxLines = 1,
    this.expands = false,
  });
  @override
  Widget build(BuildContext context) {
    final field = TextField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      maxLines: expands ? null : maxLines,
      expands: expands,
      style: GoogleFonts.inter(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(color: Colors.grey[500], fontSize: 13, fontWeight: FontWeight.bold),
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
    if (height != null) {
      return SizedBox(height: height, child: field);
    }
    return field;
  }
}

class CustomDropdown extends StatelessWidget {
  final String? value;
  final String hint;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  const CustomDropdown({
    super.key,
    required this.value,
    required this.hint,
    required this.items,
    required this.onChanged,
  });
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      isExpanded: true,
      initialValue: value,
      hint: Text(
        hint,
        style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[500], fontWeight: FontWeight.bold),
      ),
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(
            item,
            style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 13),
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

class CustomDateField extends StatelessWidget {
  final String label;
  final IconData icon;
  final DateTime? value;
  final VoidCallback onTap;
  const CustomDateField({super.key, required this.label, required this.icon, required this.value, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabel(label: label, icon: icon),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(icon, size: 16, color: Colors.grey[600], fontWeight: FontWeight.bold),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    value != null ? value.toString().split(" ")[0] : "Select date",
                    style: GoogleFonts.inter(fontSize: 13, color: value == null ? Colors.grey : Colors.black),
                  ),
                ),
                Icon(Icons.keyboard_arrow_down, color: Colors.grey, fontWeight: FontWeight.bold),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class FormTextArea extends StatelessWidget {
  final String label;
  final IconData icon;
  final TextEditingController controller;
  final int minLength;
  final int maxLength;
  final String hint;
  const FormTextArea({
    super.key,
    required this.label,
    required this.icon,
    required this.controller,
    this.minLength = 100,
    this.maxLength = 500,
    required this.hint,
  });
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, _) {
        final length = value.text.length;
        Color counterColor;
        if (length < minLength) {
          counterColor = Colors.red;
        } else if (length > maxLength) {
          counterColor = Colors.orange;
        } else {
          counterColor = Colors.green;
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FieldLabel(label: label, icon: icon),
                Text(
                  "$length / $maxLength",
                  style: GoogleFonts.inter(fontSize: 11, color: counterColor, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            CustomTextField(controller: controller, hint: hint, height: 130, expands: true),
            if (length > 0 && length < minLength)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  "Minimum $minLength characters required",
                  style: GoogleFonts.inter(color: Colors.red, fontSize: 11, fontWeight: FontWeight.w600),
                ),
              ),
          ],
        );
      },
    );
  }
}

class FileUploadBox extends StatelessWidget {
  final PlatformFile? file;
  final VoidCallback onTap;
  const FileUploadBox({super.key, required this.file, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 140,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cloud_upload_outlined, color: Color(0xFF3B6EF0), size: 38),
            SizedBox(height: 8),
            Text(
              file != null ? file!.name : "Click to upload file",
              style: GoogleFonts.inter(fontWeight: FontWeight.w600),
            ),
            Text(
              file != null ? "${(file!.size / 1024).toStringAsFixed(2)} KB" : "PDF, CSV, PNG (MAX 25MB)",
              style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[500]),
            ),
          ],
        ),
      ),
    );
  }
}

class PageHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  const PageHeader({super.key, required this.title, required this.subtitle});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        SizedBox(height: 6),
        Text(
          subtitle,
          style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[600], height: 1.5, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class ResourceItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final IconData trailing;
  const ResourceItem({super.key, required this.icon, required this.title, required this.trailing});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(color: Color(0xFFEFF4FF), borderRadius: BorderRadius.circular(8)),
        child: Icon(icon, color: Color(0xFF3B6EF0), size: 18, fontWeight: FontWeight.bold),
      ),
      title: Text(
        title,
        style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
      ),
      trailing: Icon(trailing, color: Colors.grey[700], size: 18, fontWeight: FontWeight.bold),
      contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
    );
  }
}
