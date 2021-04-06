<?xml version="1.0" encoding="UTF-8"?>
<dg:drawing xmlns:dg="http://www.dynageo.com/xml/dg12" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.dynageo.com/xml/dg12 http://www.dynageo.com/xml/dg12.xsd">
	<header>
		<created prog_name="EUKLID DynaGeo" prog_version="3.1.6.21" date="2009-09-12T14:09:25">
		</created>
		<edited prog_name="EUKLID DynaGeo" prog_version="3.5.0.5" date="2009-11-12T21:50:12">
		</edited>
		<environment>
			<commands>
				797A7B8A897CE6
			</commands>
		</environment>
	</header>
	<windowdata>
		<log_window xmin="-12.699991797922" xmax="5.95312115527594" ymin="-2.69874825705842" ymax="8.73124436107135">
		</log_window>
		<scr_window width="705" height="432">
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
			<position x="-6.64104279445238" y="1.77270872634957">
			</position>
		</Point>
		<Point id="13" name="P5">
			<appearance brush_style="0">
			</appearance>
			<position x="-3.3072927944524" y="1.77270872634957">
			</position>
		</Point>
		<Segment id="15" name="s5">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				13;6
			</parents>
			<position x1="-3.3072927944524" y1="1.77270872634957" x2="-6.64104279445238" y2="1.77270872634957">
			</position>
		</Segment>
		<RegPoly id="18" name="N1">
			<parents>
				6;13
			</parents>
			<position x1="-6.64104279445238" y1="1.77270872634957" x2="-3.3072927944524" y2="1.77270872634957" vcount="5">
			</position>
		</RegPoly>
		<Vertex id="20" name="P2" plist_index="2">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				18
			</parents>
			<position x="-2.27710738945493" y="4.94329338754852">
			</position>
		</Vertex>
		<Segment id="21" name="s1">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				13;20
			</parents>
			<position x1="-3.3072927944524" y1="1.77270872634957" x2="-2.27710738945493" y2="4.94329338754852">
			</position>
		</Segment>
		<Vertex id="22" name="P3" plist_index="3">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				18
			</parents>
			<position x="-4.97416779445239" y="6.90282247237854">
			</position>
		</Vertex>
		<Segment id="23" name="s2">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				20;22
			</parents>
			<position x1="-2.27710738945493" y1="4.94329338754852" x2="-4.97416779445239" y2="6.90282247237854">
			</position>
		</Segment>
		<Vertex id="24" name="P4" plist_index="4">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				18
			</parents>
			<position x="-7.67122819944985" y="4.94329338754852">
			</position>
		</Vertex>
		<Segment id="25" name="s3">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				22;24
			</parents>
			<position x1="-4.97416779445239" y1="6.90282247237854" x2="-7.67122819944985" y2="4.94329338754852">
			</position>
		</Segment>
		<Segment id="26" name="s4">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				24;6
			</parents>
			<position x1="-7.67122819944985" y1="4.94329338754852" x2="-6.64104279445238" y2="1.77270872634957">
			</position>
		</Segment>
		<Area id="27" name="F_1">
			<appearance color="$000000FF" brush_style="2">
			</appearance>
			<parents>
				18
			</parents>
			<orientation>
				true
			</orientation>
		</Area>
	</objlist>
</dg:drawing>
