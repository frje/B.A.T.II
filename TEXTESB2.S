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
sujet2::     .DC.b "SECTEUR TOURISTIQUE",0
sujet3::     .DC.b "SECTEUR INDUSTRIEL",0
sujet4::     .DC.b "SECTEUR SUD",0
sujet5::     .DC.b "SECTEUR D'ASHAN",0
sujet6::     .DC.b "SECTEUR NORD",0
sujet7::     .DC.b "CITE",0
sujet8::     .DC.b "TOUR VERTUMNUS",0
sujet9::     .DC.b "RESTITUEUR VOCAL",0
sujet10::    .DC.b "FAUSSE CARTE/PRETEUR",0
sujet11::    .DC.b "SOCIETE WELCO",0
sujet12::    .DC.b "AXIAL A VENTOUSES",0
sujet13::    .DC.b "DITROXYL PENTRADINITE",0
sujet14::    .DC.b "TOUR KOSHAN",0
sujet15::    .DC.b "TOUR CARMENTA",0
sujet16::    .DC.b "TOUR MINERVA",0
sujet17::    .DC.b "TRIBUNAL DES PRETEURS",0
sujet18::    .DC.b "BANQUE MASSIGLIA",0
sujet19::    .DC.b "SENATEUR JUGH'AHIH",0
sujet20::    .DC.b "ZIST HONOR",0
sujet21::    .DC.b "VETEMENTS DE PRETEUR",0
sujet22::    .DC.b "BEDIHN 6",0
sujet23::    .DC.b "FOREUSE",0
sujet24::    .DC.b "STATION SPATIALE",0
sujet25::    .DC.b "PRISON DE ROMA II",0
sujet26::    .DC.b "VERRE DE CONTACT CODEUR",0
sujet27::    .DC.b "LAISSEZ-PASSER RX",0
sujet28::    .DC.b "LAISSEZ-PASSER TA",0
sujet29::    .DC.b "LAISSEZ-PASSER A",0
sujet30::    .DC.b "CARTE D'ACCES AU CAI",0
sujet31::    .DC.b "BANDE POUR RESTITUEUR",0
sujet32::    .DC.b "BOMBUZAL",0

;---------------------------------------------------------------
;---------------------------------------------------------------
;---------------------------------------------------------------
;                      MENUS
;---------------------------------------------------------------
;---------------------------------------------------------------
;---------------------------------------------------------------

;14 caracteres max !!!

mainmtx0::   .DC.b "CHARGER PARTIE",0
mainmtx1::   .DC.b "SAUVER PARTIE",0
mainmtx2::   .DC.b "INVENTAIRE",0
mainmtx3::   .DC.b "CONFIGURATION",0
mainmtx4::   .DC.b "DORMIR",0
mainmtx5::   .DC.b "PAUSE",0
mainmtx6::   .DC.b "VIDEOPHONE",0


intertx::    .DC.b " INTERPEL.",0

intertx0::   .DC.b "DISCUTER",0
intertx1::   .DC.b "DONNER",0
intertx2::   .DC.b "ENROLER",0
intertx3::   .DC.b "ACHETER",0
intertx4::   .DC.b "VENDRE",0
intertx5::   .DC.b "VOLER",0
intertx6::   .DC.b "COMBATTRE",0
txprix0::    .DC.b "000000 CRED",0
txprix1::    .DC.b "000000 CRED",0
txprix2::    .DC.b "000000 CRED",0
txprix3::    .DC.b "000000 CRED",0
txprix4::    .DC.b "000000 CRED",0
txprix5::    .DC.b "000000 CRED",0
txprix6::    .DC.b "000000 CRED",0

grouptx::    .DC.b "   GROUPE",0


;22 caracteres max

grouptx0::   .DC.b "TROUVER UN OBJET",0
grouptx1::   .DC.b "APPRENDRE SUR UN SUJET",0
grouptx2::   .DC.b "RENDEZ-VOUS",0
grouptx3::   .DC.b "DISCUTER",0
grouptx4::   .DC.b "DONNER UN OBJET",0
grouptx5::   .DC.b "PRENDRE UN OBJET",0
grouptx6::   .DC.b "CHASSER DU GROUPE",0

rdvtx0::     .DC.b "JARDINS DE CANOPEA",0
rdvtx1::     .DC.b "HALL DE L'ASTROPORT",0
rdvtx2::     .DC.b "BOITE DE NUIT APPOLON",0
rdvtx3::     .DC.b "RECEPTION MANTOUE",0
rdvtx4::     .DC.b "REJOINDRE",0
rdvtx5::     .DC.b "ANNULER MISSION",0


;19 caracteres max !!!


mtx0::       .DC.b "     DISCUTER",0

mtx1::       .DC.b "     ACHETER",0
mtx2::       .DC.b "     VOLER",0
mtx3::       .DC.b " LOUER UNE CHAMBRE",0
mtx4::       .DC.b "PRENDRE/LAISSER CLE",0
mtx5::       .DC.b "MONTRER SES PAPIERS",0
mtx6::       .DC.b "  PRENDRE UN RDV",0
mtx7::       .DC.b "  ORDRE DU JOUR    ",0

mtx8::       .DC.b "  TERMINUS TB1    ",0   ;1
mtx9::       .DC.b "  TERMINUS TF",0        ;2
mtx10::      .DC.b "  TERMINUS TB",0        ;3
mtx11::      .DC.b "  TERMINUS TE",0        ;4
mtx12::      .DC.b "  TOUR CARMENTA",0      ;5
mtx13::      .DC.b "  TOUR VERTUMNUS",0     ;6
mtx14::      .DC.b "  TOUR MINERVA",0       ;7
mtx15::      .DC.b "  TOUR KOSHAN  ",0      ;8
mtx16::      .DC.b "  TOUR JANUS  ",0       ;9

mtx17::      .DC.b "  COMMANDER VERRES ",0
mtx18::      .DC.b "     TROQUER     ",0



txboi0::     .DC.b "  JE SUIS DESOLE,  ",0
txboi1::     .DC.b "L'HOTEL EST COMPLET",0  ;TAILLE MAX
txboi3::     .DC.b " ",0
txboi4::     .DC.b "1 JOUR  100 CREDITS",0
txboi5::     .DC.b "2 JOURS 200 CREDITS",0
txboi6::     .DC.b "4 JOURS 400 CREDITS",0
txboi7::     .DC.b "8 JOURS 800 CREDITS",0
txboi8::     .DC.b "   CELA FAIT "
txboi81::    .DC.b "100   ",0
txboi9::     .DC.b "   CREDITS. OK ?   ",0
txboioui::   .DC.b " OUI ",0
txboinon::   .DC.b "  NON",0
txboi10::    .DC.b "DESOLE, VOUS N'AVEZ",0
txboi11::    .DC.b "PAS DE QUOI PAYER !",0
txboi12::    .DC.b "  JE VOUS PROPOSE  ",0
txboi13::    .DC.b "AUJOURD'HUI A "
txboi131::   .DC.b "00 H.",0
txboi14::    .DC.b "  DESOLE, IL N'Y A ",0
txboi15::    .DC.b "PLUS DE RENDEZ-VOUS",0
txboi16::    .DC.b " POUR AUJOURD'HUI. ",0
txboi17::    .DC.b " REPASSEZ DEMAIN...",0
txboi18::    .DC.b "  ENTREZ CITOYEN   ",0
txboi19::    .DC.b "  EQUITES MENASIS  ",0
txboi20::    .DC.b " VOUS ETES ATTENDU.",0
txboi21::    .DC.b "   VOUS AVEZ DEJA  ",0
txboi22::    .DC.b "    RENDEZ-VOUS    ",0
txboi23::    .DC.b "    AUJOURD'HUI.   ",0
txboi24::    .DC.b "SORTEZ  D'ICI AVANT",0
txboi25::    .DC.b "  QUE JE M'ENERVE",0
txboi26::    .DC.b " ET QUE J'APPELLE  ",0
txboi27::    .DC.b "LES CATAPHRACTAIRES",0
txboi28::    .DC.b "    VIA-EXPRESS    ",0
txboi29::    .DC.b "300 CREDITS MINIMUM",0
txboi30::    .DC.b "   TAXI MOSQUITO   ",0
txboi31::    .DC.b "FORFAIT:400 CREDITS",0
txboi32::    .DC.b "  AVEC CHAUFFEUR ? ",0
txboi33::    .DC.b "FORFAIT:950 CREDITS",0

txboi34::    .DC.b "IZAE BOGLI EST MORT",0
txboi35::    .DC.b "  SON COFFRE A ETE ",0
txboi36::    .DC.b "  FRACTURE ET SES  ",0
txboi37::    .DC.b "TITRES ONT DISPARU.",0

txboi38::    .DC.b "  REPASSEZ DANS 24 ",0
txboi39::    .DC.b " HEURES, VOS VERRES",0
txboi40::    .DC.b " DE CONTACT CODEURS",0
txboi41::    .DC.b "    SERONT PRETS.  ",0
txboi42::    .DC.b " J'AI BESOIN D'UNE ",0
txboi43::    .DC.b "TABLETTE MEMORIELLE",0
txboi44::    .DC.b "CODEE POUR POUVOIR ",0
txboi45::    .DC.b "   LES FABRIQUER.  ",0
txboi46::    .DC.b "VOUS M'EN AVEZ DEJA",0
txboi47::    .DC.b " COMMANDE, ILS NE  ",0
txboi48::    .DC.b "  SONT PAS ENCORE  ",0
txboi49::    .DC.b "       PRETS...    ",0
txboi50::    .DC.b "  VOS VERRES SONT  ",0
txboi51::    .DC.b "      PRETS...     ",0
txboi52::    .DC.b "  VOUS POUVEZ LES  ",0
txboi53::    .DC.b "    ACHETER...     ",0

txboi54::    .DC.b "...AAAARRRGGGHHH!!!",0
txboi55::    .DC.b "APRES QUELQUES PAS,",0
txboi56::    .DC.b " UNE FORTE CHALEUR ",0
txboi57::    .DC.b "  VOUS ENVAHIT...  ",0
txboi58::    .DC.b "LE CHAMP DE RAYONS ",0
txboi59::    .DC.b "G S'EST DECLENCHE, ",0
txboi60::    .DC.b " VOUS ETES CUIT... ",0


txboi61::    .DC.b " ",0
txboi62::    .DC.b " ",0
txboi63::    .DC.b "     THE END...",0
txboi64::    .DC.b " ",0
txboi65::    .DC.b "  VAISSEAU SPATIAL ",0
txboi66::    .DC.b "    5000 CREDITS.  ",0

txboi67::    .DC.b "  VOUS ETES ARRETE ",0
txboi68::    .DC.b " ET JETE EN PRISON ",0
txboi69::    .DC.b "  POUR USURPATION  ",0
txboi70::    .DC.b "   D'IDENTITE...   ",0

txboi71::    .DC.b "UNE ALARME RETENTIT",0
txboi72::    .DC.b " VOUS ETES PRIS...",0

txboi73::    .DC.b "VOUS ETES SURPRIS!",0
txboi74::    .DC.b "  C'EST FINI...",0

txboi75::    .DC.b "   SAUVERGARDE DE  ",0
txboi76::    .DC.b "      PARTIE ?     ",0

txboi77::    .DC.b " INSEREZ DISQUETTE ",0
txboi78::    .DC.b " 'SAUVERGARDE' OU  ",0
txboi79::    .DC.b "  VIERGE FORMATEE  ",0
txboi80::    .DC.b "    DOUBLE FACE    ",0

txboi82::    .DC.b "   CHARGEMENT DE   ",0
txboi83::    .DC.b "      PARTIE ?     ",0

txboi84::    .DC.b "     ACHEVER LE    ",0
txboi85::    .DC.b "    GLADIATEUR ?   ",0


;---------------------------------------------------------------
;NOM DES OBJETS (MAX 26 CARACTERES)

lunnoct::    .DC.b "LUNETTES VISION NOCTURNE",0
chemise::    .DC.b "CHEMISE",0
sacj::       .DC.b "SAC JETABLE",0
sacoche::    .DC.b "SACOCHE",0
grandsac::   .DC.b "GRAND SAC",0
bombuzal::   .DC.b "FIOLE DE BOMBUZAL",0
corde::      .DC.b "CORDE",0
video::      .DC.b "VIDEOPHONE PORTABLE",0
eau::        .DC.b "EAU",0
the::        .DC.b "THE AROMATISE",0
cafe::       .DC.b "THERMOS DE CAFE",0
volcano::    .DC.b "COCKTAIL VOLCANO",0
merluz::     .DC.b "MERLUZ NITROCOLA",0
doubles::    .DC.b "DOUBLE SPLATZ",0
vinvert::    .DC.b "VIN VERT",0
vincecub::   .DC.b "VIN DE CECUBLE",0
vinmassiq::  .DC.b "VIN DE MASSIQUE",0
vinfaler::   .DC.b "VIN DE FALERNE",0
gateau::     .DC.b "GATEAU AU TASMARI",0
saucisse::   .DC.b "SAUCISSE",0
poisson::    .DC.b "POISSON VOLANT",0
galettes::   .DC.b "GALETTES ROMAINES",0
ppains::     .DC.b "PETITS PAINS",0
salade::     .DC.b "SALADE 'BIG FODLES'",0
pizza::      .DC.b "PIZZA (DE LA TERRE)",0
algue::      .DC.b "PASTILLES D'ALGUE",0
hamburge::   .DC.b "HAMBURGER",0
frites::     .DC.b "FRITES",0
azmani::     .DC.b "POT D'AZMANI",0
vespe::      .DC.b "VESPE D'ISNUFLURE",0
painroug::   .DC.b "PAIN AU BLE ROUGE",0
crepe::      .DC.b "CREPE DE BORGANIS",0

antiop::     .DC.b "VIANDE D'ANTIOPINE",0
aureus::     .DC.b "AUREUS",0
denarius::   .DC.b "DENARIUS",0
nummus::     .DC.b "NUMMUS",0
as::         .DC.b "AS",0
scutum::     .DC.b "SCUTUM IONIQUE",0
cuirasse::   .DC.b "CUIRASSE A PRISME",0
cuissard::   .DC.b "CUISSARDES DEFLECTRICES",0
coudiere::   .DC.b "COUDIERES DEFLECTRICES",0
casqued::    .DC.b "CASQUE DEFLECTEUR",0
gilet2::     .DC.b "GILET DEFLECTEUR 2",0
gilet1::     .DC.b "GILET DEFLECTEUR 1",0
chf6::       .DC.b "CHAMPS DE FORCE 6",0
chf8::       .DC.b "CHAMPS DE FORCE 8",0
chf9::       .DC.b "CHAMPS DE FORCE 9",0
k1::         .DC.b "K1",0
k2::         .DC.b "K2",0
lp45::       .DC.b "LP-45",0
plas1::      .DC.b "PLAS-1",0
fillum12::   .DC.b "FILLUM-12",0
lp110::      .DC.b "LP-110",0
lp02::       .DC.b "LP02",0
n29::        .DC.b "N29",0
lp57::       .DC.b "LP-57",0
lp12::       .DC.b "LP-12",0
hasta1::     .DC.b "HASTA-1000",0
hasta2::     .DC.b "HASTA-2000",0
laskolt::    .DC.b "LASKOLT-45",0
plasma::     .DC.b "PLASMATRON",0
asoa50::     .DC.b "ASOA-50",0
pilumlas::   .DC.b "PILUM LASER",0
gladius::    .DC.b "GLADIUS",0
haas10::     .DC.b "HAAS-10",0
beckmann::   .DC.b "BECKMANN",0
voktraso::   .DC.b "VOKTRASOFF",0
corps::      .DC.b "CORPS",0
bob::        .DC.b "B.O.B",0
main_g::     .DC.b "MAIN GAUCHE",0
main_d::     .DC.b "MAIN DROITE",0
ctueur::     .DC.b "CONTRAT TUEUR",0
sdouleu::    .DC.b "SONDE DE DOULEUR",0
vetpret::    .DC.b "VETEMENTS DE PRETEUR",0
cp_kubit::   .DC.b "CARTE DU PRETEUR KUBITUS",0
cp_adelia::  .DC.b "CARTE DU PRETEUR ADELIA",0
cp_bonum::   .DC.b "CARTE DU PRETEUR BONUM",0
cp_sirius::  .DC.b "CARTE DU PRETEUR SIRIUS",0
cp_agam::    .DC.b "CARTE PRETEUR AGAMEMNUM",0
fc_pret::    .DC.b "FAUSSE CARTE DE PRETEUR",0
livremem::   .DC.b "LIVRE MEMOIRE D'UN PAGE",0
journal::    .DC.b "JOURNAL LOCAL",0
papierma::   .DC.b "PAPIERS DIVERS MASSIGLIA",0
verrecod::   .DC.b "VERRE DE CONTACT CODEUR",0
banderes::   .DC.b "BANDE RESTITUEUR VOCAL",0
resvocal::   .DC.b "RESTITUEUR VOCAL",0
ditroxyl::   .DC.b "DITROXYL",0
axial::      .DC.b "SYSTEME AXIAL A VENTOUSES",0
tablette::   .DC.b "TABLETTE MEMORIELLE",0
titrepro::   .DC.b "TITRE DE PROPRIETE",0
cartecre::   .DC.b "CARTE DE CREDIT",0
cc_ma::      .DC.b "CARTE DE CREDIT MASSIGLIA",0
cc_jm::      .DC.b "CARTE DE CREDIT J.MENASIS",0
clehotel::   .DC.b "CLE D'HOTEL",0
cle_cite::   .DC.b "CLE D'HOTEL (CITE)",0
cle_mm::     .DC.b "CLE D'HOTEL (MANTOUE)",0
cartecai::   .DC.b "CARTE D'ACCES CAI",0
lp_a::       .DC.b "LAISSEZ-PASSER A",0
lp_ta::      .DC.b "LAISSEZ-PASSER TA",0
lp_rx::      .DC.b "LAISSEZ-PASSER RX",0
cle_mer::    .DC.b "CLE HOTEL MERCURE",0

;---------------------------------------------------------------

;              TAILLE MAX 25 CARACTERES
qtexte1::    
             .DC.b "MACHINE HORS SERVICE",0
qtexte1a::   
             .DC.b "CREDITS INSUFISANTS",0

;               TAILLE MAX 7 CARACTERES
qtjouer::    
             .DC.b "JEU",0
qtparier::   
             .DC.b "PARI",0
qtquit::     
             .DC.b "ABANDON",0
             .EVEN 

quattrotx::  .DC.l qtexte1,qtexte1a,qtjouer,qtparier,qtquit

;              TAILLE MAX 25 CARACTERES
ttexte1::    
             .DC.b "MACHINE HORS SERVICE",0
ttexte1a::   
             .DC.b "CREDITS INSUFISANTS",0
ttexte2::    
             .DC.b "MONTANT DU PARI",0
ttexte3::    
             .DC.b "VOUS AVEZ GAGNE :",0
ttexte4::    
             .DC.b "VOUS AVEZ PERDU :",0

;               TAILLE MAX 7 CARACTERES

tjouer::     
             .DC.b "JEU",0
tparier::    
             .DC.b "PARI",0
tquit::      
             .DC.b "ABANDON",0
             .EVEN 

tubutx::     .DC.l ttexte1,ttexte1a,ttexte2,ttexte3,ttexte4,tjouer,tparier,tquit

;14 caracteres max !!!


mode::       
             .DC.b "MODE :",0
             .DC.b "AUTOMATIQUE",0
             .DC.b "MANUEL",0
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
             .DC.b "DEPART   :",0
             .DC.b "ARRIVEE  :",0

;     TEXTE DIT PAR LE FLIC
;  4 LIGNE DE HAUT MAXIMUM
;  34 CARACTERES PAR LIGNE MAXIMUM
; SI MOINS DE 4 LIGNES, LA DERNIERE LIGNE DOIT ETRE EGALE A .DC.B 0

vcontrpa::   
             .DC.b "BAL'AMAYE CITOYEN,",0
             .DC.b "CATAPHRACTAIRE DE LA VIA, VEUILLEZ",0
             .DC.b "ME PRESENTER VOS LAISSEZ_PASSER",0
             .DC.b "S'IL VOUS PLAIT",0
             .DC.b 0
vpasok::     
             .DC.b "MERCI, VOUS POUVEZ CIRCULER",0
             .DC.b 0
vpasnook::   
             .DC.b "VOUS N'AVEZ PAS LE DROIT",0
             .DC.b "DE CIRCULER SUR CETTE VIA",0
             .DC.b "VEUILLEZ ME SUIVRE",0
             .DC.b 0
vexesvi::    
             .DC.b "BAL'AMAYE CITOYEN,",0
             .DC.b "CATAPHRACTAIRE DE LA VIA, VOTRE",0
             .DC.b "AMENDE POUR EXCES DE VITESSE",0
             .DC.b "EST DE 300 CREDITS",0
             .DC.b 0
vexesnook::  
             .DC.b "VOUS N'AVEZ PAS ASSEZ D'ARGENT",0
             .DC.b "VOUS VOUS EXPLIQUEREZ AU POSTE",0
             .DC.b 0
vexesok::    
             .DC.b "VOUS POUVEZ CIRCULER,",0
             .DC.b "MAIS SOYEZ PLUS PRUDENT",0
             .DC.b "A L'AVENIR",0
             .DC.b 0
             .EVEN 

viatx::                ;OVERLAY 52
             .DC.l mode,vtexted,vtexte,vcontrpa,vpasok,vpasnook,vexesvi
             .DC.l vexesnook,vexesok


;42 caracteres max, respecter le nombre de lignes

txcaid1::    
             .DC.b "VOUS AVEZ DEMANDE:",0
             .DC.b "ECONOMIE/DROITS TERRITORIAUX/BEDIHN6",0
             .DC.b " - BEDIHN6: SATELLITE NATUREL DE SHEDISHAN",0
             .DC.b "            GROS GISEMENTS D'ECHIATONE 21",0
             .DC.b " - PROPRIETAIRES :",0
             .DC.b "        KOSHAN INC            : 200 TITRES",0
             .DC.b "        BANQUE MASSIGLIA      : 050",0
             .DC.b "        SENAT. JUGH'AHIH      : 010",0
             .DC.b "        CITOY. BOGLI IZAE     : 025",0
             .DC.b " ",0
             .DC.b "        TOTAL DES TITRES      : 285",0
             .DC.b "        TITRES NON REPERTORIES: 215",0
             .DC.b " - DERNIERE TRANSACTION :",0
             .DC.b "        100 TITRES DU TRESOR ROYAL",0
             .DC.b "        A LA KOSHAN. PIECE NO Y2395.",0
             .DC.b "        VALEUR DU TITRE: 2 MILLIARDS",0
             .DC.b "        DE CREDITS",0
txcaif1::    
txcaid2::    
             .DC.b " ",0
             .DC.b "KOSHAN INC/ SIEGE SOCIAL CITE/TOUR KOSHAN",0
             .DC.b "       DIRECTION: SENATEUR ZAKK KOSHAN",0
             .DC.b " ",0
             .DC.b "BANQUE MASSIGLIA/ SIEGE SOCIAL CITE/",0
             .DC.b "TOUR CARMENTA",0
             .DC.b "       DIRECTION: EQUITES JULIUS MASSIGLIA",0
             .DC.b "                  BUREAU AU 14EME ETAGE.",0
             .DC.b " ",0
             .DC.b "SENAT. JUGH'AHIH/ LIEU DE CONSULTATION",0
             .DC.b "CITE/TOUR VERTUMNUS 34EME ETAGE BUREAU 7B",0
             .DC.b " ",0
             .DC.b "CITOY. BOGLI IZAE/ SOCIETE WELCO",0
             .DC.b "SIEGE SOCIAL  EMPORIUM DE CAPREE SECTEUR 2",0
             .DC.b "       DIRECTION: CITOYEN IZAE BOGLI",0
txcaif2::    

;---------------------------------------------------------------
;TEXTES BOITE DE CONFIGURATION

;taille libre (dans la limite du raisonnable !!!)

;cfgtx1::      .DC.b "SONS:",0
;cfgtx2::      .DC.b "MUSIQUE ON",0
;cfgtx3::      .DC.b "BRUITAGES ON",0
;cfgtx4::      .DC.b "MV16",0
;cfgtx5::      .DC.b "MONITEUR",0
;cfgtx6::      .DC.b "COMBATS:",0
;cfgtx7::      .DC.b "ARCADE",0
;cfgtx8::      .DC.b "STRATEGIE",0
;cfgtx9::      .DC.b "QUATTRO:",0
;cfgtx10::     .DC.b "MODE X",0
;cfgtx11::     .DC.b "MODE XY",0
;cfgtx12::     .DC.b "SIMULATEURS:",0
;cfgtx13::     .DC.b "DETAILS MAX",0
;cfgtx14::     .DC.b "DETAILS MIN",0
;cfgtx15::     .DC.b "AUTO-STABILISATION",0
;cfgtx16::     .DC.b "CLAVIER:",0
;cfgtx17::     .DC.b "QWERTY",0
;cfgtx18::     .DC.b "AZERTY",0
;cfgtx19::     .DC.b "QWERTZ",0


;42 caracteres max, respecter le nombre de lignes


txbobd1::    
             .DC.b " ",0
             .DC.b "<B.O.B VOUS DIT:>",0
             .DC.b " ",0
             .DC.b "L'ANALYSE DE LA TABLETTE MEMORIELLE M'A LAISSE",0
             .DC.b "ENTREVOIR QUELQUES IMPERFECTIONS DANS LE SYSTEME",0
             .DC.b "DE PROTECTION DE LA BANQUE MASSIGLIA. VOICI DONC",0
             .DC.b "LE PLAN LE PLUS VIABLE A MON AVIS:",0
             .DC.b " -ATTERIR AVEC UN VAISSEAU SUR LE TOIT DE LA TOUR",0
             .DC.b "  CARMENTA, MAIS PAS SUR LA ZONE D'ATTERISSAGE (UN",0
             .DC.b "  VAISSEAU D'ENTRETIEN ME SEMBLE LE PLUS APTE A",0
             .DC.b "  PASSER INAPERCU).",0
             .DC.b " -SE PROCURER UN SYSTEME AXIAL A VENTOUSE POUR SE",0
             .DC.b "  FIXER SUR LA PAROI NORD JUSTE SOUS LA ZONE",0
             .DC.b "  D'ATTERISSAGE. UTILISER ENSUITE DU DITROXYL",0
             .DC.b "  PENTRADYNITE POUR PERCER CETTE PAROI QUI EST EN",0
             .DC.b "  OZONORE (METAL HYPER RESISTANT).",0
             .DC.b " -POUR OUVRIR LA PORTE DU COULOIR, UTILISER LE",0
             .DC.b "  RESTITUEUR VOCAL (AVEC LA BANDE CONTENANT",0
             .DC.b "  L'ENREGISTREMENT DE LA VOIX DE MASSIGLIA).",0
             .DC.b " ",0
             .DC.b " ",0
             .DC.b "              <CLIQUEZ POUR PASSER A LA PAGE 2>",0
txbobf1::    
txbobd2::    
             .DC.b " ",0
             .DC.b " -LA ZONE SUIVANTE EST CONSTITUEE D'UN CHAMP DE",0
             .DC.b "  RAYONS G INFRANCHISSABLES MAIS QUI PEUT ETRE",0
             .DC.b "  DECONNECTE PAR UN DETECTEUR DE PULSATION",0
             .DC.b "  OPTIQUE. IL VOUS SUFFIRA DE DONNER CETTE",0
             .DC.b "  TABLETTE MEMORIELLE QUE JE VIENS JUSTE DE",0
             .DC.b "  REPROGRAMMER A UN OPTICIEN POUR QU'IL VOUS",0
             .DC.b "  FABRIQUE LES VERRES CODEURS DONT VOUS AUREZ",0
             .DC.b "  BESOIN POUR PASSER CE CHAMP.",0
             .DC.b " -IL NE RESTERA PLUS QU'A FAIRE FONDRE LA PORTE DU",0
             .DC.b "  COFFRE AVEC LE DITROXYL PENTRADYNITE.",0
             .DC.b " ",0
             .DC.b "                             <FIN DE L'ANALYSE>",0
txbobf2::    

txjourd::    
             .DC.b " ",0
             .DC.b " ",0
             .DC.b " ",0
             .DC.b "        EXTRAIT DU JOURNAL ROMA NEWS:",0
             .DC.b " ",0
             .DC.b " CRIME CRAPULEUX DANS LE VIEUX QUARTIER D'ASHAN.",0
             .DC.b " ",0
             .DC.b "   LA NUIT DERNIERE, DEUX OU TROIS HOMMES ONT",0
             .DC.b "ASSASSINE ZIST HONOR, DE LA CASTE D'OZOWH. CET",0
             .DC.b "ANCIEN PAGE DU ROI KELEB DISH III MENAIT UNE VIE",0
             .DC.b "APPAREMMENT SANS HISTOIRES. IL ETAIT TOUTEFOIS",0
             .DC.b "CONSIDERE COMME UN CONTESTATAIRE DU NOUVEAU ",0
             .DC.b "REGIME MAIS SA MORT NE SEMBLE PAS, AUX DIRES DU",0
             .DC.b "COMMISSAIRE CHARGE DE L'ENQUETE, ETRE D'ORDRE",0
             .DC.b "POLITIQUE.",0
             .DC.b " ",0
             .DC.b "  RASSURONS NOUS, IL NE FAIT AUCUN DOUTE QUE NOTRE",0
             .DC.b "REMARQUABLE POLICE ARRETERA BIENTOT LES MEURTRIERS",0
             .DC.b "QUI NE COURENT JAMAIS LONGTEMPS DANS NOTRE CITE...",0
txjourf::    
txbookd1::   
             .DC.b " ",0
             .DC.b "LE LIVRE QUE VOUS AVEZ DECOUVERT EST ENTIEREMENT",0
             .DC.b "ECRIT EN SHEDISH IL EST INTITULE 'MIS ORIENTIS",0
             .DC.b "BEDZAKIL' CE QUE BOB TRADUIT COMME MEMOIRES D'UN",0
             .DC.b "PAGE. VOUS REMARQUEZ QUE DEUX PAGES SONT CORNEES.",0
             .DC.b "VOUS SOUMETTEZ CES PAGES A BOB POUR QU'IL LES",0
             .DC.b "ANALYSE. AU BOUT DE QUELQUES MINUTES BOB VOUS EN",0
             .DC.b "DONNE LA TRADUCTION:",0
             .DC.b " ",0
             .DC.b "(...) C'EST EN OBSERVANT LA GRANDE ARCHE DU LEVANT",0
             .DC.b "QUE MON AMI ET ASTRONOME MOSES BANAFOOSH EUT",0
             .DC.b "L'IDEE FOLLE D'EXPLORER BEDIHN 6 POUR EN EXPLOITER",0
             .DC.b "LES MINERAIS. L'ECHIATONE DE NOTRE TERRE",0
             .DC.b "COMMENCAIT A SE TARIR ET LES RECENTS GISEMENTS",0
             .DC.b "DECOUVERTS PAR DES HUMAINS SUR BEDIHN LAISSAIENT",0
             .DC.b "PRESAGER UNE NOUVELLE ERE DE PROSPERITE POUR SES",0
             .DC.b "EXPLOITANTS. J'AI DU L'AIDER POUR PREPARER SON",0
             .DC.b "EXPEDITION MAIS JE NE SUIS PAS VENU AVEC LUI; JE",0
             .DC.b "N'AI JAMAIS AIME L'AVENTURE ET PEUT ETRE AVAIS-JE",0
             .DC.b "DEJA UN CURIEUX PRESSENTIMENT CONCERNANT L'ISSUE",0
             .DC.b "TRAGIQUE DES EVENEMENTS:",0
             .DC.b "JAMAIS JE N'AI REVU MON AMI (...)",0
txbookf1::   
txbookd2::   
             .DC.b " ",0
             .DC.b "JE SUIS MAINTENANT CONVAINCU QUE CES HUMAINS, DES",0
             .DC.b "SCELERATS QUI PORTENT LE NOM DE KOSHAN, N'ONT PAS",0
             .DC.b "LES TITRES DE MON AMI, CAR LES DERNIERS",0
             .DC.b "RENSEIGNEMENTS FONT ETAT DE 200 TITRES LEUR",0
             .DC.b "APPARTENANT, 100 TITRES LEGAUX ET LE LEG DES 100",0
             .DC.b "TITRES DU TRESOR ROYAL, MON AMI ET SES TITRES",0
             .DC.b "DOIVENT SE MORFONDRE QUELQUE PART DANS CE",0
             .DC.b "SATELLITE, J'ENVISAGE DONC D'EFFECTUER MOI MEME",0
             .DC.b "UNE EXPEDITION.",0
             .DC.b " ",0
             .DC.b "(...) UNE PEINE SANS COMMUNE MESURE ME HANTE",0
             .DC.b "DEPUIS MA REPUDIATION, SUIS-JE FOU OU EST-CE LE",0
             .DC.b "ROI? LE PREMIER PAGE A ETRE ECARTE DES",0
             .DC.b "APPARTEMENTS ROYAUX QUELLE HONTE ! COMMENT EST-CE",0
             .DC.b "POSSIBLE, COMMENT CE ROI QUI AUTREFOIS ME",0
             .DC.b "PROMETTAIT LA LIBERTE A T-IL PU REPUDIER UN PAGE",0
             .DC.b "D'HONNEUR, RETABLIR LE HONTEUX SYSTEME D'ANGA,",0
             .DC.b "LAISSER SES 100 TITRES A LA KOSHAN, UN LEG DE 200",0
             .DC.b "MILLIARDS DE CREDITS !!! SERAIT-CE ENCORE UNE",0
             .DC.b "FOURBERIE DE CES HUMAINS? TROUVERAI-JE LA",0
             .DC.b "SOLUTION SUR BEDIHN 6 ???",0
txbookf2::   

txpretd::              ;TE
             .DC.b " ",0
             .DC.b " ",0
             .DC.b " ",0
             .DC.b " ",0
             .DC.b "             TABLEAU DES SERVICES",0
             .DC.b " ",0
             .DC.b " ",0
             .DC.b " ",0
             .DC.b "EQUIPE TIERCE:",0
             .DC.b " ",0
             .DC.b "PRETEUR AGAMEMNUM        : PROCES D'INGRID DIT",0
             .DC.b "                           'LA RAFALE'.",0
             .DC.b "PRETEUR SIRIUS AL BAREK  : EN LEVEE DE SEANCE.",0
             .DC.b "PRETEUR BONUM CERES      : PROCES ACTUA/ZINGFIELD.",0
             .DC.b "PRETEUR ADELIA           : PROCES KOSHAN/HADFORD.",0
             .DC.b "PRETEUR KUBITUS          : EN LEVEE DE SEANCE.",0
txpretf::    


;      32 CARACTERES MAXIMUM, LAISSER LE .DC.B 0
gladtx::     
             .DC.b "AVE CESAR!",0
             .DC.b "CEUX QUI VONT MOURIR",0
             .DC.b "TE SALUENT",0
             .DC.b 0

;ne pas changer la taille
;pv=point de vie
;f=force
;i=intelligence
;r=reflexe
;v=vitalite
;p=perception
;mu=munition
;vp=coefficient de perforation

cpttexte::   
             .DC.b "PV",0
             .DC.b "F ",0
             .DC.b "I ",0
             .DC.b "R ",0
             .DC.b "V ",0
             .DC.b "P ",0
             .DC.b "MU",0
             .DC.b "CP",0

;23 caracteres max

ctexte1::    
             .DC.b "FRAPPE ET REUSSIT",0    ;1
             .DC.b "FRAPPE ET RATE",0       ;2
             .DC.b "EST TROP LOIN",0        ;3
             .DC.b "FUIT",0                 ;4
             .DC.b "EST MORT",0             ;5
             .DC.b "PARE",0                 ;6
             .DC.b "EST DESARME",0          ;7
             .DC.b "TIRE ET FAIT MOUCHE",0  ;8
             .DC.b "DEVIE LE COUP",0        ;9
             .DC.b "EST HORS DE PORTEE",0   ;10
             .DC.b "DE VIE",0               ;8
             .DC.b "D'INTELLIGENCE",0       ;9
             .DC.b "DE REFLEXE",0           ;10
             .DC.b "DE FORCE",0             ;10
             .DC.b "N'A PLUS D'ARME",0      ;9
             .DC.b "N'A PLUS DE PROTECTION",0     ;10
             .DC.b "TIRE A COTE DE SA CIBLE",0    ;10

;10 caracteres max

ctexte2::    
             .DC.b "JEHAN",0
             .DC.b "CIBLE",0
             .DC.b "MUNITION",0
             .DC.b "PROTECTION",0
             .DC.b "ASSOCIES",0
             .DC.b "ENNEMIS",0
ctexte1a::   
             .DC.b "PERD",0
             .DC.b "POINTS",0
             .EVEN 
combtx::     
             .DC.l cpttexte,ctexte1,ctexte2,ctexte1a


;        TAILLE MAX 11 CARACTERES
cjouer:      
             .DC.b "JEU",0
cpari:       
             .DC.b "PARI",0
cabandon:    
             .DC.b "ABANDON",0
chors:       
             .DC.b "HORS",0
cserv:       
             .DC.b "SERVICE",0
ccred:       
             .DC.b "CREDITS",0
cinsu:       
             .DC.b "INSUFISANTS",0
ccoup:       
;      LAISSER LES 3 " "
             .DC.b "   COUPS",0
cavan:       
             .DC.b "D'AVANCE",0
             .EVEN 
chidamtx::   .DC.l cjouer,cpari,cabandon,chors,cserv,ccred,cinsu,ccoup,cavan


;23 caracteres max!!!

; ------------------------------------------
; TEXTE DES LIBRAIRIES
;
afboberr::   
             .DC.b "ERREUR DE COMPILATION  ",0
             .EVEN 
; ---------------------------------------
anagent::    
             .DC.b "ANALYSE DE L'AGENT     ",0
             .EVEN 
anaevi::     
             .DC.b "ANALYSE D'UN INDIVIDU  ",0
             .EVEN 
; ---------------------------------------
tab_dar::    
             .DC.l rythb,rythm,rythn
rythb::      
             .DC.b "RYTHME CARDIAQUE RAPIDE",0
             .EVEN 
rythm::      
             .DC.b "RYTHME CARDIAQUE LENT  ",0
             .EVEN 
rythn::      
             .DC.b "RYTHME CARDIAQUE NORMAL",0
             .EVEN 
; ---------------------------------------
tab_dap::    .DC.l pressb,pressm,pressn
pressb::     
             .DC.b "FLUX ARTERIEL ELEVE    ",0
             .EVEN 
pressm::     
             .DC.b "FLUX ARTERIEL BAS      ",0
             .EVEN 
pressn::     
             .DC.b "FLUX ARTERIEL NOMINAL  ",0
             .EVEN 
; ---------------------------------------
tab_dat::    
             .DC.l tempb,tempm,tempn
tempb::      
             .DC.b "TEMPERATURE ELEVEE     ",0
             .EVEN 
tempm::      
             .DC.b "TEMPERATURE BASSE      ",0
             .EVEN 
tempn::      
             .DC.b "TEMPERATURE NOMINALE   ",0
             .EVEN 
; ---------------------------------------
tab_dae::    
             .DC.l etatb,etatm,etatn
etatb::      
             .DC.b "L'ETAT EST BON         ",0
             .EVEN 
etatm::      
             .DC.b "L'ETAT EST CRITIQUE    ",0
             .EVEN 
etatn::      
             .DC.b "L'ETAT EST NOMINAL     ",0
             .EVEN 
; ---------------------------------------
tab_daf::    
             .DC.l afaim,asoif,afatigue
afaim::      
             .DC.b "IL A FAIM              ",0
             .EVEN 
asoif::      
             .DC.b "IL A SOIF              ",0
             .EVEN 
afatigue::   
             .DC.b "IL EST FATIGUE         ",0
             .EVEN 
; ---------------------------------------
tab_das::    
             .DC.l atsg,atsf,atsn
             .DC.l fibg,fibf,fibn
             .DC.l hypg,hypf,hypn
             .DC.l morg,morf,morn
             .DC.l psyg,psyf,psyn
atsg::       
             .DC.b "TAUX ATS 34 ELEVE      ",0
             .EVEN 
atsf::       
             .DC.b "TAUX ATS 34 BAS        ",0
             .EVEN 
atsn::       
             .DC.b "TAUX ATS 34 NORMAL     ",0
             .EVEN 
fibg::       
             .DC.b "TAUX FIBRINE ELEVE     ",0
             .EVEN 
fibf::       
             .DC.b "TAUX FIBRINE BAS       ",0
             .EVEN 
fibn::       
             .DC.b "TAUX FIBRINE NORMAL",0
             .EVEN 
hypg::       
             .DC.b "TAUX HYPERCEP ELEVE",0
             .EVEN 
hypf::       
             .DC.b "TAUX HYPERCEP BAS",0
             .EVEN 
hypn::       
             .DC.b "TAUX HYPERCEP NORMAL",0
             .EVEN 
morg::       
             .DC.b "TAUX MORPHO ELEVE",0
             .EVEN 
morf::       
             .DC.b "TAUX MORPHO BAS",0
             .EVEN 
morn::       
             .DC.b "TAUX MORPHO NORMAL",0
             .EVEN 
psyg::       
             .DC.b "TAUX PSY ELEVE",0
             .EVEN 
psyf::       
             .DC.b "TAUX PSY BAS",0
             .EVEN 
psyn::       
             .DC.b "TAUX PSY NORMAL",0
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
             .DC.b "FORCE GRANDE ",0
             .EVEN 
forcef::     
             .DC.b "FORCE FAIBLE ",0
             .EVEN 
forcen::     
             .DC.b "FORCE NORMALE",0
             .EVEN 
intelg::     
             .DC.b "INTELLIGENCE GRANDE",0
             .EVEN 
intelf::     
             .DC.b "INTELLIGENCE FAIBLE",0
             .EVEN 
inteln::     
             .DC.b "INTELLIGENCE NORMALE",0
             .EVEN 
vitag::      
             .DC.b "VITALITE GRANDE",0
             .EVEN 
vitaf::      
             .DC.b "VITALITE FAIBLE",0
             .EVEN 
vitan::      
             .DC.b "VITALITE NORMALE ",0
             .EVEN 
percg::      
             .DC.b "PERCEPTION GRANDE",0
             .EVEN 
percf::      
             .DC.b "PERCEPTION FAIBLE",0
             .EVEN 
percn::      
             .DC.b "PERCEPTION NORMALE ",0
             .EVEN 
reflg::      
             .DC.b "REFLEXE IMPORTANT",0
             .EVEN 
reflf::      
             .DC.b "REFLEXE NEGLIGEABLE",0
             .EVEN 
refln::      
             .DC.b "REFLEXE NORMAL ",0
             .EVEN 
charig::     
             .DC.b "CHARISME IMPORTANT",0
             .EVEN 
charif::     
             .DC.b "CHARISME NEGLIGEABLE",0
             .EVEN 
charin::     
             .DC.b "CHARISME NORMAL ",0
             .EVEN 
; ---------------------------------------

;taille libre, laisser les 00

txheure::    .DC.b "IL EST "
txhh::       .DC.b "00 H "
txhm::       .DC.b "00 MN",0
bobalerte::  .DC.b "ALERTE !",0

             .EVEN 

;ne pas changer la taille!!!

ch_carac::   
             .DC.b 'FORCE         : '
             .DC.b '000',0
             .DC.b 'INTELLIGENCE  : '
             .DC.b '000',0
             .DC.b 'VITALITE      : '
             .DC.b '000',0
             .DC.b 'PERCEPTION    : '
             .DC.b '000',0
             .DC.b 'REFLEXE       : '
             .DC.b '000',0
             .DC.b 'CHARISME      : '
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
             .DC.b 'DIAGNOSTIC',0,0
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
             .DC.b '  PRESSIONS  : '
             .DC.b '00.00 ',0
             .DC.b '  $#$#$#$#$#-$#$#$#$#',0
             .DC.b '  ETAT CORPOREL:     ',0
             .DC.b '**                   ',0
             .DC.b '  $#$#$#$#$#-$#$#$#$#',0
             .DC.b '  MANGER             ',0
             .DC.b '  BOIRE              ',0
             .DC.b '  DORMIR             ',0
             .DC.b '  SE SOIGNER         ',0
             .DC.b '                     ',0
             .DC.b '                     ',0
ch_etat::    
             .DC.b '  DANGER            '
             .DC.b '  CRITIQUE          '
             .DC.b '  PREOCCUPANT       '
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
             .DC.b ' LIER  ',0
             .DC.b ' EFF   ',0
ch_nom_icone::         
             .DC.b '       ',0
             .DC.b 'AFFICHE',0
             .DC.b 'ALERTER',0
             .DC.b 'INC    ',0
             .DC.b 'DEC    ',0
             .DC.b 'ANALYSE',0
             .DC.b 'MOI    ',0
             .DC.b 'HUMAIN ',0
             .DC.b 'FORCE  ',0
             .DC.b 'INTELLI',0
             .DC.b 'VITALIT',0
             .DC.b 'PERCEPT',0
             .DC.b 'REFLEXE',0
             .DC.b 'CHARISM',0
             .DC.b 'FAIM   ',0
             .DC.b 'SOIF   ',0
             .DC.b 'FATIGUE',0
             .DC.b 'ETAT   ',0
             .DC.b 'TEMPERA',0
             .DC.b 'PRESSIO',0
             .DC.b 'ATS 34 ',0
             .DC.b 'FIBRINE',0
             .DC.b 'HYPERCP',0
             .DC.b 'MORPHO ',0
             .DC.b 'PSY    ',0
             .DC.b '       ',0
             .DC.b 'HEURE  ',0
             .DC.b 'RYTHME ',0
             .DC.b '+FORT  ',0
             .DC.b '+FAIBLE',0
             .DC.b 'NORMAL ',0
             .DC.b 'AGRESSI',0
             .DC.b 'ALARME ',0
             .DC.b 'SHEDISH',0
             .DC.b 'TRADUIR',0
             .DC.b '       ',0
; textes de la boite de dialogue
dbafoui::    
             .DC.b 'OUI',0
dbafnon::    
             .DC.b 'NON',0
dbafconf::   
             .DC.b 'CONFIRMATION',0,0
; textes de la boite d'alarme
alarmaf::    
             .DC.b '   ALARME   ',0,0
             .DC.b '      :     ',0,0
             .DC.b '  % %   % % ',0,0
             .DC.b '  & &   & & ',0,0
             .DC.b '    EXIT    ',0,0


;---------------------------------------------------------------
;                      textes pour OBJINFO
;---------------------------------------------------------------
; 12 caracteres maximum

oit1::       .DC.b "VALEUR",0
oit2::       .DC.b "D'EQUIPEMENT",0
oit3::       .DC.b "NOMINALE: ",0           ;XX

oit4::       .DC.b "NUMERO",0
oit5::       .DC.b "D'APPEL:",0             ;XXXX
oit6::       .DC.b "DERNIER",0
oit7::       .DC.b "NUMERO: ",0             ;XXXX

oit8::       .DC.b "BANDE VIERGE",0
oit9::       .DC.b "BANDE",0
oit10::      .DC.b "ENREGISTREE",0

oit11::      .DC.b "EQUIVALENT",0
oit12::      .DC.b "EAU: ",0
oit13::      .DC.b "ALCOOL:",0
oit14::      .DC.b " GRAMMES",0

oit15::      .DC.b "PROGRAMMEE",0
oit16::      .DC.b "POUR PLAN DE",0
oit17::      .DC.b "BANQUE",0
oit18::      .DC.b "PROGRAMMEE",0
oit19::      .DC.b "POUR",0
oit20::      .DC.b "FABRICATION",0
oit21::      .DC.b "VERRE CODEUR",0

oit22::      .DC.b "COEF DE",0
oit23::      .DC.b "PERFORATION:",0
oit24::      .DC.b "NOMBRE DE",0
oit25::      .DC.b "COUPS: ",0              ;XXXX

oit26::      .DC.b "PORTEE: ",0             ;XXXX
oit27::      .DC.b "ETAT:",0
oit28::      .DC.b "HORS SERVICE",0
oit29::      .DC.b "MEDIOCRE",0
oit30::      .DC.b "MOYEN",0
oit31::      .DC.b "BON",0
oit32::      .DC.b "NEUF",0

oit33::      .DC.b "SOLDE:",0
oit34::      .DC.b " CRED.",0               ;XXXXXX

oit35::      .DC.b " TITRES",0

oit36::      .DC.b "VALEUR",0
oit37::      .DC.b "ENERGETIQUE:",0
oit38::      .DC.b " KCAL",0

aa1::        .DC.b "PRIX: ",0
             .EVEN 
aa2::        .DC.b "CONTENU: ",0
             .EVEN 


;40 caracteres max!!!!


;--------- TEXTE DANS LES PUITS DE BANAFOOSH  ----------
;7 lignes
banafoosh::  
             .DC.b "VOUS AVEZ TROUVE L'HABITATION",0
             .DC.b " DE BANAFOOSH.",0
             .DC.b "DANS SON CONTAINER DE SURVIE,",0
             .DC.b " VOUS TROUVEZ LES 100 TITRES RECHERCHES:",0
             .DC.b "VOUS POUVEZ MAINTENANT RETOURNER",0
             .DC.b "SUR SHEDISHAN ET",0
             .DC.b "VOUS PRESENTER DEVANT LE PRETEUR.",0
;--------- TEXTE DE LA FIN DE LA 1ERE PARTIE  ----------
;"****************************************"
;  24 lignes
txpartie1::  
             .DC.b "A L'ASTROPORT DE ROMA II,",0
             .DC.b "VOUS ETES INTERPELLE PUIS",0
             .DC.b "ARRETE PAR DES CATAPHRACTAIRES.",0
             .DC.b " ",0

             .DC.b "VOUS ETES EMPRISONNE DE SUITE",0
             .DC.b "SANS AUCUNE EXPLICATION...",0
             .DC.b "APRES QUELQUES JOURS, ON VOUS EMMENE",0
             .DC.b "DANS UNE SALLE D'AUDIENCE",0
             .DC.b "POUR Y ETRE JUGE.",0
             .DC.b "VOUS ETES ACCUSE DU MEURTRE",0
             .DC.b "DE SYLVIA HADFORD, RETROUVEE",0
             .DC.b "ETRANGLEE AU MANOIR DE MANTOUE.",0
             .DC.b "LES PREUVES (FABRIQUEES DE TOUTE PIECE A",0
             .DC.b "L'EVIDENCE) SONT IRREFUTABLES.",0
             .DC.b "APRES UN PROCES GROTESQUE ET DESASTREUX",0
             .DC.b "VOUS ETES CONDAMNE A DIX ANNEES DE BAGNE",0
             .DC.b "OU VOUS DEVREZ COMBATTRE DANS",0
             .DC.b "L'ARENE POUR SURVIVRE.",0
             .DC.b "IL NE VOUS RESTE QU'UNE SEULE CHANCE,",0
             .DC.b "ETRE MEILLEUR QUE LES AUTRES",0
             .DC.b "COMBATTANTS (LES TECHNOGLADS) ET DEVENIR",0
             .DC.b "L'IDOLE DES FOULES",0
             .DC.b "POUR (PEUT ETRE) AVOIR",0
             .DC.b "LA CHANCE D'ETRE GRACIE PAR LE ROI...",0


;--------- TEXTES DE LA FIN DE LA 2EME PARTIE  ----------
;"****************************************"
; 18 lignes
partie2a::   
             .DC.b "VOTRE POPULARITE EST A SON PAROXISME,",0
             .DC.b "SELON LA LOI, VOUS ETES",0
             .DC.b "PRESENTE AU ROI POUR ETRE GRACIE MAIS,",0
             .DC.b "COMBLE DE STUPEUR,",0
             .DC.b "CELUI-CI REFUSE OBSTINEMENT DE LE FAIRE.",0
             .DC.b "C'EST A CE MOMENT QUE, DESESPERE,",0
             .DC.b "VOUS LUI PLONGEZ LA SONDE DE DOULEUR",0
             .DC.b "DANS L'ESTOMAC AVEC LA CHARGE MAXIMALE",0
             .DC.b "ET QU'AU LIEU D'UN CRI DE DOULEUR,",0
             .DC.b "UNE VERITABLE PETITE EXPLOSION",0
             .DC.b "SE PRODUIT.",0
             .DC.b "UN SILENCE GLACIAL S'EN SUIT,",0
             .DC.b "LE ROI QUI GIT DEVANT VOUS, MORT,",0
             .DC.b "N'EST PAS UN ROI COMME LES AUTRES,",0
             .DC.b "CE N'EST QU'UNE MACHINE, UN ENSEMBLE DE",0
             .DC.b "FILS ET DE CIRCUITS, UN SHEDROIDE !!!",0
             .DC.b "A CE MOMENT VOUS PERDEZ CONNAISSANCE,",0
             .DC.b "ASSOMME PAR UN GARDE.",0
partie2b::   
; 1 ligne
             .DC.b "PLUS TARD...",0         ; texte milieu
; 144 lignes
partie2c::   
             .DC.b "VOUS VOUS REVEILLEZ,",0
             .DC.b "ET AU LIEU D'UNE PRISON",0
             .DC.b "SOMBRE ET SORDIDE VOUS",0
             .DC.b "ETES ALLONGE DANS UNE LUXUEUSE SALLE,",0
             .DC.b "DANS UN LIT RECOUVERT DE DRAPS",0
             .DC.b "QUI SEMBLENT ETRE EN SATIN...",0
             .DC.b "PEU DE TEMPS APRES UNE PORTE S'OUVRE,",0
             .DC.b "UN SHEDISH CURIEUSEMENT HABILLE",0
             .DC.b "ENTRE DANS LA CHAMBRE ET VIENT S'ASSEOIR",0
             .DC.b "PRES DU LIT.",0
             .DC.b "'BAL'AMAYE EQUITES MENASIS,",0
             .DC.b "NE BOUGEZ PAS,",0
             .DC.b "VOUS ETES ENCORE SOUS LE CHOC.",0
             .DC.b "SOYEZ SUR QUE VOUS ETES EN SECURITE ICI,",0
             .DC.b "AU PALAIS.  CELA FAIT CINQ JOURS",0
             .DC.b "QUE VOUS ETES INCONSCIENT",0
             .DC.b "ET NOUS AVONS EU TRES PEUR POUR VOUS!",0
             .DC.b " ",0
             .DC.b "BEAUCOUP DE CHOSES SE SONT PRODUITES",0
             .DC.b "DEPUIS VOTRE... REGRETTABLE ACCIDENT...",0
             .DC.b "IL FAUT D'ABORD QUE JE VOUS DISE",0
             .DC.b "QUE VOUS PASSEZ POUR ETRE UN HEROS,",0
             .DC.b "VOUS ETES L'HOMME QUI A DEMASQUE",0
             .DC.b "L'INCROYABLE COMPLOT.",0
             .DC.b "IL A ETE IMAGINE PAR CERTAINS HOMMES",0
             .DC.b "DE LA KOSHAN POUR SE PROCURER",0
             .DC.b "L'INTEGRALITE DES TITRES ROYAUX",0
             .DC.b "DE BEDIHN 6 AFIN QUE LE POUVOIR ROYAL",0
             .DC.b "NE PUISSE EN AUCUN CAS S'OPPOSER",0
             .DC.b "A LEURS AGISSEMENTS.",0
             .DC.b "JE DOIS DIRE, COMME",0
             .DC.b "SES PROCHES LE PRETENDAIENT AUSSI,",0
             .DC.b "QUE L'ATTITUDE DU ROI AVAIT RADICALEMENT",0
             .DC.b "CHANGE CES DERNIERS TEMPS,",0
             .DC.b "MAIS DE LA A PENSER QU'IL NE POUVAIT",0
             .DC.b "ETRE QU'UNE VULGAIRE MACHINE,",0
             .DC.b "UN DROIDE !!!",0
             .DC.b "SANS VOULOIR COMPLIMENTER LA KOSHAN,",0
             .DC.b "ILS AVAIENT FAIT DU BON TRAVAIL,",0
             .DC.b "LA REPLIQUE ETAIT PARFAITE...",0
             .DC.b "OH, EXCUSEZ MON IMPOLITESSE,",0
             .DC.b "JE SUIS LE BOODISH ANAMEEH,",0
             .DC.b "JE DIRIGE TOUS LES ORDRES RELIGIEUX",0
             .DC.b "DE SHEDISHAN ET POUR L'INSTANT,",0
             .DC.b "JE M'OCCUPE AUSSI DE SA POLITIQUE.",0
             .DC.b "D'AUTRES EVENEMENTS SE SONT PRODUITS,",0
             .DC.b "JE CROIS QUE VOS COMPATRIOTES",0
             .DC.b "APPELLENT CELA UNE 'REVOLUTION'.",0
             .DC.b "VOTRE SENAT N'EXISTE PLUS:",0
             .DC.b "APRES LA MORT DU ROI,",0
             .DC.b "LA POPULATION S'EST SOULEVEE,",0
             .DC.b "HUMAINS ET SHEDISHS S'EN SONT PRIS",0
             .DC.b "AU GOUVERNEMENT",0
             .DC.b "ET A LA KOSHAN, J'AI EU BIEN DU MAL A",0
             .DC.b "CALMER TOUT LE MONDE.",0
             .DC.b "CELA VA MIEUX MAINTENANT.",0
             .DC.b "CE QUI EST MOINS REJOUISSANT,",0
             .DC.b "COMPTE TENU DE VOS INTERETS SUR BEDIHN 6",0
             .DC.b "LE VIEUX ZAKK KOSHAN VIT TOUJOURS,",0
             .DC.b "IL DIRIGE MEME SA SOCIETE.",0
             .DC.b "PAR UN HABILE STRATAGEME",0
             .DC.b "DONT LUI SEUL A LE SECRET,",0
             .DC.b "IL A REUSSI A TROUVER UN BOUC EMISSAIRE",0
             .DC.b "EN LA PERSONNE DE SON BRAS DROIT :",0
             .DC.b "ANGUS BOOMAKER. AU PROCES QUE",0
             .DC.b "NOUS AVONS  ORGANISE POUR L'INCULPER,",0
             .DC.b "NOUS NE SOMMES PAS ARRIVES A DEMONTER",0
             .DC.b "SES ARGUMENTS ET IL EUT ETE TROP",0
             .DC.b "DANGEREUX DE L'EXECUTER SANS PREUVES,",0
             .DC.b "COMPTE TENU DE LA GRANDE TENSION",0
             .DC.b "ACTUELLE...",0
             .DC.b "SACHEZ LE PLUS IMPORTANT MAINTENANT,",0
             .DC.b "SELON LA LOI SHEDISH VOUS POUVEZ",0
             .DC.b "A VOTRE GUISE DEVENIR ROI DE SHEDISHAN",0
             .DC.b "OU DESIGNER UN SUCCESSEUR. JE NE",0
             .DC.b "PUIS QUE VOUS CONJURER DE BIEN REFLECHIR",0
             .DC.b "POUR L'AVENIR DE NOTRE PEUPLE...",0
             .DC.b "A PRESENT JE VOUS LAISSE VOUS REPOSER,",0
             .DC.b "VOUS TROUVEREZ ICI",0
             .DC.b "TOUT CE DONT VOUS AUREZ BESOIN,",0
             .DC.b "AINSI QUE VOS AFFAIRES, RETROUVEES",0
             .DC.b "DANS UN HOTEL DU QUARTIER TOURISTIQUE...",0
             .DC.b "MOSH ID'AL FAROUM'",0
             .DC.b " ",0
             .DC.b "PEU DE TEMPS APRES LA SORTIE DU SHEDISH",0
             .DC.b "LE RESEAU RELAIS DU BAT SE DECLENCHE",0
             .DC.b "ET UN HOLOGRAMME TRIDIMENTIONNEL",0
             .DC.b "APPARAIT, IL DIT:",0
             .DC.b " ",0
             .DC.b "'NOUS AVONS DEJA UN AGENT DISPONIBLE",0
             .DC.b "SUR SHEDISHAN POUR VOUS",0
             .DC.b "REMPLACER SUR LE TRONE, PAR CHANCE,",0
             .DC.b "NOUS AVIONS PREVU CETTE EVENTUALITE.",0
             .DC.b "VOUS DEVREZ DONC ABDIQUER EN SA FAVEUR,",0
             .DC.b "MAIS VOTRE MISSION N'EST PAS FINIE...",0
             .DC.b " ",0
             .DC.b "LA KOSHAN EXISTE TOUJOURS,",0
             .DC.b "ELLE DETIENT TOUJOURS LE MONOPOLE DE",0
             .DC.b "L'ECHIATONE,",0
             .DC.b "VOUS DEVEZ L'ANEANTIR COUTE QUE COUTE...",0
             .DC.b "VOICI NOTRE PLAN:",0
             .DC.b "REDIGEZ VOTRE ABDICATION ET METTEZ LA",0
             .DC.b "DANS UNE ENVELOPPE A L'ATTENTION",0
             .DC.b "DE CE BOODISH, EXPLIQUEZ AU PASSAGE VOS",0
             .DC.b "SOUPCONS CONCERNANT LA KOSHAN,",0
             .DC.b "DITES QUE VOTRE VIE EST EN DANGER...",0
             .DC.b "NOTRE AGENT DESTINE A ETRE ROI VOUS",0
             .DC.b "FOURNIRA UN CONTRAT A VOTRE NOM.",0
             .DC.b "UN TUEUR A GAGES A ETE CONTACTE",0
             .DC.b "POUR VOUS TUER, LE TUEUR CROIT QUE",0
             .DC.b "C'EST KOSHAN QUI L'A CONTACTE.",0
             .DC.b "QUAND SIED ASHAR, NOTRE AGENT SHEDISH,",0
             .DC.b "SERA LA,",0
             .DC.b "VOUS POURREZ PARTIR POUR LA CITE.",0
             .DC.b "VOUS DEVREZ VOUS RENDRE DANS L'IMMEUBLE",0
             .DC.b "DE LA KOSHAN CETTE NUIT ET Y INTRODUIRE",0
             .DC.b "LE FAUX CONTRAT DANS LE COFFRE PERSONNEL",0
             .DC.b "DE ZAKK KOSHAN. NOTRE TUEUR DISPOSE",0
             .DC.b "DU MEME CONTRAT, IL NOUS SERA DONC",0
             .DC.b "FACILE DE CONFONDRE PAR LA SUITE CE",0
             .DC.b "SCELERAT DE KOSHAN.",0
             .DC.b "POUR VOTRE ABDICATION PUBLIQUE,",0
             .DC.b "FAITES EN SORTE QUE TOUT LE PEUPLE",0
             .DC.b "SOIT LA, VOTRE MORT DOIT ETRE GRANDIOSE.",0
             .DC.b "FAITES UN DISCOURS VANTANT LES MERITES DU",0
             .DC.b "PEUPLE, C'EST A CE MOMENT",0
             .DC.b "QUE LE TUEUR FRAPPERA, DEVANT TOUT LE",0
             .DC.b "MONDE...",0
             .DC.b "VOUS MORT,",0
             .DC.b "ASHAR ENVERRA SES FRONDEURS",0
             .DC.b "PERQUISITIONNER CHEZ KOSHAN. CETTE FOIS,",0
             .DC.b "IL NE POURRA PAS S'EN SORTIR,",0
             .DC.b "ASHAR Y VEILLERA.",0
             .DC.b "ENFIN,",0
             .DC.b "PROCUREZ-VOUS DE BONNES PROTECTIONS,",0
             .DC.b "CAR VOUS DEVEZ SIMULER VOTRE MORT.",0
             .DC.b "SI CELA PEUT VOUS CONSOLER,",0
             .DC.b "LES HEROS ONT",0
             .DC.b "TOUJOURS DE MAGNIFIQUES OBSEQUES...",0
             .DC.b "BONNE CHANCE.'",0
             .DC.b "QUELQUE TEMPS APRES, ASHAR",0
             .DC.b "SE PRESENTE A VOUS ET VOUS DONNE LE FAUX",0
             .DC.b "CONTRAT",0
             .DC.b "L'AVENTURE CONTINUE...",0
;--------- TEXTE DES OBSEQUES  ----------
;"****************************************"
; 36 lignes
obseques::   
             .DC.b "COMMUNIQUE DE PRESSE SUR ROMA NEWS:",0
             .DC.b "(...) L'ENTERREMENT",0
             .DC.b "DU HEROS NATIONAL JEHAN MENASIS S'EST",0
             .DC.b "DEROULE DANS UNE CONSTERNATION GENERALE.",0
             .DC.b "ON POUVAIT LIRE, SUR LES VISAGES",0
             .DC.b "SHEDISH OU HUMAINS,",0
             .DC.b "UNE TRISTESSE SANS PAREILLE,",0
             .DC.b "MAIS RAPPELONS A NOS AUDITEURS",0
             .DC.b "LES EVENEMENTS DRAMATIQUES QUI VIENNENT",0
             .DC.b "DE SE DEROULER...",0
             .DC.b "HIER, ALORS QUE SE DEROULAIT",0
             .DC.b "UN GRAND RASSEMBLEMENT POPULAIRE",0
             .DC.b "ORGANISE PAR CELUI QU'ON SURNOMMAIT DEJA",0
             .DC.b "'JEHAN LE GRAND'",0
             .DC.b "UN IGNOBLE ATTENTAT FUT COMMIS",0
             .DC.b "AU MOMENT MEME OU IL ALLAIT ABDIQUER EN",0
             .DC.b "LA FAVEUR DU GRAND ASHAR PREMIER,",0
             .DC.b "LE BLESSANT MORTELLEMENT.",0
             .DC.b "L'ASSASSIN FUT VITE APPREHENDE",0
             .DC.b "ET IL FALLUT PEU DE TEMPS A LA",0
             .DC.b "NOUVELLE JUSTICE MISE EN PLACE PAR NOTRE",0
             .DC.b "GRAND BECHIR POUR CONFONDRE",0
             .DC.b "LE DETESTABLE KOSHAN,",0
             .DC.b "DEJA IMPLIQUE DANS LES RECENTS",0
             .DC.b "EVENEMENTS DU COMPLOT...",0
             .DC.b "L'ASSASSIN A RECONNU AVOIR ETE EN",0
             .DC.b "CONTACT AVEC KOSHAN, UN CONTRAT",0
             .DC.b "A MEME ETE RETROUVE DANS LE PROPRE",0
             .DC.b "COFFRE DE CELUI-CI...",0
             .DC.b "TOUS LES BIENS DE KOSHAN ONT ETE SAISIS",0
             .DC.b "PAR L'ETAT.",0
             .DC.b "ZAKK KOSHAN A ETE APPREHENDE CE MATIN,",0
             .DC.b "ALORS QU'IL TENTAIT",0
             .DC.b "DE S'ENFUIR DE NOTRE PLANETE,",0
             .DC.b "SON PROCES AURA LIEU AUX PROCHAINES",0
             .DC.b "CALENDES (...)",0

;--------- TEXTE DE LA DERNIERE IMAGE  ----------
txtfin::     
             .DC.b "TO BE CONTINUED...",0

txglad1::    
             .DC.b "VOUS DEVEZ VOUS ENTRAINER",0
             .DC.b "POUR DEVENIR UN TECHNOGLAD APTE A",0
             .DC.b "RESISTER DANS L'ARENE.",0
             .DC.b "VOUS DEVEZ AFFRONTER LE MYRMIDROID,",0
             .DC.b "UN ROBOT SPECIALEMENT CONCU",0
             .DC.b "POUR VOUS ENTRAINER,",0
             .DC.b "TANT QUE VOUS NE L'AUREZ PAS BATTU,",0
             .DC.b "VOUS NE SEREZ PAS UN VERITABLE",0
             .DC.b "TECHNOGLAD...",0
txglad2::    
             .DC.b "C'EST LE GRAND JOUR DES JEUX !",0
             .DC.b " AFFRONTEZ LES TECHNOGLADS DANS",0
             .DC.b "L'ARENE DE ROMA II.",0
             .DC.b " SAMNITES, RETIAIRES ET THRACE",0
             .DC.b "  VONT VOUS DONNER DU FIL A RETORDRE",0
             .DC.b " MAIS LA VICTOIRE ET LA POPULARITE",0
             .DC.b "SONT LES SEULES ISSUES",0
             .DC.b "VERS LA LIBERTE !!!",0
             .EVEN 



;---------------------------------------------------------------
;---------------------------------------------------------------
;---------------------------------------------------------------
; rajouts apres traduction...
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



