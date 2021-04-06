<?xml version="1.0" encoding="UTF-8"?>
<dg:drawing xmlns:dg="http://www.dynageo.com/xml/dg12" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.dynageo.com/xml/dg12 http://www.dynageo.com/xml/dg12.xsd">
	<header>
		<created prog_name="EUKLID DynaGeo" prog_version="3.1.3.1" date="2008-08-05T09:36:57">
		</created>
		<edited prog_name="EUKLID DynaGeo" prog_version="3.1.3.1" date="2008-08-05T09:36:57">
		</edited>
	</header>
	<windowdata>
		<log_window xmin="-13.2291666666667" xmax="18.415" ymin="-11.8004166666667" ymax="9.97479166666667">
		</log_window>
		<scr_window width="1196" height="823">
		</scr_window>
		<startfont fontname="Arial" fontsize="13" fontcharset="0">
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
			<position x="-5.13291666666667" y="6.79979166666667">
			</position>
		</Point>
		<Segment id="8" name="a">
			<appearance shape="0" brush_style="0">
			</appearance>
			<parents>
				6;7
			</parents>
			<position x1="-7.3025" y1="4.07458333333333" x2="-5.13291666666667" y2="6.79979166666667">
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
		<Angle id="11" name="a">
			<parents>
				9;6;7
			</parents>
			<position x1="-2.91041666666667" y1="4.07458333333333" x2="-7.3025" y2="4.07458333333333" x3="-5.13291666666667" y3="6.79979166666667">
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
			<position x="-6.62446482986494" y="4.4014545554873" width="0" height="0">
			</position>
			<text>
				<![CDATA[]]>
			</text>
			<line x1="-5.62446482986494" y1="4.9014545554873" x2="0" y2="0" dx="1" dy="0.5">
			</line>
		</MeasureAngle>
		<ObjectName id="13" name="Name1">
			<parents>
				11
			</parents>
			<position x="-6.8376136349296" y="4.72359348913105" width="5.74145833333333" height="1.93145833333333">
			</position>
			<text>
				<![CDATA[<font face="Symbol">a</font>]]>
			</text>
		</ObjectName>
		<ObjectName id="14" name="Name2">
			<parents>
				8
			</parents>
			<position x="-6.57341094880623" y="5.95668563929065" width="5.74145833333333" height="1.93145833333333">
			</position>
			<text>
				<![CDATA[a]]>
			</text>
		</ObjectName>
		<ObjectName id="15" name="Name3">
			<parents>
				10
			</parents>
			<position x="-5.28887712992545" y="3.91406798914827" width="5.74145833333333" height="1.93145833333333">
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
			<position x1="-10.239375" y1="6.05895833333333" x2="-9.66741806068499" y2="6.05895833333333">
			</position>
			<radius>
				<![CDATA[w(a)/90]]>
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
			<value term="w(a)*2">
			</value>
		</Term>
		<PointWDC id="19" name="P5">
			<appearance shape="6">
			</appearance>
			<parents>
				1;12
			</parents>
			<position x="0.571956939315013" y="1.14391387863003" x_term="w(a)/90" y_term="w(a)/45">
			</position>
		</PointWDC>
		<ObjectName id="20" name="Name4">
			<parents>
				19
			</parents>
			<position x="0.883071259157771" y="1.31635085164888" width="5.74145833333333" height="1.93145833333333">
			</position>
			<text>
				<![CDATA[P<sub>5</sub>]]>
			</text>
		</ObjectName>
		<Graph id="21" name="Fn1" trace_status="11" term="w(a)/(pi/2)*x - 3">
			<appearance color="$000000FF">
			</appearance>
			<parents>
				12
			</parents>
			<points>
				-16.3935833333333;-12.376423747739;-16.3935833333333 
				-15.3942938596491;-11.8048731988808;-15.3942938596491 
				-14.3950043859649;-11.2333226500227;-14.3950043859649 
				-13.3957149122807;-10.6617721011646;-13.3957149122807 
				-12.3964254385965;-10.0902215523064;-12.3964254385965 
				-11.3971359649123;-9.51867100344829;-11.3971359649123 
				-10.3978464912281;-8.94712045459016;-10.3978464912281 
				-9.39855701754386;-8.37556990573203;-9.39855701754386 
				-8.39926754385965;-7.80401935687389;-8.39926754385965 
				-7.39997807017544;-7.23246880801576;-7.39997807017544 
				-6.40068859649123;-6.66091825915763;-6.40068859649123 
				-5.40139912280701;-6.0893677102995;-5.40139912280701 
				-4.4021096491228;-5.51781716144137;-4.4021096491228 
				-3.40282017543859;-4.94626661258323;-3.40282017543859 
				-2.40353070175438;-4.3747160637251;-2.40353070175438 
				-1.40424122807017;-3.80316551486697;-1.40424122807017 
				-0.40495175438596;-3.23161496600884;-0.40495175438596 
				0.59433771929825;-2.66006441715071;0.59433771929825 
				1.59362719298246;-2.08851386829258;1.59362719298246 
				2.59291666666667;-1.51696331943444;2.59291666666667 
				3.59220614035088;-0.945412770576312;3.59220614035088 
				4.59149561403509;-0.37386222171818;4.59149561403509 
				5.5907850877193;0.197688327139952;5.5907850877193 
				6.59007456140352;0.769238875998084;6.59007456140352 
				7.58936403508773;1.34078942485622;7.58936403508773 
				8.58865350877194;1.91233997371435;8.58865350877194 
				9.58794298245615;2.48389052257248;9.58794298245615 
				10.5872324561404;3.05544107143061;10.5872324561404 
				11.5865219298246;3.62699162028874;11.5865219298246 
				12.5858114035088;4.19854216914688;12.5858114035088 
				13.585100877193;4.77009271800501;13.585100877193 
				14.5843903508772;5.34164326686314;14.5843903508772 
				15.5836798245614;5.91319381572127;15.5836798245614 
				16.5829692982456;6.4847443645794;16.5829692982456 
				17.5822587719298;7.05629491343754;17.5822587719298 
				18.581548245614;7.62784546229567;18.581548245614 
				19.5808377192983;8.1993960111538;19.5808377192983 
				20.5801271929825;8.77094656001193;20.5801271929825 
				21.5794166666667;9.34249710887006;21.5794166666667
			</points>
		</Graph>
	</objlist>
</dg:drawing>
