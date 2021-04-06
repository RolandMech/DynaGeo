<?xml version="1.0" encoding="UTF-8"?>
<dg:drawing xmlns:dg="http://www.dynageo.com" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.dynageo.com D:/XML/xsv12/geotypes.xsd">
	<header>
		<created prog_name="EUKLID DynaGeo" prog_version="2.5"/>
		<edited prog_name="EUKLID DynaGeo" prog_version="2.7.0.28" date="2005-08-08T09:05:35"/>
		<copyright sign_code="35363067">Elschenbroich/ Seebach: &#xD;
Dynamisch Geometrie entdecken Klasse 7 - 10 &#xD;
EINZEL-Lizenz (Keine Raumlizenz)&#xD;
Elektronische Arbeitsblätter mit Euklid DynaGeo&#xD;
© CoTec 2004&#xD;
</copyright>
	</header>
	<windowdata>
		<log_window xmin="-12.9910416666667" xmax="7.96395833333335" ymin="-6.50875000000001" ymax="10.16"/>
		<scr_window width="792" height="630"/>
		<startfont fontname="Arial" fontsize="12"/>
		<commands>797A7B8B8A89887C81839C9B</commands>
	</windowdata>
	<objlist>
		<Origin id="1" name="P1" cosys_type="1">
			<appearance color="$00C0C0C0" shape="0" visible="false"/>
			<children>2;3</children>
			<position x="0" y="0"/>
		</Origin>
		<Axis id="2" name="g1" label="g">
			<appearance color="$00C0C0C0" shape="2" visible="false"/>
			<parents>1</parents>
			<children>4</children>
			<position x1="0" y1="0" x2="100" y2="0"/>
		</Axis>
		<Axis id="3" name="g2" label="g">
			<appearance color="$00C0C0C0" shape="2" visible="false"/>
			<parents>1</parents>
			<children>5</children>
			<position x1="0" y1="0" x2="0" y2="100"/>
		</Axis>
		<UnityPoint id="4" name="P2">
			<appearance color="$00C0C0C0" shape="0" visible="false"/>
			<parents>2</parents>
			<position x="0" y="1"/>
		</UnityPoint>
		<UnityPoint id="5" name="P3">
			<appearance color="$00C0C0C0" shape="0" visible="false"/>
			<parents>3</parents>
			<position x="0" y="1"/>
		</UnityPoint>
		<Point id="6" name="P4">
			<appearance color="$0000B000" brush_style="0"/>
			<children>8</children>
			<position x="-13.1233333333333" y="-0.423333333333333"/>
		</Point>
		<Point id="7" name="P5">
			<appearance color="$0000B000" brush_style="0"/>
			<children>8</children>
			<position x="12.1972916666667" y="-0.423333333333333"/>
		</Point>
		<Line id="8" name="Rissachse">
			<appearance color="$00FF00FF" shape="2"/>
			<parents>6;7</parents>
			<children>9;100;106;113;123;137;192;196;198;199;200;201;202</children>
			<position x1="-13.1233333333333" y1="-0.423333333333333" x2="12.1972916666667" y2="-0.423333333333333"/>
		</Line>
		<ObjectName id="9" name="">
			<appearance color="$00FF00FF" pen_style="1" shape="2"/>
			<parents>8</parents>
			<position x="-6.6675" y="0.105833333333333" width="5.55625000000001" height="1.85208333333334"/>
			<text><![CDATA[<font face="Arial" size="13">Ri</font><font face="Arial" size="13">ssachse </font>]]></text>
		</ObjectName>
		<Point id="14" name="Grundriss">
			<appearance color="$0000B000" brush_style="0"/>
			<children>85;54;57;122;192;193</children>
			<position x="-2.24895833333333" y="-2.778125"/>
		</Point>
		<Perpendicular id="192" name="g9">
			<appearance color="$00003F7F" pen_style="1" shape="0" brush_style="0" visible="false"/>
			<parents>14;8</parents>
			<children>20;26;51;193;194;195;197</children>
			<position x1="-2.24895833333333" y1="-28.09875" x2="-2.24895833333333" y2="-2.778125"/>
		</Perpendicular>
		<Point id="20" name="P2">
			<appearance color="$0000B000" brush_style="0"/>
			<parents>192</parents>
			<children>58;59;91;195</children>
			<position x="-2.24895833333333" y="1.61395833333333"/>
		</Point>
		<Point id="26" name="P12">
			<appearance color="$0000B000" brush_style="0"/>
			<parents>192</parents>
			<children>56;57;105;194</children>
			<position x="-2.24895833333333" y="-1.74625"/>
		</Point>
		<Perpendicular id="193" name="g5">
			<appearance color="$00003F7F" pen_style="1" shape="0" brush_style="0" visible="false"/>
			<parents>14;192</parents>
			<children>34</children>
			<position x1="23.0716666666667" y1="-2.778125" x2="-2.24895833333333" y2="-2.778125"/>
		</Perpendicular>
		<Perpendicular id="194" name="g10">
			<appearance color="$00003F7F" pen_style="1" shape="0" brush_style="0" visible="false"/>
			<parents>26;192</parents>
			<children>37</children>
			<position x1="23.0716666666667" y1="-1.74625" x2="-2.24895833333333" y2="-1.74625"/>
		</Perpendicular>
		<Perpendicular id="195" name="g11">
			<appearance color="$00003F7F" pen_style="1" shape="0" brush_style="0" visible="false"/>
			<parents>20;192</parents>
			<children>36</children>
			<position x1="23.0716666666667" y1="1.61395833333333" x2="-2.24895833333333" y2="1.61395833333333"/>
		</Perpendicular>
		<Point id="34" name="P15">
			<appearance color="$0000B000" brush_style="0"/>
			<parents>193</parents>
			<children>54;55;136;196</children>
			<position x="-0.608541666666668" y="-2.778125"/>
		</Point>
		<Perpendicular id="196" name="g12">
			<appearance color="$00003F7F" pen_style="1" shape="0" brush_style="0" visible="false"/>
			<parents>34;8</parents>
			<children>36;37;53</children>
			<position x1="-0.608541666666668" y1="-28.09875" x2="-0.608541666666668" y2="-2.778125"/>
		</Perpendicular>
		<PointLXL id="36" name="P16">
			<appearance color="$00C0C0C0" shape="0" brush_style="0"/>
			<parents>195;196</parents>
			<children>59;60;111</children>
			<position x="-0.608541666666668" y="1.61395833333333"/>
		</PointLXL>
		<PointLXL id="37" name="P17">
			<appearance color="$00C0C0C0" shape="0" brush_style="0"/>
			<parents>194;196</parents>
			<children>55;56;112</children>
			<position x="-0.608541666666668" y="-1.74625"/>
		</PointLXL>
		<Point id="51" name="Aufriss">
			<appearance color="$0000B000" brush_style="0"/>
			<parents>192</parents>
			<children>83;58;61;96;197</children>
			<position x="-2.24895833333333" y="2.69875"/>
		</Point>
		<Perpendicular id="197" name="g13">
			<appearance color="$00003F7F" pen_style="1" shape="0" brush_style="0" visible="false"/>
			<parents>51;192</parents>
			<children>53</children>
			<position x1="23.0716666666667" y1="2.69875" x2="-2.24895833333333" y2="2.69875"/>
		</Perpendicular>
		<PointLXL id="53" name="P23">
			<appearance color="$00C0C0C0" shape="0" brush_style="0"/>
			<parents>196;197</parents>
			<children>60;61;116</children>
			<position x="-0.608541666666664" y="2.69875"/>
		</PointLXL>
		<Segment id="54" name="s22">
			<appearance color="$00FF0000" shape="2"/>
			<parents>14;34</parents>
			<position x1="-2.24895833333333" y1="-2.778125" x2="-0.608541666666668" y2="-2.778125"/>
		</Segment>
		<Segment id="55" name="s23">
			<appearance color="$00FF0000" shape="2"/>
			<parents>34;37</parents>
			<position x1="-0.608541666666668" y1="-2.778125" x2="-0.608541666666668" y2="-1.74625"/>
		</Segment>
		<Segment id="56" name="s24">
			<appearance color="$00FF0000" shape="2"/>
			<parents>37;26</parents>
			<position x1="-0.608541666666668" y1="-1.74625" x2="-2.24895833333333" y2="-1.74625"/>
		</Segment>
		<Segment id="57" name="s25">
			<appearance color="$00FF0000" shape="2"/>
			<parents>26;14</parents>
			<position x1="-2.24895833333333" y1="-1.74625" x2="-2.24895833333333" y2="-2.778125"/>
		</Segment>
		<Segment id="58" name="s26">
			<appearance color="$00FF0000" shape="2"/>
			<parents>51;20</parents>
			<position x1="-2.24895833333333" y1="2.69875" x2="-2.24895833333333" y2="1.61395833333333"/>
		</Segment>
		<Segment id="59" name="s27">
			<appearance color="$00FF0000" shape="2"/>
			<parents>20;36</parents>
			<position x1="-2.24895833333333" y1="1.61395833333333" x2="-0.608541666666668" y2="1.61395833333333"/>
		</Segment>
		<Segment id="60" name="s28">
			<appearance color="$00FF0000" shape="2"/>
			<parents>36;53</parents>
			<position x1="-0.608541666666668" y1="1.61395833333333" x2="-0.608541666666664" y2="2.69875"/>
		</Segment>
		<Segment id="61" name="s29">
			<appearance color="$00FF0000" shape="2"/>
			<parents>53;51</parents>
			<position x1="-0.608541666666664" y1="2.69875" x2="-2.24895833333333" y2="2.69875"/>
		</Segment>
		<ObjectName id="83" name="">
			<appearance color="$00FF0000" shape="0"/>
			<parents>51</parents>
			<position x="-3.175" y="3.67770833333333" width="5.55625000000001" height="1.85208333333334"/>
			<text><![CDATA[<font face="Arial" size="13">Aufriss </font>]]></text>
		</ObjectName>
		<ObjectName id="85" name="">
			<appearance color="$00FF0000" shape="0"/>
			<parents>14</parents>
			<position x="-2.88395833333333" y="-3.33375" width="5.55625000000001" height="1.85208333333334"/>
			<text><![CDATA[<font face="Arial" size="13">Grundriss</font>]]></text>
		</ObjectName>
		<Point id="100" name="R">
			<appearance color="$0000D500" brush_style="0"/>
			<parents>8</parents>
			<children>101;198</children>
			<position x="-3.12208333333333" y="-0.423333333333333"/>
		</Point>
		<ObjectName id="101" name="dummy">
			<appearance color="$000080FF" shape="0"/>
			<parents>100</parents>
			<position x="-3.571875" y="0.0529166666666667" width="5.55625000000001" height="1.85208333333334"/>
			<text><![CDATA[<font face="Arial" size="13">R</font>]]></text>
		</ObjectName>
		<Perpendicular id="198" name="g14">
			<appearance color="$00C0C0C0" pen_style="2" shape="0" brush_style="0"/>
			<parents>100;8</parents>
			<children>10;103</children>
			<position x1="-3.12208333333333" y1="-25.7439583333333" x2="-3.12208333333333" y2="-0.423333333333333"/>
		</Perpendicular>
		<Point id="10" name="L2">
			<appearance color="$0000B000" brush_style="0"/>
			<parents>198</parents>
			<children>13;91;96;111;116</children>
			<position x="-3.12208333333333" y="2.16958333333333"/>
		</Point>
		<Ray id="96" name="h3">
			<appearance color="$00C0C0C0" pen_style="1"/>
			<parents>10;51</parents>
			<children>108;130</children>
			<position x1="-3.12208333333333" y1="2.16958333333333" x2="-2.24895833333333" y2="2.69875"/>
		</Ray>
		<Ray id="91" name="h2">
			<appearance color="$00C0C0C0" pen_style="1"/>
			<parents>10;20</parents>
			<children>109;125</children>
			<position x1="-3.12208333333333" y1="2.16958333333333" x2="-2.24895833333333" y2="1.61395833333333"/>
		</Ray>
		<ObjectName id="13" name="">
			<appearance color="$000080FF" shape="0"/>
			<parents>10</parents>
			<position x="-3.83645833333333" y="2.32833333333333" width="5.55625000000001" height="1.85208333333334"/>
			<text><![CDATA[<font face="Arial" size="13">L</font><font face="Arial" size="9">2</font><font face="Arial" size="13"> </font>]]></text>
		</ObjectName>
		<Point id="103" name="L1">
			<appearance color="$0000D500" brush_style="0"/>
			<parents>198</parents>
			<children>104;105;112;122;136</children>
			<position x="-3.12208333333333" y="-4.47145833333333"/>
		</Point>
		<ObjectName id="104" name="dummy">
			<appearance color="$000080FF" shape="0"/>
			<parents>103</parents>
			<position x="-3.81" y="-4.65666666666666" width="5.55625000000001" height="1.85208333333334"/>
			<text><![CDATA[<font face="Arial" size="13">L</font><font face="Arial" size="9">1</font>]]></text>
		</ObjectName>
		<Ray id="105" name="h1">
			<appearance color="$00C0C0C0" pen_style="1"/>
			<parents>103;26</parents>
			<children>106</children>
			<position x1="-3.12208333333333" y1="-4.47145833333333" x2="-2.24895833333333" y2="-1.74625"/>
		</Ray>
		<PointLXL id="106" name="P6">
			<appearance color="$00C0C0C0" shape="0" brush_style="0"/>
			<parents>8;105</parents>
			<children>199</children>
			<position x="-1.82511124595469" y="-0.423333333333333"/>
		</PointLXL>
		<Perpendicular id="199" name="g3">
			<appearance color="$00C0C0C0" pen_style="2" shape="0" brush_style="0"/>
			<parents>106;8</parents>
			<children>108;109</children>
			<position x1="-1.82511124595469" y1="-25.7439583333333" x2="-1.82511124595469" y2="-0.423333333333333"/>
		</Perpendicular>
		<PointLXL id="108" name="P7">
			<appearance color="$00FF0000" shape="0" brush_style="0"/>
			<parents>96;199</parents>
			<children>110;131;133;156</children>
			<position x="-1.82511124595469" y="2.95562702265372"/>
		</PointLXL>
		<PointLXL id="109" name="P8">
			<appearance color="$00FF0000" shape="0" brush_style="0"/>
			<parents>91;199</parents>
			<children>110;132;134;161</children>
			<position x="-1.82511124595469" y="1.34423745954692"/>
		</PointLXL>
		<Segment id="110" name="s1">
			<appearance color="$00FF0000"/>
			<parents>108;109</parents>
			<position x1="-1.82511124595469" y1="2.95562702265372" x2="-1.82511124595469" y2="1.34423745954692"/>
		</Segment>
		<Ray id="111" name="h4">
			<appearance color="$00C0C0C0" pen_style="2" visible="false"/>
			<parents>10;36</parents>
			<children>115;144</children>
			<position x1="-3.12208333333333" y1="2.16958333333333" x2="-0.608541666666668" y2="1.61395833333333"/>
		</Ray>
		<Ray id="112" name="h5">
			<appearance color="$00C0C0C0" pen_style="2" visible="false"/>
			<parents>103;37</parents>
			<children>113</children>
			<position x1="-3.12208333333333" y1="-4.47145833333333" x2="-0.608541666666668" y2="-1.74625"/>
		</Ray>
		<PointLXL id="113" name="P9">
			<appearance color="$00C0C0C0" shape="0" brush_style="0" visible="false"/>
			<parents>8;112</parents>
			<children>200</children>
			<position x="0.611624190938514" y="-0.423333333333334"/>
		</PointLXL>
		<Perpendicular id="200" name="g4">
			<appearance color="$00C0C0C0" pen_style="2" shape="0" brush_style="0" visible="false"/>
			<parents>113;8</parents>
			<children>115;120</children>
			<position x1="0.611624190938514" y1="-25.7439583333333" x2="0.611624190938514" y2="-0.423333333333334"/>
		</Perpendicular>
		<PointLXL id="115" name="P10">
			<appearance color="$00FF0000" shape="0" brush_style="0"/>
			<parents>111;200</parents>
			<children>132;148;151;161</children>
			<position x="0.611624190938514" y="1.34423745954691"/>
		</PointLXL>
		<Ray id="116" name="h6">
			<appearance color="$00C0C0C0" pen_style="2" visible="false"/>
			<parents>10;53</parents>
			<children>120;139</children>
			<position x1="-3.12208333333333" y1="2.16958333333333" x2="-0.608541666666664" y2="2.69875"/>
		</Ray>
		<PointLXL id="120" name="P11">
			<appearance color="$00FF0000" shape="0" brush_style="0"/>
			<parents>116;200</parents>
			<children>131;147;148;156</children>
			<position x="0.611624190938514" y="2.95562702265372"/>
		</PointLXL>
		<Ray id="122" name="h7">
			<appearance color="$00C0C0C0" pen_style="2" visible="false"/>
			<parents>103;14</parents>
			<children>123</children>
			<position x1="-3.12208333333333" y1="-4.47145833333333" x2="-2.24895833333333" y2="-2.778125"/>
		</Ray>
		<PointLXL id="123" name="P13">
			<appearance color="$00C0C0C0" shape="0" brush_style="0" visible="false"/>
			<parents>8;122</parents>
			<children>201</children>
			<position x="-1.03476888020833" y="-0.423333333333332"/>
		</PointLXL>
		<Perpendicular id="201" name="g6">
			<appearance color="$00C0C0C0" pen_style="2" shape="0" brush_style="0" visible="false"/>
			<parents>123;8</parents>
			<children>125;130</children>
			<position x1="-1.03476888020833" y1="-25.7439583333333" x2="-1.03476888020833" y2="-0.423333333333332"/>
		</Perpendicular>
		<PointLXL id="125" name="P14">
			<appearance color="$00FF0000" shape="0" brush_style="0"/>
			<parents>91;201</parents>
			<children>134;146;149;161</children>
			<position x="-1.03476888020833" y="0.841292317708323"/>
		</PointLXL>
		<PointLXL id="130" name="P18">
			<appearance color="$00FF0000" shape="0" brush_style="0"/>
			<parents>96;201</parents>
			<children>133;145;149;156</children>
			<position x="-1.03476888020833" y="3.43462239583334"/>
		</PointLXL>
		<Segment id="131" name="s2">
			<appearance color="$00FF0000"/>
			<parents>108;120</parents>
			<position x1="-1.82511124595469" y1="2.95562702265372" x2="0.611624190938514" y2="2.95562702265372"/>
		</Segment>
		<Segment id="132" name="s3">
			<appearance color="$00FF0000"/>
			<parents>109;115</parents>
			<position x1="-1.82511124595469" y1="1.34423745954692" x2="0.611624190938514" y2="1.34423745954691"/>
		</Segment>
		<Segment id="133" name="s4">
			<appearance color="$00FF0000"/>
			<parents>108;130</parents>
			<position x1="-1.82511124595469" y1="2.95562702265372" x2="-1.03476888020833" y2="3.43462239583334"/>
		</Segment>
		<Segment id="134" name="s5">
			<appearance color="$00FF0000"/>
			<parents>109;125</parents>
			<position x1="-1.82511124595469" y1="1.34423745954692" x2="-1.03476888020833" y2="0.841292317708323"/>
		</Segment>
		<Ray id="136" name="h8">
			<appearance color="$00C0C0C0" pen_style="2" visible="false"/>
			<parents>103;34</parents>
			<children>137</children>
			<position x1="-3.12208333333333" y1="-4.47145833333333" x2="-0.608541666666668" y2="-2.778125"/>
		</Ray>
		<PointLXL id="137" name="P19">
			<appearance color="$00C0C0C0" shape="0" brush_style="0" visible="false"/>
			<parents>8;136</parents>
			<children>202</children>
			<position x="2.88685221354167" y="-0.423333333333332"/>
		</PointLXL>
		<Perpendicular id="202" name="g7">
			<appearance color="$00C0C0C0" pen_style="2" shape="0" brush_style="0" visible="false"/>
			<parents>137;8</parents>
			<children>139;144</children>
			<position x1="2.88685221354167" y1="-25.7439583333333" x2="2.88685221354167" y2="-0.423333333333332"/>
		</Perpendicular>
		<PointLXL id="139" name="P20">
			<appearance color="$00FF0000" shape="0" brush_style="0"/>
			<parents>116;202</parents>
			<children>145;147;150;156</children>
			<position x="2.88685221354167" y="3.43462239583333"/>
		</PointLXL>
		<PointLXL id="144" name="P21">
			<appearance color="$00FF0000" shape="0" brush_style="0"/>
			<parents>111;202</parents>
			<children>146;150;151;161</children>
			<position x="2.88685221354167" y="0.841292317708323"/>
		</PointLXL>
		<Segment id="145" name="s6">
			<appearance color="$00FF0000"/>
			<parents>130;139</parents>
			<position x1="-1.03476888020833" y1="3.43462239583334" x2="2.88685221354167" y2="3.43462239583333"/>
		</Segment>
		<Segment id="146" name="s7">
			<appearance color="$00FF0000"/>
			<parents>125;144</parents>
			<position x1="-1.03476888020833" y1="0.841292317708323" x2="2.88685221354167" y2="0.841292317708323"/>
		</Segment>
		<Segment id="147" name="s8">
			<appearance color="$00FF0000"/>
			<parents>120;139</parents>
			<position x1="0.611624190938514" y1="2.95562702265372" x2="2.88685221354167" y2="3.43462239583333"/>
		</Segment>
		<Segment id="148" name="s9">
			<appearance color="$00FF0000"/>
			<parents>120;115</parents>
			<position x1="0.611624190938514" y1="2.95562702265372" x2="0.611624190938514" y2="1.34423745954691"/>
		</Segment>
		<Segment id="149" name="s10">
			<appearance color="$00FF0000"/>
			<parents>130;125</parents>
			<position x1="-1.03476888020833" y1="3.43462239583334" x2="-1.03476888020833" y2="0.841292317708323"/>
		</Segment>
		<Segment id="150" name="s11">
			<appearance color="$00FF0000"/>
			<parents>139;144</parents>
			<position x1="2.88685221354167" y1="3.43462239583333" x2="2.88685221354167" y2="0.841292317708323"/>
		</Segment>
		<Segment id="151" name="s12">
			<appearance color="$00FF0000"/>
			<parents>115;144</parents>
			<position x1="0.611624190938514" y1="1.34423745954691" x2="2.88685221354167" y2="0.841292317708323"/>
		</Segment>
		<Polygon id="156" name="N1">
			<appearance color="$0080FFFF" pen_style="5" brush_style="0"/>
			<parents>108;130;139;120</parents>
			<children>191</children>
			<position x1="0" y1="0" x2="0" y2="0"/>
		</Polygon>
		<Polygon id="161" name="N2">
			<appearance color="$00FF0000" pen_style="5" shape="2" brush_style="0"/>
			<parents>109;125;144;115</parents>
			<children>190</children>
			<position x1="0" y1="0" x2="0" y2="0"/>
		</Polygon>
		<Area id="190" name="F_1" brush_bmp="318;
F273DA78006463B5D6203B03280E62008050646641E54048FF4A0980FFFFE1078D9918210E260C4F83574393
18290F4BD8A4F99BA01BAC47939700EA9397C1A8">
			<appearance color="$00FF0000" shape="2" brush_style="0"/>
			<parents>161</parents>
			<orientation>true</orientation>
			<operators/>
		</Area>
		<TextBox id="163" name="dummy">
			<appearance color="$00000008" shape="0" brush_style="8"/>
			<position x="-12.0914583333334" y="9.02229166666668" width="14.2875" height="4.12750000000001"/>
			<text><![CDATA[<font face="ARIAL" size=11>Gegeben sind hier Grund- und Aufriss eines Quaders sowie einer Lichtquelle L, die als Schatten das ebenfalls bereits konstruierte perspektivische Bild des Quaders auf die Aufrissebene wirft.  <br> a) Konstruiere Grund- und Aufriss einer einbeschriebenen Doppelpyramide, die als Eckpunkte die Mittelpunkte der Quaderflächen hat.  <br>b) Konstruiere auch das Bild dieser Doppelpyramide. <br></font>]]></text>
		</TextBox>
		<Area id="191" name="F_2">
			<appearance color="$0080FFFF" brush_style="0"/>
			<parents>156</parents>
			<orientation>true</orientation>
			<operators/>
		</Area>
	</objlist>
</dg:drawing>
