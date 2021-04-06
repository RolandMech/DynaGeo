<?xml version="1.0" encoding="UTF-8"?>
<dg:drawing xmlns:dg="http://www.dynageo.com/xml/dg12" 
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xsi:schemaLocation="http://www.dynageo.com/xml/dg12 http://www.dynageo.com/xml/dg12.xsd">
	<header>
		<created prog_name="EUKLID DynaGeo" prog_version="2.6">
		</created>
		<edited prog_name="EUKLID DynaGeo" prog_version="3.0.6.3" 
			date="2008-04-02T08:39:28">
		</edited>
	</header>
	<windowdata>
		<log_window xmin="-9.63083333333332" xmax="24.2358333333333" 
			ymin="-17.1185416666667" ymax="6.50875">
		</log_window>
		<scr_window width="1280" height="893">
		</scr_window>
		<startfont fontname="Arial" fontsize="12" fontcharset="0">
		</startfont>
		<options AreaDecimals="5" DefLocLineStatus="7">
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
			<appearance color="$00C0C0C0" shape="0" 
				brush_style="0">
			</appearance>
			<parents>
				1
			</parents>
			<position x1="0" y1="0" x2="1" y2="0">
			</position>
		</Axis>
		<Axis id="3" name="ya" label="y">
			<appearance color="$00C0C0C0" shape="0" 
				brush_style="0">
			</appearance>
			<parents>
				1
			</parents>
			<position x1="0" y1="0" x2="0" y2="-1">
			</position>
		</Axis>
		<UnityPoint id="4" name="X_1">
			<appearance color="$00C0C0C0" brush_style="0" 
				visible="false">
			</appearance>
			<parents>
				2
			</parents>
			<position x="1" y="0">
			</position>
		</UnityPoint>
		<UnityPoint id="5" name="Y_1">
			<appearance color="$00C0C0C0" brush_style="0" 
				visible="false">
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
			<position x="-6.29708333333333" y="0.502708333333333">
			</position>
		</Point>
		<Point id="7" name="P2">
			<appearance brush_style="0">
			</appearance>
			<position x="-0.714375" y="2.778125">
			</position>
		</Point>
		<Segment id="8" name="s1">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				6;7
			</parents>
			<position x1="-6.29708333333333" y1="0.502708333333333" 
				x2="-0.714375" y2="2.778125">
			</position>
		</Segment>
		<MidPoint id="9" name="M">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				6;7
			</parents>
			<position x="-3.50572916666667" y="1.64041666666667">
			</position>
		</MidPoint>
		<Circle id="10" name="k1">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				9;7
			</parents>
			<position x1="-3.50572916666667" y1="1.64041666666667" 
				x2="-0.714375" y2="2.778125">
			</position>
			<radius>
				3.0143056141512
			</radius>
		</Circle>
		<ObjectName id="11" name="dummy1">
			<parents>
				9
			</parents>
			<position x="-3.36020833333333" y="1.49489583333334" 
				width="5.74145833333333" height="1.93145833333333">
			</position>
			<text>
				<![CDATA[M]]>
			</text>
		</ObjectName>
	</objlist>
</dg:drawing>
