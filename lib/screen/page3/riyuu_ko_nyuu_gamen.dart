import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:link_life_one/api/KojiPageApi/get_riyuu.dart';
import 'package:link_life_one/components/toast.dart';
import 'package:link_life_one/screen/page3/shashin_teishuutsu_gamen_page_2.dart';
import 'package:link_life_one/shared/cache_notifier.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../../components/custom_text_field.dart';
import '../../components/text_line_down.dart';
import '../../shared/assets.dart';
import '../../shared/custom_button.dart';

class RiyuuKoNyuuGamen extends StatefulWidget {
  final String JYUCYU_ID;
  final int index;
  final String KOJI_ST;
  final String lableTextField;
  const RiyuuKoNyuuGamen({
    required this.JYUCYU_ID,
    required this.index,
    required this.KOJI_ST,
    required this.lableTextField,
    Key? key,
  }) : super(key: key);

  @override
  State<RiyuuKoNyuuGamen> createState() => _RiyuuKoNyuuGamenState();
}

class _RiyuuKoNyuuGamenState extends State<RiyuuKoNyuuGamen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController controller = TextEditingController();
  DateTime date = DateTime.now();

  dynamic riyuu = [];

  @override
  void initState() {
    callRiyuu();
    super.initState();
  }

  Future<void> callRiyuu() async {
    dynamic result = await GetRiyuu()
        .getRiyuu(JYUCYU_ID: widget.JYUCYU_ID, onSuccess: () {});
    setState(
      () {
        riyuu = result;
        controller.text = riyuu[0]['CANCEL_RIYU'] ?? "";
        date = riyuu[0]['MTMORI_YMD'] != null
            ? DateFormat('yyyy-MM-dd').parse(riyuu[0]['MTMORI_YMD'])
            : DateTime.now();
        loadCache();
      },
    );
  }

  void loadCache() {
    Tuple2<String, DateTime>? data = context
        .read<CacheNotifier>()
        .cacheRiyuu[widget.JYUCYU_ID + widget.index.toString()];
    if (data != null) {
      controller.text = data.item1;
      date = data.item2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 650,
      child: Form(
        key: _formKey,
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 80,
                      child: TextLineDown(
                        style: const TextStyle(
                            fontSize: 20,
                            color: Color(0xFF042C5C),
                            fontWeight: FontWeight.w500),
                        text: '戻る',
                        onTap: () {
                          context
                            .read<CacheNotifier>()
                            .cacheRiyuuData(
                                widget.JYUCYU_ID + widget.index.toString(),
                                Tuple2(controller.text, date));
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: const Color.fromARGB(255, 247, 240, 240),
                        )),
                        width: 200,
                        child: CustomButton(
                          color: Colors.white70,
                          onClick: () {},
                          name: '理由記入画面',
                          textStyle: const TextStyle(
                            color: Color(0xFF042C5C),
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 80,
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        widget.lableTextField,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: CustomTextField(
                    hint: '',
                    type: TextInputType.text,
                    validator: _validateString,
                    controller: controller,
                    maxLines: 10,
                    borderColor: Colors.black,
                  ),
                ),
                Visibility(
                  visible: widget.index == 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          '見積提出予定日：',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 200,
                        child: widget.index == 3
                            ? Text(
                                DateFormat('yyyy年 MM月 dd日', 'ja')
                                    .format(date)
                                    .toString(),
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w700),
                              )
                            : GestureDetector(
                                onTap: () async {
                                  DatePicker.showDatePicker(context,
                                      showTitleActions: true,
                                      minTime: DateTime.now(),
                                      maxTime: DateTime(2200, 6, 7),
                                      onChanged: (datePick) {},
                                      onConfirm: (newDate) {
                                    setState(() {
                                      date = newDate;
                                    });
                                  },
                                      currentTime: DateTime.now(),
                                      locale: LocaleType.jp);
                                },
                                child: Row(
                                  children: [
                                    Image.asset(
                                      Assets.icCalendar,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      DateFormat('yyyy /MM / dd (E)', 'ja')
                                          .format(
                                            date,
                                          )
                                          .toString(),
                                      style: const TextStyle(
                                        color: Color(0xFF77869E),
                                        fontSize: 14.5,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    GestureDetector(
                      onTap: () {
                        if (_formKey.currentState?.validate() == true) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => widget.index == 2
                                  ? ShashinTeishuutsuGamenPage2(
                                      KOJI_ST: widget.KOJI_ST,
                                      index: widget.index,
                                      JYUCYU_ID: widget.JYUCYU_ID,
                                      mitmoriYmd: date,
                                      cancelRiyuu: controller.text,
                                    )
                                  : ShashinTeishuutsuGamenPage2(
                                      KOJI_ST: widget.KOJI_ST,
                                      index: widget.index,
                                      JYUCYU_ID: widget.JYUCYU_ID,
                                      cancelRiyuu: controller.text,
                                    ),
                            ),
                          );
                        }
                      },
                      child: Container(
                        width: 180,
                        height: 37,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFA800),
                          borderRadius: BorderRadius.circular(26),
                        ),
                        child: const Center(
                          child: Text(
                            '次へ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _validateString(String? input) {
    if (input == null || input.trim() == '') {
      return "未入力";
    } else {
      return null;
    }
  }
}
