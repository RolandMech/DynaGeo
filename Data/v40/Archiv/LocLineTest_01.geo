<?xml version="1.0" encoding="UTF-8"?>
<dg:drawing xmlns:dg="http://www.dynageo.com/xml/dg12" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.dynageo.com/xml/dg12 http://www.dynageo.com/xml/dg12.xsd">
	<header>
		<created prog_name="EUKLID DynaGeo" prog_version="3.0.5.6" date="2007-10-10T14:47:59">
		</created>
		<edited prog_name="EUKLID DynaGeo" prog_version="3.2.0.143" date="2008-10-30T19:23:06">
		</edited>
		<copyright sign_code="35363067">
			H.-J. Elschenbroich/ H.-W. Henn: Mathematik anders 
			machen. &#xD;
Beispiele Dynamisch Geometrie entdecken. 
			&#xD;
&#xD;
Nach: &#xD;
Henn: Der Regenbogen. mathematik 
			lehren 113 &#xD;
		</copyright>
	</header>
	<windowdata>
		<log_window xmin="-13.5466666666667" xmax="18.7060416666667" ymin="-8.73125" ymax="8.016875">
		</log_window>
		<scr_window width="1219" height="633">
		</scr_window>
		<startfont fontname="Arial" fontsize="13" fontcharset="0">
		</startfont>
		<options AreaDecimals="5" DefLocLineStatus="3">
		</options>
	</windowdata>
	<macrolist>
		<macro>
			<name>
				Brechnung neu
			</name>
			<helptext>
				AO: Gerade t, Punkt A auf t, Punkt B&#xD;ZO Punkt C 
				so, dass Strahl AB auf Strahl AC gebrochen wird.
			</helptext>
			<cmd_list>
				<cmd cmd_type="-1">
					<Point id="6" name="P1">
						<appearance brush_style="0">
						</appearance>
						<position x="-10.6891666666667" y="-0.529166666666667">
						</position>
					</Point>
				</cmd>
				<cmd cmd_type="-1">
					<Point id="7" name="P2">
						<appearance brush_style="0">
						</appearance>
						<position x="6.82625" y="-0.555625">
						</position>
					</Point>
				</cmd>
				<cmd cmd_type="0">
					<Line id="8" name="g1">
						<appearance shape="0" brush_style="0">
						</appearance>
						<parents>
							6;7
						</parents>
						<position x1="0" y1="0" x2="0" y2="0">
						</position>
					</Line>
				</cmd>
				<cmd cmd_type="0">
					<Point id="9" name="P3">
						<appearance brush_style="0">
						</appearance>
						<parents>
							8
						</parents>
						<position x="-2.69880819994143" y="-0.541236694562022">
						</position>
					</Point>
				</cmd>
				<cmd cmd_type="0">
					<Point id="10" name="P4">
						<appearance brush_style="0">
						</appearance>
						<position x="2.40770833333333" y="3.22791666666667">
						</position>
					</Point>
				</cmd>
				<cmd cmd_type="1">
					<Similiarity id="13" name="Abb1" map_type="2">
						<parents>
							9
						</parents>
					</Similiarity>
				</cmd>
				<cmd cmd_type="1">
					<MappedPoint id="14" name="P5">
						<appearance shape="0" brush_style="0">
						</appearance>
						<parents>
							10;13
						</parents>
						<position x="-7.8053247332162" y="-4.31039005579071">
						</position>
					</MappedPoint>
				</cmd>
				<cmd cmd_type="1">
					<Perpendicular id="12" name="g2">
						<appearance shape="0" brush_style="0">
						</appearance>
						<parents>
							9;8
						</parents>
						<position x1="0" y1="0" x2="0" y2="0">
						</position>
					</Perpendicular>
				</cmd>
				<cmd cmd_type="1">
					<Perpendicular id="16" name="g3">
						<appearance shape="0" brush_style="0">
						</appearance>
						<parents>
							14;12
						</parents>
						<position x1="0" y1="0" x2="0" y2="0">
						</position>
					</Perpendicular>
				</cmd>
				<cmd cmd_type="1">
					<PointLXL id="17" name="P6">
						<appearance shape="0" brush_style="0">
						</appearance>
						<parents>
							12;16
						</parents>
						<position x="-2.70451342428322" y="-4.31809520882535">
						</position>
					</PointLXL>
				</cmd>
				<cmd cmd_type="1">
					<MidPoint id="18" name="P7">
						<appearance shape="0" brush_style="0">
						</appearance>
						<parents>
							14;17
						</parents>
						<position x="-5.25491907874971" y="-4.31424263230803">
						</position>
					</MidPoint>
				</cmd>
				<cmd cmd_type="1">
					<MidPoint id="19" name="P8">
						<appearance shape="0" brush_style="0">
						</appearance>
						<parents>
							18;14
						</parents>
						<position x="-6.53012190598296" y="-4.31231634404937">
						</position>
					</MidPoint>
				</cmd>
				<cmd cmd_type="1">
					<Perpendicular id="20" name="g4">
						<appearance shape="0" brush_style="0">
						</appearance>
						<parents>
							19;8
						</parents>
						<position x1="0" y1="0" x2="0" y2="0">
						</position>
					</Perpendicular>
				</cmd>
				<cmd cmd_type="1">
					<Circle id="11" name="k1">
						<appearance shape="0" brush_style="0">
						</appearance>
						<parents>
							9;10
						</parents>
						<position x1="0" y1="0" x2="0" y2="0">
						</position>
						<radius>
							0
						</radius>
					</Circle>
				</cmd>
				<cmd cmd_type="1">
					<DoubleIntersection id="21" name="DI_1">
						<parents>
							20;11
						</parents>
						<pointlist>
							0;0 0;0
						</pointlist>
					</DoubleIntersection>
				</cmd>
				<cmd cmd_type="2">
					<IntersectPoint id="22" name="P9" plist_index="0">
						<appearance shape="0" brush_style="0">
						</appearance>
						<parents>
							21
						</parents>
						<position x="-6.53206675941714" y="-5.59980931747418">
						</position>
					</IntersectPoint>
				</cmd>
			</cmd_list>
		</macro>
		<macro>
			<name>
				Brechung neu neu
			</name>
			<helptext>
				AO: Gerade t, Punkt A auf t, Punkt B&#xD;ZO: Punkt C 
				so, dass AB in AC gebrochen wird.&#xD;
			</helptext>
			<cmd_list>
				<cmd cmd_type="0">
					<Point id="6" name="P1">
						<appearance shape="0" brush_style="0">
						</appearance>
						<position x="-5.318125" y="3.4925">
						</position>
					</Point>
				</cmd>
				<cmd cmd_type="-1">
					<Point id="7" name="P2">
						<appearance shape="0" brush_style="0">
						</appearance>
						<position x="1.190625" y="-0.661458333333333">
						</position>
					</Point>
				</cmd>
				<cmd cmd_type="0">
					<Line id="8" name="g1">
						<appearance shape="0" brush_style="0">
						</appearance>
						<parents>
							6;7
						</parents>
						<position x1="0" y1="0" x2="0" y2="0">
						</position>
					</Line>
				</cmd>
				<cmd cmd_type="0">
					<Point id="9" name="P3">
						<appearance shape="0" brush_style="0">
						</appearance>
						<position x="-10.6891666666667" y="3.36020833333333">
						</position>
					</Point>
				</cmd>
				<cmd cmd_type="1">
					<Perpendicular id="14" name="g2">
						<appearance shape="0" brush_style="0">
						</appearance>
						<parents>
							6;8
						</parents>
						<position x1="0" y1="0" x2="0" y2="0">
						</position>
					</Perpendicular>
				</cmd>
				<cmd cmd_type="1">
					<Similiarity id="11" name="Abb1" map_type="2">
						<parents>
							6
						</parents>
					</Similiarity>
				</cmd>
				<cmd cmd_type="1">
					<MappedPoint id="12" name="P4">
						<appearance shape="0" brush_style="0">
						</appearance>
						<parents>
							9;11
						</parents>
						<position x="0.0529166666666718" y="3.62479166666666">
						</position>
					</MappedPoint>
				</cmd>
				<cmd cmd_type="1">
					<ParallelLine id="16" name="g3">
						<appearance shape="0" brush_style="0">
						</appearance>
						<parents>
							12;8
						</parents>
						<position x1="0" y1="0" x2="0" y2="0">
						</position>
					</ParallelLine>
				</cmd>
				<cmd cmd_type="1">
					<PointLXL id="17" name="P5">
						<appearance shape="0" brush_style="0">
						</appearance>
						<parents>
							14;16
						</parents>
						<position x="-3.70360994344312" y="6.02224970645218">
						</position>
					</PointLXL>
				</cmd>
				<cmd cmd_type="1">
					<Segment id="18" name="s2">
						<appearance shape="0" brush_style="0">
						</appearance>
						<parents>
							17;12
						</parents>
						<position x1="0" y1="0" x2="0" y2="0">
						</position>
					</Segment>
				</cmd>
				<cmd cmd_type="1">
					<MeasureDistance id="15" name="d(P3;g2)">
						<appearance pen_style="2">
						</appearance>
						<parents>
							9;14
						</parents>
						<position x="0" y="0" width="0" height="0">
						</position>
						<text>
							<![CDATA[]]>
						</text>
						<line x1="0" y1="0" x2="0" y2="0" dx="0" dy="0">
						</line>
					</MeasureDistance>
				</cmd>
				<cmd cmd_type="1">
					<CircleWDR id="21" name="k2">
						<appearance shape="0" brush_style="0">
						</appearance>
						<parents>
							17;15
						</parents>
						<position x1="0" y1="0" x2="0" y2="0">
						</position>
						<radius>
							<![CDATA[d(%9;%14) / 1.33]]>
						</radius>
					</CircleWDR>
				</cmd>
				<cmd cmd_type="1">
					<DoubleIntersection id="23" name="DI_1">
						<parents>
							18;21
						</parents>
						<pointlist>
							0;0 0;0
						</pointlist>
					</DoubleIntersection>
				</cmd>
				<cmd cmd_type="1">
					<IntersectPoint id="25" name="P7" plist_index="1">
						<appearance shape="0" brush_style="0">
						</appearance>
						<parents>
							23
						</parents>
						<position x="-0.879153845616213" y="4.21964967653826">
						</position>
					</IntersectPoint>
				</cmd>
				<cmd cmd_type="1">
					<ParallelLine id="26" name="g4">
						<appearance shape="0" brush_style="0">
						</appearance>
						<parents>
							25;14
						</parents>
						<position x1="0" y1="0" x2="0" y2="0">
						</position>
					</ParallelLine>
				</cmd>
				<cmd cmd_type="1">
					<PointLXL id="27" name="P8">
						<appearance shape="0" brush_style="0">
						</appearance>
						<parents>
							8;26
						</parents>
						<position x="-2.49366890217309" y="1.68989997008608">
						</position>
					</PointLXL>
				</cmd>
				<cmd cmd_type="1">
					<Ray id="28" name="h1">
						<appearance shape="0" brush_style="0">
						</appearance>
						<parents>
							27;25
						</parents>
						<position x1="0" y1="0" x2="0" y2="0">
						</position>
					</Ray>
				</cmd>
				<cmd cmd_type="1">
					<Circle id="10" name="k1">
						<appearance shape="0" brush_style="0">
						</appearance>
						<parents>
							6;9
						</parents>
						<position x1="0" y1="0" x2="0" y2="0">
						</position>
						<radius>
							0
						</radius>
					</Circle>
				</cmd>
				<cmd cmd_type="1">
					<DoubleIntersection id="29" name="DI_2">
						<parents>
							28;10
						</parents>
						<pointlist>
							0;0 0;0
						</pointlist>
					</DoubleIntersection>
				</cmd>
				<cmd cmd_type="2">
					<IntersectPoint id="31" name="P10" plist_index="1">
						<appearance shape="0" brush_style="0">
						</appearance>
						<parents>
							29
						</parents>
						<position x="-0.234222719469155" y="5.23017870222091">
						</position>
					</IntersectPoint>
				</cmd>
			</cmd_list>
		</macro>
	</macrolist>
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
		<Point id="6" name="P1">
			<appearance brush_style="0">
			</appearance>
			<position x="-12.85875" y="7.9375">
			</position>
		</Point>
		<Point id="7" name="P2">
			<appearance brush_style="0">
			</appearance>
			<position x="11.4564583333333" y="7.9375">
			</position>
		</Point>
		<Line id="8" name="g1">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				6;7
			</parents>
			<position x1="-12.85875" y1="7.9375" x2="11.4564583333333" y2="7.9375">
			</position>
		</Line>
		<Point id="9" name="P3">
			<appearance brush_style="0">
			</appearance>
			<position x="-3.20145833333334" y="3.86291666666667">
			</position>
		</Point>
		<ParallelLine id="10" name="Achse">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				9;8
			</parents>
			<position x1="-3.20145833333334" y1="3.86291666666667" x2="21.11375" y2="3.86291666666667">
			</position>
		</ParallelLine>
		<Point id="11" name="M">
			<appearance brush_style="0">
			</appearance>
			<parents>
				10
			</parents>
			<position x="3.413125" y="3.86291666666667">
			</position>
		</Point>
		<CircleWDR id="13" name="Tröpfchen">
			<appearance color="$00FF0000" shape="0" brush_style="2">
			</appearance>
			<parents>
				11
			</parents>
			<position x1="3.413125" y1="3.86291666666667" x2="6.413125" y2="3.86291666666667">
			</position>
			<radius r_term="3">
			</radius>
		</CircleWDR>
		<CircleWDR id="14" name="k2">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				9
			</parents>
			<position x1="-3.20145833333334" y1="3.86291666666667" x2="-0.20145833333334" y2="3.86291666666667">
			</position>
			<radius r_term="3">
			</radius>
		</CircleWDR>
		<Perpendicular id="15" name="g3">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				9;10
			</parents>
			<position x1="-3.20145833333334" y1="-20.4522916666666" x2="-3.20145833333334" y2="3.86291666666667">
			</position>
		</Perpendicular>
		<DoubleIntersection id="16" name="DI_1">
			<appearance visible="false">
			</appearance>
			<parents>
				15;14
			</parents>
			<pointlist>
				-3.20145833333334;0.862916666666677 
				-3.20145833333334;6.86291666666666
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="17" name="P5" plist_index="0">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				16
			</parents>
			<position x="-3.20145833333334" y="0.862916666666677">
			</position>
		</IntersectPoint>
		<IntersectPoint id="18" name="P6" plist_index="1">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				16
			</parents>
			<position x="-3.20145833333334" y="6.86291666666666">
			</position>
		</IntersectPoint>
		<Segment id="19" name="s1">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				18;17
			</parents>
			<position x1="-3.20145833333334" y1="6.86291666666666" x2="-3.20145833333334" y2="0.862916666666677">
			</position>
		</Segment>
		<Point id="20" name="x">
			<appearance color="$0000FF00" shape="0" brush_style="0">
			</appearance>
			<parents>
				19
			</parents>
			<position x="-3.20145833333334" y="6.08541666666667">
			</position>
		</Point>
		<ParallelLine id="21" name="g4">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				20;10
			</parents>
			<position x1="-3.20145833333334" y1="6.08541666666667" x2="21.11375" y2="6.08541666666667">
			</position>
		</ParallelLine>
		<DoubleIntersection id="22" name="DI_2">
			<appearance visible="false">
			</appearance>
			<parents>
				21;13
			</parents>
			<pointlist>
				1.39805831375857;6.08541666666667 
				5.42819168624143;6.08541666666667
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="23" name="P8" plist_index="0">
			<appearance color="$000000FF" shape="0" brush_style="0">
			</appearance>
			<parents>
				22
			</parents>
			<position x="1.39805831375857" y="6.08541666666667">
			</position>
		</IntersectPoint>
		<IntersectPoint id="24" name="P9" plist_index="1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				22
			</parents>
			<position x="5.42819168624143" y="6.08541666666667">
			</position>
		</IntersectPoint>
		<Ray id="25" name="Strahl">
			<appearance color="$000000FF" shape="0" brush_style="2">
			</appearance>
			<parents>
				23;20
			</parents>
			<position x1="1.39805831375857" y1="6.08541666666667" x2="-3.20145833333334" y2="6.08541666666667">
			</position>
		</Ray>
		<Point id="26" name="0o">
			<appearance brush_style="0">
			</appearance>
			<position x="-11.668125" y="-7.09083333333333">
			</position>
		</Point>
		<ParallelLine id="27" name="g5">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				26;25
			</parents>
			<position x1="-11.668125" y1="-7.09083333333333" x2="-16.2676416470919" y2="-7.09083333333333">
			</position>
		</ParallelLine>
		<CircleWDR id="28" name="k3">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				26
			</parents>
			<position x1="-11.668125" y1="-7.09083333333333" x2="-5.668125" y2="-7.09083333333333">
			</position>
			<radius r_term="6">
			</radius>
		</CircleWDR>
		<Perpendicular id="29" name="g6">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				26;27
			</parents>
			<position x1="-11.668125" y1="-2.49131668624142" x2="-11.668125" y2="-7.09083333333333">
			</position>
		</Perpendicular>
		<DoubleIntersection id="30" name="DI_3">
			<appearance visible="false">
			</appearance>
			<parents>
				29;28
			</parents>
			<pointlist>
				-11.668125;-1.09083333333333 
				-11.668125;-13.0908333333333
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="31" name="360o" plist_index="0">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				30
			</parents>
			<position x="-11.668125" y="-1.09083333333333">
			</position>
		</IntersectPoint>
		<IntersectPoint id="32" name="P12" plist_index="1">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				30
			</parents>
			<position x="-11.668125" y="-13.0908333333333">
			</position>
		</IntersectPoint>
		<Segment id="33" name="s2">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				31;26
			</parents>
			<position x1="-11.668125" y1="-1.09083333333333" x2="-11.668125" y2="-7.09083333333333">
			</position>
		</Segment>
		<MidPoint id="34" name="180o">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				31;26
			</parents>
			<position x="-11.668125" y="-4.09083333333333">
			</position>
		</MidPoint>
		<MidPoint id="37" name="270o">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				34;31
			</parents>
			<position x="-11.668125" y="-2.59083333333333">
			</position>
		</MidPoint>
		<Point id="38" name="P15">
			<appearance brush_style="0">
			</appearance>
			<parents>
				27
			</parents>
			<position x="12.3825" y="-7.09083333333333">
			</position>
		</Point>
		<Segment id="39" name="Stossparameter">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				26;38
			</parents>
			<position x1="-11.668125" y1="-7.09083333333333" x2="12.3825" y2="-7.09083333333333">
			</position>
		</Segment>
		<MidPoint id="40" name="P16">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				26;38
			</parents>
			<position x="0.3571875" y="-7.09083333333333">
			</position>
		</MidPoint>
		<MeasureDistance id="41" name="d(x;P5)">
			<appearance pen_style="2" visible="false">
			</appearance>
			<parents>
				20;17
			</parents>
			<position x="0" y="0" width="0" height="0">
			</position>
			<text>
				<![CDATA[]]>
			</text>
			<line x1="-3.20145833333334" y1="6.08541666666667" x2="-3.20145833333334" y2="0.862916666666677" dx="61" dy="6">
			</line>
		</MeasureDistance>
		<MeasureDistance id="42" name="d(0o;P15)">
			<appearance pen_style="2" visible="false">
			</appearance>
			<parents>
				26;38
			</parents>
			<position x="0" y="0" width="0" height="0">
			</position>
			<text>
				<![CDATA[]]>
			</text>
			<line x1="-11.668125" y1="-7.09083333333333" x2="12.3825" y2="-7.09083333333333" dx="-60" dy="22">
			</line>
		</MeasureDistance>
		<CircleWDR id="45" name="k4">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				26;41;42
			</parents>
			<position x1="-11.668125" y1="-7.09083333333333" x2="19.7329722656249" y2="-7.09083333333333">
			</position>
			<radius r_term="d(x;P5)*d(0o;P15)/4">
			</radius>
		</CircleWDR>
		<DoubleIntersection id="50" name="DI_4">
			<appearance visible="false">
			</appearance>
			<parents>
				39;45
			</parents>
			<pointlist>
				-43.0692222656249;-7.09083333333333 
				19.7329722656249;-7.09083333333333
			</pointlist>
		</DoubleIntersection>
		<CircleWDR id="55" name="k5">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				26;41;42
			</parents>
			<position x1="-11.668125" y1="-7.09083333333333" x2="9.26593984374996" y2="-7.09083333333333">
			</position>
			<radius r_term="d(x;P5)*d(0o;P15)/6">
			</radius>
		</CircleWDR>
		<DoubleIntersection id="62" name="DI_5">
			<appearance visible="false">
			</appearance>
			<parents>
				39;55
			</parents>
			<pointlist>
				-32.60218984375;-7.09083333333333 
				9.26593984374996;-7.09083333333333
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="63" name="P17" plist_index="0">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				62
			</parents>
			<position x="-11.668125" y="-7.09083333333333" z="254">
			</position>
		</IntersectPoint>
		<IntersectPoint id="64" name="P18" plist_index="1">
			<appearance color="$00FF0000" shape="0" brush_style="0">
			</appearance>
			<parents>
				62
			</parents>
			<position x="9.26593984374996" y="-7.09083333333333">
			</position>
		</IntersectPoint>
		<ParallelLine id="65" name="g7">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				34;39
			</parents>
			<position x1="-11.668125" y1="-4.09083333333333" x2="12.3825" y2="-4.09083333333333">
			</position>
		</ParallelLine>
		<ParallelLine id="66" name="g8">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				37;39
			</parents>
			<position x1="-11.668125" y1="-2.59083333333333" x2="12.3825" y2="-2.59083333333333">
			</position>
		</ParallelLine>
		<Perpendicular id="67" name="g9">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				38;39
			</parents>
			<position x1="12.3825" y1="-31.1414583333333" x2="12.3825" y2="-7.09083333333333">
			</position>
		</Perpendicular>
		<PointLXL id="68" name="P19">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				67;66
			</parents>
			<position x="12.3825" y="-2.59083333333333">
			</position>
		</PointLXL>
		<PointLXL id="69" name="P20">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				67;65
			</parents>
			<position x="12.3825" y="-4.09083333333333">
			</position>
		</PointLXL>
		<Segment id="71" name="s4">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				37;34
			</parents>
			<position x1="-11.668125" y1="-2.59083333333333" x2="-11.668125" y2="-4.09083333333333">
			</position>
		</Segment>
		<Segment id="72" name="s5">
			<appearance color="$0000FFFF" shape="0" brush_style="2">
			</appearance>
			<parents>
				34;69
			</parents>
			<position x1="-11.668125" y1="-4.09083333333333" x2="12.3825" y2="-4.09083333333333">
			</position>
		</Segment>
		<Segment id="73" name="s6">
			<appearance color="$0000FFFF" shape="0" brush_style="2">
			</appearance>
			<parents>
				69;68
			</parents>
			<position x1="12.3825" y1="-4.09083333333333" x2="12.3825" y2="-2.59083333333333">
			</position>
		</Segment>
		<Segment id="74" name="s7">
			<appearance color="$0000FFFF" shape="0" brush_style="2">
			</appearance>
			<parents>
				68;37
			</parents>
			<position x1="12.3825" y1="-2.59083333333333" x2="-11.668125" y2="-2.59083333333333">
			</position>
		</Segment>
		<Polygon id="75" name="N1">
			<parents>
				37;34;69;68
			</parents>
			<position x1="0" y1="0" x2="0" y2="0">
			</position>
		</Polygon>
		<Area id="76" name="F_1">
			<appearance color="$0000FFFF" pen_style="5" brush_style="0">
			</appearance>
			<parents>
				75
			</parents>
			<orientation>
				true
			</orientation>
		</Area>
		<Area id="70" name="F_2">
			<appearance color="$0000FFFF" pen_style="5" brush_style="3" visible="false">
			</appearance>
			<parents>
				66
			</parents>
			<orientation>
				false
			</orientation>
		</Area>
		<Area id="79" name="F_3">
			<appearance color="$0000FFFF" pen_style="5" brush_style="0" visible="false">
			</appearance>
			<parents>
				13
			</parents>
			<orientation>
				true
			</orientation>
		</Area>
		<ObjectName id="84" name="Name1">
			<appearance color="$000000FF">
			</appearance>
			<parents>
				25
			</parents>
			<position x="-5.21002989365664" y="9.6043186711238" width="5.74145833333335" height="1.93145833333333">
			</position>
			<text>
				<![CDATA[Strahl]]>
			</text>
		</ObjectName>
		<ObjectName id="85" name="Name2">
			<appearance color="$00FF0000">
			</appearance>
			<parents>
				13
			</parents>
			<position x="5.71500000000001" y="6.35" width="5.74145833333335" height="1.93145833333333">
			</position>
			<text>
				<![CDATA[Tröpfchen]]>
			</text>
		</ObjectName>
		<ObjectName id="86" name="Name3">
			<parents>
				10
			</parents>
			<position x="8.04333333333335" y="3.86291666666667" width="5.74145833333335" height="1.93145833333333">
			</position>
			<text>
				<![CDATA[Achse]]>
			</text>
		</ObjectName>
		<ObjectName id="87" name="Name4">
			<appearance color="$00FF0000" shape="0" brush_style="2">
			</appearance>
			<parents>
				11
			</parents>
			<position x="3.563125" y="3.86291666666667" width="5.74145833333335" height="1.93145833333333">
			</position>
			<text>
				<![CDATA[M]]>
			</text>
		</ObjectName>
		<ObjectName id="88" name="Name5">
			<parents>
				31
			</parents>
			<position x="-12.779375" y="-0.873125" width="5.74145833333335" height="1.93145833333333">
			</position>
			<text>
				<![CDATA[360<sup>o</sup>]]>
			</text>
		</ObjectName>
		<ObjectName id="89" name="Name6">
			<parents>
				37
			</parents>
			<position x="-12.7529166666667" y="-2.38125" width="5.74145833333335" height="1.93145833333333">
			</position>
			<text>
				<![CDATA[270<sup>o</sup>]]>
			</text>
		</ObjectName>
		<ObjectName id="90" name="Name7">
			<parents>
				34
			</parents>
			<position x="-12.7264583333334" y="-3.86291666666667" width="5.74145833333335" height="1.93145833333333">
			</position>
			<text>
				<![CDATA[180<sup>o</sup>]]>
			</text>
		</ObjectName>
		<ObjectName id="91" name="Name8">
			<parents>
				26
			</parents>
			<position x="-12.22375" y="-6.77333333333333" width="5.74145833333335" height="1.93145833333333">
			</position>
			<text>
				<![CDATA[0<sup>o</sup>]]>
			</text>
		</ObjectName>
		<ObjectName id="92" name="Name9">
			<appearance visible="false">
			</appearance>
			<parents>
				39
			</parents>
			<position x="3.96875000000001" y="-7.24958333333333" width="5.74145833333335" height="1.93145833333333">
			</position>
			<text>
				<![CDATA[Stossparameter]]>
			</text>
		</ObjectName>
		<TextBox id="93" name="tb1">
			<parents>
				40
			</parents>
			<position x="0.264583333333334" y="-7.19666666666666" width="6.77333333333335" height="2.32833333333333">
			</position>
			<text>
				<![CDATA[0]]>
			</text>
		</TextBox>
		<TextBox id="95" name="tb2">
			<parents>
				26
			</parents>
			<position x="-11.7739583333334" y="-7.09083333333333" width="6.77333333333335" height="2.32833333333333">
			</position>
			<text>
				<![CDATA[-1]]>
			</text>
		</TextBox>
		<TextBox id="96" name="tb3">
			<parents>
				38
			</parents>
			<position x="12.2766666666667" y="-7.24958333333333" width="6.77333333333335" height="2.32833333333333">
			</position>
			<text>
				<![CDATA[1]]>
			</text>
		</TextBox>
		<TextBox id="97" name="tb4">
			<appearance shape="0" brush_style="2">
			</appearance>
			<parents>
				18
			</parents>
			<position x="-5.13291666666668" y="7.69937499999998" width="6.77333333333335" height="2.32833333333333">
			</position>
			<text>
				<![CDATA[Stoßparameter x<br>            1]]>
			</text>
		</TextBox>
		<TextBox id="98" name="tb5">
			<appearance shape="0" brush_style="2">
			</appearance>
			<parents>
				17
			</parents>
			<position x="-3.28083333333334" y="0.820208333333347" width="6.77333333333335" height="2.32833333333333">
			</position>
			<text>
				<![CDATA[-1]]>
			</text>
		</TextBox>
		<ObjectName id="99" name="Name10">
			<appearance color="$0000FF00" shape="0" brush_style="2">
			</appearance>
			<parents>
				20
			</parents>
			<position x="-2.88395833333334" y="6.0325" width="5.74145833333335" height="1.93145833333333">
			</position>
			<text>
				<![CDATA[x]]>
			</text>
		</ObjectName>
		<TextBox id="100" name="tb6">
			<parents>
				39
			</parents>
			<position x="2.96333333333334" y="-7.24958333333333" width="6.77333333333335" height="2.32833333333333">
			</position>
			<text>
				<![CDATA[Stoßparameter x]]>
			</text>
		</TextBox>
		<TextBox id="105" name="tb7">
			<parents>
				9
			</parents>
			<position x="-3.65125000000001" y="4.47145833333333" width="6.77333333333335" height="2.32833333333333">
			</position>
			<text>
				<![CDATA[0]]>
			</text>
		</TextBox>
		<Ray id="110" name="h1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				11;23
			</parents>
			<position x1="3.413125" y1="3.86291666666667" x2="1.39805831375857" y2="6.08541666666667">
			</position>
		</Ray>
		<Perpendicular id="111" name="g2">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				23;110
			</parents>
			<position x1="3.62055831375857" y1="8.10048335290809" x2="1.39805831375857" y2="6.08541666666667">
			</position>
		</Perpendicular>
		<Similiarity id="112" name="Abb1" map_type="2">
			<appearance visible="false">
			</appearance>
			<parents>
				23
			</parents>
		</Similiarity>
		<MappedPoint id="113" name="P4">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				20;112
			</parents>
			<position x="5.99757496085048" y="6.08541666666666">
			</position>
		</MappedPoint>
		<Perpendicular id="114" name="g10">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				23;111
			</parents>
			<position x1="-0.617008372482857" y1="8.30791666666666" x2="1.39805831375857" y2="6.08541666666667">
			</position>
		</Perpendicular>
		<Perpendicular id="115" name="g11">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				113;114
			</parents>
			<position x1="3.77507496085049" y1="4.07034998042524" x2="5.99757496085048" y2="6.08541666666666">
			</position>
		</Perpendicular>
		<PointLXL id="116" name="P7">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				114;115
			</parents>
			<position x="3.4732037135961" y="3.79665338025585">
			</position>
		</PointLXL>
		<MidPoint id="117" name="P10">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				113;116
			</parents>
			<position x="4.73538933722329" y="4.94103502346125">
			</position>
		</MidPoint>
		<MidPoint id="118" name="P11">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				117;113
			</parents>
			<position x="5.36648214903689" y="5.51322584506396">
			</position>
		</MidPoint>
		<Perpendicular id="119" name="g12">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				118;111
			</parents>
			<position x1="3.35141546279546" y1="7.73572584506396" x2="5.36648214903689" y2="5.51322584506396">
			</position>
		</Perpendicular>
		<Circle id="120" name="k1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				23;20
			</parents>
			<position x1="1.39805831375857" y1="6.08541666666667" x2="-3.20145833333334" y2="6.08541666666667">
			</position>
			<radius>
				4.59951664709191
			</radius>
		</Circle>
		<DoubleIntersection id="121" name="DI_6">
			<appearance visible="false">
			</appearance>
			<parents>
				119;120
			</parents>
			<pointlist>
				0.722670794904898;10.6350765535431 
				5.86000270349382;4.96890170940648
			</pointlist>
		</DoubleIntersection>
		<ParallelLine id="129" name="g13">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				113;111
			</parents>
			<position x1="5.99757496085048" y1="6.08541666666666" x2="3.77507496085049" y2="4.07034998042524">
			</position>
		</ParallelLine>
		<PointLXL id="130" name="P13">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				114;129
			</parents>
			<position x="3.4732037135961" y="3.79665338025585">
			</position>
		</PointLXL>
		<Segment id="131" name="s3">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				130;113
			</parents>
			<position x1="3.4732037135961" y1="3.79665338025585" x2="5.99757496085048" y2="6.08541666666666">
			</position>
		</Segment>
		<MeasureDistance id="132" name="d(x;g10)">
			<appearance pen_style="2" visible="false">
			</appearance>
			<parents>
				20;114
			</parents>
			<position x="0" y="0" width="0" height="0">
			</position>
			<text>
				<![CDATA[]]>
			</text>
			<line x1="-3.20145833333334" y1="6.08541666666667" x2="-0.677087086078954" y2="8.37417995307749" dx="0" dy="0">
			</line>
		</MeasureDistance>
		<CircleWDR id="133" name="k6">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				130;132
			</parents>
			<position x1="3.4732037135961" y1="3.79665338025585" x2="6.0352151793008" y2="3.79665338025585">
			</position>
			<radius r_term="d(x;g10)/1.33">
			</radius>
		</CircleWDR>
		<DoubleIntersection id="135" name="DI_7">
			<appearance visible="false">
			</appearance>
			<parents>
				131;133
			</parents>
			<pointlist>
				1.57518021941987;2.07577872881914 
				5.37122720777233;5.51752803169255
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="136" name="P14" plist_index="1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				135
			</parents>
			<position x="5.37122720777233" y="5.51752803169255">
			</position>
		</IntersectPoint>
		<ParallelLine id="137" name="g14">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				136;114
			</parents>
			<position x1="5.37122720777233" y1="5.51752803169255" x2="7.38629389401376" y2="3.29502803169256">
			</position>
		</ParallelLine>
		<PointLXL id="138" name="P21">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				111;137
			</parents>
			<position x="3.2960818079348" y="7.80629131810337">
			</position>
		</PointLXL>
		<Ray id="139" name="h2">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				138;136
			</parents>
			<position x1="3.2960818079348" y1="7.80629131810337" x2="5.37122720777233" y2="5.51752803169255">
			</position>
		</Ray>
		<DoubleIntersection id="141" name="DI_8">
			<appearance visible="false">
			</appearance>
			<parents>
				139;120
			</parents>
			<pointlist>
				0.730296110388824;10.6362019864358 
				5.86186750548078;4.97638064977093
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="142" name="P22" plist_index="1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				141
			</parents>
			<position x="5.86186750548078" y="4.97638064977093">
			</position>
		</IntersectPoint>
		<Ray id="143" name="h3">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				23;142
			</parents>
			<position x1="1.39805831375857" y1="6.08541666666667" x2="5.86186750548078" y2="4.97638064977093">
			</position>
		</Ray>
		<DoubleIntersection id="144" name="DI_9">
			<appearance visible="false">
			</appearance>
			<parents>
				143;13
			</parents>
			<pointlist>
				1.39805831375857;6.08541666666667 
				6.23404051634456;4.88391404650978
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="145" name="P23" plist_index="0">
			<appearance color="$000000FF" shape="0" brush_style="0">
			</appearance>
			<parents>
				144
			</parents>
			<position x="1.39805831375857" y="6.08541666666667">
			</position>
		</IntersectPoint>
		<IntersectPoint id="146" name="P24" plist_index="1">
			<appearance color="$000000FF" shape="0" brush_style="0">
			</appearance>
			<parents>
				144
			</parents>
			<position x="6.23404051634456" y="4.88391404650978">
			</position>
		</IntersectPoint>
		<Segment id="147" name="s8">
			<appearance color="$000000FF" shape="0" brush_style="2">
			</appearance>
			<parents>
				145;146
			</parents>
			<position x1="1.39805831375857" y1="6.08541666666667" x2="6.23404051634456" y2="4.88391404650978">
			</position>
		</Segment>
		<PerpBisector id="148" name="g15">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				145;146
			</parents>
			<position x1="3.81604941505157" y1="5.48466535658822" x2="5.01755203520846" y2="10.3206475591742">
			</position>
		</PerpBisector>
		<Similiarity id="149" name="Abb2" map_type="1">
			<appearance visible="false">
			</appearance>
			<parents>
				148
			</parents>
		</Similiarity>
		<MappedPoint id="150" name="P25">
			<appearance color="$000000FF" shape="0" brush_style="0">
			</appearance>
			<parents>
				20;149
			</parents>
			<position x="10.2987353631721" y="2.7312856092151">
			</position>
		</MappedPoint>
		<Segment id="151" name="s9">
			<appearance pen_style="2" shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				20;150
			</parents>
			<position x1="-3.20145833333334" y1="6.08541666666667" x2="10.2987353631721" y2="2.7312856092151">
			</position>
		</Segment>
		<Segment id="152" name="s10">
			<appearance color="$000000FF" shape="0" brush_style="2">
			</appearance>
			<parents>
				146;150
			</parents>
			<position x1="6.23404051634456" y1="4.88391404650978" x2="10.2987353631721" y2="2.7312856092151">
			</position>
		</Segment>
		<ParallelLine id="153" name="g16">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				146;10
			</parents>
			<position x1="6.23404051634456" y1="4.88391404650978" x2="30.5492488496779" y2="4.88391404650978">
			</position>
		</ParallelLine>
		<Point id="154" name="P26">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				153
			</parents>
			<position x="7.9093015755747" y="4.88391404650978">
			</position>
		</Point>
		<Segment id="155" name="s11">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				146;154
			</parents>
			<position x1="6.23404051634456" y1="4.88391404650978" x2="7.9093015755747" y2="4.88391404650978">
			</position>
		</Segment>
		<Angle id="156" name="α1">
			<parents>
				154;146;150
			</parents>
			<position x1="7.9093015755747" y1="4.88391404650978" x2="6.23404051634456" y2="4.88391404650978" x3="10.2987353631721" y3="2.7312856092151">
			</position>
			<line radius="0.8" reversed="false">
			</line>
		</Angle>
		<MeasureAngle id="158" name="w(P26;P24;P25)">
			<appearance pen_style="2">
			</appearance>
			<parents>
				156
			</parents>
			<position x="5.72161900902825" y="5.01122547113331" width="0" height="0">
			</position>
			<text>
				<![CDATA[]]>
			</text>
			<line x1="6.72161900902825" y1="5.51122547113331" x2="0" y2="0" dx="1" dy="0.5">
			</line>
		</MeasureAngle>
		<CircleWDR id="160" name="k7">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				26;158
			</parents>
			<position x1="-11.668125" y1="-7.09083333333333" x2="-6.13321367713811" y2="-7.09083333333333">
			</position>
			<radius r_term="w(α1)/60">
			</radius>
		</CircleWDR>
		<DoubleIntersection id="165" name="DI_10">
			<appearance visible="false">
			</appearance>
			<parents>
				33;160
			</parents>
			<pointlist>
				-11.668125;-1.55592201047144 
				-11.668125;-12.6257446561952
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="166" name="P27" plist_index="0">
			<appearance color="$00FF0000" shape="0" brush_style="0">
			</appearance>
			<parents>
				165
			</parents>
			<position x="-11.668125" y="-1.55592201047144">
			</position>
		</IntersectPoint>
		<IntersectPoint id="167" name="P28" plist_index="1">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				165
			</parents>
			<position x="-11.668125" y="-6.37276446516401" z="2469">
			</position>
		</IntersectPoint>
		<Perpendicular id="168" name="g17">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				166;33
			</parents>
			<position x1="-17.668125" y1="-1.55592201047144" x2="-11.668125" y2="-1.55592201047144">
			</position>
		</Perpendicular>
		<Perpendicular id="169" name="g18">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				64;168
			</parents>
			<position x1="9.26593984374996" y1="-13.0908333333333" x2="9.26593984374996" y2="-7.09083333333333">
			</position>
		</Perpendicular>
		<PointLXL id="170" name="P29">
			<appearance color="$000000FF" shape="0" brush_style="0">
			</appearance>
			<parents>
				169;168
			</parents>
			<position x="9.26593984374996" y="-1.55592201047144">
			</position>
		</PointLXL>
		<Segment id="171" name="s12">
			<appearance color="$00FF0000" shape="0" brush_style="2">
			</appearance>
			<parents>
				166;170
			</parents>
			<position x1="-11.668125" y1="-1.55592201047144" x2="9.26593984374996" y2="-1.55592201047144">
			</position>
		</Segment>
		<Segment id="172" name="s13">
			<appearance color="$00FF0000" shape="0" brush_style="2">
			</appearance>
			<parents>
				170;64
			</parents>
			<position x1="9.26593984374996" y1="-1.55592201047144" x2="9.26593984374996" y2="-7.09083333333333">
			</position>
		</Segment>
		<TextBox id="180" name="tb8">
			<appearance color="$00FF0000" shape="0" brush_style="2">
			</appearance>
			<position x="-13.255625" y="3.730625" width="9.76312500000002" height="5.66208333333333">
			</position>
			<text>
				<![CDATA[
				<font size=12><b>Regenbogen: Strahl zweiter Ordnung</b><br>x 
				ist der sogenannte Stoßparameter, der orientierte Abstand 
				des auf das Tröpfchen fallenden Sonnenstrahls von der 
				Symmetrieachse. Dazu ist der reflektierte Strahl zweiter 
				Ordnung konstruiert, und es wird der Winkel </font><font 
				face="SYMBOL" size=12>a</font><font size=12> gegen die Achse 
				angezeigt. Der funktionale Zusammenhang von x und 
				</font><font face="SYMBOL" size=12>a</font><font size=12> 
				wird unten im Schaubild dargestellt. Zu sehen sind der Punkt 
				P(x/</font><font face="SYMBOL" size=12>a</font><font 
				size=12>) und die Ortslinie von P für -1</font><font 
				face="SYMBOL" size=12>£</font><font size=12> x </font><font 
				face="SYMBOL" size=12>£</font><font size=12>1.</font>
				]]>
			</text>
		</TextBox>
		<ObjectName id="209" name="Name11">
			<parents>
				156
			</parents>
			<position x="5.69235874477594" y="4.74185469852353" width="0" height="0">
			</position>
			<text>
				<![CDATA[<font face="Symbol">a</font><sub>1</sub>]]>
			</text>
		</ObjectName>
		<Trace id="210" name="OL1" trace_status="3">
			<appearance color="$000000FF" line_width="3">
			</appearance>
			<parents>
				20;21;22;23;120;112;110;111;114;25;27;38;39;42;29;30;
				31;33;132;113;129;130;131;133;135;136;137;138;139;141;
				142;143;144;145;146;148;149;150;153;154;156;158;160;
				165;166;168;41;55;62;64;169;170
			</parents>
			<points>
				12.3800949374999;-2.42795550792774;0.0001 
				12.3656443275991;-2.36763514148905;0.000700841346153846 
				12.3511937176983;-2.33353752957397;0.00130168269230769 
				12.3367431077974;-2.30732385321526;0.00190252403846154 
				12.3222924978966;-2.28539317282779;0.00250336538461538 
				12.2933912780949;-2.24913377405267;0.00370504807692308 
				12.2644900582932;-2.21917449147647;0.00490673076923077 
				12.2355888384915;-2.19327929249846;0.00610841346153846 
				12.2066876186898;-2.17028376932025;0.00731009615384615 
				12.1777863988882;-2.14948999268892;0.00851177884615385 
				12.1633357889873;-2.13976964470886;0.00911262019230769 
				12.1488851790865;-2.1304405458113;0.00971346153846154 
				12.0910827394831;-2.09638456950114;0.0121168269230769 
				12.0621815196814;-2.08096878540405;0.0133185096153846 
				12.0332802998798;-2.06643186636524;0.0145201923076923 
				11.9754778602764;-2.03957827675769;0.0169235576923077 
				11.9465766404747;-2.0270998413781;0.0181252403846154 
				11.9321260305739;-2.021069077261;0.0187260817307692 
				11.917675420673;-2.01516813931713;0.0193269230769231 
				11.8598729810697;-1.99274551209576;0.0217302884615385 
				11.830971761268;-1.98217218975714;0.0229319711538462 
				11.8020705414663;-1.97197827012041;0.0241336538461538 
				11.7442681018629;-1.95261568878477;0.0265370192307692 
				11.7153668820612;-1.9433985922261;0.0277387019230769 
				11.6864656622596;-1.9344630546021;0.0289403846153846 
				11.6286632226562;-1.91736562769684;0.03134375 
				11.5708607830528;-1.90119806227408;0.0337471153846154 
				11.5130583434495;-1.88585717346472;0.0361504807692308 
				11.4841571236478;-1.8784692618531;0.0373521634615385 
				11.4697065137469;-1.87484167544501;0.0379530048076923 
				11.4552559038461;-1.87125684139808;0.0385538461538462 
				11.3396510246394;-1.84399755590667;0.0433605769230769 
				11.281848585036;-1.83122305820587;0.0457639423076923 
				11.2240461454326;-1.81895440886393;0.0481673076923077 
				11.1084412662259;-1.79577708771731;0.0529740384615385 
				11.0506388266225;-1.78480100907809;0.0553774038461538 
				10.9928363870192;-1.77419457921291;0.0577807692307692 
				10.7616266286057;-1.7349972960526;0.0673942307692308 
				10.646021749399;-1.71706750945186;0.0722009615384615 
				10.5304168701923;-1.70008502367279;0.0770076923076923 
				10.0679973533653;-1.63985036948349;0.0962346153846154 
				9.60557783653841;-1.58894283833996;0.115461538461538 
				8.68073880288457;-1.50553679053848;0.153915384615385 
				7.75589976923073;-1.43802487444253;0.192369230769231 
				6.83106073557688;-1.38064913541909;0.230823076923077 
				5.90622170192303;-1.33014887180911;0.269276923076923 
				4.98138266826919;-1.28448041850035;0.307730769230769 
				4.05654363461535;-1.24226029677581;0.346184615384615 
				3.1317046009615;-1.20248877510532;0.384638461538462 
				2.20686556730766;-1.16439810286149;0.423092307692308 
				1.74444605048073;-1.14578348053493;0.442319230769231 
				1.28202653365382;-1.12736150015415;0.461546153846154 
				1.05081677524035;-1.11820199110542;0.471159615384615 
				0.819607016826891;-1.10906606005587;0.480773076923077 
				0.704002137620162;-1.10450445911547;0.485579807692308 
				0.588397258413432;-1.09994579004334;0.490386538461538 
				0.530594818810069;-1.09766724889881;0.492789903846154 
				0.472792379206696;-1.09538907375954;0.495193269230769 
				0.443891159405018;-1.09425008529586;0.496394951923077 
				0.414989939603337;-1.09311114256791;0.497596634615385 
				0.400539329702495;-1.09254168359005;0.498197475961538 
				0.386088719801653;-1.0919722303287;0.498798317307692 
				0.378863414851233;-1.09168750524621;0.499098737980769 
				0.371638109900811;-1.09140278087829;0.499399158653846 
				0.3680254574256;-1.09126041888784;0.499549368990385 
				0.364412804950391;-1.09111805698672;0.499699579326923 
				0.362606478712785;-1.09104687606034;0.499774684495192 
				0.36080015247518;-1.09097569514514;0.499849789663462 
				0.359896989356378;-1.09094010469056;0.499887342247596 
				0.358993826237579;-1.09090451423737;0.499924894831731 
				0.358542244678171;-1.09088671901116;0.499943671123798 
				0.358090663118774;-1.09086892378512;0.499962447415865 
				0.357864872339071;-1.09086002617215;0.499971835561899 
				0.357639081559372;-1.0908511285592;0.499981223707933 
				0.357526186169522;-1.09084667975272;0.499985917780949 
				0.357413290779674;-1.09084223094626;0.499990611853966 
				0.357356843084745;-1.09084000654303;0.499992958890475 
				0.357300395389824;-1.09083778213979;0.499995305926983 
				0.35727217154236;-1.09083666993818;0.499996479445237 
				0.357243947694895;-1.09083555773656;0.499997652963492 
				0.357229835771162;-1.09083500163575;0.499998239722619 
				0.357215723847436;-1.09083444553494;0.499998826481746 
				0.357208667885571;-1.09083416748454;0.499999119861309 
				0.357201611923703;-1.09083388943414;0.499999413240873 
				0.357194555961837;-1.09083361138373;0.499999706620436 
				0.357191027980901;-1.09083347235853;0.499999853310218 
				1.1E100;1.1E100;0.499999889982664 
				0;0;0.499999926655109 0;0;0.499999963327555 
				0;0;0.499999981663777 0;0;0.499999990831889 
				0;0;0.499999995415944 0;0;0.499999997707972 
				0;0;0.499999998853986 0;0;0.499999999426993 
				0;0;0.499999999713497 0;0;0.499999999856748 
				0;0;0.499999999928374 0;0;0.499999999964187 0;0;0.5 
				0;0;0.500002347036508 0;0;0.500004694073017 
				0;0;0.500005867591271 0;0;0.500006454350398 
				0;0;0.500007041109525 0;0;0.500007334489089 
				0;0;0.500007627868652 
				0.356996989029602;-7.09082582588604;0.500007921248216 
				0.356989933067734;-7.0908255480473;0.500008214627779 
				0.356961709220269;-7.09082443570064;0.500009388146034 
				0.356735918440564;-7.09081553820546;0.500018776292067 
				0.356284336881167;-7.09079774294012;0.500037552584135 
				0.355381173762365;-7.09076215240936;0.500075105168269 
				0.353574847524758;-7.09069097150257;0.500150210336539 
				0.349962195049547;-7.09054860968044;0.500300420673077 
				0.34273689009913;-7.09026388578289;0.500600841346154 
				0.328286280198288;-7.08969443633742;0.501201682692308 
				0.299385060396604;-7.08855552409854;0.502403365384615 
				0.241582620793239;-7.08627759290703;0.504806730769231 
				0.125977741586509;-7.08172087662305;0.509613461538462 
				-0.10523201682695;-7.07260060661083;0.519226923076923 
				-0.567651533653873;-7.05430516651257;0.538453846153846 
				-1.49249056730772;-7.01726856380521;0.576907692307692 
				-2.41732960096156;-6.97917789156135;0.615361538461539 
				-3.34216863461541;-6.93940636989085;0.653815384615385 
				-4.26700766826925;-6.8971862481663;0.692269230769231 
				-5.1918467019231;-6.85151779485756;0.730723076923077 
				-6.11668573557694;-6.80101753124758;0.769176923076923 
				-7.04152476923078;-6.74364179222414;0.807630769230769 
				-7.96636380288463;-6.67612987612818;0.846084615384616 
				-8.42878331971155;-6.63693789824958;0.865311538461539 
				-8.89120283653847;-6.5927238283267;0.884538461538462 
				-9.3536223533654;-6.54181629718317;0.903765384615385 
				-9.58483211177886;-6.51308670791552;0.913378846153846 
				-9.70043699098559;-6.49771605041456;0.918185576923077 
				-9.81604187019231;-6.48158164299387;0.922992307692308 
				-10.0472516286058;-6.44666937061405;0.932605769230769 
				-10.1628565078125;-6.42767431987433;0.9374125 
				-10.2784613870192;-6.40747208745376;0.942219230769231 
				-10.394066266226;-6.38588957894935;0.947025961538462 
				-10.5096711454327;-6.36271225780273;0.951832692307693 
				-10.6252760246394;-6.33766911075999;0.956639423076923 
				-10.6830784642428;-6.32434233861194;0.959042788461539 
				-10.7119796840445;-6.31745545632978;0.960244471153846 
				-10.7264302939453;-6.31395297227764;0.9608453125 
				-10.7408809038462;-6.31040982526858;0.961446153846154 
				-10.7986833434495;-6.29580949320194;0.963849519230769 
				-10.8564857830529;-6.28046860439258;0.966252884615385 
				-10.9142882226563;-6.26430103896982;0.96865625 
				-10.9431894424579;-6.25587580086979;0.969857932692308 
				-10.9576400523588;-6.25157156076422;0.970458774038462 
				-10.9720906622596;-6.24720361206456;0.971059615384616 
				-11.029893101863;-6.22905097788188;0.973462980769231 
				-11.0587943216647;-6.21953200895593;0.974664663461539 
				-11.0876955414664;-6.20968839654625;0.975866346153846 
				-11.1454979810697;-6.18892115457089;0.978269711538462 
				-11.1743992008714;-6.17793522685166;0.979471394230769 
				-11.1888498107722;-6.17227583094546;0.980072235576923 
				-11.1960751157227;-6.16940226520946;0.98037265625 
				-11.2033004206731;-6.16649852734952;0.980673076923077 
				-11.2611028602764;-6.14208838990897;0.983076442307692 
				-11.2900040800781;-6.12900208620761;0.984278125 
				-11.3189052998798;-6.11523480030142;0.985479807692308 
				-11.3767077394832;-6.08528209716551;0.987883173076923 
				-11.4056089592849;-6.06885026852979;0.989084855769231 
				-11.4200595691857;-6.06020019849608;0.989685697115385 
				-11.4345101790865;-6.05122612085535;0.990286538461538 
				-11.4634113988882;-6.03217667397774;0.991488221153846 
				-11.4923126186899;-6.01138289734641;0.992689903846154 
				-11.5212138384916;-5.9883873741682;0.993891586538462 
				-11.5356644483924;-5.97585995368493;0.994492427884615 
				-11.5501150582933;-5.96249217519019;0.995093269230769 
				-11.579016278095;-5.93253289261398;0.996294951923077 
				-11.6079174978966;-5.89627349383886;0.997496634615385 
				-11.6223681077975;-5.87434281345138;0.998097475961538 
				-11.6368187176983;-5.84812913709268;0.998698317307692 
				-11.6512693275992;-5.81403152517759;0.999299158653846 
				-11.6657199375;-5.75371115873886;0.9999
			</points>
		</Trace>
	</objlist>
</dg:drawing>
