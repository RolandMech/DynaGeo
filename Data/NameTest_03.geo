<?xml version="1.0" encoding="UTF-8"?>
<dg:drawing xmlns:dg="http://www.dynageo.com/xml/dg12" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.dynageo.com/xml/dg12 http://www.dynageo.com/xml/dg12.xsd">
	<header>
		<created prog_name="EUKLID DynaGeo" prog_version="3.2.0.12" date="2008-08-03T14:50:33">
		</created>
		<edited prog_name="EUKLID DynaGeo" prog_version="3.2.0.13" date="2008-08-04T10:42:40">
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
			<position x="-3.571875" y="5.66208333333333">
			</position>
		</Point>
		<Point id="7" name="P2">
			<appearance brush_style="0">
			</appearance>
			<position x="-5.29166666666667" y="2.91041666666667">
			</position>
		</Point>
		<Segment id="8" name="s1">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				6;7
			</parents>
			<position x1="-3.571875" y1="5.66208333333333" x2="-5.29166666666667" y2="2.91041666666667">
			</position>
		</Segment>
		<Point id="9" name="P3">
			<appearance brush_style="0">
			</appearance>
			<position x="-1.56104166666667" y="2.2225">
			</position>
		</Point>
		<Segment id="10" name="s2">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				7;9
			</parents>
			<position x1="-5.29166666666667" y1="2.91041666666667" x2="-1.56104166666667" y2="2.2225">
			</position>
		</Segment>
		<Angle id="11" name="ε">
			<parents>
				9;7;6
			</parents>
			<position x1="-1.56104166666667" y1="2.2225" x2="-5.29166666666667" y2="2.91041666666667" x3="-3.571875" y3="5.66208333333333">
			</position>
			<line radius="1.08479166666667" reversed="false">
			</line>
		</Angle>
		<MeasureAngle id="12" name="w(P3;P2;P1)">
			<appearance pen_style="2">
			</appearance>
			<parents>
				11
			</parents>
			<position x="-4.63645578933453" y="3.19903580607343" width="0" height="0">
			</position>
			<text>
				<![CDATA[]]>
			</text>
			<line x1="-3.63645578933453" y1="3.69903580607343" x2="0" y2="0" dx="1" dy="0.5">
			</line>
		</MeasureAngle>
		<ObjectName id="13" name="Name1">
			<parents>
				11
			</parents>
			<position x="-4.82857397308756" y="3.5122172213255" width="5.74145833333333" height="1.93145833333333">
			</position>
			<text>
				<![CDATA[<font face="Symbol">e</font>]]>
			</text>
		</ObjectName>
	</objlist>
</dg:drawing>
