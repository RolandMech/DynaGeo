<?xml version="1.0"?>
<dg:drawing xmlns:dg="http://www.dynageo.com/xml/dg12" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.dynageo.com/xml/dg12 http://www.dynageo.com/xml/dg12.xsd"><header><created prog_name="EUKLID DynaGeo" prog_version="4.0.0.539" date="2015-08-29T19:38:42"/><edited prog_name="EUKLID DynaGeo" prog_version="4.0.0.541" date="2015-08-29T20:52:10"/></header><windowdata><log_window xmin="-19.2352083333333" xmax="19.2352083333333" ymin="-10.2129166666667" ymax="10.1864583333333"/><scr_window width="1454" height="771"/><startfont fontname="Arial" fontsize="12" fontcharset="0"/><options AreaDecimals="3" AngleDecimals="2" DefLocLineStatus="3"/></windowdata><objlist><Origin id="1" name="O" cosys_type="1"><appearance color="$00808080"/><position x="0" y="0"/></Origin><Axis id="2" name="xa" label="x"><appearance color="$00808080" shape="0" brush_style="0"/><parents>1</parents><position x1="0" y1="0" x2="1" y2="0"/></Axis><Axis id="3" name="ya" label="y"><appearance color="$00808080" shape="0" brush_style="0"/><parents>1</parents><position x1="0" y1="0" x2="0" y2="1"/></Axis><UnityPoint id="4" name="X_1"><appearance color="$00C0C0C0" brush_style="0" visible="false"/><parents>2</parents><position x="1" y="0"/></UnityPoint><UnityPoint id="5" name="Y_1"><appearance color="$00C0C0C0" brush_style="0" visible="false"/><parents>3</parents><position x="0" y="1"/></UnityPoint><LogSlider id="6" name="h" show_name="true"><appearance color="$00808080" visible="false"/><position x="-18.7060416666667" y="9.65729166666667" width="250" height="33"/><value min="0.0001" actual="1" max="1" quant="0.001" ani_step="0.001"/></LogSlider><Number id="7" name="Z1" show_name="true"><appearance color="$00808080"/><position x="-18.6002083333335" y="9.60437500000009" width="250" height="33"/><value min="-3" actual="1.996" max="5" quant="0.001" ani_step="0.001"/></Number><Point id="8" name="P1"><appearance brush_style="0"/><position x="-5.52979166666666" y="6.270625"/></Point><Point id="9" name="P2"><appearance brush_style="0"/><position x="-11.985625" y="6.270625"/></Point><Circle id="10" name="k1"><appearance line_width="3" shape="0" brush_style="0"/><parents>8;9</parents><position x1="-5.52979166666666" y1="6.270625" x2="-11.985625" y2="6.270625"/><radius>6.45583333333332</radius></Circle><Line id="13" name="g1"><appearance line_width="3" shape="0" brush_style="0"/><parents>9;8</parents><position x1="-11.985625" y1="6.270625" x2="-5.52979166666666" y2="6.270625"/></Line><Area id="12" name="F_1"><appearance color="$000000FF" pen_style="5" brush_style="7"/><parents>10;13</parents><orientation>true</orientation><operators>*</operators></Area><PointWDC id="14" name="P3"><appearance shape="0" add_name2name="true"/><parents>1;7</parents><position x="3" y="1.996" x_term="3" y_term="Z1"/></PointWDC><ObjectName id="15" name="Name1"><parents>14</parents><position x="3.15" y="1.996" width="5.95312499999999" height="2.80458333333333"/><text><![CDATA[P<sub>3</sub>]]></text></ObjectName></objlist></dg:drawing>