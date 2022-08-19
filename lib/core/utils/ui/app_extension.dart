part of ui_utils;

extension ConvertMapToRow on Map{
  row({Color? color,required BuildContext context}) => Row(
    children: [
      Text(keys.first.toString().tr, style: TextStyle(color: color,fontSize: 14),),
      Text(" : ", style: TextStyle(color: color,fontSize: 14)),
      AutoSizeText(isIR() ?  values.first.toString().toPersianDigit() : values.first.toString() ,
          style: TextStyle(color: color,fontSize: 16),overflow: TextOverflow.ellipsis,maxLines: 3,),
    ],
  );
}