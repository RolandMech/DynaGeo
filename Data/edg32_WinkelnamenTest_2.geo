<?xml version="1.0" encoding="UTF-8"?>
<dg:drawing xmlns:dg="http://www.dynageo.com/xml/dg12" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.dynageo.com/xml/dg12 http://www.dynageo.com/xml/dg12.xsd">
	<header>
		<created prog_name="EUKLID DynaGeo" prog_version="3.1.3.1" date="2008-08-05T09:36:57">
		</created>
		<edited prog_name="EUKLID DynaGeo" prog_version="3.2.0.64" date="2008-08-10T20:37:40">
		</edited>
	</header>
	<windowdata>
		<log_window xmin="-13.2291666666667" xmax="16.906875" ymin="-9.49854166666668" ymax="9.97479166666668">
		</log_window>
		<scr_window width="1139" height="736">
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
			<position x="-5.68854166666667" y="6.87916666666668">
			</position>
		</Point>
		<Segment id="8" name="a">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				6;7
			</parents>
			<position x1="-7.3025" y1="4.07458333333333" x2="-5.68854166666667" y2="6.87916666666668">
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
			<position x1="-2.91041666666667" y1="4.07458333333333" x2="-7.3025" y2="4.07458333333333" x3="-5.68854166666667" y3="6.87916666666668">
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
			<position x="-6.65089714179827" y="4.45139920746263" width="0" height="0">
			</position>
			<text>
				<![CDATA[]]>
			</text>
			<line x1="-5.65089714179827" y1="4.95139920746263" x2="0" y2="0" dx="1" dy="0.5">
			</line>
		</MeasureAngle>
		<ObjectName id="13" name="Name1">
			<parents>
				11
			</parents>
			<position x="-6.88761195975954" y="4.75664009696989" width="5.74145833333333" height="1.93145833333334">
			</position>
			<text>
				<![CDATA[<font face="Symbol">a</font>]]>
			</text>
		</ObjectName>
		<ObjectName id="14" name="Name2">
			<parents>
				8
			</parents>
			<position x="-6.93149818114641" y="5.92591934440354" width="5.74145833333333" height="1.93145833333334">
			</position>
			<text>
				<![CDATA[a]]>
			</text>
		</ObjectName>
		<ObjectName id="15" name="Name3">
			<parents>
				10
			</parents>
			<position x="-5.28887712992545" y="3.91406798914827" width="5.74145833333333" height="1.93145833333334">
			</position>
			<text>
				<![CDATA[b]]>
			</text>
		</ObjectName>
		<Point id="16" name="P4">
			<appearance brush_style="0">
			</appearance>
			<position x="-10.16" y="5.79437500000001">
			</position>
		</Point>
		<CircleWDR id="17" name="k1">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				16;12
			</parents>
			<position x1="-10.16" y1="5.79437500000001" x2="-9.15865347814262" y2="5.79437500000001">
			</position>
			<radius r_term="w(α)/60">
			</radius>
		</CircleWDR>
		<Term id="18" name="T1" show_name="false" show_term="true">
			<appearance shape="4">
			</appearance>
			<parents>
				12
			</parents>
			<position x="-12.3560416666667" y="9.31333333333335" width="150" height="35">
			</position>
			<value term="w(α)*2.5">
			</value>
		</Term>
		<PointWDC id="19" name="P5">
			<appearance shape="6" add_data2name="true">
			</appearance>
			<parents>
				1;12
			</parents>
			<position x="0.667564347904918" y="1.33512869580984" x_term="w(α)/90" y_term="w(α)/45">
			</position>
		</PointWDC>
		<ObjectName id="20" name="Name4">
			<parents>
				19
			</parents>
			<position x="0.962227165150285" y="1.36882933030057" width="5.74145833333333" height="1.93145833333334">
			</position>
			<text>
				<![CDATA[P<sub>5</sub>]]>
			</text>
		</ObjectName>
		<Graph id="21" name="F1" trace_status="11" term="w(α)/(pi/2)*x-3">
			<appearance color="$000000FF" add_data2name="true">
			</appearance>
			<parents>
				12
			</parents>
			<points>
				-16.2427708333333;-13.8430947195232;-16.2427708333333 
				-15.2911063596491;-13.2077974457239;-15.2911063596491 
				-14.3394418859649;-12.5725001719246;-14.3394418859649 
				-13.3877774122807;-11.9372028981254;-13.3877774122807 
				-12.4361129385965;-11.3019056243261;-12.4361129385965 
				-11.4844484649123;-10.6666083505268;-11.4844484649123 
				-10.5327839912281;-10.0313110767275;-10.5327839912281 
				-9.58111951754385;-9.39601380292824;-9.58111951754385 
				-8.62945504385964;-8.76071652912897;-8.62945504385964 
				-7.67779057017543;-8.12541925532969;-7.67779057017543 
				-6.72612609649122;-7.49012198153041;-6.72612609649122 
				-5.77446162280701;-6.85482470773114;-5.77446162280701 
				-4.8227971491228;-6.21952743393186;-4.8227971491228 
				-3.87113267543859;-5.58423016013258;-3.87113267543859 
				-2.91946820175438;-4.94893288633331;-2.91946820175438 
				-1.96780372807017;-4.31363561253403;-1.96780372807017 
				-1.01613925438596;-3.67833833873475;-1.01613925438596 
				-0.0644747807017497;-3.04304106493548;-0.0644747807017497 
				0.887189692982461;-2.4077437911362;0.887189692982461 
				1.83885416666667;-1.77244651733692;1.83885416666667 
				2.79051864035088;-1.13714924353765;2.79051864035088 
				3.74218311403509;-0.501851969738369;3.74218311403509 
				4.6938475877193;0.133445304060908;4.6938475877193 
				5.64551206140351;0.768742577860184;5.64551206140351 
				6.59717653508772;1.40403985165946;6.59717653508772 
				7.54884100877193;2.03933712545874;7.54884100877193 
				8.50050548245614;2.67463439925801;8.50050548245614 
				9.45216995614035;3.30993167305729;9.45216995614035 
				10.4038344298246;3.94522894685657;10.4038344298246 
				11.3554989035088;4.58052622065585;11.3554989035088 
				12.307163377193;5.21582349445512;12.307163377193 
				13.2588278508772;5.8511207682544;13.2588278508772 
				14.2104923245614;6.48641804205368;14.2104923245614 
				15.1621567982456;7.12171531585295;15.1621567982456 
				16.1138212719298;7.75701258965223;16.1138212719298 
				17.065485745614;8.39230986345151;17.065485745614 
				18.0171502192983;9.02760713725078;18.0171502192983 
				18.9688146929825;9.66290441105006;18.9688146929825 
				19.9204791666667;10.2982016848493;19.9204791666667
			</points>
		</Graph>
		<ObjectName id="22" name="Name5">
			<appearance color="$000000FF">
			</appearance>
			<parents>
				21
			</parents>
			<position x="3.889375" y="-1.46610440362497" width="5.74145833333333" height="1.93145833333334">
			</position>
			<text>
				<![CDATA[F<sub>1</sub>]]>
			</text>
		</ObjectName>
		<Trace id="23" name="OL1" trace_status="2">
			<appearance line_width="3">
			</appearance>
			<parents>
				7;11;12;19
			</parents>
			<points>
				0.601060154131222;1.20212030826244;0 
				0.731539508130202;1.4630790162604;0 
				0.859704293715423;1.71940858743085;0 
				0.992658483522036;1.98531696704407;0 
				1.13169323731956;2.26338647463911;0 
				1.30565535313866;2.61131070627732;0 
				1.49977049211061;2.99954098422123;0 
				1.62795447886592;3.25590895773184;0 
				1.81631058085957;3.63262116171914;0 
				1.99859264638655;3.99718529277311;0 
				2.20415264930585;4.40830529861171;0 
				2.33691196835217;4.67382393670434;0 
				2.48548041947476;4.97096083894951;0 
				2.6394913063543;5.27898261270861;0 
				2.83062770363667;5.66125540727333;0 
				2.99418068850675;5.9883613770135;0 
				3.12620313078365;6.2524062615673;0 
				3.25942359068046;6.51884718136092;0 
				3.39545721302021;6.79091442604042;0 
				3.51449929831291;7.02899859662582;0 
				3.6329693373086;7.2659386746172;0 
				3.76204695665092;7.52409391330184;0 
				3.89091693845951;7.78183387691902;0 
				4.02324700006907;8.04649400013815;0 
				4.1613055938281;8.32261118765621;0 
				4.28241358708628;8.56482717417255;0 
				4.4058117034584;8.8116234069168;0 
				0.0192479786077966;0.0384959572155931;0 
				0.145984804100757;0.291969608201514;0 
				0.282432388957935;0.56486477791587;0 
				0.407886730925933;0.815773461851866;0 
				0.530548124017773;1.06109624803555;0 
				0.671827028281942;1.34365405656388;0
			</points>
		</Trace>
	</objlist>
</dg:drawing>
