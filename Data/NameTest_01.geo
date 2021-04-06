<?xml version="1.0" encoding="UTF-8"?>
<dg:drawing xmlns:dg="http://www.dynageo.com/xml/dg12" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.dynageo.com/xml/dg12 http://www.dynageo.com/xml/dg12.xsd">
	<header>
		<created prog_name="EUKLID DynaGeo" prog_version="3.2.0.1" date="2008-07-30T17:53:39">
		</created>
		<edited prog_name="EUKLID DynaGeo" prog_version="3.2.0.13" date="2008-08-04T10:55:08">
		</edited>
	</header>
	<windowdata>
		<log_window xmin="-12.620625" xmax="12.620625" ymin="-8.51958333333333" ymax="8.493125">
		</log_window>
		<scr_window width="954" height="643">
		</scr_window>
		<startfont fontname="Arial" fontsize="13" fontcharset="0">
		</startfont>
		<options LengthDecimals="2" AreaDecimals="5" AngleDecimals="1" DefLocLineStatus="3">
		</options>
	</windowdata>
	<objlist>
		<Origin id="1" name="O" cosys_type="-1">
			<appearance color="$00C0C0C0">
			</appearance>
			<position x="0.0" y="0.0">
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
			<position x="-4.28625" y="0.687916666666667">
			</position>
		</Point>
		<Point id="7" name="P2">
			<appearance brush_style="0">
			</appearance>
			<position x="-1.69333333333333" y="5.52979166666667">
			</position>
		</Point>
		<Point id="8" name="P3">
			<appearance brush_style="0">
			</appearance>
			<position x="4.57729166666667" y="2.06375">
			</position>
		</Point>
		<Segment id="9" name="s1">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				6;7
			</parents>
			<position x1="-4.28625" y1="0.687916666666667" x2="-1.69333333333333" y2="5.52979166666667">
			</position>
		</Segment>
		<Segment id="10" name="s2">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				7;8
			</parents>
			<position x1="-1.69333333333333" y1="5.52979166666667" x2="4.57729166666667" y2="2.06375">
			</position>
		</Segment>
		<Segment id="11" name="s3">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				8;6
			</parents>
			<position x1="4.57729166666667" y1="2.06375" x2="-4.28625" y2="0.687916666666667">
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
			<appearance color="$000000FF" brush_style="2">
			</appearance>
			<parents>
				13
			</parents>
			<orientation>
				true
			</orientation>
		</Area>
		<ObjectName id="15" name="Name1">
			<parents>
				8
			</parents>
			<position x="4.72729166666667" y="2.06375" width="5.74145833333333" height="1.93145833333333">
			</position>
			<text>
				<![CDATA[P3]]>
			</text>
		</ObjectName>
		<ObjectName id="16" name="Name2">
			<parents>
				6
			</parents>
			<position x="-4.60375" y="0.529166666666667" width="5.74145833333333" height="1.93145833333333">
			</position>
			<text>
				<![CDATA[P1]]>
			</text>
		</ObjectName>
		<ObjectName id="17" name="Name3">
			<parents>
				7
			</parents>
			<position x="-1.74625" y="6.19125" width="5.74145833333333" height="1.93145833333333">
			</position>
			<text>
				<![CDATA[P<sub>2</sub>]]>
			</text>
		</ObjectName>
		<Angle id="18" name="a">
			<parents>
				8;6;7
			</parents>
			<position x1="4.57729166666667" y1="2.06375" x2="-4.28625" y2="0.687916666666667" x3="-1.69333333333333" y3="5.52979166666667">
			</position>
			<line radius="1.18325263809364" reversed="false">
			</line>
		</Angle>
		<MeasureAngle id="19" name="w(P3;P1;P2)">
			<appearance pen_style="2">
			</appearance>
			<parents>
				18
			</parents>
			<position x="-3.64910020830967" y="1.13948942431372" width="0" height="0">
			</position>
			<text>
				<![CDATA[]]>
			</text>
			<line x1="-2.643683541643" y1="1.69511442431372" x2="0" y2="0" dx="1.00541666666667" dy="0.555625">
			</line>
		</MeasureAngle>
		<ObjectName id="20" name="Name4">
			<parents>
				18
			</parents>
			<position x="-3.87594233197087" y="1.38031085646583" width="5.74145833333333" height="1.93145833333333">
			</position>
			<text>
				<![CDATA[<font face="Symbol" size=12>a</font>]]>
			</text>
		</ObjectName>
		<TextBox id="21" name="tb1">
			<position x="-10.7685416666667" y="6.77333333333333" width="6.77333333333333" height="2.72520833333333">
			</position>
			<text>
				<![CDATA[<font face="Symbol" size=12>yz</font>]]>
			</text>
		</TextBox>
	</objlist>
</dg:drawing>
