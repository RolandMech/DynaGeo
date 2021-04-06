<?xml version="1.0" encoding="UTF-8"?>
<dg:drawing xmlns:dg="http://www.dynageo.com/xml/dg12" 
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
xsi:schemaLocation="http://www.dynageo.com/xml/dg12 http://www.dynageo.com/xml/dg12.xsd">
<header>
<created prog_name="EUKLID DynaGeo" prog_version="2.8">
</created>
<edited prog_name="EUKLID DynaGeo" prog_version="3.0.0.467" 
date="2006-12-27T19:39:27">
</edited>
<environment>
<commands>
857B8A89871E
</commands>
<links forward="ellipse_5.geo">
</links>
</environment>
</header>
<windowdata>
<log_window xmin="-8.713613168492" xmax="8.3961130935267" 
ymin="-3.81000089958355" ymax="7.8845851949715">
</log_window>
<scr_window width="970" height="663">
</scr_window>
<startfont fontname="Arial" fontsize="12" fontcharset="0">
</startfont>
<options DefLocLineStatus="3">
</options>
</windowdata>
<objlist>
<Origin id="1" name="O" cosys_type="-1">
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
<TextBox id="6" name="dummy1">
<position x="-8.04333523245415" y="7.39069618946993" 
width="7.37305729641631" height="3.40430635935011">
</position>
<text>
<![CDATA[
Nun wollen wir die <b>Symmetrie-Eigenschaften</b> der Ellipse 
untersuchen. Gegeben ist eine Ellipse mit den Brennpunkten 
F<sub>1</sub> und F<sub>2</sub> und dem Kurvenpunkt 
P.<br><br><i><b>Aufgabe:<br></b></i><br>Konstruiere alle Geraden, die 
Symmetrie-Achsen dieser Ellipse sind. Dann kannst Du Deine 
Konstruktion von DynaGeo überprüfen lassen!
]]>
</text>
</TextBox>
<Point id="7" name="F1">
<appearance brush_style="0">
</appearance>
<children>
8;45;47
</children>
<position x="2.32833388307883" y="-0.776111294359611">
</position>
</Point>
<ObjectName id="8" name="dummy2">
<parents>
7
</parents>
<position x="2.47833388307883" y="-0.776111294359611" 
width="3.82763979263717" height="1.28763919291481">
</position>
<text>
<![CDATA[F<sub>1</sub>]]>
</text>
</ObjectName>
<Point id="9" name="F2">
<appearance brush_style="0">
</appearance>
<children>
10;45;47
</children>
<position x="6.31472371319866" y="-0.776111294359611">
</position>
</Point>
<ObjectName id="10" name="dummy3">
<parents>
9
</parents>
<position x="6.46472371319866" y="-0.776111294359611" 
width="3.82763979263717" height="1.28763919291481">
</position>
<text>
<![CDATA[F<sub>2</sub>]]>
</text>
</ObjectName>
<Point id="11" name="P">
<appearance brush_style="0">
</appearance>
<children>
12;45
</children>
<position x="6.50875153678856" y="1.94027823589903">
</position>
</Point>
<ObjectName id="12" name="dummy4">
<parents>
11
</parents>
<position x="6.52639042984219" y="2.36361166918609" 
width="3.82763979263717" height="1.28763919291481">
</position>
<text>
<![CDATA[P]]>
</text>
</ObjectName>
<TextBox id="15" name="dummy6">
<position x="0.652639042984219" y="7.37305729641631" 
width="6.2794459270914" height="5.71500134937532">
</position>
<text>
<![CDATA[
<i><b>Hilfe:</b></i> (Klicke auf den Pfeil!)<br><hr><br>Damit Deine 
Konstruktion den Abschluss-Test bestehen kann, musst Du die 
Symmterie-Achsen so konstruieren, dass sie auch dann noch 
Symmetrie-Achsen sind, wenn man an den Brennpunkten 
zieht!<br><hr><br>Eine der Symmetrie-Achsen ist die Gerade durch die 
beiden Brennpunkte.<br><hr><br>Die andere Symmterie-Achse solltest Du 
nun aber selbst finden. Nur soviel sei verraten: die beiden 
Symmetrie-Achsen sind orthogonal.<br><hr><br>
]]>
</text>
</TextBox>
<EllipseF id="45" name="KS1">
<appearance shape="0" brush_style="0">
</appearance>
<parents>
7;9;11
</parents>
<params a="0.59096934038311" b="0" c="0.806694018031094" 
d="-2.55389102328267" e="0.626084338486268" f="2.7430496118796">
</params>
<points>
0.467151058705968;-0.776111294359611;0 
0.496365219148219;-1.18151937659894;0.0196078235294118 
0.583564844466532;-1.58078189783736;0.0392156470588235 
0.727428079867857;-1.96784645732819;0.0588234705882353 
0.925774109705734;-2.33684556262161;0.0784312941176471 
1.17559621635647;-2.68218557459148;0.0980391176470588 
1.47310735890238;-2.99863150113332;0.117646941176471 
1.81379758069715;-3.28138635414982;0.137254764705882 
2.19250237557481;-3.52616386685538;0.156862588235294 
2.60348097634246;-3.72925346908159;0.176470411764706 
3.04050337878525;-3.88757653562634;0.196078235294118 
3.4969447819911;-3.99873305498039;0.215686058823529 
3.96588601337901;-4.06103801098283;0.235293882352941 
4.44021841609288;-4.07354692589742;0.254901705882353 
4.91275160877797;-4.03607017770369;0.274509529411765 
5.3763224842151;-3.94917587456778;0.294117352941176 
5.82390379450751;-3.81418124291895;0.313725176470588 
6.24871067678301;-3.63313265967945;0.333333 
6.64430350459358;-3.40877463133835;0.352940823529412 
7.00468550589312;-3.14450819011386;0.372548647058824 
7.32439366780733;-2.84433933787468;0.392156470588235 
7.59858155017478;-2.51281831935649;0.411764294117647 
7.82309275249282;-2.15497064522778;0.431372117647059 
7.99452392058652;-1.77622091062303;0.450979941176471 
8.11027633788576;-1.38231056397424;0.470587764705882 
8.16859531924075;-0.979210872679077;0.490195588235294 
8.1685968101071;-0.573032404954668;0.509803411764706 
8.11028078788485;-0.169932400037271;0.529411235294118 
7.99453126226102;0.223978569101788;0.54901905882353 
7.82310287455066;0.602729225628556;0.568626882352941 
7.59859429917619;0.96057810713566;0.588234705882353 
7.32440885049082;1.29210060018604;0.607842529411765 
7.00470289210515;1.59227117175882;0.627450352941177 
6.64432283077742;1.85653955105506;0.647058176470589 
6.248731649974;2.08089970682689;0.666666 
5.82392609677409;2.26195057460652;0.686273823529412 
5.37634577747832;2.39694761327363;0.705881647058824 
4.9127755399364;2.48384440941809;0.725489470588236 
4.44024262237529;2.52132369881926;0.745097294117648 
3.96591012784356;2.50881733478897;0.76470511764706 
3.49696843908781;2.44651490067895;0.784312941176471 
3.04052621989737;2.3353608359962;0.803920764705883 
2.60350265522272;2.17704011969139;0.823528588235295 
2.19252256359412;1.97395272764659;0.843136411764707 
1.81381597182633;1.72917725155988;0.862744235294119 
1.47312367435123;1.44642423072666;0.88235205882353 
1.1756102087999;1.12997990415857;0.901959882352942 
0.925785567032987;0.784641235698982;0.921567705882354 
0.72743682839788;0.415643197086176;0.941175529411766 
0.583570751580794;0.0285794112765246;0.960783352941178 
0.496368195301067;-0.370682641008327;0.980391176470589 
0.467151058782051;-0.776090566130531;0.999999
</points>
</EllipseF>
<CheckControl id="47" name="go1">
<appearance visible="false">
</appearance>
<parents>
7;9
</parents>
<cc_data term="ortho (@1; @2) AND {[incid (F1; @1) AND incid (F2; @1) AND (d(F1;@2) = d(F2;@2))] OR [incid (F1; @2) AND incid (F2; @2) AND (d(F1;@1) = d(F2;@1))]}" 
vars="@1=Gerade; @2=Gerade" hint="Gib die beiden Symmetrie-Achsen ein!">
</cc_data>
</CheckControl>
</objlist>
</dg:drawing>
