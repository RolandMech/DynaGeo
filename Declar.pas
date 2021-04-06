unit Declar;

interface

uses messages;

const
  cmd_Drag          =  0;
  cmd_MoveName      =  1;
  cmd_MarkRect      =  2;
  cmd_BlinkBaseObj  =  3;
  cmd_Update        =  4;
  cmd_sw2contds     =  5;        { "SW_itch To Cont_inuity D_rag S_trategy"    }
  cmd_sw2detds      =  6;        { "SW_itch To Det_erministic D_rag S_trategy" }
  cmd_AdjNumObj     =  7;
  cmd_EnableBlink   =  8;        { nur für TGeoTimer verwendet ! }
  cmd_InitCRMsg     =  9;        { nur für TGeoTimer verwendet ! }
  cmd_ContextMenu   = 10;

  cmd_Game01        = 13;        { Spiel "Winkel schätzen"           }
  cmd_Game02        = 14;        { Spiel "Winkel mit Geo3eck messen" }
  cmd_ExitGame02    = 15;        { Ende des Spiels verwalten         }

  cmd_Options       = 20;
  cmd_CheckSol      = 30;        { Beweiser aufrufen }
  cmd_GeoGroup      = 31;
  cmd_Chordal       = 32;
  cmd_RegPoly       = 33;
  cmd_Polare        = 34;
  cmd_Pol           = 35;
  cmd_SRichtTerm    = 36;        { Strahl mit bestimmter Richtung }
  cmd_CircleSLR     = 37;        { Circle with S_egment L_ength R_adius }

  cmd_SaveDGJHTML   = 38;
  cmd_SaveDGXHTML   = 39;
  cmd_SaveGMAHTML   = 40;

  cmd_Verging       = 41;
  cmd_PtCoord       = 42;
  cmd_Strahl        = 43;
  cmd_Arc           = 44;
  cmd_Vector        = 45;

  cmd_MirrorAxisObj    = 47;
  cmd_MirrorCentreObj  = 49;
  cmd_MoveObj          = 51;
  cmd_RotateObj        = 53;
  cmd_StretchObj       = 55;
  cmd_MirrorCircleObj  = 56;
  cmd_DefineAffin      = 57;
  cmd_MapObj           = 58;
  cmd_RepeatMapping    = 59;

  cmd_EditColour       = 61;
  cmd_EditPointStyle   = 62;
  cmd_EditLineStyle    = 63;
  cmd_EditPattern      = 64;
  cmd_EditRadius       = 65;
  cmd_EditAngle        = 66;
  cmd_EditCoords       = 67;
  cmd_EditLength       = 68;
  cmd_EditLocLineStyle = 69;
  cmd_EditLocLineDyna  = 70;

  cmd_EditLocLineCurve = 72;
  cmd_EditRange        = 73;
  cmd_EditTerm         = 74;
  cmd_EditLocLineStnd  = 75;
  cmd_EditFunktion     = 76;
  cmd_EditRieIntCount  = 77;

  cmd_NumberObj    = 78;
  cmd_TermObj      = 79;
  cmd_Area2Foregr  = 81;  // früher: cmd_Poly2Foregr
  cmd_TogglePolyF  = 82;
  cmd_EditComment  = 88;
  cmd_MeasureSL    = 89;
  cmd_Comment      = 90;
  cmd_Image        = 91;
  cmd_ConstrText   = 92;
  cmd_ImageEdit    = 93;
  cmd_Group        = 94;
  cmd_DynaHelp     = 95;
  cmd_EditMap      = 96;
  cmd_SetDotPt     = 97;
  cmd_LatticePt    = 98;

  cmd_New       = 101;
  cmd_Load      = 102;
  cmd_Save      = 103;
  cmd_SaveAs    = 104;
  cmd_PrnInit   = 105;
  cmd_Print     = 106;
  cmd_Exit      = 107;
  cmd_FileProp  = 108;

  cmd_PonLine   = 109;
  cmd_ZoomReset = 111;
  cmd_ToggleVis = 112;
  cmd_NameObj   = 113;
  cmd_DelObj    = 114;
  cmd_ZoomIn    = 115;
  cmd_ZoomOut   = 116;
  cmd_Slide     = 117;
  cmd_ShowAll   = 118;
  cmd_EditDraw  = 119;

  cmd_PCreate   = 121;     { Basis-Punkt }
  cmd_SCreate   = 122;     { Strecke zwischen 2 Punkten }
  cmd_GCreate   = 123;     { Gerade durch 2 Punkte }
  cmd_KCreate   = 124;     { Kreis um Mittelpunkt durch Kreispunkt }
  cmd_DCreate   = 125;     { Dreieck }
  cmd_RCreate   = 126;     { Basis-Gerade }
  cmd_FCreate   = 127;     { Basis-Kreis }
  cmd_LCreate   = 128;     { Strecke fester Länge }
  cmd_MCreate   = 129;     { Kreis mit bestimmtem Radius }
  cmd_Circle3P  = 130;     { Kreis durch 3 Punkte }
  cmd_NCreate   = 131;     { Polygon }

  cmd_Schnitt    = 132;
  cmd_Mitte      = 133;
  cmd_LotStrecke = 134;
  cmd_MSenkr     = 135;
  cmd_WHalb      = 136;
  cmd_Parall     = 137;
  cmd_Lot        = 138;
  cmd_GRichtTerm = 139;

  cmd_DefMakro     = 141;
  cmd_DelMakro     = 142;
  cmd_LoadMakro    = 143;
  cmd_SaveMakro    = 144;
  cmd_RunMakro     = 145;
  cmd_EditHlpMakro = 146;
  cmd_ChooseMakro  = 147;

  cmd_ShowGrowth   = 151;
  cmd_BindP2L      = 152;
  cmd_ReleaseP     = 153;
  cmd_MarkAngle    = 154;
  cmd_MeasureAngle = 155;
  cmd_MeasureDist  = 156;
  cmd_TermInput    = 157;
  cmd_MakeLocLine  = 158;   { Ortslinie aufzeichnen }
  cmd_MeasureArea  = 159;

  cmd_HelpBasics   = 164;
  cmd_HelpScreen   = 165;
  cmd_HelpKeyMouse = 166;
  cmd_Licence      = 167;
  cmd_Register     = 168;

  { für Makro-Einträge reservierte Menü-Ids :

                   = 170
                 ... 199  }

  cmd_WriteToCB    = 201;
  cmd_ReadFromCB   = 202;  { wird noch nicht benutzt }
  cmd_Undo         = 203;
  cmd_UndoUndo     = 204;
  cmd_Preview      = 205;
  cmd_FillArea     = 206;
  cmd_CutArea      = 207;

  cmd_WHalbKomp    = 210;

  cmd_AnimaParams  = 212;   { Animationsbefehle }
  cmd_ResetAnima   = 213;
  cmd_RunAnimaBK   = 214;
  cmd_RunAnimaFD   = 215;
  cmd_StopAnima    = 216;

  cmd_Curves       = 220;   { für die Hilfe zur "Kurven"-Werkzeugleiste }
  cmd_Conic        = 221;   { Kegelschnitt durch 5 Punkte                      }
  cmd_EllipseF     = 222;   { Ellipse aus 2 Brennpunkten und 1 Kurvenpunkt     }
  cmd_EllipseS     = 223;   { Ellipse aus Mittelpunkt und 2 Scheiteln          }
  cmd_EllipseK     = 224;   { Ellipse aus Mittelpunkt und 2 konj. Durchmessern }
  cmd_ParabelF     = 225;   { Parabel aus Brennpunkt und Leitgerade            }
  cmd_ParabelT     = 226;   { Parabel aus 2 Tangenten und den Berührpunkten    }
  cmd_HyperbelA    = 227;   { Hyperbel aus Asymptoten und 1 Kurvenpunkten      }
  cmd_HyperbelF    = 228;   { Hyperbel aus 2 Brennpunkten und 1 Kurvenpunkt    }
  cmd_Polynom      = 229;   { Polynomfunktion durch vorgegebene Punkte }

  cmd_Graph        = 230;   { Funktions-Schaubild }
  cmd_Tangente     = 231;   { Tangente in einem Punkt einer Kurve }
  cmd_Normale      = 232;   { Normale auf eine Kurve in einem Kurvenpunkt }
  cmd_GraphArea    = 233;   { Fläche zwischen Kurve und x-Achse (bzw. 2. Kurve)}
  cmd_Riemann      = 234;   { Unter-/Obersumme einer Integralfläche }
  cmd_MakeEnvelop  = 235;   { Einhüllende einer Geraden }

  cmd_Pt2BasePt    = 237;
  cmd_CombinePts   = 238;
  cmd_QuantP       = 239;
  cmd_CoordSys     = 241;
  cmd_FixPt        = 242;
  cmd_UnfixPt	     = 243;
  cmd_Clip2Grid	   = 244;
  cmd_BindTBox2Obj = 245;
  cmd_ReleaseTBox  = 246;
  cmd_MagnGlass    = 248;

{ cmd_*  muss für "echte Befehle" stets kleiner als 256 bleiben (Byte!),
         weil man sonst keine Mengen von Befehls-Ids bilden kann !       }

  cmd_NEckReady       = 256;
  cmd_NoData          = 257;
  cmd_AddData         = 258;
  cmd_GroupsChanged   = 259;
  cmd_GroupShowName   = 260;
  cmd_GroupHideName   = 261;
  cmd_EditGroup       = 262;
  cmd_EnterCond       = 263;
  cmd_ExitCond        = 264;
  cmd_DefAffReady     = 265;
  cmd_Switch2LowerSum = 266;
  cmd_Switch2UpperSum = 267;
  cmd_ShowFunkTable   = 277;
  cmd_CloseFunkTable  = 278;
  cmd_EditXCoord      = 280;
  cmd_hideName        = 281;
  cmd_EditEnvLines    = 282;
  cmd_EditEnvCurve    = 283;
  cmd_ShowSlider      = 284;
  cmd_ShowCounter     = 285;

  cmd_SecantSlopes    = 291;
  cmd_SlopeTriangles  = 292;
  cmd_SecSlopeFuncs   = 293;
  cmd_CurvatureCircle = 294;
  cmd_CurvatureParabo = 295;

  cmd_TryLoading    = wm_App + cmd_Load;      // WM_APP = $8000 = 32768;
  cmd_AffinMapping  = wm_App + cmd_MapObj;
  cmd_Continue      = wm_App + 1210;
  cmd_PopupCommand  = wm_App + 1211;
  cmd_ExternCommand = wm_App + 1212;
  cmd_ConstrWinDown = wm_App + 1213;
  cmd_AdjToolBtn    = wm_App + 1215;
  cmd_RunAnimation  = wm_App + 1216;
  cmd_CloseEdGroup  = wm_App + 1217;
  cmd_JumpLink      = wm_App + 1218;  { für den Viewer ! }
  cmd_MappingChanged= wm_App + 1219;

  cmd_ExtMouseMove  = wm_App + 1220;  { nur im Viewer !! }
  cmd_ExtMouseClick = wm_App + 1221;  { nur im Viewer !! }

  cmd_PosFlagChange = wm_App + 1222;

  idh_spbtnRunMak   = 1217;
  idh_SelectXCmds   = 1218;   { Hilfe-Index für SelectXCmdForm }
  idh_helpcontents  = 1220;

  idh_opt_start     = 1221;
  idh_opt_darst     = 1222;
  idh_opt_meas      = 1223;
  idh_opt_intern    = 1224;
  idh_opt_menu      = 1225;
  idh_opt_kons      = 1226;
  idh_opt_export    = 1227;
  idh_opt_map       = 1228;
  idh_opt_olines    = 1229;
  idh_opt_newcfg    = 1231;

  idh_tool_main     = 1241;
  idh_tool_form     = 1242;
  idh_tool_constr   = 1243;
  idh_tool_map      = 1244;
  idh_tool_meas     = 1245;
  idh_tool_ani      = 1246;
  idh_tool_curv     = 1247;

  idh_menu_file     = 1281;
  idh_menu_edit     = 1282;
  idh_menu_draw     = 1283;
  idh_menu_constr   = 1284;
  idh_menu_map      = 1285;
  idh_menu_meas     = 1286;
  idh_menu_macro    = 1287;
  idh_menu_misc     = 1288;
  idh_menu_help     = 1289;
  idh_menu_conics   = 1290;
  idh_menu_view     = 1291;
  idh_menu_curves   = 1292;

  idh_linkback      = 1300;
  idh_linkup        = 1301;
  idh_linkforward   = 1302;
  idh_checksolution = 1350;
  idh_checksolcfg   = 1351;
  idh_viewercmds    = 1352;
  idh_geo3eck       = 1353;
  idh_boolterm      = 1354;
  idh_insthints     = 1355;
  idh_magnglass     = 1356;
  idh_game_01       = 1357;
  idh_game_02       = 1358;

  idh_locline_standard = 27004;
  idh_graph_varproblem = 27005;
  idh_impress          = 27006;
  idh_contents         = 27007;
  idh_install          = 27008;
  idh_installhints     = 27009;
  idh_internals        = 27010;
  idh_intersect        = 27011;
  idh_jump_pt          = 27012;
  idh_coordsystem      = 27013;
  idh_deg_rad_problem  = 27014;
  	

resourcestring

  id_picname   = 'Bild';
  id_and       = ' und ';

  id_hint00 = 'Zugmodus';
  id_hint01 = 'Irgend ein Objekt angeben.';
  id_hint02 = 'Einen Punkt (durch Klicken) erzeugen.';
  id_hint03 = 'Anfangs- und Endpunkt der Strecke angeben.';
  id_hint04 = 'Zwei Punkte angeben.';
  id_hint05 = 'Mittelpunkt und Kreispunkt angeben.';
  id_hint06 = 'Die drei Ecken angeben.';
  id_hint07 = 'Die Gerade aufziehen.';
  id_hint08 = 'Den Kreis aufziehen.';
  id_hint09 = 'Einen Punkt angeben.';
  id_hint10 = 'Zwei Linien angeben.';
  id_hint11 = 'Eine Strecke (oder zwei Punkte) angeben.';
  id_hint12 = 'Den zu spiegelnden Punkt und die Spiegelachse bzw. das Symmetriezentrum angeben. ';
  id_hint13 = 'Schenkel-, Scheitel- und Schenkelpunkt angeben.';
  id_hint14 = 'Einen Punkt und eine Gerade (oder Strecke) angeben.';
  id_hint15 = 'Die Startobjekte angeben.';
  id_hint16 = 'Einen Basispunkt und eine Linie angeben.';
  id_hint17 = 'Einen gebundenen Punkt angeben.';
  id_hint18 = 'Zwei Objekte angeben.';
  id_hint19 = 'Die Zeichnung verschieben.';
  id_hint20 = 'Einen Punkt angeben, dessen Ortslinie aufgezeichnet werden soll.';
  id_hint21 = 'An einem Basispunkt ziehen....';
  id_hint22 = 'Rückblende : ';
  id_hint23 = 'Einen neuen Wert (oder Term) für den Radius eingeben.';
  id_hint24 = 'Den Mittelpunkt angeben.';
  id_hint25 = 'Einen neuen Wert für die Länge der Strecke eingeben.';
  id_hint26 = 'Anfangspunkt und Richtung zum Endpunkt angeben.';
  id_hint27 = 'Einen neuen Wert (oder Term) für die Winkelgröße eingeben.';
  id_hint28 = 'Einen Punkt auf dem 1. Schenkel, den Scheitelpunkt und die Orientierung angeben.';
  id_hint29 = 'Die Linie angeben, auf der der Punkt erzeugt werden soll.';
  id_hint30 = 'Einen Winkel (direkt oder durch drei Punkte) angeben.';
  id_hint31 = 'Das zu benennende Objekt eingeben.';
  id_hint32 = 'Das zu löschende Objekt eingeben.';
  id_hint33 = 'Das zu verbergende bzw. sichtbar zu machende Objekt eingeben.';
  id_hint34 = 'Die Eckpunkte des N-Ecks eingeben.';
  id_hint35 = 'Die zu überwachenden Terme eingeben.';
  id_hint36 = 'Den (neuen) Ort für den Ursprung angeben.';
  id_hint37 = 'Das zu bearbeitende Objekt angeben.';
  id_hint38 = 'Die Terme für die Koordinaten des Punktes eingeben.';
  id_hint39 = 'Einen ungebundenen Basispunkt angeben.';
  id_hint40 = 'Einen Koordinatenpunkt angeben.';
  id_hint41 = 'Einen ungebundenen Basispunkt oder einen Koordinatenpunkt angeben.';
  id_hint42 = 'Einen Punkt auf dem 1. Schenkel und den Scheitelpunkt angeben.';
  id_hint43 = 'Die zu messende Strecke eingeben.';
  id_hint44 = 'Einen Punkt auf dem 1. Schenkel und den Scheitelpunkt angeben.';
  id_hint45 = 'Den Startpunkt des Bogens, den Mittelpunkt und einen Punkt in Richtung zum Endpunkt angeben.';
  id_hint46 = 'Ein N-Eck angeben.';
  id_hint47 = 'Das zu spiegelnde Objekt und die Spiegelachse angeben.';
  id_hint48 = 'Den Anfangspunkt und einen Punkt auf der Halbgeraden angeben.';
  id_hint49 = 'Editieren...';
  id_hint50 = 'Einen Punkt und den zugehörigen verschobenden Punkt angeben.';
  id_hint51 = 'Das zu verschiebende Objekt und den Verschiebungsvektor angeben.';
  id_hint52 = 'Einen zu drehenden Punkt, das Drehzentrum und einen Zielpunkt angeben.';
  id_hint53 = 'Das zu drehende Objekt, das Drehzentrum und einen Drehwinkel angeben.';
  id_hint54 = 'Den Fußpunkt und die Spitze angeben, oder: den Fußpunkt und einen "Vatervektor" angeben.';
  id_hint55 = 'Das zu spiegelnde Objekt und das Symmetriezentrum angeben.';
  id_hint56 = 'Einen Punkt und seinen Spiegelpunkt angeben.';
  id_hint57 = 'Das zu spiegelnde Objekt (Punkt, Gerade oder Kreis) und den Kreis angeben, an dem gespiegelt werden soll.';
  id_hint58 = 'Geben Sie den Zahlbereich und den aktuellen Wert des Zahl-Objekts ein.';
  id_hint59 = 'Geben Sie den Ort an, an dem das Zahl-Objekt erscheinen soll.';
  id_hint60 = ' (%s vorselektiert)';
  id_hint61 = 'Klicken Sie auf die Stelle, an der die Term-Anzeige erzeugt werden soll.';
  id_hint62 = 'Geben Sie einen neuen Term ein oder editieren Sie den vorhandenen!';
  id_hint63 = 'Einen Punkt, das Streckzentrum und den Bildpunkt des ersten Punktes angeben.';
  id_hint64 = 'Das zu streckende Objekt, das Streckzentrum und den Streckfaktor angeben.';
  id_hint65 = 'Mit der ESC-Taste können Sie das Blinken beenden.';
  id_hint66 = 'Wählen Sie die zu editierende Textbox aus!';
  id_hint67 = 'Geben Sie erst die Textbox an und dann das Objekt, an das sie gebunden werden soll.';
  id_hint68 = 'Geben Sie das Objekt an, an das die Textbox gebunden werden soll.';
  id_hint69 = 'Geben Sie den Rand des neu zu füllenden Bereiches an oder klicken Sie auf eine schon existierende Füllung.';
  id_hint70 = 'Geben Sie die zu bearbeitende Füllung an, dann die Schnittlinie und schließlich die gewünschte Teilfläche!';
  id_hint71 = 'Klicken Sie auf diejenige der beiden Halbebenen, die Sie meinen!';
  id_hint72 = 'Geben Sie die Textbox an, deren Bindung Sie lösen wollen!';
  id_hint73 = 'Geben Sie die Fläche an, die Sie nach vorne holen wollen!';
  id_hint74 = 'Wählen Sie zunächst das Objekt aus, das die Animation steuern soll!';
  id_hint75 = 'Animation läuft...';
  id_hint76 = 'Geben Sie die Linie an, an die der Punkt gebunden werden soll!';
  id_hint77 = 'Geben Sie 5 Punkte an, durch die der Kegelschnitt gehen soll!';
  id_hint78 = 'Geben Sie einen Punkt an, sowie zwei Geraden, auf denen die Streckenendpunkte liegen sollen.';
  id_hint79 = 'Klicken Sie ein Objekt an, um es zur Gruppe hinzuzufügen oder aus ihr zu entfernen.';
  id_hint80 = 'Gruppen-Eigenschaften editieren...';
  id_hint81 = 'Geben Sie den Funktionsterm ein!';
  id_hint82 = 'Geben Sie den Berührpunkt der gewünschten Tangente an!';
  id_hint83 = 'Geben Sie den Kurvenpunkt an, in dem die Normale errichtet werden soll.';
  id_hint84 = 'Geben Sie die beiden Brennpunkte und einen Punkt auf der Ellipse an.';
  id_hint85 = 'Geben Sie den Mittelpunkt, einen Hauptscheitel und einen Punkt auf dem Nebenkreis an.';
  id_hint86 = 'Geben Sie den Mittelpunkt an, sowie zwei konjugierte Punkte auf der Ellipse.';
  id_hint87 = 'Geben Sie den Brennpunkt und die Leitgerade an.';
  id_hint88 = 'Geben Sie die beiden Brennpunkte und einen Punkt auf der Hyperbel an.';
  id_hint89 = 'Geben Sie den ersten Parabelpunkt und die Tangentenrichtung an!';
  id_hint90 = 'Geben Sie den zweiten Parabelpunkt und die Tangentenrichtung an!';
  id_hint91 = 'Geben Sie die beiden Asymptoten und einen Punkt auf der Hyperbel an!';
  id_hint92 = 'Das abzubildende Objekt angeben.';
  id_hint93 = 'Geben Sie die (obere) Randfunktion und das Integrationsintervall (2 Punkte) an!';
  id_hint94 = 'Geben Sie die untere Randfunktion an oder klicken Sie auf die x-Achse!';
  id_hint95 = 'Geben Sie das Zielobjekt bzw. die Zielobjekte an!';
  id_hint96 = 'Geben Sie die Kurve an, an die die Tangente gelegt werden soll.';
  id_hint97 = 'Geben Sie die Kurve an, auf der die Normale errichtet werden soll.';
  id_hint98 = 'Geben Sie die 3 Punkte an, durch die der Kreis laufen soll.';
  id_hint99 = 'Geben Sie 2 Punkte oder Kreise ein.';
  id_hint100 = 'Geben Sie den Pol und den Kegelschnitt ein.';
  id_hint101 = 'Geben Sie die Polare und den Kegelschnitt ein.';
  id_hint102 = 'Geben Sie die Fläche an, deren Inhalt gemessen werden soll.';
  id_hint103 = 'Geben Sie die zwei Endpunkte einer Strecke ein.';
  id_hint104 = 'Geben Sie die gewünschte Anzahl der Ecken für das regelmäßige N-Eck ein.';
  id_hint105 = 'Geben Sie die Randfunktion und das Integrationsintervall (2 Punkte) an!';
  id_hint106 = 'Geben Sie die Anzahl der Teilintervalle und die Art der Riemann-Summe ein.';
  id_hint107 = 'Geben Sie eine Radius-Strecke ein, und dann den Mittelpunkt.';
  id_hint108 = 'Geben Sie den Punkt an, den Sie in einen freien Basispunkt verwandeln wollen.';
  id_hint109 = 'Geben Sie die zwei Punkte an, die Sie zusammenführen wollen.';
  id_hint110 = 'Geben Sie die neue x-Koordinate ein.';
  id_hint111 = 'Klicken Sie an die Stelle, wo der Gitterpunkt erzeugt werden soll.';
  id_hint112 = 'Eine Gerade angeben, deren Einhüllende aufgezeichnet werden soll.';
  id_hint113 = 'Geben Sie einen Punkt auf einem Funktionsgraphen an.';
  id_hint114 = 'Wähle erst die Art des Winkels aus, schätze dann seine Weite und gib den Schätzwert im Fenster ein.';
  id_hint115 = 'Miss die Winkelweite mit Hilfe des Geodreiecks, und gib den Messwert im Fenster ein!';
  id_hint116 = 'Geben Sie alle Punkte ein, durch die das Schaubild der Polynom-Funktion verlaufen soll.';
  id_hint117 = '';
  id_hint118 = '';
  id_hint119 = '';


  id_mess00 = '- message 00 -';
  id_mess01 = 'Wollen Sie wirklich alle markierten Objekte löschen?';
  id_mess02 = 'Alle erzeugenden Punkte eingeben...';
  id_mess03 = 'Um zirkuläre Verwandtschaften zu vermeiden, musste eine Punktbindung aufgehoben werden.';
  id_mess04 = 'Die beiden Punkte liegen zu dicht beieinander!';
  id_mess05 = 'Die neu erzeugte Strecke ist ungültig, weil ihre Endpunkte ungünstig zueinander liegen.'#13#10 +
              'Sie wird sichtbar, wenn Sie sie (durch Verziehen) günstiger positionieren.';
  id_mess06 = 'Diese Strecke fester Länge kann nicht erzeugt werden, weil dabei'#13#10 +
              'eine zirkuläre Verwandtschaftsbeziehung entstehen würde.'#13#10#10 +
              'Wollen Sie stattdessen eine gewöhnliche Strecke erzeugen?';
  id_mess07 = '%s auf %s';
  id_mess08 = 'An diese Linie kann der Punkt nicht gebunden werden, weil er zu eng mit ihr verwandt ist !';
  id_mess09 = 'Sie haben die Farbe einer Achse des Koordinatensystems geändert.'#13#10 +
              'Möchten Sie, dass das gesamte Koordinatensystem in der neuen Farbe erscheint?';
  id_mess10 = ' <  ungültig  > ';
  id_mess11 = 'Der Winkel konnte nicht gemessen werden.';
  id_mess12 = 'Alle verborgenen Objekte werden dauerhaft sichtbar gemacht.'#13#10 +
              'Dieser Vorgang kann nur wieder rückgängig gemacht werden,'#13#10 +
              'indem Sie alle unerwünschten Objekte einzeln verbergen.'#13#10#10 +
              'Wollen Sie wirklich alle Objekte sichtbar schalten?';
  id_mess13 = 'Es sind keine verborgenen gültigen Objekte (mehr) vorhanden.';
  id_mess14 = 'Dieser Befehl ist leider noch nicht verfügbar.';
  id_mess15 = 'Die Eingabe-Objekte müssen alle verschieden voneinander sein.';
  id_mess16 = 'Ein solches Objekt existiert schon und wird daher nicht nochmals erzeugt.';
  id_mess17 = 'Die Ortslinienpunkte scheinen auf einer Geraden zu liegen.'#13#10#10 +
              'Soll DynaGeo in Zukunft versuchen, an Stelle der eigentlichen'#13#10 +
              'Ortslinie diese Gerade zu verwenden und anzuzeigen?';
  id_mess18 = 'Die Ortslinienpunkte scheinen auf einem Kreis zu liegen.'#13#10#10 +
              'Soll DynaGeo in Zukunft versuchen, an Stelle der eigentlichen'#13#10 +
              'Ortslinie diesen Kreis zu verwenden und anzuzeigen?';
  id_mess19 = 'Die Gerade konnte nicht erzeugt werden.'#13#10 +
              'Sie müssen die Gerade mit der gedrückten linken Maustaste aufziehen.';
  id_mess20 = 'Der Kreis konnte nicht erzeugt werden.'#13#10 +
              'Sie müssen den Kreis mit der gedrückten linken Maustaste aufziehen.';
  id_mess21 = 'Die laufende Rückblende wird abgebrochen.';
  id_mess22 = 'Die Update-Strategie für den Zugmodus wurde'#13#10 +
              'auf "Stetige Aktualisierung" umgestellt.'#13#10#10 +
              'Bitte beachten Sie, dass diese neue Einstellung'#13#10 +
              'nur für die aktuelle Zeichnung gilt!';
  id_mess23 = 'Die Update-Strategie für den Zugmodus wurde auf'#13#10 +
              '"Deterministische Aktualisierung" umgestellt.'#13#10#10 +
              'Dies ist die Standard-Einstellung, die'#13#10 +
              'auch für jede neue Zeichnung gilt!';
  id_mess24 = 'Animationen können nur durch bestimmte Objekte gesteuert werden,'#13#10 +
              'z.B. durch Zahlobjekte oder durch Basispunkte, die an Strecken'#13#10 +
              'oder Kreise gebunden sind.'#13#10#10 +
              'Ihre Zeichnung enthält aber (noch) keine geeigneten Objekt.';
  id_mess25 = 'Zahlobjekt %s editieren';
  id_mess26 = 'Dies ist ein unbekannter Befehl!';
  id_mess27 = 'Falscher Objekt-Typ!';
  id_mess28 = 'Abstrakte Methode (%s) aufgerufen!';
  id_mess29 = 'Die gewählte Standard-Menü-Konfiguration konnte nicht in die'#13#10 +
              'Liste der privaten Menü-Konfigurationen verschoben werden!';
  id_mess30 = 'Die ausgewählte private Menü-Konfiguration konnte nicht in die'#13#10 +
              'Liste der globalen Menü-Konfigurationen verschoben werden!';
  id_mess31 = 'Die ausgewählte globale Menü-Konfiguration konnte nicht als'#13#10 +
              'Standard-Menü-Konfiguration eingetragen werden!';
  id_mess32 = 'Die aktuellen Einstellungen konnten'#13#10 +
              'nicht als Standard-Einstellungen gespeichert werden!';
  id_mess33 = 'Der aktuelle Wert ist ungültig.';
  id_mess34 = 'Ein leerer Term ist hier nicht zulässig.';
  id_mess35 = ' Kreisradius : ';
  id_mess36 = ' Winkelgröße : ';
  id_mess37 = 'In einer (so) leeren Zeichnung ist keine Rückblende nötig.';
  id_mess38 = 'Die Daten wurden erfolgreich in die'#13#10 +
              'Initialisierungsdatei geschrieben.';
  id_mess39 = 'Die Netzwerk-Optionen konnten nicht gespeichert werden!';
  id_mess40 = 'Dieser Befehl speichert die aktuellen Benutzer-Einstellungen'#13#10 +
              'des Administrators als Standard-Einstellungen für alle Benutzer ab.'#13#10#10 +
              'Wollen Sie das wirklich?';
  id_mess41 = 'Das Koordinatensystem kann nicht gelöscht, sondern nur verborgen werden.'#13#10 +
              'Gelöscht werden lediglich die Fixierungen von Koordinatenpunkten.'#13#10#10 +
              'Wollen Sie alle Koordinatenpunkte in Basispunkte verwandeln?';
  id_mess42 = 'Diese Textbox ist nicht gebunden, daher'#13#10 +
              'kann auch keine Bindung gelöst werden.';
  id_mess43 = 'Dieser Punkt ist schon über eine Strecke fester Länge an einen abgeleiteten Punkt gebunden;'#13#10 +
              'eine weitere Bindung ist in diesem Fall leider nicht mehr möglich. ';
  id_mess44 = 'Es ist kein gültiger Konstruktionsschritt registriert,'#13#10 +
              'der zurückgenommen werden könnte.';
  id_mess45 = 'Es sind keine gelöschten Objekte (mehr) vorhanden.';
  id_mess46 = 'Fehler beim Update der Registrierung von DynaGeoX!';
  id_mess47 = 'Ein solches Objekt existierte schon als verborgenes Objekt;'#13#10 +
              'es wurde wieder sichtbar gemacht.';
  id_mess48 = 'Die vorliegende Datei wurde offenbar auf einem Computer mit einem größeren Bildschirm erstellt:'#13#10 +
              'sie enthält Objekte, die außerhalb des hier verfügbaren Darstellungsbereichs liegen.'#13#10#10 +
              'DynaGeo wird diese Objekte in den darstellbaren Bereich verschieben. Möglicherweise werden'#13#10 +
              'sie aber erst sichtbar, wenn das DynaGeo-Fenster in den Vollbildmodus geschaltet wird.';
  id_mess49 = 'Die vorliegende Datei enthält Objekte, die außerhalb des aktuellen Fensters liegen'#13#10 +
              'und nicht durch Zoomen sichtbar gemacht werden können.'#13#10#10 +
              'Sie erscheinen erst, wenn das DynaGeo-Fenster entsprechend vergrößert oder'#13#10 +
              'in den Vollbild-Modus geschaltet wird.';
  id_mess50 = 'Standard  ( Alle Befehle verfügbar )';
  id_mess51 = 'Sie haben %d Befehle für den Viewer aktiviert, das aktuelle Viewer-Fenster'#13#10 +
              'kann aber höchstens %d Befehle darstellen.'#13#13#10 +
              'Sie können entweder die Höhe des Viewer-Fensters vergrößern'#13#10 +
              'oder die Anzahl der aktiven Befehle vermindern.';
  id_mess52 = 'Bitte überprüfen Sie, ob das DynaGeoX-Fenster in der'#13#10 +
              'entsprechenden HTML-Datei auch groß genug ist, um alle'#13#10 +
              'gewählten Befehle anzeigen zu können!';
  id_mess53 = 'Großes Logo anzeigen';
  id_mess54 = 'Logo verkleinern';
  id_mess55 = 'Objekt auswählen...';
  id_mess56 = ' Streckenlänge : ';
  id_mess57 = 'Makro auswählen...';
  id_mess58 = 'Termobjekt %s editieren';
  id_mess59 = 'Ungültige Boolsche Bedingung!';
  id_mess60 = 'Diese Datei wurde offenbar mit einer neueren Version von DynaGeo erstellt.'#13#10;
  id_mess61 = 'Sie enthält einige unbekannte Objekte. Diese wurden deaktiviert, weshalb'#13#10 +
              'die Zeichnung wahrscheinlich unvollständig ist.'#13#13#10;
  id_mess62 = 'Sie enthält unbekannte Objekte, von denen weitere Objekte abhängen.'#13#10 +
              'All diese Objekte der Zeichnung mussten deaktiviert werden. Daher'#13#10 +
              'ist es sehr wahrscheinlich, dass die vorliegende Version von DynaGeo'#13#10 +
              'diese Zeichnung nicht korrekt anzeigen kann.'#13#13#10;
  id_mess63 = 'Schauen Sie doch mal auf der DynaGeo-Homepage (www.dynageo.de) nach,'#13#10 +
              'ob ein Update verfügbar ist.';
  id_mess64 = 'Eine gültige Gruppe muss mindestens ein Objekt enthalten.'#13#10 +
              'Die aktuelle Gruppe ist jedoch derzeit leer.'#13#10#10 +
              'Wollen Sie die Gruppe "%s" löschen?';
  id_mess65 = 'Bitte geben Sie der Gruppe eine eindeutige Bezeichnung!';
  id_mess66 = 'Der Name enthält ein ungültiges Zeichen.';
  id_mess67 = 'Dieser Name wurde schon für ein anderes Objekt verwendet.';
  id_mess68 = '(nicht editierbar)';
  id_mess69 = '(editierbar)';
  id_mess70 = 'Die aktuelle Abbildung ist auf dieses Objekt nicht anwendbar.';
  id_mess71 = 'Fataler Verwandtschafts-Fehler. Bitte schließen Sie EUKLID DynaGeo.';
  id_mess72 = 'Neue Menükonfiguration (%s)';
  id_mess73 = 'Gruppe "%s" editieren';
  id_mess74 = 'Neue Gruppe anlegen';
  id_mess75 = 'Nur Zirkel und Lineal';
  id_mess76 = 'Nur affine Objekte';
  id_mess77 = 'Keine Abbildungen, keine Kegelschnitte';
  id_mess78 = 'Die Gruppe "%s" konnte nicht gefunden werden!';
  id_mess79 = 'Dieses Kommando würde die Ausführung des laufenden Befehls abbrechen.';
  id_mess80 = #13#10'Wollen Sie das wirklich ?';
  id_mess81 = 'Dieser Befehl würde die laufende Ortslinien-Aufzeichnung abbrechen.';
  id_mess82 = 'Dieser Befehl würde die laufende Polygon-Erstellung abbrechen.';
  id_mess83 = 'Dieser Befehl würde die laufende Makro-Ausführung abbrechen.';
  id_mess84 = 'Dieser Befehl würde die laufende Makro-Aufzeichnung abbrechen.';
  id_mess85 = 'Dieser Term ist ungültig.'#13#10 +
              'Er enthält einen Link, der zu einer zirkulären Verwandtschaftsbeziehung führen würde.';
  id_mess86 = 'Kein Abbildungsobjekt gefunden!';
  id_mess87 = 'Es ist ein unbekannter Fehler aufgetreten.';
  id_mess88 = 'Da Sie den ursprünglichen Namen "%s" des Objekts inzwischen'#13#10 +
              'anderweitig vergeben haben, musste das wieder zum Leben'#13#10 +
              'erweckte Objekt umbenannt werden.'#13#10#10 +
              'Solange Sie nichts anderes beschließen, heißt es nun "%s".';
  id_mess89 = 'Der Name muss mindestens 1 Zeichen lang sein.'#13#10 +
              'Leere Namen sind nicht erlaubt.';
  id_mess90 = ' Term : ';
  id_mess91 = ' Gruppe "%s" ';
  id_mess92 = 'Dieser Punkt kann nicht in einen freien Basispunkt'#13#10 +
              'verwandelt werden, weil dabei eine zirkuläre'#13#10 +
              'Verwandtschaftsbeziehung entstehen würde.';
  id_mess93 = 'Das Koordinatensystem ist in einer Gruppe enthalten, die seine Sichtbarkeit'#13#10 +
              'regelt. Aktuell sind alle Elemente dieser Gruppe verborgen. Daher ist auch'#13#10 +
              'der Dialog zum Editieren der Einstellungen des Koordinatensystems deaktiviert.'#13#10#10 +
              'Wenn Sie diesen Dialog nun aber trotzdem aufrufen wollen, muss'#13#10 +
              'das Koordinatensystem zuvor aus allen Gruppen entfernt werden.'#13#10 +
              'Soll DynaGeo das jetzt für Sie tun?';
  id_mess94 = 'Das Koordinatensystem ist in einer Gruppe enthalten, die seine Sichtbarkeit'#13#10 +
              'regelt. Daher ist im folgenden Dialog das entsprechende Feld zur Einstellung'#13#10 +
              'der Sichtbarkeit deaktiviert. Es wird erst wieder aktiviert, wenn Sie das'#13#10 +
              'Koordinatensystem aus der Gruppe "%s"'#13#10 +
              'entfernen.';
  id_mess95 = ' Funktions-Term f(x) = ';
  id_mess96 = 'Der Punkt %s ist Berührpunkt einer Tangente an eine Kurve.'#13#10 +
              'Wenn Sie die Bindung von %s an diese Kurve aufheben, dann muss'#13#10 +
              'die Tangente gelöscht werden (und alle eventuell von ihr'#13#10 +
              'abhängigen Objekte ebenfalls).'#13#10#10 +
              'Wollen Sie das wirklich?';
  id_mess97 = 'Scherung';
  id_mess98 = 'orthogonalen axialen Streckung';
  id_mess99 = 'Schrägspiegelung';
  id_mess100 = 'allgemeinen Achsenaffinität';
  id_mess101 = 'Euler''schen Affinität';
  id_mess102 = 'Affin-Drehung';
  id_mess103 = 'allgemeinen Affinität';
  id_mess104 = 'Keine Kegelschnitte';
  id_mess105 = 'Die Ortslinie konnte nicht in eine Standardkurve'#13#10 +
               'umgewandelt werden.';
  id_mess106 = 'Die Ortslinie wurde erfolgreich in eine'#13#10 +
               'Standardkurve umgewandelt.';
  id_mess107 = 'Sie wollen die Standardkurven-Darstellung der Ortslinie'#13#10 +
               'abschalten. Dabei gehen all diejenigen Objekte der Zeichnung'#13#10 +
               'verloren, welche von dieser Standardkurve abhängen.'#13#10#10 +
               'Wollen Sie das wirklich?';
  id_mess108 = 'Für diese Ortslinie wurde die Standardkurven-'#13#10 +
               'Darstellung abgeschaltet.';
  id_mess109 = 'Ein Term enthält einen Syntax-Fehler.';
  id_mess110 = 'An dieser Stelle kreuzen sich %d Linien.'#13#10#10 +
               'Wenn Sie einen Schnittpunkt erzeugen wollen, verwenden Sie bitte den'#13#10 +
               'Befehl "Schnittpunkt erzeugen" und geben Sie die beiden Linien an,'#13#10 +
               'die geschnitten werden sollen.'#13#10#10 +
               'Wenn Sie einen freien Basispunkt erzeugen wollen, dann wiederholen'#13#10 +
               'Sie bitte den aktuellen Befehl. Klicken Sie dabei jedoch an eine noch'#13#10 +
               'freie Stelle der Zeichnung! Danach können Sie den neu erzeugten'#13#10 +
               'Basispunkt an jede gewünschte andere Stelle ziehen.';
  id_mess111 = 'Der Korrektheits-Test für die Konstruktion'#13#10 +
               'konnte nicht initialisiert werden.'#13#10#10 +
               'Möglicherweise ist die Zeichnung beschädigt,'#13#10 +
               'oder Sie haben falsche Zielobjekte angegeben.';
  id_mess112 = 'Sehr gut !!!';
  id_mess113 = 'Diese Konstruktion ist korrekt.';
  id_mess114 = 'Schade !';
  id_mess115 = 'Diese Konstruktion ist falsch.';
  id_mess116 = 'Die Korrektheits-Bedingung enthält noch einen Fehler:'#13#10 +
               'die Anzahl der schließenden Klammern stimmt nicht mit'#13#10 +
               'der Zahl der öffnenden Klammern überein.';
  id_mess117 = 'Die Korrektheits-Bedingung enthält noch einen Syntax-Fehler';
  id_mess118 = '<b><i>Hilfe:</i></b> (Klicke auf den Pfeil!)<br><hr><br>' +
               '{ Hier den eigenen Hilfetext einfügen! }';
  id_mess119 = 'Das Viewer-Fenster ist ziemlich groß. Möglicherweise kann es auf'#13#10 +
               'manchen Bildschirmen Probleme bei der Darstellung geben.'#13#10#10 +
               'Wollen Sie die Fenster-Abmessungen trotzdem so beibehalten?';
  id_mess120 = 'Die Datei "%s" '#13#10 + 'existiert (noch) nicht.'#13#10#10 +
               'Wollen Sie den Link "%s" trotzdem beibehalten?';
  id_mess121 = 'Die Korrektheits-Bedingung ist leer. Eine eventuell in Ihrer'#13#10 +
               'Zeichnung schon vorhandene Korrektheits-Prüfung wird gelöscht.'#13#10#10 +
               'Wollen Sie das wirklich?';
  id_mess122 = 'Wenn Sie dieses Objekt löschen, wird auch die vorhandene'#13#10 +
               'Korrektheits-Prüfung ungültig und muss gelöscht werden.'#13#10#10 +
               'Wollen Sie das wirklich?';
  id_mess123 = 'Wenn Sie dieses Objekt löschen, wird auch die vorhandene'#13#10 +
               'Korrektheits-Prüfung ungültig und muss gelöscht werden.'#13#10 +
               'Außerdem hängen weitere Objekte von dem zu löschenden'#13#10 +
               'Objekt ab und müssten ebenfalls gelöscht werden.'#13#10#10 +
               'Wollen Sie das wirklich?';
  id_mess124 = 'Der angegebene Pfad zur Zieldatei'#13#10 +
               '   "%s"'#13#10 +
               'ist (noch) nicht gültig.'#13#10#10 +
               'Wollen Sie ihn trotzdem beibehalten?';
  id_mess125 = 'Sie müssen sowohl einen anzuzeigenden Text als auch einen'#13#10 +
               'gültigen (relativen) Pfad zur Zieldatei eingeben.'#13#10#10 +
               'Bitte vervollständigen Sie Ihre Eingabe!';
  id_mess126 = 'Diese Linie umschließt keine messbare Fläche.';
  id_mess127 = 'Diese HTML-Datei enthält kein <object>-Tag für den '#13#10 +
               'DynaGeoX-Viewer.'#13#10 +
               'Daher kann auch kein "Text oberhalb des DynaGeoX-Objekts"'#13#10 +
               'gefunden werden.';
  id_mess128 = 'Diese HTML-Datei enthält mehrere <object>-Tags für den '#13#10 +
               'DynaGeoX-Viewer.'#13#10 +
               'Daher kann auch kein "Text oberhalb des DynaGeoX-Objekts"'#13#10 +
               'gefunden werden.';
  id_mess129 = 'Das Koordinatensystem war zuvor unsichtbar gewesen.'#13#10 +
               'Soll es nun wieder verborgen werden?';
  id_mess130 = ' Anzahl der Ecken : ';
  id_mess131 = 'Die eingegebene Anzahl der Ecken ist ungültig.'#13#10 +
               'DynaGeo kann nur reguläre Polygone mit mindestens 3'#13#10 +
               'und höchstens 100 Ecken darstellen.'#13#10#10 +
               'Der Befehl wird abgebrochen.';
  id_mess132 = 'Der Term enthält mindestens eine ungültige @-Variable.'#13#10 +
               'Zulässig sind nur:  @1, @2, @3,.... @9.';
  id_mess133 = ' Anzahl der Teilintervalle : ';
  id_mess134 = 'Abbildungsmatrix anschauen';
  id_mess135 = 'Die Terme für die Koeffizienten der Abbildungsmatrix sind durch die Elternobjekte ' +
               'dieser Abbildung festgelegt und können daher nicht direkt editiert werden.';
  id_mess136 = 'Abbildungsmatrix editieren';
  id_mess137 = 'Sie können die Koeffizienten der Abbildungsmatrix hier direkt editieren. ' +
               'Bitte geben Sie die gewünschten Terme ein!';
  id_mess138 = 'Die eingegebene Funktion weist eine ziemlich große Variation im Funktionswerte-'#13#10 +
               'verlauf auf. Solche Funktionen sind für pixelorientierte Funktionenplotter schwer'#13#10 +
               'verdaulich, da ihre Darstellung sehr mühsam sein kann.'#13#10#10 +
               'Bitte vergrößern Sie die Zeichnung bzw. verkleinern Sie den Anzeigebereich so, dass'#13#10 +
               'nur der Teil des Schaubildes dargestellt wird, der für Sie wirklich wichtig ist.'#13#10#10 +
               'Weitere Details hierzu finden Sie in der Hilfe zu DynaGeo.';
  id_mess139 = '"%s" ist kein gültiger Term.';
  id_mess140 = 'Der Punkt %s kann nicht die vom Punkt %s abhängenden'#13#10 +
               'Objekte übernehmen, weil er selbst zu diesen Objekten gehört.'#13#10 +
               'Eine zirkuläre Verwandtschaftsbeziehung wäre die Folge!'#13#10 +
               'Weitere Details dazu finden Sie in der Hilfe-Datei.'#13#10#10 +
               'Die Ausführung des Befehls wird abgebrochen.';
  id_mess141 = ' x-Koordinate editieren :';
  id_mess142 = 'Diese Fläche hat keinen endlichen Inhalt.';
  id_mess143 = 'Ein Term enthält eine Referenz auf einen Flächeninhalt, den'#13#10 +
               'DynaGeo nicht exakt berechnen kann. Ersatzweise wird ein'#13#10 +
               'Schätzwert verwendet. Wenn Sie allerdings mit diesem unsicheren'#13#10 +
               'Wert weitere Objekte konstruieren, dann kann es zu seltsamen'#13#10 +
               'Komplikationen kommen. '#13#10#10 +
               'Es wird empfohlen, weiterführende Konstruktionen nicht von'#13#10 +
               'Schätzwerten abhängig zu machen. Soll DynaGeo den Term'#13#10 +
               'trotzdem wie eingegeben verwenden?' ;
  id_mess144 = 'Die neue Konfigurations-Datei für die Benutzer-Optionen'#13#10 +
               'wurde erfolgreich erstellt.';
  id_mess145 = 'Die neue Konfigurations-Datei für die Benutzer-Optionen'#13#10 +
               'konnte nicht erstellt werden.';
  id_mess146 = 'Mit diesem Term schließen Sie eine rekursive Definition ab.'#13#10 +
               'Rekursive Funktionen sind jedoch in ihrem Laufzeit-Verhalten'#13#10 +
               'schwer einzuschätzen: in extremen Fällen kann der Rechner'#13#10 +
               'für Stunden "einfrieren". Sie sollten sich daher auf solche'#13#10 +
               'Abenteuer nur einlassen, wenn Sie genau wissen, was Sie tun.'#13#10#10 +
               'Soll DynaGeo diese rekursive Funktion wirklich darstellen?';
  id_mess147 = 'Der eingegebene Funktionsterm scheint keine gültigen Werte'#13#10 +
               'produzieren zu können. Es wird daher keine solche Funktion'#13#10 +
               'erstellt.'#13#10#10 +
               'Bitte ändern Sie den Funktionsterm ab!';
  id_mess148 = 'Änderungen an den Experten-Optionen können die Funktionsweise des Programms'#13#10 +
               'in schwer vorhersagbarer Weise verändern. Sie sollten das folgende Fenster'#13#10 +
               'daher nur dann aufrufen, wenn Sie ganz genau wissen, was Sie tun.'#13#10#10 +
               'Wollen Sie die Experten-Optionen wirklich editieren?';
  id_mess149 = 'Von den %s Objekten der Zeichnung können im aktuellen'#13#10 +
               'Java-Viewer %s Objekte nicht korrekt dargestellt werden,'#13#10 +
               'entweder weil der Java-Viewer diese Objekte noch nicht'#13#10 +
               'kennt oder weil sie von solchen unbekannten Objekten'#13#10 +
               'abhängen.'#13#10#10 +
               'Liste der nicht darstellbaren Objekte'#13#10 +
               '   (in der Zeichnung grün markiert):'#13#10;
  id_mess150 = 'Wollen Sie die Zeichnung trotzdem exportieren?';
  id_mess151 = 'Der eingegebene Winkelwert ist eine Konstante, die von DynaGeo als'#13#10 +
               'ein Bogenmaß interpretiert wird. Wenn Sie hingegen den Winkelwert im'#13#10 +
               'Gradmaß meinen, dann müssen Sie das Gradzeichen (°) hinzufügen.'#13#10#10 +
               'Wollen Sie den Wert wirklich ohne Gradzeichen eingeben?';
  id_mess152 = 'Der eingegebene Term scheint einen Winkel bzw. eine Winkelsumme'#13#10 +
               'zu beschreiben. Soll der Termwert im Gradmaß angezeigt werden?';
  id_mess153 = 'Die Ortslinienpunkte scheinen auf einem Kegelschnitt zu liegen.'#13#10#10 +
               'Soll DynaGeo in Zukunft versuchen, an Stelle der eigentlichen'#13#10 +
               'Ortslinie diesen Kegelschnitt zu verwenden und anzuzeigen?';
  id_mess154 = 'Dieser Befehl löscht das Vergrößerungsglass.'#13#10 +
               'Wollen Sie das wirklich?';
  id_mess155 = 'Das Spiel "Winkel schätzen" konnte nicht gestartet werden, weil ' +
               'die benötigten Initialisierungsdaten unvollständig sind.';
  id_mess156 = 'Der Winkel muss in Grad angegeben werden,'#13#10 +
               'also mit einem Gradzeichen am Ende!';
  id_mess157 = 'Du musst zuerst einen "nächsten Winkel" anfordern!';
  id_mess158 = 'Du musst erst die Größe des aktuellen Winkels im Feld "Winkelweite" eingeben!'#13#10#10 +
               'Schließe die Eingabe ab, indem Du die ENTER-Taste drückst!';
  id_mess159 = '';
  id_mess160 = '';
  id_mess161 = 'Super!!!'#13#10 + 'Großes Lob für die tolle Leistung!';
  id_mess162 = 'Gut gemacht!!'#13#10 + 'Weiter so!';
  id_mess163 = 'Ganz ordentlich!'#13#10 +
               'Könnte aber mit etwas Übung noch besser werden!';
  id_mess164 = 'Gar nicht schlecht für den Anfang!'#13#10 +
               'Bleib dran und übe noch ein paar Runden!';
  id_mess165 = 'Naja, das sollte noch besser werden!'#13#10 +
               'Regelmäßiges Üben hilft, aber Du musst es auch wollen!';
  id_mess166 = 'Das sieht gar nicht gut aus!'#13#10 +
               'Lass Dir erst einmal die Grundlagen zu Winkeln erklären.';
  id_mess167 = '';
  id_mess168 = '';
  id_mess169 = '';
  id_mess170 = '';
  id_mess171 = '';
  id_mess172 = '';
  id_mess173 = '';
  id_mess174 = '';

  id_makmsg00 = '. Startobjekt: ';
  id_makmsg01 = 'Geben Sie einen Punkt ein !';
  id_makmsg02 = 'Geben Sie eine Strecke ein !';
  id_makmsg03 = 'Geben Sie eine Gerade (oder Strecke) ein !';
  id_makmsg04 = 'Geben Sie einen Kreis ein !';
  id_makmsg05 = 'Geben Sie ein %d-Eck ein !';
  id_makmsg06 = 'Geben Sie einen Kegelschnitt ein !';
  id_makmsg07 = 'Geben Sie ein Zahlobjekt ein !';
  id_makmsg08 = '- makro message 08 -';
  id_makmsg09 = '- makro message 09 -';
  id_makmsg10 = '- makro message 10 -';
  id_makmsg11 = '- makro message 11 -';
  id_makmsg12 = '- makro message 12 -';
  id_makmsg13 = '- makro message 13 -';
  id_makmsg14 = '- makro message 14 -';
  id_makmsg15 = '- makro message 15 -'; // ' --- Unbekannter Typ des Startobjekts !!! --- ';
  id_makmsg16 = 'Es ist überhaupt kein Makro aktiv !';
  id_makmsg17 = 'Die Makrodatei "%s"'#13#10 + 'konnte nicht gefunden werden !';
  id_makmsg18 = 'Die Makrodatei "%s"'#13#10 + 'hat ein unbekanntes Format !';
  id_makmsg19 = 'Das Makro "%s" ist neu aufgezeichnet worden und wird mit der aktuellen'#13#10 +
                'Zeichnung abgespeichert. Um es auch für andere Zeichnungen verfügbar zu'#13#10 +
                'machen, müssen Sie es in eine "*.mak"-Datei exportieren.'#13#10#10 +
                'Wollen Sie das Makro jetzt exportieren? ';
  id_makmsg20 = 'Hilfe zum Makro "%s"';
  id_makmsg21 = 'Es ist ein Makrofehler unbekannter Art aufgetreten.'#13#10 +
                'Löschen Sie das Makro und erstellen Sie es neu !';
  id_makmsg22 = '- makro message 22 -'; //'Makro speichern';
  id_makmsg23 = '- makro message 23 -'; //'Makro laden';
  id_makmsg24 = '- makro message 24 -'; //'Makro01';
  id_makmsg25 = 'Makro : ';
  id_makmsg26 = 'Dieses Zielobjekt lässt sich nicht aus den Startobjekten ableiten !'#13#10 +
                'Die Makro-Aufzeichnung wird abgebrochen.';
  id_makmsg27 = 'Ein Objekt kann nicht gleichzeitig Start- und Zielobjekt sein !';
  id_makmsg28 = 'Das Makro konnte nicht korrekt ausgeführt werden !';
  id_makmsg29 = 'Alle Startobjekte eingeben...';
  id_makmsg30 = 'Alle Zielobjekte eingeben...';
  id_makmsg31 = 'Das Makro "%s" wurde erfolgreich erstellt;'#13#10 +
                'dem Makro-Menü wurde ein entsprechender Eintrag hinzugefügt.';
  id_makmsg32 = '- makro message 32 -'; //'Alles klar !';
  id_makmsg33 = 'Die Makro-Erstellung wurde abgebrochen.';
  id_makmsg34 = 'Makro Nr. ';
  id_makmsg35 = '-- Keine Hilfe verfügbar! --';
  id_makmsg36 = 'Ein Term in diesem Makro konnte nicht berechnet werden.';
  id_makmsg37 = 'Die Eckenzahl dieses Polygons (%d) stimmt nicht mit'#13#10 +
                'der erwarteten Eckenzahl (%d) überein.'#13#10#10 +
                'Die Makro-Ausführung wird abgebrochen.';
  id_makmsg38 = 'Zu diesem Menüpunkt ist kein Makro registriert.'#13#10 +
                'Bitte löschen Sie alle Makros, beenden Sie EUKLID DynaGeo und'#13#10 +
                'starten Sie das Programm dann neu.';
  id_makmsg39 = 'Das Makro ist ungültig, weil es keine Startobjekte enthält.';
  id_makmsg40 = 'Das Makro ist ungültig, weil es keine Zielobjekte enthält.';
  id_makmsg41 = 'Die Datei enthält ein ungültiges Makro,'#13#10 +
                'das nicht geladen werden konnte.';
  id_makmsg42 = 'Dieses Startobjekt kann nicht in einem Makro verwendet werden.';
  id_makmsg43 = '- makro message 45 -';
  id_makmsg44 = '- makro message 44 -';
  id_makmsg45 = '- makro message 45 -';
  id_makmsg46 = '- makro message 46 -';
  id_makmsg47 = '- makro message 47 -';
  id_makmsg48 = '- makro message 48 -';

  id_filemsg00 = 'Es ist ein unbekannter Fehler beim Schreiben der Datei'#13#10 +
                 '"%s"'#13#10'aufgetreten.';
  id_filemsg01 = 'Die Objekt-Sortierung für die Datei "%s"'#13#10' ist fehlgeschlagen!';
  id_filemsg02 = 'Diese Zeichnung enthält Objekte, die nicht in GeoScript-Dateien'#13#10 +
                 'exportiert werden können, wie z.B. Strecken fester Länge.';
  id_filemsg03 = 'Die Erweitertung des Dateinamens ("%s") passt nicht'#13#10 +
                 'zum ausgewählten Datei-Filter ("%s").'#13#10#10 +
                 'Soll der Dateiname geändert werden, so dass eine'#13#10 +
                 '"%s"-Datei abgespeichert wird?';
  id_filemsg04 = 'dd.mm.yyyy,  hh:mm "Uhr"';
  id_filemsg05 = 'Die Datei "%s" wird geladen...';
  id_filemsg06 = 'Die Datei "%s"'#13#10'konnte nicht gefunden werden!';
  id_filemsg07 = 'Die Programmdatei wurde verändert. Möglicherweise liegt ein Virenbefall vor,'#13#10 +
                 'oder die Datei wurde auf andere Art beschädigt. Das Programm wird beendet.'#13#10#10 +
                 'Holen Sie sich eine neue Kopie von http://www.dynageo.de/';
  id_filemsg08 = 'Die Datei "%s"'#13#10'wird gespeichert...';
  id_filemsg09 = 'Die Datei "%s"'#13#10'konnte nicht korrekt geschrieben werden.';
  id_filemsg10 = #13#10#10'Möglicherweise existiert sie schon und ist schreibgeschützt,'#13#10 +
                 'oder Sie haben keine Schreibrechte im Zielverzeichnis.';
  id_filemsg11 = 'Eine Datei dieses Namens existiert schon.'#13#10'Soll sie überschrieben werden?';
  id_filemsg12 = 'KEINNAME';
  id_filemsg13 = 'Die aktuelle Zeichnung wurde möglicherweise'#13#10 +
                 'geändert, ist aber noch nicht gespeichert.'#13#10#10 +
                 'Wollen Sie sie jetzt abspeichern?';
  id_filemsg14 = 'Es wurden falsche Links gefunden und ein Reparaturversuch unternommen.';
  id_filemsg15 = 'Es gab mehrere Probleme beim Laden!';
  id_filemsg16 = 'Die Datei "%s"'#13#10'hat ein unbekanntes Format.'#13#10#10 +
                 'Möglicherweise wurde sie mit einer neueren Version von'#13#10 +
                 'EUKLID DynaGeo erzeugt. Schauen Sie doch einfach mal unter'#13#10 +
                 'http://www.dynageo.de/ nach, ob es dort nicht ein Update für'#13#10 +
                 'die derzeit auf Ihrem Rechner installierte Version gibt!';
  id_filemsg17 = 'Die automatische Größenkorrektur kann nicht durchgeführt werden.'#13#10'Die Objekte dieser Zeichnung haben eventuell falsche Maße.';
  id_filemsg18 = 'Datei-Typ unklar!';
  id_filemsg19 = ' < unbekannt > ';
  id_filemsg20 = ' < noch nicht gespeichert > ';
  id_filemsg21 = 'Keine Daten gefunden!';
  id_filemsg22 = 'Die Datei "%s"'#13#10'konnte nicht geladen werden.';
  id_filemsg23 = 'Die Datei "%s"'#13#10'enthält keine korrekten DynaGeo-Daten (Header unlesbar)!';
  id_filemsg24 = 'Die Datei "%s"'#13#10'enthält keine korrekten DynaGeo-Daten (Herkunft unklar)!';
  id_filemsg25 = #13#10#10'Offenbar ist die Zieldatei schreibgeschützt.'#13#10 +
                 'Speichern Sie Ihre Zeichnung unter einem anderen Namen bzw. in einem'#13#10 +
                 'anderen Verzeichnis, in dem Sie ausreichende Schreibrechte haben.';
  id_filemsg26 = 'EUKLID DynaGeo kann keine "*%s"-Dateien schreiben.'#13#10#10 +
                 'Bitte wählen Sie im "Speichern unter..."-Dialog'#13#10 +
                 'eine zulässige Erweiterung aus.';
  id_filemsg27 = 'EUKLID DynaGeo kann Dateien im veralteten GEOX-Format'#13#10 +
                 'nur noch einlesen, aber nicht mehr schreiben.'#13#10#10 +
                 'Bitte speichern Sie die Zeichnung unter einem neuen Namen'#13#10 +
                 'mit der Datei-Kennung ".geo" ab!';
  id_filemsg28 = 'Die Datei "%s"'#13#10 +
                 'enthält einen XML-Syntaxfehler und kann daher nicht korrekt'#13#10 +
                 'interpretiert werden. Der Ladevorgang wird abgebrochen.';
  id_filemsg29 = #13#10#10'Wollen Sie selbst nach ihr suchen?';
  id_filemsg30 = #13#10#10'Es ist nicht genügend Speicher verfügbar, um diese Datei zu erstellen.'#13#10 +
                 'Falls Sie eine Bitmap-Datei mit hoher Auflösung speichern wollten,'#13#10 +
                 'empfiehlt es sich, die gewünschte Auflösung zu reduzieren.';
  id_filemsg31 = 'Der Typ der Datei "%s"'#13#10 +
                 'ist unbekannt.'#13#10#10 +
                 'DynaGeo kann keine Dateien dieses Typs schreiben.';
  id_filemsg32 = 'Beim Lesen des Inhalts der Datei'#13#10 +
                 ' "%s" '#13#10 +
                 'sind Fehler aufgetreten.'#13#10#10 +
                 'DynaGeo kann die Daten nicht korrekt interpretieren.'#13#10 +
                 'Wahrscheinlich ist die Datei beschädigt.';
  id_filemsg33 = 'Mysteriöser Datei-Fehler!';
  id_filemsg34 = 'Leider konnten %d Objekte aus der Datei'#13#10 +
                 'nicht korrekt importiert werden.';
  id_filemsg35 = 'Die aktuelle Zeichnung ist offenbar noch nicht gespeichert worden.'#13#10#10 +
                 'Bitte speichern Sie die Zeichnung erst ab, ehe Sie sie in'#13#10 +
                 'eine HTML-Seite exportieren!';
  id_filemsg36 = 'Die aktuelle Zeichnung ist offenbar seit dem letzten Speichern'#13#10 +
                 'verändert worden. Wenn Sie den Vorgang fortsetzen, wird die'#13#10 +
                 'Zeichnung im zuletzt gespeicherten Zustand exportiert, welcher'#13#10 +
                 'nicht mit dem aktuellen Zustand übereinstimmt.'#13#10#10 +
                 'Wollen Sie die Zeichnung wirklich im alten Zustand exportieren?';
  id_filemsg37 = 'Die Zeichnung enthält Terme mit Winkelmaßen in einem alten Format.'#13#10 +
                 'DynaGeo hat versucht, diese Terme ins neue Format zu konvertieren;'#13#10 +
                 'sollte sich die Zeichnung nicht korrekt verhalten, müssen Sie die'#13#10 +
                 'Terme überarbeiten. Details dazu finden Sie in der Hilfe-Datei im'#13#10 +
                 'Abschnitt "Werkstatt-Berichte | Das Problem der Winkelmessung".';
  id_filemsg38 = 'DynaGeo kann keine Bilddateien vom Typ "%s" importieren.';
  id_filemsg39 = '-- file message 39 --';


  id_optmsg00 = 'Ein Eingabefeld enthält falsche Daten.';
  id_optmsg01 = '- option message 01 -';
  id_optmsg02 = 'Die Einstellungen für Objektdarstellung konnten nicht auf ihre Standardwerte zurückgesetzt werden.';
  id_optmsg03 = 'Die Benutzereinstellungen konnten nicht geladen werden.';
  id_optmsg04 = 'Die Einstellungen für die Objektdarstellung wurden auf ihre Standardwerte zurückgesetzt.';
  id_optmsg05 = 'Die Benutzereinstellungen wurden geladen.';
  id_optmsg06 = 'Die aktuellen Einstellungen wurden erfolgreich gespeichert.';
  id_optmsg07 = 'Die aktuellen Einstellungen konnten nicht gespeichert werden !'#13#10'Eventuell ist das Ziellaufwerk schreibgeschützt.';
  id_optmsg08 = 'Formatfehler in den Daten der Menü-Konfiguration!';
  id_optmsg09 = 'Sie haben der neuen Menükonfiguration noch keinen eindeutigen Namen gegeben.';
  id_optmsg10 = '- option message 10 -';
  id_optmsg11 = '- option message 11 -';
  id_optmsg12 = '- option message 12 -';
  id_optmsg13 = '- option message 13 -';

  id_startmsg00 = '---> FreeWare <---';
  id_startmsg01 = 'für alle, die gerne Mathematik machen;';
  id_startmsg02 = 'auch für den Mathematik-Unterricht an Schulen.';
  id_startmsg03 = 'Lizenz-Details finden Sie in der Hilfe-Datei.';
  id_startmsg04 = ' für';
  id_startmsg05 = 'Die Datei "%s"'#13#10 +
                  'enthält keine gültigen DynaGeo-Lizenzdaten. Möglicherweise'#13#10 +
                  'ist sie beim Transport beschädigt worden.';
  id_startmsg06 = 'Diese Datei ist eine veraltete Beta-Version'#13#10 +
                  'des Programms EUKLID DynaGeo.'#13#10#10 +
                  'Bitte holen Sie sich eine neuere Version von'#13#10 +
                  'der DynaGeo-Homepage:'#13#10 +
                  '         http://www.dynageo.de ';
  id_startmsg07 = 'Okay';
  id_startmsg08 = 'EUKLID DynaGeo - [ ';
                     { dient zur Ermittlung des Projektnamens !!! }
  id_startmsg09 = ' ]';
  id_startmsg10 = 'Sie dürfen dieses Programm noch %d Tage lang testen.'#13#10#10 +
                  'Wenn Sie es nach Ablauf dieses Zeitraums weiterhin'#13#10 +
                  'benutzen wollen, müssen Sie eine Lizenz kaufen.'#13#10 +
                  'Details dazu finden Sie in der Online-Hilfe oder'#13#10 +
                  'im Internet unter  http://www.dynageo.de/.';
  id_startmsg11 = 'Es ist keine Hilfe verfügbar, da die Datei'#13#10 + '%s'#13#10 +
                  'nicht gefunden werden konnte !';
  id_startmsg12 = 'EUKLID DynaGeo sucht nach den Lizenzdaten.'#13#10 +
                  'Bitte legen Sie die Installations-Diskette'#13#10 +
                  'ins Laufwerk %s: ein!';
  id_startmsg13 = 'EUKLID DynaGeo hat eine alte Version der Initialisierungsdatei gefunden'#13#10 +
                  'und sie erfolgreich aktualisiert.';
  id_startmsg14 = 'Die Lizenzdaten wurden erfolgreich eingetragen.'#13#10 +
                  'EUKLID DynaGeo wird nun beendet.'#13#10#10 +
                  'Beim nächsten Start wird sich das Programm mit den neuen Daten'#13#10 +
                  'als lizensierte Vollversion melden!';
  id_startmsg15 = 'EUKLID DynGeo ist als lizensierte Vollversion installiert.'#13#10 +
                  'Wenn Sie fortfahren, werden die eingetragenen Lizenzdaten durch'#13#10 +
                  'neu eingelesene ersetzt. Wenn dabei ein Fehler passiert,'#13#10 +
                  'wird möglicherweise Ihre Lizensierung ungültig.'#13#10#10 +
                  'Wollen Sie den Prozess abbrechen und lieber die'#13#10 +
                  'aktuellen Lizenzdaten beibehalten?';
  id_startmsg16 = 'Version 2.0  (c) 1994/2003  R. Mechling';   // wird zur Laufzeit aktualisiert !
  id_startmsg17 = 'Unregistrierte ShareWare-Version !';
  id_startmsg18 = 'Der Cursor "%s" konnte nicht geladen werden.';
  id_startmsg19 = 'In die Datei %s '#13#10 +
                  'konnte nicht geschrieben werden.'#13#10 +
                  'Möglicherweise haben Sie dafür keine ausreichenden Rechte'#13#10 +
                  'in diesem Verzeichnis.'#13#10#10 +
                  'Die Anwendung wird beendet.';
  id_startmsg20 = 'Der ShareWare-Test-Zeitraum von 8 Wochen ist inzwischen verstrichen.'#13#10 +
                  'Wenn Sie EUKLID DynaGeo weiter benutzen wollen, müssen Sie eine Lizenz kaufen.'#13#10 +
                  'Details finden Sie unter http://www.dynageo.de/.'#13#10#10 +
                  'EUKLID DynaGeo kann jetzt Ihre Lizenzdaten registrieren und damit'#13#10 +
                  'die vorliegende Shareware-Version in eine lizensierte Vollversion umwandeln.'#13#10 +
                  'Dazu müssen Sie den Pfad zu einer gültigen Lizenz-Datei ("*.dgl") angeben.'#13#10 +
                  'Wollen Sie jetzt Ihre Lizenzdaten eintragen lassen?';
  id_startmsg21 = 'Die Initialisierungsdaten des Programms sind ungültig.'#13#10 +
                  'De-installieren Sie DynaGeo komplett, starten Sie Windows neu'#13#10 +
                  'und installieren Sie das Programm nochmals.';
  id_startmsg22 = 'Die vorliegende Shareware-Version von EUKLID DynaGeo'#13#10 +
                  'war bisher insgesamt %d Minuten aktiv.'#13#10#10;
  id_startmsg23 = 'Der ShareWare-Test-Zeitraum von 8 Wochen ist inzwischen verstrichen.'#13#10 +
                  'Wenn Sie EUKLID DynaGeo weiter benutzen wollen, müssen Sie eine Lizenz kaufen.'#13#10 +
                  'Details finden Sie unter http://www.dynageo.de/.';
  id_startmsg24 = 'Die Datei %s '#13#10 +
                  'konnte nicht zum Schreiben geöffnet werden. Möglicherweise'#13#10 +
                  'haben Sie keine Schreibrechte in diesem Verzeichnis.'#13#10#10 +
                  'Die Anwendung wird beendet.';
  id_startmsg25 = 'Euklid DynaGeo  (c)1994/2016  R. Mechling';
  id_startmsg26 = '  Animation  ';           // Letzter Eintrag in TabSet1 
  id_startmsg27 = 'Der Versuch, in die Datei DYNAGEO.INI zu schreiben, schlug fehl.'#13#10 +
                  'Bitte beachten Sie, dass Neuinstallationen und Updates von DynaGeo'#13#10 +
                  'stets mit Administrator-Rechten durchgeführt werden müssen!';
  id_startmsg28 = 'EUKLID DynaGeo ist Shareware. Die vorliegende Version ist'#13#10 +
                  'nur zum Anschauen der Daten auf dieser CD gedacht.'#13#10#10 +
                  'Für den Einsatz des Programms im Unterricht benötigen Sie'#13#10 +
                  'eine Schullizenz oder eine Erweiterte Schullizenz.'#13#10#10 +
                  'Weitere Details zum Programm, eine jeweils aktuelle Version'#13#10 +
                  'und Bestellmöglichkeiten für eine Lizenz finden Sie'#13#10 +
                  'im Internet unter'#13#10#10 +
                  '          http://www.dynageo.de/'#13#10;
  id_startmsg29 = 'Die vorliegende Version ist nur zum Anschauen der Daten auf'#13#10 +
                  'einer CD mit Unterrichtsmaterialien gedacht.'#13#10#10 +
                  'Offenbar ist dies aber nicht die originale CD.'#13#10 +
                  'Das Programm wird daher beendet.';
  id_startmsg30 = 'Die Datei enthält leider teilweise ungültige Daten.'#13#10#10 +
                  'DynaGeo hat versucht, möglichst viel von der ursprünglichen Zeichnung'#13#10 +
                  'zu bewahren, aber leider konnten nur %s von %s Objekten erfolgreich'#13#10 +
                  'gelesen werden.'#13#10#10 +
                  'Ob die eingelesenen Objekte wirklich korrekt sind, kann DynaGeo nicht'#13#10 +
                  'entscheiden. Notfalls müssen Sie die Zeichnung neu anfertigen.';
  id_startmsg31 = '- start message 31 -';
  id_startmsg32 = '- start message 32 -';

  id_objtxt00 = '?  ist ein freier Basispunkt';
  id_objtxt01 = '?  ist ein Punkt mit den festen Koordinaten  ( %s | %s ) ';
  id_objtxt02 = '?  ist die Strecke  [ ? ; ? ] ';
  id_objtxt03 = '?  ist eine Strecke der festen Länge %s cm zwischen ? und ?';
  id_objtxt04 = '?  ist die Gerade  ( ? ; ? ) ';
  id_objtxt05 = '?  ist eine Basisgerade';
  id_objtxt06 = '?  ist eine Gerade im festen Winkel von  %s° zur Geraden  ( ? ; ? )';
  id_objtxt07 = '?  ist ein Kreis um ? durch ?';
  id_objtxt08 = '?  ist ein Basiskreis';
  id_objtxt09 = '?  ist ein Kreis um ? mit dem festen Radius %s cm';
  id_objtxt10 = '?  ist der Winkel  ( ? ; ? ; ? )';
  id_objtxt11 = '?  ist der Ursprung des Koordinatensystems';
  id_objtxt12 = '?  ist die x-Achse des Koordiantensystems';
  id_objtxt13 = '?  ist die y-Achse des Koordinatensystems';
  id_objtxt14 = '?  ist der Eins-Punkt der  x-Achse';
  id_objtxt15 = '?  ist der Eins-Punkt der  y-Achse';
  id_objtxt16 = 'Namens-Anzeige für  ?';
  id_objtxt17 = 'Maß-Anzeige für den Abstand von  ?  und  ?';
  id_objtxt18 = 'Maß-Anzeige für den Winkel  ( ? ; ? ; ? )';
  id_objtxt19 = '?  ist der Mittelpunkt der Strecke [ ? ; ? ]';
  id_objtxt20 = '?  ist der %d. Schnittpunkt der Kegelschnitte ? und ?';
  id_objtxt21 = '?  ist der %d. Schnittpunkt der Linie ? mit dem Kegelschnitt ?';
  id_objtxt22 = '?  ist der %d. Schnittpunkt der Kreise ? und ?';
  id_objtxt23 = '?  ist der %d. Schnittpunkt der Linie ? mit dem Kreis ?';
  id_objtxt24 = '?  ist Bildpunkt von ? bei einer affinen Abbildung';
  id_objtxt25 = '[=- ?  ist ein veraltetes Objekt vom Typ "%s") -=]';
  id_objtxt26 = '?  ist der Schnittpunkt der Linien ? und ?';
  id_objtxt27 = '?  ist die Mittelsenkrechte der Strecke [ ? ; ? ]';
  id_objtxt28 = '?  ist die Halbierende des Winkels ( ? ; ? ; ? )';
  id_objtxt29 = '?  ist das Lot von ? auf  ?';
  id_objtxt30 = '?  ist die Parallele zu ? durch ?';
  id_objtxt31 = '?  ist eine Ortslinie des Punktes ?, wenn ? gezogen wird';
  id_objtxt32 = '?  ist ein Kreis mit Mittelpunkt ? und Radius %s cm';
  id_objtxt33 = '?  ist eine Gerade durch ? im Winkel der Weite %s zur Geraden ( ? ; ? )';
  id_objtxt34 = 'Eine Spur des Punktes ?';
  id_objtxt35 = '?  ist ein Basispunkt, der an ? gebunden ist.';
  id_objtxt36 = 'Eine Text-Box.';
  id_objtxt37 = '?  ist das Polygon [';
  id_objTxt38 = '?  ist ein Bogen mit Startpunkt ? um den Mittelpunkt ? bis zum Strahl [ ? ; ? )';
  id_objTxt39 = '?  ist ein Kreis, auf dem alle Punkte der Ortslinie ? liegen';
  id_objTxt40 = '?  ist eine Gerade, auf der alle Punkte der Ortslinie ? liegen';
  id_objTxt41 = '?  ist eine Halbgerade mit Startpunkt ? durch den Punkt ?';
  id_objTxt42 = '?  ist das Bild der Geraden ? bei der ';
  id_objTxt43 = '?  ist das Bild des Kreises ? bei der ';
  id_objtxt44 = '?  ist das Bild des Punktes ? bei der ';
  id_objtxt45 = '?  ist das Bild des Kegelschnitts ? bei der ';
  id_objtxt46 = '?  ist der Vektor, der ? nach ? schiebt';
  id_objtxt47 = '?  ist eine weitere Instanz des Vektors ?';
  id_objtxt48 = '?  ist eine Achsenspiegelung an ?';
  id_objtxt49 = '?  ist eine Punktspiegelung an ?';
  id_objtxt50 = '?  ist eine Drehung um den Punkt ? um %s°';
  id_objtxt51 = '?  ist eine Verschiebung um den Vektor ?';
  id_objtxt52 = '?  ist eine Kreisspiegelung an ?';
  id_objtxt53 = '?  ist ein Zahl-Objekt mit dem aktuellen Wert %s.';
  id_objtxt54 = '?  ist ein Punkt mit den bestimmten Koordinaten ( %s | %s ).';
  id_objtxt55 = '?  ist der Term %s.';
  id_objtxt56 = '?  ist eine zentrische Streckung an ? mit dem Streckfaktor %s.';
  id_objtxt57 = 'zentrischen Streckung an ? mit dem Streckfaktor %s.';
  id_objtxt58 = '?  ist das Bild der Ortslinie ? bei der ';
  id_objtxt59 = '?  ist die Füllung einer von %s berandeten Fläche.';
  id_objtxt60 = '?  ist ein Kreis, auf dem alle Punkte der Ortslinie ? liegen sollten.';
  id_objtxt61 = '?  ist eine Gerade, auf der alle Punkte der Ortslinie ? liegen sollten.';
  id_objtxt62 = '?  ist ein Kegelschnitt durch die 5 Punkte ?, ?, ?, ? und ?.';
  id_objtxt63 = '?  ist eine Ellipse durch die 5 Punkte ?, ?, ?, ? und ?.';
  id_objtxt64 = '?  ist eine Parabel durch die 5 Punkte ?, ?, ?, ? und ?.';
  id_objtxt65 = '?  ist eine Hyperbel durch die 5 Punkte ?, ?, ?, ? und ?.';
  id_objtxt66 = '?  ist eine Gerade durch ?, aus der die Geraden ? und ? eine Strecke der Länge %s ausschneiden.';
  id_objtxt67 = '?  ist ein Funktions-Schaubild mit ?(x) = %s.';
  id_objtxt68 = '?  ist eine Tangente an die Kurve ? im Punkt ?.';
  id_objtxt69 = '?  ist eine Ellipse mit den Brennpunkten ? und ? durch den Punkt ?.';
  id_objtxt70 = '?  ist eine Ellipse mit Mittelpunkt ?, Hauptscheitel ? und einem Nebenkreis durch ?.';
  id_objtxt71 = '?  ist eine Ellipse mit Mittelpunkt ? durch die beiden konjugierten Punkte ? und ?.';
  id_objtxt72 = '?  ist eine Parabel mit Brennpunkt ? und Leitgerade ?.';
  id_objtxt73 = '?  ist eine Parabel mit den Berührpunkten ? und ? und den Tangenten(richtungen) ? und ?.';
  id_objtxt74 = '?  ist eine Hyperbel mit den Brennpunkten ? und ? durch den Punkt ?.';
  id_objtxt75 = '?  ist eine Hyperbel mit den Asymptoten ? und ? durch den Punkt ?.';
  id_objtxt76 = '?  ist eine affine Abbildung, die (?, ?, ?) auf (?, ?, ?) abbildet.';
  id_objtxt77 = 'affinen Abbildung, die (?, ?, ?) auf (?, ?, ?) abbildet.';
  id_objtxt78 = '?  ist eine affine Abbildung, die durch eine Matrix gegeben ist.';
  id_objtxt79 = 'affinen Abbildung, die durch eine Matrix gegeben ist.';
  id_objtxt80 = 'Eine Spur eines Punktes.';
  id_objtxt81 = '?  ist ein Bild.';
  id_objtxt82 = '?  ist ein Abbild von ?';
  id_objtxt83 = '?  ist eine Scherung mit Achse ?, die ? auf ? abbildet.';
  id_objtxt84 = '?  ist eine orthogonale axiale Streckung mit Achse ?, die ? auf ? abbildet.';
  id_objtxt85 = 'orthogonalen axialen Streckung mit Achse ?, die ? auf ? abbildet.';
  id_objtxt86 = '?  ist eine Schrägspiegelung mit Achse ?, die ? auf ? abbildet.';
  id_objtxt87 = '?  ist eine allgemeine Achsenaffinität mit Achse ?, die ? auf ? abbildet.';
  id_objtxt88 = 'allgemeinen Achsenaffinität mit Achse ?, die ? auf ? abbildet.';
  id_objtxt89 = '?  ist eine Euler''sche Affinität mit Fixgeraden ? und ?, die ? auf ? abbildet.';
  id_objtxt90 = '?  ist eine Affin-Drehung um den Fixpunkt ?, die ? auf ? und ? auf ? abbildet.';
  id_objtxt91 = '?  ist eine Fläche zwischen der Kurve ? und der x-Achse.';
  id_objtxt92 = '?  ist eine Fläche zwischen den Kurven ? und ?.';
  id_objtxt93 = '?  ist die Chordale zu ? und ?.';
  id_objtxt94 = '?  ist die Normale auf die Kurve ? im Punkt ?.';
  id_objtxt95 = '?  ist die Polare zum Pol ? beim Kegelschnitt ?.';
  id_objtxt96 = '?  ist der Pol zur Polaren ? beim Kegelschnitt ?.';
  id_objtxt97 = 'Maß-Anzeige für den Flächeninhalt von  ?';
  id_objtxt98 = '?  ist der Mittelpunkt des Kreises ?.';
  id_objtxt99 = '?  ist der Mittelpunkt der Ellipse ?.';
  id_objtxt100 = '?  ist der Mittelpunkt der Hyperbel ?.';
  id_objtxt101 = '?  ist ein reguläres %s-Eck über der Strecke [ ? ; ? ].';
  id_objtxt102 = '?  ist ein Eckpunkt des regulären N-Ecks ?.';
  id_objtxt103 = '?  ist das Bild des regulären %s-Ecks ? bei der Abbildung ?.';
  id_objtxt104 = '?  ist die Untersumme einer Fläche unter der Kurve ?.';
  id_objtxt105 = '?  ist die Obersumme einer Fläche unter der Kurve ?.';
  id_objtxt106 = '?  ist der Kreis durch die 3 Punkte ?, ? und ?.';
  id_objtxt107 = '?  ist ein Strahl von ? aus, im Winkel der Weite %s zur Geraden ( ? ; ? )';
  id_objtxt108 = '?  ist ein Kegelschnitt, auf dem alle Punkte der Ortslinie ? liegen sollten.';
  id_objtxt109 = '?  ist der Mittelpunkt der Strecke ?.';
  id_objtxt110 = 'Eine Spur der Geraden ?.';
  id_objtxt111 = 'Eine Spur einer Geraden.';
  id_objtxt112 = '?  ist eine Einhüllende der geraden Linie ?, wenn ? gezogen wird.';
  id_objtxt113 = '?  ist die Gruppe aus den Objekten ';
  id_objtxt114 = '?  ist eine Gruppe aus %s einzelnen Objekten.';
  id_objtxt115 = '?  ist ein Nullvektor.';
  id_objtxt116 = '?  ist eine Lupe, die den Punkt ? fokussiert.';
  id_objtxt117 = '?  ist ein Zoom-Rahmen.';
  id_objtxt118 = '';
  id_objtxt119 = '';

  { C_ontext M_enu E_ntries : }

  cme_hide       = 'Verbergen';
  cme_name       = 'Benennen...';
  cme_rename     = 'Umbenennen...';
  cme_hidename   = 'Name verbergen';
  cme_col        = 'Farbe...';
  cme_ptform     = 'Punktform...';
  cme_ptfree     = 'Bindung aufheben';
  cme_ptbind     = 'An Linie binden...';
  cme_ptquant    = 'Schrittweite...';
  cme_ptfix      = 'Fixieren';
  cme_xedit      = 'x-Koordinate editieren...';
  cme_xyedit     = 'Koordinaten editieren...';
  cme_xyfree     = 'In freien Basispunkt verwandeln';
  cme_setdotpt   = 'Spurpunkt setzen';
  cme_linestyle  = 'Linienart...';
  cme_length     = 'Streckenlänge...';
  cme_fillstyle  = 'Füllmuster...';
  cme_namhide    = 'Name verbergen';
  cme_namedit    = 'Name editieren...';
  cme_leanline   = 'Dünne Linie';
  cme_fatline    = 'Dicke Linie';
  cme_locpoints  = 'Als Punkte-Serie zeigen';
  cme_loccurve   = 'Als Kurve zeigen';
  cme_locdyna    = 'Dynamisch';
  cme_locauto    = 'Automatisch';
  cme_locstnd    = 'Standard-Kurve';
  cme_radius     = 'Radius...';
  cme_angle      = 'Winkel...';
  cme_edit       = 'Editieren...';
  cme_editrange  = 'Bereich editieren...';
  cme_editterm   = 'Term editieren...';
  cme_editfunc   = 'Funktions-Term editieren...';
  cme_functable  = 'Werte-Tabelle anzeigen...';
  cme_showslider = 'In Normalansicht zeigen';
  cme_showcounter= 'Minimiert zeigen';
  cme_lowersum   = 'In Untersumme verwandeln';
  cme_uppersum   = 'In Obersumme verwandeln';
  cme_editRIcnt  = 'Anzahl der Teilintervalle ändern...';
  cme_update     = 'Neu zeichnen';
  cme_zoomreset  = 'Zeichnung zurücksetzen (auf 1:1)';
  cme_zoomin     = 'Zeichnung vergrößern';
  cme_zoomout    = 'Zeichnung verkleinern';
  cme_detds      = 'Deterministische Zug-Strategie';
  cme_contds     = 'Stetige Zug-Strategie';
  cme_blinkbo    = 'Basisobjekte blinken lassen';
  cme_tboxbind   = 'Textbox an Objekt binden';
  cme_tboxfree   = 'Bindung der Textbox aufheben';
  cme_imagehide  = 'Bild verbergen';
  cme_frameedit  = 'Bildrahmen anzeigen';
  cme_framelock  = 'Bild fixieren';
  cme_mapobj     = 'Objekt abbilden mit...';
  cme_hideSQO    = 'Geodreieck verbergen';
  cme_coordsys   = 'Koordinatensystem ändern...';

  cme_showcoords    = 'Koordinaten zeigen';
  cme_showequation  = 'Gleichung zeigen';
  cme_hidecoords    = 'Koordinaten verbergen';
  cme_hideequation  = 'Gleichung verbergen';

  cme_envshowcurve  = 'Hüllkurve zeigen';
  cme_envhidecurve  = 'Hüllkurve verbergen';
  cme_envshowlines  = 'Geradenschar zeigen';
  cme_envhidelines  = 'Geradenschar verbergen';

  cme_SecantSlopes    = 'Sekanten-Steigungen';
  cme_SecSlopeFuncs   = 'Sekanten-Steigungs-Funktionen';
  cme_CurvatureCircle = 'Approximierenden Kreis';
  cme_CurvatureParabo = 'Approximierende Parabel';
  cme_ZF_show         = ' zeigen';
  cme_ZF_kill         = ' entfernen';

  about_okaybtn     = 'Okay';

  XViewerInternetPath = 'http://www.dynageo.de/download/dynageox3.cab';
  JViewerInternetPath = 'http://www.dynageo.de/download/dynageoj.jar';

implementation

initialization
// nothing to do.
end.
