<?xml version="1.0" encoding="UTF-8"?>
<dg:drawing xmlns:dg="http://www.dynageo.com/xml/dg12" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.dynageo.com/xml/dg12 http://www.dynageo.com/xml/dg12.xsd">
	<header>
		<created prog_name="EUKLID DynaGeo" prog_version="3.5.1.2" date="2009-12-05T21:50:05">
		</created>
		<edited prog_name="EUKLID DynaGeo" prog_version="3.5.1.2" date="2009-12-05T22:13:05">
		</edited>
	</header>
	<windowdata>
		<log_window xmin="-10.080625" xmax="10.1070833333333" ymin="-10.6891666666667" ymax="10.6627083333333">
		</log_window>
		<scr_window width="763" height="807">
		</scr_window>
		<startfont fontname="Arial" fontsize="13" fontcharset="0">
		</startfont>
		<options LengthDecimals="2" AreaDecimals="5" AngleDecimals="1" DefLocLineStatus="3">
		</options>
	</windowdata>
	<objlist>
		<Origin id="1" name="O" cosys_type="1">
			<appearance color="$00C0C0C0">
			</appearance>
			<position x="0" y="0">
			</position>
		</Origin>
		<Axis id="2" name="xa" label="x">
			<appearance color="$00C0C0C0" shape="0" brush_style="0">
			</appearance>
			<parents>
				1
			</parents>
			<position x1="0" y1="0" x2="1" y2="0">
			</position>
		</Axis>
		<Axis id="3" name="ya" label="y">
			<appearance color="$00C0C0C0" shape="0" brush_style="0">
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
			<position x="-4.57729166666666" y="3.83645833333333">
			</position>
		</Point>
		<Point id="7" name="P2">
			<appearance brush_style="0">
			</appearance>
			<position x="-3.86291666666666" y="7.99041666666667">
			</position>
		</Point>
		<Point id="8" name="P3">
			<appearance brush_style="0">
			</appearance>
			<position x="1.87854166666666" y="5.66208333333333">
			</position>
		</Point>
		<Segment id="9" name="s1">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				6;7
			</parents>
			<position x1="-4.57729166666666" y1="3.83645833333333" x2="-3.86291666666666" y2="7.99041666666667">
			</position>
		</Segment>
		<Segment id="10" name="s2">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				7;8
			</parents>
			<position x1="-3.86291666666666" y1="7.99041666666667" x2="1.87854166666666" y2="5.66208333333333">
			</position>
		</Segment>
		<Segment id="11" name="s3">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				8;6
			</parents>
			<position x1="1.87854166666666" y1="5.66208333333333" x2="-4.57729166666666" y2="3.83645833333333">
			</position>
		</Segment>
		<Polygon id="13" name="N1">
			<parents>
				6;7;8
			</parents>
			<position x1="0" y1="0" x2="0" y2="0">
			</position>
		</Polygon>
		<Area id="14" name="F_1">
			<appearance color="$000080FF" pen_style="5" brush_style="0">
			</appearance>
			<parents>
				13
			</parents>
			<orientation>
				true
			</orientation>
		</Area>
		<Angle id="15" name="α1">
			<parents>
				8;6;7
			</parents>
			<position x1="1.87854166666666" y1="5.66208333333333" x2="-4.57729166666666" y2="3.83645833333333" x3="-3.86291666666666" y3="7.99041666666667">
			</position>
			<line radius="1.41124890820252" reversed="false">
			</line>
		</Angle>
		<MeasureAngle id="16" name="w(P3;P1;P2)">
			<appearance pen_style="2">
			</appearance>
			<parents>
				15
			</parents>
			<position x="-3.95424196535369" y="4.52881680838443" width="0" height="0">
			</position>
			<text>
				<![CDATA[]]>
			</text>
			<line x1="-2.86945029868703" y1="5.40194180838443" x2="0" y2="0" dx="1.08479166666666" dy="0.873125">
			</line>
		</MeasureAngle>
		<ObjectName id="17" name="Name1">
			<parents>
				15
			</parents>
			<position x="-4.31359201272358" y="4.63148794677261" width="5.74145833333332" height="1.93145833333333">
			</position>
			<text>
				<![CDATA[<font face="SYMBOL">a</font><sub>1</sub>]]>
			</text>
		</ObjectName>
		<Term id="18" name="T1" show_name="false" show_term="true" show_format="1">
			<appearance shape="4">
			</appearance>
			<parents>
				16
			</parents>
			<position x="-9.04874999999999" y="9.68374999999999" width="150" height="35">
			</position>
			<value term="arcsin(sin(w(α1))/1.5)">
			</value>
		</Term>
	</objlist>
</dg:drawing>
