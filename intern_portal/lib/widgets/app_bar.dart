import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showLogo;
  final bool showBack;
  final List<Widget>? actions;
  final Color backgroundColor;
  final bool showDivider;
  final Widget? customTitle;

  const CommonAppBar({
    super.key,
    this.title,
    this.showLogo = false,
    this.showBack = false,
    this.actions,
    this.backgroundColor = Colors.white,
    this.showDivider = true,
    this.customTitle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor,
      elevation: 0,
      leadingWidth: showBack ? 40 : null,
      titleSpacing: showBack ? 0 : 12,

      leading: showBack
          ? IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              icon: const Icon(Icons.arrow_back, color: Colors.black87),
              onPressed: () => Navigator.pop(context),
            )
          : null,
      title:
          customTitle ??
          (showLogo
              ? Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(color: const Color(0xFF3B6EF0), borderRadius: BorderRadius.circular(8)),
                      child: const Icon(Icons.school, color: Colors.white, size: 18),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      "InternPortal",
                      style: GoogleFonts.inter(color: Colors.black87, fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                  ],
                )
              : Text(
                  title ?? "",
                  style: GoogleFonts.inter(color: Colors.black87, fontWeight: FontWeight.w700, fontSize: 16),
                )),
      actions: actions,
      bottom: showDivider
          ? PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Divider(height: 1, color: Colors.grey[200]),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
