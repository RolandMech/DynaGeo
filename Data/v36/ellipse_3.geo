<?xml version="1.0" encoding="UTF-8"?>
<dg:drawing xmlns:dg="http://www.dynageo.com/xml/dg12" 
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
xsi:schemaLocation="http://www.dynageo.com/xml/dg12 http://www.dynageo.com/xml/dg12.xsd">
<header>
<created prog_name="EUKLID DynaGeo" prog_version="2.8">
</created>
<edited prog_name="EUKLID DynaGeo" prog_version="3.0.0.467" 
date="2006-12-27T19:36:02">
</edited>
<environment>
<commands>
796D9C9B4F1EDE
</commands>
<links forward="ellipse_4.geo">
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
width="7.40833508252356" height="9.38389110452984">
</position>
<text>
<![CDATA[
Die Kurve aller Punkte Q, für die die Summe der Abstände  von zwei 
gegebenen Punkten F<sub>1</sub> und F<sub>2</sub> konstant ist, 
heißt <b>Ellipse</b>, die Punkte F<sub>1</sub> und F<sub>2</sub> 
heißen <b>Brennpunkte</b>.  DynaGeo stellt auf der Werkzeugleiste 
&quot;<i>Kurven</i>&quot; einen Standard-Befehl &quot;<i>Ellipse aus 
zwei Brennpunkten und einem Kurvenpunkt</i>&quot; zur Verfügung, 
damit Du eine Ellipse nicht immer so umständlich als Ortslinie 
erzeugen musst.<br><br><i><b>Aufgaben:<br></b></i><br>1. Konstruiere 
mit diesem neuen Befehl diejenige Ellipse mit den beiden gegebenen 
Punkten F<sub>1</sub> und F<sub>2</sub> als Brennpunkten, die durch 
den Punkt P verläuft.<br><br>2. Konstruieren einen zusätzlichen 
Punkt Q, der an die Ellipse gebunden ist. Miss dann die Abstände von 
Q zu den Brennpunkten. Verwende ein Termobjekt, um die Summe der 
Abstände zu bilden. Überzeuge Dich dann davon, dass diese Summe 
für alle Lagen von Q auf der Ellipse konstant ist! <br><br>3. Löse 
den Punkt Q von der Ellipse!<br>Für welche Lagen von Q ist die 
Abstands-Summe größer, wo ist sie kleiner als der Wert, der sich 
ergibt, wenn Q auf der Ellipse liegt?<br><br>4. Binde den Punkt Q 
wieder an die Ellipse. Jetzt kannst Du Deine Konstruktion von DynaGeo 
überprüfen lassen!<br>
]]>
</text>
</TextBox>
<Point id="7" name="F1">
<appearance brush_style="0">
</appearance>
<children>
8;65
</children>
<position x="2.25777831086432" y="-0.829027973520494">
</position>
</Point>
<ObjectName id="8" name="dummy2">
<parents>
7
</parents>
<position x="2.40777831086432" y="-0.829027973520494" 
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
10;66
</children>
<position x="6.63222378816395" y="-0.864305759627749">
</position>
</Point>
<ObjectName id="10" name="dummy3">
<parents>
9
</parents>
<position x="6.78222378816395" y="-0.864305759627749" 
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
12;65;66
</children>
<position x="5.66208467021444" y="2.16958384559619">
</position>
</Point>
<ObjectName id="12" name="dummy4">
<parents>
11
</parents>
<position x="5.67972356326807" y="2.59291727888325" 
width="3.82763979263717" height="1.28763919291481">
</position>
<text>
<![CDATA[P]]>
</text>
</ObjectName>
<TextBox id="15" name="dummy6">
<position x="0.652639042984219" y="7.32014061725542" 
width="6.2794459270914" height="4.58611219394316">
</position>
<text>
<![CDATA[
<i><b>Hilfe:</b></i> (Klicke auf den Pfeil!)<br><hr><br>Um einen 
ziehbaren (Basis-)Punkt an eine Linie zu binden, klicke mit der 
rechten Maustaste auf den Punkt und wähle aus dem Kontextmenü den 
Befehl &quot;<i>An Linie binden</i>&quot;. Klicke dann auf die Linie, 
an die der Punkt gebunden werden soll.<br><hr><br>Um einen gebundenen 
Punkt wieder von seiner &quot;Trägerlinie&quot; zu lösen, gibt es 
im Kontextmenü des Punktes einen Befehl &quot;<i>Bindung 
aufheben</i>&quot;.<br><hr>
]]>
</text>
</TextBox>
<MeasureDistance id="65" name="d(F1;P)">
<appearance pen_style="2" visible="false">
</appearance>
<parents>
7;11
</parents>
<children>
67
</children>
<position x="0" y="0" width="0" height="0">
</position>
<text>
<![CDATA[]]>
</text>
<line x1="2.25777831086432" y1="-0.829027973520494" 
x2="5.66208467021444" y2="2.16958384559619" dx="0" dy="0">
</line>
</MeasureDistance>
<MeasureDistance id="66" name="d(F2;P)">
<appearance pen_style="2" visible="false">
</appearance>
<parents>
9;11
</parents>
<children>
67
</children>
<position x="0" y="0" width="0" height="0">
</position>
<text>
<![CDATA[]]>
</text>
<line x1="6.63222378816395" y1="-0.864305759627749" 
x2="5.66208467021444" y2="2.16958384559619" dx="0" dy="0">
</line>
</MeasureDistance>
<CheckControl id="67" name="go1">
<appearance visible="false">
</appearance>
<parents>
65;66
</parents>
<cc_data term="d(F1; @1) + d(F2; @1) = d(F1; P) + d(F2; P)" 
vars="@1=Punkt" hint="Gib den Punkt Q auf der Ellipse an!">
</cc_data>
</CheckControl>
</objlist>
</dg:drawing>
