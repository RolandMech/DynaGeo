<?xml version="1.0" encoding="UTF-8"?>
<dg:drawing xmlns:dg="http://www.dynageo.com/xml/dg12" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.dynageo.com/xml/dg12 http://www.dynageo.com/xml/dg12.xsd">
	<header>
		<created prog_name="EUKLID DynaGeo" prog_version="3.2.0.263" date="2009-08-02T12:39:59">
		</created>
		<edited prog_name="EUKLID DynaGeo" prog_version="3.2.0.263" date="2009-08-02T13:09:18">
		</edited>
	</header>
	<windowdata>
		<log_window xmin="-10.9802083333333" xmax="12.1179166666667" ymin="-6.905625" ymax="8.28145833333333">
		</log_window>
		<scr_window width="873" height="574">
		</scr_window>
		<startfont fontname="Arial" fontsize="13" fontcharset="0">
		</startfont>
		<options AreaDecimals="5" DefLocLineStatus="3">
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
		<Point id="6" name="A">
			<appearance brush_style="0">
			</appearance>
			<position x="-7.96395833333332" y="3.730625">
			</position>
		</Point>
		<Point id="7" name="C">
			<appearance brush_style="0">
			</appearance>
			<position x="-3.65125" y="7.381875">
			</position>
		</Point>
		<Point id="8" name="B">
			<appearance brush_style="0">
			</appearance>
			<position x="-1.508125" y="2.69875">
			</position>
		</Point>
		<Segment id="9" name="s1">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				6;7
			</parents>
			<position x1="-7.96395833333332" y1="3.730625" x2="-3.65125" y2="7.381875">
			</position>
		</Segment>
		<Segment id="10" name="s2">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				7;8
			</parents>
			<position x1="-3.65125" y1="7.381875" x2="-1.508125" y2="2.69875">
			</position>
		</Segment>
		<Segment id="11" name="s3">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				8;6
			</parents>
			<position x1="-1.508125" y1="2.69875" x2="-7.96395833333332" y2="3.730625">
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
			<appearance color="$000000FF" pen_style="5" shape="0">
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
				6
			</parents>
			<position x="-8.01687499999999" y="3.59833333333333" width="5.74145833333333" height="1.93145833333333">
			</position>
			<text>
				<![CDATA[A]]>
			</text>
		</ObjectName>
		<ObjectName id="16" name="Name2">
			<parents>
				8
			</parents>
			<position x="-1.48166666666667" y="2.59291666666667" width="5.74145833333333" height="1.93145833333333">
			</position>
			<text>
				<![CDATA[B]]>
			</text>
		</ObjectName>
		<ObjectName id="17" name="Name3">
			<parents>
				7
			</parents>
			<position x="-3.67770833333333" y="8.016875" width="5.74145833333333" height="1.93145833333333">
			</position>
			<text>
				<![CDATA[C]]>
			</text>
		</ObjectName>
		<Angle id="18" name="α">
			<parents>
				8;6;7
			</parents>
			<position x1="-1.508125" y1="2.69875" x2="-7.96395833333332" y2="3.730625" x3="-3.65125" y3="7.381875">
			</position>
			<line radius="2.08735960938427" reversed="false">
			</line>
		</Angle>
		<MeasureAngle id="19" name="w(B;A;C)">
			<appearance pen_style="2">
			</appearance>
			<parents>
				18
			</parents>
			<position x="-6.63695661473621" y="4.10076847399394" width="0" height="0">
			</position>
			<text>
				<![CDATA[]]>
			</text>
			<line x1="-5.34049828140288" y1="4.84160180732728" x2="0" y2="0" dx="1.29645833333333" dy="0.740833333333333">
			</line>
		</MeasureAngle>
		<ObjectName id="20" name="Name4">
			<parents>
				18
			</parents>
			<position x="-6.91862540518892" y="4.59271949260801" width="5.74145833333333" height="1.93145833333333">
			</position>
			<text>
				<![CDATA[<font face="SYMBOL">a</font>]]>
			</text>
		</ObjectName>
		<Term id="21" name="T1" show_name="true" show_term="true" show_format="1">
			<appearance shape="4">
			</appearance>
			<parents>
				19
			</parents>
			<position x="-10.4775" y="7.67291666666667" width="150" height="35">
			</position>
			<value term="w(α)">
			</value>
		</Term>
		<LineWDD id="22" name="g1">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				8;6;21
			</parents>
			<position x1="-7.96395833333332" y1="3.730625" x2="88.359102412973" y2="30.5982257202612">
			</position>
			<term>
				T1/2
			</term>
		</LineWDD>
		<Point id="23" name="P1">
			<appearance brush_style="0">
			</appearance>
			<parents>
				22
			</parents>
			<position x="-0.945084513448298" y="5.68841473215193">
			</position>
		</Point>
		<Angle id="24" name="α2">
			<appearance color="$000000FF">
			</appearance>
			<parents>
				8;6;23
			</parents>
			<position x1="-1.508125" y1="2.69875" x2="-7.96395833333332" y2="3.730625" x3="-0.945084513448298" y3="5.68841473215193">
			</position>
			<line radius="1.27027557774002" reversed="false">
			</line>
		</Angle>
		<MeasureAngle id="25" name="w(B;A;P1)">
			<appearance pen_style="2">
			</appearance>
			<parents>
				24
			</parents>
			<position x="-7.12692666295415" y="3.77818718759154" width="0" height="0">
			</position>
			<text>
				<![CDATA[]]>
			</text>
			<line x1="-6.80942666295415" y1="2.69339552092487" x2="0" y2="0" dx="0.3175" dy="-1.08479166666667">
			</line>
		</MeasureAngle>
		<ObjectName id="26" name="Name5">
			<appearance color="$000000FF">
			</appearance>
			<parents>
				24
			</parents>
			<position x="-7.223125" y="4.15395833333333" width="5.74145833333333" height="1.93145833333333">
			</position>
			<text>
				<![CDATA[<font face="SYMBOL">a</font><sub>2</sub>]]>
			</text>
		</ObjectName>
		<Term id="27" name="T2" show_name="true" show_term="true" show_format="1">
			<appearance shape="4">
			</appearance>
			<parents>
				25
			</parents>
			<position x="-10.4510416666667" y="6.48229166666667" width="150" height="35">
			</position>
			<value term="w(α2)">
			</value>
		</Term>
	</objlist>
</dg:drawing>
