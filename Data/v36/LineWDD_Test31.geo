<?xml version="1.0" encoding="UTF-8"?>
<dg:drawing xmlns:dg="http://www.dynageo.com/xml/dg12" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.dynageo.com/xml/dg12 http://www.dynageo.com/xml/dg12.xsd">
	<header>
		<created prog_name="EUKLID DynaGeo" prog_version="3.6.0.274" date="2010-12-30T11:00:57">
		</created>
		<edited prog_name="EUKLID DynaGeo" prog_version="3.1.6.21" date="2010-12-30T11:46:36">
		</edited>
	</header>
	<windowdata>
		<log_window xmin="-11.27125" xmax="11.2977083333333" ymin="-7.3025" ymax="7.27604166666667">
		</log_window>
		<scr_window width="853" height="551">
		</scr_window>
		<startfont fontname="Arial" fontsize="13" fontcharset="0">
		</startfont>
		<options AreaDecimals="4" DefLocLineStatus="3">
		</options>
	</windowdata>
	<objlist>
		<Origin id="1" name="O" cosys_type="1">
			<appearance color="$00808080">
			</appearance>
			<position x="0" y="0">
			</position>
		</Origin>
		<Axis id="2" name="xa" label="x">
			<appearance color="$00808080" shape="0" brush_style="0">
			</appearance>
			<parents>
				1
			</parents>
			<position x1="0" y1="0" x2="1" y2="0">
			</position>
		</Axis>
		<Axis id="3" name="ya" label="y">
			<appearance color="$00808080" shape="0" brush_style="0">
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
			<position x="-0.502708333333333" y="4.15395833333333">
			</position>
		</Point>
		<Point id="7" name="P2">
			<appearance brush_style="0">
			</appearance>
			<position x="-5.476875" y="1.79916666666667">
			</position>
		</Point>
		<Point id="8" name="P3">
			<appearance brush_style="0">
			</appearance>
			<position x="-3.73062499999999" y="6.111875">
			</position>
		</Point>
		<Segment id="9" name="s1">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				6;7
			</parents>
			<position x1="-0.502708333333333" y1="4.15395833333333" x2="-5.476875" y2="1.79916666666667">
			</position>
		</Segment>
		<Segment id="10" name="s2">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				7;8
			</parents>
			<position x1="-5.476875" y1="1.79916666666667" x2="-3.73062499999999" y2="6.111875">
			</position>
		</Segment>
		<Segment id="11" name="s3">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				8;6
			</parents>
			<position x1="-3.73062499999999" y1="6.111875" x2="-0.502708333333333" y2="4.15395833333333">
			</position>
		</Segment>
		<Polygon id="13" name="N1">
			<parents>
				8;7;6
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
		<Angle id="15" name="a1">
			<parents>
				6;7;8
			</parents>
			<position x1="-0.502708333333333" y1="4.15395833333333" x2="-5.476875" y2="1.79916666666667" x3="-3.73062499999999" y3="6.111875">
			</position>
			<line radius="0.8" reversed="false">
			</line>
		</Angle>
		<MeasureAngle id="16" name="w(P1;P2;P3)">
			<appearance pen_style="2">
			</appearance>
			<parents>
				15
			</parents>
			<position x="-5.11439305740258" y="2.18308181522271" width="0" height="0">
			</position>
			<text>
				<![CDATA[]]>
			</text>
			<line x1="-4.11439305740258" y1="2.68308181522271" x2="0" y2="0" dx="1" dy="0.5">
			</line>
		</MeasureAngle>
		<Point id="17" name="P4">
			<appearance brush_style="0">
			</appearance>
			<position x="-3.06916666666667" y="-1.21708333333333">
			</position>
		</Point>
		<Point id="18" name="P5">
			<appearance brush_style="0">
			</appearance>
			<position x="3.30729166666667" y="1.32291666666667">
			</position>
		</Point>
		<Line id="19" name="g1">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				17;18
			</parents>
			<position x1="-3.06916666666667" y1="-1.21708333333333" x2="3.30729166666667" y2="1.32291666666667">
			</position>
		</Line>
		<LineWDD id="20" name="g2">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				18;17;16
			</parents>
			<position x1="-3.06916666666667" y1="-1.21708333333333" x2="70.0291300435635" y2="67.0224874307267">
			</position>
			<term>
				w(P1;P2;P3)/2
			</term>
		</LineWDD>
		<CircleWDR id="26" name="k1">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				18;16
			</parents>
			<position x1="3.30729166666667" y1="1.32291666666667" x2="7.02689448142034" y2="1.32291666666667">
			</position>
			<radius>
				<![CDATA[bogen(w(P1;P2;P3))*5]]>
			</radius>
		</CircleWDR>
	</objlist>
</dg:drawing>
