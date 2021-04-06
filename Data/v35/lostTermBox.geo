<?xml version="1.0" encoding="UTF-8"?>
<dg:drawing xmlns:dg="http://www.dynageo.com/xml/dg12" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.dynageo.com/xml/dg12 http://www.dynageo.com/xml/dg12.xsd">
	<header>
		<created prog_name="EUKLID DynaGeo" prog_version="3.5.2.21" date="2010-01-24T11:26:34">
		</created>
		<edited prog_name="EUKLID DynaGeo" prog_version="3.5.2.21" date="2010-01-24T11:27:39">
		</edited>
	</header>
	<windowdata>
		<log_window xmin="-16.4835416666667" xmax="16.51" ymin="-10.6627083333333" ymax="10.6627083333333">
		</log_window>
		<scr_window width="1247" height="806">
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
		<Number id="6" name="Z1" show_name="true">
			<appearance color="$00808080">
			</appearance>
			<position x="-15.954375" y="10.1335416666667" width="250" height="33">
			</position>
			<value min="-3" actual="2.232" max="5" quant="0.001" ani_step="0.001">
			</value>
		</Number>
		<Term id="7" name="T1" show_name="false" show_term="true" show_format="0">
			<appearance shape="4">
			</appearance>
			<parents>
				6
			</parents>
			<position x="-26.3260416666667" y="7.75229166666666" width="150" height="35">
			</position>
			<value term="Z1*2">
			</value>
		</Term>
	</objlist>
</dg:drawing>
