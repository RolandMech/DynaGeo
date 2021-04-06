<?xml version="1.0" encoding="UTF-8"?>
<dg:drawing xmlns:dg="http://www.dynageo.com/xml/dg12" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.dynageo.com/xml/dg12 http://www.dynageo.com/xml/dg12.xsd">
	<header>
		<created prog_name="EUKLID DynaGeo" prog_version="3.0.1.21" date="2009-04-24T16:36:20">
		</created>
		<edited prog_name="EUKLID DynaGeo" prog_version="3.2.0.205" date="2009-04-30T15:02:26">
		</edited>
	</header>
	<windowdata>
		<log_window xmin="-10.0541666666667" xmax="16.1660416666667" ymin="-12.8852083333333" ymax="5.635625">
		</log_window>
		<scr_window width="991" height="700">
		</scr_window>
		<startfont fontname="Arial" fontsize="12" fontcharset="0">
		</startfont>
		<options LengthDecimals="2" AreaDecimals="5" DefLocLineStatus="3">
		</options>
	</windowdata>
	<objlist>
		<Origin id="1" name="O" cosys_type="0">
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
			<position x1="-1.08479166666667" y1="-3.36020833333333" x2="-6.21770833333333" y2="1.05833333333333">
			</position>
			<radius>
				6.77276486872339
			</radius>
		</Circle>
		<ObjectName id="9" name="Name1">
			<parents>
				6
			</parents>
			<position x="-0.934791666666667" y="-3.36020833333333" width="5.74145833333335" height="1.93145833333333">
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
			<line x1="-1.08479166666667" y1="-3.36020833333333" x2="-6.21770833333333" y2="1.05833333333333" dx="-27" dy="27">
			</line>
		</MeasureDistance>
		<PointWDC id="12" name="P1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				1;6;10
			</parents>
			<position x="5.68797320205672" y="-3.36020833333333" x_term="x(N) + d(N;P2)" y_term="y(N)">
			</position>
		</PointWDC>
		<CircleWDR id="15" name="k2">
			<appearance color="$00008000" shape="0" brush_style="0" groups="1">
			</appearance>
			<parents>
				6;10
			</parents>
			<position x1="-1.08479166666667" y1="-3.36020833333333" x2="4.18797320205672" y2="-3.36020833333333">
			</position>
			<radius r_term="d(N;P2) - 1.5">
			</radius>
		</CircleWDR>
		<Line id="17" name="g1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				6;12
			</parents>
			<position x1="-1.08479166666667" y1="-3.36020833333333" x2="5.68797320205672" y2="-3.36020833333333">
			</position>
		</Line>
		<LineWDD id="19" name="g2">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				12;6
			</parents>
			<position x1="-1.08479166666667" y1="-3.36020833333333" x2="95.5077909622402" y2="22.5216961769187">
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
				-7.62678016874988;-5.11312886936022 
				5.45719683541654;-1.60728779730644
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="21" name="P3" plist_index="0">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				20
			</parents>
			<position x="-7.62678016874988" y="-5.11312886936022">
			</position>
		</IntersectPoint>
		<IntersectPoint id="22" name="P4" plist_index="1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				20
			</parents>
			<position x="5.45719683541654" y="-1.60728779730644">
			</position>
		</IntersectPoint>
		<LineWDD id="24" name="g3">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				22;6
			</parents>
			<position x1="-1.08479166666667" y1="-3.36020833333333" x2="85.5177487117772" y2="46.6397916666667">
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
				-6.9501780968399;-6.74659076769502 
				4.78059476350656;0.0261741010283642
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="26" name="P5" plist_index="0">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				25
			</parents>
			<position x="-6.9501780968399" y="-6.74659076769502">
			</position>
		</IntersectPoint>
		<IntersectPoint id="27" name="P6" plist_index="1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				25
			</parents>
			<position x="4.78059476350656" y="0.0261741010283642">
			</position>
		</IntersectPoint>
		<LineWDD id="29" name="g4">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				27;6
			</parents>
			<position x1="-1.08479166666667" y1="-3.36020833333333" x2="69.6258864519881" y2="67.3504697853214">
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
				-5.873859632723;-8.14927629938966 
				3.70427629938966;1.428859632723
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="31" name="P7" plist_index="0">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				30
			</parents>
			<position x="-5.873859632723" y="-8.14927629938966">
			</position>
		</IntersectPoint>
		<IntersectPoint id="32" name="P8" plist_index="1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				30
			</parents>
			<position x="3.70427629938966" y="1.428859632723">
			</position>
		</IntersectPoint>
		<LineWDD id="34" name="g5">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				32;6
			</parents>
			<position x1="-1.08479166666667" y1="-3.36020833333333" x2="48.9152083333333" y2="83.2423320451105">
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
				-4.47117410102837;-9.22559476350656 
				2.30159076769502;2.5051780968399
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="36" name="P9" plist_index="0">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				35
			</parents>
			<position x="-4.47117410102837" y="-9.22559476350656">
			</position>
		</IntersectPoint>
		<IntersectPoint id="37" name="P10" plist_index="1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				35
			</parents>
			<position x="2.30159076769502" y="2.5051780968399">
			</position>
		</IntersectPoint>
		<LineWDD id="39" name="g6">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				37;6
			</parents>
			<position x1="-1.08479166666667" y1="-3.36020833333333" x2="24.7971128435854" y2="93.2323742955735">
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
				-2.83771220269356;-9.90219683541654 
				0.668128869360218;3.18178016874988
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="41" name="P11" plist_index="0">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				40
			</parents>
			<position x="-2.83771220269356" y="-9.90219683541654">
			</position>
		</IntersectPoint>
		<IntersectPoint id="42" name="P12" plist_index="1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				40
			</parents>
			<position x="0.668128869360218" y="3.18178016874988">
			</position>
		</IntersectPoint>
		<LineWDD id="44" name="g7">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				42;6
			</parents>
			<position x1="-1.08479166666667" y1="-3.36020833333333" x2="-1.08479166666664" y2="96.6397916666667">
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
				-1.08479166666667;-8.63297320205672 
				-1.08479166666667;1.91255653539006
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="46" name="P13" plist_index="0">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				45
			</parents>
			<position x="-1.08479166666667" y="-8.63297320205672">
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
				-1.08479166666667;3.41255653539006
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
			<position x="-1.08479166666667" y="3.41255653539006">
			</position>
		</IntersectPoint>
		<LineWDD id="52" name="g8">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				50;6
			</parents>
			<position x1="-1.08479166666667" y1="-3.36020833333333" x2="-26.9666961769187" y2="93.2323742955735">
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
				0.668128869360216;-9.90219683541654 
				-2.83771220269356;3.18178016874988
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="54" name="P16" plist_index="0">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				53
			</parents>
			<position x="0.668128869360216" y="-9.90219683541654">
			</position>
		</IntersectPoint>
		<IntersectPoint id="55" name="P17" plist_index="1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				53
			</parents>
			<position x="-2.83771220269356" y="3.18178016874988">
			</position>
		</IntersectPoint>
		<LineWDD id="57" name="g9">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				55;6
			</parents>
			<position x1="-1.08479166666667" y1="-3.36020833333333" x2="-51.0847916666667" y2="83.2423320451105">
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
				2.30159076769502;-9.22559476350657 
				-4.47117410102836;2.5051780968399
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="59" name="P18" plist_index="0">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				58
			</parents>
			<position x="2.30159076769502" y="-9.22559476350657">
			</position>
		</IntersectPoint>
		<IntersectPoint id="60" name="P19" plist_index="1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				58
			</parents>
			<position x="-4.47117410102836" y="2.5051780968399">
			</position>
		</IntersectPoint>
		<LineWDD id="62" name="Zeit">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				60;6
			</parents>
			<position x1="-1.08479166666667" y1="-3.36020833333333" x2="-71.7954697853214" y2="67.3504697853214">
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
				3.70427629938966;-8.14927629938966 
				-5.873859632723;1.428859632723
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="64" name="P20" plist_index="0">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				63
			</parents>
			<position x="3.70427629938966" y="-8.14927629938966">
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
			<position x1="-1.08479166666667" y1="-3.36020833333333" x2="-87.6873320451105" y2="46.6397916666667">
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
				4.78059476350656;-6.74659076769502 
				-6.9501780968399;0.0261741010283642
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="70" name="P22" plist_index="0">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				69
			</parents>
			<position x="4.78059476350656" y="-6.74659076769502">
			</position>
		</IntersectPoint>
		<IntersectPoint id="71" name="P23" plist_index="1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				69
			</parents>
			<position x="-6.9501780968399" y="0.0261741010283642">
			</position>
		</IntersectPoint>
		<LineWDD id="73" name="g12">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				71;6
			</parents>
			<position x1="-1.08479166666667" y1="-3.36020833333333" x2="-97.6773742955735" y2="22.5216961769187">
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
				5.45719683541654;-5.11312886936022 
				-7.62678016874988;-1.60728779730644
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="75" name="P24" plist_index="0">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				74
			</parents>
			<position x="5.45719683541654" y="-5.11312886936022">
			</position>
		</IntersectPoint>
		<IntersectPoint id="76" name="P25" plist_index="1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				74
			</parents>
			<position x="-7.62678016874988" y="-1.60728779730644">
			</position>
		</IntersectPoint>
		<DoubleIntersection id="77" name="DI_13">
			<appearance visible="false">
			</appearance>
			<parents>
				19;15
			</parents>
			<pointlist>
				-6.17789142931628;-4.72490030170644 
				4.00830809598294;-1.99551636496022
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="78" name="P26" plist_index="0">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				77
			</parents>
			<position x="-6.17789142931628" y="-4.72490030170644">
			</position>
		</IntersectPoint>
		<IntersectPoint id="79" name="P27" plist_index="1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				77
			</parents>
			<position x="4.00830809598294" y="-1.99551636496022">
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
				3.48155665782991;-0.723825898971635
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
			<position x="3.48155665782991" y="-0.723825898971635">
			</position>
		</IntersectPoint>
		<DoubleIntersection id="83" name="DI_15">
			<appearance visible="false">
			</appearance>
			<parents>
				29;15
			</parents>
			<pointlist>
				-4.81319946094318;-7.08861612760983 
				2.64361612760983;0.368199460943175
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="84" name="P30" plist_index="0">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				83
			</parents>
			<position x="-4.81319946094318" y="-7.08861612760983">
			</position>
		</IntersectPoint>
		<IntersectPoint id="85" name="P31" plist_index="1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				83
			</parents>
			<position x="2.64361612760983" y="0.368199460943175">
			</position>
		</IntersectPoint>
		<DoubleIntersection id="86" name="DI_16">
			<appearance visible="false">
			</appearance>
			<parents>
				34;15
			</parents>
			<pointlist>
				-3.72117410102837;-7.92655665782991 
				1.55159076769503;1.20613999116325
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="87" name="P32" plist_index="0">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				86
			</parents>
			<position x="-3.72117410102837" y="-7.92655665782991">
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
				-2.44948363503978;-8.45330809598294 
				0.279900301706437;1.73289142931628
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="90" name="P34" plist_index="0">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				89
			</parents>
			<position x="-2.44948363503978" y="-8.45330809598294">
			</position>
		</IntersectPoint>
		<IntersectPoint id="91" name="P35" plist_index="1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				89
			</parents>
			<position x="0.279900301706437" y="1.73289142931628">
			</position>
		</IntersectPoint>
		<IntersectPoint id="93" name="P36" plist_index="0">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				93
			</parents>
			<position x="0" y="0" z="4">
			</position>
		</IntersectPoint>
		<IntersectPoint id="94" name="P37" plist_index="1">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				93
			</parents>
			<position x="0" y="0" z="4">
			</position>
		</IntersectPoint>
		<IntersectPoint id="96" name="P38" plist_index="0">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				96
			</parents>
			<position x="0" y="0" z="4">
			</position>
		</IntersectPoint>
		<IntersectPoint id="99" name="P39" plist_index="0">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				99
			</parents>
			<position x="0" y="0" z="3">
			</position>
		</IntersectPoint>
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
