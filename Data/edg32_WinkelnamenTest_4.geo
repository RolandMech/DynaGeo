<?xml version="1.0" encoding="UTF-8"?>
<dg:drawing xmlns:dg="http://www.dynageo.com/xml/dg12" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.dynageo.com/xml/dg12 http://www.dynageo.com/xml/dg12.xsd">
	<header>
		<created prog_name="EUKLID DynaGeo" prog_version="3.1.3.1" date="2008-08-05T09:36:57">
		</created>
		<edited prog_name="EUKLID DynaGeo" prog_version="3.2.0.143" date="2008-10-15T08:21:51">
		</edited>
	</header>
	<windowdata>
		<log_window xmin="-13.2291666666667" xmax="19.0235416666667" ymin="-6.77333333333334" ymax="9.97479166666668">
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
		<Point id="6" name="P1">
			<appearance brush_style="0">
			</appearance>
			<position x="-7.3025" y="4.07458333333333">
			</position>
		</Point>
		<Point id="7" name="P2">
			<appearance brush_style="0">
			</appearance>
			<position x="-5.60916666666668" y="8.51958333333334">
			</position>
		</Point>
		<Segment id="8" name="a">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				6;7
			</parents>
			<position x1="-7.3025" y1="4.07458333333333" x2="-5.60916666666668" y2="8.51958333333334">
			</position>
		</Segment>
		<Point id="9" name="P3">
			<appearance brush_style="0">
			</appearance>
			<position x="-3.01625000000001" y="4.07458333333334">
			</position>
		</Point>
		<Segment id="10" name="b">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				6;9
			</parents>
			<position x1="-7.3025" y1="4.07458333333333" x2="-3.01625000000001" y2="4.07458333333334">
			</position>
		</Segment>
		<Angle id="11" name="α1">
			<parents>
				9;6;7
			</parents>
			<position x1="-3.01625000000001" y1="4.07458333333334" x2="-7.3025" y2="4.07458333333333" x3="-5.60916666666668" y3="8.51958333333334">
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
			<position x="-6.68271170138618" y="4.50171206417906" width="0" height="0">
			</position>
			<text>
				<![CDATA[]]>
			</text>
			<line x1="-5.68271170138618" y1="5.00171206417906" x2="0" y2="0" dx="1" dy="0.5">
			</line>
		</MeasureAngle>
		<ObjectName id="14" name="Name2">
			<parents>
				8
			</parents>
			<position x="-6.92837790178393" y="6.74726046121052" width="5.74145833333334" height="1.93145833333334">
			</position>
			<text>
				<![CDATA[a]]>
			</text>
		</ObjectName>
		<ObjectName id="15" name="Name3">
			<parents>
				10
			</parents>
			<position x="-5.3373981629393" y="3.91406798914827" width="5.74145833333334" height="1.93145833333334">
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
			<position x1="-10.080625" y1="3.96875000000001" x2="-8.54405740087952" y2="3.96875000000001">
			</position>
			<radius r_term="w(α1)/45">
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
			<value term="w(α1)*2">
			</value>
		</Term>
		<PointWDC id="19" name="P5">
			<appearance shape="6" add_data2name="true">
			</appearance>
			<parents>
				1;12
			</parents>
			<position x="0.987793456577453" y="1.53656759912048" x_term="w(α1)/70" y_term="w(α1)/45">
			</position>
		</PointWDC>
		<ObjectName id="20" name="Name4">
			<parents>
				19
			</parents>
			<position x="1.28245627382282" y="1.57026823361121" width="5.74145833333334" height="1.93145833333334">
			</position>
			<text>
				<![CDATA[P<sub>5</sub>]]>
			</text>
		</ObjectName>
		<Graph id="21" name="F1" trace_status="11" term="w(α1)/( pi/4 )*x - 5">
			<appearance color="$000000FF" add_data2name="true">
			</appearance>
			<parents>
				12
			</parents>
			<points>
				-16.4544375;-30.2833555242531;-16.4544375 
				-15.4359309210527;-28.7183513155515;-15.4359309210527 
				-14.4174243421053;-27.1533471068499;-14.4174243421053 
				-13.3989177631579;-25.5883428981484;-13.3989177631579 
				-12.3804111842106;-24.0233386894468;-12.3804111842106 
				-11.3619046052632;-22.4583344807452;-11.3619046052632 
				-10.3433980263158;-20.8933302720436;-10.3433980263158 
				-9.32489144736844;-19.328326063342;-9.32489144736844 
				-8.30638486842107;-17.7633218546405;-8.30638486842107 
				-7.2878782894737;-16.1983176459389;-7.2878782894737 
				-6.26937171052633;-14.6333134372373;-6.26937171052633 
				-5.25086513157896;-13.0683092285357;-5.25086513157896 
				-4.23235855263159;-11.5033050198342;-4.23235855263159 
				-3.21385197368422;-9.93830081113258;-3.21385197368422 
				-2.19534539473685;-8.37329660243101;-2.19534539473685 
				-1.17683881578948;-6.80829239372943;-1.17683881578948 
				-0.158332236842107;-5.24328818502785;-0.158332236842107 
				0.860174342105264;-3.67828397632627;0.860174342105264 
				1.87868092105263;-2.1132797676247;1.87868092105263 
				2.8971875;-0.548275558923119;2.8971875 
				3.91569407894738;1.01672864977846;3.91569407894738 
				4.93420065789475;2.58173285848004;4.93420065789475 
				5.95270723684212;4.14673706718161;5.95270723684212 
				6.97121381578949;5.71174127588319;6.97121381578949 
				7.98972039473686;7.27674548458477;7.98972039473686 
				9.00822697368423;8.84174969328635;9.00822697368423 
				10.0267335526316;10.4067539019879;10.0267335526316 
				11.045240131579;11.9717581106895;11.045240131579 
				12.0637467105263;13.5367623193911;12.0637467105263 
				13.0822532894737;15.1017665280927;13.0822532894737 
				14.1007598684211;16.6667707367942;14.1007598684211 
				15.1192664473684;18.2317749454958;15.1192664473684 
				16.1377730263158;19.7967791541974;16.1377730263158 
				17.1562796052632;21.361783362899;17.1562796052632 
				18.1747861842106;22.9267875716005;18.1747861842106 
				19.1932927631579;24.4917917803021;19.1932927631579 
				20.2117993421053;26.0567959890037;20.2117993421053 
				21.2303059210527;27.6218001977053;21.2303059210527 
				22.2488125;29.1868044064069;22.2488125
			</points>
		</Graph>
		<ObjectName id="22" name="Name5">
			<appearance color="$000000FF">
			</appearance>
			<parents>
				21
			</parents>
			<position x="2.61450109649123" y="-1.22433496047124" width="5.74145833333334" height="1.93145833333334">
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
			<position x="-4.55083333333334" y="2.19604166666667">
			</position>
		</Point>
		<Point id="29" name="P10">
			<appearance brush_style="0">
			</appearance>
			<position x="-2.85750000000001" y="-2.67229166666667">
			</position>
		</Point>
		<Segment id="30" name="s1">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				27;28
			</parents>
			<position x1="-8.01687500000001" y1="-2.83104166666667" x2="-4.55083333333334" y2="2.19604166666667">
			</position>
		</Segment>
		<Segment id="31" name="s2">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				28;29
			</parents>
			<position x1="-4.55083333333334" y1="2.19604166666667" x2="-2.85750000000001" y2="-2.67229166666667">
			</position>
		</Segment>
		<Segment id="32" name="s3">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				29;27
			</parents>
			<position x1="-2.85750000000001" y1="-2.67229166666667" x2="-8.01687500000001" y2="-2.83104166666667">
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
			<position x1="-2.85750000000001" y1="-2.67229166666667" x2="-8.01687500000001" y2="-2.83104166666667" x3="-4.55083333333334" y3="2.19604166666667">
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
			<position x="-7.32414942574306" y="-2.45353459861809" width="0" height="0">
			</position>
			<text>
				<![CDATA[]]>
			</text>
			<line x1="-6.32414942574306" y1="-1.95353459861809" x2="0" y2="0" dx="1" dy="0.5">
			</line>
		</MeasureAngle>
		<ObjectName id="38" name="Name7">
			<parents>
				36
			</parents>
			<position x="-7.56406265408771" y="-2.12743141512577" width="5.74145833333334" height="1.93145833333334">
			</position>
			<text>
				<![CDATA[<font face="Symbol" size=12>g</font>]]>
			</text>
		</ObjectName>
		<ObjectName id="39" name="Name8">
			<parents>
				31
			</parents>
			<position x="-3.59735608854154" y="0.798113136352732" width="5.74145833333334" height="1.93145833333334">
			</position>
			<text>
				<![CDATA[s<sub>2</sub>]]>
			</text>
		</ObjectName>
		<ObjectName id="40" name="Name9">
			<parents>
				34
			</parents>
			<position x="-5.45923611111112" y="-0.564444444444444" width="5.74145833333334" height="1.93145833333334">
			</position>
			<text>
				<![CDATA[N<sub>1</sub>]]>
			</text>
		</ObjectName>
		<Angle id="41" name="β">
			<parents>
				28;29;27
			</parents>
			<position x1="-4.55083333333334" y1="2.19604166666667" x2="-2.85750000000001" y2="-2.67229166666667" x3="-8.01687500000001" y3="-2.83104166666667">
			</position>
			<line radius="0.8" reversed="false">
			</line>
		</Angle>
		<MeasureAngle id="42" name="w(P9;P10;P8)">
			<appearance pen_style="2">
			</appearance>
			<parents>
				41
			</parents>
			<position x="-3.29248563320219" y="-2.37300668724455" width="0" height="0">
			</position>
			<text>
				<![CDATA[]]>
			</text>
			<line x1="-2.29248563320219" y1="-1.87300668724455" x2="0" y2="0" dx="1" dy="0.5">
			</line>
		</MeasureAngle>
		<Term id="44" name="T1" show_name="false" show_term="true">
			<appearance shape="4">
			</appearance>
			<parents>
				12;37;42
			</parents>
			<position x="-12.7" y="8.14916666666668" width="150" height="35">
			</position>
			<value term="w(α1) + w(γ) + w(β)">
			</value>
		</Term>
		<ObjectName id="45" name="Name1">
			<parents>
				41
			</parents>
			<position x="-3.39668157080313" y="-2.09947267103032" width="5.74145833333334" height="1.93145833333334">
			</position>
			<text>
				<![CDATA[<font face="SYMBOL">b</font>]]>
			</text>
		</ObjectName>
		<ObjectName id="46" name="Name10">
			<parents>
				11
			</parents>
			<position x="-6.94280714127015" y="4.78729264443828" width="5.74145833333334" height="1.93145833333334">
			</position>
			<text>
				<![CDATA[<font face="SYMBOL">a<sub>1</sub></font>]]>
			</text>
		</ObjectName>
	</objlist>
</dg:drawing>
