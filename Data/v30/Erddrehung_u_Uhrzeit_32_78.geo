<?xml version="1.0" encoding="UTF-8"?>
<dg:drawing xmlns:dg="http://www.dynageo.com/xml/dg12" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.dynageo.com/xml/dg12 http://www.dynageo.com/xml/dg12.xsd">
	<header>
		<created prog_name="EUKLID DynaGeo" prog_version="3.0.1.21" date="2009-04-24T16:36:20">
		</created>
		<edited prog_name="EUKLID DynaGeo" prog_version="3.2.0.204" date="2009-04-30T14:59:54">
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
			<position x="-1.29645833333334" y="-3.96875">
			</position>
		</Point>
		<Point id="7" name="P2">
			<appearance brush_style="0">
			</appearance>
			<position x="-6.50875000000002" y="1.666875">
			</position>
		</Point>
		<Circle id="8" name="k1">
			<appearance shape="0" brush_style="0" groups="1">
			</appearance>
			<parents>
				6;7
			</parents>
			<position x1="-1.29645833333334" y1="-3.96875" x2="-6.50875000000002" y2="1.666875">
			</position>
			<radius>
				7.67647403167808
			</radius>
		</Circle>
		<ObjectName id="9" name="Name1">
			<parents>
				6
			</parents>
			<position x="-1.14645833333333" y="-3.96875" width="5.74145833333335" height="1.93145833333333">
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
			<line x1="-1.29645833333334" y1="-3.96875" x2="-6.50875000000002" y2="1.666875" dx="-27" dy="27">
			</line>
		</MeasureDistance>
		<PointWDC id="12" name="P1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				1;6;10
			</parents>
			<position x="6.38001569834474" y="-3.96875" x_term="x(N) + d(N;P2)" y_term="y(N)">
			</position>
		</PointWDC>
		<CircleWDR id="15" name="k2">
			<appearance color="$00008000" shape="0" brush_style="0" groups="1">
			</appearance>
			<parents>
				6;10
			</parents>
			<position x1="-1.29645833333334" y1="-3.96875" x2="4.88001569834474" y2="-3.96875">
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
			<position x1="-1.29645833333334" y1="-3.96875" x2="6.38001569834474" y2="-3.96875">
			</position>
		</Line>
		<LineWDD id="19" name="g2">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				12;6
			</parents>
			<position x1="-1.29645833333334" y1="-3.96875" x2="95.2961242955735" y2="21.9131545102521">
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
				-8.71136285536856;-5.95556767863322 
				6.11844618870189;-1.98193232136678
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="21" name="P3" plist_index="0">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				20
			</parents>
			<position x="-8.71136285536856" y="-5.95556767863322">
			</position>
		</IntersectPoint>
		<IntersectPoint id="22" name="P4" plist_index="1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				20
			</parents>
			<position x="6.11844618870189" y="-1.98193232136678">
			</position>
		</IntersectPoint>
		<LineWDD id="24" name="g3">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				22;6
			</parents>
			<position x1="-1.29645833333334" y1="-3.96875" x2="85.3060820451105" y2="46.03125">
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
				-7.9444798562581;-7.80698701583904 
				5.35156318959143;-0.13051298416096
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="26" name="P5" plist_index="0">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				25
			</parents>
			<position x="-7.9444798562581" y="-7.80698701583904">
			</position>
		</IntersectPoint>
		<IntersectPoint id="27" name="P6" plist_index="1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				25
			</parents>
			<position x="5.35156318959143" y="-0.13051298416096">
			</position>
		</IntersectPoint>
		<LineWDD id="29" name="g4">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				27;6
			</parents>
			<position x1="-1.29645833333334" y1="-3.96875" x2="69.4142197853214" y2="66.7419281186548">
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
				-6.72454517673534;-9.396836843402 
				4.13162851006867;1.45933684340201
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="31" name="P7" plist_index="0">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				30
			</parents>
			<position x="-6.72454517673534" y="-9.396836843402">
			</position>
		</IntersectPoint>
		<IntersectPoint id="32" name="P8" plist_index="1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				30
			</parents>
			<position x="4.13162851006867" y="1.45933684340201">
			</position>
		</IntersectPoint>
		<LineWDD id="34" name="g5">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				32;6
			</parents>
			<position x1="-1.29645833333334" y1="-3.96875" x2="48.7035416666667" y2="82.6337903784439">
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
				-5.13469534917238;-10.6167715229248 
				2.5417786825057;2.67927152292477
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="36" name="P9" plist_index="0">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				35
			</parents>
			<position x="-5.13469534917238" y="-10.6167715229248">
			</position>
		</IntersectPoint>
		<IntersectPoint id="37" name="P10" plist_index="1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				35
			</parents>
			<position x="2.5417786825057" y="2.67927152292477">
			</position>
		</IntersectPoint>
		<LineWDD id="39" name="g6">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				37;6
			</parents>
			<position x1="-1.29645833333334" y1="-3.96875" x2="24.5854461769188" y2="92.6238326289068">
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
				-3.28327601196656;-11.3836545220352 
				0.690359345299883;3.44615452203522
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="41" name="P11" plist_index="0">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				40
			</parents>
			<position x="-3.28327601196656" y="-11.3836545220352">
			</position>
		</IntersectPoint>
		<IntersectPoint id="42" name="P12" plist_index="1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				40
			</parents>
			<position x="0.690359345299883" y="3.44615452203522">
			</position>
		</IntersectPoint>
		<LineWDD id="44" name="g7">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				42;6
			</parents>
			<position x1="-1.29645833333334" y1="-3.96875" x2="-1.29645833333331" y2="96.03125">
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
				-1.29645833333334;-10.1452240316781 
				-1.29645833333333;2.20772403167808
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="46" name="P13" plist_index="0">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				45
			</parents>
			<position x="-1.29645833333334" y="-10.1452240316781">
			</position>
		</IntersectPoint>
		<DoubleIntersection id="48" name="DI_7">
			<appearance visible="false">
			</appearance>
			<parents>
				44;8
			</parents>
			<pointlist>
				-1.29645833333334;-11.6452240316781 
				-1.29645833333333;3.70772403167808
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="49" name="U" plist_index="0">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				48
			</parents>
			<position x="-1.29645833333334" y="-11.6452240316781">
			</position>
		</IntersectPoint>
		<IntersectPoint id="50" name="b" plist_index="1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				48
			</parents>
			<position x="-1.29645833333333" y="3.70772403167808">
			</position>
		</IntersectPoint>
		<LineWDD id="52" name="g8">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				50;6
			</parents>
			<position x1="-1.29645833333334" y1="-3.96875" x2="-27.1783628435854" y2="92.6238326289068">
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
				0.69035934529988;-11.3836545220352 
				-3.28327601196655;3.44615452203522
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="54" name="P16" plist_index="0">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				53
			</parents>
			<position x="0.69035934529988" y="-11.3836545220352">
			</position>
		</IntersectPoint>
		<IntersectPoint id="55" name="P17" plist_index="1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				53
			</parents>
			<position x="-3.28327601196655" y="3.44615452203522">
			</position>
		</IntersectPoint>
		<LineWDD id="57" name="g9">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				55;6
			</parents>
			<position x1="-1.29645833333334" y1="-3.96875" x2="-51.2964583333333" y2="82.6337903784439">
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
				2.5417786825057;-10.6167715229248 
				-5.13469534917238;2.67927152292477
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="59" name="P18" plist_index="0">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				58
			</parents>
			<position x="2.5417786825057" y="-10.6167715229248">
			</position>
		</IntersectPoint>
		<IntersectPoint id="60" name="P19" plist_index="1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				58
			</parents>
			<position x="-5.13469534917238" y="2.67927152292477">
			</position>
		</IntersectPoint>
		<LineWDD id="62" name="Zeit">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				60;6
			</parents>
			<position x1="-1.29645833333334" y1="-3.96875" x2="-72.0071364519881" y2="66.7419281186548">
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
				4.13162851006867;-9.396836843402 
				-6.72454517673534;1.45933684340201
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="64" name="P20" plist_index="0">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				63
			</parents>
			<position x="4.13162851006867" y="-9.396836843402">
			</position>
		</IntersectPoint>
		<IntersectPoint id="65" name="P21" plist_index="1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				63
			</parents>
			<position x="-6.72454517673534" y="1.45933684340201">
			</position>
		</IntersectPoint>
		<LineWDD id="68" name="g11">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				65;6
			</parents>
			<position x1="-1.29645833333334" y1="-3.96875" x2="-87.8989987117772" y2="46.03125">
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
				5.35156318959143;-7.80698701583904 
				-7.9444798562581;-0.130512984160961
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="70" name="P22" plist_index="0">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				69
			</parents>
			<position x="5.35156318959143" y="-7.80698701583904">
			</position>
		</IntersectPoint>
		<IntersectPoint id="71" name="P23" plist_index="1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				69
			</parents>
			<position x="-7.9444798562581" y="-0.130512984160961">
			</position>
		</IntersectPoint>
		<LineWDD id="73" name="g12">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				71;6
			</parents>
			<position x1="-1.29645833333334" y1="-3.96875" x2="-97.8890409622402" y2="21.9131545102521">
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
				6.11844618870189;-5.95556767863322 
				-8.71136285536856;-1.98193232136678
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="75" name="P24" plist_index="0">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				74
			</parents>
			<position x="6.11844618870189" y="-5.95556767863322">
			</position>
		</IntersectPoint>
		<IntersectPoint id="76" name="P25" plist_index="1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				74
			</parents>
			<position x="-8.71136285536856" y="-1.98193232136678">
			</position>
		</IntersectPoint>
		<DoubleIntersection id="77" name="DI_13">
			<appearance visible="false">
			</appearance>
			<parents>
				19;15
			</parents>
			<pointlist>
				-7.26247411593496;-5.56733911097944 
				4.66955744926828;-2.37016088902056
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="78" name="P26" plist_index="0">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				77
			</parents>
			<position x="-7.26247411593496" y="-5.56733911097944">
			</position>
		</IntersectPoint>
		<IntersectPoint id="79" name="P27" plist_index="1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				77
			</parents>
			<position x="4.66955744926828" y="-2.37016088902056">
			</position>
		</IntersectPoint>
		<DoubleIntersection id="80" name="DI_14">
			<appearance visible="false">
			</appearance>
			<parents>
				24;15
			</parents>
			<pointlist>
				-6.64544175058144;-7.05698701583904 
				4.05252508391477;-0.88051298416096
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="81" name="P28" plist_index="0">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				80
			</parents>
			<position x="-6.64544175058144" y="-7.05698701583904">
			</position>
		</IntersectPoint>
		<IntersectPoint id="82" name="P29" plist_index="1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				80
			</parents>
			<position x="4.05252508391477" y="-0.88051298416096">
			</position>
		</IntersectPoint>
		<DoubleIntersection id="83" name="DI_15">
			<appearance visible="false">
			</appearance>
			<parents>
				29;15
			</parents>
			<pointlist>
				-5.66388500495552;-8.33617667162218 
				3.07096833828885;0.398676671622185
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="84" name="P30" plist_index="0">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				83
			</parents>
			<position x="-5.66388500495552" y="-8.33617667162218">
			</position>
		</IntersectPoint>
		<IntersectPoint id="85" name="P31" plist_index="1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				83
			</parents>
			<position x="3.07096833828885" y="0.398676671622185">
			</position>
		</IntersectPoint>
		<DoubleIntersection id="86" name="DI_16">
			<appearance visible="false">
			</appearance>
			<parents>
				34;15
			</parents>
			<pointlist>
				-4.38469534917238;-9.31773341724811 
				1.7917786825057;1.38023341724811
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="87" name="P32" plist_index="0">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				86
			</parents>
			<position x="-4.38469534917238" y="-9.31773341724811">
			</position>
		</IntersectPoint>
		<IntersectPoint id="88" name="P33" plist_index="1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				86
			</parents>
			<position x="1.7917786825057" y="1.38023341724811">
			</position>
		</IntersectPoint>
		<DoubleIntersection id="89" name="DI_17">
			<appearance visible="false">
			</appearance>
			<parents>
				39;15
			</parents>
			<pointlist>
				-2.89504744431277;-9.93476578260162 
				0.302130777646102;1.99726578260162
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="90" name="P34" plist_index="0">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				89
			</parents>
			<position x="-2.89504744431277" y="-9.93476578260162">
			</position>
		</IntersectPoint>
		<IntersectPoint id="91" name="P35" plist_index="1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				89
			</parents>
			<position x="0.302130777646102" y="1.99726578260162">
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
			<position x="0" y="0" z="3">
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
		<IntersectPoint id="100" name="P40" plist_index="1">
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
