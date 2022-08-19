import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const double _radius = 5;

class DropDownFieldWidget<T> extends StatelessWidget {
  final Map<T, String> nameValuesMap;
  final String? label;
  final String? hint;
  final void Function(T? value)? onValueChange;
  final bool isRequired;
  final TextStyle? textStyle;
  final bool enabled;
  final double maxWidth;
  final T? value;
  final Widget Function(T item)? itemIconGetter;

  const DropDownFieldWidget(this.nameValuesMap,
      {this.label,
        this.isRequired = true,
        this.enabled = true,
        this.onValueChange,
        this.value,
        Key? key,
        this.itemIconGetter, this.hint, this.textStyle,
        this.maxWidth= 340,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (label?.isNotEmpty ?? false)
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 0, 10),
              child: AutoSizeText(label!,
                style: TextStyle(fontSize: 15, color: Theme.of(context).hintColor),
                maxFontSize: 15,
                minFontSize: 12,
                maxLines: 1,
              ),
            ),
          Stack(
            children: [
              DropdownButtonFormField<T>(
                style: textStyle,
                decoration: InputDecoration(

                  contentPadding:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  enabled: enabled,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(_radius)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color:Theme.of(context).hintColor),
                    borderRadius:const BorderRadius.all(Radius.circular(_radius)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).hintColor),
                    borderRadius:
                    const BorderRadius.all(Radius.circular(_radius)),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).hintColor),
                    borderRadius:
                    const BorderRadius.all(Radius.circular(_radius)),
                  ),
                ),
                isExpanded: true,
                onChanged: onValueChange,
                hint: Text(hint==null?"":hint!),
                value: value,
                validator: (value) {
                  if (isRequired && value == null) {
                    return "This field must not be empty".tr;
                  }
                  return null;
                },
                items: [
                  for (var entry in nameValuesMap.entries)
                    DropdownMenuItem(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(entry.value.tr),
                          itemIconGetter?.call(entry.key) ??
                              const SizedBox.shrink()
                        ],
                      ),
                      value: entry.key,
                    )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}