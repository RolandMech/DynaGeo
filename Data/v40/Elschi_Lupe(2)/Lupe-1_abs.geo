<?xml version="1.0"?>
<dg:drawing xmlns:dg="http://www.dynageo.com/xml/dg12" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.dynageo.com/xml/dg12 http://www.dynageo.com/xml/dg12.xsd"><header><created prog_name="EUKLID DynaGeo" prog_version="4.0.0.549" date="2015-09-14T14:48:19"/><edited prog_name="EUKLID DynaGeo" prog_version="4.0.0.549" date="2015-09-14T16:04:57"/></header><windowdata><log_window xmin="-12.3031170542369" xmax="23.8389429373494" ymin="-7.9639531899469" ymax="7.93749487370123"/><scr_window width="1366" height="601"/><startfont fontname="Arial" fontsize="12" fontcharset="0"/><options LengthDecimals="6" DefLocLineStatus="2"/></windowdata><objlist><Origin id="1" name="O" cosys_type="0"><appearance color="$00808080"/><position x="0" y="0"/></Origin><Axis id="2" name="xa" label="x"><appearance color="$00808080" shape="0" brush_style="0"/><parents>1</parents><position x1="0" y1="0" x2="1" y2="0"/></Axis><Axis id="3" name="ya" label="y"><appearance color="$00808080" shape="0" brush_style="0"/><parents>1</parents><position x1="0" y1="0" x2="0" y2="1"/></Axis><UnityPoint id="4" name="X_1"><appearance color="$00C0C0C0" brush_style="0" visible="false"/><parents>2</parents><position x="1" y="0"/></UnityPoint><UnityPoint id="5" name="Y_1"><appearance color="$00C0C0C0" brush_style="0" visible="false"/><parents>3</parents><position x="0" y="1"/></UnityPoint><Graph id="6" name="f" trace_status="3" term="abs(x)"><appearance color="$00FF0000" line_width="3" shape="0" brush_style="0" add_name2name="true"/><points>-15.9173230533955;15.9173230533955;-15.9173230533955 -14.7759948431349;14.7759948431349;-14.7759948431349 -13.6346666328743;13.6346666328743;-13.6346666328743 -12.4933384226137;12.4933384226137;-12.4933384226137 -11.3520102123531;11.3520102123531;-11.3520102123531 -10.2106820020925;10.2106820020925;-10.2106820020925 -9.06935379183183;9.06935379183183;-9.06935379183183 -7.92802558157121;7.92802558157121;-7.92802558157121 -6.78669737131059;6.78669737131059;-6.78669737131059 -5.64536916104997;5.64536916104997;-5.64536916104997 -4.50404095078935;4.50404095078935;-4.50404095078935 -3.36271274052873;3.36271274052873;-3.36271274052873 -2.22138453026811;2.22138453026811;-2.22138453026811 -1.6507204251378;1.6507204251378;-1.6507204251378 -1.08005632000749;1.08005632000749;-1.08005632000749 -0.794724267442336;0.794724267442336;-0.794724267442336 -0.509392214877181;0.509392214877181;-0.509392214877181 -0.366726188594603;0.366726188594603;-0.366726188594603 -0.224060162312026;0.224060162312026;-0.224060162312026 -0.152727149170737;0.152727149170737;-0.152727149170737 -0.0813941360294484;0.0813941360294484;-0.0813941360294484 -0.045727629458804;0.045727629458804;-0.045727629458804 -0.0100611228881597;0.0100611228881597;-0.0100611228881597 0.0256053836824847;0.0256053836824847;0.0256053836824847 0.0612718902531291;0.0612718902531291;0.0612718902531291 1.20260010051375;1.20260010051375;1.20260010051375 2.34392831077437;2.34392831077437;2.34392831077437 3.48525652103499;3.48525652103499;3.48525652103499 4.62658473129561;4.62658473129561;4.62658473129561 5.76791294155623;5.76791294155623;5.76791294155623 6.90924115181685;6.90924115181685;6.90924115181685 8.05056936207747;8.05056936207747;8.05056936207747 9.19189757233809;9.19189757233809;9.19189757233809 10.3332257825987;10.3332257825987;10.3332257825987 11.4745539928593;11.4745539928593;11.4745539928593 12.6158822031199;12.6158822031199;12.6158822031199 13.7572104133806;13.7572104133806;13.7572104133806 14.8985386236412;14.8985386236412;14.8985386236412 16.0398668339018;16.0398668339018;16.0398668339018 17.1811950441624;17.1811950441624;17.1811950441624 18.322523254423;18.322523254423;18.322523254423 19.4638514646837;19.4638514646837;19.4638514646837 20.6051796749443;20.6051796749443;20.6051796749443 21.7465078852049;21.7465078852049;21.7465078852049 22.8878360954655;22.8878360954655;22.8878360954655 24.0291643057262;24.0291643057262;24.0291643057262 25.1704925159868;25.1704925159868;25.1704925159868 26.3118207262474;26.3118207262474;26.3118207262474 27.453148936508;27.453148936508;27.453148936508</points></Graph><Point id="7" name="A"><appearance color="$0000D900" brush_style="0" add_name2name="true"/><parents>6</parents><position x="0" y="0"/></Point><LogSlider id="8" name="h" show_name="true"><appearance color="$0000D900"/><position x="-11.7210340968321" y="7.01145380510275" width="250" height="33"/><value min="0.0001" actual="1" max="1" quant="0" ani_step="0.001"/></LogSlider><ObjectName id="14" name="Name3"><appearance color="$0000D900"/><parents>7</parents><position x="-0.132291581228354" y="0.476694162459971" width="5.95312115527593" height="2.8045815220411"/><text><![CDATA[A]]></text></ObjectName><ObjectName id="15" name="Name4"><appearance color="$00FF0000"/><parents>6</parents><position x="-0.969357879040964" y="0.0551849137497102" width="5.95312115527593" height="2.8045815220411"/><text><![CDATA[f]]></text></ObjectName></objlist></dg:drawing>