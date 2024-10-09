import 'package:flutter/material.dart';
import 'package:gatepay_convert/shared/utils/theme.dart';

class CustomCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;

  const CustomCheckbox({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged?.call(!widget.value);
      },
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 24,
          height: 24,
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: widget.value ? tPrimaryColor : tPrimaryColorShade2,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: tPrimaryColor,
              width: 2,
            ),
          ),
          child: widget.value
              ? Icon(
                  Icons.check,
                  size: 20,
                  color: Colors.white,
                )
              : null,
        ),
      ),
    );
  }
}
