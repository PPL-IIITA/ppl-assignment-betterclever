// Copyright (c) 2017, Pranjal Paliwal. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:ValentinesDay/Util.dart';
import 'package:ValentinesDay/model/Boy.dart';
import 'package:ValentinesDay/model/Girl.dart';

main(List<String> arguments) {
  TestingUtils.storeBoysInCSV(100);
  TestingUtils.storeGiftsInCSV(100);
  TestingUtils.storeGirlsInCSV(100);

  List<Girl> girlList = Utils.getGirls(10);
  List<Boy> boyList = Utils.getBoys(100);

  for(Boy b in boyList){
    print(b);
  }

  for(Girl girl in girlList){
    girl.assignBoyfriend(boyList);
    print(girl);
  }
}
