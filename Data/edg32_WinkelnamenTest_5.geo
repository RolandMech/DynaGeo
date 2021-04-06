<?xml version="1.0" encoding="UTF-8"?>
<dg:drawing xmlns:dg="http://www.dynageo.com/xml/dg12" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.dynageo.com/xml/dg12 http://www.dynageo.com/xml/dg12.xsd">
	<header>
		<created prog_name="EUKLID DynaGeo" prog_version="3.2.0.143" date="2008-10-15T08:14:34">
		</created>
		<edited prog_name="EUKLID DynaGeo" prog_version="3.2.0.143" date="2008-10-15T08:14:34">
		</edited>
	</header>
	<windowdata>
		<log_window xmin="-16.113125" xmax="16.1395833333333" ymin="-8.38729166666667" ymax="8.36083333333333">
		</log_window>
		<scr_window width="1219" height="633">
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
		<Point id="7" name="P2">
			<appearance brush_style="0">
			</appearance>
			<position x="-5.10645833333333" y="1.5875">
			</position>
		</Point>
		<Point id="8" name="P3">
			<appearance brush_style="0">
			</appearance>
			<position x="1.48166666666667" y="2.51354166666667">
			</position>
		</Point>
		<Segment id="10" name="s2">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				7;8
			</parents>
			<position x1="-5.10645833333333" y1="1.5875" x2="1.48166666666667" y2="2.51354166666667">
			</position>
		</Segment>
		<MidPoint id="24" name="P4">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				7;8
			</parents>
			<position x="-1.81239583333333" y="2.05052083333333">
			</position>
		</MidPoint>
		<Circle id="25" name="k1">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				24;8
			</parents>
			<position x1="-1.81239583333333" y1="2.05052083333333" x2="1.48166666666667" y2="2.51354166666667">
			</position>
			<radius>
				3.32644495610659
			</radius>
		</Circle>
		<Point id="6" name="P1">
			<appearance brush_style="0">
			</appearance>
			<parents>
				25
			</parents>
			<position x="-1.66036457487284" y="5.37348976825552">
			</position>
		</Point>
		<Angle id="19" name="α2">
			<parents>
				6;8;7
			</parents>
			<position x1="-1.66036457487284" y1="5.37348976825552" x2="1.48166666666667" y2="2.51354166666667" x3="-5.10645833333333" y3="1.5875">
			</position>
			<line radius="1.18325263809364" reversed="false">
			</line>
		</Angle>
		<MeasureAngle id="20" name="w(P1;P3;P2)">
			<appearance pen_style="2">
			</appearance>
			<parents>
				19
			</parents>
			<position x="0.735459918002234" y="2.74387468806754" width="0" height="0">
			</position>
			<text>
				<![CDATA[]]>
			</text>
			<line x1="1.73545991800223" y1="3.24387468806754" x2="0" y2="0" dx="1" dy="0.5">
			</line>
		</MeasureAngle>
		<Angle id="15" name="α1">
			<parents>
				8;7;6
			</parents>
			<position x1="1.48166666666667" y1="2.51354166666667" x2="-5.10645833333333" y2="1.5875" x3="-1.66036457487284" y3="5.37348976825552">
			</position>
			<line radius="1.26806927893572" reversed="false">
			</line>
		</Angle>
		<ObjectName id="18" name="Name1">
			<parents>
				15
			</parents>
			<position x="-4.61645356028439" y="2.32764537323267" width="5.74145833333333" height="1.93145833333333">
			</position>
			<text>
				<![CDATA[<font face="SYMBOL">a</font><sub>1</sub>]]>
			</text>
		</ObjectName>
		<MeasureAngle id="16" name="w(P3;P2;P1)">
			<appearance pen_style="2">
			</appearance>
			<parents>
				15
			</parents>
			<position x="-4.36644348009953" y="1.97842542082806" width="0" height="0">
			</position>
			<text>
				<![CDATA[]]>
			</text>
			<line x1="-3.36644348009953" y1="2.47842542082806" x2="0" y2="0" dx="1" dy="0.5">
			</line>
		</MeasureAngle>
		<Term id="21" name="T2" show_name="false" show_term="true">
			<appearance shape="4">
			</appearance>
			<parents>
				16;20
			</parents>
			<position x="-15.5839583333333" y="6.64104166666667" width="150" height="35">
			</position>
			<value term="w(α1) + w(α2)">
			</value>
		</Term>
		<Term id="17" name="T1" show_name="false" show_term="true">
			<appearance shape="4">
			</appearance>
			<parents>
				16
			</parents>
			<position x="-15.5839583333333" y="7.83166666666667" width="150" height="35">
			</position>
			<value term="w(α1)">
			</value>
		</Term>
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
		<Segment id="11" name="s3">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				8;6
			</parents>
			<position x1="1.48166666666667" y1="2.51354166666667" x2="-1.66036457487284" y2="5.37348976825552">
			</position>
		</Segment>
		<Segment id="9" name="s1">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				6;7
			</parents>
			<position x1="-1.66036457487284" y1="5.37348976825552" x2="-5.10645833333333" y2="1.5875">
			</position>
		</Segment>
		<ObjectName id="26" name="Name2">
			<parents>
				19
			</parents>
			<position x="0.549664777811954" y="3.09873186307874" width="5.74145833333333" height="1.93145833333333">
			</position>
			<text>
				<![CDATA[<font face="SYMBOL">a</font><sub>2</sub>]]>
			</text>
		</ObjectName>
	</objlist>
</dg:drawing>
