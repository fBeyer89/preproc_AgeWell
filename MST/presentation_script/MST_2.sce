# MST
# ----

active_buttons = 4;
button_codes = 1,2,3,4;
default_background_color = 255, 255, 255;
response_matching = simple_matching;

default_text_color = 0, 0, 0;


begin;
picture {} default;
picture {} Bi;


# Bilder
# ------

bitmap {filename = "Stimuli/001a.jpg";}P001_a;
bitmap {filename = "Stimuli/002a.jpg";}P002_a;
bitmap {filename = "Stimuli/003a.jpg";}P003_a;
bitmap {filename = "Stimuli/004a.jpg";}P004_a;
bitmap {filename = "Stimuli/005a.jpg";}P005_a;
bitmap {filename = "Stimuli/006a.jpg";}P006_a;
bitmap {filename = "Stimuli/007a.jpg";}P007_a;
bitmap {filename = "Stimuli/008a.jpg";}P008_a;
bitmap {filename = "Stimuli/009a.jpg";}P009_a;
bitmap {filename = "Stimuli/010a.jpg";}P010_a;
bitmap {filename = "Stimuli/011a.jpg";}P011_a;
bitmap {filename = "Stimuli/012a.jpg";}P012_a;
bitmap {filename = "Stimuli/013a.jpg";}P013_a;
bitmap {filename = "Stimuli/014a.jpg";}P014_a;
bitmap {filename = "Stimuli/015a.jpg";}P015_a;
bitmap {filename = "Stimuli/016a.jpg";}P016_a;
bitmap {filename = "Stimuli/017a.jpg";}P017_a;
bitmap {filename = "Stimuli/018a.jpg";}P018_a;
bitmap {filename = "Stimuli/019a.jpg";}P019_a;
bitmap {filename = "Stimuli/020a.jpg";}P020_a;
bitmap {filename = "Stimuli/021a.jpg";}P021_a;
bitmap {filename = "Stimuli/022a.jpg";}P022_a;
bitmap {filename = "Stimuli/023a.jpg";}P023_a;
bitmap {filename = "Stimuli/024a.jpg";}P024_a;
bitmap {filename = "Stimuli/025a.jpg";}P025_a;
bitmap {filename = "Stimuli/026a.jpg";}P026_a;
bitmap {filename = "Stimuli/027a.jpg";}P027_a;
bitmap {filename = "Stimuli/028a.jpg";}P028_a;
bitmap {filename = "Stimuli/029a.jpg";}P029_a;
bitmap {filename = "Stimuli/030a.jpg";}P030_a;
bitmap {filename = "Stimuli/031a.jpg";}P031_a;
bitmap {filename = "Stimuli/032a.jpg";}P032_a;
bitmap {filename = "Stimuli/033a.jpg";}P033_a;
bitmap {filename = "Stimuli/034a.jpg";}P034_a;
bitmap {filename = "Stimuli/035a.jpg";}P035_a;
bitmap {filename = "Stimuli/036a.jpg";}P036_a;
bitmap {filename = "Stimuli/037a.jpg";}P037_a;
bitmap {filename = "Stimuli/038a.jpg";}P038_a;
bitmap {filename = "Stimuli/039a.jpg";}P039_a;
bitmap {filename = "Stimuli/040a.jpg";}P040_a;
bitmap {filename = "Stimuli/041a.jpg";}P041_a;
bitmap {filename = "Stimuli/042a.jpg";}P042_a;
bitmap {filename = "Stimuli/043a.jpg";}P043_a;
bitmap {filename = "Stimuli/044a.jpg";}P044_a;
bitmap {filename = "Stimuli/045a.jpg";}P045_a;
bitmap {filename = "Stimuli/046a.jpg";}P046_a;
bitmap {filename = "Stimuli/047a.jpg";}P047_a;
bitmap {filename = "Stimuli/048a.jpg";}P048_a;
bitmap {filename = "Stimuli/049a.jpg";}P049_a;
bitmap {filename = "Stimuli/050a.jpg";}P050_a;
bitmap {filename = "Stimuli/051a.jpg";}P051_a;
bitmap {filename = "Stimuli/052a.jpg";}P052_a;
bitmap {filename = "Stimuli/053a.jpg";}P053_a;
bitmap {filename = "Stimuli/054a.jpg";}P054_a;
bitmap {filename = "Stimuli/055a.jpg";}P055_a;
bitmap {filename = "Stimuli/056a.jpg";}P056_a;
bitmap {filename = "Stimuli/057a.jpg";}P057_a;
bitmap {filename = "Stimuli/058a.jpg";}P058_a;
bitmap {filename = "Stimuli/059a.jpg";}P059_a;
bitmap {filename = "Stimuli/060a.jpg";}P060_a;
bitmap {filename = "Stimuli/061a.jpg";}P061_a;
bitmap {filename = "Stimuli/062a.jpg";}P062_a;
bitmap {filename = "Stimuli/063a.jpg";}P063_a;
bitmap {filename = "Stimuli/064a.jpg";}P064_a;
bitmap {filename = "Stimuli/065a.jpg";}P065_a;
bitmap {filename = "Stimuli/066a.jpg";}P066_a;
bitmap {filename = "Stimuli/067a.jpg";}P067_a;
bitmap {filename = "Stimuli/068a.jpg";}P068_a;
bitmap {filename = "Stimuli/069a.jpg";}P069_a;
bitmap {filename = "Stimuli/070a.jpg";}P070_a;
bitmap {filename = "Stimuli/071a.jpg";}P071_a;
bitmap {filename = "Stimuli/072a.jpg";}P072_a;
bitmap {filename = "Stimuli/073a.jpg";}P073_a;
bitmap {filename = "Stimuli/074a.jpg";}P074_a;
bitmap {filename = "Stimuli/075a.jpg";}P075_a;
bitmap {filename = "Stimuli/076a.jpg";}P076_a;
bitmap {filename = "Stimuli/077a.jpg";}P077_a;
bitmap {filename = "Stimuli/078a.jpg";}P078_a;
bitmap {filename = "Stimuli/079a.jpg";}P079_a;
bitmap {filename = "Stimuli/080a.jpg";}P080_a;
bitmap {filename = "Stimuli/081a.jpg";}P081_a;
bitmap {filename = "Stimuli/082a.jpg";}P082_a;
bitmap {filename = "Stimuli/083a.jpg";}P083_a;
bitmap {filename = "Stimuli/084a.jpg";}P084_a;
bitmap {filename = "Stimuli/085a.jpg";}P085_a;
bitmap {filename = "Stimuli/086a.jpg";}P086_a;
bitmap {filename = "Stimuli/087a.jpg";}P087_a;
bitmap {filename = "Stimuli/088a.jpg";}P088_a;
bitmap {filename = "Stimuli/089a.jpg";}P089_a;
bitmap {filename = "Stimuli/090a.jpg";}P090_a;
bitmap {filename = "Stimuli/091a.jpg";}P091_a;
bitmap {filename = "Stimuli/092a.jpg";}P092_a;
bitmap {filename = "Stimuli/093a.jpg";}P093_a;
bitmap {filename = "Stimuli/094a.jpg";}P094_a;
bitmap {filename = "Stimuli/095a.jpg";}P095_a;
bitmap {filename = "Stimuli/096a.jpg";}P096_a;
bitmap {filename = "Stimuli/097a.jpg";}P097_a;
bitmap {filename = "Stimuli/098a.jpg";}P098_a;
bitmap {filename = "Stimuli/099a.jpg";}P099_a;
bitmap {filename = "Stimuli/100a.jpg";}P100_a;
bitmap {filename = "Stimuli/101a.jpg";}P101_a;
bitmap {filename = "Stimuli/102a.jpg";}P102_a;
bitmap {filename = "Stimuli/103a.jpg";}P103_a;
bitmap {filename = "Stimuli/104a.jpg";}P104_a;
bitmap {filename = "Stimuli/105a.jpg";}P105_a;
bitmap {filename = "Stimuli/106a.jpg";}P106_a;
bitmap {filename = "Stimuli/107a.jpg";}P107_a;
bitmap {filename = "Stimuli/108a.jpg";}P108_a;
bitmap {filename = "Stimuli/109a.jpg";}P109_a;
bitmap {filename = "Stimuli/110a.jpg";}P110_a;
bitmap {filename = "Stimuli/111a.jpg";}P111_a;
bitmap {filename = "Stimuli/112a.jpg";}P112_a;
bitmap {filename = "Stimuli/113a.jpg";}P113_a;
bitmap {filename = "Stimuli/114a.jpg";}P114_a;
bitmap {filename = "Stimuli/115a.jpg";}P115_a;
bitmap {filename = "Stimuli/116a.jpg";}P116_a;
bitmap {filename = "Stimuli/117a.jpg";}P117_a;
bitmap {filename = "Stimuli/118a.jpg";}P118_a;
bitmap {filename = "Stimuli/119a.jpg";}P119_a;
bitmap {filename = "Stimuli/120a.jpg";}P120_a;
bitmap {filename = "Stimuli/121a.jpg";}P121_a;
bitmap {filename = "Stimuli/122a.jpg";}P122_a;
bitmap {filename = "Stimuli/123a.jpg";}P123_a;
bitmap {filename = "Stimuli/124a.jpg";}P124_a;
bitmap {filename = "Stimuli/125a.jpg";}P125_a;
bitmap {filename = "Stimuli/126a.jpg";}P126_a;
bitmap {filename = "Stimuli/127a.jpg";}P127_a;
bitmap {filename = "Stimuli/128a.jpg";}P128_a;
bitmap {filename = "Stimuli/129a.jpg";}P129_a;
bitmap {filename = "Stimuli/130a.jpg";}P130_a;
bitmap {filename = "Stimuli/131a.jpg";}P131_a;
bitmap {filename = "Stimuli/132a.jpg";}P132_a;
bitmap {filename = "Stimuli/133a.jpg";}P133_a;
bitmap {filename = "Stimuli/134a.jpg";}P134_a;
bitmap {filename = "Stimuli/135a.jpg";}P135_a;
bitmap {filename = "Stimuli/136a.jpg";}P136_a;
bitmap {filename = "Stimuli/137a.jpg";}P137_a;
bitmap {filename = "Stimuli/138a.jpg";}P138_a;
bitmap {filename = "Stimuli/139a.jpg";}P139_a;
bitmap {filename = "Stimuli/140a.jpg";}P140_a;
bitmap {filename = "Stimuli/141a.jpg";}P141_a;
bitmap {filename = "Stimuli/142a.jpg";}P142_a;
bitmap {filename = "Stimuli/143a.jpg";}P143_a;
bitmap {filename = "Stimuli/144a.jpg";}P144_a;
bitmap {filename = "Stimuli/145a.jpg";}P145_a;
bitmap {filename = "Stimuli/146a.jpg";}P146_a;
bitmap {filename = "Stimuli/147a.jpg";}P147_a;
bitmap {filename = "Stimuli/148a.jpg";}P148_a;
bitmap {filename = "Stimuli/149a.jpg";}P149_a;
bitmap {filename = "Stimuli/150a.jpg";}P150_a;
bitmap {filename = "Stimuli/151a.jpg";}P151_a;
bitmap {filename = "Stimuli/152a.jpg";}P152_a;
bitmap {filename = "Stimuli/153a.jpg";}P153_a;
bitmap {filename = "Stimuli/154a.jpg";}P154_a;
bitmap {filename = "Stimuli/155a.jpg";}P155_a;
bitmap {filename = "Stimuli/156a.jpg";}P156_a;
bitmap {filename = "Stimuli/157a.jpg";}P157_a;
bitmap {filename = "Stimuli/158a.jpg";}P158_a;
bitmap {filename = "Stimuli/159a.jpg";}P159_a;
bitmap {filename = "Stimuli/160a.jpg";}P160_a;
bitmap {filename = "Stimuli/161a.jpg";}P161_a;
bitmap {filename = "Stimuli/162a.jpg";}P162_a;
bitmap {filename = "Stimuli/163a.jpg";}P163_a;
bitmap {filename = "Stimuli/164a.jpg";}P164_a;
bitmap {filename = "Stimuli/165a.jpg";}P165_a;
bitmap {filename = "Stimuli/166a.jpg";}P166_a;
bitmap {filename = "Stimuli/167a.jpg";}P167_a;
bitmap {filename = "Stimuli/168a.jpg";}P168_a;
bitmap {filename = "Stimuli/169a.jpg";}P169_a;
bitmap {filename = "Stimuli/170a.jpg";}P170_a;
bitmap {filename = "Stimuli/171a.jpg";}P171_a;
bitmap {filename = "Stimuli/172a.jpg";}P172_a;
bitmap {filename = "Stimuli/173a.jpg";}P173_a;
bitmap {filename = "Stimuli/174a.jpg";}P174_a;
bitmap {filename = "Stimuli/175a.jpg";}P175_a;
bitmap {filename = "Stimuli/176a.jpg";}P176_a;
bitmap {filename = "Stimuli/177a.jpg";}P177_a;
bitmap {filename = "Stimuli/178a.jpg";}P178_a;
bitmap {filename = "Stimuli/179a.jpg";}P179_a;
bitmap {filename = "Stimuli/180a.jpg";}P180_a;
bitmap {filename = "Stimuli/181a.jpg";}P181_a;
bitmap {filename = "Stimuli/182a.jpg";}P182_a;
bitmap {filename = "Stimuli/183a.jpg";}P183_a;
bitmap {filename = "Stimuli/184a.jpg";}P184_a;
bitmap {filename = "Stimuli/185a.jpg";}P185_a;
bitmap {filename = "Stimuli/186a.jpg";}P186_a;
bitmap {filename = "Stimuli/187a.jpg";}P187_a;
bitmap {filename = "Stimuli/188a.jpg";}P188_a;
bitmap {filename = "Stimuli/189a.jpg";}P189_a;
bitmap {filename = "Stimuli/190a.jpg";}P190_a;
bitmap {filename = "Stimuli/191a.jpg";}P191_a;
bitmap {filename = "Stimuli/192a.jpg";}P192_a;

bitmap {filename = "Stimuli/001b.jpg";}P001_b;
bitmap {filename = "Stimuli/002b.jpg";}P002_b;
bitmap {filename = "Stimuli/003b.jpg";}P003_b;
bitmap {filename = "Stimuli/004b.jpg";}P004_b;
bitmap {filename = "Stimuli/005b.jpg";}P005_b;
bitmap {filename = "Stimuli/006b.jpg";}P006_b;
bitmap {filename = "Stimuli/007b.jpg";}P007_b;
bitmap {filename = "Stimuli/008b.jpg";}P008_b;
bitmap {filename = "Stimuli/009b.jpg";}P009_b;
bitmap {filename = "Stimuli/010b.jpg";}P010_b;
bitmap {filename = "Stimuli/011b.jpg";}P011_b;
bitmap {filename = "Stimuli/012b.jpg";}P012_b;
bitmap {filename = "Stimuli/013b.jpg";}P013_b;
bitmap {filename = "Stimuli/014b.jpg";}P014_b;
bitmap {filename = "Stimuli/015b.jpg";}P015_b;
bitmap {filename = "Stimuli/016b.jpg";}P016_b;
bitmap {filename = "Stimuli/017b.jpg";}P017_b;
bitmap {filename = "Stimuli/018b.jpg";}P018_b;
bitmap {filename = "Stimuli/019b.jpg";}P019_b;
bitmap {filename = "Stimuli/020b.jpg";}P020_b;
bitmap {filename = "Stimuli/021b.jpg";}P021_b;
bitmap {filename = "Stimuli/022b.jpg";}P022_b;
bitmap {filename = "Stimuli/023b.jpg";}P023_b;
bitmap {filename = "Stimuli/024b.jpg";}P024_b;
bitmap {filename = "Stimuli/025b.jpg";}P025_b;
bitmap {filename = "Stimuli/026b.jpg";}P026_b;
bitmap {filename = "Stimuli/027b.jpg";}P027_b;
bitmap {filename = "Stimuli/028b.jpg";}P028_b;
bitmap {filename = "Stimuli/029b.jpg";}P029_b;
bitmap {filename = "Stimuli/030b.jpg";}P030_b;
bitmap {filename = "Stimuli/031b.jpg";}P031_b;
bitmap {filename = "Stimuli/032b.jpg";}P032_b;
bitmap {filename = "Stimuli/033b.jpg";}P033_b;
bitmap {filename = "Stimuli/034b.jpg";}P034_b;
bitmap {filename = "Stimuli/035b.jpg";}P035_b;
bitmap {filename = "Stimuli/036b.jpg";}P036_b;
bitmap {filename = "Stimuli/037b.jpg";}P037_b;
bitmap {filename = "Stimuli/038b.jpg";}P038_b;
bitmap {filename = "Stimuli/039b.jpg";}P039_b;
bitmap {filename = "Stimuli/040b.jpg";}P040_b;
bitmap {filename = "Stimuli/041b.jpg";}P041_b;
bitmap {filename = "Stimuli/042b.jpg";}P042_b;
bitmap {filename = "Stimuli/043b.jpg";}P043_b;
bitmap {filename = "Stimuli/044b.jpg";}P044_b;
bitmap {filename = "Stimuli/045b.jpg";}P045_b;
bitmap {filename = "Stimuli/046b.jpg";}P046_b;
bitmap {filename = "Stimuli/047b.jpg";}P047_b;
bitmap {filename = "Stimuli/048b.jpg";}P048_b;
bitmap {filename = "Stimuli/049b.jpg";}P049_b;
bitmap {filename = "Stimuli/050b.jpg";}P050_b;
bitmap {filename = "Stimuli/051b.jpg";}P051_b;
bitmap {filename = "Stimuli/052b.jpg";}P052_b;
bitmap {filename = "Stimuli/053b.jpg";}P053_b;
bitmap {filename = "Stimuli/054b.jpg";}P054_b;
bitmap {filename = "Stimuli/055b.jpg";}P055_b;
bitmap {filename = "Stimuli/056b.jpg";}P056_b;
bitmap {filename = "Stimuli/057b.jpg";}P057_b;
bitmap {filename = "Stimuli/058b.jpg";}P058_b;
bitmap {filename = "Stimuli/059b.jpg";}P059_b;
bitmap {filename = "Stimuli/060b.jpg";}P060_b;
bitmap {filename = "Stimuli/061b.jpg";}P061_b;
bitmap {filename = "Stimuli/062b.jpg";}P062_b;
bitmap {filename = "Stimuli/063b.jpg";}P063_b;
bitmap {filename = "Stimuli/064b.jpg";}P064_b;
bitmap {filename = "Stimuli/065b.jpg";}P065_b;
bitmap {filename = "Stimuli/066b.jpg";}P066_b;
bitmap {filename = "Stimuli/067b.jpg";}P067_b;
bitmap {filename = "Stimuli/068b.jpg";}P068_b;
bitmap {filename = "Stimuli/069b.jpg";}P069_b;
bitmap {filename = "Stimuli/070b.jpg";}P070_b;
bitmap {filename = "Stimuli/071b.jpg";}P071_b;
bitmap {filename = "Stimuli/072b.jpg";}P072_b;
bitmap {filename = "Stimuli/073b.jpg";}P073_b;
bitmap {filename = "Stimuli/074b.jpg";}P074_b;
bitmap {filename = "Stimuli/075b.jpg";}P075_b;
bitmap {filename = "Stimuli/076b.jpg";}P076_b;
bitmap {filename = "Stimuli/077b.jpg";}P077_b;
bitmap {filename = "Stimuli/078b.jpg";}P078_b;
bitmap {filename = "Stimuli/079b.jpg";}P079_b;
bitmap {filename = "Stimuli/080b.jpg";}P080_b;
bitmap {filename = "Stimuli/081b.jpg";}P081_b;
bitmap {filename = "Stimuli/082b.jpg";}P082_b;
bitmap {filename = "Stimuli/083b.jpg";}P083_b;
bitmap {filename = "Stimuli/084b.jpg";}P084_b;
bitmap {filename = "Stimuli/085b.jpg";}P085_b;
bitmap {filename = "Stimuli/086b.jpg";}P086_b;
bitmap {filename = "Stimuli/087b.jpg";}P087_b;
bitmap {filename = "Stimuli/088b.jpg";}P088_b;
bitmap {filename = "Stimuli/089b.jpg";}P089_b;
bitmap {filename = "Stimuli/090b.jpg";}P090_b;
bitmap {filename = "Stimuli/091b.jpg";}P091_b;
bitmap {filename = "Stimuli/092b.jpg";}P092_b;
bitmap {filename = "Stimuli/093b.jpg";}P093_b;
bitmap {filename = "Stimuli/094b.jpg";}P094_b;
bitmap {filename = "Stimuli/095b.jpg";}P095_b;
bitmap {filename = "Stimuli/096b.jpg";}P096_b;
bitmap {filename = "Stimuli/097b.jpg";}P097_b;
bitmap {filename = "Stimuli/098b.jpg";}P098_b;
bitmap {filename = "Stimuli/099b.jpg";}P099_b;
bitmap {filename = "Stimuli/100b.jpg";}P100_b;
bitmap {filename = "Stimuli/101b.jpg";}P101_b;
bitmap {filename = "Stimuli/102b.jpg";}P102_b;
bitmap {filename = "Stimuli/103b.jpg";}P103_b;
bitmap {filename = "Stimuli/104b.jpg";}P104_b;
bitmap {filename = "Stimuli/105b.jpg";}P105_b;
bitmap {filename = "Stimuli/106b.jpg";}P106_b;
bitmap {filename = "Stimuli/107b.jpg";}P107_b;
bitmap {filename = "Stimuli/108b.jpg";}P108_b;
bitmap {filename = "Stimuli/109b.jpg";}P109_b;
bitmap {filename = "Stimuli/110b.jpg";}P110_b;
bitmap {filename = "Stimuli/111b.jpg";}P111_b;
bitmap {filename = "Stimuli/112b.jpg";}P112_b;
bitmap {filename = "Stimuli/113b.jpg";}P113_b;
bitmap {filename = "Stimuli/114b.jpg";}P114_b;
bitmap {filename = "Stimuli/115b.jpg";}P115_b;
bitmap {filename = "Stimuli/116b.jpg";}P116_b;
bitmap {filename = "Stimuli/117b.jpg";}P117_b;
bitmap {filename = "Stimuli/118b.jpg";}P118_b;
bitmap {filename = "Stimuli/119b.jpg";}P119_b;
bitmap {filename = "Stimuli/120b.jpg";}P120_b;
bitmap {filename = "Stimuli/121b.jpg";}P121_b;
bitmap {filename = "Stimuli/122b.jpg";}P122_b;
bitmap {filename = "Stimuli/123b.jpg";}P123_b;
bitmap {filename = "Stimuli/124b.jpg";}P124_b;
bitmap {filename = "Stimuli/125b.jpg";}P125_b;
bitmap {filename = "Stimuli/126b.jpg";}P126_b;
bitmap {filename = "Stimuli/127b.jpg";}P127_b;
bitmap {filename = "Stimuli/128b.jpg";}P128_b;
bitmap {filename = "Stimuli/129b.jpg";}P129_b;
bitmap {filename = "Stimuli/130b.jpg";}P130_b;
bitmap {filename = "Stimuli/131b.jpg";}P131_b;
bitmap {filename = "Stimuli/132b.jpg";}P132_b;
bitmap {filename = "Stimuli/133b.jpg";}P133_b;
bitmap {filename = "Stimuli/134b.jpg";}P134_b;
bitmap {filename = "Stimuli/135b.jpg";}P135_b;
bitmap {filename = "Stimuli/136b.jpg";}P136_b;
bitmap {filename = "Stimuli/137b.jpg";}P137_b;
bitmap {filename = "Stimuli/138b.jpg";}P138_b;
bitmap {filename = "Stimuli/139b.jpg";}P139_b;
bitmap {filename = "Stimuli/140b.jpg";}P140_b;
bitmap {filename = "Stimuli/141b.jpg";}P141_b;
bitmap {filename = "Stimuli/142b.jpg";}P142_b;
bitmap {filename = "Stimuli/143b.jpg";}P143_b;
bitmap {filename = "Stimuli/144b.jpg";}P144_b;
bitmap {filename = "Stimuli/145b.jpg";}P145_b;
bitmap {filename = "Stimuli/146b.jpg";}P146_b;
bitmap {filename = "Stimuli/147b.jpg";}P147_b;
bitmap {filename = "Stimuli/148b.jpg";}P148_b;
bitmap {filename = "Stimuli/149b.jpg";}P149_b;
bitmap {filename = "Stimuli/150b.jpg";}P150_b;
bitmap {filename = "Stimuli/151b.jpg";}P151_b;
bitmap {filename = "Stimuli/152b.jpg";}P152_b;
bitmap {filename = "Stimuli/153b.jpg";}P153_b;
bitmap {filename = "Stimuli/154b.jpg";}P154_b;
bitmap {filename = "Stimuli/155b.jpg";}P155_b;
bitmap {filename = "Stimuli/156b.jpg";}P156_b;
bitmap {filename = "Stimuli/157b.jpg";}P157_b;
bitmap {filename = "Stimuli/158b.jpg";}P158_b;
bitmap {filename = "Stimuli/159b.jpg";}P159_b;
bitmap {filename = "Stimuli/160b.jpg";}P160_b;
bitmap {filename = "Stimuli/161b.jpg";}P161_b;
bitmap {filename = "Stimuli/162b.jpg";}P162_b;
bitmap {filename = "Stimuli/163b.jpg";}P163_b;
bitmap {filename = "Stimuli/164b.jpg";}P164_b;
bitmap {filename = "Stimuli/165b.jpg";}P165_b;
bitmap {filename = "Stimuli/166b.jpg";}P166_b;
bitmap {filename = "Stimuli/167b.jpg";}P167_b;
bitmap {filename = "Stimuli/168b.jpg";}P168_b;
bitmap {filename = "Stimuli/169b.jpg";}P169_b;
bitmap {filename = "Stimuli/170b.jpg";}P170_b;
bitmap {filename = "Stimuli/171b.jpg";}P171_b;
bitmap {filename = "Stimuli/172b.jpg";}P172_b;
bitmap {filename = "Stimuli/173b.jpg";}P173_b;
bitmap {filename = "Stimuli/174b.jpg";}P174_b;
bitmap {filename = "Stimuli/175b.jpg";}P175_b;
bitmap {filename = "Stimuli/176b.jpg";}P176_b;
bitmap {filename = "Stimuli/177b.jpg";}P177_b;
bitmap {filename = "Stimuli/178b.jpg";}P178_b;
bitmap {filename = "Stimuli/179b.jpg";}P179_b;
bitmap {filename = "Stimuli/180b.jpg";}P180_b;
bitmap {filename = "Stimuli/181b.jpg";}P181_b;
bitmap {filename = "Stimuli/182b.jpg";}P182_b;
bitmap {filename = "Stimuli/183b.jpg";}P183_b;
bitmap {filename = "Stimuli/184b.jpg";}P184_b;
bitmap {filename = "Stimuli/185b.jpg";}P185_b;
bitmap {filename = "Stimuli/186b.jpg";}P186_b;
bitmap {filename = "Stimuli/187b.jpg";}P187_b;
bitmap {filename = "Stimuli/188b.jpg";}P188_b;
bitmap {filename = "Stimuli/189b.jpg";}P189_b;
bitmap {filename = "Stimuli/190b.jpg";}P190_b;
bitmap {filename = "Stimuli/191b.jpg";}P191_b;
bitmap {filename = "Stimuli/192b.jpg";}P192_b;


# Instruktion und Beispiele Teil 1
# --------------------------------

array{
 bitmap {filename = "Instr/MST_anw_T1_001.jpeg"; description = "T1_1";}skala_Start;
 bitmap {filename = "Instr/MST_anw_T1_002.jpeg"; description = "T1_2";};
 bitmap {filename = "Instr/MST_anw_T1_003.jpeg"; description = "T1_3";};
 bitmap {filename = "Instr/MST_anw_T1_004.jpeg"; description = "T1_4";};
 bitmap {filename = "Instr/MST_anw_T1_005.jpeg"; description = "T1_5";};
 bitmap {filename = "Instr/MST_anw_T1_007.jpeg"; description = "T1_7";};
 bitmap {filename = "Instr/MST_anw_T1_008.jpeg"; description = "T1_8";};
 bitmap {filename = "Instr/MST_anw_T1_010.jpeg"; description = "T1_10";};
 bitmap {filename = "Instr/MST_anw_T1_011.jpeg"; description = "T1_11";};
 bitmap {filename = "Instr/MST_anw_T1_013.jpeg"; description = "T1_13";};
 bitmap {filename = "Instr/MST_anw_T1_014.jpeg"; description = "T1_14";};
 bitmap {filename = "Instr/MST_anw_T1_016.jpeg"; description = "T1_16";};
 bitmap {filename = "Instr/MST_anw_T1_017.jpeg"; description = "T1_17";};
 bitmap {filename = "Instr/MST_anw_T1_018.jpeg"; description = "T1_18";};
}Instr_T1;


# Instruktion und Beispiele Teil 2
# --------------------------------

array{
 bitmap {filename = "Instr/MST_anw_T2_020.jpeg"; description = "T2_20";};
 bitmap {filename = "Instr/MST_anw_T2_021.jpeg"; description = "T2_21";};
 bitmap {filename = "Instr/MST_anw_T2_022.jpeg"; description = "T2_22";};
 bitmap {filename = "Instr/MST_anw_T2_023.jpeg"; description = "T2_23";};
 bitmap {filename = "Instr/MST_anw_T2_024.jpeg"; description = "T2_24";};
 bitmap {filename = "Instr/MST_anw_T2_025.jpeg"; description = "T2_25";};
 bitmap {filename = "Instr/MST_anw_T2_027.jpeg"; description = "T2_27";};
 bitmap {filename = "Instr/MST_anw_T2_028.jpeg"; description = "T2_28";};
 bitmap {filename = "Instr/MST_anw_T2_030.jpeg"; description = "T2_30";};
 bitmap {filename = "Instr/MST_anw_T2_031.jpeg"; description = "T2_31";};
 bitmap {filename = "Instr/MST_anw_T2_033.jpeg"; description = "T2_33";};
 bitmap {filename = "Instr/MST_anw_T2_034.jpeg"; description = "T2_34";};
 bitmap {filename = "Instr/MST_anw_T2_036.jpeg"; description = "T2_36";};
 bitmap {filename = "Instr/MST_anw_T2_038.jpeg"; description = "T2_38";};
 bitmap {filename = "Instr/MST_anw_T2_039.jpeg"; description = "T2_39";};
 bitmap {filename = "Instr/MST_anw_T2_041.jpeg"; description = "T2_41";};
 bitmap {filename = "Instr/MST_anw_T2_042.jpeg"; description = "T2_42";};
 bitmap {filename = "Instr/MST_anw_T2_044.jpeg"; description = "T2_44";};
 bitmap {filename = "Instr/MST_anw_T2_045.jpeg"; description = "T2_45";};
 bitmap {filename = "Instr/MST_anw_T2_046.jpeg"; description = "T2_46";};
 bitmap {filename = "Instr/MST_anw_T2_048.jpeg"; description = "T2_48";};
 bitmap {filename = "Instr/MST_anw_T2_049.jpeg"; description = "T2_49";};
 bitmap {filename = "Instr/MST_anw_T2_051.jpeg"; description = "T2_51";};
 bitmap {filename = "Instr/MST_anw_T2_052.jpeg"; description = "T2_52";};
 bitmap {filename = "Instr/MST_anw_T2_054.jpeg"; description = "T2_54";};
 bitmap {filename = "Instr/MST_anw_T2_055.jpeg"; description = "T2_55";};
 bitmap {filename = "Instr/MST_anw_T2_056.jpeg"; description = "T2_56";};
 bitmap {filename = "Instr/MST_anw_T2_058.jpeg"; description = "T2_58";};
}Instr_T2;


# Trials
# ------

trial{

 trial_duration = forever;
 trial_type = specific_response;
 terminator_button = 4;
 
 stimulus_event{

  picture {bitmap skala_Start;
  x = 0; y = 0;};
  time = 0;
  code = "Instr";
  duration = next_picture;
	
 }Instr_event;
}Instr_trial;


trial{

 trial_duration = 2500;
 
 stimulus_event{

  picture {bitmap P001_a;
  x = 0; y = 0;};
  time = 0;
  code = "Bild";
  duration = next_picture;
	
 }Stim_event_1;

 picture default;
 time = 2000;
 duration = next_picture;

}Stim_trial_1;


trial{

 trial_type = fixed;
 trial_duration = 2500;
 
 stimulus_event{

  picture {bitmap P001_a;
  x = 0; y = 0;};
  time = 0;
  code = "Bild";
  duration = next_picture;
  response_active = true; 
 	
 }Stim_event_2;

 picture default;
 time = 2000;
 duration = next_picture;

}Stim_trial_2;


trial{

 trial_duration = 42;

 stimulus_event{

  picture default;
  time = 0; 
  duration = next_picture;
  code = "";

 }stim_Ausg_rando;
}trial_Ausg_rando;


trial{

 trial_duration = 42;

 picture default;
 time = 0; 
 duration = next_picture;
 code = "FB_cor";

}trial_FB_cor;


trial{

 trial_duration = 42;

 picture default;
 time = 0; 
 duration = next_picture;
 code = "FB_inco";

}trial_FB_inco;


trial{

 trial_duration = 42;

 picture default;
 time = 0; 
 duration = next_picture;
 code = "FB_miss";

}trial_FB_miss;


trial{

 trial_duration = 3000;

 stimulus_event{

  picture{
   text{
    caption = "<b>E N D E  - V I E L E N  D A N K !</b>";
    formatted_text = true;
    font_size = 40;};
   x = 0; y = 0;
   };
 
  time = 0;
  code = "Ende";
  duration = next_picture;
 
 }stim_ausgabe;

}ende;


################################################################


begin_pcl;

int i;
int teil;
int trl_anz;
int cor_taste;
int first_resp;

int Anz_cor;
int Anz_inco;
int Anz_miss;

double Pro_cor_d;
int Pro_cor_i;

array <string> Bild_T1[128];
array <string> Art_T1[128];
string Datei1;

array <string> Bild_T2[192];
array <string> Art_T2[192];
string Datei2;

array <bitmap> Pi[1];
string Bild; 


# Aufforderung zur Eingabe der Dateinummer (1-5)
# ----------------------------------------------

preset string nr;
Datei1 = "Dateien/MST_rando_T1_"+nr+".txt";
Datei2 = "Dateien/MST_rando_T2_"+nr+".txt";


# Auslesen der erforderlichen Parameter
# -------------------------------------

# Picture-Datei oeffnen

input_file pic1 = new input_file;
pic1.open(Datei1);

input_file pic2 = new input_file;
pic2.open(Datei2);


# Auslesen der Werte aus der Picture-Datei - Teil 1

loop
 i = 1
until
 i > 128
begin
 
 Bild_T1[i] = pic1.get_string();
 Art_T1[i]  = pic1.get_string();
 i = i + 1;

end;


# Auslesen der Werte aus der Picture-Datei - Teil 2

loop
 i = 1
until
 i > 192
begin
 
 Bild_T2[i] = pic2.get_string();
 Art_T2[i]  = pic2.get_string();
 i = i + 1;

end;


# Programmstart
# -------------

# Ausgabe der gewaehlten Randonummer ins Logfile

stim_Ausg_rando.set_event_code("Randonummer_"+nr);
trial_Ausg_rando.present();


loop
 teil = 1
until
 teil > 2
begin


 if (teil == 1) then

	
  # Instruktion und Beispiel Teil 1
  # -------------------------------

  loop
   i = 1
  until
   i > 14
  begin
 
   Bi.clear();
   Bi.add_part(Instr_T1[i], 0, 0);

   Instr_event.set_stimulus(Bi);
   Instr_event.set_event_code("Instr_"+Instr_T1[i].description());
   Instr_trial.present();

   if ((i == 1) || (i == 2) || (i == 4) || (i == 5) || (i == 7)
    || (i == 9) || (i == 11) || (i == 13)) then
    default.present(); 
    wait_interval(500);
   end;
 
  i = i + 1;

  end;

 elseif (teil == 2) then
	
	
  # Instruktion und Beispiel Teil 2
  # -------------------------------

  loop
   i = 1
  until
   i > 28
  begin
 
   Bi.clear();
   Bi.add_part(Instr_T2[i], 0, 0);

   Instr_event.set_stimulus(Bi);
   Instr_event.set_event_code("Instr_"+Instr_T2[i].description());
   Instr_trial.present();

   if ((i == 1) || (i == 2) || (i == 3) || (i == 4) || (i == 6)
    || (i == 8) || (i == 10) || (i == 12) || (i == 13) || (i == 15)
    || (i == 17) || (i == 20) || (i == 22) || (i == 24) || (i == 27)) then
    default.present(); 
    wait_interval(500);
   end;
 
  i = i + 1;

  end;

 end;                             # Ende Instruktion


 default.present();
 wait_interval(1000);


 if     (teil == 1) then trl_anz = 128
 elseif (teil == 2) then trl_anz = 192;
 end;


 # Anfangswerte setzen
  
 Anz_cor = 0;
 Anz_inco = 0;
 Anz_miss = 0;
 Pro_cor_d = 0.0;
 Pro_cor_i = 0;


 loop
  i = 1
 until
  i > trl_anz
 begin

  if     (teil == 1) then Bild = Bild_T1[i];
  elseif (teil == 2) then Bild = Bild_T2[i];
  end;


  # Zuordnung des entsprechenden Stimulationsbildes
  # -----------------------------------------------

  if     (Bild == "001a") then Pi[1] = P001_a;
  elseif (Bild == "002a") then Pi[1] = P002_a;
  elseif (Bild == "003a") then Pi[1] = P003_a;
  elseif (Bild == "004a") then Pi[1] = P004_a;
  elseif (Bild == "005a") then Pi[1] = P005_a;
  elseif (Bild == "006a") then Pi[1] = P006_a;
  elseif (Bild == "007a") then Pi[1] = P007_a;
  elseif (Bild == "008a") then Pi[1] = P008_a;
  elseif (Bild == "009a") then Pi[1] = P009_a;
  elseif (Bild == "010a") then Pi[1] = P010_a;
  elseif (Bild == "011a") then Pi[1] = P011_a;
  elseif (Bild == "012a") then Pi[1] = P012_a;
  elseif (Bild == "013a") then Pi[1] = P013_a;
  elseif (Bild == "014a") then Pi[1] = P014_a;
  elseif (Bild == "015a") then Pi[1] = P015_a;
  elseif (Bild == "016a") then Pi[1] = P016_a;
  elseif (Bild == "017a") then Pi[1] = P017_a;
  elseif (Bild == "018a") then Pi[1] = P018_a;
  elseif (Bild == "019a") then Pi[1] = P019_a;
  elseif (Bild == "020a") then Pi[1] = P020_a;
  elseif (Bild == "021a") then Pi[1] = P021_a;
  elseif (Bild == "022a") then Pi[1] = P022_a;
  elseif (Bild == "023a") then Pi[1] = P023_a;
  elseif (Bild == "024a") then Pi[1] = P024_a;
  elseif (Bild == "025a") then Pi[1] = P025_a;
  elseif (Bild == "026a") then Pi[1] = P026_a;
  elseif (Bild == "027a") then Pi[1] = P027_a;
  elseif (Bild == "028a") then Pi[1] = P028_a;
  elseif (Bild == "029a") then Pi[1] = P029_a;
  elseif (Bild == "030a") then Pi[1] = P030_a;
  elseif (Bild == "031a") then Pi[1] = P031_a;
  elseif (Bild == "032a") then Pi[1] = P032_a;
  elseif (Bild == "033a") then Pi[1] = P033_a;
  elseif (Bild == "034a") then Pi[1] = P034_a;
  elseif (Bild == "035a") then Pi[1] = P035_a;
  elseif (Bild == "036a") then Pi[1] = P036_a;
  elseif (Bild == "037a") then Pi[1] = P037_a;
  elseif (Bild == "038a") then Pi[1] = P038_a;
  elseif (Bild == "039a") then Pi[1] = P039_a;
  elseif (Bild == "040a") then Pi[1] = P040_a;
  elseif (Bild == "041a") then Pi[1] = P041_a;
  elseif (Bild == "042a") then Pi[1] = P042_a;
  elseif (Bild == "043a") then Pi[1] = P043_a;
  elseif (Bild == "044a") then Pi[1] = P044_a;
  elseif (Bild == "045a") then Pi[1] = P045_a;
  elseif (Bild == "046a") then Pi[1] = P046_a;
  elseif (Bild == "047a") then Pi[1] = P047_a;
  elseif (Bild == "048a") then Pi[1] = P048_a;
  elseif (Bild == "049a") then Pi[1] = P049_a;
  elseif (Bild == "050a") then Pi[1] = P050_a;
  elseif (Bild == "051a") then Pi[1] = P051_a;
  elseif (Bild == "052a") then Pi[1] = P052_a;
  elseif (Bild == "053a") then Pi[1] = P053_a;
  elseif (Bild == "054a") then Pi[1] = P054_a;
  elseif (Bild == "055a") then Pi[1] = P055_a;
  elseif (Bild == "056a") then Pi[1] = P056_a;
  elseif (Bild == "057a") then Pi[1] = P057_a;
  elseif (Bild == "058a") then Pi[1] = P058_a;
  elseif (Bild == "059a") then Pi[1] = P059_a;
  elseif (Bild == "060a") then Pi[1] = P060_a;
  elseif (Bild == "061a") then Pi[1] = P061_a;
  elseif (Bild == "062a") then Pi[1] = P062_a;
  elseif (Bild == "063a") then Pi[1] = P063_a;
  elseif (Bild == "064a") then Pi[1] = P064_a;
  elseif (Bild == "065a") then Pi[1] = P065_a;
  elseif (Bild == "066a") then Pi[1] = P066_a;
  elseif (Bild == "067a") then Pi[1] = P067_a;
  elseif (Bild == "068a") then Pi[1] = P068_a;
  elseif (Bild == "069a") then Pi[1] = P069_a;
  elseif (Bild == "070a") then Pi[1] = P070_a;
  elseif (Bild == "071a") then Pi[1] = P071_a;
  elseif (Bild == "072a") then Pi[1] = P072_a;
  elseif (Bild == "073a") then Pi[1] = P073_a;
  elseif (Bild == "074a") then Pi[1] = P074_a;
  elseif (Bild == "075a") then Pi[1] = P075_a;
  elseif (Bild == "076a") then Pi[1] = P076_a;
  elseif (Bild == "077a") then Pi[1] = P077_a;
  elseif (Bild == "078a") then Pi[1] = P078_a;
  elseif (Bild == "079a") then Pi[1] = P079_a;
  elseif (Bild == "080a") then Pi[1] = P080_a;
  elseif (Bild == "081a") then Pi[1] = P081_a;
  elseif (Bild == "082a") then Pi[1] = P082_a;
  elseif (Bild == "083a") then Pi[1] = P083_a;
  elseif (Bild == "084a") then Pi[1] = P084_a;
  elseif (Bild == "085a") then Pi[1] = P085_a;
  elseif (Bild == "086a") then Pi[1] = P086_a;
  elseif (Bild == "087a") then Pi[1] = P087_a;
  elseif (Bild == "088a") then Pi[1] = P088_a;
  elseif (Bild == "089a") then Pi[1] = P089_a;
  elseif (Bild == "090a") then Pi[1] = P090_a;
  elseif (Bild == "091a") then Pi[1] = P091_a;
  elseif (Bild == "092a") then Pi[1] = P092_a;
  elseif (Bild == "093a") then Pi[1] = P093_a;
  elseif (Bild == "094a") then Pi[1] = P094_a;
  elseif (Bild == "095a") then Pi[1] = P095_a;
  elseif (Bild == "096a") then Pi[1] = P096_a;
  elseif (Bild == "097a") then Pi[1] = P097_a;
  elseif (Bild == "098a") then Pi[1] = P098_a;
  elseif (Bild == "099a") then Pi[1] = P099_a;
  elseif (Bild == "100a") then Pi[1] = P100_a;
  elseif (Bild == "101a") then Pi[1] = P101_a;
  elseif (Bild == "102a") then Pi[1] = P102_a;
  elseif (Bild == "103a") then Pi[1] = P103_a;
  elseif (Bild == "104a") then Pi[1] = P104_a;
  elseif (Bild == "105a") then Pi[1] = P105_a;
  elseif (Bild == "106a") then Pi[1] = P106_a;
  elseif (Bild == "107a") then Pi[1] = P107_a;
  elseif (Bild == "108a") then Pi[1] = P108_a;
  elseif (Bild == "109a") then Pi[1] = P109_a;
  elseif (Bild == "110a") then Pi[1] = P110_a;
  elseif (Bild == "111a") then Pi[1] = P111_a;
  elseif (Bild == "112a") then Pi[1] = P112_a;
  elseif (Bild == "113a") then Pi[1] = P113_a;
  elseif (Bild == "114a") then Pi[1] = P114_a;
  elseif (Bild == "115a") then Pi[1] = P115_a;
  elseif (Bild == "116a") then Pi[1] = P116_a;
  elseif (Bild == "117a") then Pi[1] = P117_a;
  elseif (Bild == "118a") then Pi[1] = P118_a;
  elseif (Bild == "119a") then Pi[1] = P119_a;
  elseif (Bild == "120a") then Pi[1] = P120_a;
  elseif (Bild == "121a") then Pi[1] = P121_a;
  elseif (Bild == "122a") then Pi[1] = P122_a;
  elseif (Bild == "123a") then Pi[1] = P123_a;
  elseif (Bild == "124a") then Pi[1] = P124_a;
  elseif (Bild == "125a") then Pi[1] = P125_a;
  elseif (Bild == "126a") then Pi[1] = P126_a;
  elseif (Bild == "127a") then Pi[1] = P127_a;
  elseif (Bild == "128a") then Pi[1] = P128_a;
  elseif (Bild == "129a") then Pi[1] = P129_a;
  elseif (Bild == "130a") then Pi[1] = P130_a;
  elseif (Bild == "131a") then Pi[1] = P131_a;
  elseif (Bild == "132a") then Pi[1] = P132_a;
  elseif (Bild == "133a") then Pi[1] = P133_a;
  elseif (Bild == "134a") then Pi[1] = P134_a;
  elseif (Bild == "135a") then Pi[1] = P135_a;
  elseif (Bild == "136a") then Pi[1] = P136_a;
  elseif (Bild == "137a") then Pi[1] = P137_a;
  elseif (Bild == "138a") then Pi[1] = P138_a;
  elseif (Bild == "139a") then Pi[1] = P139_a;
  elseif (Bild == "140a") then Pi[1] = P140_a;
  elseif (Bild == "141a") then Pi[1] = P141_a;
  elseif (Bild == "142a") then Pi[1] = P142_a;
  elseif (Bild == "143a") then Pi[1] = P143_a;
  elseif (Bild == "144a") then Pi[1] = P144_a;
  elseif (Bild == "145a") then Pi[1] = P145_a;
  elseif (Bild == "146a") then Pi[1] = P146_a;
  elseif (Bild == "147a") then Pi[1] = P147_a;
  elseif (Bild == "148a") then Pi[1] = P148_a;
  elseif (Bild == "149a") then Pi[1] = P149_a;
  elseif (Bild == "150a") then Pi[1] = P150_a;
  elseif (Bild == "151a") then Pi[1] = P151_a;
  elseif (Bild == "152a") then Pi[1] = P152_a;
  elseif (Bild == "153a") then Pi[1] = P153_a;
  elseif (Bild == "154a") then Pi[1] = P154_a;
  elseif (Bild == "155a") then Pi[1] = P155_a;
  elseif (Bild == "156a") then Pi[1] = P156_a;
  elseif (Bild == "157a") then Pi[1] = P157_a;
  elseif (Bild == "158a") then Pi[1] = P158_a;
  elseif (Bild == "159a") then Pi[1] = P159_a;
  elseif (Bild == "160a") then Pi[1] = P160_a;
  elseif (Bild == "161a") then Pi[1] = P161_a;
  elseif (Bild == "162a") then Pi[1] = P162_a;
  elseif (Bild == "163a") then Pi[1] = P163_a;
  elseif (Bild == "164a") then Pi[1] = P164_a;
  elseif (Bild == "165a") then Pi[1] = P165_a;
  elseif (Bild == "166a") then Pi[1] = P166_a;
  elseif (Bild == "167a") then Pi[1] = P167_a;
  elseif (Bild == "168a") then Pi[1] = P168_a;
  elseif (Bild == "169a") then Pi[1] = P169_a;
  elseif (Bild == "170a") then Pi[1] = P170_a;
  elseif (Bild == "171a") then Pi[1] = P171_a;
  elseif (Bild == "172a") then Pi[1] = P172_a;
  elseif (Bild == "173a") then Pi[1] = P173_a;
  elseif (Bild == "174a") then Pi[1] = P174_a;
  elseif (Bild == "175a") then Pi[1] = P175_a;
  elseif (Bild == "176a") then Pi[1] = P176_a;
  elseif (Bild == "177a") then Pi[1] = P177_a;
  elseif (Bild == "178a") then Pi[1] = P178_a;
  elseif (Bild == "179a") then Pi[1] = P179_a;
  elseif (Bild == "180a") then Pi[1] = P180_a;
  elseif (Bild == "181a") then Pi[1] = P181_a;
  elseif (Bild == "182a") then Pi[1] = P182_a;
  elseif (Bild == "183a") then Pi[1] = P183_a;
  elseif (Bild == "184a") then Pi[1] = P184_a;
  elseif (Bild == "185a") then Pi[1] = P185_a;
  elseif (Bild == "186a") then Pi[1] = P186_a;
  elseif (Bild == "187a") then Pi[1] = P187_a;
  elseif (Bild == "188a") then Pi[1] = P188_a;
  elseif (Bild == "189a") then Pi[1] = P189_a;
  elseif (Bild == "190a") then Pi[1] = P190_a;
  elseif (Bild == "191a") then Pi[1] = P191_a;
  elseif (Bild == "192a") then Pi[1] = P192_a;

  elseif (Bild == "001b") then Pi[1] = P001_b;
  elseif (Bild == "002b") then Pi[1] = P002_b;
  elseif (Bild == "003b") then Pi[1] = P003_b;
  elseif (Bild == "004b") then Pi[1] = P004_b;
  elseif (Bild == "005b") then Pi[1] = P005_b;
  elseif (Bild == "006b") then Pi[1] = P006_b;
  elseif (Bild == "007b") then Pi[1] = P007_b;
  elseif (Bild == "008b") then Pi[1] = P008_b;
  elseif (Bild == "009b") then Pi[1] = P009_b;
  elseif (Bild == "010b") then Pi[1] = P010_b;
  elseif (Bild == "011b") then Pi[1] = P011_b;
  elseif (Bild == "012b") then Pi[1] = P012_b;
  elseif (Bild == "013b") then Pi[1] = P013_b;
  elseif (Bild == "014b") then Pi[1] = P014_b;
  elseif (Bild == "015b") then Pi[1] = P015_b;
  elseif (Bild == "016b") then Pi[1] = P016_b;
  elseif (Bild == "017b") then Pi[1] = P017_b;
  elseif (Bild == "018b") then Pi[1] = P018_b;
  elseif (Bild == "019b") then Pi[1] = P019_b;
  elseif (Bild == "020b") then Pi[1] = P020_b;
  elseif (Bild == "021b") then Pi[1] = P021_b;
  elseif (Bild == "022b") then Pi[1] = P022_b;
  elseif (Bild == "023b") then Pi[1] = P023_b;
  elseif (Bild == "024b") then Pi[1] = P024_b;
  elseif (Bild == "025b") then Pi[1] = P025_b;
  elseif (Bild == "026b") then Pi[1] = P026_b;
  elseif (Bild == "027b") then Pi[1] = P027_b;
  elseif (Bild == "028b") then Pi[1] = P028_b;
  elseif (Bild == "029b") then Pi[1] = P029_b;
  elseif (Bild == "030b") then Pi[1] = P030_b;
  elseif (Bild == "031b") then Pi[1] = P031_b;
  elseif (Bild == "032b") then Pi[1] = P032_b;
  elseif (Bild == "033b") then Pi[1] = P033_b;
  elseif (Bild == "034b") then Pi[1] = P034_b;
  elseif (Bild == "035b") then Pi[1] = P035_b;
  elseif (Bild == "036b") then Pi[1] = P036_b;
  elseif (Bild == "037b") then Pi[1] = P037_b;
  elseif (Bild == "038b") then Pi[1] = P038_b;
  elseif (Bild == "039b") then Pi[1] = P039_b;
  elseif (Bild == "040b") then Pi[1] = P040_b;
  elseif (Bild == "041b") then Pi[1] = P041_b;
  elseif (Bild == "042b") then Pi[1] = P042_b;
  elseif (Bild == "043b") then Pi[1] = P043_b;
  elseif (Bild == "044b") then Pi[1] = P044_b;
  elseif (Bild == "045b") then Pi[1] = P045_b;
  elseif (Bild == "046b") then Pi[1] = P046_b;
  elseif (Bild == "047b") then Pi[1] = P047_b;
  elseif (Bild == "048b") then Pi[1] = P048_b;
  elseif (Bild == "049b") then Pi[1] = P049_b;
  elseif (Bild == "050b") then Pi[1] = P050_b;
  elseif (Bild == "051b") then Pi[1] = P051_b;
  elseif (Bild == "052b") then Pi[1] = P052_b;
  elseif (Bild == "053b") then Pi[1] = P053_b;
  elseif (Bild == "054b") then Pi[1] = P054_b;
  elseif (Bild == "055b") then Pi[1] = P055_b;
  elseif (Bild == "056b") then Pi[1] = P056_b;
  elseif (Bild == "057b") then Pi[1] = P057_b;
  elseif (Bild == "058b") then Pi[1] = P058_b;
  elseif (Bild == "059b") then Pi[1] = P059_b;
  elseif (Bild == "060b") then Pi[1] = P060_b;
  elseif (Bild == "061b") then Pi[1] = P061_b;
  elseif (Bild == "062b") then Pi[1] = P062_b;
  elseif (Bild == "063b") then Pi[1] = P063_b;
  elseif (Bild == "064b") then Pi[1] = P064_b;
  elseif (Bild == "065b") then Pi[1] = P065_b;
  elseif (Bild == "066b") then Pi[1] = P066_b;
  elseif (Bild == "067b") then Pi[1] = P067_b;
  elseif (Bild == "068b") then Pi[1] = P068_b;
  elseif (Bild == "069b") then Pi[1] = P069_b;
  elseif (Bild == "070b") then Pi[1] = P070_b;
  elseif (Bild == "071b") then Pi[1] = P071_b;
  elseif (Bild == "072b") then Pi[1] = P072_b;
  elseif (Bild == "073b") then Pi[1] = P073_b;
  elseif (Bild == "074b") then Pi[1] = P074_b;
  elseif (Bild == "075b") then Pi[1] = P075_b;
  elseif (Bild == "076b") then Pi[1] = P076_b;
  elseif (Bild == "077b") then Pi[1] = P077_b;
  elseif (Bild == "078b") then Pi[1] = P078_b;
  elseif (Bild == "079b") then Pi[1] = P079_b;
  elseif (Bild == "080b") then Pi[1] = P080_b;
  elseif (Bild == "081b") then Pi[1] = P081_b;
  elseif (Bild == "082b") then Pi[1] = P082_b;
  elseif (Bild == "083b") then Pi[1] = P083_b;
  elseif (Bild == "084b") then Pi[1] = P084_b;
  elseif (Bild == "085b") then Pi[1] = P085_b;
  elseif (Bild == "086b") then Pi[1] = P086_b;
  elseif (Bild == "087b") then Pi[1] = P087_b;
  elseif (Bild == "088b") then Pi[1] = P088_b;
  elseif (Bild == "089b") then Pi[1] = P089_b;
  elseif (Bild == "090b") then Pi[1] = P090_b;
  elseif (Bild == "091b") then Pi[1] = P091_b;
  elseif (Bild == "092b") then Pi[1] = P092_b;
  elseif (Bild == "093b") then Pi[1] = P093_b;
  elseif (Bild == "094b") then Pi[1] = P094_b;
  elseif (Bild == "095b") then Pi[1] = P095_b;
  elseif (Bild == "096b") then Pi[1] = P096_b;
  elseif (Bild == "097b") then Pi[1] = P097_b;
  elseif (Bild == "098b") then Pi[1] = P098_b;
  elseif (Bild == "099b") then Pi[1] = P099_b;
  elseif (Bild == "100b") then Pi[1] = P100_b;
  elseif (Bild == "101b") then Pi[1] = P101_b;
  elseif (Bild == "102b") then Pi[1] = P102_b;
  elseif (Bild == "103b") then Pi[1] = P103_b;
  elseif (Bild == "104b") then Pi[1] = P104_b;
  elseif (Bild == "105b") then Pi[1] = P105_b;
  elseif (Bild == "106b") then Pi[1] = P106_b;
  elseif (Bild == "107b") then Pi[1] = P107_b;
  elseif (Bild == "108b") then Pi[1] = P108_b;
  elseif (Bild == "109b") then Pi[1] = P109_b;
  elseif (Bild == "110b") then Pi[1] = P110_b;
  elseif (Bild == "111b") then Pi[1] = P111_b;
  elseif (Bild == "112b") then Pi[1] = P112_b;
  elseif (Bild == "113b") then Pi[1] = P113_b;
  elseif (Bild == "114b") then Pi[1] = P114_b;
  elseif (Bild == "115b") then Pi[1] = P115_b;
  elseif (Bild == "116b") then Pi[1] = P116_b;
  elseif (Bild == "117b") then Pi[1] = P117_b;
  elseif (Bild == "118b") then Pi[1] = P118_b;
  elseif (Bild == "119b") then Pi[1] = P119_b;
  elseif (Bild == "120b") then Pi[1] = P120_b;
  elseif (Bild == "121b") then Pi[1] = P121_b;
  elseif (Bild == "122b") then Pi[1] = P122_b;
  elseif (Bild == "123b") then Pi[1] = P123_b;
  elseif (Bild == "124b") then Pi[1] = P124_b;
  elseif (Bild == "125b") then Pi[1] = P125_b;
  elseif (Bild == "126b") then Pi[1] = P126_b;
  elseif (Bild == "127b") then Pi[1] = P127_b;
  elseif (Bild == "128b") then Pi[1] = P128_b;
  elseif (Bild == "129b") then Pi[1] = P129_b;
  elseif (Bild == "130b") then Pi[1] = P130_b;
  elseif (Bild == "131b") then Pi[1] = P131_b;
  elseif (Bild == "132b") then Pi[1] = P132_b;
  elseif (Bild == "133b") then Pi[1] = P133_b;
  elseif (Bild == "134b") then Pi[1] = P134_b;
  elseif (Bild == "135b") then Pi[1] = P135_b;
  elseif (Bild == "136b") then Pi[1] = P136_b;
  elseif (Bild == "137b") then Pi[1] = P137_b;
  elseif (Bild == "138b") then Pi[1] = P138_b;
  elseif (Bild == "139b") then Pi[1] = P139_b;
  elseif (Bild == "140b") then Pi[1] = P140_b;
  elseif (Bild == "141b") then Pi[1] = P141_b;
  elseif (Bild == "142b") then Pi[1] = P142_b;
  elseif (Bild == "143b") then Pi[1] = P143_b;
  elseif (Bild == "144b") then Pi[1] = P144_b;
  elseif (Bild == "145b") then Pi[1] = P145_b;
  elseif (Bild == "146b") then Pi[1] = P146_b;
  elseif (Bild == "147b") then Pi[1] = P147_b;
  elseif (Bild == "148b") then Pi[1] = P148_b;
  elseif (Bild == "149b") then Pi[1] = P149_b;
  elseif (Bild == "150b") then Pi[1] = P150_b;
  elseif (Bild == "151b") then Pi[1] = P151_b;
  elseif (Bild == "152b") then Pi[1] = P152_b;
  elseif (Bild == "153b") then Pi[1] = P153_b;
  elseif (Bild == "154b") then Pi[1] = P154_b;
  elseif (Bild == "155b") then Pi[1] = P155_b;
  elseif (Bild == "156b") then Pi[1] = P156_b;
  elseif (Bild == "157b") then Pi[1] = P157_b;
  elseif (Bild == "158b") then Pi[1] = P158_b;
  elseif (Bild == "159b") then Pi[1] = P159_b;
  elseif (Bild == "160b") then Pi[1] = P160_b;
  elseif (Bild == "161b") then Pi[1] = P161_b;
  elseif (Bild == "162b") then Pi[1] = P162_b;
  elseif (Bild == "163b") then Pi[1] = P163_b;
  elseif (Bild == "164b") then Pi[1] = P164_b;
  elseif (Bild == "165b") then Pi[1] = P165_b;
  elseif (Bild == "166b") then Pi[1] = P166_b;
  elseif (Bild == "167b") then Pi[1] = P167_b;
  elseif (Bild == "168b") then Pi[1] = P168_b;
  elseif (Bild == "169b") then Pi[1] = P169_b;
  elseif (Bild == "170b") then Pi[1] = P170_b;
  elseif (Bild == "171b") then Pi[1] = P171_b;
  elseif (Bild == "172b") then Pi[1] = P172_b;
  elseif (Bild == "173b") then Pi[1] = P173_b;
  elseif (Bild == "174b") then Pi[1] = P174_b;
  elseif (Bild == "175b") then Pi[1] = P175_b;
  elseif (Bild == "176b") then Pi[1] = P176_b;
  elseif (Bild == "177b") then Pi[1] = P177_b;
  elseif (Bild == "178b") then Pi[1] = P178_b;
  elseif (Bild == "179b") then Pi[1] = P179_b;
  elseif (Bild == "180b") then Pi[1] = P180_b;
  elseif (Bild == "181b") then Pi[1] = P181_b;
  elseif (Bild == "182b") then Pi[1] = P182_b;
  elseif (Bild == "183b") then Pi[1] = P183_b;
  elseif (Bild == "184b") then Pi[1] = P184_b;
  elseif (Bild == "185b") then Pi[1] = P185_b;
  elseif (Bild == "186b") then Pi[1] = P186_b;
  elseif (Bild == "187b") then Pi[1] = P187_b;
  elseif (Bild == "188b") then Pi[1] = P188_b;
  elseif (Bild == "189b") then Pi[1] = P189_b;
  elseif (Bild == "190b") then Pi[1] = P190_b;
  elseif (Bild == "191b") then Pi[1] = P191_b;
  elseif (Bild == "192b") then Pi[1] = P192_b;

  end;

 
  Bi.clear();
  Bi.add_part(Pi[1], 0, 0);
  
  if     (teil == 1) then
   Stim_event_1.set_event_code(string(i)+"_T1_Picture_"+Bild_T1[i]+"_Art:_"+Art_T1[i]);
   Stim_event_1.set_stimulus(Bi);
   Stim_trial_1.present();  

  elseif (teil == 2) then
	
   # Festlegung der korrekten Taste
	
   if     (Art_T2[i] == "old") then cor_taste = 1;
   elseif (Art_T2[i] == "sim") then cor_taste = 2; 
   elseif (Art_T2[i] == "new") then cor_taste = 3; 
   end;

   Stim_event_2.set_event_code(string(i)+"_T2_Picture_"+Bild_T2[i]+"_Art:_"+Art_T2[i]+"_cor_taste:_"+string(cor_taste));
   Stim_event_2.set_stimulus(Bi);
   Stim_trial_2.present(); 

   first_resp = stimulus_manager.last_stimulus_data().button();

  end;
	

  if (teil == 2) then
	
   # FB beim 2.Teil

   if (first_resp == 0) then
   
    trial_FB_miss.present();
    Anz_miss = Anz_miss +1;

   elseif (((first_resp == 1) && (cor_taste == 1))
        || ((first_resp == 2) && (cor_taste == 2))
        || ((first_resp == 3) && (cor_taste == 3))) then

    trial_FB_cor.present();
    Anz_cor = Anz_cor + 1;

   else
	
    trial_FB_inco.present();
    Anz_inco = Anz_inco + 1;
	
   end;
	
  end;

  i = i + 1;

 end;
 
 default.present();
 wait_interval(2000);
 
 teil = teil + 1;

end;


# Berechnung Prozentzahl korrekt

Pro_cor_d = (double(Anz_cor) * 100.0) / 192.0;
Pro_cor_i = int(Pro_cor_d);

stim_ausgabe.set_event_code("ENDE__cor:_"+string(Pro_cor_i)+"_Anz_cor:_"+string(Anz_cor)+"_Anz_inco:_"+string(Anz_inco)+"_Anz_miss:_"+string(Anz_miss));
ende.present();