import 'package:cool_alert/cool_alert.dart';

class DialogAction {
  alertDialog(context, title, type, text, confirmBtnText, cancelBtnText,
      Function onConfirm, Function onCancel) {
    CoolAlert.show(
      context: context,
      title: title,
      type: type,
      text: text,
      confirmBtnText: confirmBtnText,
      onConfirmBtnTap: onConfirm,
      cancelBtnText: cancelBtnText,
      onCancelBtnTap: onCancel,
      showCancelBtn: true,
    );
  }

  alertDialogOneButton(
      context, title, type, text, confirmBtnText, Function onConfirm) {
    CoolAlert.show(
      context: context,
      title: title,
      type: type,
      text: text,
      confirmBtnText: confirmBtnText,
      onConfirmBtnTap: onConfirm,
      showCancelBtn: false,
    );
  }
}
