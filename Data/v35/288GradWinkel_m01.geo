<?xml version="1.0" encoding="UTF-8"?>
<dg:drawing xmlns:dg="http://www.dynageo.com/xml/dg12" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.dynageo.com/xml/dg12 http://www.dynageo.com/xml/dg12.xsd">
<header>
<created prog_name="EUKLID DynaGeo" prog_version="3.5.4.11" date="2016-03-14T18:45:30">
</created>
<edited prog_name="EUKLID DynaGeo" prog_version="3.5.0.22" date="2016-03-15T10:39:40">
</edited>
</header>
<windowdata>
<log_window xmin="-7.91104166666669" xmax="24.0770833333334" ymin="-14.1816666666667" ymax="5.21229166666668">
</log_window>
<scr_window width="1209" height="733">
</scr_window>
<startfont fontname="Arial" fontsize="13" fontcharset="0">
</startfont>
<options DefLocLineStatus="3">
</options>
</windowdata>
<objlist>
<Origin id="1" name="O" cosys_type="-1">
<appearance color="$00C0C0C0" visible="false">
</appearance>
<position x="0" y="0">
</position>
</Origin>
<Axis id="2" name="xa" label="x">
<appearance color="$00C0C0C0" shape="0" brush_style="0" visible="false">
</appearance>
<parents>
1
</parents>
<position x1="0" y1="0" x2="1" y2="0">
</position>
</Axis>
<Axis id="3" name="ya" label="y">
<appearance color="$00C0C0C0" shape="0" brush_style="0" visible="false">
</appearance>
<parents>
1
</parents>
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
<Point id="6" name="P1">
<appearance brush_style="0">
</appearance>
<position x="-3.30729166666668" y="-1.61395833333334">
</position>
</Point>
<Point id="7" name="P2">
<appearance brush_style="0">
</appearance>
<position x="2.64583333333334" y="-1.5875">
</position>
</Point>
<Segment id="8" name="s1">
<appearance shape="0" brush_style="0">
</appearance>
<parents>
6;7
</parents>
<position x1="-3.30729166666668" y1="-1.61395833333334" x2="2.64583333333334" y2="-1.5875">
</position>
</Segment>
<LineWDD id="10" name="g1">
<appearance shape="0" brush_style="0">
</appearance>
<parents>
7;6
</parents>
<position x1="-3.30729166666668" y1="-1.61395833333334" x2="-2.99405084816273" y2="-2.56363206131731">
</position>
<term>
288°
</term>
</LineWDD>
<Point id="11" name="P3">
<appearance brush_style="0">
</appearance>
<parents>
10
</parents>
<position x="-2.12985491403145" y="-5.18367429717522">
</position>
</Point>
<Angle id="12" name="α1">
<parents>
7;6;11
</parents>
<position x1="2.64583333333334" y1="-1.5875" x2="-3.30729166666668" y2="-1.61395833333334" x3="-2.12985491403145" y3="-5.18367429717522">
</position>
<line radius="1.57799061584047" reversed="false">
</line>
</Angle>
<MeasureAngle id="13" name="w(P2;P1;P3)">
<appearance pen_style="2">
</appearance>
<parents>
12
</parents>
<position x="-4.15257405105406" y="-1.00554615382372" width="0" height="0">
</position>
<text>
<![CDATA[]]>
</text>
<line x1="-6.37507405105406" y1="-0.29117115382372" x2="0" y2="0" dx="-2.2225" dy="0.714375">
</line>
</MeasureAngle>
<Point id="14" name="P4">
<appearance brush_style="0">
</appearance>
<position x="9.60437500000003" y="-0.105833333333334">
</position>
</Point>
<Point id="15" name="P5">
<appearance brush_style="0">
</appearance>
<position x="4.78895833333335" y="0.343958333333334">
</position>
</Point>
<LineWDD id="17" name="g2">
<appearance shape="0" brush_style="0">
</appearance>
<parents>
14;15
</parents>
<position x1="4.78895833333335" y1="0.343958333333334" x2="5.18508596439945" y2="1.26215379177666">
</position>
<term>
-( 288° )
</term>
</LineWDD>
<Point id="18" name="P6">
<appearance brush_style="0">
</appearance>
<parents>
17
</parents>
<position x="3.37521784051105" y="-2.93299080660248">
</position>
</Point>
<Angle id="19" name="α2">
<parents>
14;15;18
</parents>
<position x1="9.60437500000003" y1="-0.105833333333334" x2="4.78895833333335" y2="0.343958333333334" x3="3.37521784051105" y3="-2.93299080660248">
</position>
<line radius="1.40652858351688" reversed="false">
</line>
</Angle>
<MeasureAngle id="20" name="w(P4;P5;P6)">
<appearance pen_style="2">
</appearance>
<parents>
19
</parents>
<position x="4.31552290037803" y="1.14246709338855" width="0" height="0">
</position>
<text>
<![CDATA[]]>
</text>
<line x1="3.44239790037803" y1="1.96267542672188" x2="0" y2="0" dx="-0.873125000000003" dy="0.820208333333335">
</line>
</MeasureAngle>
<Segment id="21" name="s2">
<appearance shape="0" brush_style="0">
</appearance>
<parents>
15;14
</parents>
<position x1="4.78895833333335" y1="0.343958333333334" x2="9.60437500000003" y2="-0.105833333333334">
</position>
</Segment>
<Angle id="22" name="α3">
<appearance color="$000000FF">
</appearance>
<parents>
18;15;14
</parents>
<position x1="3.37521784051105" y1="-2.93299080660248" x2="4.78895833333335" y2="0.343958333333334" x3="9.60437500000003" y3="-0.105833333333334">
</position>
<line radius="1.02745581481098" reversed="false">
</line>
</Angle>
<MeasureAngle id="23" name="w(P6;P5;P4)">
<appearance pen_style="2">
</appearance>
<parents>
22
</parents>
<position x="5.13479843514715" y="-0.239344756494266" width="0" height="0">
</position>
<text>
<![CDATA[]]>
</text>
<line x1="6.03438176848048" y1="-0.847886423160934" x2="0" y2="0" dx="0.899583333333336" dy="-0.608541666666668">
</line>
</MeasureAngle>
<Point id="24" name="P7">
<appearance brush_style="0">
</appearance>
<parents>
17
</parents>
<position x="6.37988160158949" y="4.03160444807974">
</position>
</Point>
<Angle id="25" name="α4">
<appearance color="$0000FF00">
</appearance>
<parents>
14;15;24
</parents>
<position x1="9.60437500000003" y1="-0.105833333333334" x2="4.78895833333335" y2="0.343958333333334" x3="6.37988160158949" y3="4.03160444807974">
</position>
<line radius="0.850379230149376" reversed="false">
</line>
</Angle>
<MeasureAngle id="26" name="w(P4;P5;P7)">
<appearance pen_style="2">
</appearance>
<parents>
25
</parents>
<position x="5.27173221550034" y="0.63019471965356" width="0" height="0">
</position>
<text>
<![CDATA[]]>
</text>
<line x1="7.38839888216702" y1="1.42394471965356" x2="0" y2="0" dx="2.11666666666667" dy="0.793750000000002">
</line>
</MeasureAngle>
<Angle id="27" name="α5">
<appearance color="$000000FF">
</appearance>
<parents>
11;6;7
</parents>
<position x1="-2.12985491403145" y1="-5.18367429717522" x2="-3.30729166666668" y2="-1.61395833333334" x3="2.64583333333334" y3="-1.5875">
</position>
<line radius="1.01304670596781" reversed="false">
</line>
</Angle>
<MeasureAngle id="28" name="w(P3;P1;P2)">
<appearance pen_style="2">
</appearance>
<parents>
27
</parents>
<position x="-2.76463284061265" y="-2.00454998079674" width="0" height="0">
</position>
<text>
<![CDATA[]]>
</text>
<line x1="-1.91796617394599" y1="-2.40142498079674" x2="0" y2="0" dx="0.846666666666669" dy="-0.396875000000001">
</line>
</MeasureAngle>
<TextBox id="29" name="tb1">
<position x="4.60375000000001" y="-3.75708333333334" width="6.56166666666669" height="2.98979166666667">
</position>
<text>
<![CDATA[
Ursprüngliche Eingaben:<br>links:  winkelweite =  288°<br>recht: 
winkelweite = -288°<br>
]]>
</text>
</TextBox>
</objlist>
</dg:drawing>
