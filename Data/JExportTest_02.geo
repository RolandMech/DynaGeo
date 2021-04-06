<?xml version="1.0" encoding="UTF-8"?>
<dg:drawing xmlns:dg="http://www.dynageo.com/xml/dg12" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.dynageo.com/xml/dg12 http://www.dynageo.com/xml/dg12.xsd">
	<header>
		<created prog_name="EUKLID DynaGeo" prog_version="3.2.0.171" date="2009-02-07T17:48:57">
		</created>
		<edited prog_name="EUKLID DynaGeo" prog_version="3.2.0.171" date="2009-02-08T14:31:14">
		</edited>
	</header>
	<windowdata>
		<log_window xmin="-16.51" xmax="16.0602083333333" ymin="-8.73125000000002" ymax="11.7210416666667">
		</log_window>
		<scr_window width="1231" height="773">
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
			<position x="-7.24374616909448" y="2.5949308506771">
			</position>
			<friends>
				7
			</friends>
		</Point>
		<Point id="7" name="P2">
			<appearance brush_style="0">
			</appearance>
			<position x="-9.97479166666666" y="3.83645833333334">
			</position>
			<friends>
				6
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
			<position x1="-6.85270833333333" y1="5.55625" x2="-7.24374616909448" y2="2.5949308506771">
			</position>
		</Segment>
		<Segment id="16" name="s4">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				6;13
			</parents>
			<position x1="-7.24374616909448" y1="2.5949308506771" x2="1.32291666666667" y2="2.80458333333333">
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
		<PerpBisector id="20" name="g1">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				6;7
			</parents>
			<position x1="-8.60926891788057" y1="3.21569459200522" x2="-9.85079640053681" y2="0.484649094433041">
			</position>
		</PerpBisector>
	</objlist>
</dg:drawing>
