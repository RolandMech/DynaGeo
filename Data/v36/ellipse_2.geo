<?xml version="1.0" encoding="UTF-8"?>
<dg:drawing xmlns:dg="http://www.dynageo.com/xml/dg12" 
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
xsi:schemaLocation="http://www.dynageo.com/xml/dg12 http://www.dynageo.com/xml/dg12.xsd">
<header>
<created prog_name="EUKLID DynaGeo" prog_version="2.8">
</created>
<edited prog_name="EUKLID DynaGeo" prog_version="3.0.0.467" 
date="2006-12-27T19:34:31">
</edited>
<environment>
<commands>
79849E9C
</commands>
</environment>
</header>
<windowdata>
<log_window xmin="-8.74889095459925" xmax="8.36083530741944" 
ymin="-4.0393065092807" ymax="7.65527958527435">
</log_window>
<scr_window width="970" height="663">
</scr_window>
<startfont fontname="Arial" fontsize="12" fontcharset="0">
</startfont>
<options DefLocLineStatus="3">
</options>
</windowdata>
<objlist>
<Origin id="1" name="O" cosys_type="1">
<appearance color="$00C0C0C0">
</appearance>
<children>
2;3
</children>
<position x="0" y="0">
</position>
</Origin>
<Axis id="2" name="xa" label="x">
<appearance color="$00C0C0C0" shape="0" brush_style="0">
</appearance>
<parents>
1
</parents>
<children>
4
</children>
<position x1="0" y1="0" x2="1" y2="0">
</position>
</Axis>
<Axis id="3" name="ya" label="y">
<appearance color="$00C0C0C0" shape="0" brush_style="0">
</appearance>
<parents>
1
</parents>
<children>
5
</children>
<position x1="0" y1="0" x2="0" y2="1">
</position>
</Axis>
<UnityPoint id="4" name="X_1">
<appearance color="$00C0C0C0" brush_style="0" visible="false">
</appearance>
<parents>
2
</parents>
<position x="1" y="0">
</position>
</UnityPoint>
<UnityPoint id="5" name="Y_1">
<appearance color="$00C0C0C0" brush_style="0" visible="false">
</appearance>
<parents>
3
</parents>
<position x="0" y="1">
</position>
</UnityPoint>
<Point id="6" name="F1" quant="1">
<appearance brush_style="0">
</appearance>
<children>
9;12;16;19;32;34
</children>
<position x="1" y="1">
</position>
</Point>
<Point id="7" name="F2" quant="1">
<appearance brush_style="0">
</appearance>
<children>
10;13;16;20;33;35
</children>
<position x="5" y="1">
</position>
</Point>
<Point id="8" name="P" quant="0.5">
<appearance brush_style="0">
</appearance>
<children>
11;12;13;16
</children>
<position x="5" y="4">
</position>
</Point>
<ObjectName id="9" name="dummy1">
<parents>
6
</parents>
<position x="0.685276286801345" y="0.910417353848542" 
width="3.82763979263717" height="1.28763919291481">
</position>
<text>
<![CDATA[F<sub>1</sub>]]>
</text>
</ObjectName>
<ObjectName id="10" name="dummy2">
<parents>
7
</parents>
<position x="5.14791622936911" y="0.945695139955797" 
width="3.82763979263717" height="1.28763919291481">
</position>
<text>
<![CDATA[F<sub>2</sub>]]>
</text>
</ObjectName>
<ObjectName id="11" name="dummy3">
<parents>
8
</parents>
<position x="5.25374958769087" y="3.99722363823336" 
width="3.82763979263717" height="1.28763919291481">
</position>
<text>
<![CDATA[P]]>
</text>
</ObjectName>
<MeasureDistance id="12" name="d(F1;P)">
<appearance pen_style="2">
</appearance>
<parents>
6;8
</parents>
<children>
20
</children>
<position x="0" y="0" width="0" height="0">
</position>
<text>
<![CDATA[]]>
</text>
<line x1="1" y1="1" x2="5" y2="4" dx="0" dy="0">
</line>
</MeasureDistance>
<MeasureDistance id="13" name="d(F2;P)">
<appearance pen_style="2">
</appearance>
<parents>
7;8
</parents>
<children>
20
</children>
<position x="0" y="0" width="0" height="0">
</position>
<text>
<![CDATA[]]>
</text>
<line x1="5" y1="1" x2="5" y2="4" dx="0" dy="0">
</line>
</MeasureDistance>
<TextBox id="14" name="dummy4">
<position x="-8.25500194909768" y="7.26722393809454" 
width="6.9850016492365" height="8.25500194909768">
</position>
<text>
<![CDATA[
Hier ist nochmals die Lösung der vorigen Aufgabe aufgezeichnet. 
Q<sub>1</sub> und Q<sub>2</sub> sind die beiden Punkte, deren 
Abstandssumme von F<sub>1</sub> und F<sub>2</sub> stets genau so 
groß ist wie die des (festen) Punktes P. Wir wollen nun die Kurve 
aller Punkte Q mit dieser Eigenschaft konstruieren. 
<br><br><i><b>Aufgaben:<br></b></i><br>1. Wenn Du den Wert des 
Zahlobjekts veränderst, laufen Q<sub>1</sub> und Q<sub>2</sub> durch 
alle möglichen Lagen. Zeichne nun die Ortslinien der Punkte 
Q<sub>1</sub> und Q<sub>2</sub> auf, wenn der Wert des Zahlobjekt 
durch das ganze zugelassene Intervall verläuft. <br><br>2. 
Verändere dann die Lage des Punktes P. Beobachte die dadurch 
hervorgerufene Veränderung der Ortslinie. Vergewissere Dich, dass 
auch jetzt noch die Summe der Abstände aller Ortslinienpunkte Q von 
den Punkten F<sub>1</sub> und F<sub>2</sub> konstant ist. Wie groß 
ist diese Konstante?<br><br>3. Verändere schließlich auch die Lage 
der Punkte F<sub>1</sub> und F<sub>2</sub>. Wie verändert sich die 
Ortslinie dabei? Welche Kurvenformen lassen sich erzeugen? <br>(Achte 
dabei darauf, dass der Abstand von F<sub>1</sub> zu F<sub>2</sub> 
<br> nicht größer als 10 cm wird.) 
]]>
</text>
</TextBox>
<EllipseF id="16" name="e">
<appearance visible="false">
</appearance>
<parents>
6;7;8
</parents>
<children>
17
</children>
<params a="3" b="0" c="4" d="-9" e="-4" f="-17">
</params>
<points>
-1;1;0 -0.969682099246921;0.574302897368423;0.0196078235294118 
-0.87918798454072;0.155058915991075;0.0392156470588235 
-0.729889451675599;-0.251376645422682;0.0588234705882353 
-0.524049709702548;-0.638842650366116;0.0784312941176471 
-0.264789073055659;-1.00146552089769;0.0980391176470588 
0.0439623391395503;-1.33374827491763;0.117646941176471 
0.397524179546925;-1.63065385464675;0.137254764705882 
0.790536821772691;-1.88768148313543;0.156862588235294 
1.217042606676;-2.10093489131801;0.176470411764706 
1.67057615422819;-2.26718138136222;0.196078235294118 
2.14426237188782;-2.38390083097521;0.215686058823529 
2.63092067378734;-2.44932389581231;0.235293882352941 
3.12317383087793;-2.46245883088018;0.254901705882353 
3.61355980197855;-2.42310652434993;0.274509529411765 
4.09464485048793;-2.33186351588344;0.294117352941176 
4.55913623202884;-2.19011295371828;0.313725176470588 
4.99999274479816;-2.00000362759215;0.333333 
5.41053146679564;-1.76441739534591;0.352940823529412 
5.78452906190688;-1.48692549698357;0.372548647058824 
6.11631611914664;-1.17173441842232;0.392156470588235 
6.40086309497865;-0.823622125581173;0.411764294117647 
6.63385655591647;-0.447865635432784;0.431372117647059 
6.81176456564769;-0.0501610219649724;0.450979941176471 
6.9318902254812;0.363462930322182;0.470587764705882 
6.99241255650065;0.78673611646141;0.490195588235294 
6.99241410369343;1.21324215922831;0.509803411764706 
6.93189484360572;1.63651567468528;0.529411235294118 
6.81177218469802;2.05014028061581;0.54901905882353 
6.63386706039581;2.44784586214407;0.568626882352941 
6.40087632565012;2.82360362009522;0.588234705882353 
6.11633187544715;3.17171746126287;0.607842529411765 
5.78454710498745;3.48691034520336;0.627450352941177 
5.41055152314211;3.76440427863002;0.647058176470589 
5.00001451037736;3.99999274477623;0.666666 
4.55915937689744;4.1901044697744;0.686273823529412 
4.09466902379402;4.33185755941928;0.705881647058824 
3.61358463728017;4.42310318565922;0.725489470588236 
3.12319895169798;4.46245816057399;0.745097294117648 
2.63094569932057;4.44932590405176;0.76470511764706 
2.14428692277339;4.38390548731751;0.784312941176471 
1.67059985830046;4.2671886152221;0.803920764705883 
1.21706510460611;4.10094459303775;0.823528588235295 
0.790557772515639;3.88769350564715;0.843136411764707 
0.397543265511433;3.63066801570178;0.862744235294119 
0.0439792710024323;3.33376435984924;0.88235205882353 
-0.264774551963673;3.0014832858752;0.901959882352942 
-0.524037819505971;2.63886182609111;0.921567705882354 
-0.729880372617329;2.25139694121131;0.941175529411766 
-0.879181854249752;1.84496219219832;0.960783352941178 
-0.96967901065203;1.42571870324375;0.980391176470589 
-0.999999999921043;1.00002176559237;0.999999
</points>
</EllipseF>
<ObjectName id="17" name="dummy6">
<appearance visible="false">
</appearance>
<parents>
16
</parents>
<position x="2.87515861854463" y="2.31069595561544" 
width="3.82763979263717" height="1.28763919291481">
</position>
<text>
<![CDATA[e]]>
</text>
</ObjectName>
<Number id="18" name="Z1" show_name="true">
<appearance color="$00808080">
</appearance>
<children>
19;20
</children>
<position x="-8.29027973520494" y="-0.635000149930589" 
width="250" height="33">
</position>
<value min="0" actual="3.5" max="16" quant="0.1" 
ani_step="0.001">
</value>
</Number>
<CircleWDR id="19" name="k1">
<appearance shape="0" brush_style="0">
</appearance>
<parents>
6;18
</parents>
<children>
21
</children>
<position x1="1" y1="1" x2="4.5" y2="1">
</position>
<radius>
<![CDATA[Z1]]>
</radius>
</CircleWDR>
<CircleWDR id="20" name="k2">
<appearance shape="0" brush_style="0">
</appearance>
<parents>
7;12;13;18
</parents>
<children>
21
</children>
<position x1="5" y1="1" x2="9.5" y2="1">
</position>
<radius>
<![CDATA[d(F1;P) + d(F2;P) - Z1]]>
</radius>
</CircleWDR>
<DoubleIntersection id="21" name="DI_1">
<appearance visible="false">
</appearance>
<parents>
19;20
</parents>
<children>
22;23
</children>
<pointlist>
2;-2.35410196624968 2;4.35410196624968
</pointlist>
</DoubleIntersection>
<IntersectPoint id="22" name="Q2" plist_index="0">
<appearance shape="0" brush_style="0">
</appearance>
<parents>
21
</parents>
<children>
25;34;35
</children>
<position x="2" y="-2.35410196624968">
</position>
</IntersectPoint>
<IntersectPoint id="23" name="Q1" plist_index="1">
<appearance shape="0" brush_style="0">
</appearance>
<parents>
21
</parents>
<children>
24;32;33
</children>
<position x="2" y="4.35410196624968">
</position>
</IntersectPoint>
<ObjectName id="24" name="dummy7">
<parents>
23
</parents>
<position x="1.92750097454884" y="4.81206076235746" 
width="3.82763979263717" height="1.28763919291481">
</position>
<text>
<![CDATA[Q<sub>1</sub>]]>
</text>
</ObjectName>
<ObjectName id="25" name="dummy8">
<parents>
22
</parents>
<position x="1.99805654676335" y="-2.50136577233225" 
width="3.82763979263717" height="1.28763919291481">
</position>
<text>
<![CDATA[Q<sub>2</sub>]]>
</text>
</ObjectName>
<MeasureDistance id="32" name="d(Q1;F1)">
<appearance pen_style="2" visible="false">
</appearance>
<parents>
23;6
</parents>
<position x="0" y="0" width="0" height="0">
</position>
<text>
<![CDATA[]]>
</text>
<line x1="2" y1="4.35410196624968" x2="1" y2="1" 
dx="0" dy="0">
</line>
</MeasureDistance>
<MeasureDistance id="33" name="d(Q1;F2)">
<appearance pen_style="2" visible="false">
</appearance>
<parents>
23;7
</parents>
<position x="0" y="0" width="0" height="0">
</position>
<text>
<![CDATA[]]>
</text>
<line x1="2" y1="4.35410196624968" x2="5" y2="1" 
dx="0" dy="0">
</line>
</MeasureDistance>
<MeasureDistance id="34" name="d(Q2;F1)">
<appearance pen_style="2" visible="false">
</appearance>
<parents>
22;6
</parents>
<position x="0" y="0" width="0" height="0">
</position>
<text>
<![CDATA[]]>
</text>
<line x1="2" y1="-2.35410196624968" x2="1" y2="1" 
dx="0" dy="0">
</line>
</MeasureDistance>
<MeasureDistance id="35" name="d(Q2;F2)">
<appearance pen_style="2" visible="false">
</appearance>
<parents>
22;7
</parents>
<position x="0" y="0" width="0" height="0">
</position>
<text>
<![CDATA[]]>
</text>
<line x1="2" y1="-2.35410196624968" x2="5" y2="1" 
dx="0" dy="0">
</line>
</MeasureDistance>
<TextBox id="45" name="dummy5">
<position x="0.881944652681376" y="7.3025017242018" 
width="6.2794459270914" height="2.31069499002521">
</position>
<text>
<![CDATA[
<i><b>Hier geht's weiter:</b> </i><br>Mit einem Doppelklick auf den 
folgenden Link kommst Du zur nächsten Aufgabe: <br><a 
href="ellipse_3.geo"><u>Die Ellipse als Standardkurve</u></a> 
]]>
</text>
</TextBox>
</objlist>
</dg:drawing>
