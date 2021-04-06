unit GlobVars;

interface

Uses Windows, Classes, SysUtils, Graphics, Forms, Controls,
     Declar;

type TXMLOutputFormat = (fofRaw, fofCompressed, fofShortLines, fofPrettyPrint);
     TValTabData      = class (TObject) // Ist effektiv ein Record, den
                        public               // man auf Nil setzen kann !
                          vis      : Boolean;
                          xmin     : String; // Bereichsbeschreibung
                          dx       : String; //    in Strings
                          xmax     : String; //    ( wegen "pi"...)
                          marked   : String; // enthält die GeoNummern der
                                             // aufgelisteten Funktionsobjekte
                          rect     : TRect;  // das Fenster-Rechteck
                        end;

const

  // Die folgenden beiden Strings müssen bei jeder neuen Version
  // entsprechend angepasst werden, damit sich diese neue Version
  // in der Oberfläche und den GEO-Dateien durchsetzt.

  EuklidCRText    : String     = '   ©1994-2016  Roland Mechling';
  { Dieser String erscheint genau so wie hier definiert in der voll-
    ständigen Versions&CopyRight-Zeile des About-Fensters, welche
    zur Laufzeit in MyStartMess[16] abgelegt ist.                         }
  EuklidLogo      : String     = 'EUKLID 4.0';
  { EuklidLogo dient ausschließlich zur Unterscheidung verschiedener
    Versionen von '*.GEO'- und '*.MAK'-Dateien. Der String wird auch
    fürs neue XML-Format benutzt !                                        }

  EuklidLanguage  : String     = 'DEU'; { Sprache der Oberfläche          }
  LizenzNr        : Integer    =     0; { Alte Nummer, wird beim Starten gesetzt  }
  LizNumStr       : String     =    ''; { Lizenz-Nummer als String        }
  AutoRegister    : Boolean    = False; { Erzwingt Neuerstellung der zentralen
                                            DYNAGEO.INI, wenn True        }

  IsActiveX       : Boolean    = False; { Beim Start von DynaGeoX auf TRUE setzen }
  AXVersionStr    : String     =    ''; { Beim Start von DynaGeoX setzen          }

  DGXPathRegistered : String   =    ''; { Pfad zum registrierten DynaGeoX-OCX     }
  DGXPathInSubDir   : String   =    ''; { Pfad zur OCX-Datei im "Viewer"-SubDir   }
  DefMakroDir       : String   =    ''; { Pfad zum Standard-Makro-Verzeichnis     }

  RegData         : AnsiString =    ''; { Lizenzdaten }
  RegName         : AnsiString =    ''; {    "        }
  RegAddr1        : AnsiString =    ''; {    "        }
  RegAddr2        : AnsiString =    ''; {    "        }

  RegLicType      : Integer    =     1; { Nr. der Lizenzart (laut User-Datenbank) }
  RegLicStart     : TDateTime  =   0.0; { Ausstellungsdatum der Lizenz (iff ex.)  }
  RegLicEnd       : TDateTime  =   0.0; { Gültigkeits-Ende bei temporärer Lizenz  }
  SW_RunTime      : Integer    =    60; { Laufzeit der Shareware-Version in Tagen }
  SW_DaysLeft     : Integer    =    60; { Verbleibende Shareware-Test-Tage        }

  XMLOutputFormat : TXMLOutputFormat = fofShortLines; { GEO-XML-Datei-Format :
                                          fofRaw         : Daten ohne Formatierung
                                          fofCompressed  : ZIP-komprimiert
                                          fofShortLines  : Textzeilen mit CR-LF,
                                                           <= 100 Zeichen/Zeile
                                          fofPrettyPrint : "schön formatiert",
                                                           mit CR-LF und TABs     }

  GeoFileVersion  : String  =    '';    { Version der aktuell geladenen GEO-Datei }
                                        { bis 2.7 : "h.n"; ab 3.0 : "h.n.r.b"     }
  GeoFileCRMask   : Integer = 27498213; { Maske zum Abspeichern von Drawing.CRNr  }

  prn_PaperFormat : Integer =   0;      { Papierbereich für den Ausdruck }
  prn_UserScaleF  : Double  = 1.0;      { Skalierung der Ausdrucke       }
  prn_UserBorder  : Double  = 0.0;      { Randbreite der Ausdrucke       }

  IsShareWare     : Boolean = True;     { unterscheidet lizensierte und ShareWare-Version }
  IsStartUp       : Boolean = True;     { Flag für den Programmstart                      }
  AppShouldClose  : Boolean = False;    { Flag für "Programmende während einer Animation" }

  act_PixelPerXcm   : Double = 0;       { Skalierung der Zeichnung, .... }
  act_PixelPerYcm   : Double = 0;       { ... auch anisotrop !           }
  scr_TwipsPerPixel : Double = 0;       { Für das Rendern in eine Bitmap }
  ScreenPPCMx       : Double = 0;       { Bildschirmauflösung horizontal ("P"ixels "P"er "CM") }
  ScreenPPCMy       : Double = 0;       { Bildschirmauflösung vertikal   ("P"ixels "P"er "CM") }
  MaxDrawingWidth   : Integer = 0;      { Maximale Breite des Clientbereichs der Zeichnung     }
  MaxDrawingHeight  : Integer = 0;      { Maximale Höhe des Clientbereichs der Zeichnung       }
  ppcm_corrfactor   : Double  = 1;      { Korrekturfaktor für die Skalierung einer Zeichnung,
                                          die von einem Rechner mit anderem ppcm stammt        }
  ExportBitmap_dpi  : Integer = 0;      { Auflösung der exportierten BMP-, JPG- und PNG-Bilder }

  StartLinks        : Integer = 80;     { Abmessungen des letzten Fensters       }
  StartOben         : Integer = 80;
  StartBreite       : Integer = 480;
  StartHoehe        : Integer = 320;
  StartWindowState  : Integer = 0;      { Größeneinstellung des Startfensters:   }
                                        {   0 : Standard (zentriert mit Rand)    }
                                        {   1 : Maximiert                        }
                                        {   2 : letztes Fenster wiederherstellen }
  OSisNT      : Boolean = False;        { True, wenn Betriebssystem NT4 oder neuer ist  }
  GDIMaxInt   : Integer = 32767;        { Maximaler Koordinatenbereich für GDI-Aufrufe :
                                            2^15-1; vorsichtshalber beschränkt auf den
                                            16-Bit-MaxInt-Bereich; ist erst ab WinNT4
                                            2^27 groß; wird zur Laufzeit gemäß
                                            vorgefundenem OS aktualisiert               }
  GDIMaxRadius: Integer =  3276;        { Grenze für Zeichenfunktionen: ab hier muss
                                            "vorsichtig" gezeichnet werden !            }

  UserIsAdmin         : Boolean = False;{ True, wenn der Benutzer in die zentrale
                                            DYNAGEO.INI schreiben darf                  }
  ActualMenuConfigKey : String  = '';   { enthält den Key der aktuell aktiven
                                            Menü-Konfiguration                          }
  EditOptionsAllowed  : Boolean = True; { Wenn False, dann wird der Menüpunkt
                                            "Einstellungen" gesperrt                    }
  SaveOptionsAllowed  : Boolean = True; { Regelt, ob eigene Einstellungen abgespeichert
                                            werden dürfen                               }
  ChooseMenuAllowed   : Boolean = True; { False, wenn die Menükonfiguration in der
                                            zentralen DYNAGEO.INI vorgeschrieben wird   }
  EditMenuesAllowed   : Boolean = True; { False, wenn der Benutzer keine eigenen
                                            Menü-Konfigurationen erstellen darf         }
  UserOptFileInExeDir : Boolean = False;{ False, wenn die Benutzer-Einstellungen
                                            möglichst im User-Profil abgelegt werden
                                            sollen ( = empfohlener Normalfall ! )       }

  MyMoveCursor  : AnsiChar = #$03; {6B}     { Test-Variablen mit falschen }
  MyHelpCursor  : AnsiChar = #$17; {AD}     {   Werten  vorbelegt;        }
  MyInputCursor : AnsiChar = #$19; {F8}     { korrekte Werte dahinter !   }
  MyCatchCursor : AnsiChar = #$42; {3C}
  MyDragCursor  : AnsiChar = #$81; {A3}
  MyPickCursor  : AnsiChar = #$38; {D6}
  MyZoomCursor  : AnsiChar = #$A4; {39}
  MyStopCursor  : AnsiChar = #$B0; {A1}


  Hand_Cursor     : TCursor = 1;          { Cursorwerte }
  Help_Cursor     : TCursor = 2;
  Input_Cursor    : TCursor = 3;
  Catch_Cursor    : TCursor = 4;
  Drag_Cursor     : TCursor = 5;
  PickUp_Cursor   : TCursor = 6;
  Hand_FatCursor  : TCursor = 7;
  Input_FatCursor : TCursor = 8;
  Catch_FatCursor : TCursor = 9;

  CatchDist     : Integer = 5;
  ZoomFaktor    : Double  = 1.50;
  PointSize     : Integer = 4;          { Radius des Punktkreises (= halbe Seite des Punktquadrats)   }

  ToolPointStyleNum : Integer     = 0;          { aktuelle Punktform      }
  ToolLineStyleNum  : Integer     = 0;          { aktueller Linienstil    }
  ToolObjColour     : TColor      = clBlack;    { aktuelle Objektfarbe    }
  ToolFillStyleNum  : Integer     = 2;          { aktuelles Füllmuster    }
  ToolFillColour    : TColor      = clRed;      { aktuelle Füllfarbe      }
  GlobalDefaultFont : TFont       = Nil;        { Font für Beschriftungen }

  TraceOnly     : Boolean = False;      { nächste Ortslinie nur als Spur aufzeichnen                  }
  OLineMode     : Integer = 0;          { Ortslinien-Modus:                      }
                                        {   0 : keine Ortslinie aktiv            }
                                        {   1 : Auswahl des 1. Punktes läuft     }
                                        {   2 : Auswahl weiterer Punkte läuft    }
                                        {   3 : Punktauswahl abgeschlossen       }
                                        {   4 : Aufzeichnung der Ortslinie       }

  SynchronizeCols : Boolean = True;     { neue Objektfarbe wird auch für den Namen verwendet          }
  ExtPointCmd     : Boolean = False;    { Smarter "Punkt"-Befehl (Automatische Bindung bzw. Schnitt)  }
  CmdAutoRepeat   : Boolean = False;    { Automatische Wiederholung des letzten Befehls               }
  SignedAngles    : Boolean = True;     { Winkelorientierung wird berücksichtigt                      }
  SignedAreas     : Boolean = False;    { Flächen mit Vorzeichen auch bei Polygonen, Kreisen....      }
  RightAnglePt    : Boolean = False;    { Rechte Winkel rund mit Punkt markieren statt Winkelhaken    }
  FillAngleSector : Boolean = True;     { Winkelmarkierungen gefüllt anzeigen                         }
  SelObjHover     : Boolean = True;     { Hover-Effekt für selektierte Eingabe-Objekte                }
  DefDragStrategy : Integer = 0;        { Standardwert der Aktualisierungsstrategie im Zugmodus für
                                          neue Zeichnungen:
                                            0 : Reversibilität anstreben (wie Cabri)
                                            1 : Kontinuität anstreben (wie Cinderella)                }

  DefLengthUnit   : String = ' cm ';    { Einheiten-String für Abstandsmaße                           }
  DefAngleUnit    : String = ' ° ';     { Einheiten-String für Winkelmaße                             }
  DefAreaUnit     : String = ' cm² ';   { Einheiten-String für Flächenmaße                            }
  AngleEpsilon    : Double  = pi/360;   { Genauigkeit des Winkelvergleichs (Standard: 0.5 Grad)       }
  DistEpsilon     : Double  = 1e-8;     { Genauigkeit des Längenvergleichs (Standard: 1e-8 Pixel)     }
  AngleDecimals   : Integer = 0;        { Genauigkeit bei Winkelmaß-Ausgaben (Standard : 0)           }
  LengthDecimals  : Integer = 3;        { Genauigkeit bei Längenmaß-Ausgaben (Standard : 3)           }
  AreaDecimals    : Integer = 2;        { Genauigkeit bei Flächenmessungen  (Standard : 2)            }
  TermDigits      : Integer = 4;        { Anzahl der geltenden Stellen von Termen (Standard : 4)      }
  LineEqStyle     : Integer = 0;        { Form der Geradengleichung (Standard : 0)                    }

  ParamEpsilon    : Double  = 1e-6;     { Minimale Schrittweite bei Param-Variationen auf Ortslinien  }
  DefAniStep      : Double  = 1e-3;     { Standard-Schrittweite für Animationen                       }
  NumberQuant     : Double  = 1e-3;     { Standard-Quantisierungsschrittweite für Zahlobjekte         }
  PointQuant      : Double  = 1e-3;     { Standard-Quantisierungsschrittweite für Basispunkte         }
  MaxBending      : Double  = 1e-2;     { Maximaler Krümmungsparameter für Ortslinien                 }
  MaxGradient     : Double  = 10000;    { Maximaler Gradientenbetrag bei Ortslinien                   }

  MacroWarningsOn : Boolean = True;

    // Die Werte der folgenden 3 Konstanten später aus externen Optionen holen !?
  CheckCount      : Integer = 10;       { Anzahl der Korrektheits-Tests beim "Beweisen"               }
  SimSteps        : Integer = 40;       { Anzahl der Zwischenschritte für das automatische Verziehen  }
  SimShow         : Boolean = False;    { Sichtbarkeit des automatischen Zugvorgangs                  }

  NewCosysType    : Integer = 0;        { Typ des zuletzt verwendeten Koordinatensystems              }
                                        {   = 0 : Koordinatensystem nicht anzeigen                    }
                                        {   > 0 : nur Achsen mit Marken ( Wert = Abstand der Marken)  }
                                        {   < 0 : zusätzlich Beschriftungen an den Achsen             }
  DefCosysCol     : TColor = clGray;    { Voreingestellte Farbe des Koordinatensystems                }

  XAxisName       : String = 'x';
  YAxisName       : String = 'y';

  InitAngleRadius : Double  =     0.8;  { Radius des Winkelbogens bei der Initialisierung             }
  SetSquareHalfLen: Double  =     8.10; { Halbe Breite des virtuellen Geodreiecks                     }
  SpaceRoom       : Integer =    40;    { Breite des Teststreifens bei der Zeichensuche für RTF2BMP   }
  MaxCommentLen   : Integer = 10240;    { Maximale Anzahl der Zeichen in einer Kommentarbox           }
  NameRenderWin   : TPoint  =  (x:210;  { Abmessungen des Fensters zur Eingabe von Namen; wird bei    }
                                y: 70); {   der Initialisierung des Hauptformulars aktualisiert       }

  InternalLineStyle         : Boolean = False;  { Nicht durchgezogene gerade Linien stückweise zeichnen? }
  InternalCurvStyle         : Boolean = False;  { Nicht durchgezogene Kurven stückweise zeichnen?        }
  Double_Buffered           : Boolean = True;   { Bildschirmausgaben intern puffern? Default: Ja! (True) }
  PrnNeedsLineSupport       : Boolean = False;  { Drucker kann keine gestrichelten Linien zeichnen?      }
  PrnNeedsCurvSupport       : Boolean = False;  { Drucker kann keine gestrichelten Kurven zeichnen?      }
  PrnKnowsHatchedFillings   : Boolean = False;  { Drucker kann gestrichelte Füllungen drucken?           }
  PrnKnowsUserDefinedBrush  : Boolean = False;  { Drucker kann mit benutzerdefiniertem Pinsel ausfüllen? }
  ClipboardNeedsLineSupport : Boolean = True;   { Vorsichtshalber immer ?                                }
  ClipboardNeedsCurvSupport : Boolean = True;   { Vorsichtshalber immer ?                                }
  ClipboardScaleX           : Double  = 1.00;   { Skalierungsfaktor für die x-Richtung  (Skal-FktrX)     }
  ClipBoardAspect           : Double  = 1.00;   { =  Skal-FktrY / Skal-FktrX                             }

  ShowMeasuresFramed        : Boolean = False;  { Rahmen um Maßangaben ?                            }
  NoNamesInConstrText       : Boolean = True;   { Namen- und Maßobjekte im KonstText unterdrücken ? }
  PolyFilled                : Boolean = True;   { Neue Polygone *mit* Füllung erzeugen ?            }
  PolyFillMode              : Integer = Alternate;  { Windows-Füllmodus (Alternate | Winding)       }
  Use_Fat_Cursors           : Boolean = False;  { Dick gezeichnete Auswahlcursor verwenden?         }
  RecursionAllowed          : Boolean = True;   { Zirkuläre Bezüge zwischen Funktionen zulassen?    }

  DefBasePointStyle         : Integer =  1;     { Default-Werte für Objekt-Darstellung              }
  DefCoordPointStyle        : Integer =  3;
  DefConstrPointStyle       : Integer =  0;
  DefNormalLineStyle        : Integer =  0;

  DefLocLineStyle           : Integer =  1;
  DefLocLineStatus          : Integer =  3;     { Dokumentation siehe GeoLocLines.TGLocLine         }
  LocLinesDynamic           : Boolean = True;   { Ortslinien als dynamische Kurven erzeugen?        }
  LocLinesStandard          : Boolean = False;  { Ortslinien-Konversion in Standardkurven anbieten  }
  EnvLinesDynamic           : Boolean = True;   { Hüllkurven als dynamische Kurven erzeugen?        }
  EnvShowLines              : Boolean = False;  { Bei Hüllkurven die Geradenschar ausblenden        }
  EnvShowCurve              : Boolean = True;   { Bei Hüllkurven die Kurve selbst zeigen            }

  OLMinDist                 : Double  = 5.0;    { Minimaler Abstand zweier benachbarter Punkte der OL  }
  OLMaxDev                  : Double  = pi/36;  { Maximale Richtungsänderung einer Ortslinie zwischen  }
                                                {   2 benachbarten Stützpunkten  ( Standardwert: 10° ) }
  LocSL_LineLimit           : Double  = 0.999;  { Qualitätsgrenzen für die Ortslinien-Approximation    }
  LocSL_CircleLimit         : Double  = 0.998;  {   durch Standardlinien (Geraden oder Kreise          }
  LocSL_ConicLimit          : Double  = 0.997;  {                         oder Kegelschnitte)          }
  MaxRiemannCount           : Integer = 256;    { Maximalzahl der Teilintervalle einer Riemannsumme    }

  AutoTraceMirrorAxis   : Boolean = True;   { Automatische Erzeugung der }
  AutoTraceMirrorCentre : Boolean = True;   {   Punkt-Spuren bei den     }
  AutoTraceMove         : Boolean = True;   {   einzelnen Abbildungen    }
  AutoTraceRotate       : Boolean = True;
  AutoTraceStretch      : Boolean = True;



  { Konstanten zur Zusammensetzung und Interpretation der
    Status-Variablen eines Geo-Objektes                    }
  gs_IsFlagged    = $00000001;   {    1 }
  gs_IsReversed   = $00000002;   {    2 ; für Punkte, Winkel, Bögen und Kreise }
  gs_HasNameObj   = $00000004;   {    4 }
  gs_IsMarked     = $00000010;   {   16 }
  gs_IsMakMarked  = $00000020;   {   32 }
  gs_IsBlinking   = $00000040;   {   64 }
  gs_IsMoving     = $00000080;   {  128 }
  gs_ShowsOnlyNow = $00000100;   {  256 }
  gs_ShowsAlways  = $00000200;   {  512 ; falls möglich ! }
  gs_IsGrouped    = $00000400;   { 1024 ; nur während der Gruppierung ! }
  gs_IsWaiting    = $00000800;   { 2048 }
  gs_DataCanShow  = $00001000;   { 4096 }
  gs_DataValid    = $00002000;   { 8192 }

  gs_IsVisible    = gs_DataValid or gs_DataCanShow or gs_ShowsOnlyNow;  { 12544 }
  gs_Normal       = gs_DataValid or gs_DataCanShow or gs_ShowsAlways;   { 12800 }
  gs_FreeMask     = gs_DataValid or gs_DataCanShow or gs_HasNameObj;

  { Selektor-Konstanten für TGeoObj.GetValue }
  gv_val      = $00000000;  { liefert die Größe von Maßobjekten                }
  gv_x        = $00000001;  { liefert die x-Koordinate                         }
  gv_y        = $00000002;  { liefert die y-Koordinate                         }
  gv_len      = $00000003;  { liefert Streckenlänge, Bogenlänge, Umfang        }
  gv_radius   = $00000004;  { liefert den Radius (nur bei Kreisen!)            }
  gv_area     = $00000005;  { liefert den Flächeninhalt (Kreis, Polygon)       }
  gv_min      = $00000006;  { liefert die Untergrenze (bei TGNumberObj)        }
  gv_max      = $00000007;  { liefert die Obergrenze (bei TGNumberObj)         }
  gv_quant    = $00000008;  { liefert die Quantisierung für Zahlobjekte        }
  gv_slope    = $00000009;  { liefert bei Geraden die Steigung                 }
  gv_vertices = $00000010;  { liefert bei Polygonen die Anzahl der Ecken       }

  { Selektor-Konstanten für TGLocLine.OLStatus / TGEnvelopLine.OLStatus   }
  { ACHTUNG ! Nicht alle Eigenschaften sind unabhängig! Wegen der Details
              über die gegenseitigen Abhängigkeiten siehe die Get/Set-
              Funktionen in GeoLocLines.pas!                              }
  ols_IsDynamic      = $00000001;
  ols_IsSpline       = $00000002;
  env_ShowCurve      = $00000004;
  env_ShowLines      = $00000008;

  ols_TryStandard    = $00008000;
  ols_IsStraightLine = $00010000;
  ols_IsCircle       = $00020000;
  ols_IsConic        = $00040000;


  { Menge der Maus-relevanten Konstanten in TShiftState }
  ssMouse : TShiftState = [ssLeft, ssRight, ssMiddle, ssDouble];

  { EUKLID - ShortCuts }
  SC_Repeat       : Word    = Word('W');  { Deutsche Vorbelegung }

  { FormatEdit-ShortCuts }
  key_Bold        : Integer =  6;         { Deutsche Vorbelegung }
  key_Italic      : Integer = 11;
  key_UnderLine   : Integer = 21;
  key_Subscript   : Integer =  9;
  key_Superscript : Integer =  5;

  { Zeichen, die in Namen von GeoObjekten verwendet werden dürfen }
  NameChar      : TSysCharSet = ['_', '0'..'9', 'A'..'Z', 'a'..'z',
                                 'ä', 'ö', 'ü', 'Ä', 'Ö', 'Ü', 'ß',
                                 '''', '´', '`', '#', 'ç', 'Ç',
                                 'á', 'à', 'â', 'Á', 'À', 'Â',
                                 'é', 'è', 'ê', 'É', 'È', 'Ê',
                                 'í', 'ì', 'î', 'Í', 'Ì', 'Î',
                                 'ó', 'ò', 'ô', 'Ó', 'Ò', 'Ô',
                                 'ú', 'ù', 'û', 'Ú', 'Ù', 'Û'];
  NameWChar     : WideString  = '_01234566789' +
                                'ABCDEFGHIJKLMNOPQRSTUVWXYZ' +
                                'abcdefghijklmnopqrstuvwxyz' +
                                'äöüÄÖÜß''´`#çÇ' +
                                'áàâÁÀÂéèêÉÈÊíìîÍÌÎóòôÓÒÔúùûÚÙÛ';
       { enthält nur die für Namen zugelassenen ASCII-Zeichen!
         Die Nummern der zugelassenen "Griechen" sind in
         OrderedGreekList aufgeführt. In der Unit "Utility"
         steht eine }

  { Zeichen, die Namen vom Rest des Textes trennen }
  delimiters    : TSysCharSet = [' ', '.', ',', ':', ';', '+', '-',
                                 '(', ')', '[', ']', '{', '}',
                                 '?', '!', '"', '/', '\'];
  DelimiterWChar: WideString  = ' .,:;+-()[]{}?!"/\';

  { Dezimal-Ziffern }
  DecimalDigits : TSysCharSet = ['0', '1', '2', '3', '4',
                                 '5', '6', '7', '8', '9'];

  { Klammern für die Interpretation von Term-Strings }
  brackets : WideString  = '()[]{}';

  SymTab   : Array[1..4] of String = ('abgdehfj' + 'klmnopqr',
                                      'stuwxycz' + 'GDFJLPWY',
                                      '^|ÐÇÈÌÍÎ' + 'Ï£³¹Æ¥$"',
                                      '×·´*±®ÞÛ' + '¬Öåò¿»  ');
  SymList  : String     = '';  // Werden erst beim Programmstart initialisiert,
  WSymList : WideString = '';  // um Synchronizität mit symTab zu garantieren !

  WSymNumList : Array[1..64] of Word =
       ($03B1, $03B2, $03B3, $03B4, $03B5, $03B7, $03A6, $03C6,
        $03BA, $03BB, $03BC, $03BD, $03BF, $03C0, $0398, $03C1,
        $03C3, $03C4, $03C5, $03C9, $03BE, $03C8, $03C7, $03B6,
        $0393, $0394, $03A6, $03B8, $039B, $03A0, $03A9, $03A8,

        $0015, $2551, $0015, $0015, $0015, $0015, $0015, $0015,
        $0015, $2264, $2265, $2260, $00D8, $221E, $0015, $0015,
        $0015, $0015, $0015, $0015, $00B1, $0015, $0015, $0015,
        $0015, $221A, $2211, $0015, $0015, $2248, $0020, $0020);

  OrderedGreekNumList : Array[1..32] of Word =
       ($0393, $0394, $0398, $039B, $03A0, $03A6, $03A8, $03A9,
        $03B1, $03B2, $03B3, $03B4, $03B5, $03B6, $03B7, $03B8,
        $03BA, $03BB, $03BC, $03BD, $03BE, $03BF, $03C0, $03C1,
        $03C3, $03C4, $03C5, $03C6, $03C7, $03C8, $03C9, $0000);

  wccError = WideChar($0015);    // Fehlermelde-Signale für die
  ccError  = Char($15);          //   Zeichenkonvertierungen

  { Mathematische Sonderzeichen in HTML-Notation }
  klgl : String = '<font face="Symbol"> ' + #163 + ' </font>';
  grgl : String = '<font face="Symbol"> ' + #179 + ' </font>';
  elem : String = '<font face="Symbol"> ' + #206 + ' </font>';

  { Kommando-Arten }
  Repeatable_Commands : Set of Byte =
           [cmd_PtCoord..cmd_Vector, cmd_Polare, cmd_Pol,
            cmd_MirrorAxisObj..cmd_RepeatMapping, cmd_PonLine,
            cmd_ToggleVis..cmd_DelObj, cmd_EditDraw,
            cmd_PCreate..cmd_DCreate, cmd_LCreate..cmd_GRichtTerm,
            cmd_SRichtTerm, cmd_BindP2L..cmd_MeasureDist,
            cmd_MeasureArea, cmd_FixPt..cmd_Clip2Grid,
            cmd_FillArea..cmd_CutArea, cmd_WHalbKomp];

  Construct_Commands  : Set of Byte =
           [cmd_RegPoly, cmd_Verging..cmd_RepeatMapping, cmd_NumberObj,
            cmd_TermObj, cmd_PonLine, cmd_PCreate..cmd_GRichtTerm,
            cmd_Chordal..cmd_CircleSLR, cmd_RunMakro, cmd_FillArea,
            cmd_CutArea, cmd_WHalbKomp, cmd_Conic..cmd_Riemann,
            cmd_Polynom];

  Hover_Commands : Set of Byte =
           [cmd_RegPoly, cmd_Verging..cmd_RepeatMapping, cmd_NumberObj,
            cmd_TermObj, cmd_PonLine, cmd_PCreate..cmd_GRichtTerm,
            cmd_RunMakro, cmd_BindP2L, cmd_ReleaseP, cmd_WHalbKomp,
            cmd_Conic..cmd_Riemann, cmd_Pt2BasePt, cmd_CombinePts];

  Measure_Commands    : Set of Byte =
           [cmd_MarkAngle..cmd_MeasureDist,
            cmd_MeasureSL, cmd_MeasureArea];

  EditBar_Commands    : Set of Byte =
           [cmd_EditDraw, cmd_FillArea, cmd_CutArea];

  ViewerPopup_Commands: Set of Byte =
           [cmd_NameObj, cmd_ToggleVis, cmd_BindP2L, cmd_ReleaseP,
            cmd_EditLocLineStyle, cmd_EditLocLineCurve, cmd_EditLocLineDyna,
            cmd_EditColour, cmd_EditLineStyle, cmd_EditPointStyle,
            cmd_EditPattern, cmd_EditComment, cmd_EditTerm, cmd_EditRange,
            cmd_EditRadius, cmd_EditAngle, cmd_EditCoords, cmd_EditFunktion,
            cmd_SetDotPt];

  NoReset_Commands: Set of Byte =
           [cmd_DefineAffin, cmd_RCreate, cmd_FCreate, cmd_NCreate,
            cmd_Conic, cmd_ParabelT, cmd_TermInput, cmd_BlinkBaseObj,
            cmd_Group, cmd_Riemann, cmd_Polynom];

  MultiSelect_Commands: Set of Byte =
           [cmd_BindP2L];

  { Spiele-Menü-Konfiguration: 'C'ommands'2D'elete'B'efore'P'laying'G'ames }
  C2DBPG : Array [0..35] of Integer =
    (078, 079, 090, 091, 092, 101, 102, 103, 104, 105,
     106, 112, 113, 114, 118, 129, 139, 141, 142, 143,
     144, 146, 152, 153, 154, 155, 156, 158, 159, 203,
     204, 235, 241, 242, 243, 244);

  { Spiele-Menü-Konfiguration: 'C'ommands'2D'elete'A'fter'P'laying'G'ames }
  C2DAPG : Array [0..99] of Integer =
    (0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

  { 'C'ompatibility 'C'odes für TypesCompatible  }
  ccDragableObj       =   1;
  ccBasePoint         =  10;  { = Basispunkt, auch gebunden ! }
  ccNamedObj          =  11;
  ccCoordPoint        =  16;
  ccPointWOParents    =  17;  { = freier Basispunkt }
  ccPointOnCurve      =  18;  { = gebundener Basispunkt }
  ccPointWParents     =  19;  { = abgeleiteter Punkt oder gebundener Basispunkt }
  ccAnyPoint          =  29;  { = irgend ein Punkt }
  ccPointOrShortLn    =  31;
  ccPointOrVector     =  32;
  ccPointOrArc        =  33;
  ccPointOrCircle     =  34;
  ccVector            =  36;
  ccShortLine         =  37;
  ccPointOrStraightLn =  38;
  ccStraightLine      =  39;
  ccMappableObj       =  44;
  ccMakroDefObj       =  45;   { = Point, Circle, Straightline, Polygon, Conic, Area  }
  ccDistableObj       =  47;
  ccAnyLine           =  48;
  ccCircle            =  49;
  ccAnyPoly           =  51;
  ccBorderLine        =  52;   { = LongLine or Circle or Ellipse or Polygon }
  ccSimpleLine        =  53;   { = StraightLine or Circle or Conic }
  ccConicOrCircle     =  56;
  ccConic             =  57;
  ccCurveWithTans     =  58;   { = Circle or Conic or Function }
  ccPointOrAngle      =  59;
  ccParentObj         =  69;
  ccAnyAngleObj       =  85;
  ccComment           =  88;
  ccMeasureObj        =  89;
  ccArea              =  90;
  ccBorderOrArea      =  91;  { = LongLine or Circle or Ellipse or Polygon or Area }
  ccNumberObj         =  93;
  ccTermObj           =  94;
  ccFunktion          =  95;  { = Funktion }
  ccFunktionOrAxis    =  96;  { = Funktion or Axis }
  ccAnyObjNoArea      =  98;
  ccAnyGeoObj         = 100;

  varTypeStrs : Array [0..4] of String =
                  ('Punkt', 'Strecke', 'Gerade', 'Kreis', 'Kegelschnitt');
  varTypeIds  : Array [0..4] of Integer =
                  (ccAnyPoint, ccShortLine, ccStraightLine, ccCircle, ccConic);

  MaxModeListIndex = 102;
  InitModeList : Array [0..MaxModeListIndex, 0..5] of Integer =
    ((cmd_ToggleVis,   ccAnyGeoObj,    0,  0,   0, 33),     {  irgend ein Objekt }
     (cmd_NameObj,     ccNamedObj,     0,  0,   0, 31),     {  Geom. Objekt oder Winkel        }
     (cmd_DelObj,      ccAnyGeoObj,    0,  0,   0, 32),     {  irgend ein Objekt }
     (cmd_EditDraw,    ccAnyObjNoArea, 0,  0,   0, 37),     {  irgend ein Objekt }

     (cmd_PCreate,      0,                0,                0,           10,   2),     {* Basispunkt        }
     (cmd_LatticePt,    0,                0,                0,           10, 111),     {* Gitterpunkt       }
     (cmd_SCreate,      ccAnyPoint,       ccAnyPoint,       0,           31,   3),     {  Strecke           }
     (cmd_Vector,       ccAnyPoint,       ccPointOrVector,  0,           47,  54),     {  Vektor            }
     (cmd_GCreate,      ccAnyPoint,       ccAnyPoint,       0,           32,   4),     {  Gerade            }
     (cmd_KCreate,      ccAnyPoint,       ccAnyPoint,       0,           41,   5),     {  Kreis             }
     (cmd_Circle3P,     ccAnyPoint,       ccAnyPoint,       ccAnyPoint,   0,  98),     {  Kreis durch 3 Punkte   (ALT) }
     (cmd_CircleSLR,    ccPointOrShortLn, ccAnyPoint,       ccAnyPoint,   0, 107),     {  "In den Zirkel nehmen" (ALT) }

     (cmd_RCreate,      0,                0,                0,           30,   7),     {* Basisgerade       }
     (cmd_FCreate,      0,                0,                0,           40,   8),     {* Basiskreis        }
     (cmd_LCreate,      ccAnyPoint,       ccAnyPoint,       0,           37,  25),     {  Strecke mit bestimmter Länge }
     (cmd_EditLength,   0,                0,                0,            0,  25),     {  Streckenlänge editieren      }
     (cmd_MCreate,      ccAnyPoint,       0,                0,           43,  23),     {  Kreis mit bestimmtem Radius  }
     (cmd_EditRadius,   0,                0,                0,            0,  23),     {  Kreisradius editieren        }
     (cmd_DCreate,      ccPointOrShortLn, ccPointOrShortLn, ccAnyPoint,  51,   6),     {  Dreieck           }
     (cmd_NCreate,      ccAnyPoint,       0,                0,           51,  34),     {  N-Eck             }
     (cmd_RegPoly,      ccAnyPoint,       ccAnyPoint,       0,           51, 103),     {  Reguläres N-Eck   }
     (cmd_Graph,        0,                0,                0,            0,  81),     {  Funktionsgraph    }
     (cmd_Conic,        ccAnyPoint,       0,                0,           57,  77),     {  Kegelschnitt      }
     (cmd_EllipseF,     ccAnyPoint,       ccAnyPoint,       ccAnyPoint, 222,  84),     {  Ellipse (2 BrPte, KuPt)      }
     (cmd_EllipseS,     ccAnyPoint,       ccAnyPoint,       ccAnyPoint, 223,  85),     {  Ellipse (MiPt, HS, NKPt)     }
     (cmd_EllipseK,     ccAnyPoint,       ccAnyPoint,       ccAnyPoint, 224,  86),     {  Ellipse (MiPt, 2 konj. Pte)  }
     (cmd_ParabelF,     ccAnyPoint,       ccStraightLine,   0,          225,  87),     {  Parabel (BrPt, Leitgerade)   }
     (cmd_ParabelT,     ccAnyPoint,       0,                0,          226,  89),     {  Parabel (2 Ber.Pte + Tang.R. }
     (cmd_HyperbelF,    ccAnyPoint,       ccAnyPoint,       ccAnyPoint, 228,  88),     {  Hyperbel (2 BrPte, KuPt)     }
     (cmd_HyperbelA,    ccStraightLine,   ccStraightLine,   ccAnyPoint, 227,  91),     {  Hyperbel (2 Asympt., 1KuPt   }

     (cmd_PonLine,      ccAnyLine,        0,                0,           10,  29),     {  Punkt auf einer Linie        }
     (cmd_MakeLocLine,  ccAnyPoint,       0,                0,            0,  20),     {  Ortslinie         }
     (cmd_MakeEnvelop,  ccStraightLine,   0,                0,          235, 112),     {  Einhüllende       }
     (cmd_Schnitt,      ccSimpleLine,     ccSimpleLine,     0,           11,  10),     {  Schnittpunkt(e)   }
     (cmd_Mitte,        ccPointOrShortLn, ccAnyPoint,       0,           14,  11),     {  Mittelpunkt       }

     (cmd_MirrorAxisObj,   ccMappableObj,  ccStraightLine,  0,            0,  47),     {  Achsengespiegeltes Objekt    }
     (cmd_MirrorCentreObj, ccMappableObj,  ccAnyPoint,      0,            0,  55),     {  Punktgespiegeltes Objekt     }
     (cmd_MoveObj,         ccMappableObj,  ccVector,        0,            0,  51),     {  Verschobenes Objekt          }
     (cmd_RotateObj,       ccMappableObj,  ccAnyPoint,      ccAnyAngleObj,0,  53),     {  Gedrehtes Objekt             }
     (cmd_StretchObj,      ccMappableObj,  ccAnyPoint,      ccMeasureObj, 0,  64),     {  Zentrisch gestrecktes Objekt }
     (cmd_MirrorCircleObj, ccMappableObj,  ccCircle,        0,           15,  57),     {  Kreisgespiegeltes Objekt     }
     (cmd_MapObj,          ccMappableObj,  0,               0,            0,  92),     {  Affin abgebildetes Objekt    }
     (cmd_RepeatMapping,   ccMappableObj,  0,               0,            0,  92),     {  Letzte Abbildung wiederholen }
     (cmd_DefineAffin,     ccStraightLine, 0,               0,            0,   0),     {  Achsen-Affinität }
     (cmd_EditMap,         0,              0,               0,            0,   0),     {  Matrix anschauen / ändern    }

     (cmd_Strahl,       ccAnyPoint,       ccAnyPoint,       0,           47,  48),     {  Halbgerade        }
     (cmd_MSenkr,       ccPointOrShortLn, ccAnyPoint,       0,           33,  11),     {  Mittelsenkrechte  }
     (cmd_WHalb,        ccPointOrAngle,   ccAnyPoint,       ccAnyPoint,  36,  13),     {  Winkelhalbierende }
     (cmd_WHalbKomp,    ccPointOrAngle,   ccAnyPoint,       ccAnyPoint,   0,  13),     {  Außenwinkelhalbierende (ALT) }
     (cmd_Parall,       ccAnyPoint,       ccStraightLine,   0,           35,  14),     {  Parallele         }
     (cmd_Lot,          ccAnyPoint,       ccStraightLine,   0,           34,  14),     {  Lot               }
     (cmd_LotStrecke,   ccAnyPoint,       ccStraightLine,   0,            0,  14),     {  Lotstrecke             (ALT) }
     (cmd_GRichtTerm,   ccAnyPoint,       ccAnyPoint,       ccAnyPoint,  48,  27),     {  Gerade mit bestimmter Richtung,
                                                                                           hier mit Orientierungspunkt }
     (cmd_SRichtTerm,   ccAnyPoint,       ccAnyPoint,       ccAnyPoint,  48,  27),     {  Strahl mit bestimmter Richtung,
                                                                                           hier mit Orientierungspunkt }
     (cmd_Tangente,     ccPointOnCurve,   0,                0,            0,  82),     {  Tangente an eine Kurve       }
     (cmd_Normale,      ccPointOnCurve,   0,                0,            0,  83),     {  Normale auf eine Kurve (ALT) }
     (cmd_Polare,       ccAnyPoint,       ccConicOrCircle,  0,            0, 100),     {  Polare                       }
     (cmd_Pol,          ccStraightLine,   ccConicOrCircle,  0,            0, 101),     {  Pol                          }
     (cmd_Chordal,      ccPointOrCircle,  ccPointOrCircle,  0,            0,  99),     {  Chordale zweier
                                                                                           Kreise oder Punkte   (ALT) }
     (cmd_EditAngle,    0,                0,                0,            0,   6),     {  Geradenrichtung editieren    }

     (cmd_Arc,          ccAnyPoint,       ccAnyPoint,       ccAnyPoint,  44,  45),     {  Kreisbogen        }
     (cmd_Area2Foregr,  ccArea,           0,                0,            0,  73),     {  Fläche in den Vordergrund holen }
     (cmd_TogglePolyF,  ccAnyPoly,        0,                0,            0,  46),     {  NEck füllen/Füllung entfernen   }

     (cmd_DefMakro,     ccMakroDefObj,    0,                0,            0,   1),     {  Makrodefinition starten    }
     (cmd_RunMakro,     0,                0,                0,            0,  15),     {  Makro laufen lassen        }

     (cmd_BindP2L,      ccBasePoint,      ccAnyLine,        0,            0,  16),     {  Punkt binden      }
     (cmd_ReleaseP,     ccBasePoint,      0,                0,            0,  17),     {  Punkt lösen       }
     (cmd_MarkAngle,    ccAnyPoint,       ccAnyPoint,       ccAnyPoint,  52,  13),     {  Winkel markieren  }
     (cmd_MeasureAngle, ccPointOrAngle,   ccAnyPoint,       ccAnyPoint,   0,  30),     {  Winkel messen     }
     (cmd_MeasureArea,  ccBorderOrArea,   0,                0,            0, 102),     {  Fläche messen     }
     (cmd_MeasureDist,  ccDistableObj,    ccDistableObj,    0,           81,  18),     {  Abstand messen    }
     (cmd_MeasureSL,    ccPointOrShortLn, 10,               0,           81,  43),     {  Streckenlänge     }
     (cmd_TermInput,    ccMeasureObj,     0,                0,            0,  35),     {  Term-Eingabe      }
     (cmd_NumberObj,    0, {ccBasePoint,} 0,                0,           91,  59),     {  Zahlobjekt        }
     (cmd_TermObj,      0, {ccBasePoint,} 0,                0,           92,  61),     {  Termanzeige       }
     (cmd_EditTerm,     ccTermObj,        0,                0,            0,  62),     {  Termanzeige editieren      }
     (cmd_EditFunktion, 0,                0,                0,            0,  81),     {  Funktions-Term editieren   }
     (cmd_EditComment,  ccComment,        0,                0,            0,  66),     {  Textbox editieren          }
     (cmd_BindTBox2Obj, ccComment,        ccParentObj,      0,            0,  67),     {  Textbox an Objekt binden   }
     (cmd_ReleaseTBox,  ccComment,        0,                0,            0,  72),     {  Textbox-Bindung lösen      }

     (cmd_FixPt,        ccBasePoint,      0,                0,           16,  39),     {  Punkt im Koordinatensystem fixieren }
     (cmd_UnfixPt,      ccCoordPoint,     0,                0,           10,  40),     {  Fixierung eines Punktes lösen       }
     (cmd_Clip2Grid,    ccPointWOParents, 0,                0,           16,  41),     {  Punkt auf Gitterpunkt schieben      }
     (cmd_PtCoord,      0,                0,                0,            0,  38),     {  Punkt mit festen Koordinaten        }
     (cmd_EditCoords,   0,                0,                0,            0,  38),     {  Punktkoordinatenterme editieren     }
     (cmd_EditXCoord,   0,                0,                0,            0, 110),     {  x-Koordinate v. geb. Pkt editieren  }
     (cmd_Pt2BasePt,    ccPointWParents,  0,                0,            0, 108),     {  Punkt in freien Basispunkt wandeln  }
     (cmd_CombinePts,   ccAnyPoint,       ccAnyPoint,       0,            0, 109),     {  Punkte zusammenführen               }

     (cmd_Slide,        0,                0,                0,            0,  19),     {  Zeichnung verschieben           }
     (cmd_FillArea,     ccBorderOrArea,   0,                0,            0,  69),     {  Kreis oder Polygon füllen       }
     (cmd_CutArea,      ccArea,           ccBorderLine,     ccAnyPoint,   0,  70),     {  Füllung zurechtschneiden        }
     (cmd_GraphArea,    ccFunktion,       ccAnyPoint,       ccAnyPoint,   0,  93),     {  Integral-Fläche                 }
     (cmd_Riemann,      ccFunktion,       ccAnyPoint,       ccAnyPoint,   0, 105),     {  Unter-/Obersumme                }
     (cmd_EditRieIntCount, 0,             0,                0,            0, 106),     {  Anzahl der Teilintervalle       }
     (cmd_SetDotPt,     ccBasePoint,      0,                0,            0,   0),     {  Spurpunkt setzen                }

     (cmd_Verging,      ccAnyPoint,     ccStraightLine,   ccStraightLine, 0,  78),     {  Strecke einschieben             }
     (cmd_Group,        ccAnyGeoObj,      0,                0,            0,  79),     {  Objekte zu Gruppe hinzufügen    }
     (cmd_EditGroup,    0,                0,                0,            0,  80),     {  Gruppen-Eigenschaften editieren }
     (cmd_CheckSol,     ccAnyPoint,       ccAnyPoint,       ccAnyPoint,   0,  95),     {  Beweiser               }
     (cmd_MagnGlass,    ccPointOnCurve,   0,                0,            0, 113),     {  Vergrößerungsglass     }
     (cmd_Game01,       0,                0,                0,            0, 114),     {  Spiel "Winkel schätzen"}
     (cmd_Game02,       0,                0,                0,            0, 115),     {  Spiel "Winkel messen"  }
     (cmd_Polynom,      ccAnyPoint,       0,                0,            0, 116) );   {  Interpolations-Polynom }

   {  Befehls-Id       -----------------------------------------------    |   |
                       |                                                  |   Hint-Nummer
                       |                                                  ZielobjektTyp
               Anfangsobjekt-Typen oder ~Typ-Gruppen                                   }

  index_EditDraw : Integer =     4;  // Index der EditDrawing-Leiste
  index_Animation: Integer =     6;  // Index der Animations-Leiste
  ShowLocLinePts : Boolean = False;  // Einschalten zur Debug-Diagnose bei Ortslinien-Problemen

  MaxXMLTypeIndex = 95;
  DeprTypeIndex   = MaxXMLTypeIndex - 16;  // Index des ersten veralteten Typs

  // Tabelle zur Umsetzung der Delphi-Klassennamen in XML-Bezeichner;
  // der 3. String ist genau dann "true", wenn dieser Typ schon in DynaGeoJ implementiert ist
  XMLTypeNames : Array [1..MaxXMLTypeIndex, 0..2] of String =
          (('TGPoint',              'Point',              'true'),
           ('TGVertexPt',           'Vertex',             'true'),
           ('TGXPoint',             'PointWDC',           'true'),
           ('TGLxLPt',              'PointLXL',           'true'),
           ('TGDoubleIntersection', 'DoubleIntersection', 'true'),
           ('TGQuadIntersection',   'QuadIntersection',   'true'),
           ('TGIntersectPt',        'IntersectPoint',     'true'),
           ('TGMiddlePt',           'MidPoint',           'true'),
           ('TGPol',                'PolPoint',           'true'),
           ('TGOrigin',             'Origin',             'true'),
           ('TGaugePoint',          'UnityPoint',         'true'),
           ('TGMappedPoint',        'MappedPoint',        'true'),

           ('TGShortLine',          'Segment',            'true'),
           ('TGVector',             'Vector',             'true'),
           ('TGHalfLine',           'Ray',                'true'),
           ('TGLongLine',           'Line',               'true'),
           ('TGBaseLine',           'BasisLine',          'true'),
           ('TGAxis',               'Axis',               'true'),
           ('TGXLine',              'LineWDD',            'true'),
           ('TGXRay',               'RayWDD',             'true'),
           ('TGSenkr',              'Perpendicular',      'true'),
           ('TGMSenkr',             'PerpBisector',       'true'),
           ('TGParall',             'ParallelLine',       'true'),
           ('TGWHalb',              'Bisector',           'true'),
           ('TGTangent',            'Tangent',            'true'),
           ('TGNormal',             'Normal',             'true'),
           ('TGPolare',             'Polar',              'true'),
           ('TGChordal',            'Chordal',            'true'),
           ('TGFixLine',            'Stick',              'true'),
           ('TGVergingLine',        'VergingLine',        ''),
           ('TGMappedLine',         'MappedLine',         'true'),

           ('TGCircle',             'Circle',             'true'),
           ('TGCircle3P',           'Circle3P',           'true'),
           ('TGArc',                'Arc',                'true'),
           ('TGBaseCircle',         'BasisCircle',        'true'),
           ('TGXCircle',            'CircleWDR',          'true'),
           ('TGMappedCircle',       'MappedCircle',       'true'),

           ('TGName',               'ObjectName',         'true'),
           ('TGAngle',              'Angle',              'true'),
           ('TGAngleWidth',         'MeasureAngle',       'true'),
           ('TGDistLine',           'MeasureDistance',    'true'),
           ('TGAreaSize',           'MeasureArea',        'true'),
           ('TGNumberObj',          'Number',             'true'),
           ('TGLogSlider',          'LogSlider',          ''),
           ('TGTermObj',            'Term',               'true'),
           ('TGComment',            'TextBox',            'true'),

           ('TGLocLine',            'Trace',              'true'),
           ('TGOLLongLine',         'LineTrace',          ''),     // ?
           ('TGOLCircle',           'CircleTrace',        ''),     // ?
           ('TGOLConic',            'ConicTrace',         ''),     // ?
           ('TGFunktion',           'Graph',              'true'),
           ('TGMappedLocLine',      'MappedTrace',        'true'),
           ('TGEnvelopLine',        'Envelope',           'true'),

           ('TGPolygon',            'Polygon',            'true'),
           ('TGRegPoly',            'RegPoly',            'true'),
           ('TGMappedRegPoly',      'MappedRegPoly',      'true'),
           ('TGConic',              'Conic',              'true'),
           ('TGEllipseF',           'EllipseF',           'true'),
           ('TGEllipseS',           'EllipseS',           'true'),
           ('TGEllipseK',           'EllipseK',           'true'),
           ('TGParabelF',           'ParabelF',           'true'),
           ('TGParabelT',           'ParabelT',           'true'),
           ('TGHyperbelF',          'HyperbelF',          'true'),
           ('TGHyperbelA',          'HyperbelA',          'true'),
           ('TGMappedConic',        'MappedConic',        'true'),
           ('TGIPolynomFkt',        'Polynom',            ''),

           ('TGArea',               'Area',               'true'),
           ('TGIntArea',            'IntArea',            'true'),
           ('TGRiemannArea',        'RiemannArea',        'true'),
           ('TGImage',              'Picture',            'true'),
           ('TGMappedImage',        'MappedPicture',      'true'),
           ('TGSetsquare',          'Setsquare',          ''),
           ('TGZoomFrame',          'ZoomFrame',          ''),
           ('TGFramePt',            'FramePoint',         ''),

           ('TGSimiliarity',        'Similiarity',        'true'),
           ('TGAffinMapping',       'AffineMapping',      'true'),
           ('TGInversion',          'Inversion',          'true'),
           ('TGCheckControl',       'CheckControl',       ''),


  { Verarbeitung veralteter Typen : }
  { =============================== }
  { a) Die folgenden Typen werden erst beim Schreiben einer neuen XML-GEO-Datei
       durch den neuen Typ ersetzt, indem die Daten im Format des neuen Typs in
       die Datei geschrieben werden                                            }

           ('TGCoordPt',            'PointWDC',           'true'),    // index = DeprTypeIndex
           ('TGFixCircle',          'CircleWDR',          'true'),
           ('TGDirLine',            'LineWDD',            'true'),

  { b) Die folgenden Typen werden beim Einlesen von alten binären GEO-Dateien
       ( <= 2.6) durch entsprechende neue ersetzt:                             }

           ('TGLot',                'Perpendicular',      'true'),    // FileIO.PatchOld26Objects !

  { c) Die folgenden Typen werden beim Einlesen von Daten im Format <= 2.7
       ersetzt durch TGMappedPoint, TGMappedLine, TGMappedCircle und passende
       TGTranformation-Instanzen                                               }

           ('TGMirrorPt',           'MirroredPoint',      ''),
           ('TGMovedPt',            'MovedPoint',         ''),
           ('TGRotatedPt',          'RotatedPoint',       ''),
           ('TGStretchedPt',        'StretchedPoint',     ''),
           ('TGMirrorLongLine',     'MirroredLine',       ''),
           ('TGMirrorLine',         'MirroredLine',       ''),        // (2.7: Nur a)!)
           ('TGMovedLongLine',      'MovedLine',          ''),
           ('TGRotatedLongLine',    'RotatedLine',        ''),
           ('TGStretchedLongLine',  'StretchedLine',      ''),
           ('TGMirrorCircle',       'MirroredCircle',     ''),
           ('TGMovedCircle',        'MovedCircle',        ''),
           ('TGRotatedCircle',      'RotatedCircle',      ''),
           ('TGStretchedCircle',    'StretchedCircle',    ''));


  MaxMessIndex = 174;
  MyMess : Array [0..MaxMessIndex] of String =
          (id_mess00, id_mess01, id_mess02, id_mess03, id_mess04,
           id_mess05, id_mess06, id_mess07, id_mess08, id_mess09,
           id_mess10, id_mess11, id_mess12, id_mess13, id_mess14,
           id_mess15, id_mess16, id_mess17, id_mess18, id_mess19,
           id_mess20, id_mess21, id_mess22, id_mess23, id_mess24,
           id_mess25, id_mess26, id_mess27, id_mess28, id_mess29,
           id_mess30, id_mess31, id_mess32, id_mess33, id_mess34,
           id_mess35, id_mess36, id_mess37, id_mess38, id_mess39,
           id_mess40, id_mess41, id_mess42, id_mess43, id_mess44,
           id_mess45, id_mess46, id_mess47, id_mess48, id_mess49,
           id_mess50, id_mess51, id_mess52, id_mess53, id_mess54,
           id_mess55, id_mess56, id_mess57, id_mess58, id_mess59,
           id_mess60, id_mess61, id_mess62, id_mess63, id_mess64,
           id_mess65, id_mess66, id_mess67, id_mess68, id_mess69,
           id_mess70, id_mess71, id_mess72, id_mess73, id_mess74,
           id_mess75, id_mess76, id_mess77, id_mess78, id_mess79,
           id_mess80, id_mess81, id_mess82, id_mess83, id_mess84,
           id_mess85, id_mess86, id_mess87, id_mess88, id_mess89,
           id_mess90, id_mess91, id_mess92, id_mess93, id_mess94,
           id_mess95, id_mess96, id_mess97, id_mess98, id_mess99,
           id_mess100, id_mess101, id_mess102, id_mess103, id_mess104,
           id_mess105, id_mess106, id_mess107, id_mess108, id_mess109,
           id_mess110, id_mess111, id_mess112, id_mess113, id_mess114,
           id_mess115, id_mess116, id_mess117, id_mess118, id_mess119,
           id_mess120, id_mess121, id_mess122, id_mess123, id_mess124,
           id_mess125, id_mess126, id_mess127, id_mess128, id_mess129,
           id_mess130, id_mess131, id_mess132, id_mess133, id_mess134,
           id_mess135, id_mess136, id_mess137, id_mess138, id_mess139,
           id_mess140, id_mess141, id_mess142, id_mess143, id_mess144,
           id_mess145, id_mess146, id_mess147, id_mess148, id_mess149,
           id_mess150, id_mess151, id_mess152, id_mess153, id_mess154,
           id_mess155, id_mess156, id_mess157, id_mess158, id_mess159,
           id_mess160, id_mess161, id_mess162, id_mess163, id_mess164,
           id_mess165, id_mess166, id_mess167, id_mess168, id_mess169,
           id_mess170, id_mess171, id_mess172, id_mess173, id_mess174);

  MaxMakMsgIndex = 48;
  MyMakMsg : Array [0..MaxMakMsgIndex] of String =
          (id_makmsg00, id_makmsg01, id_makmsg02, id_makmsg03, id_makmsg04,
           id_makmsg05, id_makmsg06, id_makmsg07, id_makmsg08, id_makmsg09,
           id_makmsg10, id_makmsg11, id_makmsg12, id_makmsg13, id_makmsg14,
           id_makmsg15, id_makmsg16, id_makmsg17, id_makmsg18, id_makmsg19,
           id_makmsg20, id_makmsg21, id_makmsg22, id_makmsg23, id_makmsg24,
           id_makmsg25, id_makmsg26, id_makmsg27, id_makmsg28, id_makmsg29,
           id_makmsg30, id_makmsg31, id_makmsg32, id_makmsg33, id_makmsg34,
           id_makmsg35, id_makmsg36, id_makmsg37, id_makmsg38, id_makmsg39,
           id_makmsg40, id_makmsg41, id_makmsg42, id_makmsg43, id_makmsg44,
           id_makmsg45, id_makmsg46, id_makmsg47, id_makmsg48);

  MaxFileMsgIndex = 39;
  MyFileMsg : Array [0..MaxFileMsgIndex] of String =
          (id_filemsg00, id_filemsg01, id_filemsg02, id_filemsg03, id_filemsg04,
           id_filemsg05, id_filemsg06, id_filemsg07, id_filemsg08, id_filemsg09,
           id_filemsg10, id_filemsg11, id_filemsg12, id_filemsg13, id_filemsg14,
           id_filemsg15, id_filemsg16, id_filemsg17, id_filemsg18, id_filemsg19,
           id_filemsg20, id_filemsg21, id_filemsg22, id_filemsg23, id_filemsg24,
           id_filemsg25, id_filemsg26, id_filemsg27, id_filemsg28, id_filemsg29,
           id_filemsg30, id_filemsg31, id_filemsg32, id_filemsg33, id_filemsg34,
           id_filemsg35, id_filemsg36, id_filemsg37, id_filemsg38, id_filemsg39);

  MaxOptMsgIndex = 13;
  MyOptMsg : Array [0..MaxOptMsgIndex] of String =
          (id_optmsg00, id_optmsg01, id_optmsg02, id_optmsg03, id_optmsg04,
           id_optmsg05, id_optmsg06, id_optmsg07, id_optmsg08, id_optmsg09,
           id_optmsg10, id_optmsg11, id_optmsg12, id_optmsg13);

  MaxStartMsgIndex = 32;
  MyStartMsg : Array [0..MaxStartMsgIndex] of String =
          (id_startmsg00, id_startmsg01, id_startmsg02, id_startmsg03, id_startmsg04,
           id_startmsg05, id_startmsg06, id_startmsg07, id_startmsg08, id_startmsg09,
           id_startmsg10, id_startmsg11, id_startmsg12, id_startmsg13, id_startmsg14,
           id_startmsg15, id_startmsg16, id_startmsg17, id_startmsg18, id_startmsg19,
           id_startmsg20, id_startmsg21, id_startmsg22, id_startmsg23, id_startmsg24,
           id_startmsg25, id_startmsg26, id_startmsg27, id_startmsg28, id_startmsg29,
           id_startmsg30, id_startmsg31, id_startmsg32);

  MaxObjTxtIndex = 119;
  MyObjTxt : Array [0..MaxObjTxtIndex] of String =
          (id_objtxt00, id_objtxt01, id_objtxt02, id_objtxt03, id_objtxt04,
           id_objtxt05, id_objtxt06, id_objtxt07, id_objtxt08, id_objtxt09,
           id_objtxt10, id_objtxt11, id_objtxt12, id_objtxt13, id_objtxt14,
           id_objtxt15, id_objtxt16, id_objtxt17, id_objtxt18, id_objtxt19,
           id_objtxt20, id_objtxt21, id_objtxt22, id_objtxt23, id_objtxt24,
           id_objtxt25, id_objtxt26, id_objtxt27, id_objtxt28, id_objtxt29,
           id_objtxt30, id_objtxt31, id_objtxt32, id_objtxt33, id_objtxt34,
           id_objtxt35, id_objtxt36, id_objtxt37, id_objtxt38, id_objtxt39,
           id_objtxt40, id_objtxt41, id_objtxt42, id_objtxt43, id_objtxt44,
           id_objtxt45, id_objtxt46, id_objtxt47, id_objtxt48, id_objtxt49,
           id_objtxt50, id_objtxt51, id_objtxt52, id_objtxt53, id_objtxt54,
           id_objtxt55, id_objtxt56, id_objtxt57, id_objtxt58, id_objtxt59,
           id_objtxt60, id_objtxt61, id_objtxt62, id_objtxt63, id_objtxt64,
           id_objtxt65, id_objtxt66, id_objtxt67, id_objtxt68, id_objtxt69,
           id_objtxt70, id_objtxt71, id_objtxt72, id_objtxt73, id_objtxt74,
           id_objtxt75, id_objtxt76, id_objtxt77, id_objtxt78, id_objtxt79,
           id_objtxt80, id_objtxt81, id_objtxt82, id_objtxt83, id_objtxt84,
           id_objtxt85, id_objtxt86, id_objtxt87, id_objtxt88, id_objtxt89,
           id_objtxt90, id_objtxt91, id_objtxt92, id_objtxt93, id_objtxt94,
           id_objtxt95, id_objtxt96, id_objtxt97, id_objtxt98, id_objtxt99,
           id_objtxt100, id_objtxt101, id_objtxt102, id_objtxt103, id_objtxt104,
           id_objtxt105, id_objtxt106, id_objtxt107, id_objtxt108, id_objtxt109,
           id_objtxt110, id_objtxt111, id_objtxt112, id_objtxt113, id_objtxt114,
           id_objtxt115, id_objtxt116, id_objtxt117, id_objtxt118, id_objtxt119);


  MaxHintIndex = 119;
  MyHint : Array [0..MaxHintIndex] of String =
          (id_hint00, id_hint01, id_hint02, id_hint03, id_hint04,
           id_hint05, id_hint06, id_hint07, id_hint08, id_hint09,
           id_hint10, id_hint11, id_hint12, id_hint13, id_hint14,
           id_hint15, id_hint16, id_hint17, id_hint18, id_hint19,
           id_hint20, id_hint21, id_hint22, id_hint23, id_hint24,
           id_hint25, id_hint26, id_hint27, id_hint28, id_hint29,
           id_hint30, id_hint31, id_hint32, id_hint33, id_hint34,
           id_hint35, id_hint36, id_hint37, id_hint38, id_hint39,
           id_hint40, id_hint41, id_hint42, id_hint43, id_hint44,
           id_hint45, id_hint46, id_hint47, id_hint48, id_hint49,
           id_hint50, id_hint51, id_hint52, id_hint53, id_hint54,
           id_hint55, id_hint56, id_hint57, id_hint58, id_hint59,
           id_hint60, id_hint61, id_hint62, id_hint63, id_hint64,
           id_hint65, id_hint66, id_hint67, id_hint68, id_hint69,
           id_hint70, id_hint71, id_hint72, id_hint73, id_hint74,
           id_hint75, id_hint76, id_hint77, id_hint78, id_hint79,
           id_hint80, id_hint81, id_hint82, id_hint83, id_hint84,
           id_hint85, id_hint86, id_hint87, id_hint88, id_hint89,
           id_hint90, id_hint91, id_hint92, id_hint93, id_hint94,
           id_hint95, id_hint96, id_hint97, id_hint98, id_hint99,
           id_hint100, id_hint101, id_hint102, id_hint103, id_hint104,
           id_hint105, id_hint106, id_hint107, id_hint108, id_hint109,
           id_hint110, id_hint111, id_hint112, id_hint113, id_hint114,
           id_hint115, id_hint116, id_hint117, id_hint118, id_hint119);


function  TypeOfLicenceString (    nr       : Integer    ): String;
function  LicenceIsRunning                                : Boolean;
procedure GetFileVersion      (    filepath : String;
                               var MajorVN,
                                   MinorVN,
                                   DebugVN,
                                   BuildVN  : Integer    );
function FullVersionString    (    filepath : String     ): String;
function EuklidVersionString                              : String;
function IsEarlierVersionThan (    vs1, vs2 : String     ): Boolean;

function Get_EUKLID_VCR_Text  : String;   { VersionCopyRight-Text }
function TermInputIndex       : Integer;

procedure SpyOut(msgStr: String; const Args: array of const);


implementation

Uses Menus, Registry, MathLib, DebugLog, Utility;

var DGXVersionRegistered,   { Version der registrierten OCX-Viewer-Datei }
    DGXVersionInSubDir  : Integer;  { Version der neuen XCO-Viewer-Datei }

function TypeOfLicenceString(nr : Integer) : String;
  { Die zurückgegebenen Strings sollen absichtlich *nicht* internationa-
                  lisiert werden !
    2011-11-22 :  Nach der Umstellung der englischen auf deutsche Lizenz-
                  daten *müssen* jetzt die folgenden Strings (soweit nötig)
                  internationalisiert werden.                           }

  function pt(s: String): String;  // "p"erhaps "t"ranslate() !!!
    begin
    if EuklidLanguage = 'DEU' then
      Result := s
    else begin
      if s = 'Einzellizenz' then
        Result := 'Single User Licence'
      else
      if s = 'Erweiterte Schullizenz' then
        Result := 'Extended School Licence'
      else
      if s = 'Einzel-Testlizenz' then
        Result := 'Single User Test Licence'
      else
        Result := s;
      end;
    end;

  begin
  Case nr of
  { Einzel-Lizenzen : }
    1,                                          { normale Bestellung }
   26     : Result := pt('Einzellizenz');       { Update-CD          }

  { Schul-Lizenzen :}
    2,                                          { normale Bestellung }
   14,                                          { Upgrade von E      }
   27,                                          { Update-CD          }
   30     : Result := 'Schullizenz';            { Sonderlizenz       }

  { Erweiterte Schullizenzen : }
    3,                                          { normale Bestellung }
   13, 15,                                      { Upgrade von S, E   }
   16, 23, 24, 25,                              { Sonderlizenzen     }
   28,                                          { Update-CD          }
   29, 31 : Result := pt('Erweiterte Schullizenz'); { Sonderlizenzen }

  { Sonderlizenzen : }
    7     : Result := 'Firmenlizenz';           { Firmenlizenz       }

  { Test-Lizenzen, eventuell temporär }
    4     : Result := pt('Einzel-Testlizenz');
    5     : Result := 'Schul-Testlizenz';
    6     : Result := 'Erweiterte Schul-Testlizenz';

  { Fremdsprachige Lizenzen }
    9     : Result := '[Danish Extended School License]';
   10, 18 : Result := 'Single User License';
   12, 19 : Result := 'Extended School License';
   17     : Result := 'Extended School Test License';
   20     : Result := 'licence-un seul utilisateur';
   21     : Result := 'licence-école par extension';
   22     : Result := 'Single User Test License';
  else
    Result := '';
  end; { of case }
  end;

function LicenceIsRunning: Boolean;
  { Prüft, ob eine gültige (deutsche?) Lizenz vorliegt.
    2011-11-24 : Wegen Fehlermeldung von Achim Bohn wurde in der Zeile [*]
                 der ursprünglich verwendete "StrToDate('01.01.1994')"-
    Aufruf durch das betriebssicherere "EncodeDate(1994, 1, 1)" ersetzt.  }
  begin
  Case RegLicType of
     1.. 3 : Result := True;
     4.. 6 : If RegLicEnd > EncodeDate(1994, 1, 1) then   {      [*]      }
               Result := Now <= RegLicEnd + 1
             else
               Result := True;
     7,
    13..16,
    23..40 : Result := True;
  else
    Result := False;
  end; { of case }
  end;


{======================================================}

procedure GetFileVersion(    filepath         : string;
                         var MajorVN, MinorVN,
                             DebugVN, BuildVN : Integer);
  var Info     : Pointer;
      InfoSize : DWord;
      FileInfo : PVSFixedFileInfo;
      FileInfoSize,
      Tmp      : DWord;
  begin
  MajorVN := -1;
  InfoSize := GetFileVersionInfoSize(PChar(filepath), Tmp);
  If InfoSize > 0 then begin
    GetMem(Info, InfoSize);
    try
      GetFileVersionInfo(PChar(filepath), 0, InfoSize, Info);
      VerQueryValue(Info, '\', Pointer(FileInfo), FileInfoSize);
      MajorVN := FileInfo.dwFileVersionMS shr 16;
      MinorVN := FileInfo.dwFileVersionMS and $FFFF;
      DebugVN := FileInfo.dwFileVersionLS shr 16;
      BuildVN := FileInfo.dwFileVersionLS and $FFFF;
    finally
      FreeMem(Info, InfoSize);
    end; { of try }
    end;
  end;

function FullVersionString(filepath: String): String;
  var mav,             { mayor version }
      miv,             { minor version }
      dev,             { debug version }
      buv : Integer;   { build version }
  begin
  GetFileVersion(filepath, mav, miv, dev, buv);
  If mav > 0 then
    Result := IntToStr(mav) + '.' +
              IntToStr(miv) + '.' +
              IntToStr(dev) + '.' +
              IntToStr(buv)
  else
    Result := '1.0.0.0';
  end;

function FullVersionNum(filepath: String): Integer;
  var mav,             { mayor version }
      miv,             { minor version }
      dev,             { debug version }
      buv : Integer;   { build version }
  begin
  GetFileVersion(filepath, mav, miv, dev, buv);
  If mav > 0 then
    Result := ((mav*10 + miv)*10 + dev)*1000 + buv
  else
    Result := -1;
  end;


function IsEarlierVersionThan(vs1, vs2: String): Boolean;
  { Erwartet 2 Versions-Strings im Format "mav.miv.dev.buv", wobei mav,
    miv, dev, buv nicht-negative Integer-Zahlen sind, die durch Punkte
    voneinander getrennt sind. Es wird genau dann TRUE zurückgegeben,
    wenn der erste String eine frühere Version bezeichnet als der zweite.
    Enthalten die Versions-Strings nicht alle Stellen einer kompletten
    Versionsnummer, dann werden die fehlenden Stellen mit Nullen auf-
    gefüllt. Ist hingegen einer der beiden übergebenen Strings total
    leer, dann wird FALSE zuückgegeben, weil in diesem Fall der Ver-
    gleich überhaupt nicht durchgeführt werden kann.                   }

  type VArray = Array[1..4] of Integer;

  procedure GetData(vs: String; var v : VArray);
    var n, i : Integer;
    begin
    For i := 1 to 4 do v[i] := 0;
    n := Pos('.', vs);
    i := 1;
    While n > 0 do begin
      v[i] := StrToInt(Copy(vs, 1, n - 1));
      Delete(vs, 1, n);
      n := Pos('.', vs);
      i := i + 1;
      end;
    If Length(vs) > 0 then
      v[i] := StrToInt(vs);
    end;

  var v1, v2 : VArray;
      i      : Integer;
  begin
  if (Length(vs1) = 0) or (Length(vs2) = 0) then
    Result := false
  else begin
    GetData(vs1, v1);
    GetData(vs2, v2);
    i := 1;
    While (i <= 4) and (v1[i] = v2[i]) do
      i := i + 1;   // Übereinstimmende Stellen überspringen
    if i <= 4 then
      Result := v1[i] < v2[i]
    else
      Result := false;
    end;
  end;

function EuklidVersionString: String;
  var mav,             { mayor version }
      miv,             { minor version }
      dev,             { debug version }
      buv : Integer;   { build version }
  begin
  GetFileVersion(Application.ExeName, mav, miv, dev, buv);
  If mav > 0 then begin
    Result := IntToStr(mav) + '.' +
              IntToStr(miv);
    If dev > 0 then
      Result := Result + Chr(Ord('a') + Pred(dev));
    end
  else
    Result := '2.3';
  end;

function Get_EUKLID_VCR_Text: String;
  begin
  If (EuklidLanguage = 'DEU') then
    Result := 'Version '
  else
    Result := 'vers. ';
  Result := Result + EuklidVersionString + EuklidCRText;
  end;

function TermInputIndex : Integer;
  var i : Integer;
  begin
  i := 0;
  Result := -1;
  While (Result < 0) and (i <= MaxModeListIndex) do
    If InitModeList[i, 0] = cmd_TermInput then
      Result := i
    else
      Inc(i);
  end;


{============= Internes =================}


procedure AdjustPlatformDependentConstants;
  { Wenn das Betriebssystem NT oder Win2000 oder noch was moderneres ist,
    und man davon ausgehen kann, daß zumindest der NT-Standard erfüllt
    wird, dann wird das GDI mit 32-Bit-Koordinaten angesprochen.
    Unter Win95/98 muß man sich auf 16-Bit-Koordinaten beschränken !!! }
  begin
  OSisNT := Win32Platform >= VER_PLATFORM_WIN32_NT;
  If OSisNT then begin
    GDIMaxInt := Integer(1) SHL 26 - 1;
    GDIMaxRadius := GDIMaxInt Div 5000;
    end
  else begin
    GDIMaxInt := Integer(1) SHL 15 - 1;
    GDIMaxRadius := GDIMaxInt Div 50;
    end;
  end;


function ReadDGXPathFromRegistry: String;
  var reg : TRegistry;
  begin
  Result := '';
  reg := TRegistry.Create(KEY_READ);
  try
    reg.RootKey := HKEY_CLASSES_ROOT;
    If reg.OpenKeyReadOnly
         ('CLSID\{2EF98DE5-183F-11D4-83EC-EC6A1DB6E213}\InprocServer32') then
      begin
      Result := reg.ReadString('');
      reg.CloseKey;
      end
  finally
    reg.Free;
  end; { of try }
  end;

procedure Check4OldDynaGeoX;
  { setzt DGXPathRegistered und DGXPathInSubDir  }
  begin
  DGXPathRegistered := ReadDGXPathFromRegistry;
  If (Length(DGXPathRegistered) > 0) and
     FileExists(DGXPathRegistered) then
    DGXVersionRegistered := FullVersionNum(DGXPathRegistered)
  else begin
    DGXPathRegistered := '';
    DGXVersionRegistered := -1;
    end;

  DGXPathInSubDir := ExtractFileDir(Application.Exename) +
                     '\Viewer\DynaGeoXi.ocx';
  If FileExists(DGXPathInSubDir) then
    DGXVersionInSubdir := FullVersionNum(DGXPathInSubDir)
  else begin
    DGXPathInSubDir := '';
    DGXVersionInSubDir := -1;
    end;
  end;


procedure AdjustEnvironmentDependentValues;
  { unterscheidet zwischen der Verwendung dieser Bibliothek
    im normalen DynaGeo-Programm und im DynaGeoX-Viewer     }
  begin
  If Pos('IE', UpperCase(Application.ExeName)) > 0 then begin  // Ist's der IE ?
    { Nix zu tun ! }
    end
  else begin
    Check4OldDynaGeoX;
    end;
  end;


procedure InitTables;
  var wc : WideChar;
      i  : Integer;
  begin
  For i := 1 to 4 do
    SymList := SymList + SymTab[i];
  For i := 1 to Length(SymList) do begin
    wc := GetWideCharFromSymbolChar(SymList[i]);
    If (Ord(wc) > 255) and (Pos(wc, WSymList) = 0) then
      WSymList := WSymList + wc;
    end;
  end;

{=============================================================}

procedure SpyOut(msgStr: String; const Args: array of const);
  begin
  DebugOut(msgStr, Args);
  end;

{=============================================================}

initialization

  Randomize;                               { Zufallsgenerator initialisieren }
  GlobalDefaultFont := TFont.Create;
  AdjustPlatformDependentConstants;
  AdjustEnvironmentDependentValues;
  InitTables;

finalization

  GlobalDefaultFont.Free;

end.
