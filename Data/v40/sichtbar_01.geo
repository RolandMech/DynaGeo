<?xml version="1.0"?>
<dg:drawing xmlns:dg="http://www.dynageo.com/xml/dg12" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.dynageo.com/xml/dg12 http://www.dynageo.com/xml/dg12.xsd"><header><created prog_name="EUKLID DynaGeo" prog_version="3.8.3.16" date="2016-02-16T22:50:39"/><edited prog_name="EUKLID DynaGeo" prog_version="3.8.3.16" date="2016-02-16T23:02:02"/></header><windowdata><log_window xmin="-11.985625" xmax="24.1564583333333" ymin="-9.04875" ymax="6.85270833333333"/><scr_window width="1366" height="601"/><startfont fontname="Arial" fontsize="12" fontcharset="0"/><options LengthDecimals="6" DefLocLineStatus="2"/></windowdata><objlist><Origin id="1" name="O" cosys_type="-1"><appearance color="$00808080" visible="false"/><position x="0" y="0"/></Origin><Axis id="2" name="xa" label="x"><appearance color="$00808080" shape="0" brush_style="0" visible="false"/><parents>1</parents><position x1="0" y1="0" x2="1" y2="0"/></Axis><Axis id="3" name="ya" label="y"><appearance color="$00808080" shape="0" brush_style="0" visible="false"/><parents>1</parents><position x1="0" y1="0" x2="0" y2="1"/></Axis><UnityPoint id="4" name="X_1"><appearance color="$00C0C0C0" brush_style="0" visible="false"/><parents>2</parents><position x="1" y="0"/></UnityPoint><UnityPoint id="5" name="Y_1"><appearance color="$00C0C0C0" brush_style="0" visible="false"/><parents>3</parents><position x="0" y="1"/></UnityPoint><Point id="6" name="P1"><appearance brush_style="0"/><position x="-5.26520833333333" y="0.423333333333333"/></Point><Point id="7" name="P2"><appearance brush_style="0"/><position x="-0.79375" y="1.79916666666667"/></Point><Line id="8" name="g1"><appearance shape="0" brush_style="0" groups="1"/><parents>6;7</parents><position x1="-5.26520833333333" y1="0.423333333333333" x2="-0.79375" y2="1.79916666666667"/></Line><Number id="9" name="a" show_name="true"><appearance color="$00808080"/><position x="-10.9272916666667" y="5.18583333333334" width="250" height="33"/><value min="0" actual="0" max="2" quant="1" ani_step="0.001"/></Number><Circle id="10" name="k1"><appearance shape="0" brush_style="0" groups="2"/><parents>7;6</parents><position x1="-0.79375" y1="1.79916666666667" x2="-5.26520833333333" y2="0.423333333333333"/><radius>4.67833912706713</radius></Circle><TextBox id="11" name="tb1"><position x="3.01625" y="2.778125" width="12.0385416666667" height="3.01625"/><text><![CDATA[Wenn ich a normal habe, kann ich über a Sichtbarkeit steuern.<br>Wenn ich a minimiere, klappt das nicht mehr.]]></text></TextBox></objlist><grouplist><group id="0" comment="gerade" condition="a = 1"/><group id="1" comment="kreis" condition="a = 2"/></grouplist></dg:drawing>