<?xml version="1.0" encoding="UTF-8"?>
<dg:drawing xmlns:dg="http://www.dynageo.com/xml/dg12" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.dynageo.com/xml/dg12 http://www.dynageo.com/xml/dg12.xsd">
	<header>
		<created prog_name="EUKLID DynaGeo" prog_version="3.2.0.171" date="2009-02-07T17:48:57">
		</created>
		<edited prog_name="EUKLID DynaGeo" prog_version="3.2.0.175" date="2009-02-13T14:40:27">
		</edited>
	</header>
	<windowdata>
		<log_window xmin="-16.0866562773678" xmax="16.4835310210529" ymin="-9.60436879717848" ymax="10.847909660725">
		</log_window>
		<scr_window width="1231" height="773">
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
		<Point id="6" name="P1">
			<appearance brush_style="0">
			</appearance>
			<position x="-7.40832854878781" y="2.59291499207573">
			</position>
			<friends>
				13381576;22
			</friends>
		</Point>
		<Point id="9" name="P3">
			<appearance brush_style="0">
			</appearance>
			<position x="-6.85270833333333" y="5.55625">
			</position>
		</Point>
		<Point id="10" name="P4">
			<appearance brush_style="0">
			</appearance>
			<position x="-1.95791666666667" y="4.57729166666667">
			</position>
		</Point>
		<Circle id="11" name="k1">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				9;10
			</parents>
			<position x1="-6.85270833333333" y1="5.55625" x2="-1.95791666666667" y2="4.57729166666667">
			</position>
			<radius>
				4.99172764466093
			</radius>
		</Circle>
		<CircleWDR id="12" name="k2">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				10
			</parents>
			<position x1="-1.95791666666667" y1="4.57729166666667" x2="0.54208333333333" y2="4.57729166666667">
			</position>
			<radius r_term="2.5">
			</radius>
		</CircleWDR>
		<Point id="13" name="P5">
			<appearance brush_style="0">
			</appearance>
			<position x="1.32291666666667" y="2.80458333333333">
			</position>
		</Point>
		<Segment id="14" name="s2">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				13;9
			</parents>
			<position x1="1.32291666666667" y1="2.80458333333333" x2="-6.85270833333333" y2="5.55625">
			</position>
		</Segment>
		<Segment id="15" name="s3">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				9;6
			</parents>
			<position x1="-6.85270833333333" y1="5.55625" x2="-7.40832854878781" y2="2.59291499207573">
			</position>
		</Segment>
		<Segment id="16" name="s4">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				6;13
			</parents>
			<position x1="-7.40832854878781" y1="2.59291499207573" x2="1.32291666666667" y2="2.80458333333333">
			</position>
		</Segment>
		<Polygon id="18" name="N1">
			<parents>
				13;9;6
			</parents>
			<position x1="0" y1="0" x2="0" y2="0">
			</position>
		</Polygon>
		<Area id="19" name="F_1">
			<appearance color="$000000FF" brush_style="2">
			</appearance>
			<parents>
				18
			</parents>
			<orientation>
				true
			</orientation>
		</Area>
		<Point id="22" name="P6">
			<appearance brush_style="0">
			</appearance>
			<position x="-10.2031571593143" y="3.6832970525402">
			</position>
			<friends>
				6
			</friends>
		</Point>
		<PerpBisector id="24" name="g1">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				6;22
			</parents>
			<position x1="-8.80574285405104" y1="3.13810602230797" x2="-9.89612491451551" y2="0.343277411781507">
			</position>
		</PerpBisector>
	</objlist>
</dg:drawing>
