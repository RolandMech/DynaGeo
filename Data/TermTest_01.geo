<?xml version="1.0" encoding="UTF-8"?>
<dg:drawing xmlns:dg="http://www.dynageo.com/xml/dg12" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.dynageo.com/xml/dg12 http://www.dynageo.com/xml/dg12.xsd">
	<header>
		<created prog_name="EUKLID DynaGeo" prog_version="3.2.0.156" date="2009-01-07T11:21:41">
		</created>
		<edited prog_name="EUKLID DynaGeo" prog_version="3.2.0.156" date="2009-01-07T11:21:41">
		</edited>
	</header>
	<windowdata>
		<log_window xmin="-13.5995833333333" xmax="13.5995833333333" ymin="-9.89541666666667" ymax="9.89541666666667">
		</log_window>
		<scr_window width="1028" height="748">
		</scr_window>
		<startfont fontname="Arial" fontsize="13" fontcharset="0">
		</startfont>
		<options LengthDecimals="1" AreaDecimals="5" AngleDecimals="1" SignedAngles="false" DefLocLineStatus="3">
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
		<Number id="6" name="Z1" show_name="true">
			<appearance color="$00808080">
			</appearance>
			<position x="-13.0704166666667" y="9.36625" width="250" height="33">
			</position>
			<value min="-3" actual="2.131" max="5" quant="0.001" ani_step="0.001">
			</value>
		</Number>
		<Number id="7" name="Z2" show_name="true">
			<appearance color="$00808080">
			</appearance>
			<position x="-13.0704166666667" y="8.22854166666667" width="250" height="33">
			</position>
			<value min="-3" actual="2.975" max="5" quant="0.001" ani_step="0.001">
			</value>
		</Number>
		<Term id="8" name="T1" show_name="false" show_term="true">
			<appearance shape="4">
			</appearance>
			<parents>
				6;7
			</parents>
			<position x="-13.0704166666667" y="7.09083333333333" width="150" height="35">
			</position>
			<value term="Z1 + Z2">
			</value>
		</Term>
	</objlist>
</dg:drawing>
