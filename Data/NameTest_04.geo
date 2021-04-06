<?xml version="1.0" encoding="UTF-8"?>
<dg:drawing xmlns:dg="http://www.dynageo.com/xml/dg12" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.dynageo.com/xml/dg12 http://www.dynageo.com/xml/dg12.xsd">
	<header>
		<created prog_name="EUKLID DynaGeo" prog_version="3.2.0.20" date="2008-08-04T17:15:10">
		</created>
		<edited prog_name="EUKLID DynaGeo" prog_version="3.2.0.20" date="2008-08-04T17:15:10">
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
			<position x="-2.59291666666667" y="5.18583333333333">
			</position>
		</Point>
		<Point id="7" name="P2">
			<appearance brush_style="0">
			</appearance>
			<position x="-4.841875" y="1.53458333333333">
			</position>
		</Point>
		<Segment id="8" name="s1">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				6;7
			</parents>
			<position x1="-2.59291666666667" y1="5.18583333333333" x2="-4.841875" y2="1.53458333333333">
			</position>
		</Segment>
		<Point id="9" name="P3">
			<appearance brush_style="0">
			</appearance>
			<position x="-1.21708333333333" y="0.846666666666667">
			</position>
		</Point>
		<Segment id="10" name="s2">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				7;9
			</parents>
			<position x1="-4.841875" y1="1.53458333333333" x2="-1.21708333333333" y2="0.846666666666667">
			</position>
		</Segment>
		<Angle id="11" name="α">
			<parents>
				9;7;6
			</parents>
			<position x1="-1.21708333333333" y1="0.846666666666667" x2="-4.841875" y2="1.53458333333333" x3="-2.59291666666667" y3="5.18583333333333">
			</position>
			<line radius="1.21420402167428" reversed="false">
			</line>
		</Angle>
		<MeasureAngle id="12" name="w(P3;P2;P1)">
			<appearance pen_style="2">
			</appearance>
			<parents>
				11
			</parents>
			<position x="-4.10871579504569" y="1.85812454671002" width="0" height="0">
			</position>
			<text>
				<![CDATA[]]>
			</text>
			<line x1="-3.10871579504569" y1="2.35812454671002" x2="0" y2="0" dx="1" dy="0.5">
			</line>
		</MeasureAngle>
		<ObjectName id="13" name="Name1">
			<parents>
				11
			</parents>
			<position x="-4.365625" y="2.143125" width="5.74145833333333" height="1.93145833333333">
			</position>
			<text>
				<![CDATA[<font face="Symbol">a</font>]]>
			</text>
		</ObjectName>
	</objlist>
</dg:drawing>
