import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:sizer/sizer.dart';

class ProfileListTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final VoidCallback? onTap;
  final Widget? trailing;

  const ProfileListTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.5.h),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: .5.h),
        leading: Icon(
          icon,
          size: 20.sp,
          color: theme.primaryColor, // Constant icon color
          semanticLabel: '$title icon',
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: theme.textTheme.bodyLarge?.color, // Constant title color
          ),
        ),
        subtitle:
            subtitle != null
                ? Text(
                  subtitle!,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w300,
                    color: theme.textTheme.bodySmall?.color?.withValues(
                      alpha: 0.7,
                    ),
                  ),
                )
                : null,
        trailing:
            trailing ??
            Icon(
              Iconsax.arrow_right_3_copy,
              size: 16.sp,
              color: theme.textTheme.bodySmall?.color?.withValues(alpha: .5),
            ),
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        tileColor: Colors.transparent,
        splashColor: theme.primaryColor.withValues(alpha: 0.1),
      ),
    );
  }
}
