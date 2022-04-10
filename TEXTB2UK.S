;---------------------------------------------------------------
;
; TEXTES BAT 2
;
;---------------------------------------------------------------
;
; ADRSUJETLISTE
;
; LISTE DES OFFSET POUR CALCULER L'ADRESSE DES TEXTES DES SUJETS
;

adrsujetliste::        .DC.w sujet0-sujet0
             .DC.w sujet1-sujet0,sujet2-sujet0,sujet3-sujet0,sujet4-sujet0
             .DC.w sujet5-sujet0,sujet6-sujet0,sujet7-sujet0,sujet8-sujet0
             .DC.w sujet9-sujet0,sujet10-sujet0,sujet11-sujet0,sujet12-sujet0
             .DC.w sujet13-sujet0,sujet14-sujet0,sujet15-sujet0,sujet16-sujet0
             .DC.w sujet17-sujet0,sujet18-sujet0,sujet19-sujet0,sujet20-sujet0
             .DC.w sujet21-sujet0,sujet22-sujet0,sujet23-sujet0,sujet24-sujet0
             .DC.w sujet25-sujet0,sujet26-sujet0,sujet27-sujet0,sujet28-sujet0
             .DC.w sujet29-sujet0,sujet30-sujet0,sujet31-sujet0,sujet32-sujet0


;---------------------------------------------------------------
;LISTE DES SUJETS

;23 caracteres max !!!!!

sujet0::     
sujet1::     .DC.b "ROMA II",0
sujet2::     .DC.b "TOURIST SECTOR",0
sujet3::     .DC.b "INDUSTRIAL SECTOR",0
sujet4::     .DC.b "SOUTH SECTOR",0
sujet5::     .DC.b "ASHAN SECTOR",0
sujet6::     .DC.b "NORTH SECTOR",0
sujet7::     .DC.b "CITY",0
sujet8::     .DC.b "VERTUMNUS TOWER",0
sujet9::     .DC.b "VOICE RETRIEVAL SYSTEM",0
sujet10::    .DC.b "FALSE PRAETOR/CARD",0
sujet11::    .DC.b "WELCO INC.",0
sujet12::    .DC.b "AXIAL SUCKER SYSTEM",0
sujet13::    .DC.b "DITROXYL PENTRADINITE",0
sujet14::    .DC.b "KOSHAN TOWER",0
sujet15::    .DC.b "CARMENTA TOWER",0
sujet16::    .DC.b "MINERVA TOWER",0
sujet17::    .DC.b "PRAETORS COURT",0
sujet18::    .DC.b "MASSIGLIA BANK",0
sujet19::    .DC.b "SENATOR JUGH'AHIH",0
sujet20::    .DC.b "ZIST HONOR",0
sujet21::    .DC.b "PRAETOR'S CLOTHES",0
sujet22::    .DC.b "BEDIHN 6",0
sujet23::    .DC.b "DRILL",0
sujet24::    .DC.b "SPACE STATION",0
sujet25::    .DC.b "ROMA II PRISON",0
sujet26::    .DC.b "CODING CONTACT LENSE",0
sujet27::    .DC.b "RX PASS",0
sujet28::    .DC.b "TA PASS",0
sujet29::    .DC.b "A PASS",0
sujet30::    .DC.b "AIC ACCESS CARD",0
sujet31::    .DC.b "VOICE RETRIEVAL TAPE",0
sujet32::    .DC.b "BOMBUZAL",0
;---------------------------------------------------------------
;---------------------------------------------------------------
;---------------------------------------------------------------
;                      MENUS
;---------------------------------------------------------------
;---------------------------------------------------------------
;---------------------------------------------------------------

;14 caracteres max !!!

mainmtx0::   .DC.b "LOAD GAME",0
mainmtx1::   .DC.b "SAVE GAME",0
mainmtx2::   .DC.b "INVENTORY",0
mainmtx3::   .DC.b "SET UP",0
mainmtx4::   .DC.b "SLEEP",0
mainmtx5::   .DC.b "PAUSE",0
mainmtx6::   .DC.b "VIDEOPHONE",0
intertx::    .DC.b "HAIL",0

intertx0::   .DC.b "CHAT",0
intertx1::   .DC.b "GIVE",0
intertx2::   .DC.b "RECRUIT",0
intertx3::   .DC.b "BUY",0
intertx4::   .DC.b "SELL",0
intertx5::   .DC.b "STEAL",0
intertx6::   .DC.b "FIGHT",0
txprix0::    .DC.b "000000 CRED",0
txprix1::    .DC.b "000000 CRED",0
txprix2::    .DC.b "000000 CRED",0
txprix3::    .DC.b "000000 CRED",0
txprix4::    .DC.b "000000 CRED",0
txprix5::    .DC.b "000000 CRED",0
txprix6::    .DC.b "000000 CRED",0

grouptx::    .DC.b "   GROUP",0

;22 caracteres max

grouptx0::   .DC.b "FIND AN OBJECT",0
grouptx1::   .DC.b "LEARN ABOUT A SUBJECT",0
grouptx2::   .DC.b "APPOINTMENT",0
grouptx3::   .DC.b "TALK",0
grouptx4::   .DC.b "GIVE AN OBJECT",0
grouptx5::   .DC.b "TAKE AN OBJECT",0
grouptx6::   .DC.b "BAN FROM THE GROUP",0
rdvtx0::     .DC.b "CANOPEA GARDENS",0
rdvtx1::     .DC.b "ASTROPORT HALL",0
rdvtx2::     .DC.b "APPOLON NIGHT CLUB",0
rdvtx3::     .DC.b "MANTOUE RECEPTION",0
rdvtx4::     .DC.b "REJOIN",0
rdvtx5::     .DC.b "CANCEL MISSION",0


;19 caracteres max !!!


mtx0::       .DC.b "        TALK",0
mtx1::       .DC.b "         BUY",0
mtx2::       .DC.b "       STEAL",0
mtx3::       .DC.b "       RENT A ROOM",0
mtx4::       .DC.b "     TAKE/LEAVE KEY",0
mtx5::       .DC.b "         SHOW ID'S",0
mtx6::       .DC.b "MAKE AN APPOINTMENT",0
mtx7::       .DC.b "AGENDA             ",0
mtx8::       .DC.b "  TB1 TERMINUS",0       ;1
mtx9::       .DC.b "  TF TERMINUS",0        ;2
mtx10::      .DC.b "  TB TERMINUS",0        ;3
mtx11::      .DC.b "  TE TERMINUS",0        ;4
mtx12::      .DC.b "  CARMENTA TOWER",0     ;5
mtx13::      .DC.b "  VERTUMNUS TOWER",0    ;6
mtx14::      .DC.b "  MINERVA TOWER",0      ;7
mtx15::      .DC.b "  KOSHAN TOWER",0       ;8
mtx16::      .DC.b "  JANUS TOWER",0        ;9
mtx17::      .DC.b "ORDER LENSES     ",0
mtx18::      .DC.b "      SWAP       ",0


txboi0::     .DC.b "    I'M SORRY,     ",0
txboi1::     .DC.b " THE HOTEL IS FULL ",0  ;TAILLE MAX
txboi3::     .DC.b " ",0
txboi4::     .DC.b "1 DAY   100 CREDITS",0
txboi5::     .DC.b "2 DAYS  200 CREDITS",0
txboi6::     .DC.b "4 DAYS  400 CREDITS",0
txboi7::     .DC.b "8 DAYS  800 CREDITS",0
txboi8::     .DC.b "   THAT WILL BE    ",0
txboi81::    .DC.b "       100         ",0
txboi9::     .DC.b "   CREDITS. OK ?   ",0
txboioui::   .DC.b " YES ",0
txboinon::   .DC.b "  NO ",0
txboi10::    .DC.b " SORRY, YOU DON'T  ",0
txboi11::    .DC.b "HAVE ENOUGH MONEY !",0
txboi12::    .DC.b "    I SUGGEST      ",0
txboi13::    .DC.b "    TODAY,  AT     ",0

txboi131::   .DC.b "       00 H.       ",0
txboi14::    .DC.b "  SORRY, NO MORE   ",0
txboi15::    .DC.b "   APPOINTMENTS    ",0
txboi16::    .DC.b "    FOR TODAY      ",0
txboi17::    .DC.b "COME BACK TOMORROW ",0
txboi18::    .DC.b "   ENTER CITIZEN   ",0
txboi19::    .DC.b "  EQUITES MENASIS  ",0
txboi20::    .DC.b " YOU ARE EXPECTED. ",0
txboi21::    .DC.b " YOU ALREADY HAVE  ",0
txboi22::    .DC.b "  AN APPOINTMENT   ",0
txboi23::    .DC.b "      TODAY        ",0
txboi24::    .DC.b "  GET OUT BEFORE   ",0
txboi25::    .DC.b "    I GET ANGRY    ",0
txboi26::    .DC.b "     AND CALL      ",0
txboi27::    .DC.b "THE CATAPHRACTAIRES",0
txboi28::    .DC.b "    EXPRESS VIA    ",0
txboi29::    .DC.b "300 CREDITS MINIMUM",0
txboi30::    .DC.b "   MOSQUITO TAXI   ",0
txboi31::    .DC.b "PRICE:  400 CREDITS",0
txboi32::    .DC.b "  WITH A DRIVER ?  ",0
txboi33::    .DC.b "PRICE:  950 CREDITS",0
txboi34::    .DC.b " IZAE BOGLI IS DEAD",0
txboi35::    .DC.b " HIS SAFE HAS BEEN ",0
txboi36::    .DC.b "  FORCED AND HIS   ",0
txboi37::    .DC.b " DEEDS DISAPPEARED ",0
txboi38::    .DC.b "  COME BACK IN 24  ",0
txboi39::    .DC.b " HOURS, YOUR CODER ",0
txboi40::    .DC.b "  CONTACT LENSES   ",0
txboi41::    .DC.b "  WILL BE READY.   ",0
txboi42::    .DC.b "    I NEED A       ",0
txboi43::    .DC.b "  CODED MEMORY     ",0
txboi44::    .DC.b "  TABLET   TO      ",0
txboi45::    .DC.b "   MAKE THEM.      ",0
txboi46::    .DC.b " YOU HAVE ALREADY  ",0
txboi47::    .DC.b "   ORDERED THEM    ",0
txboi48::    .DC.b "   THEY'RE NOT     ",0
txboi49::    .DC.b "   READY YET...    ",0
txboi50::    .DC.b "  YOUR LENSES ARE  ",0
txboi51::    .DC.b "     READY...      ",0
txboi52::    .DC.b "     YOU CAN       ",0
txboi53::    .DC.b "    BUY THEM...    ",0

txboi54::    .DC.b "...AAAARRRGGGHHH!!!",0
txboi55::    .DC.b "AFTER A FEW STEPS  ",0
txboi56::    .DC.b " YOU FEEL A        ",0
txboi57::    .DC.b " TERRIBLE HEAT...  ",0
txboi58::    .DC.b " THE G RAY FIELD   ",0
txboi59::    .DC.b " HAS GONE OFF,     ",0
txboi60::    .DC.b " YOU'VE HAD IT...  ",0

txboi61::    .DC.b " ",0
txboi62::    .DC.b " ",0
txboi63::    .DC.b "    THE END...     ",0
txboi64::    .DC.b " ",0
txboi65::    .DC.b "     SPACE SHIP     ",0
txboi66::    .DC.b "    5000 CREDITS.   ",0

txboi67::    .DC.b " YOU ARE ARRESTED  ",0
txboi68::    .DC.b "    AND JAILED     ",0
txboi69::    .DC.b "   FOR CRIMINAL    ",0
txboi70::    .DC.b "  IMPERSONATION    ",0

txboi71::    .DC.b " AN ALARM GOES OFF ",0
txboi72::    .DC.b "  YOU'RE CAUGHT... ",0

txboi73::    .DC.b "YOU'RE DISCOVERED!",0
txboi74::    .DC.b " IT'S ALL OVER... ",0

txboi75::    .DC.b "      SAVE         ",0
txboi76::    .DC.b "     GAME ?        ",0

txboi77::    .DC.b " INSERT 'SAVE GAME'",0
txboi78::    .DC.b "   DISK OR DOUBLE  ",0
txboi79::    .DC.b "  SIDED BLANK DISK ",0
txboi80::    .DC.b " ",0

txboi82::    .DC.b "      LOAD         ",0
txboi83::    .DC.b "      GAME?        ",0
txboi84::    .DC.b "    FINISH OFF     ",0
txboi85::    .DC.b "  THE GLADIATOR ?  ",0


;---------------------------------------------------------------
;NOM DES OBJETS (MAX 26 CARACTERES)

lunnoct::    .DC.b "NIGHT VISION GLASSES",0
chemise::    .DC.b "SHIRT",0
sacj::       .DC.b "DISPOSABLE BAG",0
sacoche::    .DC.b "SATCHEL",0
grandsac::   
             .DC.b "BIG BAG",0
bombuzal::   
             .DC.b "BOMBUZAL FLASH",0
corde::      
             .DC.b "ROPE",0
video::      
             .DC.b "PORTABLE VIDEOPHONE",0
eau::        
             .DC.b "WATER",0
the::        
             .DC.b "HERBAL TEA",0
cafe::       
             .DC.b "THERMOS OF COFFEE",0
volcano::    .DC.b "VOLCANO COCKTAIL",0
merluz::     .DC.b "MERLUZ NITROCOLA",0
doubles::    .DC.b "DOUBLE SPLATZ",0
vinvert::    
             .DC.b "GREEN WINE",0
vincecub::   
             .DC.b "CECUBLE WINE",0
vinmassiq::  
             .DC.b "MASSIQUE WINE",0
vinfaler::   
             .DC.b "FALERNE WINE",0
gateau::     
             .DC.b "TASMARI CAKE",0
saucisse::   
             .DC.b "SAUSAGE",0
poisson::    
             .DC.b "FLYING FISH",0
galettes::   
             .DC.b "ROMAN SCONES",0
ppains::     
             .DC.b "BREAD ROLLS",0
salade::     
             .DC.b "'BIG FODLES' SALAD",0
pizza::      
             .DC.b "(EARTHSIDE) PIZZA",0
algue::      
             .DC.b "SEAWEED PILLS",0
hamburge::   
             .DC.b "HAMBURGER",0

frites::     
             .DC.b "FRENCH FRIES",0
azmani::     
             .DC.b "AZMANI POT",0
vespe::      
             .DC.b "ISNUFLURE VESPE",0
painroug::   
             .DC.b "RED WHEAT BREAD",0
crepe::      
             .DC.b "BORGANIS PANCAKE",0
antiop::     
             .DC.b "ANTIOPINE MEAT",0
aureus::     
             .DC.b "AUREUS",0

denarius::   .DC.b "DENARIUS",0
nummus::     .DC.b "NUMMUS",0
as::         .DC.b "AS",0
scutum::     .DC.b "IONIC SCUTUM",0
cuirasse::   .DC.b "PRISM ARMOUR",0
cuissard::   .DC.b "DEFLECTOR LEGGINGS",0
coudiere::   .DC.b "DEFLECTOR COUDIERES",0
casqued::    .DC.b "DEFLECTOR HELMET",0
gilet2::     
             .DC.b "DEFLACTOR VEST 2",0
gilet1::     
             .DC.b "DEFLECTOR VEST 1",0
chf6::       
             .DC.b "FORCE FIELD 6",0
chf8::       
             .DC.b "FORCE FIELD 8",0
chf9::       
             .DC.b "FORCE FIELD 9",0
k1::         
             .DC.b "K1",0

k2::         
             .DC.b "K2",0

lp45::       
             .DC.b "LP-45",0

plas1::      
             .DC.b "PLAS-1",0

fillum12::   
             .DC.b "FILLUM-12",0

lp110::      
             .DC.b "LP-110",0

lp02::       
             .DC.b "LP02",0

n29::        
             .DC.b "N29",0

lp57::       
             .DC.b "LP-57",0

lp12::       
             .DC.b "LP-12",0

hasta1::     
             .DC.b "HASTA-1000",0

hasta2::     
             .DC.b "HASTA-2000",0

laskolt::    
             .DC.b "LASKOLT-45",0

plasma::     
             .DC.b "PLASMATRON",0

asoa50::     
             .DC.b "ASOA-50",0

pilumlas::   
             .DC.b "LASER PILUM",0
gladius::    
             .DC.b "GLADIUS",0

haas10::     
             .DC.b "HAAS-10",0

beckmann::   
             .DC.b "BECKMANN",0

voktraso::   
             .DC.b "VOKTRASOFF",0

corps::      
             .DC.b "BODY",0

bob::        
             .DC.b "B.O.B",0

main_g::     
             .DC.b "LEFT HAND",0
main_d::     
             .DC.b "RIGHT HAND",0
ctueur::     
             .DC.b "MURDER CONTRACT",0
sdouleu::    
             .DC.b "PAIN STICK",0
vetpret::    
             .DC.b "PRAETOR'S CLOTHES",0
cp_kubit::   
             .DC.b "PRAETOR KUBITUS' CARD",0
cp_adelia::  
             .DC.b "PRAETOR ADELIA'S CARD",0
cp_bonum::   
             .DC.b "PRAETOR BONUM CARD",0
cp_sirius::  
             .DC.b "PRAETOR SIRIUS' CARD",0
cp_agam::    
             .DC.b "PREATOR AGAMEMNUM'S CARD",0
fc_pret::    
             .DC.b "FALSE PRAETOR'S CARD",0
livremem::   
             .DC.b "MEMOIRS OF A PAGE",0
journal::    
             .DC.b "LOCAL NEWSPAPER",0
papierma::   
             .DC.b "SUNDRY MASSIGLIA PAPERS",0
verrecod::   
             .DC.b "CODING CONTACT LENSES",0
banderes::   
             .DC.b "VOICE RETRIEVAL TAPE",0
resvocal::   
             .DC.b "VOICE RETRIEVAL SYSTEM",0
ditroxyl::   
             .DC.b "DITROXYL",0

axial::      
             .DC.b "AXIAL SUCKER SYSTEM",0
tablette::   
             .DC.b "MEMORY TABLET",0
titrepro::   
             .DC.b "TITLE DEED",0
cartecre::   
             .DC.b "CREDIT CARD",0
cc_ma::      
             .DC.b "MASSIGLIA CREDIT CARD",0
cc_jm::      
             .DC.b "J.MENASIS CREDIT CARD",0
clehotel::   
             .DC.b "HOTEL KEY",0
cle_cite::   
             .DC.b "HOTEL KEY (CITY)",0
cle_mm::     
             .DC.b "HOTEL KEY (MANTOUE)",0
cartecai::   
             .DC.b "AIC ACCESS CARD",0
lp_a::       
             .DC.b "PASS A",0
lp_ta::      
             .DC.b "PASS TA",0
lp_rx::      .DC.b "PASS RX",0
cle_mer::    .DC.b "HOTEL MERCURY KEY",0
;---------------------------------------------------------------

;              TAILLE MAX 25 CARACTERES
qtexte1::    
             .DC.b "MACHINE OUT OF ORDER",0
qtexte1a::   
             .DC.b "NOT ENOUGH CREDITS",0

;               TAILLE MAX 7 CARACTERES
qtjouer::    
             .DC.b "GAME",0
qtparier::   
             .DC.b "BET",0
qtquit::     
             .DC.b "QUIT",0
             .EVEN 

quattrotx::  .DC.l qtexte1,qtexte1a,qtjouer,qtparier,qtquit

;              TAILLE MAX 25 CARACTERES
ttexte1::    
             .DC.b "MACHINE OUT OF ORDER",0
ttexte1a::   
             .DC.b "NOT ENOUGH CREDITS",0
ttexte2::    
             .DC.b "STAKE",0
ttexte3::    
             .DC.b "YOU WIN :",0
ttexte4::    
             .DC.b "YOU LOSE :",0

;               TAILLE MAX 7 CARACTERES

tjouer::     
             .DC.b "GAME",0
tparier::    
             .DC.b "BET",0
tquit::      
             .DC.b "QUIT",0
             .EVEN 

tubutx::     .DC.l ttexte1,ttexte1a,ttexte2,ttexte3,ttexte4,tjouer,tparier,tquit

;14 caracteres max !!!


mode::       
             .DC.b "MODE :",0
             .DC.b "AUTOMATIC",0
             .DC.b "MANUAL",0
vtexted::    
             .DC.b "ASTROPORT",0
             .DC.b "TA1",0
             .DC.b "TA2",0
             .DC.b "TA",0
             .DC.b "TA3",0
             .DC.b "TF1",0
             .DC.b "TF",0
             .DC.b "TB",0
             .DC.b "TB1",0
             .DC.b "TE",0
             .DC.b "TE2",0
             .DC.b "TC",0
             .DC.b "TC1",0
             .DC.b "TD",0

vtexte::     
             .DC.b "DEPARTURE",0
             .DC.b "ARRIVAL",0

;     TEXTE DIT PAR LE FLIC
;  4 LIGNE DE HAUT MAXIMUM
;  34 CARACTERES PAR LIGNE MAXIMUM
; SI MOINS DE 4 LIGNES, LA DERNIERE LIGNE DOIT ETRE EGALE A .DC.B 0

vcontrpa::   
             .DC.b "BAL'AMAYE CITIZEN",0
             .DC.b "VIA CATAPHRACTAIRE",0
             .DC.b "SHOW ME YOUR PASS",0
             .DC.b "PLEASE",0
             .DC.b 0
vpasok::     
             .DC.b "THANK YOU, MOVE ALONG",0
             .DC.b 0
vpasnook::   
             .DC.b "YOU ARE NOT ALLOWED",0
             .DC.b "TO DRIVE ON THIS VIA",0
             .DC.b "PLEASE FOLLOW ME",0
             .DC.b 0
vexesvi::    
             .DC.b "BAL'AMAYE CITIZEN",0
             .DC.b "VIA CATAPHRACTAIRE, YOUR",0
             .DC.b "FINE FOR BREAKING THE SPEED LIMIT",0
             .DC.b "IS 300 CREDITS",0
             .DC.b 0
vexesnook::  
             .DC.b "YOU HAVEN'T ENOUGH MONEY",0
             .DC.b "YOU CAN EXPLAIN AT THE STATION",0
             .DC.b 0
vexesok::    
             .DC.b "MOVE ALONG",0
             .DC.b "BUT BE MORE CAREFUL",0
             .DC.b "IN THE FUTURE",0
             .DC.b 0
             .EVEN 

viatx::                ;OVERLAY 52
             .DC.l mode,vtexted,vtexte,vcontrpa,vpasok,vpasnook,vexesvi
             .DC.l vexesnook,vexesok


;42 caracteres max, respecter le nombre de lignes

txcaid1::    
             .DC.b "YOU HAVE ASKED FOR:",0
             .DC.b "ECONOMY/TERITORIAL RIGHTS/BEDIHN6",0
             .DC.b "- BEDIHN6: NATURAL SATELLITE OF SHEDISHAN",0
             .DC.b "            BIG ECHIATONE 21 DEPOSITS",0
             .DC.b " - OWNERS : ",0
             .DC.b "        KOSHAN INC            : 200 DEEDS",0
             .DC.b "        MASSIGLIA BANK        : 050",0
             .DC.b "        SEN. JUGH'AHIH        : 010",0
             .DC.b "        CIT. BOGLI IZAE       : 025",0
             .DC.b " ",0
             .DC.b "        TOTAL DEEDS           : 285",0
             .DC.b "        NOT LISTED DEEDS      : 215",0
             .DC.b " - LAST TRANSACTION:",0
             .DC.b "        100 ROYAL TREASURE DEEDS",0
             .DC.b "TO KOSHAN INC. DOCUMENT NO. Y2395.",0
             .DC.b "        DEED VALUE     : 2 BILLION",0
             .DC.b "           CREDITS",0
txcaif1::    
txcaid2::    
             .DC.b " ",0
             .DC.b "KOSHAN INC/ HEAD OFFICE CITY/KOSHAN TOWER",0
             .DC.b "        MANAGER: SENATOR ZAKK KOSHAN",0
             .DC.b " ",0

             .DC.b "MASSIGLIA BANK/ HEAD OFFICE CITY/",0
             .DC.b "CARMENTA TOWER",0
             .DC.b "       MANAGER: EQUITES JULIUS MASSIGLIA",0
             .DC.b "                  OFFICE ON 14TH FLOOR.",0
             .DC.b " ",0

             .DC.b "SEN. JUGH'AHIH/ PLACE OF CONSULTATION",0
             .DC.b "CITY/VERTUMNUS TOWER 34TH FLOOR OFFICE 7B",0
             .DC.b " ",0

             .DC.b "CIT. BOGLI IZAE/ WELCO INC.",0
             .DC.b "HEAD OFFICE CAPREE EMPORIUM SECTOR 2",0
             .DC.b "       MANAGER: CITIZEN IZAE BOGLI",0
txcaif2::    

;---------------------------------------------------------------
;TEXTES BOITE DE CONFIGURATION

;taille libre (dans la limite du raisonnable !!!)

             .IF 0
cfgtx1::     .DC.b "SOUND:",0
cfgtx2::     .DC.b "MUSIC ON",0
cfgtx3::     .DC.b "EFFECTS ON",0
cfgtx4::     .DC.b "MV16",0
cfgtx5::     .DC.b "MONITOR",0
cfgtx6::     .DC.b "COMBATS:",0
cfgtx7::     .DC.b "ARCADE",0
cfgtx8::     .DC.b "STRATEGY",0
cfgtx9::     .DC.b "QUATTRO:",0
cfgtx10::    .DC.b "X MODE",0
cfgtx11::    .DC.b "XY MODE",0
cfgtx12::    .DC.b "SIMULATORS:",0
cfgtx13::    .DC.b "MAX DETAILS",0
cfgtx14::    .DC.b "MIN DETAILS",0
cfgtx15::    .DC.b "AUTO-STAB",0
cfgtx16::    .DC.b "KEYBOARD:",0
cfgtx17::    .DC.b "QWERTY",0
cfgtx18::    .DC.b "AZERTY",0
cfgtx19::    .DC.b "QWERTZ",0
             .ENDIF 

;50 caracteres max, respecter le nombre de lignes


txbobd1::    
             .DC.b " ",0
             .DC.b "<B.O.B SAYS:>",0
             .DC.b " ",0
             .DC.b "THE MEMORY TABLET ANALYSE SHOWED ME",0
             .DC.b "A FEW DEFECTS IN THE MASSIGLIA ",0
             .DC.b "BANK PROTECTION SYSTEM. SO HERE IS WHAT I",0
             .DC.b "THINK IS THE BEST PLAN:",0
             .DC.b " -LAND WITH A SHIP ON THE ROOF OF THE",0
             .DC.b "  CARMENTA TOWER, BUT NOT ON THE LANDING",0
             .DC.b "  PAD (A MAINTENANCE SHIP SEEMS TO BE THE",0
             .DC.b "  MOST LIKELY TO GO UNSUSPECTED).",0
             .DC.b " -FIND AN AXIAL SUCKET SYSTEM TO HANG",0
             .DC.b "  ONTO THE NORTH WALL JUST BELOW THE",0
             .DC.b "  LANDING PAD. THEN USE THE DITROXYL",0
             .DC.b "  PENTRADYNITE TO MAKE A HOLE IN THE WALL,",0
             .DC.b "  MADE OF OZONORE (A STRONG METAL.)",0
             .DC.b " -TO OPEN THE DOOR TO THE CORRIDOR, USE THE",0
             .DC.b "  THE VOICE RETRIEVAL SYSTEM (WITH THE TAPE",0
             .DC.b "  OF MASSIGLIA'S VOICE).",0
             .DC.b " ",0
             .DC.b " ",0
             .DC.b "       <CLICK MOUSE FOR NEXT PAGE>       ",0
txbobf1::    
txbobd2::    
             .DC.b " ",0
             .DC.b " -NEXT, THERE IS AN IMPENETRABLE G RAY",0
             .DC.b "  BARRIER, BUT IT CAN BE SWITCHED OFF",0
             .DC.b "  WITH AN OPTICAL PULSE DETECTOR.",0
             .DC.b "  ALL YOU HAVE TO DO IS TO GIVE THIS MEMORY",0
             .DC.b "  TABLET I HAVE JUST REPROGRAMMED",0
             .DC.b "  TO AN OPTICIAN, SO THAT HE CAN MAKE YOU SOME",0
             .DC.b "  CODING LENSES THAT YOU WILL NEED",0
             .DC.b "  TO GET PAST THE G RAY FIELD.",0
             .DC.b " -THEN YOU JUST HAVE TO MELT THE DOOR OF THE",0
             .DC.b "  SAFE WITH THE DITROXYL PENTRADYNITE.",0
             .DC.b " ",0
             .DC.b "                <END OF ANALYSIS>             ",0
txbobf2::    

txjourd::    
             .DC.b " ",0
             .DC.b " ",0
             .DC.b " ",0
             .DC.b "     EXCERPT FROM ROMA NEWS:    ",0

             .DC.b " ",0
             .DC.b " MURDER IN THE OLD ASHAN DISTRICT.",0
             .DC.b " ",0

             .DC.b "   LAST NIGHT, TWO OR THREE MEN MURDERED",0
             .DC.b "ZIST HONOR, OF THE OZOWH CASTE. HE WAS",0
             .DC.b "A FORMER PAGE TO KING KELEB III AND APPARENTLY",0
             .DC.b "LED AN UNEVENTFUL LIFE. HE WAS HOWEVER",0
             .DC.b "CONSIDERED CRITICAL OF THE NEW",0
             .DC.b "REGIME BUT ACCORDING TO THE INSPECTOR IN CHARGE",0
             .DC.b "OF THE ENQUIRY, HIS DEATH DOES NOT APPEAR TO BE",0
             .DC.b "POLITICALLY MOTIVATED.",0
             .DC.b " ",0

             .DC.b "  THERE IS NO CAUSE FOR ALARM, IT IS CERTAIN",0

             .DC.b "OUR EXCELLENT POLICE FORCE WILL SOON BE ARRESTING",0
             .DC.b "THE MURDERERS, WHO NEVER ROAM OUR CITY FOR LONG...",0
txjourf::    
txbookd1::   
             .DC.b " ",0

             .DC.b "THE BOOK YOU HAVE FOUND IS WRITTEN ENTIRELY",0
             .DC.b "IN SHEDISH AND ENTITLED 'MIS ORENTIS",0
             .DC.b "BEDZAKIL' WHICH BOB TRANSLATES AS MEMOIRS OF A",0
             .DC.b "PAGE. YOU NOTICE THE CORNERS OF TWO PAGES ARE",0
             .DC.b "TURNED DOWN. YOU SHOW BOB THESE PAGES SO IT CAN",0
             .DC.b "ANALYSE THEM. AFTER A FEW MINUTES, BOB HAS GIVEN",0
             .DC.b "YOU THE TRANSLATION:",0
             .DC.b " ",0

             .DC.b "(...) IT WAS WHEN OBSERVING THE GREAT ARCH OF",0
             .DC.b "THE LEVANT THAT MY FRIEND, THE ASTRONOMER MOSES",0
             .DC.b "BANAFOOSH HAD THE MAD IDEA OF EXPLORING BEDHIN 6",0
             .DC.b "TO MINE ITS MINERALS. OUR PLANET'S ECHIATONE",0
             .DC.b "WAS BEGINNING TO DRY UP AND THE RECENT DEPOSITS",0
             .DC.b "FOUND BY HUMANS ON BEDHIN SEEMED TO MARK THE START",0
             .DC.b "OF A NEW ERA OF PROSPERITY FOR THOSE WHO MINED",0
             .DC.b "IT. I HAD TO HELP HIM PREPARE HIS",0
             .DC.b "EXPEDITION BUT I DIDN'T COME WITH HIM; I NEVER",0
             .DC.b "LIKED ADVENTURE AND PERHAPS",0
             .DC.b "I ALREADY HAD A CURIOUS FOREBODING OF THE TRAGIC",0
             .DC.b "OUTCOME OF EVENTS.",0
             .DC.b "I NEVER SAW MY FRIEND AGAIN (...)",0
txbookf1::   
txbookd2::   
             .DC.b " ",0
             .DC.b "I AM NOW CONVINCED THAT THESE HUMANS, SCOUNDRELS",0
             .DC.b "BEARING THE NAME OF KOSHAN, DO NOT HAVE MY FRIEND'S",0
             .DC.b "TITLE DEEDS BECAUSE THE LATEST INFORMATION",0
             .DC.b "MENTIONS 200 DEEDS BELONGING TO THEM,",0
             .DC.b "100 LEGAL DEEDS AND THE 100 WILLED",0
             .DC.b "TO THE ROYAL TREASURE, MY FRIEND AND HIS DEEDS",0
             .DC.b "MUST BE LANGUISHING SOMEWHERE ON THIS",0
             .DC.b "SATELLITE, SO I AM THINKING OF SETTING UP AN",0
             .DC.b "EXPEDITION MYSELF.",0
             .DC.b " ",0

             .DC.b "(...) AN IMMEASURABLE SORROW HAS COME OVER ME",0
             .DC.b "SINCE MY REPUDIATION, AM I MAD, OR IS THE",0
             .DC.b "KING? THE FIRST PAGE TO BE BANISHED",0
             .DC.b "FROM THE ROYAL APPARTMENTS, WHAT A SHAME! HOW CAN",0
             .DC.b "IT BE, HOW COULD THIS KING WHO USED TO PROMISE",0
             .DC.b "ME FREEDOM REPUDIATE A PAGE OF HONOUR,",0
             .DC.b "RESTORE THE SHAMEFUL ANGA SYSTEM,",0
             .DC.b "LEAVE HIS 100 TITLE-DEEDS TO KOSHAN, A BEQUEST OF",0
             .DC.b "200 BILLION CREDITS!!! IS IT ANOTHER TRICK OF",0
             .DC.b "THESE HUMANS? WILL I FIND THE ANSWER",0
             .DC.b "ON BEDHIN 6???",0
txbookf2::   

txpretd::              ;TE
             .DC.b " ",0
             .DC.b " ",0
             .DC.b " ",0
             .DC.b " ",0
             .DC.b "             LIST OF SERVICES",0
             .DC.b " ",0
             .DC.b " ",0
             .DC.b " ",0
             .DC.b "TIERCE TEAM:",0
             .DC.b " ",0
             .DC.b "PRAETOR AGAMEMNUM      : TRIAL OF INGRID KNOWN AS",0
             .DC.b "                           'THE TORNADO'.",0
             .DC.b "PRAETOR SIRIUS AL BAREX: ON ADJOURNMENT OF SITTING.",0
             .DC.b "PRAETOR BONUM CERES    : ACTUA/ZINGFIELD TRIAL.",0
             .DC.b "PRAETOR ADELIA         : KOSHAN/HADFORD TRIAL.",0
             .DC.b "PRAETOR KUBITUS        : ON ADJOURMENT OF SITTING.",0
txpretf::    


;      32 CARACTERES MAXIMUM, LAISSER LE .DC.B 0
gladtx::     
             .DC.b "AVE CAESAR!",0
             .DC.b "THOSE ABOUT TO DIE",0
             .DC.b "SALUTE THEE",0
             .DC.b 0

;ne pas changer la taille
;pv=point de vie
;f=force
;i=intelligence
;r=reflexe
;v=vitalite
;p=perception
;mu=munition
;cp=coefficient de perforation

cpttexte::   
             .DC.b "LP",0
             .DC.b "F ",0
             .DC.b "I ",0
             .DC.b "R ",0
             .DC.b "V ",0
             .DC.b "P ",0
             .DC.b "AM",0
             .DC.b "PC",0

;23 caracteres max

ctexte1::    
             .DC.b "STRIKES AND HITS",0     ;1
             .DC.b "STRIKES AND MISSES",0   ;2
             .DC.b "IS TOO FAR",0           ;3
             .DC.b "RUNS AWAY",0            ;4
             .DC.b "IS DEAD",0              ;5
             .DC.b "WARDS OFF",0            ;6
             .DC.b "IS DISARMED",0          ;7
             .DC.b "SHOOTS AND HITS",0      ;8
             .DC.b "DEFLECT BLOW",0         ;9
             .DC.b "IS OUT OF RANGE",0      ;10
             .DC.b "LIFE",0                 ;8
             .DC.b "INTELLIGENCE",0         ;9
             .DC.b "REFLEX",0               ;10
             .DC.b "FORCE",0                ;10
             .DC.b "HAS NO MORE WEAPONS",0  ;9
             .DC.b "HAS NO MORE PROTECTION",0     ;10
             .DC.b "MISSES THE TARGET",0    ;10

;10 caracteres max

ctexte2::    
             .DC.b "JEHAN",0
             .DC.b "TARGET",0
             .DC.b "AMMUNITION",0
             .DC.b "PROTECTION",0
             .DC.b "ASSOCIATES",0
             .DC.b "ENEMIES",0
ctexte1a::   
             .DC.b "LOSES",0
             .DC.b "POINTS",0
             .EVEN 
combtx::     
             .DC.l cpttexte,ctexte1,ctexte2,ctexte1a


;        TAILLE MAX 11 CARACTERES
cjouer:      
             .DC.b "GAME",0
cpari:       
             .DC.b "BET",0
cabandon:    
             .DC.b "QUIT",0
chors:       
             .DC.b "OUT OF",0
cserv:       
             .DC.b "ORDER",0
ccred:       
             .DC.b "CREDITS",0
cinsu:       
             .DC.b "NOT ENOUGH",0
ccoup:       
;      LAISSER LES 3 " "
             .DC.b "   BLOWS",0
cavan:       
             .DC.b "AHEAD",0
             .EVEN 
chidamtx::   .DC.l cjouer,cpari,cabandon,chors,cserv,ccred,cinsu,ccoup,cavan


;23 caracteres max!!!

; ------------------------------------------
; TEXTE DES LIBRAIRIES
;
afboberr::   
             .DC.b "COMPILATION ERROR",0
             .EVEN 
; ---------------------------------------
anagent::    
             .DC.b "ANALYSIS OF AGENT      ",0
             .EVEN 
anaevi::     
             .DC.b "ANALYSIS OF INDIVIDUAL ",0
             .EVEN 
; ---------------------------------------
tab_dar::    
             .DC.l rythb,rythm,rythn
rythb::      
             .DC.b "FAST HEARTBEAT         ",0
             .EVEN 
rythm::      
             .DC.b "SLOW HEARTBEAT         ",0
             .EVEN 
rythn::      
             .DC.b "NORMAL HEARTBEAT       ",0
             .EVEN 
; ---------------------------------------
tab_dap::    .DC.l pressb,pressm,pressn
pressb::     
             .DC.b "HIGH BLOOD FLOW        ",0
             .EVEN 
pressm::     
             .DC.b "LOW BLOOD FLOW         ",0
             .EVEN 
pressn::     
             .DC.b "NORMAL BLOOD FLOW      ",0
             .EVEN 
; ---------------------------------------
tab_dat::    
             .DC.l tempb,tempm,tempn
tempb::      
             .DC.b "HIGH TEMPERATURE       ",0
             .EVEN 
tempm::      
             .DC.b "LOW TEMPERATURE        ",0
             .EVEN 
tempn::      
             .DC.b "NORMAL TEMPERATURE     ",0
             .EVEN 
; ---------------------------------------
tab_dae::    
             .DC.l etatb,etatm,etatn
etatb::      
             .DC.b "GOOD CONDITION         ",0
             .EVEN 
etatm::      
             .DC.b "CRITICAL CONDITION     ",0
             .EVEN 
etatn::      
             .DC.b "NORMAL CONDITION       ",0
             .EVEN 
; ---------------------------------------
tab_daf::    
             .DC.l afaim,asoif,afatigue
afaim::      
             .DC.b "HE'S HUNGRY            ",0
             .EVEN 
asoif::      
             .DC.b "HE'S THIRSTY           ",0
             .EVEN 
afatigue::   
             .DC.b "HE'S TIRED             ",0
             .EVEN 
; ---------------------------------------
tab_das::    
             .DC.l atsg,atsf,atsn
             .DC.l fibg,fibf,fibn
             .DC.l hypg,hypf,hypn
             .DC.l morg,morf,morn
             .DC.l psyg,psyf,psyn
atsg::       
             .DC.b "HIGH ATS 34 LEVEL      ",0
             .EVEN 
atsf::       
             .DC.b "LOW ATS 34 LEVEL       ",0
             .EVEN 
atsn::       
             .DC.b "NORMAL ATS 34 LEVEL    ",0
             .EVEN 
fibg::       
             .DC.b "HIGH FIBRINE LEVEL     ",0
             .EVEN 
fibf::       
             .DC.b "LOW FIBRINE LEVEL      ",0
             .EVEN 
fibn::       
             .DC.b "NORMAL FIBRINE LEVEL   ",0
             .EVEN 
hypg::       
             .DC.b "HIGH HYPERCEP LEVEL    ",0
             .EVEN 
hypf::       
             .DC.b "LOW  HYPERCEP LEVEL    ",0
             .EVEN 
hypn::       
             .DC.b "NORMAL HYPERCEP LEVEL  ",0
             .EVEN 
morg::       
             .DC.b "HIGH MORPHO LEVEL      ",0
             .EVEN 
morf::       
             .DC.b "LOW MORPHO LEVEL       ",0
             .EVEN 
morn::       
             .DC.b "NORMAL MORPHO LEVEL    ",0
             .EVEN 
psyg::       
             .DC.b "HIGH PSY LEVEL         ",0
             .EVEN 
psyf::       
             .DC.b "LOW PSY LEVEL          ",0
             .EVEN 
psyn::       
             .DC.b "NORMAL PSY LEVEL       ",0
             .EVEN 
; ---------------------------------------
tab_dac::    
             .DC.l forceg,forcef,forcen
             .DC.l intelg,intelf,inteln
             .DC.l vitag,vitaf,vitan
             .DC.l percg,percf,percn
             .DC.l reflg,reflf,refln
             .DC.l charig,charif,charin
forceg::     
             .DC.b "HIGH FORCE",0
             .EVEN 
forcef::     
             .DC.b "LOW FORCE ",0
             .EVEN 
forcen::     
             .DC.b "NORMAL FORCE",0
             .EVEN 
intelg::     
             .DC.b "HIGH INTELLIGENCE",0
             .EVEN 
intelf::     
             .DC.b "LOW INTELLIGENCE",0
             .EVEN 
inteln::     
             .DC.b "NORMAL INTELLIGENCE",0
             .EVEN 
vitag::      
             .DC.b "HIGH VITALITY",0
             .EVEN 
vitaf::      
             .DC.b "LOW VITALITY",0
             .EVEN 
vitan::      
             .DC.b "NORMAL VITALITY",0
             .EVEN 
percg::      
             .DC.b "HIGH PERCEPTION",0
             .EVEN 
percf::      
             .DC.b "LOW PERCEPTION",0
             .EVEN 
percn::      
             .DC.b "NORMAL PERCEPTION",0
             .EVEN 
reflg::      
             .DC.b "HIGH REFLEX",0
             .EVEN 
reflf::      
             .DC.b "LOW REFLEX",0
             .EVEN 
refln::      
             .DC.b "NORMAL REFLEX",0
             .EVEN 
charig::     
             .DC.b "HIGH CHARISMA",0
             .EVEN 
charif::     
             .DC.b "LOW CHARISMA",0
             .EVEN 
charin::     
             .DC.b "NORMAL CHARISMA",0
             .EVEN 
; ---------------------------------------

;taille libre, laisser les 00

txheure::    .DC.b "IT IS"
txhh::       .DC.b "00 H "
txhm::       .DC.b "00 O'CLOCK",0
bobalerte::  .DC.b "WATCH OUT!",0

             .EVEN 

;ne pas changer la taille!!!

ch_carac::   
             .DC.b 'FORCE         : '
             .DC.b '000',0
             .DC.b 'INTELLIGENCE  : '
             .DC.b '000',0
             .DC.b 'VITALITY      : '
             .DC.b '000',0
             .DC.b 'PERCEPTION    : '
             .DC.b '000',0
             .DC.b 'REFLEX        : '
             .DC.b '000',0
             .DC.b 'CHARISMA      : '
             .DC.b '000',0
             .DC.b 'EXPERIENCE    : '
             .DC.b '000',0
             .DC.b 'PROGRESSION   : '
             .DC.b ' 00',0
ch_bio::     
             .DC.b 'ATS 34      (S1)',0,0
             .DC.b 'FIBRINE     (S2)',0,0
             .DC.b 'HYPERCEP    (S3)',0,0
             .DC.b 'MORPHO L7   (S4)',0,0
             .DC.b 'PSY         (S5)',0,0
             .DC.b '      EXIT      ',0,0
ch_sante::   
             .DC.b 'EXIT',0,0
             .DC.b 'DIAGNOSIS',0,0
             .DC.b '#',0
             .DC.b '$',0
             .DC.b '%',0
             .DC.b '&',0
             .DC.b '+',0
             .DC.b '-',0
             .DC.b '@',0
; affichage pour le diagnostic
; "**" = changement de couleur
ch_diag::    
             .DC.b '  TEMPERATURE: '
             .DC.b '00  C ',0
             .DC.b '  PRESSURES  : '
             .DC.b '00.00 ',0
             .DC.b '  $#$#$#$#$#-$#$#$#$#',0
             .DC.b '  BODY STATE:        ',0
             .DC.b '**                   ',0
             .DC.b '  $#$#$#$#$#-$#$#$#$#',0
             .DC.b '  EAT                ',0
             .DC.b '  DRINK              ',0
             .DC.b '  SLEEP              ',0
             .DC.b '  MEDICATE           ',0
             .DC.b '                     ',0
             .DC.b '                     ',0
ch_etat::    
             .DC.b '  DANGER            '
             .DC.b '  CRITICAL          '
             .DC.b '  WORRYING          '
             .DC.b '  NORMAL            '
ch_prog::    
             .DC.b ' EXIT  ',0
             .DC.b ' NEW   ',0
             .DC.b '#',0
             .DC.b '$',0
             .DC.b '%',0
             .DC.b '&',0
             .DC.b 'DO ',0                  ; +24
             .DC.b 'IF ',0
             .DC.b '   RUNNING ',0
             .DC.b '    ERROR  ',0
             .DC.b ' JOIN  ',0
             .DC.b ' DEL   ',0
ch_nom_icone::         
             .DC.b '       ',0
             .DC.b 'DISPLAY',0
             .DC.b 'WARN   ',0
             .DC.b 'INC    ',0
             .DC.b 'DEC    ',0
             .DC.b 'ANALYSE',0
             .DC.b 'ME     ',0
             .DC.b 'HUMAN  ',0
             .DC.b 'FORCE  ',0
             .DC.b 'INTELL.',0
             .DC.b 'VITAL. ',0
             .DC.b 'PERCEP.',0
             .DC.b 'REFLEX ',0
             .DC.b 'CHARISM',0
             .DC.b 'HUNGER ',0
             .DC.b 'THIRST ',0
             .DC.b 'FATIGUE',0
             .DC.b 'STATE  ',0
             .DC.b 'TEMP.  ',0
             .DC.b 'PRESS. ',0
             .DC.b 'ATS 34 ',0
             .DC.b 'FIBRINE',0
             .DC.b 'HYPERCP',0
             .DC.b 'MORPHO ',0
             .DC.b 'PSY    ',0
             .DC.b '       ',0

             .DC.b 'HOUR   ',0
             .DC.b 'RHYTHM ',0
             .DC.b 'HIGHER ',0
             .DC.b 'LOWER  ',0
             .DC.b 'NORMAL ',0
             .DC.b 'AGGRESS',0
             .DC.b 'ALARM  ',0
             .DC.b 'SHEDISH',0
             .DC.b 'TRANS. ',0
             .DC.b '       ',0
; textes de la boite de dialogue
dbafoui::    
             .DC.b 'YES',0
dbafnon::    
             .DC.b 'NO',0
dbafconf::   
             .DC.b 'CONFIRMATION',0,0
; textes de la boite d'alarme
alarmaf::    
             .DC.b '   ALARM    ',0,0
             .DC.b '      :     ',0,0
             .DC.b '  % %   % % ',0,0
             .DC.b '  & &   & & ',0,0
             .DC.b '    EXIT    ',0,0


;---------------------------------------------------------------
;                      textes pour OBJINFO
;---------------------------------------------------------------
; 12 caracteres maximum

oit1::       .DC.b "NOMINAL",0
oit2::       .DC.b "EQUIPMENT",0
oit3::       .DC.b "VALUE: ",0              ;XX

oit4::       .DC.b "CALL",0
oit5::       .DC.b "NUMBER:",0              ;XXXX
oit6::       .DC.b "LAST",0
oit7::       .DC.b "NUMBER: ",0             ;XXXX

oit8::       .DC.b "BLANK TAPE",0
oit9::       .DC.b "RECORDED",0
oit10::      .DC.b "TAPE",0

oit11::      .DC.b "EQUIVALENT",0
oit12::      .DC.b "WATER: ",0
oit13::      .DC.b "ALCOHOL: ",0
oit14::      .DC.b " GRAMMES",0

oit15::      .DC.b "PROGRAMMED",0
oit16::      .DC.b "FOR BANK",0
oit17::      .DC.b "PLAN",0
oit18::      .DC.b "PROGRAMMED",0
oit19::      .DC.b "FOR",0
oit20::      .DC.b "MAKING",0
oit21::      .DC.b "CODER LENS",0

oit22::      .DC.b "PERFORATION",0
oit23::      .DC.b "COEF.:",0
oit24::      .DC.b "NUMBER OF",0
oit25::      .DC.b "BLOWS: ",0              ;XXXX

oit26::      .DC.b "RANGE: ",0              ;XXXX
oit27::      .DC.b "STATE:",0
oit28::      .DC.b "OUT OF ORDER",0
oit29::      .DC.b "POOR",0
oit30::      .DC.b "MED.",0
oit31::      .DC.b "GOOD",0
oit32::      .DC.b "NEW",0

oit33::      .DC.b "BAL.:",0
oit34::      .DC.b "CRED.",0                ;XXXXXX

oit35::      .DC.b " DEEDS",0

oit36::      .DC.b "ENERGY",0
oit37::      .DC.b "VALUE:",0
oit38::      .DC.b " KCAL",0

aa1::        .DC.b "PRICE:",0
             .EVEN 
aa2::        .DC.b "CONTENTS:",0
             .EVEN 


;40 caracteres max!!!!


;--------- TEXTE DANS LES PUITS DE BANAFOOSH  ----------
;7 lignes
banafoosh::  
             .DC.b "YOU HAVE FOUND BANAFOOSH'S",0
             .DC.b "DWELLING.",0
             .DC.b "IN HIS SURVIVAL CONTAINER,",0
             .DC.b "YOU FIND THE MISSING 100 TITLE-DEEDS:",0
             .DC.b "YOU CAN NOW RETURN TO",0
             .DC.b "SHEDISHAN AND",0
             .DC.b "MEET THE PRAETOR.",0
;--------- TEXTE DE LA FIN DE LA 1ERE PARTIE  ----------
;"****************************************"
;  24 lignes
txpartie1::  
             .DC.b "AS YOU LEAVE YOUR SHIP",0
             .DC.b "AT ROMA II ASTROPORT,",0
             .DC.b "YOU ARE STOPPED AND THEN",0
             .DC.b "ARRESTED BY THE CATAPHRACTAIRES.",0
             .DC.b "YOU ARE IMMEDIATELY IMPRISONED",0
             .DC.b "WITH NO EXPLANATION...",0
             .DC.b "AFTER A FEW DAYS, YOU ARE TAKEN",0
             .DC.b "TO THE AUDIENCE CHAMBER,",0
             .DC.b "TO BE TRIED.",0
             .DC.b "YOU ARE ACCUSED OF THE MURDER",0
             .DC.b "OF SYLVIA HARFORD,",0
             .DC.b "FOUND STRANGLED AT MANTOUE MANOR.",0
             .DC.b "THE EVIDENCE (YOU HAVE OF COURSE BEEN",0
             .DC.b "FRAMED) IS IRREFUTABLE.",0
             .DC.b "AFTER A DISASTROUS PARODY OF A TRIAL",0
             .DC.b "YOU ARE SENTENCED TO TEN YEARS HARD LABOUR",0
             .DC.b "WHERE YOU HAVE TO FIGHT IN",0
             .DC.b "THE ARENA TO SURVIVE.",0
             .DC.b "YOUR ONLY HOPE IS",0
             .DC.b "TO BE BETTER THAN THE OTHER",0
             .DC.b "FIGHTERS (THE TECHNOGLADS) AND BECOME",0
             .DC.b "THE IDOL OF THE CROWD,",0
             .DC.b "TO HAVE A CHANCE (PERHAPS)",0
             .DC.b "OF BEING PARDONED BY THE KING...",0


;--------- TEXTES DE LA FIN DE LA 2EME PARTIE  ----------
;"****************************************"
; 18 lignes
partie2a::   
             .DC.b "YOUR POPULARITY IS AT ITS HEIGHT,",0
             .DC.b "AS LAID DOWN BY LAW, YOU ARE",0
             .DC.b "PRESENTED TO THE KING FOR PARDON BUT",0
             .DC.b "TO YOUR SURPRISE,",0
             .DC.b "HE OBSTINATELY REFUSES TO DO IT.",0
             .DC.b "YOU BECOME DESPERATE, AND",0
             .DC.b "PLUNGE A PAIN STICK",0
             .DC.b "INTO HIS STOMACH AT MAXIMUM CHARGE,",0
             .DC.b "AND INSTEAD OF A CRY OF PAIN, THERE",0
             .DC.b "IS A SMALL",0
             .DC.b "EXPLOSION.",0
             .DC.b "AN ICY SILENCE FOLLOWS.",0
             .DC.b "THE KING LYING DEAD BEFORE YOU",0
             .DC.b "IS NOT LIKE OTHER KINGS,",0
             .DC.b "HE IS ONLY A MACHINE, A BUNDLE OF",0
             .DC.b "WIRES AND CIRCUITS, A SHEDROID!!!",0
             .DC.b "JUST THEN, YOU LOSE CONSCIOUSNESS AS",0
             .DC.b "A GUARD HITS YOU OVER THE HEAD",0
partie2b::   
; 1 ligne
             .DC.b "LATER...",0             ; texte milieu
; 144 lignes
partie2c::   
             .DC.b "YOU WAKE UP, AND",0
             .DC.b "INSTEAD OF BEING IN A DARK",0
             .DC.b "SORDID PRISON, YOU ARE",0
             .DC.b "LYING IN A LUXURIOUS ROOM,",0
             .DC.b "ON A BED COVERED WITH SHEETS",0
             .DC.b "WHICH SEEM TO BE SATIN...",0
             .DC.b "SHORTLY, A DOOR OPENS",0
             .DC.b "AND A CURIOUSLY DRESSED SHEDISH",0
             .DC.b "COMES AND SITS DOWN IN THE ROOM",0
             .DC.b "NEAR YOUR BED.",0
             .DC.b "'BAL'AMAYE EQUITES MENASIS,",0
             .DC.b "DO NOT MOVE,",0
             .DC.b "YOU ARE STILL SHAKEN UP.",0
             .DC.b "DON'T WORRY, YOU ARE SAFE HERE,",0
             .DC.b "IN THE PALACE. YOU HAVE BEEN",0
             .DC.b "UNCONSCIOUS FOR FIVE DAYS",0
             .DC.b "AND WE WERE VERY WORRIED ABOUT YOU!",0
             .DC.b " ",0

             .DC.b "MUCH HAS HAPPENED",0
             .DC.b "SINCE YOUR ... REGRETABLE ACCIDENT...",0
             .DC.b "FIRST I MUST EXPLAIN",0
             .DC.b "THAT YOU ARE CONSIDERED A HERO,",0
             .DC.b "YOU ARE THE MAN WHO UNMASKED",0
             .DC.b "THE INCREDIBLE CONSPIRACY.",0
             .DC.b "THE PLOT WAS IMAGINED BY MEN",0
             .DC.b "FROM KOSHAN TO GET HOLD OF",0
             .DC.b "ALL THE ROYAL TITLE-DEEDS ON",0
             .DC.b "BEDIHN 6 SO THAT THE POWER OF THE",0
             .DC.b "KING COULD NEVER STAND IN THE WAY",0
             .DC.b "OF THEIR AMBITIONS.",0
             .DC.b "I FELT THE SAME WAY",0
             .DC.b "AS HIS CLOSE FRIENDS,",0
             .DC.b "THAT THE KING'S ATTITUDE HAD RADICALLY",0
             .DC.b "CHANGED LATELY,",0
             .DC.b "BUT NOBODY EVER SUSPECTED THAT HE",0
             .DC.b "WAS ONLY A COMMON MACHINE,",0
             .DC.b "A DROID!!!",0
             .DC.b "I SHOULDN'T LIKE TO PRAISE KOSHAN,",0
             .DC.b "BUT THEY DID A GOOD JOB,",0
             .DC.b "THE LIKENESS WAS PERFECT...",0
             .DC.b "OH, PLEASE EXCUSE MY MANNERS",0
             .DC.b "I AM BOODISH ANAMEEH,",0
             .DC.b "I AM HEAD OF THE RELIGIOUS ORDERS",0
             .DC.b "ON SHEDISHAN AND FOR THE MOMENT,",0
             .DC.b "I AM ALSO HANDLING POLITICAL LIFE.",0
             .DC.b "OTHER THINGS HAVE BEEN HAPPENING,",0
             .DC.b "I THINK YOUR COMPATRIOTS",0
             .DC.b "WOULD CALL IT A 'REVOLUTION'.",0
             .DC.b "YOUR SENATE HAS CEASED TO",0
             .DC.b "EXIST: ON THE KING'S DEATH,",0
             .DC.b "THERE WAS A POPULAR UPRISING,",0
             .DC.b "HUMANS AND SHEDISH ATTACKED",0
             .DC.b "THE GOVERNMENT",0
             .DC.b "AND KOSHAN, I HAD A LOT OF TROUBLE",0
             .DC.b "CALMING THINGS DOWN.",0
             .DC.b "THINGS ARE BETTER NOW.",0
             .DC.b "THE BAD NEWS FOR YOUR",0
             .DC.b "INTERESTS ON BEDIHN 6 IS THAT",0
             .DC.b "OLD ZAKK KOSHAN IS STILL ALIVE,",0
             .DC.b "HE IS EVEN RUNNING HIS COMPANY",0
             .DC.b "BY A CLEVER STRATAGEM",0
             .DC.b "WHICH HE IS MASTER OF",0
             .DC.b "HE MANAGED TO FIND A SCAPEGOAT",0
             .DC.b "IN THE PERSON OF HIS RIGHT HAND MAN:",0
             .DC.b "ANGUS BOOMAKER. AT THE TRIAL",0
             .DC.b "WE RAN TO CHARGE HIM,",0
             .DC.b "WE COULDN'T  BREAK HIS DEFENCE",0
             .DC.b "AND IT WOULD HAVE BEEN TOO",0
             .DC.b "DANGEROUS TO EXECUTE HIM WITHOUT",0
             .DC.b "PROOF WITH TENSION RUNNING SO",0
             .DC.b "HIGH NOW...",0
             .DC.b "NOW I'LL TELL YOU THE BIGGEST NEWS,",0
             .DC.b "UNDER SHEDISH LAW YOU CAN IF YOU",0
             .DC.b "WISH BECOME KING OF SHEDISHAN",0
             .DC.b "OR APPOINT A SUCCESSOR. I MUST",0
             .DC.b "URGE YOU TO CONSIDER CAREFULLY,",0
             .DC.b "FOR THE FUTURE OF OUR PEOPLE...",0
             .DC.b "NOW I SHALL LET YOU REST,",0
             .DC.b "HERE YOU HAVE",0
             .DC.b "EVERYTHING YOU NEED, INCLUDING",0
             .DC.b "YOUR PERSONAL BELONGINGS, FOUND",0
             .DC.b "IN A HOTEL IN THE TOURIST DISTRICT...",0
             .DC.b "MOSH ID'AL FAROUM'",0
             .DC.b " ",0

             .DC.b "SHORTLY AFTER THE SHEDISH LEFT,",0
             .DC.b "THE BAT RELAY NETWORK COMES TO LIFE",0
             .DC.b "AND A 3D HOLOGRAM",0
             .DC.b "APPEARS, IT SAYS:",0
             .DC.b " ",0
             .DC.b "'WE ALREADY HAVE AN AGENT READY",0
             .DC.b "ON SHEDISHAN TO REPLACE",0
             .DC.b "YOU ON THE THRONE, LUCKILY,",0
             .DC.b "WE PLANNED FOR THIS POSSIBILITY.",0
             .DC.b "YOU MUST ABDICATE AND LEAVE HIM THE",0
             .DC.b "THRONE BUT YOUR MISSION IS NOT OVER...",0
             .DC.b " ",0
             .DC.b "KOSHAN IS STILL OPERATING,",0
             .DC.b "THEY STILL HAVE THE MONOPOLY ON",0
             .DC.b "ECHIATONE,",0
             .DC.b "YOU MUST ELIMINATE IT AT ALL COSTS...",0
             .DC.b "HERE IS OUR PLAN:",0
             .DC.b "WRITE YOUR ABDICATION AND PUT IT IN AN",0
             .DC.b "ENVELOPE ADDRESSED TO",0
             .DC.b "THIS BOODISH, INCIDENTALLY EXPLAIN",0
             .DC.b "YOUR SUSPICIONS ABOUT KOSHAN,",0
             .DC.b "SAY YOUR LIFE IS IN DANGER...",0
             .DC.b "OUR AGENT WHO WILL BE KING WILL",0
             .DC.b "PROVIDE A CONTRACT IN YOUR NAME.",0
             .DC.b "A HIRED KILLER HAS BEEN CONTACTED",0
             .DC.b "TO KILL YOU, HE THINKS IT",0
             .DC.b "WAS KOSHAN WHO HIRED HIM.",0
             .DC.b "WHEN SIED ASHAR, OUR SHEDISH AGENT",0
             .DC.b "IS THERE,",0
             .DC.b "YOU CAN LEAVE FOR THE CITY.",0
             .DC.b "YOU MUST GO TO THE KOSHAN",0
             .DC.b "BUILDING TONIGHT AND PLACE THE",0
             .DC.b "FAKE CONTRACT IN ZAKK KOSHAN'S PERSONAL",0
             .DC.b "SAFE. OUR KILLER HAS",0
             .DC.b "THE SAME CONTRACT, SO IT WILL BE",0
             .DC.b "EASY FOR US AFTERWARDS TO CATCH THAT",0
             .DC.b "RAT KOSHAN.",0
             .DC.b "MAKE SURE THE WHOLE POPULATION",0
             .DC.b "COMES TO YOUR ABDICATION CEREMONY,",0
             .DC.b "YOUR DEATH MUST BE A GREAT EVENT.",0
             .DC.b "MAKE A SPEECH IN PRAISE OF THE PEOPLE,",0
             .DC.b "THAT IS WHEN",0
             .DC.b "THE KILLER WILL STRIKE, IN FRONT OF",0
             .DC.b "EVERYONE.",0
             .DC.b "ONCE YOU ARE DEAD,",0
             .DC.b "ASHAR WILL SEND HIS SLINGERS",0
             .DC.b "TO SEARCH THE KOSHAN OFFICES. THIS TIME",0
             .DC.b "HE WON'T BE ABLE TO WRIGGLE OUT OF IT,",0
             .DC.b "ASHAR WILL MAKE SURE OF THAT.",0
             .DC.b "AT LAST,",0
             .DC.b "GET SOME GOOD PROTECTIVE CLOTHING",0
             .DC.b "BECAUSE YOU HAVE TO PRETEND TO DIE.",0
             .DC.b "IF IT'S ANY CONSOLATION,",0
             .DC.b "HEROES ARE ALWAYS",0
             .DC.b "GIVEN A MAGNIFICENT FUNERAL...",0
             .DC.b "GOOD LUCK.",0
             .DC.b "SHORTLY AFTERWARDS, ASHAR",0
             .DC.b "COME TO GIVE YOU THE FAKE",0
             .DC.b "CONTRACT",0
             .DC.b "THE ADVENTURE CONTINUES...",0
;--------- TEXTE DES OBSEQUES  ----------
;"****************************************"
; 36 lignes
obseques::   
             .DC.b "PRESS RELEASE ON ROMA NEWS:",0
             .DC.b "(...) THE FUNEARAL",0
             .DC.b "OF NATIONAL HERO JEHAN MENASIS TOOK",0
             .DC.b "PLACE AMID GENERAL DISMAY.",0
             .DC.b "ALL FACES,",0
             .DC.b "SHEDISH AND HUMAN,",0
             .DC.b "DISPLAYED UNPARALLELED SADNESS",0
             .DC.b "BUT LET US REMIND OUR LISTENERS",0
             .DC.b "OF YESTERDAY'S DRAMATIC",0
             .DC.b "EVENTS.",0
             .DC.b "YESTERDAY, BEFORE",0
             .DC.b "A MASSIVE CROWD OF PEOPLE",0
             .DC.b "CALLED OUT BY THE PERSON WHO WAS ALREADY BEING",0
             .DC.b "CALLED JEHAN THE GREAT,",0
             .DC.b "A HEINOUS CRIME WAS COMMITTED",0
             .DC.b "JUST AS HE WAS PREPARING TO ABDICATE IN",0
             .DC.b "FAVOUR OF ASHAR THE FIRST",0
             .DC.b "MORTALLY WOUNDING HIM.",0
             .DC.b "THE ASSASSIN WAS QUICKLY CAUGHT",0
             .DC.b "AND IT DID NOT TAKE LONG FOR THE",0
             .DC.b "NEW LAW ENFORCEMENT AGENCY SET UP BY OUR",0
             .DC.b "EXCELLENT BECHIR TO INCRIMINATE",0
             .DC.b "THE DETESTABLE KOSHAN,",0
             .DC.b "ALREADY IMPLICATED IN THE RECENT",0
             .DC.b "CONSPIRACY SCANDAL...",0
             .DC.b "THE ASSASSIN ADMITED BEING IN",0
             .DC.b "CONTACT WITH KOSHAN, A CONTRACT",0
             .DC.b "HAS EVEN BEEN FOUND IN KOSHAN'S",0
             .DC.b "OWN SAFE...",0
             .DC.b "ALL KOSHAN'S ASSETS HAVE BEEN SEIZED",0
             .DC.b "BY THE STATE.",0
             .DC.b "ZAKK KOSHAN WAS APPREHENDED THIS",0
             .DC.b "MORNING WHILE TRYING",0
             .DC.b "TO FLEE THE PLANET.",0
             .DC.b "HIS TRIAL WILL BE HELD AT THE NEXT",0
             .DC.b "CALENDS (...)",0

;--------- TEXTE DE LA DERNIERE IMAGE  ----------
txtfin::     
             .DC.b "TO BE CONTINUED...",0

txglad1::    
             .DC.b "YOU MUST TRAIN TO BECOME",0
             .DC.b "A TECHNOGLAD CAPABLE OF STAYING",0
             .DC.b "ALIVE IN THE ARENA.",0
             .DC.b "YOU MUST FIGHT THE MYRMIDROID,",0
             .DC.b "A ROBOT SPECIALLY DESIGNED",0
             .DC.b "FOR YOUR TRAINING,",0
             .DC.b "YOU WILL NOT BE A TRUE TECHNOGLAD",0
             .DC.b "UNTIL YOU HAVE",0
             .DC.b "BEATEN IT.",0
txglad2::    
             .DC.b "IT IS THE BIG DAY OF THE GAMES!",0
             .DC.b "STAND UP TO THE TECHNOGLADS IN",0
             .DC.b "THE ROMA II ARENA.",0
             .DC.b "SAMMITES, RETIAIRES AND THRACE",0
             .DC.b "WILL MAKE IT HARD WORK FOR YOU",0
             .DC.b "BUT VICTORY AND POPULARITY",0
             .DC.b "ARE THE ONLY GATEWAYS",0
             .DC.b "TO FREEDOM!!!",0
             .EVEN 


;---------------------------------------------------------------
;---------------------------------------------------------------
;---------------------------------------------------------------
txboi86::    .DC.b " ",0
txboi87::    .DC.b "   PLACEZ VOTRE    ",0
txboi88::    .DC.b "   DISQUETTE 3/5   ",0
txboi89::    .DC.b " DANS LE LECTEUR B ",0



;videophone 15 caracteres max

videotx0::   .DC.b "NUMERO: ",0             ;XXXX
videotx1::   .DC.b "PAS DE REPONSE ",0
videotx2::   .DC.b "   OCCUPE...   ",0


scparv0::    .DC.b "  <ESPACE LIBRE  1>",0
scparv1::    .DC.b "  <ESPACE LIBRE  2>",0
scparv2::    .DC.b "  <ESPACE LIBRE  3>",0
scparv3::    .DC.b "  <ESPACE LIBRE  4>",0
scparv4::    .DC.b "  <ESPACE LIBRE  5>",0
scparv5::    .DC.b "  <ESPACE LIBRE  6>",0
scparv6::    .DC.b "  <ESPACE LIBRE  7>",0
scparv7::    .DC.b "  <ESPACE LIBRE  8>",0
scparv8::    .DC.b "  <ESPACE LIBRE  9>",0
scparv9::    .DC.b "  <ESPACE LIBRE 10>",0

scpar0::     .DC.b "      PARTIE  1",0
scpar1::     .DC.b "      PARTIE  2",0
scpar2::     .DC.b "      PARTIE  3",0
scpar3::     .DC.b "      PARTIE  4",0
scpar4::     .DC.b "      PARTIE  5",0
scpar5::     .DC.b "      PARTIE  6",0
scpar6::     .DC.b "      PARTIE  7",0
scpar7::     .DC.b "      PARTIE  8",0
scpar8::     .DC.b "      PARTIE  9",0
scpar9::     .DC.b "      PARTIE 10",0


mainmtx7::   .DC.b "PASSER 1 HEURE",0



;              .DC.b "A L'ASTROPORT DE ROMA II,",0
;             .DC.b "EN DESCENDANT DE VOTRE VAISSEAU,",0
;            .DC.b "VOUS ETES INTERPELLE PUIS",0
;           .DC.b "ARRETE PAR DES CATAPHRACTAIRES.",0

;remplace par !!!!!!!!!!!!!!!!!!!!!!

;              .DC.b "A L'ASTROPORT DE ROMA II,",0
;             .DC.b "VOUS ETES INTERPELLE PUIS",0
;            .DC.b "ARRETE PAR DES CATAPHRACTAIRES.",0
;           .DC.b " ",0


cfgtx1::     .DC.b "SON:",0
cfgtx2::     .DC.b "ON",0
cfgtx3::     .DC.b "OFF",0
cfgtx4::     .DC.b "MV16",0
cfgtx5::     .DC.b "MONITEUR",0
cfgtx6::     .DC.b "COMBATS:",0
cfgtx7::     .DC.b "ARCADE",0
cfgtx8::     .DC.b "STRATEGIE",0
cfgtx9::     .DC.b "QUATTRO:",0
cfgtx10::    .DC.b "MODE X",0
cfgtx11::    .DC.b "MODE XY",0
cfgtx12::    .DC.b "SIMULATEURS:",0
cfgtx13::    .DC.b "DETAILS MAX",0
cfgtx14::    .DC.b "DETAILS MIN",0
cfgtx15::    .DC.b "AUTO-STABILISATION",0
cfgtx16::    .DC.b "CLAVIER:",0
cfgtx17::    .DC.b "QWERTY",0
cfgtx18::    .DC.b "AZERTY",0
cfgtx19::    .DC.b "QWERTZ",0



