<?xml version="1.0" encoding="UTF-8"?>
<dg:drawing xmlns:dg="http://www.dynageo.com/xml/dg12" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.dynageo.com/xml/dg12 http://www.dynageo.com/xml/dg12.xsd">
	<header>
		<created prog_name="EUKLID DynaGeo" prog_version="3.1.3.1" date="2008-08-05T09:36:57">
		</created>
		<edited prog_name="EUKLID DynaGeo" prog_version="3.2.0.31" date="2008-08-08T14:28:19">
		</edited>
	</header>
	<windowdata>
		<log_window xmin="-13.2291666666667" xmax="12.0120833333333" ymin="-7.03791666666668" ymax="9.97479166666668">
		</log_window>
		<scr_window width="954" height="643">
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
			<position x="-7.3025" y="4.07458333333333">
			</position>
		</Point>
		<Point id="7" name="P2">
			<appearance brush_style="0">
			</appearance>
			<position x="-6.58812500000001" y="7.30250000000001">
			</position>
		</Point>
		<Segment id="8" name="a">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				6;7
			</parents>
			<position x1="-7.3025" y1="4.07458333333333" x2="-6.58812500000001" y2="7.30250000000001">
			</position>
		</Segment>
		<Point id="9" name="P3">
			<appearance brush_style="0">
			</appearance>
			<position x="-2.91041666666667" y="4.07458333333333">
			</position>
		</Point>
		<Segment id="10" name="b">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				6;9
			</parents>
			<position x1="-7.3025" y1="4.07458333333333" x2="-2.91041666666667" y2="4.07458333333333">
			</position>
		</Segment>
		<Angle id="11" name="α">
			<parents>
				9;6;7
			</parents>
			<position x1="-2.91041666666667" y1="4.07458333333333" x2="-7.3025" y2="4.07458333333333" x3="-6.58812500000001" y3="7.30250000000001">
			</position>
			<line radius="1.14047386746085" reversed="false">
			</line>
		</Angle>
		<MeasureAngle id="12" name="w(P3;P1;P2)">
			<appearance pen_style="2">
			</appearance>
			<parents>
				11
			</parents>
			<position x="-6.71555705967865" y="4.54583111594819" width="0" height="0">
			</position>
			<text>
				<![CDATA[]]>
			</text>
			<line x1="-5.71555705967865" y1="5.04583111594819" x2="0" y2="0" dx="1" dy="0.5">
			</line>
		</MeasureAngle>
		<ObjectName id="13" name="Name1">
			<parents>
				11
			</parents>
			<position x="-6.99581232260885" y="4.81165604568495" width="5.74145833333334" height="1.93145833333334">
			</position>
			<text>
				<![CDATA[<font face="Symbol">a</font>]]>
			</text>
		</ObjectName>
		<ObjectName id="14" name="Name2">
			<parents>
				8
			</parents>
			<position x="-7.49502585641392" y="5.98991512793179" width="5.74145833333334" height="1.93145833333334">
			</position>
			<text>
				<![CDATA[a]]>
			</text>
		</ObjectName>
		<ObjectName id="15" name="Name3">
			<parents>
				10
			</parents>
			<position x="-5.28887712992545" y="3.91406798914827" width="5.74145833333334" height="1.93145833333334">
			</position>
			<text>
				<![CDATA[b]]>
			</text>
		</ObjectName>
		<Point id="16" name="P4">
			<appearance brush_style="0">
			</appearance>
			<position x="-10.239375" y="6.05895833333333">
			</position>
		</Point>
		<CircleWDR id="17" name="k1">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				16;12
			</parents>
			<position x1="-10.239375" y1="6.05895833333333" x2="-9.37803135335475" y2="6.05895833333333">
			</position>
			<radius r_term="w(α)/90">
			</radius>
		</CircleWDR>
		<Term id="18" name="T1" show_name="false" show_term="true">
			<appearance shape="4">
			</appearance>
			<parents>
				12
			</parents>
			<position x="-12.3560416666667" y="9.31333333333333" width="150" height="35">
			</position>
			<value term="w(α)*2">
			</value>
		</Term>
		<PointWDC id="19" name="P5">
			<appearance shape="6" add_data2name="true">
			</appearance>
			<parents>
				1;12
			</parents>
			<position x="0.86134364664525" y="1.7226872932905" x_term="w(α)/90" y_term="w(α)/45">
			</position>
		</PointWDC>
		<ObjectName id="20" name="Name4">
			<parents>
				19
			</parents>
			<position x="1.10959504066357" y="1.98106508132714" width="5.74145833333334" height="1.93145833333334">
			</position>
			<text>
				<![CDATA[P<sub>5</sub>]]>
			</text>
		</ObjectName>
		<Graph id="21" name="F1" trace_status="11" term="w(α)/( pi/2 )*x - 3">
			<appearance color="$000000FF" add_data2name="true">
			</appearance>
			<parents>
				12
			</parents>
			<points>
				-15.7532916666667;-16.5689976908329;-15.7532916666667 
				-14.9561995614035;-15.8824274701734;-14.9561995614035 
				-14.1591074561404;-15.1958572495139;-14.1591074561404 
				-13.3620153508772;-14.5092870288544;-13.3620153508772 
				-12.564923245614;-13.8227168081949;-12.564923245614 
				-11.7678311403509;-13.1361465875354;-11.7678311403509 
				-10.9707390350877;-12.4495763668759;-10.9707390350877 
				-10.1736469298246;-11.7630061462164;-10.1736469298246 
				-9.37655482456141;-11.0764359255568;-9.37655482456141 
				-8.57946271929825;-10.3898657048973;-8.57946271929825 
				-7.78237061403509;-9.70329548423782;-7.78237061403509 
				-6.98527850877193;-9.01672526357831;-6.98527850877193 
				-6.18818640350877;-8.3301550429188;-6.18818640350877 
				-5.39109429824561;-7.6435848222593;-5.39109429824561 
				-4.59400219298245;-6.95701460159979;-4.59400219298245 
				-3.7969100877193;-6.27044438094028;-3.7969100877193 
				-2.99981798245614;-5.58387416028077;-2.99981798245614 
				-2.20272587719298;-4.89730393962126;-2.20272587719298 
				-1.40563377192982;-4.21073371896175;-1.40563377192982 
				-0.608541666666661;-3.52416349830224;-0.608541666666661 
				0.188550438596498;-2.83759327764273;0.188550438596498 
				0.985642543859657;-2.15102305698322;0.985642543859657 
				1.78273464912282;-1.46445283632371;1.78273464912282 
				2.57982675438597;-0.777882615664204;2.57982675438597 
				3.37691885964913;-0.0913123950046946;3.37691885964913 
				4.17401096491229;0.595257825654814;4.17401096491229 
				4.97110307017545;1.28182804631432;4.97110307017545 
				5.76819517543861;1.96839826697383;5.76819517543861 
				6.56528728070177;2.65496848763334;6.56528728070177 
				7.36237938596493;3.34153870829285;7.36237938596493 
				8.15947149122809;4.02810892895236;8.15947149122809 
				8.95656359649125;4.71467914961187;8.95656359649125 
				9.75365570175441;5.40124937027138;9.75365570175441 
				10.5507478070176;6.08781959093089;10.5507478070176 
				11.3478399122807;6.7743898115904;11.3478399122807 
				12.1449320175439;7.46096003224991;12.1449320175439 
				12.942024122807;8.14753025290942;12.942024122807 
				13.7391162280702;8.83410047356893;13.7391162280702 
				14.5362083333333;9.52067069422843;14.5362083333333
			</points>
		</Graph>
		<ObjectName id="22" name="Name5">
			<appearance color="$000000FF">
			</appearance>
			<parents>
				21
			</parents>
			<position x="2.98955600539811" y="-0.717017372056285" width="5.74145833333334" height="1.93145833333334">
			</position>
			<text>
				<![CDATA[F<sub>1</sub>]]>
			</text>
		</ObjectName>
	</objlist>
</dg:drawing>
