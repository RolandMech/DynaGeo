<?xml version="1.0" encoding="UTF-8"?>
<dg:drawing xmlns:dg="http://www.dynageo.com/xml/dg12" 
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
xsi:schemaLocation="http://www.dynageo.com/xml/dg12 http://www.dynageo.com/xml/dg12.xsd">
<header>
<created prog_name="EUKLID DynaGeo" prog_version="2.8">
</created>
<edited prog_name="EUKLID DynaGeo" prog_version="3.0.0.467" 
date="2006-12-27T19:32:05">
</edited>
<environment>
<commands>
79847C819E1E
</commands>
<links forward="ellipse_2.geo">
</links>
</environment>
</header>
<windowdata>
<log_window xmin="-8.74889095459925" xmax="7.00264054229013" 
ymin="-3.06916739133119" ymax="7.65527958527435">
</log_window>
<scr_window width="893" height="608">
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
2;3;6;7;8
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
<PointWDC id="6" name="F1">
<appearance line_width="3" shape="3">
</appearance>
<parents>
1
</parents>
<children>
9;12;16
</children>
<position x="1" y="1" x_term="1" y_term="1">
</position>
</PointWDC>
<PointWDC id="7" name="F2">
<appearance line_width="3" shape="3">
</appearance>
<parents>
1
</parents>
<children>
10;13;16
</children>
<position x="5" y="1" x_term="5" y_term="1">
</position>
</PointWDC>
<PointWDC id="8" name="P">
<appearance line_width="3" shape="3">
</appearance>
<parents>
1
</parents>
<children>
11;12;13;16
</children>
<position x="5" y="4" x_term="5" y_term="4">
</position>
</PointWDC>
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
width="7.19666836588003" height="7.00264054229013">
</position>
<text>
<![CDATA[
<i><b>Aufgaben:<br></b></i><br>Die in der vorigen Aufgabe gesuchten 
Punkte  hatten alle die Eigenschaft, dass die <b>Summe der 
Abstände</b> zu F<sub>1</sub> und F<sub>2</sub> den Wert 8 cm 
ergibt. Gesucht ist nun eine Konstruktion, die <u>alle</u> Punkte mit 
dieser Eigenschaft liefert. <br><br>Konstruiere dazu einen Punkt Q, 
der von F1 irgendeinen Abstand hat und von F2 dann einen solchen, 
dass die Summe der beiden Abstände 8 cm ergibt. <br><br>Warum darf 
der Abstand von Q zu F1 dann auf keinen Fall größer sein als 8 cm? 
Es wird sich herausstellen, dass sein größtmöglicher Wert noch 
deutlich kleiner ist.<br><br>Verwende das Zahlobjekt für Deine 
Konstruktion: mit ihm soll der Ort des konstruierten Punktes Q 
variiert werden können. Stelle die Bereichsgrenzen des Zahlobjekts 
so ein, dass Deine Konstruktion im gesamten Werte-Bereich des 
Zahlobjekts gültig ist! <br>Erst dann kann DynaGeo Deine Lösung 
testen.
]]>
</text>
</TextBox>
<TextBox id="15" name="dummy5">
<position x="0.599722363823336" y="7.3025017242018" 
width="6.2794459270914" height="4.83305669669394">
</position>
<text>
<![CDATA[
<i><b>Hilfe:</b></i> (Klicke auf den Pfeil!)<br><hr><br>Wenn der 
gesuchte Punkt Q von F<sub>1</sub> den Abstand 3,5 cm haben soll, 
dann liegt er auf einem Kreis um F<sub>1</sub> mit dem Radius 3,5 cm. 
Welchen Abstand muss er dann von F<sub>2</sub> haben? Wo muss er also 
liegen?<br><hr><br>Du kannst für den Radius des Kreises um 
F<sub>1</sub> ein Zahlobjekt verwenden. Der Radius des anderen 
Kreises (um F<sub>2</sub>) ist dann durch einen Term festgelegt. 
Durch welchen?<br><hr>
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
<position x="-8.23736305604405" y="-0.670277936037844" 
width="250" height="33">
</position>
<value min="0" actual="5" max="8" quant="0.1" ani_step="0.001">
</value>
</Number>
<CheckControl id="19" name="go1">
<appearance visible="false">
</appearance>
<cc_data term="d(@1; F1) + d(@1; F2) = 8" vars="@1=Punkt" 
hint="Gib einen konstruierten Punkt Q an!">
</cc_data>
</CheckControl>
</objlist>
</dg:drawing>
