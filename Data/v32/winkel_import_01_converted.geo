<?xml version="1.0" encoding="UTF-8"?>
<dg:drawing xmlns:dg="http://www.dynageo.com/xml/dg12" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.dynageo.com/xml/dg12 http://www.dynageo.com/xml/dg12.xsd">
	<header>
		<created prog_name="EUKLID DynaGeo" prog_version="3.1.6.21" date="2009-07-26T11:27:32">
		</created>
		<edited prog_name="EUKLID DynaGeo" prog_version="3.2.0.255" date="2009-07-28T11:39:29">
		</edited>
	</header>
	<windowdata>
		<log_window xmin="-15.2929166666667" xmax="7.80520833333335" ymin="-5.635625" ymax="9.55145833333333">
		</log_window>
		<scr_window width="873" height="574">
		</scr_window>
		<startfont fontname="Arial" fontsize="13" fontcharset="0">
		</startfont>
		<options AreaDecimals="5" DefLocLineStatus="3">
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
			<position x="-6.6675" y="0.714375">
			</position>
		</Point>
		<Point id="7" name="P2">
			<appearance brush_style="0">
			</appearance>
			<position x="-6.29708333333333" y="8.38729166666667">
			</position>
		</Point>
		<Point id="8" name="P3">
			<appearance brush_style="0">
			</appearance>
			<position x="3.04270833333333" y="2.59291666666667">
			</position>
		</Point>
		<Segment id="9" name="s1">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				6;7
			</parents>
			<position x1="-6.6675" y1="0.714375" x2="-6.29708333333333" y2="8.38729166666667">
			</position>
		</Segment>
		<Segment id="10" name="s2">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				7;8
			</parents>
			<position x1="-6.29708333333333" y1="8.38729166666667" x2="3.04270833333333" y2="2.59291666666667">
			</position>
		</Segment>
		<Segment id="11" name="s3">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				8;6
			</parents>
			<position x1="3.04270833333333" y1="2.59291666666667" x2="-6.6675" y2="0.714375">
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
			<appearance color="$0000FF00" pen_style="5" brush_style="3">
			</appearance>
			<parents>
				13
			</parents>
			<orientation>
				true
			</orientation>
		</Area>
		<LineWDD id="16" name="g1">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				8;6
			</parents>
			<position x1="-6.6675" y1="0.714375" x2="68.8615868348355" y2="66.2533484577517">
			</position>
			<term>
				30°
			</term>
		</LineWDD>
		<Angle id="17" name="α1">
			<appearance color="$000000FF">
			</appearance>
			<parents>
				8;6;7
			</parents>
			<position x1="3.04270833333333" y1="2.59291666666667" x2="-6.6675" y2="0.714375" x3="-6.29708333333333" y3="8.38729166666667">
			</position>
			<line radius="1.27796762818178" reversed="false">
			</line>
		</Angle>
		<MeasureAngle id="18" name="w(P3;P1;P2)">
			<appearance pen_style="2">
			</appearance>
			<parents>
				17
			</parents>
			<position x="-6.11517171154128" y="1.35183553215043" width="0" height="0">
			</position>
			<text>
				<![CDATA[]]>
			</text>
			<line x1="-7.19996337820795" y1="1.74871053215043" x2="0" y2="0" dx="-1.08479166666667" dy="0.396875">
			</line>
		</MeasureAngle>
		<PointLXL id="19" name="P4">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				16;10
			</parents>
			<position x="-1.35698842001473" y="5.32247357596759">
			</position>
		</PointLXL>
		<Angle id="20" name="α2">
			<parents>
				8;6;19
			</parents>
			<position x1="3.04270833333333" y1="2.59291666666667" x2="-6.6675" y2="0.714375" x3="-1.35698842001473" y3="5.32247357596759">
			</position>
			<line radius="0.840858987467908" reversed="false">
			</line>
		</Angle>
		<MeasureAngle id="21" name="w(P3;P1;P4)">
			<appearance pen_style="2">
			</appearance>
			<parents>
				20
			</parents>
			<position x="-6.1684835571431" y="0.957214216501261" width="0" height="0">
			</position>
			<text>
				<![CDATA[]]>
			</text>
			<line x1="-5.42765022380977" y1="-0.365702450165409" x2="0" y2="0" dx="0.740833333333333" dy="-1.32291666666667">
			</line>
		</MeasureAngle>
		<ObjectName id="22" name="Name1">
			<appearance color="$000000FF">
			</appearance>
			<parents>
				17
			</parents>
			<position x="-6.47754671091289" y="1.58855253615525" width="0" height="0">
			</position>
			<text>
				<![CDATA[<font face="Symbol">a</font><sub>1</sub>]]>
			</text>
		</ObjectName>
		<ObjectName id="23" name="Name2">
			<parents>
				20
			</parents>
			<position x="-6.32651005404893" y="1.1941430030963" width="0" height="0">
			</position>
			<text>
				<![CDATA[<font face="Symbol">a</font><sub>2</sub>]]>
			</text>
		</ObjectName>
	</objlist>
</dg:drawing>
