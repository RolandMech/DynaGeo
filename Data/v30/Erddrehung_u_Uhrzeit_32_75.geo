<?xml version="1.0" encoding="UTF-8"?>
<dg:drawing xmlns:dg="http://www.dynageo.com/xml/dg12" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.dynageo.com/xml/dg12 http://www.dynageo.com/xml/dg12.xsd">
	<header>
		<created prog_name="EUKLID DynaGeo" prog_version="3.0.1.21" date="2009-04-24T16:36:20">
		</created>
		<edited prog_name="EUKLID DynaGeo" prog_version="3.2.0.205" date="2009-04-30T15:05:12">
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
			<position x="-5.63562500000001" y="0.47625">
			</position>
		</Point>
		<Circle id="8" name="k1">
			<appearance shape="0" brush_style="0" groups="1">
			</appearance>
			<parents>
				6;7
			</parents>
			<position x1="-1.08479166666667" y1="-3.36020833333333" x2="-5.63562500000001" y2="0.47625">
			</position>
			<radius>
				5.95218418491738
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
			<line x1="-1.08479166666667" y1="-3.36020833333333" x2="-5.63562500000001" y2="0.47625" dx="-27" dy="27">
			</line>
		</MeasureDistance>
		<PointWDC id="12" name="P1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				1;6;10
			</parents>
			<position x="4.86739251825071" y="-3.36020833333333" x_term="x(N) + d(N;P2)" y_term="y(N)">
			</position>
		</PointWDC>
		<CircleWDR id="15" name="k2">
			<appearance color="$00008000" shape="0" brush_style="0" groups="1">
			</appearance>
			<parents>
				6;10
			</parents>
			<position x1="-1.08479166666667" y1="-3.36020833333333" x2="3.36739251825071" y2="-3.36020833333333">
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
			<position x1="-1.08479166666667" y1="-3.36020833333333" x2="4.86739251825071" y2="-3.36020833333333">
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
				-6.83416009370772;-4.90074696034797 
				4.66457676037438;-1.81966970631869
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="21" name="P3" plist_index="0">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				20
			</parents>
			<position x="-6.83416009370772" y="-4.90074696034797">
			</position>
		</IntersectPoint>
		<IntersectPoint id="22" name="P4" plist_index="1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				20
			</parents>
			<position x="4.66457676037438" y="-1.81966970631869">
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
				-6.2395343788091;-6.33630042579202 
				4.06995104547576;-0.384116240874638
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="26" name="P5" plist_index="0">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				25
			</parents>
			<position x="-6.2395343788091" y="-6.33630042579202">
			</position>
		</IntersectPoint>
		<IntersectPoint id="27" name="P6" plist_index="1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				25
			</parents>
			<position x="4.06995104547576" y="-0.384116240874638">
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
				-5.29362146669308;-7.56903813335973 
				3.12403813335974;0.848621466693075
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="31" name="P7" plist_index="0">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				30
			</parents>
			<position x="-5.29362146669308" y="-7.56903813335973">
			</position>
		</IntersectPoint>
		<IntersectPoint id="32" name="P8" plist_index="1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				30
			</parents>
			<position x="3.12403813335974" y="0.848621466693075">
			</position>
		</IntersectPoint>
		<LineWDD id="34" name="g5">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				32;6
			</parents>
			<position x1="-1.08479166666667" y1="-3.36020833333333" x2="48.9152083333334" y2="83.2423320451105">
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
				-4.06088375912536;-8.51495104547576 
				1.89130042579202;1.7945343788091
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="36" name="P9" plist_index="0">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				35
			</parents>
			<position x="-4.06088375912536" y="-8.51495104547576">
			</position>
		</IntersectPoint>
		<IntersectPoint id="37" name="P10" plist_index="1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				35
			</parents>
			<position x="1.89130042579202" y="1.7945343788091">
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
				-2.62533029368132;-9.10957676037438 
				0.455746960347976;2.38916009370772
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="41" name="P11" plist_index="0">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				40
			</parents>
			<position x="-2.62533029368132" y="-9.10957676037438">
			</position>
		</IntersectPoint>
		<IntersectPoint id="42" name="P12" plist_index="1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				40
			</parents>
			<position x="0.455746960347976" y="2.38916009370772">
			</position>
		</IntersectPoint>
		<LineWDD id="44" name="g7">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				42;6
			</parents>
			<position x1="-1.08479166666667" y1="-3.36020833333333" x2="-1.08479166666662" y2="96.6397916666667">
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
				-1.08479166666667;-7.81239251825071 
				-1.08479166666667;1.09197585158405
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="46" name="P13" plist_index="0">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				45
			</parents>
			<position x="-1.08479166666667" y="-7.81239251825071">
			</position>
		</IntersectPoint>
		<DoubleIntersection id="48" name="DI_7">
			<appearance visible="false">
			</appearance>
			<parents>
				44;8
			</parents>
			<pointlist>
				-1.08479166666667;-9.31239251825071 
				-1.08479166666667;2.59197585158405
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="49" name="U" plist_index="0">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				48
			</parents>
			<position x="-1.08479166666667" y="-9.31239251825071">
			</position>
		</IntersectPoint>
		<IntersectPoint id="50" name="b" plist_index="1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				48
			</parents>
			<position x="-1.08479166666667" y="2.59197585158405">
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
				0.455746960347972;-9.10957676037438 
				-2.62533029368131;2.38916009370772
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="54" name="P16" plist_index="0">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				53
			</parents>
			<position x="0.455746960347972" y="-9.10957676037438">
			</position>
		</IntersectPoint>
		<IntersectPoint id="55" name="P17" plist_index="1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				53
			</parents>
			<position x="-2.62533029368131" y="2.38916009370772">
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
				1.89130042579202;-8.51495104547576 
				-4.06088375912536;1.7945343788091
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="59" name="P18" plist_index="0">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				58
			</parents>
			<position x="1.89130042579202" y="-8.51495104547576">
			</position>
		</IntersectPoint>
		<IntersectPoint id="60" name="P19" plist_index="1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				58
			</parents>
			<position x="-4.06088375912536" y="1.7945343788091">
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
				3.12403813335974;-7.56903813335974 
				-5.29362146669308;0.848621466693077
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="64" name="P20" plist_index="0">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				63
			</parents>
			<position x="3.12403813335974" y="-7.56903813335974">
			</position>
		</IntersectPoint>
		<IntersectPoint id="65" name="P21" plist_index="1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				63
			</parents>
			<position x="-5.29362146669308" y="0.848621466693077">
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
				4.06995104547576;-6.33630042579202 
				-6.2395343788091;-0.384116240874637
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="70" name="P22" plist_index="0">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				69
			</parents>
			<position x="4.06995104547576" y="-6.33630042579202">
			</position>
		</IntersectPoint>
		<IntersectPoint id="71" name="P23" plist_index="1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				69
			</parents>
			<position x="-6.2395343788091" y="-0.384116240874637">
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
				4.66457676037438;-4.90074696034797 
				-6.83416009370772;-1.81966970631869
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="75" name="P24" plist_index="0">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				74
			</parents>
			<position x="4.66457676037438" y="-4.90074696034797">
			</position>
		</IntersectPoint>
		<IntersectPoint id="76" name="P25" plist_index="1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				74
			</parents>
			<position x="-6.83416009370772" y="-1.81966970631869">
			</position>
		</IntersectPoint>
		<DoubleIntersection id="77" name="DI_13">
			<appearance visible="false">
			</appearance>
			<parents>
				19;15
			</parents>
			<pointlist>
				-5.38527135427412;-4.51251839269419 
				3.21568802094078;-2.20789827397247
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="78" name="P26" plist_index="0">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				77
			</parents>
			<position x="-5.38527135427412" y="-4.51251839269419">
			</position>
		</IntersectPoint>
		<IntersectPoint id="79" name="P27" plist_index="1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				77
			</parents>
			<position x="3.21568802094078" y="-2.20789827397247">
			</position>
		</IntersectPoint>
		<DoubleIntersection id="80" name="DI_14">
			<appearance visible="false">
			</appearance>
			<parents>
				24;15
			</parents>
			<pointlist>
				-4.94049627313244;-5.58630042579202 
				2.7709129397991;-1.13411624087464
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="81" name="P28" plist_index="0">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				80
			</parents>
			<position x="-4.94049627313244" y="-5.58630042579202">
			</position>
		</IntersectPoint>
		<IntersectPoint id="82" name="P29" plist_index="1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				80
			</parents>
			<position x="2.7709129397991" y="-1.13411624087464">
			</position>
		</IntersectPoint>
		<DoubleIntersection id="83" name="DI_15">
			<appearance visible="false">
			</appearance>
			<parents>
				29;15
			</parents>
			<pointlist>
				-4.23296129491326;-6.50837796157991 
				2.06337796157991;-0.212038705086746
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="84" name="P30" plist_index="0">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				83
			</parents>
			<position x="-4.23296129491326" y="-6.50837796157991">
			</position>
		</IntersectPoint>
		<IntersectPoint id="85" name="P31" plist_index="1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				83
			</parents>
			<position x="2.06337796157991" y="-0.212038705086746">
			</position>
		</IntersectPoint>
		<DoubleIntersection id="86" name="DI_16">
			<appearance visible="false">
			</appearance>
			<parents>
				34;15
			</parents>
			<pointlist>
				-3.31088375912536;-7.2159129397991 
				1.14130042579202;0.495496273132439
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="87" name="P32" plist_index="0">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				86
			</parents>
			<position x="-3.31088375912536" y="-7.2159129397991">
			</position>
		</IntersectPoint>
		<IntersectPoint id="88" name="P33" plist_index="1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				86
			</parents>
			<position x="1.14130042579202" y="0.495496273132439">
			</position>
		</IntersectPoint>
		<DoubleIntersection id="89" name="DI_17">
			<appearance visible="false">
			</appearance>
			<parents>
				39;15
			</parents>
			<pointlist>
				-2.23710172602753;-7.66068802094078 
				0.067518392694194;0.940271354274116
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="90" name="P34" plist_index="0">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				89
			</parents>
			<position x="-2.23710172602753" y="-7.66068802094078">
			</position>
		</IntersectPoint>
		<IntersectPoint id="91" name="P35" plist_index="1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				89
			</parents>
			<position x="0.067518392694194" y="0.940271354274116">
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
