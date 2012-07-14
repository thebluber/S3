package Level 
{
	/**
     * ...
     * @author 
     */
  import engine.AssetRegistry
  import starling.display.Image;
  import starling.display.BlendMode;
  import starling.textures.TextureSmoothing;
  import UI.HUD;
  import UI.Radar;
  
  public class Level6 extends LevelState 
  {
    public function Level6() 
    {
      AssetRegistry.loadGraphics([AssetRegistry.SNAKE, AssetRegistry.LEVEL6, AssetRegistry.SCORING]);
      _levelNr = 6;
      super();
    }
    
    override protected function addSpawnMap():void {
      _spawnMap = [49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255, 264, 265, 266, 267, 268, 269, 270, 271, 272, 273, 274, 275, 276, 277, 278, 279, 280, 281, 282, 283, 284, 285, 286, 287, 288, 289, 290, 291, 292, 293, 294, 295, 296, 307, 308, 309, 310, 311, 312, 313, 314, 315, 316, 317, 318, 319, 320, 321, 322, 323, 324, 325, 326, 327, 328, 329, 330, 331, 332, 333, 334, 335, 336, 337, 338, 339, 350, 351, 352, 353, 354, 355, 356, 357, 358, 359, 360, 361, 362, 363, 364, 365, 366, 367, 368, 369, 370, 371, 372, 373, 374, 375, 376, 377, 378, 379, 380, 381, 382, 393, 394, 395, 396, 397, 398, 399, 400, 401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 412, 413, 414, 415, 416, 417, 418, 419, 420, 421, 436, 437, 438, 439, 440, 441, 442, 443, 444, 445, 446, 447, 448, 449, 450, 451, 452, 453, 454, 455, 456, 457, 458, 459, 460, 461, 462, 463, 464, 479, 480, 481, 482, 483, 484, 485, 486, 487, 488, 489, 490, 491, 492, 493, 494, 495, 496, 497, 498, 499, 500, 501, 502, 503, 504, 505, 506, 507, 517, 522, 523, 524, 525, 526, 527, 528, 529, 530, 531, 532, 533, 534, 535, 536, 537, 538, 539, 540, 541, 542, 543, 544, 545, 546, 547, 548, 549, 550, 560, 565, 566, 567, 568, 569, 570, 571, 572, 573, 574, 575, 576, 577, 578, 579, 580, 581, 582, 583, 584, 585, 586, 587, 588, 589, 590, 591, 603, 608, 609, 610, 611, 612, 613, 614, 615, 616, 617, 618, 619, 620, 621, 622, 623, 624, 625, 626, 627, 628, 629, 630, 631, 632, 633, 634, 646, 651, 652, 653, 654, 655, 656, 657, 658, 659, 660, 661, 662, 663, 664, 665, 666, 667, 668, 669, 670, 671, 672, 673, 674, 675, 676, 677, 689, 694, 695, 696, 697, 698, 699, 700, 701, 702, 703, 704, 705, 706, 707, 708, 709, 710, 711, 712, 713, 714, 715, 716, 717, 718, 719, 720, 732, 737, 738, 739, 740, 741, 742, 743, 744, 745, 746, 747, 748, 749, 750, 751, 752, 753, 754, 755, 756, 757, 758, 759, 760, 761, 762, 763, 775, 780, 781, 782, 783, 784, 785, 786, 787, 788, 789, 790, 791, 792, 793, 794, 795, 796, 797, 798, 799, 800, 801, 802, 803, 804, 805, 806, 807, 808, 809, 818, 823, 824, 825, 826, 827, 828, 829, 830, 831, 832, 833, 834, 835, 836, 837, 838, 839, 840, 841, 842, 843, 844, 845, 846, 847, 848, 849, 850, 851, 852, 861, 866, 867, 868, 869, 870, 871, 872, 873, 874, 875, 876, 877, 878, 879, 880, 881, 882, 883, 884, 885, 886, 887, 888, 889, 890, 891, 892, 893, 894, 895, 896, 897, 898, 899, 904, 909, 910, 911, 912, 913, 914, 915, 916, 917, 918, 919, 920, 921, 922, 923, 924, 925, 926, 927, 928, 929, 930, 931, 932, 933, 934, 935, 936, 937, 938, 939, 940, 941, 942, 947, 952, 953, 954, 955, 956, 957, 958, 959, 960, 961, 962, 963, 964, 965, 966, 967, 968, 969, 970, 971, 972, 973, 974, 975, 976, 977, 978, 979, 980, 981, 982, 983, 984, 985, 990, 995, 996, 997, 998, 999, 1000, 1001, 1002, 1003, 1004, 1005, 1006, 1007, 1008, 1009, 1010, 1011, 1012, 1013, 1014, 1015, 1016, 1017, 1018, 1019, 1020, 1021, 1022, 1023, 1024, 1025, 1026, 1027, 1028, 1033, 1038, 1039, 1040, 1041, 1042, 1043, 1044, 1045, 1046, 1047, 1048, 1049, 1050, 1051, 1052, 1053, 1054, 1055, 1056, 1057, 1058, 1059, 1060, 1061, 1062, 1063, 1064, 1065, 1066, 1067, 1068, 1069, 1070, 1071, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1088, 1089, 1090, 1091, 1092, 1093, 1094, 1095, 1100, 1101, 1102, 1103, 1104, 1105, 1106, 1107, 1108, 1109, 1110, 1111, 1112, 1113, 1114, 1119, 1120, 1121, 1122, 1123, 1124, 1125, 1126, 1127, 1128, 1129, 1130, 1131, 1132, 1133, 1134, 1143, 1144, 1145, 1146, 1147, 1148, 1149, 1150, 1151, 1152, 1153, 1154, 1155, 1156, 1157, 1162, 1163, 1164, 1165, 1166, 1167, 1168, 1169, 1170, 1171, 1172, 1173, 1174, 1175, 1176, 1177, 1186, 1187, 1188, 1189, 1190, 1191, 1192, 1193, 1194, 1195, 1196, 1197, 1198, 1199, 1200, 1205, 1206, 1207, 1208, 1209, 1210, 1211, 1212, 1213, 1214, 1215, 1216, 1217, 1218, 1219, 1220, 1229, 1230, 1231, 1232, 1233, 1234, 1235, 1236, 1237, 1238, 1239, 1240, 1241, 1242, 1243, 1248, 1249, 1250, 1251, 1252, 1253, 1254, 1255, 1256, 1257, 1258, 1259, 1260, 1261, 1262, 1263, 1291, 1292, 1293, 1294, 1295, 1296, 1297, 1298, 1299, 1300, 1301, 1302, 1303, 1304, 1305, 1306];
    }
    
    override protected function addBackground():void {
      _bgTexture = AssetRegistry.Level6Atlas.getTexture("level06");
      _bg = new Image(_bgTexture);
      _bg.blendMode = BlendMode.NONE;
      _bg.smoothing = TextureSmoothing.NONE;
      _levelStage.addChild(_bg);
    }
 
    override protected function showObjective():void
    {     
      showObjectiveBox("Terror Triceratops has hidden 4 eggs especially well. Maybe they contain his heirs. Little Snake cannot afford to pass on these eggs.\n\nObjective:\nEat the 4 special eggs. If you have a problem getting into the tight spots, perform () to slow down time.", 40);
    }        
    
    override public function dispose():void {
      super.dispose();
    }
    
    override protected function addAboveSnake():void {
      var flowers:Image = new Image(AssetRegistry.Level6Atlas.getTexture("level06_flowers"));
      flowers.smoothing = TextureSmoothing.NONE;
      _levelStage.addChild(flowers);
    }
    override protected function addHud():void {
      _hud = new HUD(new Radar(_eggs, _snake), ["lifes", "time", "speed", "poison"],this);
      addChild(_hud);
      
    }
    override protected function updateHud():void {
      super.updateHud();
      _hud.speedText = String(_snake.mps);
      _hud.poisonText = String(_poisonEggs);   
    }
     
    override protected function addObstacles():void {
      var pos:Array = [0, 1, 2, 3, 4, 1030, 519, 520, 513, 514, 515, 1031, 512, 19, 20, 21, 552, 553, 43, 44, 45, 46, 47, 1073, 562, 563, 1074, 62, 63, 64, 595, 596, 86, 87, 88, 89, 90, 1116, 605, 606, 1117, 105, 106, 107, 113, 114, 115, 1140, 1141, 636, 637, 638, 639, 129, 130, 131, 132, 133, 1159, 648, 649, 643, 644, 1160, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 1183, 1184, 1179, 1180, 679, 680, 681, 682, 171, 172, 173, 174, 175, 176, 1202, 691, 692, 686, 687, 1203, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 1226, 1227, 1222, 1223, 722, 214, 215, 216, 217, 218, 219, 1245, 734, 735, 729, 730, 1246, 1265, 1266, 1269, 1270, 257, 258, 259, 260, 261, 262, 1288, 777, 778, 772, 773, 1289, 1308, 1309, 1312, 1313, 1314, 1315, 1316, 1317, 1318, 1319, 1320, 1321, 1322, 1323, 1324, 301, 302, 303, 304, 305, 1330, 1331, 820, 821, 1326, 1327, 1328, 1329, 1332, 812, 1325, 814, 815, 816, 811, 1351, 1352, 1355, 1356, 1357, 1358, 1359, 1360, 1361, 1362, 1363, 1364, 1365, 1366, 1367, 344, 345, 346, 347, 348, 1373, 1374, 863, 864, 1369, 1370, 1371, 1372, 341, 1375, 343, 1368, 858, 813, 342, 859, 300, 384, 385, 386, 387, 388, 389, 390, 391, 906, 907, 901, 902, 427, 428, 429, 430, 431, 432, 433, 434, 949, 950, 944, 945, 466, 467, 468, 469, 470, 471, 472, 987, 476, 477, 992, 993, 988, 509, 510, 511];
      for (var i:int = 0; i < pos.length; i++) {
        _obstacles[pos[i]] = true;
      }
    }
  }

}
