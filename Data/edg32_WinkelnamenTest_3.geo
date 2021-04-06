<?xml version="1.0" encoding="UTF-8"?>
<dg:drawing xmlns:dg="http://www.dynageo.com/xml/dg12" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.dynageo.com/xml/dg12 http://www.dynageo.com/xml/dg12.xsd">
	<header>
		<created prog_name="EUKLID DynaGeo" prog_version="3.1.3.1" date="2008-08-05T09:36:57">
		</created>
		<edited prog_name="EUKLID DynaGeo" prog_version="3.2.0.73" date="2008-08-11T13:13:51">
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
			<position x="-5.66208333333334" y="8.51958333333335">
			</position>
		</Point>
		<Segment id="8" name="a">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				6;7
			</parents>
			<position x1="-7.3025" y1="4.07458333333333" x2="-5.66208333333334" y2="8.51958333333335">
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
			<position x1="-2.91041666666667" y1="4.07458333333333" x2="-7.3025" y2="4.07458333333333" x3="-5.66208333333334" y3="8.51958333333335">
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
			<position x="-6.68494910110212" y="4.50494059780429" width="0" height="0">
			</position>
			<text>
				<![CDATA[]]>
			</text>
			<line x1="-5.68494910110212" y1="5.00494059780429" x2="0" y2="0" dx="1" dy="0.5">
			</line>
		</MeasureAngle>
		<ObjectName id="13" name="Name1">
			<parents>
				11
			</parents>
			<position x="-6.94653129447136" y="4.78915998803261" width="5.74145833333334" height="1.93145833333334">
			</position>
			<text>
				<![CDATA[<font face="Symbol">a</font>]]>
			</text>
		</ObjectName>
		<ObjectName id="14" name="Name2">
			<parents>
				8
			</parents>
			<position x="-6.95985033771831" y="6.74137892655072" width="5.74145833333334" height="1.93145833333334">
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
			<position x="-10.080625" y="3.96875000000001">
			</position>
		</Point>
		<CircleWDR id="17" name="k1">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				16;12
			</parents>
			<position x1="-10.080625" y1="3.96875000000001" x2="-8.53076860387829" y2="3.96875000000001">
			</position>
			<radius r_term="w(α)/45">
			</radius>
		</CircleWDR>
		<Term id="18" name="Tabc1" show_name="true" show_term="true">
			<appearance shape="4">
			</appearance>
			<parents>
				12
			</parents>
			<position x="-12.2766666666667" y="9.33979166666668" width="150" height="35">
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
			<position x="0.996336254649672" y="1.54985639612171" x_term="w(α)/70" y_term="w(α)/45">
			</position>
		</PointWDC>
		<ObjectName id="20" name="Name4">
			<parents>
				19
			</parents>
			<position x="1.29099907189504" y="1.58355703061244" width="5.74145833333334" height="1.93145833333334">
			</position>
			<text>
				<![CDATA[P<sub>5</sub>]]>
			</text>
		</ObjectName>
		<Graph id="21" name="F1" trace_status="11" term="w(α)/( pi/3 )*x - 5">
			<appearance color="$000000FF" add_data2name="true">
			</appearance>
			<parents>
				12
			</parents>
			<points>
				-16.2427708333333;-23.8804717000857;-16.2427708333333 
				-15.2911063596491;-22.7742642464597;-15.2911063596491 
				-14.3394418859649;-21.6680567928337;-14.3394418859649 
				-13.3877774122807;-20.5618493392078;-13.3877774122807 
				-12.4361129385965;-19.4556418855818;-12.4361129385965 
				-11.4844484649123;-18.3494344319559;-11.4844484649123 
				-10.5327839912281;-17.2432269783299;-10.5327839912281 
				-9.58111951754387;-16.137019524704;-9.58111951754387 
				-8.62945504385966;-15.030812071078;-8.62945504385966 
				-7.67779057017545;-13.924604617452;-7.67779057017545 
				-6.72612609649124;-12.8183971638261;-6.72612609649124 
				-5.77446162280703;-11.7121897102001;-5.77446162280703 
				-4.82279714912282;-10.6059822565742;-4.82279714912282 
				-3.87113267543861;-9.49977480294821;-3.87113267543861 
				-2.91946820175439;-8.39356734932225;-2.91946820175439 
				-1.96780372807018;-7.28735989569629;-1.96780372807018 
				-1.01613925438597;-6.18115244207033;-1.01613925438597 
				-0.0644747807017594;-5.07494498844437;-0.0644747807017594 
				0.887189692982452;-3.96873753481842;0.887189692982452 
				1.83885416666666;-2.86253008119246;1.83885416666666 
				2.79051864035088;-1.7563226275665;2.79051864035088 
				3.74218311403509;-0.650115173940542;3.74218311403509 
				4.6938475877193;0.456092279685416;4.6938475877193 
				5.64551206140351;1.56229973331138;5.64551206140351 
				6.59717653508772;2.66850718693733;6.59717653508772 
				7.54884100877193;3.77471464056329;7.54884100877193 
				8.50050548245614;4.88092209418925;8.50050548245614 
				9.45216995614035;5.98712954781521;9.45216995614035 
				10.4038344298246;7.09333700144116;10.4038344298246 
				11.3554989035088;8.19954445506712;11.3554989035088 
				12.307163377193;9.30575190869308;12.307163377193 
				13.2588278508772;10.411959362319;13.2588278508772 
				14.2104923245614;11.518166815945;14.2104923245614 
				15.1621567982456;12.624374269571;15.1621567982456 
				16.1138212719298;13.7305817231969;16.1138212719298 
				17.065485745614;14.8367891768229;17.065485745614 
				18.0171502192983;15.9429966304488;18.0171502192983 
				18.9688146929825;17.0492040840748;18.9688146929825 
				19.9204791666667;18.1554115377008;19.9204791666667
			</points>
		</Graph>
		<ObjectName id="22" name="Name5">
			<appearance color="$000000FF">
			</appearance>
			<parents>
				21
			</parents>
			<position x="3.65125" y="-1.08479166666667" width="5.74145833333334" height="1.93145833333334">
			</position>
			<text>
				<![CDATA[F<sub>1</sub>]]>
			</text>
		</ObjectName>
		<Point id="23" name="P6">
			<appearance brush_style="0">
			</appearance>
			<position x="1.42875" y="4.63020833333334">
			</position>
		</Point>
		<Point id="24" name="P7">
			<appearance brush_style="0">
			</appearance>
			<position x="4.63020833333334" y="7.83166666666668">
			</position>
		</Point>
		<Segment id="25" name="b1">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				23;24
			</parents>
			<position x1="1.42875" y1="4.63020833333334" x2="4.63020833333334" y2="7.83166666666668">
			</position>
		</Segment>
		<ObjectName id="26" name="Name6">
			<parents>
				25
			</parents>
			<position x="2.63639833868763" y="6.8117129745487" width="5.74145833333334" height="1.93145833333334">
			</position>
			<text>
				<![CDATA[<font size=12>b<sub>1</sub></font>]]>
			</text>
		</ObjectName>
		<Point id="27" name="P8">
			<appearance brush_style="0">
			</appearance>
			<position x="-8.01687500000001" y="-2.83104166666667">
			</position>
		</Point>
		<Point id="28" name="P9">
			<appearance brush_style="0">
			</appearance>
			<position x="-5.58270833333334" y="2.460625">
			</position>
		</Point>
		<Point id="29" name="P10">
			<appearance brush_style="0">
			</appearance>
			<position x="-2.8575" y="-2.83104166666667">
			</position>
		</Point>
		<Segment id="30" name="s1">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				27;28
			</parents>
			<position x1="-8.01687500000001" y1="-2.83104166666667" x2="-5.58270833333334" y2="2.460625">
			</position>
		</Segment>
		<Segment id="31" name="s2">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				28;29
			</parents>
			<position x1="-5.58270833333334" y1="2.460625" x2="-2.8575" y2="-2.83104166666667">
			</position>
		</Segment>
		<Segment id="32" name="s3">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				29;27
			</parents>
			<position x1="-2.8575" y1="-2.83104166666667" x2="-8.01687500000001" y2="-2.83104166666667">
			</position>
		</Segment>
		<Polygon id="34" name="N1">
			<parents>
				27;28;29
			</parents>
			<position x1="0" y1="0" x2="0" y2="0">
			</position>
		</Polygon>
		<Area id="35" name="F_1">
			<appearance color="$000000FF" brush_style="2">
			</appearance>
			<parents>
				34
			</parents>
			<orientation>
				true
			</orientation>
		</Area>
		<Angle id="36" name="γ">
			<parents>
				29;27;28
			</parents>
			<position x1="-2.8575" y1="-2.83104166666667" x2="-8.01687500000001" y2="-2.83104166666667" x3="-5.58270833333334" y3="2.460625">
			</position>
			<line radius="1.1953194489631" reversed="false">
			</line>
		</Angle>
		<MeasureAngle id="37" name="w(P10;P8;P9)">
			<appearance pen_style="2">
			</appearance>
			<parents>
				36
			</parents>
			<position x="-7.35261732082759" y="-2.4054338150982" width="0" height="0">
			</position>
			<text>
				<![CDATA[]]>
			</text>
			<line x1="-6.35261732082759" y1="-1.9054338150982" x2="0" y2="0" dx="1" dy="0.5">
			</line>
		</MeasureAngle>
		<ObjectName id="38" name="Name7">
			<parents>
				36
			</parents>
			<position x="-7.61501806415188" y="-2.09713608023556" width="5.74145833333334" height="1.93145833333334">
			</position>
			<text>
				<![CDATA[<font face="Symbol" size=12>g</font>]]>
			</text>
		</ObjectName>
		<ObjectName id="39" name="Name8">
			<parents>
				31
			</parents>
			<position x="-4.32668003477295" y="0.985604748886676" width="5.74145833333334" height="1.93145833333334">
			</position>
			<text>
				<![CDATA[s<sub>2</sub>]]>
			</text>
		</ObjectName>
		<ObjectName id="40" name="Name9">
			<parents>
				34
			</parents>
			<position x="-5.80319444444445" y="-0.529166666666667" width="5.74145833333334" height="1.93145833333334">
			</position>
			<text>
				<![CDATA[N<sub>1</sub>]]>
			</text>
		</ObjectName>
	</objlist>
</dg:drawing>
