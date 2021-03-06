unit Tables;

interface

(*
//--------------------------------------------------------------------------
// Konstanten f?r die Algorithmen
//--------------------------------------------------------------------------
//
//  Ab table[2, 163] steht der verschl?sselte Modul n (172 Byte) :
//
//  n = #$EC#$31#$5B#$1B#$55#$3B#$B3#$46#$81#$6B#$4A#$5E#$BB#$DB#$D2#$E4 +
//      #$60#$5B#$EE#$AA#$85#$E0#$05#$F4#$B9#$3F#$DE#$1F#$B5#$87#$22#$F1 +
//      #$2D#$A9#$4F#$E5#$9F#$55#$9F#$5D#$20#$94#$01#$87#$27#$E8#$C2#$0A +
//      #$63#$4A#$6A#$B7#$9E#$47#$36#$49#$B9#$2E#$85#$E0#$A5#$33#$8C#$AC +
//      #$D6#$A0#$90#$B3#$93#$43#$85#$DD#$8A#$BD#$57#$E4#$51#$F6#$82#$1D +
//      #$DB#$BE#$4D#$B9#$52#$21#$7F#$67#$7A#$CB#$1A#$3A#$75#$57#$CA#$64 +
//      #$54#$9E#$5E#$56#$E5#$29#$14#$EA#$DB#$65#$E6#$30#$CE#$2D#$B3#$BC +
//      #$32#$DF#$48#$05#$06#$CE#$EE#$6C#$7C#$F4#$D5#$E2#$BF#$30#$BC#$CC +
//      #$DF#$19#$DC#$A4#$3A#$45#$68#$0D#$07#$AD#$01#$D9#$0F#$73#$E6#$4E +
//      #$2B#$93#$25#$72#$62#$DB#$A1#$05#$45#$96#$75#$E6#$C2#$E2#$54#$0F +
//      #$C1#$BD#$68#$DC#$A3#$F6#$53#$97#$C1#$A8#$77#$FA;
//
//  Ab table[3, 162] steht der verschl?sselte Exponent e ( 17 Byte) :
//
//  e = #$B6#$58#$53#$1A#$FF#$43#$CF#$C1#$0E#$1A#$37#$4C#$82#$CD#$DA#$9A +
//      #$EA;
//
//  Dezimale Eintr?ge in table werden von Moosbauer's Krypto-Algorithmus
//  benutzt, Hex-Eintr?ge sind Verwirrdaten bis auf die oben angegebenen
//  Bereiche f?r n und e.                                                *)

const table: array[0..4] of array[0..511] of byte =
      ((102,177,186,162,  2,156,112, 75, 55, 25,  8, 12,251,193,246,188,
        109,213,151, 53, 42, 79,191,115,233,242,164,223,209,148,108,161,
        252, 37,244, 47, 64,211,  6,237,185,160,139,113, 76,138, 59, 70,
         67, 26, 13,157, 63,179,221, 30,214, 36,166, 69,152,124,207,116,
        247,194, 41, 84, 71,  1, 49, 14, 95, 35,169, 21, 96, 78,215,225,
        182,243, 28, 92,201,118,  4, 74,248,128, 17, 11,146,132,245, 48,
        149, 90,120, 39, 87,230,106,232,175, 19,126,190,202,141,137,176,
        250, 27,101, 40,219,227, 58, 20, 51,178, 98,216,140, 22, 32,121,
         61,103,203, 72, 29,110, 85,212,180,204,150,183, 15, 66,172,196,
         56,197,158,  0,100, 45,153,  7,144,222,163,167, 60,135,210,231,
        174,165, 38,249,224, 34,220,229,217,208,241, 68,206,189,125,255,
        239, 54,168, 89,123,122, 73,145,117,234,143, 99,129,200,192, 82,
        104,170,136,235, 93, 81,205,173,236, 94,105, 52, 46,228,198,  5,
         57,254, 97,155,142,133,199,171,187, 50, 65,181,127,107,147,226,
        184,218,131, 33, 77, 86, 31, 44, 88, 62,238, 18, 24, 43,154, 23,
         80,159,134,111,  9,114,  3, 91, 16,130, 83, 10,195,240,253,119,
        177,102,162,186,156,  2, 75,112, 25, 55, 12,  8,193,251,188,246,
        213,109, 53,151, 79, 42,115,191,242,233,223,164,148,209,161,108,
         37,252, 47,244,211, 64,237,  6,160,185,113,139,138, 76, 70, 59,
         26, 67,157, 13,179, 63, 30,221, 36,214, 69,166,124,152,116,207,
        194,247, 84, 41,  1, 71, 14, 49, 35, 95, 21,169, 78, 96,225,215,
        243,182, 92, 28,118,201, 74,  4,128,248, 11, 17,132,146, 48,245,
         90,149, 39,120,230, 87,232,106, 19,175,190,126,141,202,176,137,
         27,250, 40,101,227,219, 20, 58,178, 51,216, 98, 22,140,121, 32,
        103, 61, 72,203,110, 29,212, 85,204,180,183,150, 66, 15,196,172,
        197, 56,  0,158, 45,100,  7,153,222,144,167,163,135, 60,231,210,
        165,174,249, 38, 34,224,229,220,208,217, 68,241,189,206,255,125,
         54,239, 89,168,122,123,145, 73,234,117, 99,143,200,129, 82,192,
        170,104,235,136, 81, 93,173,205, 94,236, 52,105,228, 46,  5,198,
        254, 57,155, 97,133,142,171,199, 50,187,181, 65,107,127,226,147,
        218,184, 33,131, 86, 77, 44, 31, 62, 88, 18,238, 43, 24, 23,154,
        159, 80,111,134,114,  9, 91,  3,130, 16, 10, 83,240,195,119,253),

// table_1 :
        (19, 11, 80,114, 43,  1, 69, 94, 39, 18,127,117, 97,  3, 85, 43,
         27,124, 70, 83, 47, 71, 63, 10, 47, 89, 79,  4, 14, 59, 11,  5,
         35,107,103, 68, 21, 86, 36, 91, 85,126, 32, 50,109, 94,120,  6,
         53, 79, 28, 45, 99, 95, 41, 34, 88, 68, 93, 55,110,125,105, 20,
         90, 80, 76, 96, 23, 60, 89, 64,121, 56, 14, 74,101,  8, 19, 78,
         76, 66,104, 46,111, 50, 32,  3, 39,  0, 58, 25, 92, 22, 18, 51,
         57, 65,119,116, 22,109,  7, 86, 59, 93, 62,110, 78, 99, 77, 67,
         12,113, 87, 98,102,  5, 88, 33, 38, 56, 23,  8, 75, 45, 13, 75,
         95, 63, 28, 49,123,120, 20,112, 44, 30, 15, 98,106,  2,103, 29,
         82,107, 42,124, 24, 30, 41, 16,108,100,117, 40, 73, 40,  7,114,
         82,115, 36,112, 12,102,100, 84, 92, 48, 72, 97,  9, 54, 55, 74,
        113,123, 17, 26, 53, 58,  4,  9, 69,122, 21,118, 42, 60, 27, 73,
        118,125, 34, 15, 65,115, 84, 64, 62, 81, 70,  1, 24,111,121, 83,
        104, 81, 49,127, 48,105, 31, 10,  6, 91, 87, 37, 16, 54,116,126,
         31, 38, 13,  0, 72,106, 77, 61, 26, 67, 46, 29, 96, 37, 61, 52,
        101, 17, 44,108, 71, 52, 66, 57, 33, 51, 25, 90,  2,119,122, 35,
        $11,$A2,$C4,$09,$BB,$E7,$5C,$73,$DB,$A4,$1A,$32,$8A,$8E,$72,$EE,
        $B7,$7A,$8B,$E6,$74,$D4,$A7,$52,$5A,$50,$BB,$B0,$C4,$4B,$BB,$62,
        $25,$44,$E8,$AF,$C4,$7C,$4E,$8E,$14,$0C,$68,$23,$82,$50,$F5,$C2,
        $2D,$0B,$1A,$F6,$28,$62,$8C,$24,$C0,$CE,$07,$DD,$40,$B7,$67,$CF,
        $66,$F8,$C0,$08,$2F,$D8,$00,$5E,$E0,$21,$E1,$C2,$9D,$00,$1C,$F5,
        $76,$FC,$67,$54,$21,$B6,$91,$F7,$4F,$4E,$6D,$3D,$10,$06,$3B,$8E,
        $C1,$74,$33,$71,$21,$8E,$F4,$60,$62,$93,$12,$B5,$CF,$A3,$4F,$2B,
        $20,$62,$90,$6E,$E9,$33,$FB,$5A,$9B,$E9,$88,$A7,$E0,$2D,$7C,$AA,
        $3C,$BE,$6C,$CC,$0E,$EF,$EC,$6E,$8A,$82,$16,$07,$2B,$E6,$AA,$E9,
        $D1,$F8,$79,$4F,$7E,$00,$22,$E7,$59,$A7,$F6,$35,$05,$02,$11,$3C,
        $7F,$E7,$55,$39,$68,$72,$A5,$D6,$54,$AF,$61,$42,$05,$D3,$F7,$A9,
        $F4,$27,$79,$53,$04,$7A,$B6,$31,$F6,$04,$AF,$59,$B1,$B2,$B3,$C2,
        $F1,$35,$50,$8A,$C5,$6B,$D6,$B0,$F3,$53,$E8,$BE,$84,$6E,$93,$CF,
        $A9,$A7,$2C,$6D,$61,$92,$57,$91,$9E,$FB,$40,$DD,$BE,$69,$AE,$83,
        $FE,$08,$7B,$53,$21,$6F,$4D,$19,$20,$93,$F2,$65,$C9,$5B,$8D,$98,
        $7A,$D4,$48,$EE,$D4,$63,$02,$63,$3C,$D5,$3D,$C3,$1B,$83,$AC,$D9),

// table_2 :
        (52, 50, 44,  6, 21, 49, 41, 59, 39, 51, 25, 32, 51, 47, 52, 43,
         37,  4, 40, 34, 61, 12, 28,  4, 58, 23,  8, 15, 12, 22,  9, 18,
         55, 10, 33, 35, 50,  1, 43,  3, 57, 13, 62, 14,  7, 42, 44, 59,
         62, 57, 27,  6,  8, 31, 26, 54, 41, 22, 45, 20, 39,  3, 16, 56,
         48,  2, 21, 28, 36, 42, 60, 33, 34, 18,  0, 11, 24, 10, 17, 61,
         29, 14, 45, 26, 55, 46, 11, 17, 54, 46,  9, 24, 30, 60, 32,  0,
         20, 38,  2, 30, 58, 35,  1, 16, 56, 40, 23, 48, 13, 19, 19, 27,
         31, 53, 47, 38, 63, 15, 49,  5, 37, 53, 25, 36, 63, 29,  5,  7,

        $D0,$E7,$F5,$6B,$29,$4C,$A9,$69,$83,$58,$AE,$F2,$2E,$7C,$1E,$98,
        $93,$95,$1F,$2F,$56,$58,$EA,$0F,$3E,$D2,$ED,$60,$05,$86,$67,$78,
        $D8,$2F,$D4,$EC,$31,$5B,$1B,$55,$3B,$B3,$46,$81,$6B,$4A,$5E,$BB,
        $DB,$D2,$E4,$60,$5B,$EE,$AA,$85,$E0,$05,$F4,$B9,$3F,$DE,$1F,$B5,
        $87,$22,$F1,$2D,$A9,$4F,$E5,$9F,$55,$9F,$5D,$20,$94,$01,$87,$27,
        $E8,$C2,$0A,$63,$4A,$6A,$B7,$9E,$47,$36,$49,$B9,$2E,$85,$E0,$A5,
        $33,$8C,$AC,$D6,$A0,$90,$B3,$93,$43,$85,$DD,$8A,$BD,$57,$E4,$51,
        $F6,$82,$1D,$DB,$BE,$4D,$B9,$52,$21,$7F,$67,$7A,$CB,$1A,$3A,$75,

        $57,$CA,$64,$54,$9E,$5E,$56,$E5,$29,$14,$EA,$DB,$65,$E6,$30,$CE,
        $2D,$B3,$BC,$32,$DF,$48,$05,$06,$CE,$EE,$6C,$7C,$F4,$D5,$E2,$BF,
        $30,$BC,$CC,$DF,$19,$DC,$A4,$3A,$45,$68,$0D,$07,$AD,$01,$D9,$0F,
        $73,$E6,$4E,$2B,$93,$25,$72,$62,$DB,$A1,$05,$45,$96,$75,$E6,$C2,
        $E2,$54,$0F,$C1,$BD,$68,$DC,$A3,$F6,$53,$97,$C1,$A8,$77,$FA,$11,
        $C2,$B9,$39,$C6,$71,$6B,$3B,$28,$A1,$26,$AF,$FB,$CD,$E1,$C3,$29,
        $4B,$3D,$7A,$51,$64,$55,$BE,$B5,$1E,$C9,$C8,$1E,$DC,$1E,$18,$15,
        $75,$FB,$AB,$ED,$8C,$F2,$49,$AA,$AF,$65,$72,$A8,$69,$62,$4A,$E7,

        $F1,$BA,$C7,$11,$53,$FD,$92,$B2,$41,$62,$6B,$4B,$78,$13,$05,$8A,
        $49,$B1,$A1,$06,$F0,$9D,$B1,$C8,$90,$D4,$36,$20,$38,$C7,$01,$05,
        $91,$A3,$34,$02,$FA,$54,$EF,$BF,$65,$39,$FF,$B4,$7F,$14,$83,$43,
        $FB,$CB,$EE,$F6,$F1,$FD,$9D,$AC,$55,$F7,$C7,$99,$40,$6A,$41,$4F,
        $75,$1E,$44,$89,$36,$E2,$BD,$3F,$EA,$F9,$F4,$73,$1E,$BB,$7F,$8F,
        $42,$99,$24,$DB,$BE,$4B,$66,$63,$C6,$ED,$D4,$A9,$91,$04,$B2,$37,
        $84,$01,$33,$AA,$41,$84,$9E,$CB,$70,$58,$C9,$E3,$7F,$95,$5D,$F7,
        $EC,$5E,$86,$D8,$D2,$97,$11,$E5,$6A,$8D,$06,$9D,$4E,$98,$90,$24),

// table_3 :
        ( 1,  5, 29,  6, 25,  1, 18, 23, 17, 19,  0,  9, 24, 25,  6, 31,
         28, 20, 24, 30,  4, 27,  3, 13, 15, 16, 14, 18,  4,  3,  8,  9,
         20,  0, 12, 26, 21,  8, 28,  2, 29,  2, 15,  7, 11, 22, 14, 10,
         17, 21, 12, 30, 26, 27, 16, 31, 11,  7, 13, 23, 10,  5, 22, 19,
        $FF,$29,$01,$9F,$F6,$50,$CA,$2A,$40,$DA,$40,$22,$07,$BB,$15,$2C,
        $0E,$76,$7A,$E6,$A3,$52,$09,$F6,$B5,$9D,$08,$70,$10,$23,$1F,$2C,
        $30,$F2,$4D,$55,$56,$58,$4F,$6F,$3C,$21,$14,$4E,$72,$A8,$61,$C6,
        $94,$B2,$AD,$BD,$3F,$1C,$94,$2D,$A8,$93,$B0,$4F,$A1,$A5,$89,$75,

        $A1,$AC,$2B,$78,$4C,$0C,$6C,$45,$3C,$2E,$75,$FF,$B3,$6D,$C2,$D1,
        $55,$00,$0B,$FC,$ED,$02,$1C,$37,$A4,$85,$85,$65,$5B,$45,$AF,$B1,
        $02,$FA,$B6,$58,$53,$1A,$FF,$43,$CF,$C1,$0E,$1A,$37,$4C,$82,$CD,
        $DA,$9A,$EA,$91,$A3,$34,$54,$EF,$BF,$65,$39,$FF,$B4,$7F,$14,$83,
        $43,$FB,$CB,$EE,$F6,$F1,$FD,$9D,$AC,$55,$F7,$C7,$99,$40,$6A,$41,
        $4F,$75,$1E,$44,$89,$36,$E2,$BD,$3F,$EA,$F9,$F4,$73,$1E,$BB,$7F,
        $8F,$42,$99,$24,$DB,$BE,$4B,$66,$63,$C6,$ED,$D4,$A9,$91,$04,$B2,
        $37,$84,$01,$33,$AA,$41,$84,$9E,$CB,$70,$58,$C9,$E3,$7F,$95,$5D,

          0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
          0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
          0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
          0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
          0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
          0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
          0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
          0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,

          0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
          0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
          0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
          0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
          0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
          0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
          0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
          0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0),

// table_4 :
        (15, 12, 10,  4,  1, 14, 11,  7,  5,  0, 14,  7,  1,  2, 13,  8,
         10,  3,  4,  9,  6,  0,  3,  2,  5,  6,  8,  9, 11, 13, 15, 12,
        $F7,$EC,$5E,$86,$D8,$D2,$97,$11,$E5,$6A,$8D,$06,$9D,$4E,$98,$90,
          0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
          0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
          0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
          0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
          0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,

          0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
          0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
          0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
          0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
          0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
          0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
          0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
          0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,

          0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
          0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
          0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
          0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
          0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
          0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
          0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
          0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,

          0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
          0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
          0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
          0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
          0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
          0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
          0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
          0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0));


implementation

end.
 