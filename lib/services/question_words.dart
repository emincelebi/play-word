import 'package:flutter/foundation.dart';
import 'package:play_word/models/question_model.dart';
import 'package:play_word/services/question_database.dart';

class QuestionService {
  QuestionDatabaseHelper queDb = QuestionDatabaseHelper();

  Future<void> addSampleWords() async {
    Map<String, String> words = {
      "WELL": "İYİ",
      "TEACHER": "ÖĞRETMEN",
      "WALL": "DUVAR",
      "SAFE": "GÜVENLİ",
      "ANSWER": "CEVAP",
      "EACH": "HER",
      "FISH": "BALIK",
      "THING": "ŞEY",
      "DRESS": "ELBİSE",
      "LOOK": "BAKMAK",
      "WEEKEND": "HAFTA SONU",
      "AGAIN": "TEKRAR",
      "WHAT": "NE",
      "WOMAN": "KADIN",
      "BUS": "OTOBÜS",
      "NATIONALITY": "MİLLİYET",
      "PAY": "ÖDEMEK",
      "QUARTER": "ÇEYREK",
      "ASK": "SOR",
      "TALL": "UZUN BOYLU",
      "TREE": "AĞAÇ",
      "SAY": "SÖYLEMEK",
      "SHEEP": "KOYUN",
      "HOME": "EV",
      "NEAR": "YAKIN",
      "CAT": "KEDİ",
      "UNTIL": "-E KADAR",
      "ONLY": "BİR TEK",
      "COURSE": "DERS",
      "CHOOSE": "SEÇMEK",
      "HELP": "YARDIM ETMEK",
      "BOAT": "TEKNE",
      "EVERY": "HER",
      "COW": "İNEK",
      "PLANT": "BİTKİ",
      "LITTLE": "KÜÇÜK",
      "SCHOOL": "OKUL",
      "HAPPY": "MUTLU",
      "PART": "BÖLÜM",
      "WRITTEN": "YAZILI",
      "NOISE": "GÜRÜLTÜ",
      "JOB": "İŞ",
      "SMALL": "KÜÇÜK",
      "BOARD": "YAZI TAHTASI",
      "STUDY": "DERS ÇALIŞMAK",
      "DARK": "KARANLIK",
      "QUESTION": "SORU",
      "LEFT": "SOL",
      "SLEEP": "UYUMAK",
      "CROSS": "ÇAPRAZ",
      "DRIVER": "ŞÖFÖR",
      "TELL": "ANLATMAK",
      "PLACE": "YER",
      "WEEK": "HAFTA",
      "PET": "EVCİL HAYVAN",
      "QUICK": "HIZLI",
      "INVITE": "DAVET ETMEK",
      "AFTERNOON": "ÖĞLEDEN SONRA",
      "WORD": "KELİME",
      "BUT": "FAKAT",
      "SUN": "GÜNEŞ",
      "BATH": "BANYO",
      "WHO": "KİM",
      "RIDE": "SÜRMEK",
      "CUP": "FİNCAN",
      "MOVIE": "FİLM",
      "BED": "YATAK",
      "GET": "ALMAK",
      "TONIGHT": "BU GECE",
      "LESSON": "DERS",
      "CHANGE": "DEĞİŞTİRMEK",
      "BREAKFAST": "KAHVALTI",
      "LIFE": "HAYAT",
      "DICTIONARY": "SÖZLÜK",
      "SOMETHING": "BİR ŞEY",
      "PIG": "DOMUZ",
      "SHOP": "DÜKKAN",
      "VEGETABLE": "SEBZE",
      "HOT": "SICAK",
      "SENTENCE": "CÜMLE",
      "MAKE": "YAPMAK",
      "INTO": "İÇİNE",
      "FEEL": "HİSSETMEK",
      "BEARD": "SAKAL",
      "FRUIT": "MEYVE",
      "EXCITING": "HEYECAN VERİCİ",
      "SHOE": "AYAKKABI",
      "KIND": "TÜR",
      "TOMORROW": "YARIN",
      "LANGUAGE": "DİL",
      "MUSEUM": "MÜZE",
      "INTERESTING": "İLGİNÇ",
      "THERE": "ORADA",
      "KITCHEN": "MUFTAK",
      "COLOUR": "RENK",
      "YES": "EVET",
      "CLOSED": "KAPALI",
      "GOOD": "İYİ",
      "SIT": "OTURMAK",
      "STAY": "KALMAK",
      "VERY": "ÇOK",
      "MEETING": "TOPLANTI",
      "HOMEWORK": "EV ÖDEVİ",
      "PAGE": "SAYFA",
      "WORRY": "ENDİŞE",
      "BEDROOM": "YATAK ODASI",
      "BRUSH": "FIRÇA",
      "STREET": "CADDE",
      "HUNGRY": "ACIKMIŞ",
      "STATION": "İSTASYON",
      "PRACTISE": "ALIŞTIRMA",
      "TALK": "KONUŞMAK",
      "LOUD": "YÜKSEK SESLİ",
      "WHEN": "NE ZAMAN",
      "BALLOON": "BALON",
      "LUNCH": "ÖĞLE YEMEĞİ",
      "FATHER": "BABA",
      "PLAY": "OYNA",
      "FAMILY": "AİLE",
      "MOVIE": "FİLM",
      "MONEY": "PARA",
      "TIME": "ZAMAN",
      "STUDENT": "ÖĞRENCİ",
      "BOOK": "KİTAP",
      "MUSIC": "MÜZİK",
      "WATER": "SU",
      "FOOD": "YİYECEK",
      "FRIEND": "ARKADAŞ",
      "HOUSE": "EV",
      "GAME": "OYUN",
      "SCHOOL": "OKUL",
      "WORK": "İŞ",
      "COAT": "CEKET",
      "PAPER": "KAĞIT",
      "GREAT": "HARİKA",
      "READING": "OKUMA",
      "INSIDE": "İÇERİSİNDE",
      "DRAW": "ÇİZMEK",
      "LAST": "SON",
      "TALK": "KONUŞMAK",
      "WORRIED": "ENDİŞELİ",
      "RUN": "KOŞMAK",
      "DRIVE": "SÜRMEK",
      "TABLE": "MASA",
      "CLOCK": "SAAT",
      "BROTHER": "ERKEK KARDEŞ",
      "TRAVEL": "SEYAHAT ETMEK",
      "DEAR": "SEVGİLİ",
      "POTATO": "PATATES",
      "SNOW": "KAR",
      "FEELING": "HİS",
      "SALT": "TUZ",
      "BOTH": "HER İKİSİ DE",
      "FUNNY": "KOMİK",
      "EVENING": "AKŞAM",
      "FLOWER": "ÇİÇEK",
      "EXPENSIVE": "PAHALI",
      "MORE": "DAHA",
      "POSSIBLE": "MÜMKÜN",
      "MEAT": "ET",
      "HOSPITAL": "HASTANE",
      "WINE": "ŞARAP",
      "THANK YOU": "TEŞEKKÜR EDERİM",
      "LEAVE": "AYRILMAK",
      "SWIM": "YÜZMEK",
      "CHOCOLATE": "ÇİKOLATA",
      "PRACTISE": "PRATİK YAPMAK",
      "PICTURE": "RESİM",
      "HEAD": "KAFAT",
      "ARM": "KOL",
      "PEOPLE": "İNSANLAR",
      "VISIT": "ZİYARET ETMEK",
      "HARD": "ZOR",
      "WATCH": "İZLEMEK",
      "YESTERDAY": "DÜN",
      "WATER": "SU",
      "OUTSIDE": "DIŞARIDA",
      "EASY": "KOLAY",
      "HORSE": "AT",
      "LOT": "ÇOK",
      "NEED": "İHTİYAÇ DUYMAK",
      "DESK": "SIRA",
      "END": "SON",
      "FAVOURITE": "FAVORİ",
      "COUNTRY": "ÜLKE",
      "UNDERSTAND": "ANLAMAK",
      "IMPORTANT": "ÖNEMLİ",
      "NAME": "İSİM",
      "FAMOUS": "ÜNLÜ",
      "FACTORY": "FABRİKA",
      "MONTH": "AY",
      "LEG": "BACAK",
      "PEN": "KALEM",
      "DIE": "ÖLMEK",
      "SPEAK": "KONUŞMAK",
      "PAINTING": "RESİM",
      "BORING": "SIKICI",
      "FAT": "ŞİŞMAN",
      "DRINK": "İÇMEK",
      "BIG": "BÜYÜK",
      "WALK": "YÜRÜMEK",
      "TRAIN": "TREN",
      "WAITER": "GARSON",
      "BOX": "KUTU",
      "EXAMPLE": "ÖRNEK",
      "MILK": "SÜT",
      "SLIM": "ZAYIF",
      "PLAY": "OYNAMAK",
      "TROUSERS": "PANTOLON",
      "BEFORE": "ÖNCE",
      "SWEET": "TATLI",
      "HAT": "ŞAPKA",
      "BAND": "MÜZİK GRUBU",
      "KNIFE": "BIÇAK",
      "WEATHER": "HAVA",
      "THOUGHT": "DÜŞÜNCE",
      "BEER": "BİRA",
      "PERSON": "KİŞİ",
      "ALL": "HERŞEY",
      "ADULT": "YETİŞKİN",
      "GLASS": "BARDAK",
      "ORANGE": "PORTAKAL",
      "WRITE": "YAZMAK",
      "TOOTH": "DİŞ",
      "YEAR": "YIL",
      "BROWN": "KAHVERENGİ",
      "BEST": "EN İYİ",
      "ANYTHING": "HER ŞEY",
      "STOP": "DURMAK",
      "LONG": "UZUN",
      "TICKET": "BİLET",
      "LETTER": "MEKTUP",
      "COLD": "SOĞUK",
      "HAVE": "SAHİP OLMAK",
      "PENCIL": "KURŞUN KALEM",
      "BECAUSE": "ÇÜNKÜ",
      "PLATE": "TABAK",
      "STUDENT": "ÖĞRENCİ",
      "BISCUIT": "BİSKÜVİ",
      "WASH": "YIKAMAK",
      "SOON": "YAKINDA",
      "NOTE": "NOT",
      "NEWSPAPER": "GAZETE",
      "DINNER": "AKŞAM YEMEĞİ",
      "USED": "KULLANILMIŞ",
      "NOW": "ŞİMDİ",
      "BUTTER": "TEREYAĞI",
      "CLEAN": "TEMİZ",
      "NIGHT": "GECE",
      "MONEY": "PARA",
      "MUCH": "ÇOK",
      "MAN": "ADAM",
      "ROAD": "YOL",
      "CITY": "ŞEHİR",
      "LIKE": "HOŞLANMAK",
      "THEN": "SONRA",
      "WAITRESS": "KADIN GARSON",
      "EYE": "GÖZ",
      "THINK": "DÜŞÜNMEK",
      "EXCITED": "HEYECANLI",
      "NOSE": "BURUN",
      "FOR": "İÇİN",
      "WHY": "NEDEN",
      "WEAR": "GİYİNMEK",
      "HAIR": "SAÇ",
      "KEY": "ANAHTAR",
      "GARDEN": "BAHÇE",
      "CLOTHES": "KIYAFET",
      "SKIRT": "ETEK",
      "FIRST": "İLK",
      "TEACH": "ÖĞRETMK",
      "LATE": "GEÇ",
      "MEET": "BULUŞMAK",
      "TOGETHER": "BİRLİKTE",
      "NUMBER": "NUMARA",
      "PAST": "GEÇMİŞ",
      "NOT": "DEĞİL",
      "FOOD": "YİYECEK",
      "FOOT": "AYAK",
      "READ": "OKUMAK",
      "EGG": "YUMURTA",
      "AFTER": "SONRA",
      "FLOOR": "ZEMİN",
      "ANIMAL": "HAYVAN",
      "CHAIR": "SANDALYE",
      "SAD": "ÜZGÜN",
      "DATE": "TARİH",
      "PARENT": "EBEVEYN",
      "HOUSE": "EV",
      "SEND": "GÖNDERMEK",
      "GRASS": "OT",
      "WORLD": "DÜNYA",
      "SOMETIMES": "ARA SIRA",
      "RICE": "PIRINÇ",
      "WHERE": "NEREDE",
      "RIGHT": "DOĞRU",
      "SHOPPING": "ALIŞVERİŞ YAPMAK",
      "LATER": "SONRA",
      "PUT": "KOYMAK",
      "BIRD": "KUŞ",
      "PLANE": "UÇAK",
      "AGE": "YAŞ",
      "SMOKING": "SİGARA İÇMEK",
      "BUSINESS": "İŞ",
      "FACE": "YÜZ",
      "PLEASE": "LÜTFEN",
      "NEW": "YENİ",
      "OTHER": "DİĞER",
      "WANT": "İSTEMEK",
      "HELLO": "MERHABA",
      "ANY": "HERHANGİ",
      "HOW": "NASIL",
      "PAINT": "BOYA",
      "PAIR": "ÇİFT",
      "EARLY": "ERKEN",
      "TOMATO": "DOMATES",
      "HEAR": "DUYMAK",
      "SLOW": "YAVAŞ",
      "ROOM": "ODA",
      "WRITING": "YAZI",
      "BOY": "ERKEK ÇOCUĞU",
      "BORED": "CANI SIKKIN",
      "WHICH": "HANGİ",
      "HERE": "İŞTE, BURADA",
      "SHOWER": "DUŞ",
      "FLY": "UÇMAK",
      "SECOND": "İKİNCİ",
      "BEAUTIFUL": "GÜZEL",
      "LUNCH": "ÖĞLE YEMEĞİ",
      "KICK": "TEKMELEMEK",
      "TURN": "ÇEVİRMEK",
      "ROUND": "YUVARLAK",
      "EVERYTHING": "HERŞEY",
      "DRUM": "DAVUL",
      "LEATHER": "DERİ",
      "HOPE": "UMUT",
      "THROUGH": "İÇİNDEN",
      "GOD": "TANRI",
      "CRAZY": "ÇILGIN",
      "DANGER": "TEHLİKE",
      "CARE": "ÖNEMSEMEK",
      "SUPPER": "AKŞAM YEMEĞİ",
      "SHOUT": "BAĞIRMAK",
      "TERRIBLE": "KORKUNÇ",
      "ACTUALLY": "ASLINDA",
      "KEYBOARD": "KLAVYE",
      "SHAME": "UTANÇ",
      "LINE": "HAT",
      "IMPROVE": "GELİŞTİRMEK",
      "DOUBLE": "ÇİFT",
      "DAILY": "GÜNLÜK",
      "TOY": "OYUNCAK",
      "SOAP": "SABUN",
      "ANYONE": "KİMSE",
      "BILL": "FATURA",
      "BATTERY": "BATARYA",
      "SWEATER": "KAZAK",
      "CORRECT": "DOĞRU",
      "AGO": "ÖNCE",
      "EVERYWHERE": "HER YERDE",
      "WORST": "EN KÖTÜ",
      "PRETTY": "GÜZEL",
      "LAMP": "LAMBA",
      "SPEAKER": "KONUŞMACI",
      "CASE": "OLAY",
      "NOTHING": "HİÇBİR ŞEY",
      "SHARE": "PAYLAŞMAK",
      "UPSET": "ÜZGÜN",
      "CALLED": "ADLANDIRILAN",
      "GOAL": "HEDEF",
      "AVAILABLE": "MEVCUT",
      "PAINTER": "RESSAM",
      "MATTER": "SORUN",
      "BECOME": "OLMAK",
      "PUSH": "İTMEK",
      "TOP": "ÜST",
      "SHUT": "KAPAMAK",
      "PLEASED": "MEMNUN",
      "TEAM": "TAKIM",
      "TERM": "DÖNEM",
      "POLITE": "KİBAR",
      "CLOUD": "BULUT",
      "SHIP": "GEMİ",
      "WITHOUT": "OLMADAN",
      "CHEMIST": "KİMYAGER",
      "SINCE": "DEN BERİ",
      "EXACTLY": "KESİNLİKLE",
      "CEILING": "TAVAN",
      "CHICKEN": "TAVUK",
      "FALL": "DÜŞMEK",
      "DREAM": "RÜYA",
      "BUSY": "MEŞGUL",
      "MOST": "EN",
      "DESSERT": "TATLI",
      "RECEIPT": "MAKBUZ",
      "SNAKE": "YILAN",
      "AFTERWARDS": "SONRADAN",
      "MIX": "KARIŞTIRMAK",
      "PRICE": "FİYAT",
      "CLICK": "TIKLAMAK",
      "TILL": "KADAR",
      "GLOVE": "ELDİVEN",
      "COST": "MALİYET",
      "ANYWHERE": "HERHANGİ BİR YER",
      "TYPE": "YAZMAK",
      "GUEST": "KONUK",
      "DEEP": "DERİN",
      "THANK": "TEŞEKKÜR",
      "INTERNATIONAL": "ULUSLARARASI",
      "ADD": "EKLEMEK",
      "AIR": "HAVA",
      "SICK": "HASTA",
      "EVER": "HİÇ",
      "INSTRUMENT": "ENSTRÜMAN",
      "DRY": "KURUTMAK",
      "GET OFF": "İNMEK",
      "HORRIBLE": "KORKUNÇ",
      "SEVERAL": "BİRKAÇ",
      "HOWEVER": "ANCAK",
      "GATE": "KAPI",
      "CURTAIN": "PERDE",
      "COMPANY": "ŞİRKET",
      "THEATRE": "TİYATRO",
      "STILL": "HÂLÂ",
      "PRINT": "YAZDIRMAK",
      "WOODEN": "AHŞAPTAN",
      "FURTHER": "DAHA İLERİ",
      "ACCIDENT": "KAZA",
      "CHEF": "ŞEF",
      "WOOL": "YÜN",
      "SOUND": "SES",
      "MAGIC": "BÜYÜ",
      "ANOTHER": "BİR DİĞERİ",
      "MISSING": "EKSİK",
      "TYRE": "LASTİK",
      "HAPPEN": "OLMAK",
      "SIGN": "İŞARET",
      "ISLAND": "ADA",
      "JUST": "AZ ÖNCE",
      "FOREIGN": "YABANCI",
      "PRAY": "DUA ETMEK",
      "CHEMISTRY": "KİMYA",
      "CARROT": "HAVUÇ",
      "SURPRISED": "ŞAŞIRMIS",
      "BEAR": "AYI",
      "FRIENDLY": "ARKADAŞ CANLISI",
      "DEAD": "ÖLÜ",
      "OIL": "SIVI YAĞ",
      "WISH": "DİLEMEK",
      "ADVENTURE": "MACERA",
      "LET": "İZİN VERMEK",
      "FOREST": "ORMAN",
      "TUNE": "MELODİ",
      "CERTAINLY": "KESİNLİKLE",
      "MIXED": "KARIŞIK",
      "PROBABLY": "MUHTEMEL",
      "SET": "AYARLAMAK",
      "OUT": "DIŞARI",
      "MAD": "DELİ",
      "COVER": "ÖRTMEK",
      "MOUSE": "FARE",
      "SIMPLE": "BASİT",
      "FREE": "ÜCRETSİZ",
      "DISCOUNT": "İNDİRİM",
      "GARAGE": "GARAJ",
      "VIEW": "GÖRÜNÜM",
      "PLEASANT": "HOŞ",
      "LOVELY": "SEVİMLİ",
      "NET": "AĞ",
      "MIDDLE": "ORTA",
      "DESCRIBE": "TANIMLAMAK",
      "CARPET": "HALI",
      "SPECIAL": "ÖZEL",
      "VARIETY": "ÇEŞİTLİLİK",
      "SPACE": "BOŞ YER",
      "JUMP": "ATLAMAK",
      "HIGH": "YÜKSEK",
      "GAS": "GAZ",
      "CHEQUE": "ÇEK",
      "DESERT": "ÇÖL",
      "PITY": "YAZIK",
      "SEAT": "KOLTUK",
      "MARRIED": "EVLİ",
      "ARRIVE": "VARMAK",
      "ADVICE": "TAVSİYE",
      "FAIL": "BAŞARISIZ OLMAK",
      "SILVER": "GÜMÜŞ",
      "SELL": "SATMAK",
      "TRUE": "DOĞRU",
      "BLONDE": "SARIŞIN",
      "DOWNSTAIRS": "ALT KAT",
      "POCKET": "CEP",
      "STRONG": "GÜÇLÜ",
      "CALL": "TELEFONLA ARAMAK",
      "INCLUDE": "DAHİL ETMEK",
      "TRY": "DENEMEK",
      "ESPECIALLY": "ÖZELLİKLE",
      "PACK": "PAKETLEMEK",
      "LEMON": "LİMON",
      "ADVERTISEMENT": "REKLAM",
      "SQUARE": "KARE",
      "EXCELLENT": "MÜKEMMEL",
      "YET": "HENÜZ",
      "HURT": "İNCİTMEK",
      "BELT": "KEMER",
      "KISS": "ÖPÜCÜK",
      "SECRETARY": "SEKRETER",
      "LOSE": "KAYBETMEK",
      "WEST": "BATI",
      "WORSE": "DAHA KÖTÜ",
      "STRANGE": "GARİP",
      "LATEST": "EN SON",
      "CHANNEL": "KANAL",
      "UNUSUAL": "OLAĞANDIŞI",
      "SHEET": "YAPRAK",
      "PATH": "YOL",
      "ENOUGH": "YETERLİ",
      "LEAST": "EN AZ",
      "KILL": "ÖLDÜRMEK",
      "ENVELOPE": "ZARF",
      "SCREEN": "EKRAN",
      "WHEEL": "TEKERLEK",
      "SURNAME": "SOYAD",
      "BRAIN": "BEYİN",
      "GUIDE": "KILAVUZ",
      "PIECE": "PARÇA",
      "REST": "DİNLENMEK",
      "CRY": "AĞLAMAK",
      "INSTEAD": "YERİNE",
      "HURRY": "ACELE ETMEK",
      "VARIOUS": "ÇEŞİTLİ",
      "ICE": "BUZ",
      "NURSE": "HEMŞİRE",
      "CONGRATULATIONS": "TEBRİKLER",
      "STAGE": "SAHNE",
      "COMPETITION": "REKABET",
      "POOL": "HAVUZ",
      "MIDDAY": "GÜN ORTASI",
      "PULL": "ÇEKMEK",
      "GLAD": "MEMNUN",
      "HEATING": "ISITMA",
      "AWESOME": "HARİKA",
      "KEEP": "TUTMAK",
      "ATTRACTIVE": "ÇEKİCİ",
      "BROKEN": "KIRIK",
      "BELIEVE": "İNANMAK",
      "TEMPERATURE": "SICAKLIK",
      "DRAWER": "ÇEKMECE",
      "WILD": "VAHŞİ",
      "POINT": "NOKTA",
      "SLOWLY": "YAVAŞÇA",
      "MISTAKE": "HATA",
      "LAZY": "TEMBEL",
      "LUCKY": "ŞANSLI",
      "BRILLIANT": "MUHTEŞEM",
      "COUNTRYSIDE": "KIRSAL BÖLGE",
      "SPELL": "HECELEMEK",
      "HALL": "SALON",
      "FILL": "DOLDURMAK",
      "WIDE": "GENİŞ",
      "IDEA": "FİKİR",
      "WEB": "AĞ",
      "FIT": "SIĞMAK",
      "EVERYONE": "HERKES",
      "APARTMENT": "DAİRE",
      "COLLECT": "TOPLAMAK",
      "FOLLOW": "TAKİP ETMEK",
      "STRANGER": "YABANCI",
      "VOCABULARY": "KELİME DAĞARCIGI",
      "HIT": "VURMAK",
      "LICENCE": "LİSANS",
      "AIRPORT": "HAVALİMANI",
      "LUGGAGE": "BAGAJ",
      "HILL": "TEPE",
      "COLLEAGUE": "İŞ ARKADAŞI",
      "MOUNTAIN": "DAĞ",
      "PREPARED": "HAZIRLANMIŞ",
      "COMFORTABLE": "RAHAT",
      "SURPRISE": "SÜRPRİZ",
      "WAY": "YOL",
      "NATURE": "DOĞA",
      "KING": "KRAL",
      "RING": "YÜZÜK",
      "BOSS": "PATRON",
      "USEFUL": "İŞE YARAR",
      "LIST": "LİSTE",
      "COMPLETE": "TAMAMLAMAK",
      "QUITE": "OLDUKÇA",
      "INTERESTED": "İLGİLİ",
      "MEAN": "ANLAMINA GELMEK",
      "LOW": "DÜŞÜK",
      "BRIDGE": "KÖPRÜ",
      "PASSPORT": "PASAPORT",
      "SOCK": "ÇORAP",
      "DIRTY": "KİRLİ",
      "MAP": "HARİTA",
      "CUT": "KESEMEK",
      "SCISSORS": "MAKAS",
      "BLOOD": "KAN",
      "SAVING": "TASARRUF",
      "PERFUME": "PARFÜM",
      "SALAD": "SALATA",
      "LAKE": "GÖL",
      "PURSE": "CÜZDAN",
      "MARKET": "PAZAR",
      "UMBRELLA": "ŞEMSİYE",
      "CIRCLE": "DAİRE",
      "UNFORTUNATELY": "NE YAZIK Kİ",
      "BLANKET": "BATTANİYE",
      "ILL": "HASTA",
      "STEAL": "ÇALMAK",
      "SINGLE": "BEKAR",
      "HEALTHY": "SAĞLIKLI",
      "SHELF": "RAF",
      "DELAY": "GECİKME",
      "COPY": "KOYPA",
      "ANYWAY": "HER NEYSE",
      "CLEAR": "AÇIK",
      "AGAINST": "KARŞI",
      "MEMBER": "ÜYE",
      "PEPPER": "BİBER",
      "EXPLAIN": "AÇIKLAMAK",
      "NORTH": "KUZEY",
      "DETAIL": "AYRINTI",
      "JOURNEY": "SEYAHAT",
      "TOE": "AYAK PARMAĞI",
      "CASH": "NAKİT",
      "INVITATION": "DAVETİYE",
      "AFRAID": "KORKMUŞ",
      "STRAIGHT": "DÜZ",
      "FIRE": "ATEŞ",
      "SINGER": "ŞARKICI",
      "GET ON": "BİNMEK",
      "MEDICINE": "İLAÇ",
      "PALE": "SOLUK",
      "BICYCLE": "BİSİKLET",
      "STAMP": "KAŞE, PUL",
      "LIFT": "ASANSÖR",
      "CAP": "KAPAK",
      "SURE": "ELBETTE",
      "INCLUDING": "DAHİL OLMAK ÜZERE",
      "MOON": "AY",
      "SUCH": "BÖYLE",
      "REAL": "GERÇEK",
      "SOMEBODY": "BİRİSİ",
      "FAN": "HAYRAN",
      "REPEAT": "TEKRAR ETMEK",
      "JAM": "REÇEL",
      "ANYMORE": "ARTIK",
      "PRACTICE": "UYGULAMA",
      "TIE": "KRAVAT",
      "WIN": "KAZANMAK",
      "CARTOON": "ÇİZGİ FİLM",
      "CENTER": "MERKEZ",
      "VISITOR": "ZİYARETÇİ",
      "CAPITAL": "BAŞKENT",
      "DIARY": "GÜNLÜK",
      "NOTICE": "FARK ETMEK",
      "FAR": "UZAK",
      "STAND": "AYAKTA DURMAK",
      "HEAVY": "AĞIR",
      "UNDERGROUND": "YERALTı",
      "SUIT": "TAKIM ELBİSE",
      "CHAIN": "ZİNCİR",
      "RENT": "KİRALAMAK",
      "POINTED": "SİVRİ",
      "OWN": "KENDİ",
      "FEW": "AZ",
      "SPOON": "KAŞIK",
      "SKY": "GÖKYÜZÜ",
      "ONION": "SOĞAN",
      "MIRROR": "AYNA",
      "EMPTY": "BOŞ",
      "THIN": "İNCE",
      "WORKER": "İŞÇİ",
      "WOOD": "AHŞAP",
      "ART": "SANAT",
      "EXCEPT": "HARİÇ",
      "BUILDING": "BİNA",
      "APPOINTMENT": "RANDEVU",
      "PASS": "GEÇMEK",
      "LUCK": "ŞANS",
      "LAY": "UZANMAK",
      "CENTURY": "YÜZYIL",
      "CONTACT": "TEMAS",
      "CHURCH": "KİLİSE",
      "ALONE": "YALNIZ",
      "FINALLY": "EN SONUNDA",
      "HISTORY": "TARİH",
      "DEGREE": "DERECE",
      "WHOLE": "BÜTÜN",
      "RECEIVE": "TESLİM ALMAK",
      "GEOGRAPHY": "COĞRAFYA",
      "SIDE": "YAN",
      "FOG": "SİS",
      "AWAY": "UZAKTA",
      "HATE": "NEFRET ETMEK",
      "ORDER": "SİPARİŞ VERMEK",
      "RUNNER": "KOŞUCU",
      "DEPARTMENT": "BÖLÜM",
      "RETURN": "GERİ DÖNMEK",
      "SINK": "LAVABO",
      "MATCH": "EŞLEŞTİRMEK",
      "BADLY": "KÖTÜ BİR ŞEKİLDE",
      "USUALLY": "GENELLİKLE",
      "NATIONAL": "ULUSAL",
      "MEMORY": "HAFIZA",
      "SOMEWHERE": "BİR YER",
      "EASILY": "KOLAYCA",
      "REPAIR": "TAMİR ETMEK",
      "NEWS": "HABER",
      "WET": "ISLAK",
      "CONCERT": "KONSER",
      "TIMETABLE": "PROGRAM",
      "ELSE": "BAŞKA",
      "LARGE": "BÜYÜK",
      "FRONT": "ÖN",
      "SERVE": "SERVİS ETMEK",
      "TEXT": "METİN",
      "HOLD": "TUTMAK",
      "DECIDE": "KARAR VERMEK",
      "SOUTH": "GÜNEY",
      "CAREFUL": "DİKKATLİ",
      "LEVEL": "SEVİYE",
      "BRING": "GETİRMEK",
      "NEARLY": "NEREDEYSE",
      "FRIDGE": "BUZDOLABI",
      "ADVANCED": "İLERİ DÜZEY",
      "COOKER": "OCAK",
      "CREAM": "KREM",
      "OPPOSITE": "ZIT",
      "FASHION": "MODA",
      "LIBRARY": "KÜTÜPHANE",
      "PHYSICS": "FİZİK",
      "ELECTRICITY": "ELEKTRİK",
      "LAUGH": "GÜLMEK",
      "SPEND": "HARCAMAK",
      "SONG": "ŞARKI",
      "TOWEL": "HAVLU",
      "BOWL": "KASE",
      "FIELD": "ALAN",
      "STORY": "ÖYKÜ",
      "SORT": "TÜR",
      "FORM": "ŞEKİL VERMEK",
      "CASTLE": "KALE",
      "REASON": "SEBEP",
      "JEWELLERY": "MÜCEVHER",
      "PREFER": "TERCİH ETMEK",
      "LOUD": "YÜKSEK SESLE",
      "QUEEN": "KRALİÇE",
      "PICK": "TOPLAMAK",
      "LEND": "ÖDÜNÇ VERMEK",
      "STORM": "FIRTINA",
      "FORGET": "UNUTMAK",
      "JOIN": "KATILMAK",
      "PRIZE": "ÖDÜL",
      "TAKE CARE": "KENDİNE İYİ BAK",
      "CUPBOARD": "DOLAP",
      "DOCUMENT": "BELGE",
      "SOUL": "RUH",
      "SAUCE": "SOS",
      "NOBODY": "HİÇKİMSE",
      "OFFER": "TEKLİF ETMEK",
      "ENGINE": "MOTOR",
      "WINNER": "KAZANAN",
      "AROUND": "ETRAFINDA",
      "QUIET": "SESSİZ",
      "SIZE": "BOYUT",
      "WAR": "SAVAŞ",
      "HEALTH": "SAĞLIK",
      "OCCUPATION": "MESLEK",
      "FAIR": "AÇIK RENK",
      "INDOOR": "KAPALI ALAN",
      "FORK": "ÇATAL",
      "MIND": "ZİHİN",
      "CLIMB": "TIRMANMAK",
      "BOOT": "ÇİZME",
      "WONDERFUL": "HARİKA",
      "DISCUSS": "TARTIŞMAK",
      "PASSENGER": "YOLCU",
      "FINGER": "PARMAK",
      "CROWDED": "KALABALIK",
      "INFORMATION": "BİLGİ",
      "EVEN": "BİLE",
      "UPSTAIRS": "ÜST KAT",
      "ONCE": "BİR KEZ",
      "FARMER": "ÇİFTÇİ",
      "ARTIST": "SANATÇI",
      "QUICKLY": "HIZLI BİR ŞEKİLDE",
      "MAYBE": "BELKİ",
      "ALMOST": "NEREDEYSE",
      "AGREE": "AYNI FİKİRDE OLMAK",
      "ENGINEER": "MÜHENDİS",
      "FURNITURE": "MOBİLYA",
      "POST": "POSTA",
      "WALLET": "CÜZDAN",
      "SOFTWARE": "YAZILIM",
      "FISHING": "BALIK TUTMA",
      "BRUSH": "FIRÇA",
      "IMMEDIATELY": "HEMEN",
      "MANAGER": "MÜDÜR",
      "BREAK": "KIRMAK",
      "THROW": "FIRLATMAK",
      "CYCLING": "BİSİKLETE BİNMEK",
      "MACHINE": "MAKİNE",
      "MARK": "OKUL NOTU",
      "PILLOW": "YASTIK",
      "NECK": "BOYUN",
      "CHECK": "KONTROL ETMEK",
      "MUSHROOM": "MANTAR",
      "FRESH": "TAZE",
      "RACE": "YARIŞ",
      "LOST": "KAYIP",
      "RECORD": "KAYIT ETMEK",
      "INSECT": "BÖCEK",
      "PROJECT": "PROJE",
      "BIT": "PARÇA",
      "SCIENCE": "BİLİM",
      "TRAM": "TRAMVAY",
      "UNCLE": "AMCA",
      "GROW": "BÜYÜMEK",
      "TWICE": "İKİ KEZ",
      "STOMACH": "MİDE",
      "AMAZING": "İNANILMAZ",
      "USUAL": "OLAĞAN",
      "BUILD": "İNŞA ETMEK",
      "PLUS": "ARTI",
      "AREA": "ALAN",
      "FUTURE": "GELECEK",
      "WEEKLY": "HAFTALIK",
      "FACT": "GERÇEK",
      "LIE": "YALAN SÖYLEMEK",
      "RICH": "ZENGİN",
      "BAKE": "FIRINDA PİŞİRMEK",
      "EXAM": "SINAV",
      "BEAN": "FASULYE",
      "HEART": "KALP",
      "BORROW": "ÖDÜNÇ ALMAK",
      "CEREAL": "TAHIL",
      "LESS": "DAHA AZ",
      "CRISP": "GEVREK",
      "ENTRANCE": "GİRİŞ",
      "TO BE BORN": "DOĞMAK",
      "STAFF": "PERSONEL",
      "RAILWAY": "DEMİRYOLU",
      "PERFECT": "MÜKEMMEL",
      "TOUR": "TUR",
      "SAVE": "PARA BİRİKTİRMEK",
      "GOLD": "ALTIN",
      "DENTIST": "DİŞ DOKTORU",
      "MAGAZINE": "DERGİ",
      "CUSTOMER": "MÜŞTERİ",
      "DANGEROUS": "TEHLİKELİ",
      "SPARE": "YEDEK",
      "BOTTLE": "ŞİŞE",
      "TRIP": "SEYAHAT",
      "CORNER": "KÖŞE",
      "SALE": "SATIŞ",
      "SOFT": "YUMUŞAK",
      "BOIL": "KAYNAMAK",
      "EARN": "KAZANMAK",
      "MIDNIGHT": "GECE YARISI",
      "BOTHER": "RAHATSIZ ETMEK",
      "RUBBER": "SİLGİ",
      "COACH": "OTOBÜS",
      "NOISY": "GÜRÜLTÜLÜ",
      "GUESS": "TAHMİN ETMEK",
      "MOVE": "HAREKET ETTİRMEK",
      "SLICE": "DİLİM",
      "WHILE": "-İKEN",
      "PREPARE": "HAZIRLAMAK",
      "THIRSTY": "SUSAMİŞ",
      "WELCOME": "HOŞGELDİNİZ",
      "INSTRUCTION": "TALİMAT",
      "PERHAPS": "BELKİ",
      "RECORDING": "KAYIT",
      "FLIGHT": "UÇUŞ",
      "FILE": "DOSYA",
      "SUITCASE": "BAVUL",
      "EAST": "DOĞU",
      "MEANING": "ANLAM",
      "BRIGHT": "PARLAK",
      "TIDY": "DÜZENLİ",
      "MOMENT": "AN",
      "ANGRY": "ÖFKELİ",
      "HEADACHE": "BAŞ AĞRISI",
      "UNHAPPY": "MUTSUZ",
      "ROAST": "KIZARTMAK",
      "NEIGHBOUR": "KOMŞU",
      "PUPIL": "ÖĞRENCİ",
      "DIFFERENCE": "FARK",
      "PAIN": "AĞRI",
      "NECKLACE": "KOLYE",
      "RULER": "CETVEL",
      "GIFT": "HEDİYE",
      "AMOUNT": "MİKTAR",
      "CANCEL": "İPTAL ETMEK",
      "INFORM": "BİLGİLENDİRMEK",
    };
    bool doesExistt = await queDb.doesQuestionExistByWord("WELL");
    if (!doesExistt) {
      for (var entry in words.entries) {
        String word = entry.key;
        String answer = entry.value;

        bool doesExist = await queDb.doesQuestionExistByWord(word);
        if (!doesExist) {
          int insertedId = await queDb.insertQuestion(
            QuestionModel(question: word, answer: answer),
          );
          if (insertedId != -1) {
            if (kDebugMode) {
              print('Kelime eklendi: ID - $insertedId /  $word - $answer');
            }
          } else {
            if (kDebugMode) {
              print('Kelime eklenirken bir hata oluştu.');
            }
          }
        } else {
          if (kDebugMode) {
            print('Kelime zaten var: $word');
          }
        }
      }
    } else {
      if (kDebugMode) {
        print("already have database");
      }
    }
  }
}
