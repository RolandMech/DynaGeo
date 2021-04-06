<?xml version="1.0"?>
<dg:drawing xmlns:dg="http://www.dynageo.com/xml/dg12" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.dynageo.com/xml/dg12 http://www.dynageo.com/xml/dg12.xsd"><header><created prog_name="EUKLID DynaGeo" prog_version="2.5"/><edited prog_name="EUKLID DynaGeo" prog_version="3.8.0.61" date="2013-02-16T11:55:42"/></header><windowdata><log_window xmin="-9.50383222455292" xmax="14.6684982886752" ymin="-8.3608323579029" ymax="5.90549931102509"/><scr_window width="1142" height="674"/><startfont fontname="Arial" fontsize="10"/><options AreaDecimals="1" DefLocLineStatus="3"/></windowdata><objlist><Origin id="1" name="O" cosys_type="1"><appearance color="$00C0C0C0" brush_style="0"/><position x="0" y="0"/></Origin><Axis id="2" name="xa" label="x"><appearance color="$00C0C0C0"/><parents>1</parents><position x1="0" y1="0" x2="100" y2="0"/></Axis><Axis id="3" name="ya" label="y"><appearance color="$00C0C0C0"/><parents>1</parents><position x1="0" y1="0" x2="0" y2="100"/></Axis><UnityPoint id="4" name="X_1"><appearance color="$00C0C0C0" brush_style="0" visible="false"/><parents>2</parents><position x="1" y="0"/></UnityPoint><UnityPoint id="5" name="Y_1"><appearance color="$00C0C0C0" brush_style="0" visible="false"/><parents>3</parents><position x="0" y="1"/></UnityPoint><Number id="7" name="A" show_name="true"><appearance color="$00808080" shape="2"/><position x="-9.03816561221401" y="5.56683268386952" width="250" height="33"/><value min="-0.5" actual="0.02" max="0.5" quant="0.01" ani_step="0.001"/></Number><Number id="9" name="B" show_name="true"><appearance color="$00808080" shape="2"/><position x="-9.03816561221401" y="4.78366610857229" width="250" height="33"/><value min="-1" actual="0.09" max="2" quant="0.01" ani_step="0.001"/></Number><Number id="11" name="C" show_name="true"><appearance color="$00808080" shape="2"/><position x="-9.03816561221401" y="4.00049953327505" width="250" height="33"/><value min="-2" actual="-0.6" max="3" quant="0.1" ani_step="0.001"/></Number><Number id="13" name="D" show_name="true"><appearance color="$00808080" shape="2"/><position x="-9.03816561221401" y="3.21733295797782" width="250" height="33"/><value min="-3" actual="-2.2" max="5" quant="0.1" ani_step="0.001"/></Number><Point id="14" name="Z"><appearance color="$00FF0000" brush_style="0" add_name2name="true"/><parents>2</parents><position x="-1.54516648639725" y="0"/></Point><ObjectName id="15" name="dummy"><appearance color="$00FF0000"/><parents>14</parents><position x="-1.60866648639725" y="-0.211666666666667" width="4.76249944437507" height="2.24366640490559"/><text><![CDATA[<font face="Arial" size="10"> Z</font>]]></text></ObjectName><PointWDC id="16" name="P"><appearance color="$000000FF" shape="3" brush_style="0" add_name2name="true"/><parents>1;14;7;9;11;13</parents><position x="-1.54516648639725" y="-1.13180447530105" x_term="x(Z)" y_term="( ( val(A)*x + val(B) )*x + val(C) )*x + val(D)"/></PointWDC><Trace id="17" name="OL1" trace_status="7"><appearance color="$000000FF"/><parents>14;16</parents><points>-11.3980203375564;-13.2842957766987;-11.3980203375564 -10.8497711858067;-10.6397254972747;-10.8497711858067 -10.5756466099318;-9.44514102476745;-10.5756466099318 -10.4385843219944;-8.8786925133415;-10.4385843219944 -10.301522034057;-8.33239450723932;-10.301522034057 -10.2329908900883;-8.06670538636559;-10.2329908900883 -10.1644597461196;-7.80593802303991;-10.1644597461196 -10.1301941741352;-7.67738793079271;-10.1301941741352 -10.0959286021508;-7.55005379433467;-10.0959286021508 -10.0787958161587;-7.48684120081848;-10.0787958161587 -10.0616630301665;-7.42393078579984;-10.0616630301665 -10.0530966371704;-7.39258870663859;-10.0530966371704 -10.0445302441743;-7.36132194579551;-10.0445302441743 -10.0359638511782;-7.3301304278352;-10.0359638511782 -10.0273974581821;-7.29901407732225;-10.0273974581821 -9.89033517024471;-6.81131368666535;-9.89033517024471 -9.75327288230728;-6.34252786764818;-9.75327288230728 -9.61621059436986;-5.89234763684976;-9.61621059436986 -9.47914830643243;-5.46046401084905;-9.47914830643243 -9.342086018495;-5.04656800622507;-9.342086018495 -9.27355487452629;-4.84626880461029;-9.27355487452629 -9.20502373055757;-4.65035063955681;-9.20502373055757 -9.06796144262015;-4.27150292742325;-9.06796144262015 -8.93089915468272;-3.90971588640339;-8.93089915468272 -8.79383686674529;-3.56468053307622;-8.79383686674529 -8.72530572277658;-3.39834818197833;-8.72530572277658 -8.69104015079222;-3.31671144028997;-8.69104015079222 -8.65677457880787;-3.23608788402073;-8.65677457880787 -8.51971229087044;-2.92362895581593;-8.51971229087044 -8.45118114690172;-2.77335307971346;-8.45118114690172 -8.38265000293301;-2.62699476504079;-8.38265000293301 -8.3141188589643;-2.48451538887028;-8.3141188589643 -8.24558771499558;-2.34587632827431;-8.24558771499558 -8.17705657102687;-2.21103896032526;-8.17705657102687 -8.14279099904251;-2.14503384142844;-8.14279099904251 -8.12565821305034;-2.11238256105811;-8.12565821305034 -8.10852542705816;-2.07996466209549;-8.10852542705816 -8.03999428308945;-1.95261481065739;-8.03999428308945 -7.97146313912073;-1.82895078308332;-7.97146313912073 -7.90293199515202;-1.70893395644567;-7.90293199515202 -7.86866642316766;-1.65028117381311;-7.86866642316766 -7.8344008511833;-1.5925257078168;-7.8344008511833 -7.76586970721459;-1.47968741426908;-7.76586970721459 -7.69733856324588;-1.3703804528749;-7.69733856324588 -7.62880741927716;-1.26456620070663;-7.62880741927716 -7.59454184729281;-1.21295677091732;-7.59454184729281 -7.57740906130063;-1.18747436790502;-7.57740906130063 -7.56027627530845;-1.16220603483663;-7.56027627530845 -7.49174513133974;-1.06326133233729;-7.49174513133974 -7.42321398737102;-0.967693470280983;-7.42321398737102 -7.35468284340231;-0.875463825740076;-7.35468284340231 -7.32041727141795;-0.830588765373014;-7.32041727141795 -7.30328448542577;-0.808459063473979;-7.30328448542577 -7.2861516994336;-0.786533775786946;-7.2861516994336 -7.21762055546488;-0.700864697493967;-7.21762055546488 -7.18335498348053;-0.659240953055151;-7.18335498348053 -7.14908941149617;-0.618417967933515;-7.14908941149617 -7.11482383951181;-0.578390914263102;-7.11482383951181 -7.08055826752746;-0.53915496417796;-7.08055826752746 -7.0462926955431;-0.500705289812137;-7.0462926955431 -7.02915990955092;-0.48177379731586;-7.02915990955092 -7.02059351655483;-0.472381123215461;-7.02059351655483 -7.01631032005679;-0.467703021199206;-7.01631032005679 -7.01202712355874;-0.463037063299681;-7.01202712355874 -6.97776155157439;-0.426145456774635;-6.97776155157439 -6.94349597959003;-0.390025642371048;-6.94349597959003 -6.90923040760567;-0.354672792222966;-6.90923040760567 -6.89209762161349;-0.337282470036629;-6.89209762161349 -6.87496483562131;-0.320082078464438;-6.87496483562131 -6.84069926363696;-0.286248673229507;-6.84069926363696 -6.8064336916526;-0.253167748652222;-6.8064336916526 -6.77216811966824;-0.22083447686663;-6.77216811966824 -6.75503533367607;-0.204946702062608;-6.75503533367607 -6.74646894067998;-0.197072265908872;-6.74646894067998 -6.73790254768389;-0.189244030006778;-6.73790254768389 -6.70363697569953;-0.158391580206711;-6.70363697569953 -6.66937140371517;-0.128272299600477;-6.66937140371517 -6.63510583173082;-0.0988813603221219;-6.63510583173082 -6.61797304573864;-0.0844575099727884;-6.61797304573864 -6.60084025974646;-0.0702139345056945;-6.60084025974646 -6.5665746877621;-0.042265194285239;-6.5665746877621 -6.53230911577775;-0.0150303117948032;-6.53230911577775 -6.49804354379339;0.0114955408315658;-6.49804354379339 -6.48091075780121;0.0244940896538357;-6.48091075780121 -6.47234436480512;0.0309275337161607;-6.47234436480512 -6.46806116830708;0.0341278311631115;-6.46806116830708 -6.46377797180903;0.0373171914598203;-6.46377797180903 -6.42951239982468;0.0624394679559162;-6.42951239982468 -6.39524682784032;0.0868671981858049;-6.39524682784032 -6.36098125585596;0.11060521001544;-6.36098125585596 -6.34384846986378;0.122217080238272;-6.34384846986378 -6.32671568387161;0.133658331310774;-6.32671568387161 -6.29245011188725;0.156031389937761;-6.29245011188725 -6.25818453990289;0.177729213762354;-6.25818453990289 -6.22391896791854;0.198756630650507;-6.22391896791854 -6.20678618192636;0.209020445201529;-6.20678618192636 -6.19821978893027;0.214090143027695;-6.19821978893027 -6.18965339593418;0.219118468468173;-6.18965339593418 -6.15538782394982;0.238819555081303;-6.15538782394982 -6.12112225196547;0.257864718355854;-6.12112225196547 -6.08685667998111;0.276258786157776;-6.08685667998111 -6.06972389398893;0.285213167964612;-6.06972389398893 -6.05259110799675;0.294006586353024;-6.05259110799675 -6.0183255360124;0.31111294680755;-6.0183255360124 -5.98405996402804;0.327582695387309;-5.98405996402804 -5.94979439204368;0.343420659958253;-5.94979439204368 -5.9326616060515;0.35110423194853;-5.9326616060515 -5.92409521305541;0.354887429393789;-5.92409521305541 -5.91981201655737;0.356764413981938;-5.91981201655737 -5.91552882005933;0.358631668386335;-5.91552882005933 -5.88126324807497;0.373220548537509;-5.88126324807497 -5.84699767609061;0.387192128277728;-5.84699767609061 -5.81273210410625;0.400551235472945;-5.81273210410625 -5.79559931811408;0.407002620574288;-5.79559931811408 -5.7784665321219;0.413302697989113;-5.7784665321219 -5.74420096013754;0.425451343692186;-5.74420096013754 -5.70993538815318;0.437002000448118;-5.70993538815318 -5.67566981616883;0.44795949612286;-5.67566981616883 -5.65853703017665;0.453217317262896;-5.65853703017665 -5.64997063718056;0.455791260182499;-5.64997063718056 -5.64140424418447;0.458328658582366;-5.64140424418447 -5.60713867220012;0.46811431569259;-5.60713867220012 -5.57287310021576;0.477321295319485;-5.57287310021576 -5.5386075282314;0.485954425329005;-5.5386075282314 -5.52147474223922;0.490057305435359;-5.52147474223922 -5.50434195624704;0.494018533587101;-5.50434195624704 -5.47007638426269;0.501518447959727;-5.47007638426269 -5.43581081227833;0.508458996312839;-5.43581081227833 -5.40154524029397;0.514845006512386;-5.40154524029397 -5.3844124543018;0.517831568512685;-5.3844124543018 -5.37584606130571;0.519273502761884;-5.37584606130571 -5.37156286480766;0.519981666201736;-5.37156286480766 -5.36727966830962;0.520681306424325;-5.36727966830962 -5.33301409632526;0.525972723914605;-5.33301409632526 -5.2987485243409;0.530724086849184;-5.2987485243409 -5.26448295235655;0.534940223094013;-5.26448295235655 -5.24735016636437;0.53684908991588;-5.24735016636437 -5.23021738037219;0.538625960515044;-5.23021738037219 -5.19595180838783;0.541786126978232;-5.19595180838783 -5.16168623640348;0.544425550349529;-5.16168623640348 -5.12742066441912;0.54654905849489;-5.12742066441912 -5.11028787842694;0.547418853065954;-5.11028787842694 -5.10172148543085;0.547806024500002;-5.10172148543085 -5.09315509243476;0.548161479280267;-5.09315509243476 -5.05888952045041;0.549267640571613;-5.05888952045041 -5.02462394846605;0.549872370234882;-5.02462394846605 -4.99035837648169;0.549980496136026;-4.99035837648169 -4.97322559048951;0.549849841383912;-4.97322559048951 -4.95609280449734;0.549596846141;-4.95609280449734 -4.92182723251298;0.548726248115756;-4.92182723251298 -4.88756166052862;0.547373529926249;-4.88756166052862 -4.85329608854427;0.545543519438429;-4.85329608854427 -4.83616330255209;0.544451038290763;-4.83616330255209 -4.827596909556;0.54386069276491;-4.827596909556 -4.82331371305795;0.543554526766969;-4.82331371305795 -4.81903051655991;0.543241044518251;-4.81903051655991 -4.78476494457555;0.54047093303167;-4.78476494457555 -4.7504993725912;0.537238012844636;-4.7504993725912 -4.71623380060684;0.533547111823105;-4.71623380060684 -4.69910101461466;0.531531427207512;-4.69910101461466 -4.68196822862248;0.529403057833028;-4.68196822862248 -4.64770265663813;0.524810678740359;-4.64770265663813 -4.61343708465377;0.519774802411052;-4.61343708465377 -4.57917151266941;0.51430025671106;-4.57917151266941 -4.56203872667723;0.511399991555168;-4.56203872667723 -4.55347233368114;0.509909374924666;-4.55347233368114 -4.54490594068506;0.508391869506336;-4.54490594068506 -4.5106403687007;0.502054468662833;-4.5106403687007 -4.47637479671634;0.495292882046504;-4.47637479671634 -4.44210922473198;0.488111937523304;-4.44210922473198 -4.42497643873981;0.484365714754737;-4.42497643873981 -4.40784365274763;0.480516462959184;-4.40784365274763 -4.37357808076327;0.472511286220099;-4.37357808076327 -4.33931250877891;0.464101235172;-4.33931250877891 -4.30504693679456;0.455291137680842;-4.30504693679456 -4.28791415080238;0.450737580227227;-4.28791415080238 -4.27934775780629;0.448423938347329;-4.27934775780629 -4.27506456130825;0.447257934622098;-4.27506456130825 -4.2707813648102;0.446085821612579;-4.2707813648102 -4.23651579282584;0.436490114833163;-4.23651579282584 -4.20225022084149;0.426508845208546;-4.20225022084149 -4.16798464885713;0.416146840604683;-4.16798464885713 -4.15085186286495;0.410824571393645;-4.15085186286495 -4.13371907687277;0.405408928887527;-4.13371907687277 -4.06518793290406;0.382824695577149;-4.06518793290406 -4.0309223609197;0.370988029715833;-4.0309223609197 -4.01378957492753;0.364935671674998;-4.01378957492753 -3.99665678893535;0.358794768205037;-3.99665678893535 -3.92812564496663;0.333357769698817;-3.92812564496663 -3.89386007298228;0.3201236884353;-3.89386007298228 -3.85959450099792;0.306552322986115;-3.85959450099792 -3.79106335702921;0.278417050994557;-3.79106335702921 -3.75679778504485;0.26386280018409;-3.75679778504485 -3.73966499905267;0.256466133266539;-3.73966499905267 -3.72253221306049;0.248990576651769;-3.72253221306049 -3.65400106909178;0.218311522885376;-3.65400106909178 -3.58546992512307;0.186418512623006;-3.58546992512307 -3.51693878115435;0.153350168792282;-3.51693878115435 -3.48267320917;0.136387316453671;-3.48267320917 -3.44840763718564;0.119145114320832;-3.44840763718564 -3.37987649321693;0.0838419721362813;-3.37987649321693 -3.31134534924821;0.0474793651662555;-3.31134534924821 -3.2428142052795;0.0100959163383809;-3.2428142052795 -3.20854863329514;-0.00896655410736624;-3.20854863329514 -3.19141584730296;-0.0185883636468382;-3.19141584730296 -3.17428306131078;-0.0282697514197161;-3.17428306131078 -3.03722077337336;-0.107793252016076;-3.03722077337336 -2.96868962940464;-0.148873838999087;-2.96868962940464 -2.90015848543593;-0.190782153201817;-2.90015848543593 -2.7630961974985;-0.276927471555932;-2.7630961974985 -2.69456505352979;-0.321087229852065;-2.69456505352979 -2.62603390956108;-0.365920223657414;-2.62603390956108 -2.35190933368622;-0.551212095418447;-2.35190933368622 -2.07778475781137;-0.744185901116861;-2.07778475781137 -1.52953560606166;-1.14329184485359;-1.52953560606166 -1.25541103018681;-1.3444802481558;-1.25541103018681 -0.981286454311952;-1.54346311592315;-0.981286454311952 -0.707161878437099;-1.7377685807876;-0.707161878437099 -0.570099590499672;-1.83239482857871;-0.570099590499672 -0.433037302562244;-1.92492477538108;-0.433037302562244 -0.295975014624817;-2.01504943777368;-0.295975014624817 -0.15891272668739;-2.10245983233553;-0.15891272668739 -0.0218504387499635;-2.1868469756456;-0.0218504387499635 0.04668070521875;-2.22781027076216;0.04668070521875 0.0809462772031068;-2.24796745165498;0.0809462772031068 0.115211849187464;-2.2679018842829;0.115211849187464 0.183742993156177;-2.30708319328019;0.183742993156177 0.252274137124891;-2.34531557482641;0.252274137124891 0.320805281093604;-2.38256040599393;0.320805281093604 0.355070853077961;-2.4008004205208;0.355070853077961 0.389336425062318;-2.41877906385513;0.389336425062318 0.457867569031031;-2.45393292548237;0.457867569031031 0.526398712999745;-2.48798336794805;0.526398712999745 0.594929856968458;-2.52089176832451;0.594929856968458 0.629195428952815;-2.53690563306442;0.629195428952815 0.646328214944993;-2.54480036938093;0.646328214944993 0.663461000937172;-2.55261950368416;0.663461000937172 0.731992144905885;-2.58312795109935;0.731992144905885 0.800523288874599;-2.61237848764245;0.800523288874599 0.869054432843312;-2.64033249038586;0.869054432843312 0.903320004827669;-2.65381122191779;0.903320004827669 0.920452790819847;-2.66042390803245;0.920452790819847 0.937585576812026;-2.66695133640193;0.937585576812026 1.00611672078074;-2.69219640276305;1.00611672078074 1.0403822927651;-2.70429169890811;1.0403822927651 1.07464786474945;-2.71602906654158;1.07464786474945 1.14317900871817;-2.7384107048099;1.14317900871817 1.17744458070252;-2.74904531971285;1.17744458070252 1.1945773666947;-2.75422146391517;1.1945773666947 1.20314375969079;-2.75677398118012;1.20314375969079 1.21171015268688;-2.75930269464039;1.21171015268688 1.24597572467124;-2.76917800172656;1.24597572467124 1.28024129665559;-2.77866641310542;1.28024129665559 1.31450686863995;-2.787763100911;1.31450686863995 1.33163965463213;-2.79216303976571;1.33163965463213 1.34877244062431;-2.79646323727736;1.34877244062431 1.38303801260866;-2.80476199433854;1.38303801260866 1.41730358459302;-2.81265454422859;1.41730358459302 1.45156915657738;-2.82013605908155;1.45156915657738 1.46870194256956;-2.82372116966102;1.46870194256956 1.47726833556564;-2.82547454921508;1.47726833556564 1.48583472856173;-2.82720171103148;1.48583472856173 1.52010030054609;-2.83384667221241;1.52010030054609 1.55436587253045;-2.84006611475841;1.55436587253045 1.5886314445148;-2.8458552108035;1.5886314445148 1.60576423050698;-2.8485868701801;1.60576423050698 1.62289701649916;-2.85120913248174;1.62289701649916 1.65716258848352;-2.85612305192718;1.65716258848352 1.69142816046787;-2.86059214127386;1.69142816046787 1.72569373245223;-2.86461157265583;1.72569373245223 1.74282651844441;-2.86645115790194;1.74282651844441 1.7513929114405;-2.86732815388986;1.7513929114405 1.75567610793854;-2.86775591972204;1.75567610793854 1.75995930443659;-2.86817651820714;1.75995930443659 1.79422487642094;-2.87128215006183;1.79422487642094 1.8284904484053;-2.87392364035395;1.8284904484053 1.86275602038966;-2.87609616121754;1.86275602038966 1.87988880638184;-2.87700504940554;1.87988880638184 1.89702159237401;-2.87779488478666;1.89702159237401 1.93128716435837;-2.87901498319535;1.93128716435837 1.96555273634273;-2.87975162857766;1.96555273634273 1.99981830832709;-2.87999999306763;1.99981830832709 2.01695109431926;-2.87993956126988;2.01695109431926 2.02551748731535;-2.8798629278364;2.02551748731535 2.03408388031144;-2.87975524879931;2.03408388031144 2.0683494522958;-2.87901256790675;2.0683494522958 2.10261502428016;-2.87776712252399;2.10261502428016 2.13688059626451;-2.87601408478508;2.13688059626451 2.15401338225669;-2.87494571007396;2.15401338225669 2.17114616824887;-2.87374862682407;2.17114616824887 2.20541174023323;-2.870965920775;2.20541174023323 2.23967731221758;-2.86766113877193;2.23967731221758 2.27394288420194;-2.86382945294889;2.27394288420194 2.29107567019412;-2.86171451239677;2.29107567019412 2.29964206319021;-2.86060700368665;2.29964206319021 2.30392525968825;-2.86004070672008;2.30392525968825 2.3082084561863;-2.85946603543993;2.3082084561863 2.34247402817065;-2.85456605837911;2.34247402817065 2.37673960015501;-2.84912469390047;2.37673960015501 2.41100517213937;-2.84313711413805;2.41100517213937 2.42813795813154;-2.83993698481731;2.42813795813154 2.44527074412372;-2.8365984912259;2.44527074412372 2.47953631610808;-2.82950399729807;2.47953631610808 2.51380188809244;-2.82184880448861;2.51380188809244 2.54806746007679;-2.81362808493155;2.54806746007679 2.56520024606897;-2.80930414391457;2.56520024606897 2.57376663906506;-2.80708851407255;2.57376663906506 2.58233303206115;-2.80483701076096;2.58233303206115 2.61659860404551;-2.79547075411087;2.61659860404551 2.65086417602986;-2.78552448711533;2.65086417602986 2.68512974801422;-2.77499338190839;2.68512974801422 2.7022625340064;-2.76950700626754;2.7022625340064 2.71939531999858;-2.7638726106241;2.71939531999858 2.75366089198293;-2.7521573453965;2.75366089198293 2.78792646396729;-2.73984275835964;2.78792646396729 2.82219203595165;-2.72692402164756;2.82219203595165 2.83932482194383;-2.72023658845521;2.83932482194383 2.84789121493991;-2.71683559162603;2.84789121493991 2.85217441143796;-2.71512074015021;2.85217441143796 2.856457607936;-2.71339630739432;2.856457607936 2.89072317992036;-2.69925478773396;2.89072317992036 2.92498875190472;-2.68449463480052;2.92498875190472 2.95925432388907;-2.66911102072805;2.95925432388907 2.97638710988125;-2.66118390705658;2.97638710988125 2.99351989587343;-2.65309911765061;2.99351989587343 3.02778546785779;-2.63645409770223;3.02778546785779 3.06205103984214;-2.61917113301697;3.06205103984214 3.0963166118265;-2.60124539572886;3.0963166118265 3.11344939781868;-2.59203997865063;3.11344939781868 3.12201579081477;-2.58737636897906;3.12201579081477 3.13058218381086;-2.58267205797196;3.13058218381086 3.16484775579521;-2.56344629188032;3.16484775579521 3.19911332777957;-2.54356326958797;3.19911332777957 3.23337889976393;-2.52301816322897;3.23337889976393 3.25051168575611;-2.51249581981637;3.25051168575611 3.26764447174829;-2.50180614493737;3.26764447174829 3.30191004373264;-2.47992238684721;3.30191004373264 3.336175615717;-2.45736206109253;3.336175615717 3.37044118770136;-2.43412033980739;3.37044118770136 3.38757397369353;-2.42224244713278;3.38757397369353 3.39614036668962;-2.41623897876355;3.39614036668962 3.40042356318767;-2.41322108106797;3.40042356318767 3.40470675968571;-2.41019239512583;3.40470675968571 3.43897233167007;-2.3855733991819;3.43897233167007 3.47323790365443;-2.36025852410964;3.47323790365443 3.50750347563878;-2.3342429420431;3.50750347563878 3.52463626163096;-2.32097087717886;3.52463626163096 3.54176904762314;-2.30752182511633;3.54176904762314 3.5760346196075;-2.28009034546337;3.5760346196075 3.61030019159185;-2.25194367521828;3.61030019159185 3.64456576357621;-2.22307698651509;3.64456576357621 3.66169854956839;-2.2083721265336;3.66169854956839 3.67026494256448;-2.20095155361147;3.67026494256448 3.67883133556057;-2.19348545148786;3.67883133556057 3.71309690754492;-2.16316424227063;3.71309690754492 3.74736247952928;-2.13210853099745;3.74736247952928 3.78162805151364;-2.10031348980236;3.78162805151364 3.79876083750581;-2.084137211776;3.79876083750581 3.81589362349799;-2.06777429081942;3.81589362349799 3.85015919548235;-2.03448610618267;3.85015919548235 3.88442476746671;-2.00044410802615;3.88442476746671 3.91869033945106;-1.96564346848391;3.91869033945106 3.93582312544324;-1.94795714948504;3.93582312544324 3.94438951843933;-1.93904222615474;3.94438951843933 3.94867271493738;-1.93456679052889;3.94867271493738 3.95295591143542;-1.93007935969;3.95295591143542 3.98722148341978;-1.89374695377847;3.98722148341978 4.02148705540413;-1.85664142288336;4.02148705540413 4.05575262738849;-1.81875793913872;4.05575262738849 4.07288541338067;-1.79952295623971;4.07288541338067 4.09001819937285;-1.78009167467859;4.09001819937285 4.15854934334156;-1.70039149214808;4.15854934334156 4.19281491532592;-1.65934791834578;4.19281491532592 4.20994770131809;-1.63852564861902;4.20994770131809 4.22708048731027;-1.61750225236419;4.22708048731027 4.29561163127899;-1.5313853323993;4.29561163127899 4.32987720326334;-1.4871044226841;4.32987720326334 4.3641427752477;-1.44200210932579;4.3641427752477 4.43267391921641;-1.34931396021602;4.43267391921641 4.46693949120077;-1.30171846873266;4.46693949120077 4.48407227719295;-1.2776057565675;4.48407227719295 4.50120506318513;-1.25328226214237;4.50120506318513 4.56973620715384;-1.15386839217722;4.56973620715384 4.63826735112255;-1.05103372739294;4.63826735112255 4.70679849509127;-0.944739644861907;4.70679849509127 4.74106406707562;-0.890283252276474;4.74106406707562 4.77532963905998;-0.83494752165649;4.77532963905998 4.8438607830287;-0.721618734849064;4.8438607830287 4.91239192699741;-0.604714661512005;4.91239192699741 4.98092307096612;-0.484196678717687;4.98092307096612 5.01518864295048;-0.422570401609174;5.01518864295048 5.03232142894266;-0.391413329435722;5.03232142894266 5.04945421493484;-0.360026163538483;5.04945421493484 5.11798535890355;-0.232164493046768;5.11798535890355 5.18651650287226;-0.100573044314915;5.18651650287226 5.25504764684098;0.0347868055846998;5.25504764684098 5.28931321882533;0.103891950637301;5.28931321882533 5.32357879080969;0.173953679579705;5.32357879080969 5.3921099347784;0.316966200597725;5.3921099347784 5.46064107874712;0.463862991566386;5.46064107874712 5.52917222271583;0.614682675413312;5.52917222271583 5.56343779470019;0.691575671831008;5.56343779470019 5.58057058069237;0.730395070854768;5.58057058069237 5.59770336668454;0.769463875066132;5.59770336668454 5.73476565462197;1.09106531349995;5.73476565462197 5.80329679859068;1.25796279813621;5.80329679859068 5.8718279425594;1.42897629028886;5.8718279425594 6.00889023049683;1.78350578885385;6.00889023049683 6.07742137446554;1.96709904112144;6.07742137446554 6.14595251843425;2.15496279261593;6.14595251843425 6.28301480637168;2.54365628499612;6.28301480637168 6.42007709430911;2.94989524941542;6.42007709430911 6.55713938224653;3.37398866929484;6.55713938224653 6.62567052621525;3.59282735735116;6.62567052621525 6.69420167018396;3.81624552805539;6.69420167018396 6.83126395812139;4.27697480911806;6.83126395812139 6.96832624605881;4.75648549590388;6.96832624605881 7.10538853399624;5.25508657183384;7.10538853399624 7.17391967796496;5.51164256304694;7.17391967796496 7.24245082193367;5.77308702032895;7.24245082193367 7.51657539780852;6.86852196869867;7.51657539780852 7.65363768574595;7.44657443541529;7.65363768574595 7.79069997368338;8.04526220838109;7.79069997368338 8.06482454955823;9.30577960674427;8.06482454955823 8.20188683749566;9.96822719898366;8.20188683749566 8.27041798146437;10.3076333986145;8.27041798146437 8.33894912543308;10.6525460311563;8.33894912543308 8.4074802694018;11.0030037195366;8.4074802694018 8.44174584138615;11.1803240293311;8.44174584138615 8.45887862737833;11.2695091628208;8.45887862737833 8.47601141337051;11.3590450866831;8.47601141337051 8.4845778063666;11.4039447835925;8.4845778063666 8.49314419936269;11.4489324044013;8.49314419936269 8.50171059235878;11.4940080245448;8.50171059235878 8.50599378885682;11.5165788579407;8.50599378885682 8.51027698535487;11.5391717194585;8.51027698535487 8.52740977134705;11.6297636353382;8.52740977134705 8.54454255733922;11.7207087555234;8.54454255733922 8.61307370130794;12.0880333489851;8.61307370130794 8.88719827718279;13.6147134275989;8.88719827718279 9.4354474289325;16.9515393366536;9.4354474289325 9.98369658068221;20.6827986972646;9.98369658068221 10.2578211565571;22.702520590324;10.2578211565571 10.3948834444945;23.7519860320156;10.3948834444945 10.4634145884632;24.2867550568986;10.4634145884632 10.5319457324319;24.8282664483766;10.5319457324319 10.5662113044163;25.1015626012536;10.5662113044163 10.6004768764006;25.3765588293771;10.6004768764006 10.6176096623928;25.5146959803645;10.6176096623928 10.6261760553889;25.5839245791135;10.6261760553889 10.6304592518869;25.6185789173048;10.6304592518869 10.634742448385;25.6532599606133;10.634742448385 10.639025644883;25.6879677184682;10.639025644883 10.6433088413811;25.7227022002992;10.6433088413811 10.6518752343772;25.7922513736066;10.6518752343772 10.6690080203693;25.9316708228279;10.6690080203693 10.8060703083068;27.0625081387905;10.8060703083068 11.0801948841816;29.4077175289339;11.0801948841816 11.6284440359313;34.440926877881;11.6284440359313 12.176693187681;39.9476694341624;12.176693187681 12.7249423394307;45.9477201367225;12.7249423394307 13.2731914911805;52.4608539245058;13.2731914911805 13.8214406429302;59.5068457364568;13.8214406429302 14.3696897946799;67.1054705115199;14.3696897946799 14.9179389464296;75.2765031886396;14.9179389464296 15.4661880981793;84.0397187067604;15.4661880981793 16.014437249929;93.4148920048266;16.014437249929 16.5626864016787;103.421798021783;16.5626864016787</points></Trace><ObjectName id="18" name="dummy"><appearance color="$000000FF"/><parents>16</parents><position x="-1.46049981973058" y="-1.37115963844029" width="4.76249944437507" height="2.24366640490559"/><text><![CDATA[<font face="Arial" size="10"> P</font>]]></text></ObjectName><TextBox id="19" name="dummy"><position x="-2.64583302465282" y="5.29166604930563" width="7.02733251347788" height="2.79399967403337"/><text><![CDATA[<font face="ARIAL">Der Punkt P(x|y) hat die Koordinaten <br>  x = x(Z) <br>  y = a*x^3+b*x^2+c*x +d <br>Die Ortslinie von P bei Variation von Z auf der x-Achse ist also das Schaubild der ganzrationalen Funktion 3. Grades mit frei variierbaren Koeffizienten.</font>				]]></text></TextBox></objlist></dg:drawing>
