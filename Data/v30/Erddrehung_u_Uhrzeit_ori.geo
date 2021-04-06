<?xml version="1.0" encoding="UTF-8"?>
<dg:drawing xmlns:dg="http://www.dynageo.com/xml/dg12" 
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
xsi:schemaLocation="http://www.dynageo.com/xml/dg12 http://www.dynageo.com/xml/dg12.xsd">
<header>
<created prog_name="EUKLID DynaGeo" prog_version="3.0.1.21" 
date="2009-04-24T16:36:20">
</created>
<edited prog_name="EUKLID DynaGeo" prog_version="3.0.1.21" 
date="2009-04-24T17:25:46">
</edited>
</header>
<windowdata>
<log_window xmin="-10.0541666666667" xmax="17.0391666666667" 
ymin="-11.43" ymax="5.635625">
</log_window>
<scr_window width="1024" height="645">
</scr_window>
<startfont fontname="Arial" fontsize="12" fontcharset="0">
</startfont>
<options LengthDecimals="2" AreaDecimals="5" DefLocLineStatus="7">
</options>
</windowdata>
<objlist ani_source="120">
<Origin id="1" name="O" cosys_type="0">
<appearance color="$00C0C0C0" visible="false">
</appearance>
<position x="0" y="0">
</position>
</Origin>
<Axis id="2" name="xa" label="x">
<appearance color="$00C0C0C0" shape="0" brush_style="0" 
visible="false">
</appearance>
<parents>
1
</parents>
<position x1="0" y1="0" x2="1" y2="0">
</position>
</Axis>
<Axis id="3" name="ya" label="y">
<appearance color="$00C0C0C0" shape="0" brush_style="0" 
visible="false">
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
<Point id="6" name="N">
<appearance brush_style="0">
</appearance>
<position x="-1.08479166666667" y="-3.36020833333333">
</position>
</Point>
<Point id="7" name="P2">
<appearance brush_style="0">
</appearance>
<position x="-6.21770833333333" y="1.05833333333333">
</position>
</Point>
<Circle id="8" name="k1">
<appearance shape="0" brush_style="0" groups="1">
</appearance>
<parents>
6;7
</parents>
<position x1="-1.08479166666667" y1="-3.36020833333333" 
x2="-6.21770833333333" y2="1.05833333333333">
</position>
<radius>
6.7727648687234
</radius>
</Circle>
<ObjectName id="9" name="Name1">
<parents>
6
</parents>
<position x="-0.934791666666667" y="-3.36020833333333" 
width="5.74145833333333" height="1.93145833333333">
</position>
<text>
<![CDATA[N]]>
</text>
</ObjectName>
<MeasureDistance id="10" name="d(N;P2)">
<appearance pen_style="2" visible="false">
</appearance>
<parents>
6;7
</parents>
<position x="0" y="0" width="0" height="0">
</position>
<text>
<![CDATA[]]>
</text>
<line x1="-1.08479166666667" y1="-3.36020833333333" 
x2="-6.21770833333333" y2="1.05833333333333" dx="-27" 
dy="27">
</line>
</MeasureDistance>
<PointWDC id="12" name="P1">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
1;6;10
</parents>
<position x="5.68797320205673" y="-3.36020833333333" 
x_term="x(N) + d(N;P2)" y_term="y(N)">
</position>
</PointWDC>
<CircleWDR id="15" name="k2">
<appearance color="$00008000" shape="0" brush_style="0" 
groups="1">
</appearance>
<parents>
6;10
</parents>
<position x1="-1.08479166666667" y1="-3.36020833333333" 
x2="4.18797320205673" y2="-3.36020833333333">
</position>
<radius>
<![CDATA[d(N;P2) - 1.5]]>
</radius>
</CircleWDR>
<Line id="17" name="g1">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
6;12
</parents>
<position x1="-1.08479166666667" y1="-3.36020833333333" 
x2="5.68797320205673" y2="-3.36020833333333">
</position>
</Line>
<LineWDD id="19" name="g2">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
12;6
</parents>
<position x1="-1.08479166666667" y1="-3.36020833333333" 
x2="95.5077909622402" y2="22.5216961769187">
</position>
<term>
15
</term>
</LineWDD>
<DoubleIntersection id="20" name="DI_1">
<appearance visible="false">
</appearance>
<parents>
19;8
</parents>
<pointlist>
-7.62678016874989;-5.11312886936022 
5.45719683541656;-1.60728779730644
</pointlist>
</DoubleIntersection>
<IntersectPoint id="21" name="P3" plist_index="0">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
20
</parents>
<position x="-7.62678016874989" y="-5.11312886936022">
</position>
</IntersectPoint>
<IntersectPoint id="22" name="P4" plist_index="1">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
20
</parents>
<position x="5.45719683541656" y="-1.60728779730644">
</position>
</IntersectPoint>
<LineWDD id="24" name="g3">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
22;6
</parents>
<position x1="-1.08479166666667" y1="-3.36020833333333" 
x2="85.5177487117772" y2="46.6397916666667">
</position>
<term>
15
</term>
</LineWDD>
<DoubleIntersection id="25" name="DI_2">
<appearance visible="false">
</appearance>
<parents>
24;8
</parents>
<pointlist>
-6.95017809683991;-6.74659076769503 
4.78059476350658;0.0261741010283657
</pointlist>
</DoubleIntersection>
<IntersectPoint id="26" name="P5" plist_index="0">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
25
</parents>
<position x="-6.95017809683991" y="-6.74659076769503">
</position>
</IntersectPoint>
<IntersectPoint id="27" name="P6" plist_index="1">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
25
</parents>
<position x="4.78059476350658" y="0.0261741010283657">
</position>
</IntersectPoint>
<LineWDD id="29" name="g4">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
27;6
</parents>
<position x1="-1.08479166666667" y1="-3.36020833333333" 
x2="69.6258864519881" y2="67.3504697853214">
</position>
<term>
15
</term>
</LineWDD>
<DoubleIntersection id="30" name="DI_3">
<appearance visible="false">
</appearance>
<parents>
29;8
</parents>
<pointlist>
-5.873859632723;-8.14927629938967 3.70427629938967;1.428859632723
</pointlist>
</DoubleIntersection>
<IntersectPoint id="31" name="P7" plist_index="0">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
30
</parents>
<position x="-5.873859632723" y="-8.14927629938967">
</position>
</IntersectPoint>
<IntersectPoint id="32" name="P8" plist_index="1">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
30
</parents>
<position x="3.70427629938967" y="1.428859632723">
</position>
</IntersectPoint>
<LineWDD id="34" name="g5">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
32;6
</parents>
<position x1="-1.08479166666667" y1="-3.36020833333333" 
x2="48.9152083333333" y2="83.2423320451105">
</position>
<term>
15
</term>
</LineWDD>
<DoubleIntersection id="35" name="DI_4">
<appearance visible="false">
</appearance>
<parents>
34;8
</parents>
<pointlist>
-4.47117410102837;-9.22559476350658 
2.30159076769503;2.50517809683991
</pointlist>
</DoubleIntersection>
<IntersectPoint id="36" name="P9" plist_index="0">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
35
</parents>
<position x="-4.47117410102837" y="-9.22559476350658">
</position>
</IntersectPoint>
<IntersectPoint id="37" name="P10" plist_index="1">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
35
</parents>
<position x="2.30159076769503" y="2.50517809683991">
</position>
</IntersectPoint>
<LineWDD id="39" name="g6">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
37;6
</parents>
<position x1="-1.08479166666667" y1="-3.36020833333333" 
x2="24.7971128435854" y2="93.2323742955735">
</position>
<term>
15
</term>
</LineWDD>
<DoubleIntersection id="40" name="DI_5">
<appearance visible="false">
</appearance>
<parents>
39;8
</parents>
<pointlist>
-2.83771220269356;-9.90219683541656 
0.668128869360224;3.18178016874989
</pointlist>
</DoubleIntersection>
<IntersectPoint id="41" name="P11" plist_index="0">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
40
</parents>
<position x="-2.83771220269356" y="-9.90219683541656">
</position>
</IntersectPoint>
<IntersectPoint id="42" name="P12" plist_index="1">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
40
</parents>
<position x="0.668128869360224" y="3.18178016874989">
</position>
</IntersectPoint>
<LineWDD id="44" name="g7">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
42;6
</parents>
<position x1="-1.08479166666667" y1="-3.36020833333333" 
x2="-1.08479166666664" y2="96.6397916666667">
</position>
<term>
15
</term>
</LineWDD>
<DoubleIntersection id="45" name="DI_6">
<appearance visible="false">
</appearance>
<parents>
44;15
</parents>
<pointlist>
-1.08479166666667;-8.63297320205673 
-1.08479166666667;1.91255653539007
</pointlist>
</DoubleIntersection>
<IntersectPoint id="46" name="P13" plist_index="0">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
45
</parents>
<position x="-1.08479166666667" y="-8.63297320205673">
</position>
</IntersectPoint>
<DoubleIntersection id="48" name="DI_7">
<appearance visible="false">
</appearance>
<parents>
44;8
</parents>
<pointlist>
-1.08479166666667;-10.1329732020567 
-1.08479166666666;3.41255653539007
</pointlist>
</DoubleIntersection>
<IntersectPoint id="49" name="U" plist_index="0">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
48
</parents>
<position x="-1.08479166666667" y="-10.1329732020567">
</position>
</IntersectPoint>
<IntersectPoint id="50" name="b" plist_index="1">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
48
</parents>
<position x="-1.08479166666666" y="3.41255653539007">
</position>
</IntersectPoint>
<LineWDD id="52" name="g8">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
50;6
</parents>
<position x1="-1.08479166666667" y1="-3.36020833333333" 
x2="-26.9666961769187" y2="93.2323742955735">
</position>
<term>
15
</term>
</LineWDD>
<DoubleIntersection id="53" name="DI_8">
<appearance visible="false">
</appearance>
<parents>
52;8
</parents>
<pointlist>
0.668128869360222;-9.90219683541656 
-2.83771220269356;3.18178016874989
</pointlist>
</DoubleIntersection>
<IntersectPoint id="54" name="P16" plist_index="0">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
53
</parents>
<position x="0.668128869360222" y="-9.90219683541656">
</position>
</IntersectPoint>
<IntersectPoint id="55" name="P17" plist_index="1">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
53
</parents>
<position x="-2.83771220269356" y="3.18178016874989">
</position>
</IntersectPoint>
<LineWDD id="57" name="g9">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
55;6
</parents>
<position x1="-1.08479166666667" y1="-3.36020833333333" 
x2="-51.0847916666666" y2="83.2423320451105">
</position>
<term>
15
</term>
</LineWDD>
<DoubleIntersection id="58" name="DI_9">
<appearance visible="false">
</appearance>
<parents>
57;8
</parents>
<pointlist>
2.30159076769503;-9.22559476350658 
-4.47117410102836;2.50517809683991
</pointlist>
</DoubleIntersection>
<IntersectPoint id="59" name="P18" plist_index="0">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
58
</parents>
<position x="2.30159076769503" y="-9.22559476350658">
</position>
</IntersectPoint>
<IntersectPoint id="60" name="P19" plist_index="1">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
58
</parents>
<position x="-4.47117410102836" y="2.50517809683991">
</position>
</IntersectPoint>
<LineWDD id="62" name="Zeit">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
60;6
</parents>
<position x1="-1.08479166666667" y1="-3.36020833333333" 
x2="-71.7954697853214" y2="67.3504697853214">
</position>
<term>
15
</term>
</LineWDD>
<DoubleIntersection id="63" name="DI_10">
<appearance visible="false">
</appearance>
<parents>
62;8
</parents>
<pointlist>
3.70427629938967;-8.14927629938967 -5.873859632723;1.428859632723
</pointlist>
</DoubleIntersection>
<IntersectPoint id="64" name="P20" plist_index="0">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
63
</parents>
<position x="3.70427629938967" y="-8.14927629938967">
</position>
</IntersectPoint>
<IntersectPoint id="65" name="P21" plist_index="1">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
63
</parents>
<position x="-5.873859632723" y="1.428859632723">
</position>
</IntersectPoint>
<LineWDD id="68" name="g11">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
65;6
</parents>
<position x1="-1.08479166666667" y1="-3.36020833333333" 
x2="-87.6873320451105" y2="46.6397916666667">
</position>
<term>
15
</term>
</LineWDD>
<DoubleIntersection id="69" name="DI_11">
<appearance visible="false">
</appearance>
<parents>
68;8
</parents>
<pointlist>
4.78059476350658;-6.74659076769503 
-6.95017809683991;0.0261741010283657
</pointlist>
</DoubleIntersection>
<IntersectPoint id="70" name="P22" plist_index="0">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
69
</parents>
<position x="4.78059476350658" y="-6.74659076769503">
</position>
</IntersectPoint>
<IntersectPoint id="71" name="P23" plist_index="1">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
69
</parents>
<position x="-6.95017809683991" y="0.0261741010283657">
</position>
</IntersectPoint>
<LineWDD id="73" name="g12">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
71;6
</parents>
<position x1="-1.08479166666667" y1="-3.36020833333333" 
x2="-97.6773742955735" y2="22.5216961769187">
</position>
<term>
15
</term>
</LineWDD>
<DoubleIntersection id="74" name="DI_12">
<appearance visible="false">
</appearance>
<parents>
73;8
</parents>
<pointlist>
5.45719683541656;-5.11312886936022 
-7.62678016874989;-1.60728779730645
</pointlist>
</DoubleIntersection>
<IntersectPoint id="75" name="P24" plist_index="0">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
74
</parents>
<position x="5.45719683541656" y="-5.11312886936022">
</position>
</IntersectPoint>
<IntersectPoint id="76" name="P25" plist_index="1">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
74
</parents>
<position x="-7.62678016874989" y="-1.60728779730645">
</position>
</IntersectPoint>
<DoubleIntersection id="77" name="DI_13">
<appearance visible="false">
</appearance>
<parents>
19;15
</parents>
<pointlist>
-6.17789142931629;-4.72490030170644 
4.00830809598295;-1.99551636496023
</pointlist>
</DoubleIntersection>
<IntersectPoint id="78" name="P26" plist_index="0">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
77
</parents>
<position x="-6.17789142931629" y="-4.72490030170644">
</position>
</IntersectPoint>
<IntersectPoint id="79" name="P27" plist_index="1">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
77
</parents>
<position x="4.00830809598295" y="-1.99551636496023">
</position>
</IntersectPoint>
<DoubleIntersection id="80" name="DI_14">
<appearance visible="false">
</appearance>
<parents>
24;15
</parents>
<pointlist>
-5.65113999116325;-5.99659076769503 
3.48155665782992;-0.723825898971633
</pointlist>
</DoubleIntersection>
<IntersectPoint id="81" name="P28" plist_index="0">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
80
</parents>
<position x="-5.65113999116325" y="-5.99659076769503">
</position>
</IntersectPoint>
<IntersectPoint id="82" name="P29" plist_index="1">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
80
</parents>
<position x="3.48155665782992" y="-0.723825898971633">
</position>
</IntersectPoint>
<DoubleIntersection id="83" name="DI_15">
<appearance visible="false">
</appearance>
<parents>
29;15
</parents>
<pointlist>
-4.81319946094318;-7.08861612760985 
2.64361612760985;0.368199460943179
</pointlist>
</DoubleIntersection>
<IntersectPoint id="84" name="P30" plist_index="0">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
83
</parents>
<position x="-4.81319946094318" y="-7.08861612760985">
</position>
</IntersectPoint>
<IntersectPoint id="85" name="P31" plist_index="1">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
83
</parents>
<position x="2.64361612760985" y="0.368199460943179">
</position>
</IntersectPoint>
<DoubleIntersection id="86" name="DI_16">
<appearance visible="false">
</appearance>
<parents>
34;15
</parents>
<pointlist>
-3.72117410102837;-7.92655665782992 
1.55159076769503;1.20613999116325
</pointlist>
</DoubleIntersection>
<IntersectPoint id="87" name="P32" plist_index="0">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
86
</parents>
<position x="-3.72117410102837" y="-7.92655665782992">
</position>
</IntersectPoint>
<IntersectPoint id="88" name="P33" plist_index="1">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
86
</parents>
<position x="1.55159076769503" y="1.20613999116325">
</position>
</IntersectPoint>
<DoubleIntersection id="89" name="DI_17">
<appearance visible="false">
</appearance>
<parents>
39;15
</parents>
<pointlist>
-2.44948363503978;-8.45330809598295 
0.279900301706443;1.73289142931629
</pointlist>
</DoubleIntersection>
<IntersectPoint id="90" name="P34" plist_index="0">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
89
</parents>
<position x="-2.44948363503978" y="-8.45330809598295">
</position>
</IntersectPoint>
<IntersectPoint id="91" name="P35" plist_index="1">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
89
</parents>
<position x="0.279900301706443" y="1.73289142931629">
</position>
</IntersectPoint>
<IntersectPoint id="93" name="P36" plist_index="0">
<appearance shape="0" brush_style="0">
</appearance>
<parents>
93
</parents>
<position x="0" y="0" z="2">
</position>
</IntersectPoint>
<IntersectPoint id="94" name="P37" plist_index="1">
<appearance shape="0" brush_style="0">
</appearance>
<parents>
93
</parents>
<position x="0" y="0" z="2">
</position>
</IntersectPoint>
<IntersectPoint id="96" name="P38" plist_index="0">
<appearance shape="0" brush_style="0">
</appearance>
<parents>
96
</parents>
<position x="0" y="0" z="2">
</position>
</IntersectPoint>
<IntersectPoint id="99" name="P39" plist_index="0">
<appearance shape="0" brush_style="0">
</appearance>
<parents>
99
</parents>
<position x="0" y="0" z="2">
</position>
</IntersectPoint>
<IntersectPoint id="100" name="P40" plist_index="1">
<appearance shape="0" brush_style="0">
</appearance>
<parents>
99
</parents>
<position x="0" y="0" z="2">
</position>
</IntersectPoint>
<IntersectPoint id="102" name="P41" plist_index="0">
<appearance shape="0" brush_style="0">
</appearance>
<parents>
102
</parents>
<position x="0" y="0" z="2">
</position>
</IntersectPoint>
<DoubleIntersection id="104" name="DI_18">
<appearance visible="false">
</appearance>
<parents>
52;15
</parents>
<pointlist>
0.279900301706441;-8.45330809598295 
-2.44948363503977;1.73289142931629
</pointlist>
</DoubleIntersection>
<IntersectPoint id="105" name="P42" plist_index="0">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
104
</parents>
<position x="0.279900301706441" y="-8.45330809598295">
</position>
</IntersectPoint>
<IntersectPoint id="106" name="P43" plist_index="1">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
104
</parents>
<position x="-2.44948363503977" y="1.73289142931629">
</position>
</IntersectPoint>
<DoubleIntersection id="107" name="DI_19">
<appearance visible="false">
</appearance>
<parents>
57;15
</parents>
<pointlist>
1.55159076769503;-7.92655665782992 
-3.72117410102837;1.20613999116325
</pointlist>
</DoubleIntersection>
<IntersectPoint id="108" name="P44" plist_index="0">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
107
</parents>
<position x="1.55159076769503" y="-7.92655665782992">
</position>
</IntersectPoint>
<IntersectPoint id="109" name="P45" plist_index="1">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
107
</parents>
<position x="-3.72117410102837" y="1.20613999116325">
</position>
</IntersectPoint>
<DoubleIntersection id="110" name="DI_20">
<appearance visible="false">
</appearance>
<parents>
62;15
</parents>
<pointlist>
2.64361612760985;-7.08861612760985 
-4.81319946094318;0.368199460943179
</pointlist>
</DoubleIntersection>
<IntersectPoint id="111" name="P46" plist_index="0">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
110
</parents>
<position x="2.64361612760985" y="-7.08861612760985">
</position>
</IntersectPoint>
<IntersectPoint id="112" name="P47" plist_index="1">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
110
</parents>
<position x="-4.81319946094318" y="0.368199460943179">
</position>
</IntersectPoint>
<PointLXL id="113" name="P48">
<appearance shape="0" brush_style="0">
</appearance>
<parents>
73;68
</parents>
<position x="-1.08479166666667" y="-3.36020833333333">
</position>
</PointLXL>
<DoubleIntersection id="114" name="DI_21">
<appearance visible="false">
</appearance>
<parents>
73;15
</parents>
<pointlist>
4.00830809598295;-4.72490030170644 
-6.17789142931629;-1.99551636496023
</pointlist>
</DoubleIntersection>
<IntersectPoint id="115" name="P49" plist_index="0">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
114
</parents>
<position x="4.00830809598295" y="-4.72490030170644">
</position>
</IntersectPoint>
<IntersectPoint id="116" name="P50" plist_index="1">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
114
</parents>
<position x="-6.17789142931629" y="-1.99551636496023">
</position>
</IntersectPoint>
<DoubleIntersection id="117" name="DI_22">
<appearance visible="false">
</appearance>
<parents>
17;15
</parents>
<pointlist>
-6.35755653539007;-3.36020833333333 
4.18797320205673;-3.36020833333333
</pointlist>
</DoubleIntersection>
<IntersectPoint id="118" name="P51" plist_index="0">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
117
</parents>
<position x="-6.35755653539007" y="-3.36020833333333">
</position>
</IntersectPoint>
<IntersectPoint id="119" name="P52" plist_index="1">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
117
</parents>
<position x="4.18797320205673" y="-3.36020833333333">
</position>
</IntersectPoint>
<Number id="120" name="t" show_name="true">
<appearance color="$00808080">
</appearance>
<position x="-8.94291666666667" y="4.70958333333333" 
width="250" height="33">
</position>
<value min="0" actual="0" max="24" quant="0.001" 
ani_step="0.01">
</value>
</Number>
<ObjectName id="121" name="Name2">
<appearance visible="false">
</appearance>
<parents>
62
</parents>
<position x="-2.64042658527707" y="-1.380309346011" 
width="5.74145833333333" height="1.93145833333333">
</position>
<text>
<![CDATA[Zeit]]>
</text>
</ObjectName>
<PointWDC id="124" name="0o">
<appearance shape="0" brush_style="0">
</appearance>
<parents>
1;6;10;120
</parents>
<position x="4.18797320205673" y="-3.36020833333333" 
x_term="x(N) + ( d(N;P2) - 1.5 )*cos(15*t)" y_term="y(N) + ( d(N;P2) - 1.5 
)*sin(15*t)">
</position>
</PointWDC>
<PointWDC id="131" name="15o_O">
<appearance shape="0" brush_style="0">
</appearance>
<parents>
1;6;10;120
</parents>
<position x="4.00830809598295" y="-1.99551636496022" 
x_term="x(N) + ( d(N;P2) - 1.5 )*cos(15*( t + 1 ))" y_term="y(N) + ( d(N;P2) - 1.5 )*sin(15*( 
t + 1 ))">
</position>
</PointWDC>
<PointWDC id="144" name="30oO">
<appearance shape="0" brush_style="0">
</appearance>
<parents>
1;6;10;120
</parents>
<position x="3.48155665782992" y="-0.723825898971634" 
x_term="x(N) + ( d(N;P2) - 1.5 )*cos(15*( t + 2 ))" y_term="y(N) + ( d(N;P2) - 1.5 )*sin(15*( 
t + 2 ))">
</position>
</PointWDC>
<PointWDC id="155" name="P56">
<appearance shape="0" brush_style="0">
</appearance>
<parents>
1;6;10;120
</parents>
<position x="2.64361612760985" y="0.368199460943178" 
x_term="x(N) + ( d(N;P2) - 1.5 )*cos(15*( t + 3 ))" y_term="y(N) + ( d(N;P2) - 1.5 )*sin(15*( 
t + 3 ))">
</position>
</PointWDC>
<PointWDC id="168" name="P57">
<appearance shape="0" brush_style="0">
</appearance>
<parents>
1;6;10;120
</parents>
<position x="1.55159076769503" y="1.20613999116325" 
x_term="x(N) + ( d(N;P2) - 1.5 )*cos(15*( t + 4 ))" y_term="y(N) + ( d(N;P2) - 1.5 )*sin(15*( 
t + 4 ))">
</position>
</PointWDC>
<PointWDC id="183" name="P58">
<appearance shape="0" brush_style="0">
</appearance>
<parents>
1;6;10;120
</parents>
<position x="0.279900301706442" y="1.73289142931629" 
x_term="x(N) + ( d(N;P2) - 1.5 )*cos(15*( t + 5 ))" y_term="y(N) + ( d(N;P2) - 1.5 )*sin(15*( 
t + 5 ))">
</position>
</PointWDC>
<PointWDC id="200" name="P59">
<appearance shape="0" brush_style="0">
</appearance>
<parents>
1;6;10;120
</parents>
<position x="-1.08479166666667" y="1.91255653539007" 
x_term="x(N) + ( d(N;P2) - 1.5 )*cos(15*( t + 6 ))" y_term="y(N) + ( d(N;P2) - 1.5 )*sin(15*( 
t + 6 ))">
</position>
</PointWDC>
<PointWDC id="219" name="P60">
<appearance shape="0" brush_style="0">
</appearance>
<parents>
1;6;10;120
</parents>
<position x="-2.44948363503978" y="1.73289142931629" 
x_term="x(N) + ( d(N;P2) - 1.5 )*cos(15*( t + 7 ))" y_term="y(N) + ( d(N;P2) - 1.5 )*sin(15*( 
t + 7 ))">
</position>
</PointWDC>
<PointWDC id="240" name="P61">
<appearance shape="0" brush_style="0">
</appearance>
<parents>
1;6;10;120
</parents>
<position x="-3.72117410102837" y="1.20613999116325" 
x_term="x(N) + ( d(N;P2) - 1.5 )*cos(15*( t + 8 ))" y_term="y(N) + ( d(N;P2) - 1.5 )*sin(15*( 
t + 8 ))">
</position>
</PointWDC>
<PointWDC id="263" name="P62">
<appearance shape="0" brush_style="0">
</appearance>
<parents>
1;6;10;120
</parents>
<position x="-4.81319946094318" y="0.368199460943179" 
x_term="x(N) + ( d(N;P2) - 1.5 )*cos(15*( t + 9 ))" y_term="y(N) + ( d(N;P2) - 1.5 )*sin(15*( 
t + 9 ))">
</position>
</PointWDC>
<PointWDC id="288" name="P63">
<appearance shape="0" brush_style="0">
</appearance>
<parents>
1;6;10;120
</parents>
<position x="-5.65113999116325" y="-0.723825898971634" 
x_term="x(N) + ( d(N;P2) - 1.5 )*cos(15*( t + 10 ))" 
y_term="y(N) + ( d(N;P2) - 1.5 )*sin(15*( t + 10 ))">
</position>
</PointWDC>
<PointWDC id="315" name="P64">
<appearance shape="0" brush_style="0">
</appearance>
<parents>
1;6;10;120
</parents>
<position x="-6.17789142931629" y="-1.99551636496022" 
x_term="x(N) + ( d(N;P2) - 1.5 )*cos(15*( t + 11 ))" 
y_term="y(N) + ( d(N;P2) - 1.5 )*sin(15*( t + 11 ))">
</position>
</PointWDC>
<PointWDC id="344" name="P65">
<appearance shape="0" brush_style="0">
</appearance>
<parents>
1;6;10;120
</parents>
<position x="-6.35755653539007" y="-3.36020833333333" 
x_term="x(N) + ( d(N;P2) - 1.5 )*cos(15*( t + 12 ))" 
y_term="y(N) + ( d(N;P2) - 1.5 )*sin(15*( t + 12 ))">
</position>
</PointWDC>
<PointWDC id="375" name="P66">
<appearance shape="0" brush_style="0">
</appearance>
<parents>
1;6;10;120
</parents>
<position x="-6.17789142931629" y="-4.72490030170644" 
x_term="x(N) + ( d(N;P2) - 1.5 )*cos(15*( t + 13 ))" 
y_term="y(N) + ( d(N;P2) - 1.5 )*sin(15*( t + 13 ))">
</position>
</PointWDC>
<PointWDC id="408" name="P67">
<appearance shape="0" brush_style="0">
</appearance>
<parents>
1;6;10;120
</parents>
<position x="-5.65113999116325" y="-5.99659076769503" 
x_term="x(N) + ( d(N;P2) - 1.5 )*cos(15*( t + 14 ))" 
y_term="y(N) + ( d(N;P2) - 1.5 )*sin(15*( t + 14 ))">
</position>
</PointWDC>
<PointWDC id="443" name="P68">
<appearance shape="0" brush_style="0">
</appearance>
<parents>
1;6;10;120
</parents>
<position x="-4.81319946094318" y="-7.08861612760985" 
x_term="x(N) + ( d(N;P2) - 1.5 )*cos(15*( t + 15 ))" 
y_term="y(N) + ( d(N;P2) - 1.5 )*sin(15*( t + 15 ))">
</position>
</PointWDC>
<PointWDC id="480" name="P69">
<appearance shape="0" brush_style="0">
</appearance>
<parents>
1;6;10;120
</parents>
<position x="-3.72117410102837" y="-7.92655665782992" 
x_term="x(N) + ( d(N;P2) - 1.5 )*cos(15*( t + 16 ))" 
y_term="y(N) + ( d(N;P2) - 1.5 )*sin(15*( t + 16 ))">
</position>
</PointWDC>
<PointWDC id="519" name="P70">
<appearance shape="0" brush_style="0">
</appearance>
<parents>
1;6;10;120
</parents>
<position x="-2.44948363503977" y="-8.45330809598295" 
x_term="x(N) + ( d(N;P2) - 1.5 )*cos(15*( t + 17 ))" 
y_term="y(N) + ( d(N;P2) - 1.5 )*sin(15*( t + 17 ))">
</position>
</PointWDC>
<PointWDC id="560" name="P71">
<appearance shape="0" brush_style="0">
</appearance>
<parents>
1;6;10;120
</parents>
<position x="-1.08479166666667" y="-8.63297320205673" 
x_term="x(N) + ( d(N;P2) - 1.5 )*cos(15*( t + 18 ))" 
y_term="y(N) + ( d(N;P2) - 1.5 )*sin(15*( t + 18 ))">
</position>
</PointWDC>
<PointWDC id="603" name="P72">
<appearance shape="0" brush_style="0">
</appearance>
<parents>
1;6;10;120
</parents>
<position x="0.279900301706439" y="-8.45330809598295" 
x_term="x(N) + ( d(N;P2) - 1.5 )*cos(15*( t + 19 ))" 
y_term="y(N) + ( d(N;P2) - 1.5 )*sin(15*( t + 19 ))">
</position>
</PointWDC>
<PointWDC id="648" name="P73">
<appearance shape="0" brush_style="0">
</appearance>
<parents>
1;6;10;120
</parents>
<position x="1.55159076769503" y="-7.92655665782992" 
x_term="x(N) + ( d(N;P2) - 1.5 )*cos(15*( t + 20 ))" 
y_term="y(N) + ( d(N;P2) - 1.5 )*sin(15*( t + 20 ))">
</position>
</PointWDC>
<PointWDC id="695" name="P74">
<appearance shape="0" brush_style="0">
</appearance>
<parents>
1;6;10;120
</parents>
<position x="2.64361612760984" y="-7.08861612760985" 
x_term="x(N) + ( d(N;P2) - 1.5 )*cos(15*( t + 21 ))" 
y_term="y(N) + ( d(N;P2) - 1.5 )*sin(15*( t + 21 ))">
</position>
</PointWDC>
<PointWDC id="744" name="P75">
<appearance shape="0" brush_style="0">
</appearance>
<parents>
1;6;10;120
</parents>
<position x="3.48155665782992" y="-5.99659076769504" 
x_term="x(N) + ( d(N;P2) - 1.5 )*cos(15*( t + 22 ))" 
y_term="y(N) + ( d(N;P2) - 1.5 )*sin(15*( t + 22 ))">
</position>
</PointWDC>
<PointWDC id="795" name="P76">
<appearance shape="0" brush_style="0">
</appearance>
<parents>
1;6;10;120
</parents>
<position x="4.00830809598295" y="-4.72490030170644" 
x_term="x(N) + ( d(N;P2) - 1.5 )*cos(15*( t + 23 ))" 
y_term="y(N) + ( d(N;P2) - 1.5 )*sin(15*( t + 23 ))">
</position>
</PointWDC>
<Segment id="846" name="s1">
<appearance shape="0" brush_style="0" groups="1">
</appearance>
<parents>
119;12
</parents>
<position x1="4.18797320205673" y1="-3.36020833333333" 
x2="5.68797320205673" y2="-3.36020833333333">
</position>
</Segment>
<Segment id="847" name="s2">
<appearance shape="0" brush_style="0" groups="1">
</appearance>
<parents>
22;79
</parents>
<position x1="5.45719683541656" y1="-1.60728779730644" 
x2="4.00830809598295" y2="-1.99551636496023">
</position>
</Segment>
<Segment id="848" name="s3">
<appearance shape="0" brush_style="0" groups="1">
</appearance>
<parents>
82;27
</parents>
<position x1="3.48155665782992" y1="-0.723825898971633" 
x2="4.78059476350658" y2="0.0261741010283657">
</position>
</Segment>
<Segment id="849" name="s4">
<appearance shape="0" brush_style="0" groups="1">
</appearance>
<parents>
85;32
</parents>
<position x1="2.64361612760985" y1="0.368199460943179" 
x2="3.70427629938967" y2="1.428859632723">
</position>
</Segment>
<Segment id="850" name="s5">
<appearance shape="0" brush_style="0" groups="1">
</appearance>
<parents>
37;88
</parents>
<position x1="2.30159076769503" y1="2.50517809683991" 
x2="1.55159076769503" y2="1.20613999116325">
</position>
</Segment>
<Segment id="851" name="s6">
<appearance shape="0" brush_style="0" groups="1">
</appearance>
<parents>
42;91
</parents>
<position x1="0.668128869360224" y1="3.18178016874989" 
x2="0.279900301706443" y2="1.73289142931629">
</position>
</Segment>
<Segment id="852" name="s7">
<appearance shape="0" brush_style="0" groups="1">
</appearance>
<parents>
55;106
</parents>
<position x1="-2.83771220269356" y1="3.18178016874989" 
x2="-2.44948363503977" y2="1.73289142931629">
</position>
</Segment>
<Segment id="853" name="s8">
<appearance shape="0" brush_style="0" groups="1">
</appearance>
<parents>
60;109
</parents>
<position x1="-4.47117410102836" y1="2.50517809683991" 
x2="-3.72117410102837" y2="1.20613999116325">
</position>
</Segment>
<Segment id="854" name="s9">
<appearance shape="0" brush_style="0" groups="1">
</appearance>
<parents>
65;112
</parents>
<position x1="-5.873859632723" y1="1.428859632723" 
x2="-4.81319946094318" y2="0.368199460943179">
</position>
</Segment>
<Segment id="856" name="s11">
<appearance shape="0" brush_style="0" groups="1">
</appearance>
<parents>
76;116
</parents>
<position x1="-7.62678016874989" y1="-1.60728779730645" 
x2="-6.17789142931629" y2="-1.99551636496023">
</position>
</Segment>
<Segment id="857" name="s12">
<appearance shape="0" brush_style="0" groups="1">
</appearance>
<parents>
21;78
</parents>
<position x1="-7.62678016874989" y1="-5.11312886936022" 
x2="-6.17789142931629" y2="-4.72490030170644">
</position>
</Segment>
<Segment id="858" name="s13">
<appearance shape="0" brush_style="0" groups="1">
</appearance>
<parents>
26;81
</parents>
<position x1="-6.95017809683991" y1="-6.74659076769503" 
x2="-5.65113999116325" y2="-5.99659076769503">
</position>
</Segment>
<Segment id="859" name="s14">
<appearance shape="0" brush_style="0" groups="1">
</appearance>
<parents>
31;84
</parents>
<position x1="-5.873859632723" y1="-8.14927629938967" 
x2="-4.81319946094318" y2="-7.08861612760985">
</position>
</Segment>
<Segment id="860" name="s15">
<appearance shape="0" brush_style="0" groups="1">
</appearance>
<parents>
36;87
</parents>
<position x1="-4.47117410102837" y1="-9.22559476350658" 
x2="-3.72117410102837" y2="-7.92655665782992">
</position>
</Segment>
<Segment id="861" name="s16">
<appearance shape="0" brush_style="0" groups="1">
</appearance>
<parents>
41;90
</parents>
<position x1="-2.83771220269356" y1="-9.90219683541656" 
x2="-2.44948363503978" y2="-8.45330809598295">
</position>
</Segment>
<Segment id="862" name="s17">
<appearance shape="0" brush_style="0" groups="1">
</appearance>
<parents>
49;46
</parents>
<position x1="-1.08479166666667" y1="-10.1329732020567" 
x2="-1.08479166666667" y2="-8.63297320205673">
</position>
</Segment>
<Segment id="863" name="s18">
<appearance shape="0" brush_style="0" groups="1">
</appearance>
<parents>
54;105
</parents>
<position x1="0.668128869360222" y1="-9.90219683541656" 
x2="0.279900301706441" y2="-8.45330809598295">
</position>
</Segment>
<Segment id="864" name="s19">
<appearance shape="0" brush_style="0" groups="1">
</appearance>
<parents>
59;108
</parents>
<position x1="2.30159076769503" y1="-9.22559476350658" 
x2="1.55159076769503" y2="-7.92655665782992">
</position>
</Segment>
<Segment id="865" name="s20">
<appearance shape="0" brush_style="0" groups="1">
</appearance>
<parents>
64;111
</parents>
<position x1="3.70427629938967" y1="-8.14927629938967" 
x2="2.64361612760985" y2="-7.08861612760985">
</position>
</Segment>
<Segment id="866" name="s21">
<appearance shape="0" brush_style="0" groups="1">
</appearance>
<parents>
75;115
</parents>
<position x1="5.45719683541656" y1="-5.11312886936022" 
x2="4.00830809598295" y2="-4.72490030170644">
</position>
</Segment>
<DoubleIntersection id="867" name="DI_23">
<appearance visible="false">
</appearance>
<parents>
68;15
</parents>
<pointlist>
3.48155665782992;-5.99659076769503 
-5.65113999116325;-0.723825898971634
</pointlist>
</DoubleIntersection>
<IntersectPoint id="868" name="P77" plist_index="0">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
867
</parents>
<position x="3.48155665782992" y="-5.99659076769503">
</position>
</IntersectPoint>
<IntersectPoint id="869" name="P78" plist_index="1">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
867
</parents>
<position x="-5.65113999116325" y="-0.723825898971634">
</position>
</IntersectPoint>
<Segment id="870" name="s10">
<appearance shape="0" brush_style="0" groups="1">
</appearance>
<parents>
71;869
</parents>
<position x1="-6.95017809683991" y1="0.0261741010283657" 
x2="-5.65113999116325" y2="-0.723825898971634">
</position>
</Segment>
<Segment id="871" name="s22">
<appearance shape="0" brush_style="0" groups="1">
</appearance>
<parents>
70;868
</parents>
<position x1="4.78059476350658" y1="-6.74659076769503" 
x2="3.48155665782992" y2="-5.99659076769503">
</position>
</Segment>
<DoubleIntersection id="872" name="DI_24">
<appearance visible="false">
</appearance>
<parents>
17;8
</parents>
<pointlist>
-7.85755653539007;-3.36020833333333 
5.68797320205673;-3.36020833333333
</pointlist>
</DoubleIntersection>
<IntersectPoint id="873" name="P79" plist_index="0">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
872
</parents>
<position x="-7.85755653539007" y="-3.36020833333333">
</position>
</IntersectPoint>
<IntersectPoint id="874" name="P80" plist_index="1">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
872
</parents>
<position x="5.68797320205673" y="-3.36020833333333">
</position>
</IntersectPoint>
<PointWDC id="878" name="P81">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
1;6;10
</parents>
<position x="-1.08479166666667" y="1.91255653539007" 
x_term="x(N)" y_term="y(N) + ( d(N;P2) - 1.5 )">
</position>
</PointWDC>
<Segment id="905" name="s23">
<appearance shape="0" brush_style="0" groups="1">
</appearance>
<parents>
50;878
</parents>
<position x1="-1.08479166666666" y1="3.41255653539007" 
x2="-1.08479166666667" y2="1.91255653539007">
</position>
</Segment>
<Segment id="906" name="s24">
<appearance shape="0" brush_style="0" groups="1">
</appearance>
<parents>
118;873
</parents>
<position x1="-6.35755653539007" y1="-3.36020833333333" 
x2="-7.85755653539007" y2="-3.36020833333333">
</position>
</Segment>
<Number id="907" name="Länge" show_name="true">
<appearance color="$00FF0000" pen_style="2" brush_style="2" 
groups="4">
</appearance>
<position x="2.143125" y="4.94770833333333" width="250" 
height="33">
</position>
<value min="-180" actual="22.025" max="180" quant="0.001" 
ani_step="0.001">
</value>
</Number>
<Number id="908" name="Breite" show_name="true">
<appearance color="$00FF0000" pen_style="2" brush_style="2" 
groups="4">
</appearance>
<position x="9.52500000000002" y="4.89479166666666" 
width="250" height="33">
</position>
<value min="-90" actual="-39.114" max="90" quant="0.001" 
ani_step="0.001">
</value>
</Number>
<CircleWDR id="967" name="k3">
<appearance color="$00FF0000" pen_style="2" shape="0" 
brush_style="2" groups="4">
</appearance>
<parents>
6;10;908
</parents>
<position x1="-1.08479166666667" y1="-3.36020833333333" 
x2="3.00630589308129" y2="-3.36020833333333">
</position>
<radius>
<![CDATA[( d(N;P2) - 1.5 )*cos(Breite)]]>
</radius>
</CircleWDR>
<LineWDD id="978" name="g10">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
12;6;907;120
</parents>
<position x1="-1.08479166666667" y1="-3.36020833333333" 
x2="91.6172396682579" y2="34.1409034685676">
</position>
<term>
Länge + t*15
</term>
</LineWDD>
<DoubleIntersection id="979" name="DI_25">
<appearance visible="false">
</appearance>
<parents>
978;15
</parents>
<pointlist>
-5.97275180748753;-5.33755378180465 
3.80316847415419;-1.38286288486202
</pointlist>
</DoubleIntersection>
<IntersectPoint id="980" name="P82" plist_index="0">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
979
</parents>
<position x="-5.97275180748753" y="-5.33755378180465">
</position>
</IntersectPoint>
<IntersectPoint id="981" name="P83" plist_index="1">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
979
</parents>
<position x="3.80316847415419" y="-1.38286288486202">
</position>
</IntersectPoint>
<DoubleIntersection id="986" name="DI_26">
<appearance visible="false">
</appearance>
<parents>
978;967
</parents>
<pointlist>
-4.87732220844655;-4.89441540313925 
2.70773887511321;-1.82600126352741
</pointlist>
</DoubleIntersection>
<IntersectPoint id="987" name="P84" plist_index="0">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
986
</parents>
<position x="-4.87732220844655" y="-4.89441540313925">
</position>
</IntersectPoint>
<IntersectPoint id="988" name="P85" plist_index="1">
<appearance color="$00FF0000" shape="0" brush_style="0" 
groups="4">
</appearance>
<parents>
986
</parents>
<position x="2.70773887511321" y="-1.82600126352741">
</position>
</IntersectPoint>
<Segment id="989" name="s25">
<appearance color="$00FF0000" pen_style="2" shape="0" 
brush_style="2" groups="4">
</appearance>
<parents>
6;981
</parents>
<position x1="-1.08479166666667" y1="-3.36020833333333" 
x2="3.80316847415419" y2="-1.38286288486202">
</position>
</Segment>
<ObjectName id="990" name="Name3">
<parents>
124
</parents>
<position x="4.33797320205673" y="-3.36020833333333" 
width="5.74145833333333" height="1.93145833333333">
</position>
<text>
<![CDATA[0<sup>o</sup>]]>
</text>
</ObjectName>
<ObjectName id="991" name="Name4">
<appearance visible="false">
</appearance>
<parents>
131
</parents>
<position x="4.26072274784896" y="-1.67992287760851" 
width="5.74145833333333" height="1.93145833333333">
</position>
<text>
<![CDATA[15<sup>o_</sup>O]]>
</text>
</ObjectName>
<ObjectName id="992" name="Name5">
<appearance visible="false">
</appearance>
<parents>
144
</parents>
<position x="3.63155665782992" y="-0.723825898971634" 
width="5.74145833333333" height="1.93145833333333">
</position>
<text>
<![CDATA[30<sup>o</sup>O]]>
</text>
</ObjectName>
<ObjectName id="993" name="Name6">
<appearance visible="false">
</appearance>
<parents>
49
</parents>
<position x="-0.934791666666669" y="-10.1329732020567" 
width="5.74145833333333" height="1.93145833333333">
</position>
<text>
<![CDATA[U]]>
</text>
</ObjectName>
<ObjectName id="994" name="Name7">
<appearance visible="false">
</appearance>
<parents>
50
</parents>
<position x="-0.934791666666665" y="3.41255653539007" 
width="5.74145833333333" height="1.93145833333333">
</position>
<text>
<![CDATA[b]]>
</text>
</ObjectName>
<PointWDC id="996" name="P14">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
1;49;10
</parents>
<position x="8.68797320205673" y="-10.1329732020567" 
x_term="x(U) + d(N;P2) + 3" y_term="y(U)">
</position>
</PointWDC>
<PointWDC id="1026" name="P15">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
1;49;10
</parents>
<position x="8.68797320205673" y="-8.43978198487588" 
x_term="x(U) + d(N;P2) + 3" y_term="y(U) + d(N;P2)/4">
</position>
</PointWDC>
<PointWDC id="1085" name="P53">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
1;49;10
</parents>
<position x="8.68797320205673" y="-6.74659076769503" 
x_term="x(U) + d(N;P2) + 3" y_term="y(U) + d(N;P2)/4*2">
</position>
</PointWDC>
<PointWDC id="1146" name="P54">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
1;49;10
</parents>
<position x="8.68797320205673" y="-5.05339955051418" 
x_term="x(U) + d(N;P2) + 3" y_term="y(U) + d(N;P2)/4*3">
</position>
</PointWDC>
<PointWDC id="1274" name="P86">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
1;49;10
</parents>
<position x="8.68797320205673" y="-3.36020833333333" 
x_term="x(U) + d(N;P2) + 3" y_term="y(U) + d(N;P2)/4*4">
</position>
</PointWDC>
<PointWDC id="1341" name="P87">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
1;49;10
</parents>
<position x="8.68797320205673" y="-1.66701711615248" 
x_term="x(U) + d(N;P2) + 3" y_term="y(U) + d(N;P2)/4*5">
</position>
</PointWDC>
<PointWDC id="1410" name="P88">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
1;49;10
</parents>
<position x="8.68797320205673" y="0.0261741010283671" 
x_term="x(U) + d(N;P2) + 3" y_term="y(U) + d(N;P2)/4*6">
</position>
</PointWDC>
<PointWDC id="1481" name="P89">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
1;49;10
</parents>
<position x="8.68797320205673" y="1.71936531820922" 
x_term="x(U) + d(N;P2) + 3" y_term="y(U) + d(N;P2)/4*7">
</position>
</PointWDC>
<PointWDC id="1554" name="P90">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
1;49;10
</parents>
<position x="8.68797320205673" y="3.41255653539007" 
x_term="x(U) + d(N;P2) + 3" y_term="y(U) + d(N;P2)/4*8">
</position>
</PointWDC>
<PointWDC id="1629" name="P91">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
1;49;10
</parents>
<position x="10.6879732020567" y="3.41255653539007" 
x_term="x(U) + d(N;P2) + 3 + 2" y_term="y(U) + d(N;P2)/4*8">
</position>
</PointWDC>
<PointWDC id="1706" name="P92">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
1;49;10
</parents>
<position x="10.6879732020567" y="1.71936531820922" 
x_term="x(U) + d(N;P2) + 3 + 2" y_term="y(U) + d(N;P2)/4*7">
</position>
</PointWDC>
<PointWDC id="1785" name="P93">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
1;49;10
</parents>
<position x="10.6879732020567" y="0.0261741010283671" 
x_term="x(U) + d(N;P2) + 3 + 2" y_term="y(U) + d(N;P2)/4*6">
</position>
</PointWDC>
<PointWDC id="1866" name="P94">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
1;49;10
</parents>
<position x="10.6879732020567" y="-1.66701711615248" 
x_term="x(U) + d(N;P2) + 3 + 2" y_term="y(U) + d(N;P2)/4*5">
</position>
</PointWDC>
<PointWDC id="1949" name="P95">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
1;49;10
</parents>
<position x="10.6879732020567" y="-3.36020833333333" 
x_term="x(U) + d(N;P2) + 3 + 2" y_term="y(U) + d(N;P2)/4*4">
</position>
</PointWDC>
<PointWDC id="2034" name="P96">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
1;49;10
</parents>
<position x="10.6879732020567" y="-5.05339955051418" 
x_term="x(U) + d(N;P2) + 3 + 2" y_term="y(U) + d(N;P2)/4*3">
</position>
</PointWDC>
<PointWDC id="2121" name="P97">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
1;49;10
</parents>
<position x="10.6879732020567" y="-6.74659076769503" 
x_term="x(U) + d(N;P2) + 3 + 2" y_term="y(U) + d(N;P2)/4*2">
</position>
</PointWDC>
<PointWDC id="2210" name="P98">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
1;49;10
</parents>
<position x="10.6879732020567" y="-8.43978198487588" 
x_term="x(U) + d(N;P2) + 3 + 2" y_term="y(U) + d(N;P2)/4">
</position>
</PointWDC>
<PointWDC id="2300" name="P99">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
1;49;10
</parents>
<position x="10.6879732020567" y="-10.1329732020567" 
x_term="x(U) + d(N;P2) + 3 + 2" y_term="y(U)">
</position>
</PointWDC>
<Vector id="2346" name="v1">
<appearance color="$000000FF" line_width="5" shape="0" 
brush_style="2" groups="2">
</appearance>
<parents>
1629;1554
</parents>
<position x1="10.6879732020567" y1="3.41255653539007" 
x2="8.68797320205673" y2="3.41255653539007">
</position>
</Vector>
<Vector id="2347" name="v2">
<appearance color="$000000FF" line_width="5" shape="0" 
brush_style="2" groups="2">
</appearance>
<parents>
1706;1481
</parents>
<position x1="10.6879732020567" y1="1.71936531820922" 
x2="8.68797320205673" y2="1.71936531820922">
</position>
</Vector>
<Vector id="2348" name="v3">
<appearance color="$000000FF" line_width="5" shape="0" 
brush_style="2" groups="2">
</appearance>
<parents>
1785;1410
</parents>
<position x1="10.6879732020567" y1="0.0261741010283671" 
x2="8.68797320205673" y2="0.0261741010283671">
</position>
</Vector>
<Vector id="2349" name="v4">
<appearance color="$000000FF" line_width="5" shape="0" 
brush_style="2" groups="2">
</appearance>
<parents>
1866;1341
</parents>
<position x1="10.6879732020567" y1="-1.66701711615248" 
x2="8.68797320205673" y2="-1.66701711615248">
</position>
</Vector>
<Vector id="2350" name="v5">
<appearance color="$000000FF" line_width="5" shape="0" 
brush_style="2" groups="2">
</appearance>
<parents>
1949;1274
</parents>
<position x1="10.6879732020567" y1="-3.36020833333333" 
x2="8.68797320205673" y2="-3.36020833333333">
</position>
</Vector>
<Vector id="2351" name="v6">
<appearance color="$000000FF" line_width="5" shape="0" 
brush_style="2" groups="2">
</appearance>
<parents>
2034;1146
</parents>
<position x1="10.6879732020567" y1="-5.05339955051418" 
x2="8.68797320205673" y2="-5.05339955051418">
</position>
</Vector>
<Vector id="2352" name="v7">
<appearance color="$000000FF" line_width="5" shape="0" 
brush_style="2" groups="2">
</appearance>
<parents>
2121;1085
</parents>
<position x1="10.6879732020567" y1="-6.74659076769503" 
x2="8.68797320205673" y2="-6.74659076769503">
</position>
</Vector>
<Vector id="2353" name="v8">
<appearance color="$000000FF" line_width="5" shape="0" 
brush_style="2" groups="2">
</appearance>
<parents>
2210;1026
</parents>
<position x1="10.6879732020567" y1="-8.43978198487588" 
x2="8.68797320205673" y2="-8.43978198487588">
</position>
</Vector>
<Vector id="2354" name="v9">
<appearance color="$000000FF" line_width="5" shape="0" 
brush_style="0" groups="2">
</appearance>
<parents>
2300;996
</parents>
<position x1="10.6879732020567" y1="-10.1329732020567" 
x2="8.68797320205673" y2="-10.1329732020567">
</position>
</Vector>
<Circle id="2355" name="k4">
<appearance shape="0" brush_style="0">
</appearance>
<parents>
6;124
</parents>
<position x1="-1.08479166666667" y1="-3.36020833333333" 
x2="4.18797320205673" y2="-3.36020833333333">
</position>
<radius>
5.2727648687234
</radius>
</Circle>
<Line id="2356" name="g13">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
50;49
</parents>
<position x1="-1.08479166666666" y1="3.41255653539007" 
x2="-1.08479166666667" y2="-10.1329732020567">
</position>
</Line>
<Perpendicular id="2359" name="g14">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
878;2356
</parents>
<position x1="-14.6303214041135" y1="1.91255653539007" 
x2="-1.08479166666667" y2="1.91255653539007">
</position>
</Perpendicular>
<Perpendicular id="2360" name="g15">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
46;2356
</parents>
<position x1="-14.6303214041135" y1="-8.63297320205673" 
x2="-1.08479166666667" y2="-8.63297320205673">
</position>
</Perpendicular>
<Area id="2358" name="F_1">
<appearance color="$00808080" pen_style="5" brush_style="0" 
groups="2">
</appearance>
<parents>
2356
</parents>
<orientation>
false
</orientation>
<operators>
</operators>
</Area>
<Area id="2364" name="F_2">
<appearance color="$00FFFFFF" pen_style="5" brush_style="0">
</appearance>
<parents>
2359
</parents>
<orientation>
true
</orientation>
<operators>
</operators>
</Area>
<Area id="2366" name="F_3">
<appearance color="$00FFFFFF" pen_style="5" brush_style="0">
</appearance>
<parents>
2360
</parents>
<orientation>
false
</orientation>
<operators>
</operators>
</Area>
<Segment id="2367" name="s26">
<appearance pen_style="2" shape="0" brush_style="0">
</appearance>
<parents>
124;6
</parents>
<position x1="4.18797320205673" y1="-3.36020833333333" 
x2="-1.08479166666667" y2="-3.36020833333333">
</position>
</Segment>
<CircleWDR id="2371" name="k5">
<appearance shape="0" brush_style="0" visible="false">
</appearance>
<parents>
6;10
</parents>
<position x1="-1.08479166666667" y1="-3.36020833333333" 
x2="2.19758163966229" y2="-3.36020833333333">
</position>
<radius>
<![CDATA[( d(N;P2) - 1.5 )*cos(51.5)]]>
</radius>
</CircleWDR>
<DoubleIntersection id="2375" name="DI_27">
<appearance visible="false">
</appearance>
<parents>
2367;2371
</parents>
<pointlist>
2.19758163966229;-3.36020833333333 
-4.36716497299562;-3.36020833333333
</pointlist>
</DoubleIntersection>
<IntersectPoint id="2376" name="Greenwich" plist_index="0">
<appearance shape="0" brush_style="0">
</appearance>
<parents>
2375
</parents>
<position x="2.19758163966229" y="-3.36020833333333">
</position>
</IntersectPoint>
<IntersectPoint id="2377" name="P100" plist_index="1">
<appearance shape="0" brush_style="0">
</appearance>
<parents>
2375
</parents>
<position x="2.10466951684193" y="-2.58476531093079" 
z="582">
</position>
</IntersectPoint>
<ObjectName id="2378" name="Name8">
<parents>
2376
</parents>
<position x="2.13020378948702" y="-3.55356802240254" 
width="5.74145833333333" height="1.93145833333333">
</position>
<text>
<![CDATA[Greenwich]]>
</text>
</ObjectName>
</objlist>
<grouplist>
<group id="0" comment="Winkelmesser" visible="true">
</group>
<group id="2" comment="Ort" visible="true">
</group>
<group id="1" comment="Beleuchtung" visible="true">
</group>
</grouplist>
</dg:drawing>
