<?xml version="1.0" encoding="UTF-8"?>
<dg:drawing xmlns:dg="http://www.dynageo.com/xml/dg12" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.dynageo.com/xml/dg12 http://www.dynageo.com/xml/dg12.xsd">
	<header>
		<created prog_name="EUKLID DynaGeo" prog_version="2.5">
		</created>
		<edited prog_name="EUKLID DynaGeo" prog_version="3.1.6.21" date="2009-11-09T17:31:37">
		</edited>
		<copyright sign_code="35363067">
			Elschenbroich/ Seebach: &#xD;
Dynamisch Geometrie 
			entdecken Klasse 7 - 10 &#xD;
EINZEL-Lizenz (Keine 
			Raumlizenz)&#xD;
Elektronische Arbeitsblätter mit Euklid 
			DynaGeo&#xD;
© CoTec 2004&#xD;
		</copyright>
		<environment>
			<commands>
				9C685A4F91
			</commands>
		</environment>
	</header>
	<windowdata>
		<log_window xmin="-5.13291666666667" xmax="25.4529166666667" ymin="-5.13291666666667" ymax="13.97">
		</log_window>
		<scr_window width="1156" height="722">
		</scr_window>
		<startfont fontname="Arial" fontsize="13" fontcharset="0">
		</startfont>
		<options AreaDecimals="4" DefLocLineStatus="3">
		</options>
	</windowdata>
	<macrolist>
		<macro>
			<name>
				Heron
			</name>
			<helptext>
				Eingabe: Ein Rechteck (Durch Klicken auf die gefärbte 
				Fläche).&#xD;Ausgabe: Ein Rechteck mit gleichem 
				Flächeninhalt, aber quadratähnlicherer Gestalt.
			</helptext>
			<cmd_list>
				<cmd cmd_type="-1">
					<Point id="18" name="">
						<appearance shape="4">
						</appearance>
						<parents>
							17
						</parents>
						<position x="104" y="372">
						</position>
					</Point>
				</cmd>
				<cmd cmd_type="-1">
					<PointLXL id="26" name="">
						<appearance shape="0" brush_style="0">
						</appearance>
						<parents>
							20;19
						</parents>
						<position x="508.999999999962" y="372">
						</position>
					</PointLXL>
				</cmd>
				<cmd cmd_type="-1">
					<PointLXL id="25" name="">
						<appearance color="$00FF0000" brush_style="0">
						</appearance>
						<parents>
							24;20
						</parents>
						<position x="508.999999999962" y="334.204724409448">
						</position>
					</PointLXL>
				</cmd>
				<cmd cmd_type="-1">
					<IntersectPoint id="22" name="" plist_index="0">
						<appearance shape="3">
						</appearance>
						<parents>
							179
						</parents>
						<position x="0" y="0">
						</position>
					</IntersectPoint>
				</cmd>
				<cmd cmd_type="0">
					<Polygon id="33" name="">
						<appearance color="$00FFFFC8" pen_style="5" brush_style="0">
						</appearance>
						<parents>
							18;26;25;22
						</parents>
						<position x1="0" y1="0" x2="0" y2="0">
						</position>
					</Polygon>
				</cmd>
				<cmd cmd_type="1">
					<Ray id="27" name="">
						<appearance color="$00C0C0C0">
						</appearance>
						<parents>
							18;26
						</parents>
						<position x1="0" y1="0" x2="0" y2="0">
						</position>
					</Ray>
				</cmd>
				<cmd cmd_type="1">
					<MeasureDistance id="37" name="">
						<appearance color="$00FF0000" shape="0" brush_style="0">
						</appearance>
						<parents>
							18;22
						</parents>
						<position x="-5.13291666666667" y="13.97" width="0" height="0">
						</position>
						<text>
							<![CDATA[]]>
						</text>
						<line x1="0" y1="0" x2="0" y2="0" dx="0" dy="0">
						</line>
					</MeasureDistance>
				</cmd>
				<cmd cmd_type="1">
					<MeasureDistance id="36" name="">
						<appearance pen_style="2">
						</appearance>
						<parents>
							26;18
						</parents>
						<position x="-5.13291666666667" y="13.97" width="0" height="0">
						</position>
						<text>
							<![CDATA[]]>
						</text>
						<line x1="0" y1="0" x2="0" y2="0" dx="0" dy="0">
						</line>
					</MeasureDistance>
				</cmd>
				<cmd cmd_type="1">
					<CircleWDR id="90" name="">
						<parents>
							18;37;36
						</parents>
						<position x1="0" y1="0" x2="0" y2="0">
						</position>
						<radius>
							<![CDATA[( d(%18;%22) + d(%26;%18) ) / 2]]>
						</radius>
					</CircleWDR>
				</cmd>
				<cmd cmd_type="1">
					<DoubleIntersection id="180" name="">
						<appearance shape="3">
						</appearance>
						<parents>
							27;90
						</parents>
						<pointlist>
							0;0 0;0
						</pointlist>
					</DoubleIntersection>
				</cmd>
				<cmd cmd_type="1">
					<IntersectPoint id="153" name="" plist_index="0">
						<appearance shape="3">
						</appearance>
						<parents>
							180
						</parents>
						<position x="0" y="0">
						</position>
					</IntersectPoint>
				</cmd>
				<cmd cmd_type="2">
					<IntersectPoint id="154" name="" plist_index="1">
						<appearance shape="4">
						</appearance>
						<parents>
							180
						</parents>
						<position x="325.397637795257" y="372">
						</position>
					</IntersectPoint>
				</cmd>
				<cmd cmd_type="1">
					<Ray id="28" name="">
						<appearance color="$00C0C0C0">
						</appearance>
						<parents>
							18;22
						</parents>
						<position x1="0" y1="0" x2="0" y2="0">
						</position>
					</Ray>
				</cmd>
				<cmd cmd_type="1">
					<MeasureDistance id="156" name="">
						<appearance pen_style="2">
						</appearance>
						<parents>
							154;18
						</parents>
						<position x="-5.13291666666667" y="13.97" width="0" height="0">
						</position>
						<text>
							<![CDATA[]]>
						</text>
						<line x1="0" y1="0" x2="0" y2="0" dx="0" dy="0">
						</line>
					</MeasureDistance>
				</cmd>
				<cmd cmd_type="1">
					<CircleWDR id="157" name="">
						<parents>
							18;37;36;156
						</parents>
						<position x1="0" y1="0" x2="0" y2="0">
						</position>
						<radius>
							<![CDATA[d(%18;%22) * d(%26;%18) / d(%154;%18)]]>
						</radius>
					</CircleWDR>
				</cmd>
				<cmd cmd_type="1">
					<DoubleIntersection id="181" name="">
						<appearance shape="3">
						</appearance>
						<parents>
							28;157
						</parents>
						<pointlist>
							0;0 0;0
						</pointlist>
					</DoubleIntersection>
				</cmd>
				<cmd cmd_type="1">
					<IntersectPoint id="170" name="" plist_index="0">
						<appearance shape="3">
						</appearance>
						<parents>
							181
						</parents>
						<position x="0" y="0">
						</position>
					</IntersectPoint>
				</cmd>
				<cmd cmd_type="2">
					<IntersectPoint id="171" name="" plist_index="1">
						<appearance shape="4">
						</appearance>
						<parents>
							181
						</parents>
						<position x="104" y="302.861563083489">
						</position>
					</IntersectPoint>
				</cmd>
				<cmd cmd_type="1">
					<ParallelLine id="172" name="">
						<parents>
							171;27
						</parents>
						<position x1="0" y1="0" x2="0" y2="0">
						</position>
					</ParallelLine>
				</cmd>
				<cmd cmd_type="1">
					<ParallelLine id="173" name="">
						<parents>
							154;28
						</parents>
						<position x1="0" y1="0" x2="0" y2="0">
						</position>
					</ParallelLine>
				</cmd>
				<cmd cmd_type="2">
					<PointLXL id="174" name="">
						<appearance color="$000000FF" shape="0" brush_style="0">
						</appearance>
						<parents>
							172;173
						</parents>
						<position x="325.397637795257" y="302.861563083489">
						</position>
					</PointLXL>
				</cmd>
				<cmd cmd_type="2">
					<Polygon id="175" name="">
						<appearance color="$00D9D9FF" pen_style="5" brush_style="0">
						</appearance>
						<parents>
							18;154;174;171
						</parents>
						<position x1="0" y1="0" x2="0" y2="0">
						</position>
					</Polygon>
				</cmd>
				<cmd cmd_type="2">
					<Segment id="176" name="">
						<parents>
							154;174
						</parents>
						<position x1="0" y1="0" x2="0" y2="0">
						</position>
					</Segment>
				</cmd>
				<cmd cmd_type="2">
					<Segment id="177" name="">
						<parents>
							174;171
						</parents>
						<position x1="0" y1="0" x2="0" y2="0">
						</position>
					</Segment>
				</cmd>
				<cmd cmd_type="2">
					<Segment id="178" name="">
						<parents>
							171;18
						</parents>
						<position x1="0" y1="0" x2="0" y2="0">
						</position>
					</Segment>
				</cmd>
			</cmd_list>
		</macro>
	</macrolist>
	<objlist>
		<Origin id="1" name="O" cosys_type="0">
			<appearance color="$00C0C0C0" brush_style="0" visible="false">
			</appearance>
			<position x="0" y="0">
			</position>
		</Origin>
		<Axis id="2" name="xa" label="x">
			<appearance color="$00C0C0C0" visible="false">
			</appearance>
			<parents>
				1
			</parents>
			<position x1="0" y1="0" x2="1" y2="0">
			</position>
		</Axis>
		<Axis id="3" name="ya" label="y">
			<appearance color="$00C0C0C0" visible="false">
			</appearance>
			<parents>
				1
			</parents>
			<position x1="0" y1="0" x2="0" y2="-1">
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
		<Point id="18" name="P4">
			<appearance brush_style="0" visible="false">
			</appearance>
			<position x="-7.83166666666667" y="-3.889375">
			</position>
		</Point>
		<ParallelLine id="19" name="g4">
			<appearance visible="false">
			</appearance>
			<parents>
				18;2
			</parents>
			<position x1="-7.83166666666667" y1="-3.889375" x2="-6.83166666666667" y2="-3.889375">
			</position>
		</ParallelLine>
		<CircleWDR id="21" name="k2">
			<appearance visible="false">
			</appearance>
			<parents>
				18
			</parents>
			<position x1="-7.83166666666667" y1="-3.889375" x2="-6.83166666666667" y2="-3.889375">
			</position>
			<radius>
				<![CDATA[1]]>
			</radius>
		</CircleWDR>
		<TextBox id="140" name="">
			<appearance color="$00000008">
			</appearance>
			<position x="-4.49791666666667" y="13.5995833333333" width="24.1564583333334" height="8.94291666666667">
			</position>
			<text>
				<![CDATA[
				<font face="Arial" size="14">Es ist ein Rechteck mit den 
				Seitenlängen 1 und A gegeben.  <br>Den Wert von A kannst du 
				durch Ziehen am Schieberegler verändern.</font><font 
				face="Arial" size="14"> <br> <br></font><font face="Arial" 
				size="14">a) Mit dem Makro "Heron" formt man dieses in ein 
				anderes Rechteck gleichen Inhalts um.  <br>    (Makro 
				starten, Klick auf die eine Rechtecksseite, am besten die 
				obere).</font><font face="Arial" size="14"> <br></font><font 
				face="Arial" size="14">    Überprüfe dies mit Hilfe des 
				Termfensters/Taschenrechners.  <br>    (Messen von 
				Streckenlängen mit dem dem Abstand-Button und der 
				Alt-Taste.)</font><font face="Arial" size="14"> 
				<br></font><font face="Arial" size="14">b) Wiederhole dies 
				mit dem neuen Rechteck usw.  <br>    Wie entwickelt sich die 
				Gestalt dieser Rechtecke?</font><font face="Arial" size="14"> 
				<br></font><font face="Arial" size="14">    Was erwartest du, 
				wenn man das Verfahren "immer wieder" anwenden 
				würde?</font><font face="Arial" size="14"> <br></font><font 
				face="Arial" size="14">c) Welche algebraische Bedeutung gibt 
				es für die Seitenlänge(n) der erzeugten 
				Rechtecke?</font><font face="Arial" size="14"> 
				<br></font><font face="Arial" size="14">d) Nach welcher 
				Formel werden bei gegebenen Seitenlängen x<sub>alt</sub> und 
				y<sub>alt</sub> die neuen Seitenlängen  <br>    
				x<sub>neu</sub> und y<sub>neu</sub> berechnet?</font><font 
				face="Arial" size="14"> <br></font>
				]]>
			</text>
		</TextBox>
		<CircleWDR id="348" name="k1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				1
			</parents>
			<position x1="0" y1="0" x2="1" y2="0">
			</position>
			<radius>
				<![CDATA[1]]>
			</radius>
		</CircleWDR>
		<DoubleIntersection id="646" name="DI_3">
			<appearance visible="false">
			</appearance>
			<parents>
				3;348
			</parents>
			<pointlist>
				0;1 0;-1
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="349" name="P1" plist_index="0">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				646
			</parents>
			<position x="0" y="1">
			</position>
		</IntersectPoint>
		<IntersectPoint id="350" name="P2" plist_index="1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				646
			</parents>
			<position x="0" y="-1">
			</position>
		</IntersectPoint>
		<DoubleIntersection id="643" name="DI_2">
			<appearance visible="false">
			</appearance>
			<parents>
				2;348
			</parents>
			<pointlist>
				-1;0 1;0
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="351" name="P3" plist_index="0">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				643
			</parents>
			<position x="-1" y="0">
			</position>
		</IntersectPoint>
		<IntersectPoint id="352" name="P5" plist_index="1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				643
			</parents>
			<position x="1" y="0">
			</position>
		</IntersectPoint>
		<Ray id="353" name="h1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				1;352
			</parents>
			<position x1="0" y1="0" x2="1" y2="0">
			</position>
		</Ray>
		<ParallelLine id="356" name="g1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				349;2
			</parents>
			<position x1="0" y1="1" x2="1" y2="1">
			</position>
		</ParallelLine>
		<Segment id="362" name="1">
			<appearance shape="0" brush_style="2">
			</appearance>
			<parents>
				349;1
			</parents>
			<position x1="0" y1="1" x2="0" y2="0">
			</position>
		</Segment>
		<ObjectName id="621" name="dummy2">
			<parents>
				362
			</parents>
			<position x="-0.396875" y="0.740833333333339" width="5.74145833333334" height="1.93145833333333">
			</position>
			<text>
				<![CDATA[
				<font face="Arial" size="12"><b></font><font face="Arial" 
				size="13">1</font>
				]]>
			</text>
		</ObjectName>
		<Number id="623" name="A" show_name="true">
			<appearance color="$002BA800" shape="0" brush_style="2">
			</appearance>
			<position x="0.079375" y="-1.16416666666667" width="250" height="33">
			</position>
			<value min="0" actual="10" max="20" quant="0.1" ani_step="0.001">
			</value>
		</Number>
		<Point id="625" name="P6">
			<appearance brush_style="0" visible="false">
			</appearance>
			<parents>
				2
			</parents>
			<position x="2.72520833333333" y="0">
			</position>
		</Point>
		<Ray id="626" name="h2">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				1;625
			</parents>
			<position x1="0" y1="0" x2="2.72520833333333" y2="0">
			</position>
		</Ray>
		<CircleWDR id="627" name="k3">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				1;623
			</parents>
			<position x1="0" y1="0" x2="10" y2="0">
			</position>
			<radius>
				<![CDATA[A]]>
			</radius>
		</CircleWDR>
		<DoubleIntersection id="640" name="DI_1">
			<appearance visible="false">
			</appearance>
			<parents>
				626;627
			</parents>
			<pointlist>
				-10;0 10;0
			</pointlist>
		</DoubleIntersection>
		<IntersectPoint id="628" name="P7" plist_index="0">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				640
			</parents>
			<position x="-5.13291666666667" y="13.97" z="2">
			</position>
		</IntersectPoint>
		<IntersectPoint id="629" name="P8" plist_index="1">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				640
			</parents>
			<position x="10" y="0">
			</position>
		</IntersectPoint>
		<ParallelLine id="631" name="g2">
			<appearance shape="0" brush_style="0" visible="false">
			</appearance>
			<parents>
				629;3
			</parents>
			<position x1="10" y1="0" x2="10" y2="-1">
			</position>
		</ParallelLine>
		<PointLXL id="632" name="P9">
			<appearance color="$000000FF" shape="0" brush_style="0">
			</appearance>
			<parents>
				631;356
			</parents>
			<position x="10" y="1">
			</position>
		</PointLXL>
		<Segment id="633" name="s1">
			<appearance shape="0" brush_style="2">
			</appearance>
			<parents>
				1;629
			</parents>
			<position x1="0" y1="0" x2="10" y2="0">
			</position>
		</Segment>
		<Segment id="634" name="s2">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				629;632
			</parents>
			<position x1="10" y1="0" x2="10" y2="1">
			</position>
		</Segment>
		<Segment id="635" name="s3">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				632;349
			</parents>
			<position x1="10" y1="1" x2="0" y2="1">
			</position>
		</Segment>
		<Polygon id="637" name="N1">
			<parents>
				1;629;632;349
			</parents>
			<position x1="0" y1="0" x2="0" y2="0">
			</position>
		</Polygon>
		<Area id="638" name="F_1">
			<appearance color="$00FFFFAA" pen_style="5" brush_style="0">
			</appearance>
			<parents>
				637
			</parents>
			<orientation>
				true
			</orientation>
		</Area>
		<MeasureDistance id="639" name="d(O;P8)">
			<appearance color="$00279D00" shape="0" brush_style="2">
			</appearance>
			<parents>
				1;629
			</parents>
			<position x="0" y="0" width="1.45520833333334" height="0.635">
			</position>
			<text>
				<![CDATA[]]>
			</text>
			<line x1="0" y1="0" x2="10" y2="0" dx="0" dy="24">
			</line>
		</MeasureDistance>
	</objlist>
</dg:drawing>
