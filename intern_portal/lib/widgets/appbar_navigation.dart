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
              ? Image.asset('assets/intern_portal.png', height: 130, fit: BoxFit.contain)
              : Text(
                  title ?? "",
                  style: GoogleFonts.inter(
                    color: Colors.black87,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                    letterSpacing: 0.2,
                  ),
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
