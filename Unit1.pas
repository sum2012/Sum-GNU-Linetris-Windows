//   Copyright 2011-2026 by Wu Hon Sum
//   This program is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    any later version.
//
//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with this program.  If not, see <http://www.gnu.org/licenses/>.
//
//  newsgroup:news://my.newsgroup.com.hk/welcome.sum
// forum http://home.i-cable.com/wu/
// movedlist may be wrong need remove later

unit Unit1;

{$MODE Delphi}

interface

uses
  Windows, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Menus,ComCtrls,lclintf,ClipBrd;

const
  inf = 10000;
  TT_EXACT = 0;
  TT_LOWERBOUND = 1;
  TT_UPPERBOUND = 2;
  ROW8_MASK = UInt64($FF00000000000000);

type
  TTranspositionEntry = record
    Hash: UInt64;
    Value: Integer;
    Depth: Integer;
    Flag: Integer;
    BestMove: Integer;
  end;




type
  Tboard = record
    Red: UInt64;
    Black: UInt64;
    Hash: UInt64;
  end;
  TArrayBoard = array[0..9, 0..9] of Integer;
  Tmovelist = array[1..20] of integer;
  TMoveArray = record
    Count: Integer;
    Moves: array[0..63] of Integer;
  end;

  TParallelTask = record
    Move1, Move2, Move1Idx: Integer;
  end;

  TAIThread = class;

  { TForm1 }

  TForm1 = class(TForm)
    apple: TImage;
    Chess2: TImage;
    Chess1: TImage;
    HumanFirstButton: TMenuItem;
    HumanVsHumanButton: TMenuItem;
    ComputerFirstButton: TMenuItem;
    AboutButton: TMenuItem;
    RuleButton: TMenuItem;
    RedChess: TImage;
    BlackChess: TImage;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
    Image10: TImage;
    Image11: TImage;
    Image12: TImage;
    Image13: TImage;
    Image14: TImage;
    Image15: TImage;
    Image16: TImage;
    Image17: TImage;
    Image18: TImage;
    Image19: TImage;
    Image20: TImage;
    Image21: TImage;
    Image22: TImage;
    Image23: TImage;
    Image24: TImage;
    Image25: TImage;
    Image26: TImage;
    Image27: TImage;
    Image28: TImage;
    Image29: TImage;
    Image30: TImage;
    Image31: TImage;
    Image32: TImage;
    Image33: TImage;
    Image34: TImage;
    Image35: TImage;
    Image36: TImage;
    Image37: TImage;
    Image38: TImage;
    Image39: TImage;
    Image40: TImage;
    Image41: TImage;
    Image42: TImage;
    Image43: TImage;
    Image44: TImage;
    Image45: TImage;
    Image46: TImage;
    Image47: TImage;
    Image48: TImage;
    Image49: TImage;
    Image50: TImage;
    Image51: TImage;
    Image52: TImage;
    Image53: TImage;
    Image54: TImage;
    Image55: TImage;
    Image56: TImage;
    Image57: TImage;
    Image58: TImage;
    Image59: TImage;
    Image60: TImage;
    Image61: TImage;
    Image62: TImage;
    Image63: TImage;
    Image64: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    MainMenu1: TMainMenu;
    SaveButton: TMenuItem;
    Closebutton: TMenuItem;
    Restartbutton: TMenuItem;
    LoadButton: TMenuItem;
    Mode1: TMenuItem;
    HumanVsComputer: TMenuItem;
    ComputerVsHuman: TMenuItem;
    HumanvsHuman: TMenuItem;
    BackButton: TMenuItem;
    StepListBox: TListBox;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;


    CopyToClipboardButton: TButton;


    AiListBox: TListBox;
    ThinkstepEdit: TEdit;
    NornalDepth: TEdit;
    Label5: TLabel;
    EndgameDepth: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    ScoreLabel: TLabel;
    AIDisplayScoreLabel: TLabel;
    Redlabel: TLabel;
    BlackLabel: TLabel;
    AIUsedTimeLabel: TLabel;

    Tojavaboardbutton: TMenuItem;
    TTSizeMenuItem: TMenuItem;
    TTLevel1Button: TMenuItem;
    TTLevel2Button: TMenuItem;
    TTLevel3Button: TMenuItem;
    TTLevel4Button: TMenuItem;
    TTLevel5Button: TMenuItem;
    Timer1: TTimer;
    procedure AboutButtonClick(Sender: TObject);
    procedure TTLevelClick(Sender: TObject);
    procedure NornalDepthChange(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ComputerFirstButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var {%H-}CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure HumanFirstButtonClick(Sender: TObject);
    procedure HumanVsHumanButtonClick(Sender: TObject);
    procedure HumanvsHumanClick(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure RuleButtonClick(Sender: TObject);
    procedure RedChessClick(Sender: TObject);
    procedure BlackChessClick(Sender: TObject);
    procedure ClosebuttonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure CopyToClipboardButtonClick(Sender: TObject);
    procedure LoadButtonClick(Sender: TObject);

    procedure ComputerVsHumanClick(Sender: TObject);
    procedure HumanVsComputerClick(Sender: TObject);

    procedure BackButtonClick(Sender: TObject);
    procedure StepListBoxClick(Sender: TObject);
    procedure RunCliTest;
    procedure NewGame(AFirstIsRed: Boolean);

    procedure TojavaboardbuttonClick(Sender: TObject);
  private
    FTTSize: Cardinal;
//      mutistep:Boolean;
//      mutiscore:Integer;
      mutidepth:integer;
      mutitemplist:TMoveArray;
      FParallelTasks: array of TParallelTask;
      mutisteplist:TMoveArray;
      mutiscorelist:TMoveArray;
      mutiscores: array of Integer;
      mutiresults: array of TMoveArray;
      mutiSideisRed:Boolean;
      mutiBoard:Tboard;
      MyCriticalSection: TRTLCriticalSection;
      initboard,board:Tboard;
      FirstIsRed:Boolean;
      NotInBack:Boolean;

//    step:integer;
 //   MoveListA,MoveListB:TMemo;
      RedNoMove:Boolean;
      BlackNoMove:Boolean;
      RealDepth:integer;
      Redlist,Blacklist:TStringList;
      movedlist:TStringList;
      FZobristRed: array[0..63] of UInt64;
      FZobristBlack: array[0..63] of UInt64;
      FZobristSide: UInt64;
      FTranspositionTable: array of TTranspositionEntry;
      procedure InitializeZobrist;
      function CalculateHash(const ABoard: Tboard; SideIsRed: Boolean): UInt64;
      procedure UpdateHash(var AHash: UInt64; PieceIdx: Integer; PieceType: Integer); // PieceType: 1=Red, -1=Black, 0=Remove/Toggle
      procedure StoreTT(Hash: UInt64; Depth, Value, Flag, BestMove: Integer);
      function LookupTT(Hash: UInt64; Depth, Alpha, Beta: Integer; var Value, BestMove: Integer): Boolean;
      procedure GetPVFromTT(ABoard: Tboard; SideIsRed: Boolean; MaxMoreMoves: Integer; var PV: TMoveArray);
      procedure FastMakeRedMove(const ABoard:Tboard; var temp:TMoveArray);
      procedure FastMakeBlackMove(const ABoard:Tboard; var temp:TMoveArray);
      function Muti(const ComputerisRed:Boolean):string;
      procedure DoSomethingParallel(Index: PtrInt);
      procedure MakeRedMove(const ABoard:Tboard;var temp:TStringList);
      procedure MakeBlackMove(const ABoard:Tboard;var temp:TStringList);
 //     function MakeRedMoveAI(const ABoard:Tboard):TStringList;
//      function MakeBlackMoveAI(const ABoard:Tboard):TStringList;
      procedure MakeClick(t:Tstringlist;Player:string);
      procedure Score(const Aboard:Tboard;var RedScore,BlackScore:integer);
      procedure RedBoardUpdate(var Aboard:Tboard;LastChess:Integer);
      procedure BlackBoardUpdate(var Aboard:Tboard;LastChess:Integer);
      procedure Updateboard;
      function AI(Aboard:Tboard;ComputerIsRed:Boolean):string;
      function MinMax(Aboard:Tboard;SideIsRed:Boolean;depth:integer;alpha, beta: integer;var aithinkstep:TMoveArray):integer;
      function MinMaxRandom(Aboard:Tboard;SideIsRed:Boolean;depth:integer;alpha, beta: integer;var aithinkstep:TMoveArray):integer;
      procedure BatchEvaluateOnAVX512(const Boards: array of Tboard; const SideIsRed: Boolean; var Scores: array of Integer);
    function InternalEvaluate(const Aboard:Tboard;const SideIsRed:Boolean):Integer; inline;
    function EvaluateScore(const Aboard:Tboard;const SideIsRed:Boolean):Integer;
      function MinMaxStart(Aboard:Tboard;SideIsRed:Boolean;depth:integer;alpha, beta: integer;var aithinkstep:TMoveArray):integer;
      Procedure Scoresort(var scorelist:Tstringlist;var stepno:Tstringlist);
      procedure FastScoresort(var moves: TMoveArray; var scores: array of Integer);
      function GetMoveHeuristic(move: Integer; {%H-}SideIsRed: Boolean): Integer;
      function ThinkNumber(Aboard:Tboard;SideIsRed:Boolean;depth:integer):integer;
      function BoardtoFen:String;
    procedure HandleAIResult(const MoveName: string);
    procedure UpdateAIUI;
    procedure CallSyncUpdateAIUI(const AScore, ATime, AThinkStep: string; AClear, AAppend: Boolean);
    { Private declarations }
  private
    FAIWasRed: Boolean;
    FMetricsScore, FMetricsTime, FMetricsThinkStep: string;
    FMetricsClear: Boolean;
    FMetricsAppendList: TStringList;
    FAIThread: TAIThread;
    procedure StartAI(AComputerIsRed: Boolean);
    { Public declarations }
  end;

  TAIThread = class(TThread)
  private
    FForm: TForm1;
    FBoard: Tboard;
    FComputerIsRed: Boolean;
    FResultMove: string;
    FStartTime: QWord;
  protected
    procedure Execute; override;
    procedure SyncNotifyDone;
  public
    constructor Create(AForm: TForm1; ABoard: Tboard; AComputerIsRed: Boolean);
  end;

function MoveToThinkStep(move: Integer): string;
function MoveArrayToThinkStep(const moves: TMoveArray): string;




var
  Form1: TForm1;
  {
  PicCompentName: array [1..64] of string =(
  'Image1','Image2','image3','Image4','Image5',
  'Image6','Image7','image8','Image9','Image10',
  'Image11','Image12','image13','Image14','Image15',
  'Image16','Image17','image18','Image19','Image20',
  'Image21','Image22','image23','Image24','Image25',
  'Image26','Image27','image28','Image29','Image30',
  'Image31','Image32','image33','Image34','Image35',
  'Image36','Image37','image38','Image39','Image40',
  'Image41','Image42','image43','Image44','Image45',
  'Image46','Image47','image48','Image49','Image50',
  'Image51','Image52','image53','Image54','Image55',
  'Image56','Image57','image58','Image59','Image60',
  'Image61','Image62','image63','Image64');
  }
 //  board:array[1..8,1..8] of integer = (
 {
    Initboard: Tboard = (
   (0,0,0,0,0,0,0,0),
   (0,0,0,0,0,0,0,0),
   (0,0,0,0,0,0,0,0),
   (0,0,0,-1,1,0,0,0),
   (0,0,0,1,-1,0,0,0),
   (0,0,0,0,0,0,0,0),
   (0,0,0,0,0,0,0,0),
   (0,0,0,0,0,0,0,0));

    board:Tboard = (
   (0,0,0,0,0,0,0,0),
   (0,0,0,0,0,0,0,0),
   (0,0,0,0,0,0,0,0),
   (0,0,0,-1,1,0,0,0),
   (0,0,0,1,-1,0,0,0),
   (0,0,0,0,0,0,0,0),
   (0,0,0,0,0,0,0,0),
   (0,0,0,0,0,0,0,0));
// }
// 1 red ; -1 black ; 0 space
// eat chess-> new board->produce eat step -> eat chess...
    PosMark:TArrayBoard = (
    (0,0,0,0,0,0,0,0,0,0),
      (0,-199,3,-1,-1,-1,-1,3,-199,0),
      (0,3,-1,-1,-1,-1,-1,-1,3,0),
       (0,-1,-1,-1,-1,-1,-1,-1,-1,0),
       (0,-1,-1,-1,-1,-1,-1,-1,-1,0),
       (0,-1,-1,-1,-1,-1,-1,-1,-1,0),
       (0,-1,-1,-1,-1,-1,-1,-1,-1,0),
      (0,3,-1,-1,-1,-1,-1,-1,3,0),
      (0,-199,3,-1,-1,-1,-1,3,-199,0),
    (0,0,0,0,0,0,0,0,0,0)
      );
{
     BlackPosMark:TArrayBoard = (
     (0,0,0,0,0,0,0,0,0,0),
      (0,200,2,-1,-1,-1,-1,2,200,0),
      (0,2,-1,-1,-1,-1,-1,-1,2,0),
       (0,-1,-1,-1,-1,-1,-1,-1,-1,0),
       (0,-1,-1,-1,-1,-1,-1,-1,-1,0),
       (0,-1,-1,-1,-1,-1,-1,-1,-1,0),
       (0,-1,-1,-1,-1,-1,-1,-1,-1,0),
      (0,2,-1,-1,-1,-1,-1,-1,2,0),
      (0,200,2,-1,-1,-1,-1,2,200,0),
    (0,0,0,0,0,0,0,0,0,0)
      );
 }
implementation

{$R *.lfm}

procedure TForm1.InitializeZobrist;
var
  i: Integer;
  function Random64: UInt64;
  begin
    Result := (UInt64(Random($10000)) shl 48) or (UInt64(Random($10000)) shl 32) or
              (UInt64(Random($10000)) shl 16) or UInt64(Random($10000));
  end;
begin
  for i := 0 to 63 do
  begin
    FZobristRed[i] := Random64;
    FZobristBlack[i] := Random64;
  end;
  FZobristSide := Random64;
  FTranspositionTable := nil;
  // Force Windows to reclaim memory from the working set
  SetProcessWorkingSetSize(GetCurrentProcess, PtrUInt(-1), PtrUInt(-1));

  SetLength(FTranspositionTable, FTTSize);
  for i := 0 to FTTSize - 1 do
  begin
    FTranspositionTable[i].Hash := 0;
    FTranspositionTable[i].BestMove := -2;
  end;
end;

procedure TForm1.TTLevelClick(Sender: TObject);
begin
  if FAIThread <> nil then
  begin
    ShowMessage('Cannot change TT size while AI is thinking!');
    Exit;
  end;

  if Sender = TTLevel1Button then FTTSize := 1 shl 24
  else if Sender = TTLevel2Button then FTTSize := 1 shl 25
  else if Sender = TTLevel3Button then FTTSize := 1 shl 26
  else if Sender = TTLevel4Button then FTTSize := 1 shl 27
  else if Sender = TTLevel5Button then FTTSize := 1 shl 28;

  InitializeZobrist;
  CallSyncUpdateAIUI('', '', 'TT Size updated to ' + IntToStr(FTTSize), True, True);
end;

procedure TForm1.UpdateHash(var AHash: UInt64; PieceIdx: Integer; PieceType: Integer);
begin
  if (PieceIdx < 0) or (PieceIdx > 63) then Exit; // Safety check

  if PieceType = 1 then
    AHash := AHash xor FZobristRed[PieceIdx]
  else if PieceType = -1 then
    AHash := AHash xor FZobristBlack[PieceIdx];
end;

function TForm1.CalculateHash(const ABoard: Tboard; SideIsRed: Boolean): UInt64;
var
  i: Integer;
  Red, Black: UInt64;
begin
  Result := 0;
  if SideIsRed then Result := Result xor FZobristSide;
  Red := ABoard.Red;
  Black := ABoard.Black;
  while Red <> 0 do
  begin
    i := BsfQWord(Red);
    Result := Result xor FZobristRed[i];
    Red := Red and not (UInt64(1) shl i);
  end;
  while Black <> 0 do
  begin
    i := BsfQWord(Black);
    Result := Result xor FZobristBlack[i];
    Black := Black and not (UInt64(1) shl i);
  end;
end;

procedure TForm1.StoreTT(Hash: UInt64; Depth, Value, Flag, BestMove: Integer);
var
  Index: Cardinal;
  DataSignature: UInt64;
begin
  Index := Hash and (FTTSize - 1);

  if BestMove = 0 then BestMove := -2; // Safety: 0 is never a valid move index

  // Depth-preferred replacement
  if (FTranspositionTable[Index].Hash = 0) or (FTranspositionTable[Index].Depth <= Depth) then
  begin
    // Create a signature of the data fields to detect torn reads in a lockless environment
    DataSignature := UInt64(Value) xor (UInt64(Depth) shl 32) xor
                     (UInt64(Flag) shl 40) xor (UInt64(BestMove) shl 48);

    // Write data fields first
    FTranspositionTable[Index].Value := Value;
    FTranspositionTable[Index].Depth := Depth;
    FTranspositionTable[Index].Flag := Flag;
    FTranspositionTable[Index].BestMove := BestMove;

    // Store the XORed key last. This acts as a checksum.
    FTranspositionTable[Index].Hash := Hash xor DataSignature;
  end;
end;

function TForm1.LookupTT(Hash: UInt64; Depth, Alpha, Beta: Integer; var Value, BestMove: Integer): Boolean;
var
  Index: Cardinal;
  Entry: TTranspositionEntry;
  DataSignature: UInt64;
begin
  Result := False;
  Index := Hash and (FTTSize - 1);

  // Read the entire entry into a local copy. This might be a "torn read"
  // if another thread is writing to it simultaneously.
  Entry := FTranspositionTable[Index];

  // Reconstruct the signature from the data we just read
  DataSignature := UInt64(Entry.Value) xor (UInt64(Entry.Depth) shl 32) xor
                   (UInt64(Entry.Flag) shl 40) xor (UInt64(Entry.BestMove) shl 48);

  // If (StoredHash XOR ReconstructedSignature) matches our search Hash, the read was valid.
  if (Entry.Hash xor DataSignature) = Hash then
  begin
    if (Entry.BestMove = 0) then
      BestMove := -2
    else
      BestMove := Entry.BestMove;

    if Entry.Depth >= Depth then
    begin
      case Entry.Flag of
        TT_EXACT:
        begin
          Value := Entry.Value;
          Exit(True);
        end;
        TT_LOWERBOUND:
        begin
          if Entry.Value >= Beta then
          begin
            Value := Entry.Value;
            Exit(True);
          end;
        end;
        TT_UPPERBOUND:
        begin
          if Entry.Value <= Alpha then
          begin
            Value := Entry.Value;
            Exit(True);
          end;
        end;
      end;
    end;
  end;
end;

procedure TForm1.GetPVFromTT(ABoard: Tboard; SideIsRed: Boolean; MaxMoreMoves: Integer; var PV: TMoveArray);
var
  h: UInt64;
  Index: Cardinal;
  Entry: TTranspositionEntry;
  DataSignature: UInt64;
  current_depth: Integer;
begin
  current_depth := 0;
  while (current_depth < MaxMoreMoves) and (PV.Count < 64) do
  begin
    h := ABoard.Hash;
    Index := h and (FTTSize - 1);
    Entry := FTranspositionTable[Index];
    DataSignature := UInt64(Entry.Value) xor (UInt64(Entry.Depth) shl 32) xor
                     (UInt64(Entry.Flag) shl 40) xor (UInt64(Entry.BestMove) shl 48);

    if (Entry.Hash xor DataSignature) <> h then
      break;

    // Validate move
    if (Entry.BestMove = -2) or (Entry.BestMove = 0) then break;

    PV.Moves[PV.Count] := Entry.BestMove;
    inc(PV.Count);
    inc(current_depth);

    if Entry.BestMove = -1 then
    begin
      ABoard.Hash := ABoard.Hash xor FZobristSide;
    end
    else
    begin
      if SideIsRed then
        RedBoardUpdate(ABoard, Entry.BestMove)
      else
        BlackBoardUpdate(ABoard, Entry.BestMove);
    end;
    SideIsRed := not SideIsRed;
  end;
end;

procedure TForm1.FastScoresort(var moves: TMoveArray; var scores: array of Integer);
var
  i, j, tempMove, tempScore: Integer;
begin
  for i := 1 to moves.Count - 1 do
  begin
    tempScore := scores[i];
    tempMove := moves.Moves[i];
    j := i - 1;
    while (j >= 0) and (scores[j] < tempScore) do
    begin
      scores[j + 1] := scores[j];
      moves.Moves[j + 1] := moves.Moves[j];
      Dec(j);
    end;
    scores[j + 1] := tempScore;
    moves.Moves[j + 1] := tempMove;
  end;
end;

function TForm1.GetMoveHeuristic(move: Integer; {%H-}SideIsRed: Boolean): Integer;
var
  r, c: Integer;
begin
  if move = -1 then Exit(0);
  r := (move - 1) div 8 + 1;
  c := (move - 1) mod 8 + 1;
  // In Anti-Reversi, PosMark contains negative values for good squares (like corners)
  // EvaluateScore uses PosMark for both sides, just negating the final result.
  Result := PosMark[r, c];
end;

function MoveToThinkStep(move: Integer): string;
var
  c: Integer;
begin
  if move = -1 then
    Result := 'PASS'
  else
  begin
    c := move mod 8;
    if c = 0 then c := 8;
    Result := IntToStr(c);
  end;
end;

function MoveArrayToThinkStep(const moves: TMoveArray): string;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to moves.Count - 1 do
  begin
    if i > 0 then Result := Result + '->';
    Result := Result + MoveToThinkStep(moves.Moves[i]);
  end;
end;

var
  GHasAVX512VPOPCNTDQ: Boolean = False;
  GHasPOPCNT: Boolean = False;

procedure DetectCPUFeatures;
var
  vEAX, vEBX, vECX, vEDX: Cardinal;
begin
  // Check Features (EAX=1)
  vECX := 0;
  {$ASMMODE ATT}
  asm
    movl $1, %eax
    cpuid
    movl %ecx, vECX
  end ['EAX', 'EBX', 'ECX', 'EDX'];
  GHasPOPCNT := (vECX and (1 shl 23)) <> 0;

  // Check Extended Features (EAX=7, ECX=0)
  vEBX := 0;
  vECX := 0;
  asm
    movl $7, %eax
    xorl %ecx, %ecx
    cpuid
    movl %ebx, vEBX
    movl %ecx, vECX
  end ['EAX', 'EBX', 'ECX', 'EDX'];
  GHasAVX512VPOPCNTDQ := (vECX and (1 shl 14)) <> 0;
end;

procedure BatchPopCount(Inputs: Pointer; Outputs: PInteger; Count: Integer);
var
  temp: array[0..7] of UInt64;
  i: Integer;
  pIn: PQWord;
  pOut: PInteger;
begin
  pIn := PQWord(Inputs);
  pOut := Outputs;
  if GHasAVX512VPOPCNTDQ and (Count >= 8) then
  begin
    while Count >= 8 do
    begin
      {$ASMMODE ATT}
      asm
        movq pIn, %rax
        // vmovdqu64 (%rax), %zmm0
        .byte 0x62, 0xF1, 0xFD, 0x48, 0x6F, 0x00
        // vpopcntdq %zmm0, %zmm0
        .byte 0x62, 0xF2, 0xFD, 0x48, 0x55, 0xC0
        leaq temp, %rdx
        // vmovdqu64 %zmm0, (%rdx)
        .byte 0x62, 0xF1, 0xFD, 0x48, 0x7F, 0x02
      end ['rax', 'rdx', 'xmm0'];
      for i := 0 to 7 do
      begin
        pOut^ := Integer(temp[i]);
        Inc(pOut);
      end;
      Inc(pIn, 8);
      Dec(Count, 8);
    end;
  end;

  while Count > 0 do
  begin
    pOut^ := Integer(System.PopCnt(pIn^));
    Inc(pIn);
    Inc(pOut);
    Dec(Count);
  end;
end;

function PopCount(N: UInt64): Integer; inline;
begin
  if GHasPOPCNT then
    Result := System.PopCnt(N)
  else
  begin
    // SWAR (SIMD Within A Register) PopCount fallback
    N := N - ((N shr 1) and $5555555555555555);
    N := (N and $3333333333333333) + ((N shr 2) and $3333333333333333);
    Result := (((N + (N shr 4)) and $0F0F0F0F0F0F0F0F) * $0101010101010101) shr 56;
  end;
end;

function GetBoardPiece(const AB: Tboard; Row, Col: Integer): Integer; inline;
var bit: Integer;
begin
  if (Row < 1) or (Row > 8) or (Col < 1) or (Col > 8) then exit(0);
  bit := (Row - 1) * 8 + (Col - 1);
  if (AB.Red and (UInt64(1) shl bit)) <> 0 then Result := 1
  else if (AB.Black and (UInt64(1) shl bit)) <> 0 then Result := -1
  else Result := 0;
end;

procedure SetBoardPiece(var AB: Tboard; Row, Col: Integer; Val: Integer);
var bit: Integer; mask: UInt64;
begin
  if (Row < 1) or (Row > 8) or (Col < 1) or (Col > 8) then exit;
  bit := (Row - 1) * 8 + (Col - 1);
  mask := UInt64(1) shl bit;
  AB.Red := AB.Red and (not mask);
  AB.Black := AB.Black and (not mask);
  if Val = 1 then AB.Red := AB.Red or mask
  else if Val = -1 then AB.Black := AB.Black or mask;
end;

function GetDropRow(const Board: TBoard; Col: Integer): Integer;
var r: Integer;
begin
  for r := 8 downto 1 do
    if GetBoardPiece(Board, r, Col) = 0 then
      Exit(r);
  Result := 0; // Column full
end;

function CheckWin(Pieces: UInt64): Boolean;
var
  temp: UInt64;
begin
  // Vertical
  temp := Pieces and (Pieces shl 8);
  if (temp and (temp shl 16)) <> 0 then Exit(True);

  // Horizontal
  temp := Pieces and (Pieces shl 1) and $FEFEFEFEFEFEFEFE;
  if (temp and (temp shl 2) and $FCFCFCFCFCFCFCFC) <> 0 then Exit(True);

  // Diagonal \ (Down-Right)
  temp := Pieces and (Pieces shl 9) and $FEFEFEFEFEFEFEFE;
  if (temp and (temp shl 18) and $FCFCFCFCFCFCFCFC) <> 0 then Exit(True);

  // Diagonal / (Down-Left)
  temp := Pieces and (Pieces shl 7) and $7F7F7F7F7F7F7F7F;
  if (temp and (temp shl 14) and $3F3F3F3F3F3F3F3F) <> 0 then Exit(True);

  Result := False;
end;

function IsBottomRowFull(const Board: TBoard): Boolean;
begin
  Result := ((Board.Red or Board.Black) and ROW8_MASK) = ROW8_MASK;
end;

function GetBoardMoves(const Board: TBoard): UInt64;
var
  col, r, bit: Integer;
  res: UInt64;
begin
  res := 0;
  for col := 1 to 8 do
  begin
    r := GetDropRow(Board, col);
    if r > 0 then
    begin
       bit := (r - 1) * 8 + (col - 1);
       res := res or (UInt64(1) shl bit);
    end;
  end;
  Result := res;
end;

procedure ApplyBoardMove(var Own: UInt64; Move: UInt64; out Flipped: UInt64);
begin
  Flipped := 0;
  Own := Own or Move;
end;

type
  TParallelProcedure = procedure(Index: PtrInt) of object;

  TParallelWorker = class(TThread)
  private
    FCurrentIndex: PPtrInt;
    FMaxIndex: PtrInt;
    FProc: TParallelProcedure;
    FSection: PRTLCriticalSection;
  protected
    procedure Execute; override;
  public
    constructor Create(CurrentIndex: PPtrInt; MaxIndex: PtrInt; Proc: TParallelProcedure; Section: PRTLCriticalSection);
  end;

  TParallel = class
  private
    class var FMaxThreadCount: Integer;
    class function GetMaxThreadCount: Integer; static;
  public
    class property MaxThreadCount: Integer read GetMaxThreadCount write FMaxThreadCount;
    class procedure DoParallel(AProc: TParallelProcedure; StartIndex, EndIndex: PtrInt);
  end;

{ TParallelWorker }

constructor TParallelWorker.Create(CurrentIndex: PPtrInt; MaxIndex: PtrInt; Proc: TParallelProcedure; Section: PRTLCriticalSection);
begin
  inherited Create(True); // Create suspended to avoid race condition
  FCurrentIndex := CurrentIndex;
  FMaxIndex := MaxIndex;
  FProc := Proc;
  FSection := Section;
  FreeOnTerminate := False;
end;

procedure TParallelWorker.Execute;
var
  Index, Index2: PtrInt;
  HasTwo: Boolean;
  Remaining: PtrInt;
  ThreadCount: Integer;
begin
  ThreadCount := TParallel.MaxThreadCount;
  while not Terminated do
  begin
    HasTwo := False;
    EnterCriticalSection(FSection^);
    try
      Index := FCurrentIndex^;
      if Index > FMaxIndex then
        Exit;

      Remaining := FMaxIndex - Index + 1;
      if Remaining > (ThreadCount - 1) then
      begin
        Index2 := Index + 1;
        FCurrentIndex^ := FCurrentIndex^ + 2;
        HasTwo := True;
      end
      else
      begin
        Inc(FCurrentIndex^);
      end;
    finally
      LeaveCriticalSection(FSection^);
    end;

    FProc(Index);
    if HasTwo then
      FProc(Index2);
  end;
end;

{ TParallel }

class function TParallel.GetMaxThreadCount: Integer;
var
  SI: SYSTEM_INFO;
begin
  if FMaxThreadCount = 0 then
  begin
    SI.dwNumberOfProcessors := 0;
    GetSystemInfo(SI);
    FMaxThreadCount := SI.dwNumberOfProcessors;
  end;
  Result := FMaxThreadCount;
end;

class procedure TParallel.DoParallel(AProc: TParallelProcedure; StartIndex, EndIndex: PtrInt);
var
  Workers: array of TParallelWorker;
  ThreadCount, i: Integer;
  CurrentIndex: PtrInt;
  Section: TRTLCriticalSection;
begin
  if EndIndex < StartIndex then Exit;

  ThreadCount := MaxThreadCount;
  if ThreadCount > (EndIndex - StartIndex + 1) then
    ThreadCount := EndIndex - StartIndex + 1;

  if ThreadCount <= 1 then
  begin
    for i := StartIndex to EndIndex do
      AProc(i);
    Exit;
  end;

  InitCriticalSection(Section);
  try
    CurrentIndex := StartIndex;
    SetLength(Workers, ThreadCount);
    for i := 0 to ThreadCount - 1 do
    begin
      Workers[i] := TParallelWorker.Create(@CurrentIndex, EndIndex, AProc, @Section);
      Workers[i].Start;
    end;

    for i := 0 to ThreadCount - 1 do
    begin
      Workers[i].WaitFor;
      Workers[i].Free;
    end;
  finally
    DoneCriticalSection(Section);
  end;
end;



{ TAIThread }

constructor TAIThread.Create(AForm: TForm1; ABoard: Tboard; AComputerIsRed: Boolean);
begin
  inherited Create(True);
  FForm := AForm;
  FBoard := ABoard;
  FComputerIsRed := AComputerIsRed;
  FreeOnTerminate := True;
end;

procedure TAIThread.Execute;
begin
  FForm.FAIWasRed := FComputerIsRed;

  FStartTime := GetTickCount64;
  FResultMove := FForm.AI(FBoard, FComputerIsRed);

  Synchronize(SyncNotifyDone);
end;

procedure TAIThread.SyncNotifyDone;
begin
  FForm.FAIThread := nil;
  if not Terminated then
    FForm.HandleAIResult(FResultMove);
end;

procedure TForm1.HandleAIResult(const MoveName: string);
var
  Img: TImage;
begin
  Img := TImage(FindComponent(MoveName));
  if Img <> nil then
  begin
    if FAIWasRed then
      RedChessClick(Img)
    else
      BlackChessClick(Img);
  end;
end;

procedure TForm1.UpdateAIUI;
var
  LocalAppendList: TStringList;
  LocalScore, LocalTime, LocalThinkStep: string;
  LocalClear: Boolean;
  i: Integer;
begin
  LocalAppendList := TStringList.Create;
  try
    system.EnterCriticalSection(MyCriticalSection);
    try
      LocalScore := FMetricsScore;
      LocalTime := FMetricsTime;
      LocalThinkStep := FMetricsThinkStep;
      LocalClear := FMetricsClear;
      FMetricsClear := False;
      FMetricsScore := '';
      FMetricsTime := '';
      FMetricsThinkStep := '';

      LocalAppendList.Assign(FMetricsAppendList);
      FMetricsAppendList.Clear;
    finally
      system.LeaveCriticalSection(MyCriticalSection);
    end;

    if LocalClear then AiListBox.Clear;
    if LocalScore <> '' then AIDisplayScoreLabel.Caption := LocalScore;
    if LocalTime <> '' then AIUsedTimeLabel.Caption := LocalTime;
    if LocalThinkStep <> '' then
    begin
      if LocalScore <> '' then
        ThinkstepEdit.Text := LocalScore + ': ' + LocalThinkStep
      else
        ThinkstepEdit.Text := LocalThinkStep;
    end;
    if LocalAppendList.Count > 0 then
    begin
      AiListBox.Items.BeginUpdate;
      try
        for i := 0 to LocalAppendList.Count - 1 do
          AiListBox.Items.Add(LocalAppendList[i]);
      finally
        AiListBox.Items.EndUpdate;
      end;
      // Scroll to bottom
      AiListBox.ItemIndex := AiListBox.Items.Count - 1;
    end;
  finally
    LocalAppendList.Free;
  end;
end;

procedure TForm1.CallSyncUpdateAIUI(const AScore, ATime, AThinkStep: string; AClear, AAppend: Boolean);
begin
  system.EnterCriticalSection(MyCriticalSection);
  try
    if AClear then FMetricsClear := True;
    if AScore <> '' then FMetricsScore := AScore;
    if ATime <> '' then FMetricsTime := ATime;
    if AThinkStep <> '' then
    begin
      FMetricsThinkStep := AThinkStep;
      if AAppend then FMetricsAppendList.Add(AThinkStep);
    end;
  finally
    system.LeaveCriticalSection(MyCriticalSection);
  end;
end;

procedure TForm1.StartAI(AComputerIsRed: Boolean);
begin
  if FAIThread <> nil then Exit;
  FAIThread := TAIThread.Create(Self, board, AComputerIsRed);
  FAIThread.Start;
end;

procedure TForm1.NewGame(AFirstIsRed: Boolean);
var templist: TStringList;
begin
  if FAIThread <> nil then Exit;

  FirstIsRed := AFirstIsRed;
  Initboard.Red := 0;
  Initboard.Black := 0;
  Initboard.Hash := 0;
  board := Initboard;
  board.Hash := CalculateHash(board, FirstIsRed);

  Redlist.Clear;
  Blacklist.Clear;
  movedlist.Clear;
  StepListBox.Clear;
  RedNoMove := False;
  BlackNoMove := False;
  notinback := True;

  Updateboard;

  templist := TStringList.Create;
  if FirstIsRed then
  begin
    MakeRedMove(board, templist);
    MakeClick(templist, 'player1');
  end
  else begin
    MakeBlackMove(board, templist);
    MakeClick(templist, 'player2');
  end;
  templist.Free;
  Updateboard;

  Label3.Caption := '0';
  Label4.Caption := '0';
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FTTSize := 1 shl 24;
  DetectCPUFeatures;
  FMetricsAppendList := TStringList.Create;
  Timer1.Interval := 100; // Faster updates for decoupled UI

  system.InitCriticalSection(MyCriticalSection);
  randomize;
  InitializeZobrist;

  Redlist := TStringList.Create;
  Blacklist := TStringList.Create;
  movedlist := TStringList.Create;

  NewGame(True);
end;
function TForm1.Muti(const ComputerisRed:Boolean):string;
var a,b,c,tempdepth:integer; move: TMoveArray;
function test(const depth:integer;const cuted:Boolean;const fullthink:boolean):string;
var a,b,i,j,bestscore, temp_idx, best_count:integer; templist, templist2: TMoveArray; OneDepthSideisRed:boolean; bestmove:string; move: TMoveArray;
    sort_indices: array of Integer;
begin
  Result := '';
  move.Count := 0;
  templist.Count := 0;
  templist2.Count := 0;
if ComputerisRed = False then
begin
  OneDepthSideisRed:=False;
  if mutisteplist.Count <> 0 then
  begin
    templist := mutisteplist;
    mutisteplist.Count := 0;
  end
  else
    FastMakeBlackMove(board, templist);
end
else begin
  OneDepthSideisRed:=True;
  if mutisteplist.Count <> 0 then
  begin
    templist := mutisteplist;
    mutisteplist.Count := 0;
  end
  else
    FastMakeRedMove(board, templist);
end;

mutiSideisRed := OneDepthSideisRed;
board.Hash := CalculateHash(board, OneDepthSideisRed); // Ensure hash is synchronized
SetLength(FParallelTasks, 0);
SetLength(mutiscores, templist.Count);
SetLength(mutiresults, templist.Count);
For a:= 0 to templist.Count-1 do
begin
   mutiscores[a] := -inf;
   mutiresults[a].Count := 0;

   mutiBoard := board;
   if OneDepthSideisRed then
   begin
     Redboardupdate(mutiBoard, templist.Moves[a]);
     FastMakeBlackMove(mutiBoard, templist2);
   end
   else  begin
     Blackboardupdate(mutiBoard, templist.Moves[a]);
     FastMakeRedMove(mutiBoard, templist2);
   end;

   if templist2.Count = 0 then
   begin
     SetLength(FParallelTasks, Length(FParallelTasks) + 1);
     FParallelTasks[High(FParallelTasks)].Move1 := templist.Moves[a];
     FParallelTasks[High(FParallelTasks)].Move2 := -1; // PASS
     FParallelTasks[High(FParallelTasks)].Move1Idx := a;
   end
   else begin
     SetLength(FParallelTasks, Length(FParallelTasks) + templist2.Count);
     for b:= 0 to templist2.Count - 1 do
     begin
       FParallelTasks[Length(FParallelTasks) - templist2.Count + b].Move1 := templist.Moves[a];
       FParallelTasks[Length(FParallelTasks) - templist2.Count + b].Move2 := templist2.Moves[b];
       FParallelTasks[Length(FParallelTasks) - templist2.Count + b].Move1Idx := a;
     end;
   end;
end;
CallSyncUpdateAIUI('', '', 'Tasks: ' + IntToStr(Length(FParallelTasks)) + ' | Threads: ' + IntToStr(TParallel.MaxThreadCount), True, True);
mutidepth:= depth;

TParallel.DoParallel(DoSomethingParallel,0,High(FParallelTasks));

for a:= 0 to High(mutiscores) do
   mutiscores[a] := -mutiscores[a];

// Sort logic needs to be updated too. For now I'll just find the best.
bestscore := -INF;
for a := 0 to High(mutiscores) do
  if mutiscores[a] > bestscore then bestscore := mutiscores[a];

If (cuted = false) or (fullthink = True) then
begin
 for a:= 0 to High(mutiscores) do
  CallSyncUpdateAIUI('', '', IntToStr(mutiscores[a])+':'+MoveArrayToThinkStep(mutiresults[a]), False, True);

 // Find all moves with the best score
 best_count := 0;
 // Use a fixed-size array on the stack to avoid heap allocation
 for a := 0 to High(mutiscores) do
   if mutiscores[a] = bestscore then inc(best_count);

 a := Random(best_count);
 best_count := 0;
 for j := 0 to High(mutiscores) do
   if mutiscores[j] = bestscore then
   begin
     if best_count = a then
     begin
       move := mutiresults[j];
       break;
     end;
     inc(best_count);
   end;

 bestmove := MoveArrayToThinkStep(move);
 CallSyncUpdateAIUI('', '', bestmove, False, False);

 if copy(bestmove, 1, 4) = 'PASS' then
   Result := ''
 else begin
   Result := 'Image' + IntToStr(move.Moves[0]);
 end;
 CallSyncUpdateAIUI(IntToStr(bestscore), '', '', False, False);
end
else begin
  // Aggressive filtering to match original performance
  mutisteplist.Count := 0;
  // Sort moves by score (descending) - using index-based sort to avoid record copies
  SetLength(sort_indices, templist.Count);
  for a := 0 to templist.Count - 1 do sort_indices[a] := a;

  for a := 0 to templist.Count - 2 do
    for j := a + 1 to templist.Count - 1 do
      if mutiscores[sort_indices[j]] > mutiscores[sort_indices[a]] then
      begin
        temp_idx := sort_indices[a];
        sort_indices[a] := sort_indices[j];
        sort_indices[j] := temp_idx;
      end;

  // Reorder mutiscores and mutiresults based on sort_indices
  for a := 0 to templist.Count - 1 do
  begin
    if sort_indices[a] <> a then
    begin
       // Only swap if needed
       i := mutiscores[a]; mutiscores[a] := mutiscores[sort_indices[a]]; mutiscores[sort_indices[a]] := i;
       move := mutiresults[a]; mutiresults[a] := mutiresults[sort_indices[a]]; mutiresults[sort_indices[a]] := move;
       // Update sort_indices to track where the moved element went
       for j := a + 1 to templist.Count - 1 do
         if sort_indices[j] = a then
         begin
           sort_indices[j] := sort_indices[a];
           break;
         end;
    end;
  end;

  // Take all available steps (all sorted moves)
  i := templist.Count;
  for a := 0 to i - 1 do
  begin
    mutisteplist.Moves[mutisteplist.Count] := mutiresults[a].Moves[0];
    inc(mutisteplist.Count);
  end;
end;
end;
begin
  Result := '';
  move.Count := 0;
//  mutisteplist := Tstringlist.Create;

  if ComputerIsRed then FastMakeRedMove(board, move)
  else FastMakeBlackMove(board, move);
  c := move.Count;

  a := 0; b := 0;
  score(board,a,b);
  if a+b + strToint(Endgamedepth.text) >= 40 then
  begin
    tempdepth:= 64-a-b;
    Result:=test(tempdepth,true,True);
  end
  else begin
    tempdepth:= strToint(Nornaldepth.Text);
    if (c >= 4) and (a + b < 46)  then
    begin
      tempdepth:= tempdepth-4;
      test(tempdepth,true,false);
      tempdepth:= tempdepth + 2;
      Result:=test(tempdepth,false,false);
    end
    else begin
      tempdepth := tempdepth - 2;
      Result:=test(tempdepth,true,True);
    end;
  end;
  mutisteplist.Count := 0;
  mutitemplist.Count := 0;
  mutiscorelist.Count := 0;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  UpdateAIUI;
end;

procedure TForm1.AboutButtonClick(Sender: TObject);
begin
  ShowMessage('Sum GNU Linetris v1.0' + #13 + 'Based on Sum GNU Anti-Reversi source code.');
end;

procedure TForm1.NornalDepthChange(Sender: TObject);
begin

end;

procedure TForm1.ComputerFirstButtonClick(Sender: TObject);
begin
  HumanVsComputer.Checked := False;
  ComputerVsHuman.Checked := True;
  HumanvsHuman.Checked := False;
  redlabel.Caption := 'Computer';
  blacklabel.Caption := 'Human';
  NewGame(True);
  StartAI(True);
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  system.DoneCriticalSection(MyCriticalSection);
end;

procedure TForm1.DoSomethingParallel(Index: PtrInt);
var Aboard:Tboard; a, mutitscore, move1, move2: integer;
    path: TMoveArray;
begin
  move1 := FParallelTasks[Index].Move1;
  move2 := FParallelTasks[Index].Move2;
  a := FParallelTasks[Index].Move1Idx;

  path.Count := 0;
  path.Moves[0] := move1;
  path.Count := 1;

  Aboard:= board;
  if move2 <> -1 then
  begin
    path.Moves[1] := move2;
    path.Count := 2;

    if mutisideisRed = True then
    begin
      RedboardUpdate(Aboard,move1);
      Blackboardupdate(Aboard,move2);
    end
    else begin
      Blackboardupdate(Aboard,move1);
      RedboardUpdate(Aboard,move2);
    end;

    if  mutidepth > 5 then
      mutitscore := -MinMaxStart(Aboard,mutiSideIsRed,mutidepth, -INF, INF, path)
    else
      mutitscore := -MinMax(Aboard,mutiSideIsRed,mutidepth, -INF, INF, path);
  end
  else begin
     path.Moves[1] := -1; // PASS
     path.Count := 2;

     if mutisideisRed = True then
       RedboardUpdate(Aboard,move1)
     Else
       Blackboardupdate(Aboard,move1);
     Aboard.Hash := Aboard.Hash xor FZobristSide;
     mutitscore := -MinMax(Aboard,mutiSideIsRed,mutidepth+1, -INF, INF, path);
  end;

  system.EnterCriticalsection(MyCriticalSection);
  if mutitscore > mutiscores[a] then
  begin
    mutiscores[a] := mutitscore;
    mutiresults[a] := path;
  end;
  system.LeaveCriticalsection(MyCriticalSection);
end;

procedure TForm1.FastMakeRedMove(const aBoard:Tboard; var temp:TMoveArray);
var
  moves: UInt64;
  bit: Integer;
begin
  temp.Count := 0;
  moves := GetBoardMoves(aBoard);
  while moves <> 0 do
  begin
    bit := BsfQWord(moves);
    temp.Moves[temp.Count] := bit + 1;
    inc(temp.Count);
    moves := moves and (moves - 1);
  end;
end;

procedure TForm1.FastMakeBlackMove(const aBoard:Tboard; var temp:TMoveArray);
var
  moves: UInt64;
  bit: Integer;
begin
  temp.Count := 0;
  moves := GetBoardMoves(aBoard);
  while moves <> 0 do
  begin
    bit := BsfQWord(moves);
    temp.Moves[temp.Count] := bit + 1;
    inc(temp.Count);
    moves := moves and (moves - 1);
  end;
end;

procedure TForm1.MakeRedMove(const aBoard:Tboard;var temp:TStringList);
var
  moves: UInt64;
  bit: Integer;
begin
  temp.Clear;
  moves := GetBoardMoves(aBoard);
  for bit := 0 to 63 do
  begin
    if (moves and (UInt64(1) shl bit)) <> 0 then
    begin
      temp.Add(IntToStr(bit + 1));
    end;
  end;
end;


procedure TForm1.MakeblackMove(const aBoard:Tboard;var temp:TStringList);
var
  moves: UInt64;
  bit: Integer;
begin
  temp.Clear;
  moves := GetBoardMoves(aBoard);
  for bit := 0 to 63 do
  begin
    if (moves and (UInt64(1) shl bit)) <> 0 then
    begin
      temp.Add(IntToStr(bit + 1));
    end;
  end;
end;
//end of aimove

procedure TForm1.MakeClick(t:Tstringlist;Player:string);
var a:integer;
begin
  for a:= 0 to t.Count-1 do
    t[a]:='Image'+ t[a];
  redlist.Clear;
  blacklist.Clear;
  if player = 'player1' then
  begin
    for a:= 0 to t.Count-1 do
      redlist.Add(t[a]);
  end
  else begin
    for a:= 0 to t.Count-1 do
      blacklist.Add(t[a]);
  end;
end;

procedure TForm1.RedBoardUpdate(var Aboard:Tboard;LastChess:Integer);
var
  moveBit, flipped: UInt64;
begin
  if (LastChess < 1) or (LastChess > 64) then Exit;

  moveBit := UInt64(1) shl (LastChess - 1);
  ApplyBoardMove(Aboard.Red, moveBit, flipped);
  UpdateHash(Aboard.Hash, LastChess - 1, 1);

  if not CheckWin(Aboard.Red) then
  begin
    if IsBottomRowFull(Aboard) then
    begin
       Aboard.Red := Aboard.Red shl 8;
       Aboard.Black := Aboard.Black shl 8;
       Aboard.Hash := CalculateHash(Aboard, False);
    end
    else
      Aboard.Hash := Aboard.Hash xor FZobristSide;
  end
  else
    Aboard.Hash := Aboard.Hash xor FZobristSide;
end;

procedure TForm1.RedChessClick(Sender: TObject);
// update chess
var a,b,c:integer;templist:tstringlist;
    targetImg: TImage;
begin
  if (Sender = nil) or (FAIThread <> nil) then exit;
  // clean the t
  For a:= 0 to Redlist.Count-1 do
  begin
      targetImg := TImage(FindComponent(Redlist[a]));
      if targetImg <> nil then
      begin
        targetImg.picture := nil;
        targetImg.onclick := nil;
      end;
  end;
 // clean move
  Timage(Sender).Picture := Chess2.Picture;
  Timage(Sender).OnClick := nil;

  if notinback = true then
  begin
    c:=movedlist.Add('Red');
  for a:=1 to 8 do
    for b:=1 to 8 do
      movedlist[c]:=movedlist[c]+intTostr(GetBoardPiece(board, a, b)+1);
  end;
  a:=StrToint(Copy(TComponent(Sender).name,6,2));
// temp fix wrong ?
  b:= a div 8 +1 ;
  c:= a mod 8;
  if c = 0 then
  begin
    b:=b-1;
    c:=8;
  end;
//  a := (c-1)*8 + b;
    SetBoardPiece(board, b, c, 1);

  if notinback = true then
  begin
    StepListbox.Items.Add('Red '+intTostr(c));
  end;
  if StepListBox.items.count > 1 then
    BackButton.enabled:=True;
  StepListbox.ItemIndex:=StepListbox.items.Count-1;
  redlist.Clear;
  blacklist.Clear;
  score(board,b,c);
  RedboardUpdate(board,a);
  if CheckWin(board.Red) then
  begin
    Updateboard;
    ShowMessage('Red wins!');
    Exit;
  end;

  Score(board,b,c);
  Label3.Caption:=intTostr(b);
  Label4.Caption:=intTostr(c);
  templist := Tstringlist.Create;
  // give another play
  MakeBlackMove(board,templist);
  if templist.Count > 0 then
  begin
    MakeClick(templist,'player2');
    RedNoMove:=False;
    BlackNoMove:=False;
    Updateboard;
    if HumanVsComputer.Checked then
    begin
      StartAI(False);
    end;
  end
  else
  begin
    if notinback =False then
      exit;
    StepListBox.Items.Add('Black pass');
    c:=movedlist.Add('Blackpass');
    for a:=1 to 8 do
      for b:=1 to 8 do
      movedlist[c]:=movedlist[c]+intTostr(GetBoardPiece(board, a, b)+1);
    if StepListBox.items.count > 1 then
      backbutton.enabled:=True;
    if RedNoMove = True then
    begin
      Updateboard;
      score(board,a,b);
      if a < b Then
        ShowMessage('Both no more move,finish game'+#13+'Red win')
      else if a > b then
        ShowMessage('Both no more move,finish game'+#13+'Black win')
      else if a = b then
        ShowMessage('Both no more move,finish game'+#13+'Draw');
    end
    else begin
      Updateboard;
      templist.Clear;
      if a+b <> 64 then
        ShowMessage('Black no move');
      MakeRedMove(board,templist);
      if templist.Count > 0 then
      begin
        MakeClick(templist,'player1');
        RedNoMove:=False;
        BlackNoMove:=False;
        Updateboard;
//        if ComputerVsHuman.Checked = true then
        if ComputerVsHuman.Checked then
        begin
          StartAI(True);
        end;
      end
      else begin
        if NotInBack = True then
        begin
        StepListBox.Items.Add('Red pass');
        c:=movedlist.Add('Redpass');
        for a:=1 to 8 do
         for b:=1 to 8 do
        movedlist[c]:=movedlist[c]+intTostr(GetBoardPiece(board, a, b)+1);
        end;
        if StepListBox.items.count > 1 then
          backbutton.enabled:=True;
        score(board,a,b);
        if a < b Then
          ShowMessage('Both no more move,finish game'+#13+'Red win')
        else if a > b then
          ShowMessage('Both no more move,finish game'+#13+'Black win')
        else if a = b then
          ShowMessage('Both no more move,finish game'+#13+'Draw');
      end;
    end;
  end;
  templist.Free;
end;

procedure TForm1.Score(const Aboard:Tboard;var RedScore,BlackScore:integer); inline;
begin
  RedScore := PopCount(Aboard.Red);
  BlackScore := PopCount(Aboard.Black);
end;

procedure TForm1.Updateboard;
var a,b,val:integer;
    targetImg: TImage;
begin
// draw general picture
  for a := 1 to 8 do
    for b := 1 to 8 do
    begin
      val := GetBoardPiece(board, a, b);
      targetImg := TImage(FindComponent('Image'+intTostr(8*a+b-8)));
      if targetImg <> nil then
      begin
        if val = 1 then
          targetImg.picture := Chess2.picture
        else if val = -1 then
          targetImg.picture := Chess1.picture
        else
          targetImg.picture := nil;
        targetImg.onclick := nil;
      end;
    end;
// draw red picture

  for a:=0 to Redlist.Count-1 do
  begin
    targetImg := TImage(FindComponent(Redlist[a]));
    if targetImg <> nil then
    begin
      targetImg.picture := Redchess.picture;
      targetImg.OnClick := Redchess.onclick;
    end;
  end;

  for a:=0 to Blacklist.Count-1 do
  begin
    targetImg := TImage(FindComponent(Blacklist[a]));
    if targetImg <> nil then
    begin
      targetImg.picture := BlackChess.picture;
      targetImg.OnClick := BlackChess.onclick;
    end;
  end;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  if FAIThread <> nil then
  begin
    FAIThread.Terminate;
    FAIThread.WaitFor;
  end;
 // 唔用就釋放番
  Redlist.Free;
  Blacklist.Free;
//  AiMoveList.Free;
  Movedlist.Free;
  FMetricsAppendList.Free;
end;

procedure TForm1.HumanFirstButtonClick(Sender: TObject);
begin
  HumanVsComputer.Checked := True;
  ComputerVsHuman.Checked := False;
  HumanvsHuman.Checked := False;
  redlabel.Caption := 'Human';
  blacklabel.Caption := 'Computer';
  NewGame(True);
end;

procedure TForm1.HumanVsHumanButtonClick(Sender: TObject);
begin
  HumanvsHuman.Checked := True;
  HumanVsComputer.Checked := False;
  ComputerVsHuman.Checked := False;
  redlabel.Caption := 'Human';
  blacklabel.Caption := 'Human';
  NewGame(True);
end;
procedure TForm1.HumanvsHumanClick(Sender: TObject);
begin
  HumanVsComputer.checked :=False;
  ComputerVsHuman.checked :=False;
  HumanvsHuman.checked :=True;
  redlabel.Caption := 'Human';
  blacklabel.Caption := 'Human';
end;

procedure TForm1.MenuItem1Click(Sender: TObject);
begin

end;

procedure TForm1.RuleButtonClick(Sender: TObject);
begin
  ShowMessage('Sum GNU Linetris Rules:' + #13 +
              '1. The goal is to get 4 pieces in a row (horizontal, vertical, or diagonal).' + #13 +
              '2. If the bottom row is fully occupied by pieces, and the move did not result in a win, all pieces in that row disappear and the rest of the board is shifted one row down.');
end;



procedure TForm1.RunCliTest;
var
  aibestmove: TMoveArray;
  score: Integer;
  resStr, expectedStr: string;
  r, c: Integer;
  moveList: TMoveArray;
begin
  moveList.Count := 0;

  // Use fixed seed for deterministic Zobrist keys in test
  RandSeed := 12345;
  InitializeZobrist;

  // Setup board state from screenshot history
  Initboard.Red := 0;
  Initboard.Black := 0;
  Initboard.Hash := 0;
  board := Initboard;
  // Start with Red to move
  board.Hash := CalculateHash(board, True);

  // History (c,b) -> Index: (b-1)*8 + c
  // Red 4,5 (36); Black 4,4 (28); Red 5,4 (29); Black 5,5 (37); Red 6,5 (38); Black 4,6 (44);
  // Red 3,5 (35); Black 2,4 (26); Red 2,5 (34); Black 6,4 (30); Red 5,3 (21); Black 3,4 (27);
  // Red 3,3 (19); Black 3,6 (43)
  RedBoardUpdate(board, 36);  // 4,5
  BlackBoardUpdate(board, 28); // 4,4
  RedBoardUpdate(board, 29);  // 5,4
  BlackBoardUpdate(board, 37); // 5,5
  RedBoardUpdate(board, 38);  // 6,5
  BlackBoardUpdate(board, 44); // 4,6
  RedBoardUpdate(board, 35);  // 3,5
  BlackBoardUpdate(board, 26); // 2,4
  RedBoardUpdate(board, 34);  // 2,5
  BlackBoardUpdate(board, 30); // 6,4
  RedBoardUpdate(board, 21);  // 5,3
  BlackBoardUpdate(board, 27); // 3,4
  RedBoardUpdate(board, 19);  // 3,3
  BlackBoardUpdate(board, 43); // 3,6

  // Dump board state for debugging
  Writeln('--- AI Test Debug Info ---');
  Writeln('Board state:');
  for r := 1 to 8 do
  begin
    for c := 1 to 8 do
    begin
      case GetBoardPiece(board, r, c) of
        1: Write('R');
        -1: Write('B');
        0: Write('.');
      end;
    end;
    Writeln;
  end;

  FastMakeRedMove(board, moveList);
  Writeln('Available Red moves: ' + MoveArrayToThinkStep(moveList));
  Writeln('Side to move: Red');
  Writeln('Search Depth: 9');

  // Search depth 9
  aibestmove.Count := 0;
  score := MinMax(board, True, 9, -INF, INF, aibestmove);

  resStr := IntToStr(score) + ': ' + MoveArrayToThinkStep(aibestmove);
  Writeln('Actual result:   bestmove ' + resStr);

  expectedStr := '-1: 6,3';
  Writeln('Expected prefix: bestmove ' + expectedStr);

  // Check against expected value (partial match for the prefix provided by user)
  if Pos('-1: 6,3', resStr) = 1 then
  begin
    Writeln('Result: Test PASSED');
    Halt(0);
  end
  else
  begin
    Writeln('Result: Test FAILED');
    Halt(1);
  end;
end;




procedure TForm1.BlackBoardUpdate(var Aboard:Tboard;LastChess:Integer);
var
  moveBit, flipped: UInt64;
begin
  if (LastChess < 1) or (LastChess > 64) then Exit;

  moveBit := UInt64(1) shl (LastChess - 1);
  ApplyBoardMove(Aboard.Black, moveBit, flipped);
  UpdateHash(Aboard.Hash, LastChess - 1, -1);

  if not CheckWin(Aboard.Black) then
  begin
    if IsBottomRowFull(Aboard) then
    begin
       Aboard.Red := Aboard.Red shl 8;
       Aboard.Black := Aboard.Black shl 8;
       Aboard.Hash := CalculateHash(Aboard, True);
    end
    else
      Aboard.Hash := Aboard.Hash xor FZobristSide;
  end
  else
    Aboard.Hash := Aboard.Hash xor FZobristSide;
end;


procedure TForm1.BlackChessClick(Sender: TObject);
// update chess
var a,b,c:integer;templist:Tstringlist;
    targetImg: TImage;
begin
  if (Sender = nil) or (FAIThread <> nil) then exit;
  // clean the made move
  For a:= 0 to Blacklist.Count-1 do
  begin
      targetImg := TImage(FindComponent(Blacklist[a]));
      if targetImg <> nil then
      begin
        targetImg.picture := nil;
        targetImg.onclick := nil;
      end;
  end;
  // clean move
    Timage(Sender).Picture := Chess1.Picture;
    Timage(Sender).OnClick := nil;
  if notinback = true then
  begin
    c:=movedlist.Add('Black');
    for a:=1 to 8 do
    for b:=1 to 8 do
      movedlist[c]:=movedlist[c]+intTostr(GetBoardPiece(board, a, b)+1);
  end;

  a:=StrToint(Copy(TComponent(Sender).name,6,2));
// tempfix
  b:= a div 8 +1 ;
  c:= a mod 8;
  if c = 0 then
  begin
    b:=b-1;
    c:=8;
  end;
//  a := (c-1)*8 + b;
  SetBoardPiece(board, b, c, -1);
  if notinback = true then
  begin
    StepListbox.Items.Add('Black '+intTostr(c));
   end;
   if StepListBox.items.count > 1 then
      backbutton.enabled:=True;
  StepListbox.ItemIndex:=StepListbox.items.Count-1;
   redlist.clear;
  blacklist.Clear;
  Score(board,b,c);
  BlackBoardUpdate(board,a);
  if CheckWin(board.Black) then
  begin
    Updateboard;
    ShowMessage('Black wins!');
    Exit;
  end;

  Score(board,b,c);
  Label3.Caption:=intTostr(b);
  Label4.Caption:=intTostr(c);
  templist:= Tstringlist.Create;
  MakeRedMove(board,templist);
  if templist.Count >0 then
  begin
    RedNoMove:=False;
    BlackNoMove:=False;
    MakeClick(templist,'player1');
    Updateboard;
//    if ComputerVsHuman.Checked = true then
    if ComputerVsHuman.Checked then
    begin
      StartAI(True);
    end;
  end
  else begin
    if notinback =False then
      exit;
    StepListBox.Items.Add('Red pass');
    c:=movedlist.Add('Red');
    for a:=1 to 8 do
     for b:=1 to 8 do
    movedlist[c]:=movedlist[c]+intTostr(GetBoardPiece(board, a, b)+1);
//may be correcteed
    if RedNoMove = True then
    begin
      Updateboard;
      score(board,a,b);
      if a < b Then
        ShowMessage('Both no more move,finish game'+#13+'Red win')
      else if a > b then
        ShowMessage('Both no more move,finish game'+#13+'Black win')
      else if a = b then
        ShowMessage('Both no more move,finish game'+#13+'Draw');
    end
    else begin
      Updateboard;
      if a+b <> 64 then
        ShowMessage('Red pass');
      templist.clear;
      MakeBlackMove(board,templist);
      if templist.Count > 0 then
      begin
        MakeClick(templist,'player2');
        RedNoMove:=False;
        BlackNoMove:=False;
       Updateboard;

        if HumanVsComputer.Checked then
        begin
          StartAI(False);
        end;
      end
      else begin
      if NotInback = True then
      begin
        StepListBox.Items.Add('Black pass');
        c:=movedlist.Add('Black');
        for a:=1 to 8 do
         for b:=1 to 8 do
        movedlist[c]:=movedlist[c]+intTostr(GetBoardPiece(board, a, b)+1);
      end;
      score(board,a,b);
      //corrected
      if a < b Then
        ShowMessage('Both no more move,finish game'+#13+'Red win')
      else if a > b then
        ShowMessage('Both no more move,finish game'+#13+'Black win')
      else if a = b then
        ShowMessage('Both no more move,finish game'+#13+'Draw');
      end;
    end;
  end;
  templist.Free;
end;
procedure TForm1.ClosebuttonClick(Sender: TObject);
begin
  Form1.Close;
end;


procedure TForm1.SaveButtonClick(Sender: TObject);
var a:integer;c:string;f:textfile;
begin
  SaveDialog1.Filter :='Sum GNU Linetris game files (*.txt)|*.TXT';
  if SaveDialog1.Execute then
  begin
    assignfile(f,SaveDialog1.FileName);
    try
      Rewrite(f);
      Writeln(F,'Sum GNU Linetris 8x8');
      Writeln(F,'Mode');
      if HumanVsComputer.Checked then
      begin
        c:= extractfilename(savedialog1.FileName);
        redlabel.Caption := copy(c,1,length(c)-4);
//        redlabel.Caption := extractfilename(savedialog1.FileName);
        blacklabel.Caption := 'Computer';
        Writeln(F,'HumanVSComputer');
      end
      else if ComputerVsHuman.Checked then
      begin
        c:= extractfilename(savedialog1.FileName);
        blacklabel.Caption := copy(c,1,length(c)-4);

//        blacklabel.Caption := extractfilename(savedialog1.FileName);
        redlabel.Caption := 'Computer';
        Writeln(F,'ComputerVSHuman');
      end
      else begin
        redlabel.Caption := 'Computer';
        blacklabel.Caption := 'Computer';
        Writeln(F,'HumanVSHuman');
      end;
      if FirstIsRed = true then
        Writeln(F,'Red first')
      else
        Writeln(F,'Black first');
      for a:= 0 to steplistbox.Items.Count-1 do
        Writeln(f,steplistbox.items[a]);
    finally
      closefile(f);
    end;
  end;
end;


Function TForm1.BoardtoFen:String;
var x,y,t,val:integer;
begin
//abc
  Result:='';
  for y:= 1 to 8 do
  begin
    t:=0;
    for x:= 1 to 8 do
    begin
       val := GetBoardPiece(initboard, x, y);
       if val = 0 then
          inc(t)
       else if val = -1 then
       begin
          if t <> 0 then
            Result:= Result + inttostr(t) + 'B'
          else
            Result:= Result +'B';
          t:=0;
       end
       else if val = 1 then
       begin
          if t <> 0 then
            Result:= Result + inttostr(t) + 'R'
          else
            Result:= Result + 'R';
          t:=0;
       end;
    end;
    if y  <> 8 then
    begin
      if t = 0 then
        Result := Result + '/'
      else
        Result := Result + inttostr(t) +'/';
    end
    else begin
      if t <> 0 then
        Result := Result + inttostr(t);
    end;

  end;

end;

procedure TForm1.CopyToClipboardButtonClick(Sender: TObject);
begin
  Clipboard.AsText := StepListBox.Items.Text;
end;







procedure TForm1.ComputerVsHumanClick(Sender: TObject);
begin
  HumanVsComputer.checked :=False;
  ComputerVsHuman.checked :=True;
  HumanvsHuman.checked :=False;
  redlabel.Caption := 'Computer';
  blacklabel.Caption := 'Human';
  if FirstIsRed then
  begin
    if StepListBox.Items.count = 0 then
      StepListBox.Items.add('temp');
    if (StepListBox.Items.count > 0) and
       ((StepListBox.Items[StepListBox.count-1] = 'temp') or
        (copy(StepListBox.Items[StepListBox.Items.count - 1],1,5) = 'Black')) then
    begin
      if StepListBox.Items[StepListBox.count-1] = 'temp' then
        StepListBox.Clear;
      RedNoMove:=False;
      BlackNoMove:=False;
      StartAI(True);
    end;
  end
  else begin
    if (StepListBox.Items.count > 0) and (copy(StepListBox.Items[StepListBox.Items.count - 1],1,5) = 'Black') then
    begin
      RedNoMove:=False;
      BlackNoMove:=False;
      StartAI(True);
    end;
  end;
end;



procedure TForm1.HumanVsComputerClick(Sender: TObject);
begin
  HumanVsComputer.checked :=True;
  ComputerVsHuman.checked :=False;
  HumanvsHuman.checked :=False;
  redlabel.Caption := 'Human';
  blacklabel.Caption := 'Computer';
  if FirstIsRed then
  begin
    if (StepListBox.Items.count > 0) and (copy(StepListBox.Items[StepListBox.Items.count - 1],1,3) = 'Red') then
    begin
      RedNoMove:=False;
      BlackNoMove:=False;
      StartAI(False); // Computer is Black
    end;
  end
  else begin
    if StepListBox.Items.count = 0 then
      StepListBox.Items.add('temp');
    if (StepListBox.Items.count > 0) and
       ((StepListBox.Items[StepListBox.count-1] = 'temp') or
        (copy(StepListBox.Items[StepListBox.Items.count - 1],1,3) = 'Red')) then
    begin
      if StepListBox.Items[StepListBox.count-1] = 'temp' then
        StepListBox.Clear;
      RedNoMove:=False;
      BlackNoMove:=False;
      StartAI(False); // Computer is Black
    end;
  end;
end;



procedure TForm1.LoadButtonClick(Sender: TObject);
var a,h:string;b,c,d,e:integer;F:textfile;templist:Tstringlist;
begin
  if OpenDialog1.Execute then
  begin
    assignfile(f,OpenDialog1.FileName);
//    try
    Reset(f);
    readln(f,a);
    if a <>'Sum GNU Linetris 8x8' then
    begin
      exit;
    end;
    blacklist.Clear;
    redlist.Clear;
    Initboard.Red := 0;
    Initboard.Black := 0;
    Initboard.Hash := 0;
    readln(f,a); // Mode
    readln(f,h);
    readln(f,a); // Red first
    if a = 'Red first' then
      FirstIsRed:=True
    else
      FirstIsRed:=False;
    movedlist.clear;
    StepListBox.items.Clear;

//    readln(f,a);//need change
    while not eof(f) do
    begin
      readln(f,a);
      StepListBox.Items.Add(a);
     // need add ?
    end;
    closefile(f);
    board:=initboard;
    notInBack:=False;
    redlist.Clear;
    blacklist.Clear;
    HumanvsHuman.Checked:=true;
    ComputerVsHuman.Checked:=False;
    HumanVsComputer.Checked:=False;
    templist:= Tstringlist.Create;
    for b:= 0 to StepListBox.Items.count - 1 do
    begin
      if copy(StepListBox.Items[b],1,3) = 'Red' then
      begin
        if copy(StepListBox.Items[b],5,1) <> 'p' then//p for pass
        begin
          e:=movedlist.Add('Red');
          for c:=1 to 8 do
           for d:=1 to 8 do
             movedlist[e]:=movedlist[e]+intTostr(GetBoardPiece(board, c, d)+1);
          c:= strtoint(copy(StepListBox.Items[b],5,1));
          d:= GetDropRow(board, c);
          MakeRedMove(board,templist);
          MakeClick(templist,'player1');
          RedChessClick(Timage(FindComponent('Image'+intTostr(8*d+c-8))));
  //        redlist.Clear;
//          blacklist.Clear;
//          updateboard;
        end
        else begin
          e:=movedlist.Add('Redpass');
          for c:=1 to 8 do
          for d:=1 to 8 do
          movedlist[e]:=movedlist[e]+intTostr(GetBoardPiece(board, c, d)+1);
        end;
      end
      else if copy(StepListBox.Items[b],1,5) = 'Black' then
      begin
        if copy(StepListBox.Items[b],7,1) <> 'p' then//p for pass
        begin
          e:=movedlist.Add('Black');
          for c:=1 to 8 do
           for d:=1 to 8 do
             movedlist[e]:=movedlist[e]+intTostr(GetBoardPiece(board, c, d)+1);

          c:= strtoint(copy(StepListBox.Items[b],7,1));
          d:= GetDropRow(board, c);
          MakeBlackMove(board,templist);
          MakeClick(templist,'player2');
          BlackChessClick(Timage(FindComponent('Image'+intTostr(8*d+c-8))));
        end
        else begin
          e:=movedlist.Add('Blackpass');
          for c:=1 to 8 do
          for d:=1 to 8 do
          movedlist[e]:=movedlist[e]+intTostr(GetBoardPiece(board, c, d)+1);
        end;
      end;
    end;

  SaveDialog1.FileName := OpenDialog1.FileName;
  notInBack:=True;
  if StepListBox.Items.Count = 0 then
  begin
    if FirstIsRed = true then
    begin
      MakeRedMove(board,templist);
      MakeClick(templist,'player1');
    end
    else begin
      MakeBlackMove(board,templist);
      MakeClick(templist,'player2');
    end;
  end;
  b := 0; c := 0;
  score(board,b,c);
  label3.Caption:=intTostr(b);
  label4.caption:=intTostr(c);
  if StepListBox.Items.Count < 2 then
    backbutton.Enabled:=False;
  notinback:=True;
  if h = 'HumanVSComputer' then
  begin
    HumanVSComputer.Click;
    h:= extractfilename(Opendialog1.FileName);
    redlabel.Caption:= copy(h,1,length(h)-4);
    blacklabel.Caption := 'Human';
  end
  else if h = 'ComputerVSHuman' then
  begin
    ComputerVSHuman.Click;
    h:= extractfilename(Opendialog1.FileName);
    blacklabel.Caption:= copy(h,1,length(h)-4);
    redlabel.Caption := 'Human';
  end
  else begin
    redlabel.Caption := 'Human';
    blacklabel.Caption := 'Human';
  end;
  Updateboard;
  templist.Free;
  end;
end;



procedure TForm1.BackButtonClick(Sender: TObject);
var a,b,c:integer;templist:Tstringlist;
begin
  if FAIThread <> nil then
  begin
    FAIThread.Terminate;
    FAIThread.WaitFor;
    FAIThread := nil;
  end;
 templist:= Tstringlist.Create;
  While true do
  begin
//    d:=True;
    a:= movedlist.count-1;

   if (copy(movedlist[a],1,7) = 'Redpass') and (copy(movedlist[a-1],1,9) <> 'Blackpass') then
       break;
   if (copy(movedlist[a],1,9) = 'Blackpass') and (copy(movedlist[a-1],1,7) <> 'Redpass') then
       break;
   if a < 2 then break;
   if (copy(movedlist[a],1,7) <> 'Redpass') and (copy(movedlist[a],1,9) <> 'Blackpass') and (copy(movedlist[a-2],1,7) <> 'Redpass') and (copy(movedlist[a-2],1,9) <> 'Blackpass') Then
     break;
    movedlist.Delete(movedlist.Count-1);
//    movedlist.Delete(movedlist.Count-1);
//    StepListBox.items.Delete(StepListBox.count-1);
    StepListBox.items.Delete(StepListBox.count-1);
  end;
  a:=movedlist.Count-2;
  if a > -1 then
  begin
    movedlist.Delete(movedlist.Count-1);
    StepListBox.items.Delete(StepListBox.count-1);
  end;
  if (StepListBox.items[StepListBox.count-1] = 'Red pass') or (StepListBox.items[StepListBox.count-3] = 'Black pass') then
  begin
   StepListBox.items.Delete(StepListBox.count-1);
   StepListBox.items.Delete(StepListBox.count-1);
   movedlist.Delete(movedlist.Count-1);
   movedlist.Delete(movedlist.Count-1);
  end;
   StepListBox.items.Delete(StepListBox.count-1);
  redlist.Clear;
  blacklist.clear;
  if movedlist.Count > 0 Then
  begin
    if copy(movedlist[movedlist.Count-1],1,3) = 'Red' Then
      a:=3//4
    else
      a:=5;//6
    for b:=1 to 8 do
    for c:=1 to 8 do
      SetBoardPiece(board, b, c, strToint(copy(movedlist[movedlist.Count-1],8*b-8+a+c,1))-1);
    if copy(movedlist[movedlist.Count-1],1,3) = 'Red' then
    begin
      MakeRedMove(board,templist);
      Makeclick(templist,'player1');
    end
    else begin
      MakeBlackMove(board,templist);
      Makeclick(templist,'player2');
    end;
  end
  else begin
    board:=initboard;
    if Firstisred then
    begin
      MakeRedMove(board,templist);
      Makeclick(templist,'player1');
    end
    else begin
      MakeBlackMove(board,templist);
      Makeclick(templist,'player2');
    end;
  end;
  movedlist.Delete(movedlist.Count-1);
  if StepListBox.items.Count < 2 then
    backbutton.Enabled:=False;
  a := 0; b := 0;
  Score(board,a,b);
  Label3.Caption:= inttostr(a);
  Label4.Caption:= inttostr(b);
  notinback:=true;
  updateboard;
  templist.Free;
end;


function TForm1.MinMaxRandom(Aboard:Tboard;SideIsRed:Boolean;depth:integer;alpha, beta: integer;var aithinkstep:TMoveArray):integer;
var a,b,bestvalue, value, best_a_move, oldAlpha:integer; moves: TMoveArray; tempboard:Tboard;
    oldaithinkstep, bestaithinkstep: TMoveArray;
    scores: array[0..63] of Integer;
    h: UInt64;
    tt_value, tt_best_move: Integer;
begin
//一般來說，這裡有一個判斷棋局是否結束的函數，
//一旦棋局結束就不必繼續搜索了，直接返回極值。
//但由於黑白棋不存在中途結束的情況，故省略。
//  bestaithinkstep:=aithinkstep;
  a := 0; b := 0;
  Score(Aboard,a,b);
  scores[0] := 0;
  FillChar(scores, SizeOf(scores), 0);

  if CheckWin(Aboard.Red) then
  begin
    if SideIsRed then Result := 2000 + depth else Result := -2000 - depth;
    exit;
  end;
  if CheckWin(Aboard.Black) then
  begin
    if SideIsRed then Result := -2000 - depth else Result := 2000 + depth;
    exit;
  end;

  h := Aboard.Hash;
  oldAlpha := alpha;
  tt_value := 0;
  tt_best_move := -2;
  if LookupTT(h, depth, alpha, beta, tt_value, tt_best_move) then
  begin
    if (tt_best_move <> -2) then
    begin
       aithinkstep.Moves[aithinkstep.Count] := tt_best_move;
       inc(aithinkstep.Count);
       tempboard := Aboard;
       if tt_best_move = -1 then tempboard.Hash := tempboard.Hash xor FZobristSide
       else if SideIsRed then RedBoardUpdate(tempboard, tt_best_move)
       else BlackBoardUpdate(tempboard, tt_best_move);
       GetPVFromTT(tempboard, not SideIsRed, depth - 1, aithinkstep);
    end;
    Exit(tt_value);
  end;

  if (depth <= 0) or (a + b > 63) then
  begin
    Result := EvaluateScore(Aboard, SideIsRed);
    exit;
  end;

  bestvalue := -INF;
  moves.Count := 0;
  if SideIsRed then FastMakeRedMove(Aboard, moves)
  else FastMakeBlackMove(Aboard, moves);

  if moves.Count > 1 then
  begin
    if depth > 4 then
    begin
      for a := 0 to moves.Count - 1 do
      begin
        tempboard := Aboard;
        if SideIsRed then RedboardUpdate(tempboard, moves.Moves[a])
        else BlackboardUpdate(tempboard, moves.Moves[a]);
        scores[a] := -EvaluateScore(tempboard, not SideIsRed);
      end;
    end
    else
    begin
      for a := 0 to moves.Count - 1 do
        scores[a] := GetMoveHeuristic(moves.Moves[a], SideIsRed);
    end;

    if (tt_best_move <> -2) and (tt_best_move <> -1) then
    begin
       for a := 0 to moves.Count - 1 do
         if moves.Moves[a] = tt_best_move then
         begin
            scores[a] := 1000000;
            break;
         end;
    end;

    FastScoresort(moves, scores);
  end;

  if moves.Count = 0 then
  begin
    if SideIsRed then FastMakeBlackMove(Aboard, moves)
    else FastMakeRedMove(Aboard, moves);

    aithinkstep.Moves[aithinkstep.Count] := -1; // PASS
    inc(aithinkstep.Count);
    Aboard.Hash := Aboard.Hash xor FZobristSide;
    value := -MinMax(Aboard, Not SideIsRed, depth, -beta, -alpha, aithinkstep);
    StoreTT(h, depth, value, TT_EXACT, -1);
    Result := value;
    exit;
  end;

  tempboard := Aboard;
  oldaithinkstep := aithinkstep;
  bestaithinkstep := aithinkstep; // Initialize with current path
  best_a_move := -2;

  for a := 0 to moves.Count - 1 do
  begin
    aithinkstep := oldaithinkstep;
    aithinkstep.Moves[aithinkstep.Count] := moves.Moves[a];
    inc(aithinkstep.Count);

    Aboard := tempboard;
    if SideIsRed then RedboardUpdate(Aboard, moves.Moves[a])
    else BlackboardUpdate(Aboard, moves.Moves[a]);

    value := -MinMax(Aboard, Not SideIsRed, depth - 1, -beta, -alpha, aithinkstep);
    if GetCurrentThreadID = MainThreadID then
      CallSyncUpdateAIUI('', '', IntToStr(value) + ':' + MoveArrayToThinkStep(aithinkstep), False, True);

    if value > bestvalue then
    begin
      bestvalue := value;
      best_a_move := moves.Moves[a];
      if value > alpha then alpha := value;
      bestaithinkstep := aithinkstep;
    end;

    if alpha >= beta then break;
  end;

  if best_a_move <> -2 then
  begin
    if bestvalue <= oldAlpha then
      StoreTT(h, depth, bestvalue, TT_UPPERBOUND, best_a_move)
    else if bestvalue >= beta then
      StoreTT(h, depth, bestvalue, TT_LOWERBOUND, best_a_move)
    else
      StoreTT(h, depth, bestvalue, TT_EXACT, best_a_move);
  end;

  aithinkstep := bestaithinkstep;
  Result := bestvalue;
end;

function TForm1.MinMax(Aboard:Tboard;SideIsRed:Boolean;depth:integer;alpha, beta: integer;var aithinkstep:TMoveArray):integer;
var a,b,bestvalue, value, best_a_move:integer;
    moves: TMoveArray;
    tempboard: Tboard;
    oldaithinkstep, bestaithinkstep: TMoveArray;
    scores: array[0..63] of Integer;
    h: UInt64;
    oldAlpha, tt_value, tt_best_move: Integer;
begin
  bestaithinkstep:=aithinkstep;
  a := 0; b := 0;
  Score(Aboard,a,b);
  moves.Count := 0;
  scores[0] := 0;
  FillChar(scores, SizeOf(scores), 0);

  if CheckWin(Aboard.Red) then
  begin
    if SideIsRed then Result := 2000 + depth else Result := -2000 - depth;
    exit;
  end;
  if CheckWin(Aboard.Black) then
  begin
    if SideIsRed then Result := -2000 - depth else Result := 2000 + depth;
    exit;
  end;

  h := Aboard.Hash;
  oldAlpha := alpha;
  tt_value := 0;
  tt_best_move := -2;
  if LookupTT(h, depth, alpha, beta, tt_value, tt_best_move) then
  begin
    if (tt_best_move <> -2) then
    begin
       aithinkstep.Moves[aithinkstep.Count] := tt_best_move;
       inc(aithinkstep.Count);
       tempboard := Aboard;
       if tt_best_move = -1 then tempboard.Hash := tempboard.Hash xor FZobristSide
       else if SideIsRed then RedBoardUpdate(tempboard, tt_best_move)
       else BlackBoardUpdate(tempboard, tt_best_move);
       GetPVFromTT(tempboard, not SideIsRed, depth - 1, aithinkstep);
    end;
    Exit(tt_value);
  end;

  if (depth <= 0) or (a + b > 63) then //葉子節點
  begin
    Result := EvaluateScore(Aboard, SideIsRed);
    exit;
  end;

  bestvalue := -INF;
  moves.Count := 0;
  if SideIsRed then FastMakeRedMove(Aboard, moves)
  else FastMakeBlackMove(Aboard, moves);

  if moves.Count > 1 then
  begin
    // Fast move ordering: sort moves based on a weighted heuristic or shallow search
    if depth > 4 then
    begin
      for a := 0 to moves.Count - 1 do
      begin
        tempboard := Aboard;
        if SideIsRed then RedboardUpdate(tempboard, moves.Moves[a])
        else BlackboardUpdate(tempboard, moves.Moves[a]);
        scores[a] := -EvaluateScore(tempboard, not SideIsRed);
      end;
    end
    else
    begin
      for a := 0 to moves.Count - 1 do
        scores[a] := GetMoveHeuristic(moves.Moves[a], SideIsRed);
    end;

    if (tt_best_move <> -2) and (tt_best_move <> -1) then
    begin
       for a := 0 to moves.Count - 1 do
         if moves.Moves[a] = tt_best_move then
         begin
            scores[a] := 1000000;
            break;
         end;
    end;

    FastScoresort(moves, scores);
  end;

  if moves.Count = 0 then
  begin
    if SideIsRed then FastMakeBlackMove(Aboard, moves)
    else FastMakeRedMove(Aboard, moves);

    if moves.Count = 0 then // both red and black no move
    begin
      Result := EvaluateScore(Aboard, SideIsRed);
      exit;
    end;
    oldaithinkstep := aithinkstep;
    aithinkstep.Moves[aithinkstep.Count] := -1; // PASS
    inc(aithinkstep.Count);
    Aboard.Hash := Aboard.Hash xor FZobristSide;
    value := -MinMax(Aboard, Not SideIsRed, depth, -beta, -alpha, aithinkstep);
    StoreTT(h, depth, value, TT_EXACT, -1);
    Result := value;
    exit;
  end;

  tempboard := Aboard;
  oldaithinkstep := aithinkstep;
  best_a_move := -2;
  for a := 0 to moves.Count - 1 do
  begin
    aithinkstep := oldaithinkstep;
    aithinkstep.Moves[aithinkstep.Count] := moves.Moves[a];
    inc(aithinkstep.Count);

    Aboard := tempboard;
    if SideIsRed then RedboardUpdate(Aboard, moves.Moves[a])
    else BlackboardUpdate(Aboard, moves.Moves[a]);

    value := -MinMax(Aboard, Not SideIsRed, depth - 1, -beta, -alpha, aithinkstep);

    if value > bestvalue then
    begin
      bestvalue := value;
      best_a_move := moves.Moves[a];
      if value > alpha then alpha := value;
      bestaithinkstep := aithinkstep;
    end;
    if alpha >= beta then break;
  end;

  if bestvalue <= oldAlpha then
    StoreTT(h, depth, bestvalue, TT_UPPERBOUND, best_a_move)
  else if bestvalue >= beta then
    StoreTT(h, depth, bestvalue, TT_LOWERBOUND, best_a_move)
  else
    StoreTT(h, depth, bestvalue, TT_EXACT, best_a_move);

  aithinkstep := bestaithinkstep;
  Result := bestvalue;
end;

function TForm1.AI(Aboard:Tboard;ComputerIsRed:Boolean):string;
var a,b,c:integer; thinkstep: TMoveArray; t1: QWord;
begin
  a := 0; b := 0;
  t1 := GetTickCount64;
  board.Hash := CalculateHash(board, ComputerIsRed); // Ensure hash is synchronized
  CallSyncUpdateAIUI('', '', '', True, False);
  thinkstep.Count := 0;
  Score(board,a,b);
  if (a+b < 64) and (TParallel.MaxThreadCount > 1) then
  begin
    Result:=muti(ComputerIsRed);
    CallSyncUpdateAIUI('', 'Time: ' + FloatToStrF((GetTickCount64 - t1) / 1000, ffFixed, 8, 2) + 's', '', False, False);
    exit;
  end;
// http://blog.csdn.net/nowcan/archive/2004/10/19/142994.aspx
// 其實所有戰術都是減低對方行動力,最後逼對方行死位.
{
  if ComputerIsRed = true then
      MakeRedMove(Aboard,templist)
  else begin
    MakeBlackMove(Aboard,templist);
  end;
  }
  //aimovelist only output next move and score
  score(Aboard,a,b);
  Realdepth:= strToint(Endgamedepth.text);
  if a+b + Realdepth >= 64 then
    Realdepth:= 64-a-b
  else
    Realdepth:= strToint(Nornaldepth.Text);
  if ComputerIsRed = true then
  begin
      MakeRedMove(Aboard,redlist);
     c:= redlist.Count;
  end
  else begin
    MakeBlackMove(Aboard,blacklist);
    c:= blacklist.Count;
  end;

     if (a + b < 46) and (c >= 4) and (Realdepth > 5) then
     begin
       a:=minMaxStart(Aboard,ComputerIsRed,Realdepth, -INF, INF, thinkstep);
     end
     else
       a:=minMaxRandom(Aboard,ComputerIsRed,Realdepth, -INF, INF, thinkstep);
  redlist.Clear;
  blacklist.Clear;
  CallSyncUpdateAIUI(intTostr(A), '', MoveArrayToThinkStep(thinkstep), False, False);

  if thinkstep.Count > 0 then
    Result := 'Image' + IntToStr(thinkstep.Moves[0])
  else
    Result := '';
  CallSyncUpdateAIUI('', 'Time: ' + FloatToStrF((GetTickCount64 - t1) / 1000, ffFixed, 8, 2) + 's', '', False, False);
end;

Procedure Tform1.Scoresort(var scorelist:Tstringlist;var stepno:Tstringlist);
var a,b:string;c,d:integer;
begin
   for d:= 1 to stepno.count-1 do
   begin
   for c:= 1 to stepno.count-1 do
   begin
     if strtoint(scorelist[c]) > strtoint(scorelist[c-1]) then
     begin
      a:= scorelist[c-1];
      b:= stepno[c-1];
      scorelist[c-1]:=  scorelist[c];
      stepno[c-1]:=  stepno[c];
      scorelist[c] := a;
      stepno[c] := b;
     end;
  end;
 end;


end;




function TForm1.MinMaxStart(Aboard:Tboard;SideIsRed:Boolean;depth:integer;alpha, beta: integer;var aithinkstep:TMoveArray):integer;
var a,b,bestvalue, value, best_a_move, oldAlpha:integer; moves: TMoveArray; tempboard:Tboard;
    scores: array[0..63] of Integer;
    best_paths: array of TMoveArray;
    current_path: TMoveArray;
    h: UInt64;
    tt_value, tt_best_move: Integer;
begin
  best_paths := nil;
  a := 0; b := 0;
  Score(Aboard,a,b);
  scores[0] := 0;
  FillChar(scores, SizeOf(scores), 0);

  if CheckWin(Aboard.Red) then
  begin
    if SideIsRed then Result := 2000 + depth else Result := -2000 - depth;
    exit;
  end;
  if CheckWin(Aboard.Black) then
  begin
    if SideIsRed then Result := -2000 - depth else Result := 2000 + depth;
    exit;
  end;

  h := Aboard.Hash;
  oldAlpha := alpha;
  tt_value := 0;
  tt_best_move := -2;
  if LookupTT(h, depth, alpha, beta, tt_value, tt_best_move) then
  begin
    if (tt_best_move <> -2) then
    begin
       aithinkstep.Moves[aithinkstep.Count] := tt_best_move;
       inc(aithinkstep.Count);
       tempboard := Aboard;
       if tt_best_move = -1 then tempboard.Hash := tempboard.Hash xor FZobristSide
       else if SideIsRed then RedBoardUpdate(tempboard, tt_best_move)
       else BlackBoardUpdate(tempboard, tt_best_move);
       GetPVFromTT(tempboard, not SideIsRed, depth - 1, aithinkstep);
    end;
    Exit(tt_value);
  end;

  if (depth <= 0) or (a + b > 63) then //葉子節點
  begin
    Result := EvaluateScore(Aboard, SideIsRed);
    exit;
  end;

  bestvalue := -INF;
  moves.Count := 0;
  if SideIsRed then FastMakeRedMove(Aboard, moves)
  else FastMakeBlackMove(Aboard, moves);

  if moves.Count > 1 then
  begin
    FillChar(scores, SizeOf(scores), 0);
    if depth > 4 then
    begin
      for a := 0 to moves.Count - 1 do
      begin
        tempboard := Aboard;
        if SideIsRed then RedboardUpdate(tempboard, moves.Moves[a])
        else BlackboardUpdate(tempboard, moves.Moves[a]);
        scores[a] := -EvaluateScore(tempboard, not SideIsRed);
      end;
    end
    else
    begin
      for a := 0 to moves.Count - 1 do
        scores[a] := GetMoveHeuristic(moves.Moves[a], SideIsRed);
    end;

    if (tt_best_move <> -2) and (tt_best_move <> -1) then
    begin
       for a := 0 to moves.Count - 1 do
         if moves.Moves[a] = tt_best_move then
         begin
            scores[a] := 1000000;
            break;
         end;
    end;

    FastScoresort(moves, scores);
  end;

  if moves.Count = 0 then
  begin
    if SideIsRed then FastMakeBlackMove(Aboard, moves)
    else FastMakeRedMove(Aboard, moves);

    if moves.Count = 0 then
    begin
      Result := EvaluateScore(Aboard, SideIsRed);
      exit;
    end;

    current_path := aithinkstep;
    current_path.Moves[current_path.Count] := -1; // PASS
    inc(current_path.Count);
    Aboard.Hash := Aboard.Hash xor FZobristSide;
    Result := -MinMaxStart(Aboard, Not SideIsRed, depth, -beta, -alpha, current_path);
    aithinkstep := current_path;
    exit;
  end;

  tempboard := Aboard;
  best_a_move := -2;
  for a := 0 to moves.Count - 1 do
  begin
    tempboard := Aboard;
    if SideIsRed then RedboardUpdate(tempboard, moves.Moves[a])
    else BlackboardUpdate(tempboard, moves.Moves[a]);

    current_path := aithinkstep;
    current_path.Moves[current_path.Count] := moves.Moves[a];
    inc(current_path.Count);

    value := -MinMax(tempboard, Not SideIsRed, depth - 1, -beta, -alpha, current_path);
    if GetCurrentThreadID = MainThreadID then
      CallSyncUpdateAIUI('', '', MoveToThinkStep(moves.Moves[a]) + ' ' + IntToStr(value), False, True);
    if value > bestvalue then
    begin
      bestvalue := value;
      best_a_move := moves.Moves[a];
      if value > alpha then alpha := value;
      SetLength(best_paths, 1);
      best_paths[0] := current_path;
    end
    else if value = bestvalue then
    begin
      SetLength(best_paths, Length(best_paths) + 1);
      best_paths[High(best_paths)] := current_path;
    end;
  end;

  if best_a_move <> -2 then
  begin
    if bestvalue <= oldAlpha then
      StoreTT(h, depth, bestvalue, TT_UPPERBOUND, best_a_move)
    else if bestvalue >= beta then
      StoreTT(h, depth, bestvalue, TT_LOWERBOUND, best_a_move)
    else
      StoreTT(h, depth, bestvalue, TT_EXACT, best_a_move);
  end;

  if Length(best_paths) > 0 then
  begin
    a := Random(Length(best_paths));
    aithinkstep := best_paths[a];
  end;
  Result := bestvalue;
end;



function TForm1.ThinkNumber(Aboard:Tboard;SideIsRed:Boolean;depth:integer):integer;
var a,b:integer; moves: TMoveArray; tempboard:Tboard;
begin
  Result := 0;
  a := 0; b := 0;
  Score(Aboard, a, b);

  if a = 0 then exit;
  if b = 0 then exit;

  if (depth <= 0) or (a + b > 63) then exit;

  moves.Count := 0;
  if SideIsRed then FastMakeRedMove(Aboard, moves)
  else FastMakeBlackMove(Aboard, moves);

  if moves.Count = 0 then
  begin
    if SideIsRed then FastMakeBlackMove(Aboard, moves)
    else FastMakeRedMove(Aboard, moves);

    if moves.Count = 0 then
    begin
      Result := 1;
      exit;
    end;
    Result := 1;
    exit;
  end;

  if depth = realdepth - 1 then
  begin
    Result := moves.Count;
    exit;
  end;

  tempboard := Aboard;
  for a := 0 to moves.Count - 1 do
  begin
    Aboard := tempboard;
    if SideIsRed then RedboardUpdate(Aboard, moves.Moves[a])
    else BlackboardUpdate(Aboard, moves.Moves[a]);
    Result := Result + ThinkNumber(Aboard, Not SideIsRed, depth - 1);
  end;
end;
procedure TForm1.StepListBoxClick(Sender: TObject);
var a, b, c, targetIdx: Integer;
    templist: TStringList;
    nextTurn: string;
begin
  if (StepListBox.ItemIndex < 0) or
     (StepListBox.ItemIndex >= StepListBox.Items.Count - 1) then Exit;

  if FAIThread <> nil then
  begin
    FAIThread.Terminate;
    FAIThread.WaitFor;
    FAIThread := nil;
  end;

  targetIdx := StepListBox.ItemIndex;

  // We want to restore the state resulting from move targetIdx.
  // This state is stored in movedlist[targetIdx + 1].

  // 1. Restore board from movedlist[targetIdx + 1]
  nextTurn := movedlist[targetIdx + 1];
  if copy(nextTurn, 1, 9) = 'Blackpass' then a := 9
  else if copy(nextTurn, 1, 7) = 'Redpass' then a := 7
  else if copy(nextTurn, 1, 5) = 'Black' then a := 5
  else if copy(nextTurn, 1, 3) = 'Red' then a := 3
  else Exit;

  for b := 1 to 8 do
    for c := 1 to 8 do
      SetBoardPiece(board, b, c, StrToInt(copy(nextTurn, 8*b-8+a+c, 1)) - 1);

  board.Hash := CalculateHash(board, (copy(nextTurn, 1, 3) = 'Red') or (copy(nextTurn, 1, 7) = 'Redpass'));

  // 2. Truncate history
  while StepListBox.Items.Count > targetIdx + 1 do
    StepListBox.Items.Delete(StepListBox.Items.Count - 1);
  while movedlist.Count > targetIdx + 1 do
    movedlist.Delete(movedlist.Count - 1);

  // 3. Update UI and recalculate moves
  templist := TStringList.Create;
  if (copy(nextTurn, 1, 3) = 'Red') or (copy(nextTurn, 1, 7) = 'Redpass') then
  begin
    MakeRedMove(board, templist);
    MakeClick(templist, 'player1');
  end
  else begin
    MakeBlackMove(board, templist);
    MakeClick(templist, 'player2');
  end;

  if StepListBox.Items.Count < 2 then
    BackButton.Enabled := False;

  a := 0; b := 0;
  Score(board, a, b);
  Label3.Caption := IntToStr(a);
  Label4.Caption := IntToStr(b);
  notinback := True;
  Updateboard;

  // 4. Trigger AI if necessary
  if ComputerVsHuman.Checked and (templist.Count > 0) then
  begin
    if (copy(nextTurn, 1, 3) = 'Red') or (copy(nextTurn, 1, 7) = 'Redpass') then StartAI(True);
  end;
  if HumanVsComputer.Checked and (templist.Count > 0) then
  begin
    if (copy(nextTurn, 1, 5) = 'Black') or (copy(nextTurn, 1, 9) = 'Blackpass') then StartAI(False);
  end;

  templist.Free;
end;

procedure TForm1.TojavaboardbuttonClick(Sender: TObject);
var F:Textfile;s,t,u:string;a:integer;
begin
  SaveDialog1.FileName := '*.htm';
  SaveDialog1.Filter := 'Apple game Java (*.htm)|*.HTM';

  if SaveDialog1.Execute then
  begin
    Assignfile(F,SaveDialog1.FileName);
    Rewrite(f);
    Writeln(f,'<HTML>');
    Writeln(f,'<Center>');
    Writeln(f,'<APPLET width="284" height="331" codebase="http://home.i-cable.com/wu/java/" code="JavaReversi">');
    Writeln(f,'<PARAM name="Position" value="'+boardtofen+'">');
    If FirstIsRed then
      Writeln(f,'<PARAM name="MoveFirst" value="Red">')
    else
      Writeln(f,'<PARAM name="MoveFirst" value="Black">');
   s:='';
   for a := 0 to StepListBox.Count - 1 do
   begin
     t := '';
     if copy(StepListBox.Items[a],1,3) = 'Red'  then
       t := copy(StepListBox.Items[a],5,3)
     else if copy(StepListBox.Items[a],1,5) = 'Black'  then
       t := copy(StepListBox.Items[a],7,3);
     if a =  StepListBox.Count - 2 then
     begin
       if (StepListBox.items[a] = 'Red pass') and (StepListBox.items[a+1] = 'Black pass') or (StepListBox.items[a] = 'Black pass') and (StepListBox.items[a+1] = 'Red pass') then
         break;
     end;
     if copy(t,1,1) = 'p' then
        s:=s + ' P'
     Else begin
       u:= copy(t,1,1);
       t:= copy(t,3,1);
       if a = 0 then
          s := char(strtoint(u)+64)+t
       else
         s := s+ ' '+char(strtoint(u)+64)+t;
     end;

   end;

    Writeln(f,'<PARAM name="MoveList" value="'+s+'">');
    Writeln(f,'</HTML>');
    Writeln(f,'</Center>');
    Closefile(f);
  end;

end;

function Tform1.InternalEvaluate(const Aboard:Tboard;const SideIsRed:Boolean):Integer; inline;
var
  red_win, black_win: Boolean;
  temp: UInt64;
  red_3, red_2, black_3, black_2: Integer;
begin
  red_win := CheckWin(Aboard.Red);
  black_win := CheckWin(Aboard.Black);

  if red_win then
  begin
     if SideIsRed then Result := 2000 else Result := -2000;
     Exit;
  end;
  if black_win then
  begin
     if SideIsRed then Result := -2000 else Result := 2000;
     Exit;
  end;

  // Sum GNU Linetris evaluation: prioritize line formation.
  // We reward 3-in-a-row and 2-in-a-row.

  // Red 3-in-a-row
  red_3 := 0;
  temp := Aboard.Red and (Aboard.Red shl 8) and (Aboard.Red shl 16);
  red_3 := red_3 + PopCount(temp);
  temp := Aboard.Red and (Aboard.Red shl 1) and (Aboard.Red shl 2) and $FCFCFCFCFCFCFCFC;
  red_3 := red_3 + PopCount(temp);
  temp := Aboard.Red and (Aboard.Red shl 9) and (Aboard.Red shl 18) and $FCFCFCFCFCFCFCFC;
  red_3 := red_3 + PopCount(temp);
  temp := Aboard.Red and (Aboard.Red shl 7) and (Aboard.Red shl 14) and $3F3F3F3F3F3F3F3F;
  red_3 := red_3 + PopCount(temp);

  // Black 3-in-a-row
  black_3 := 0;
  temp := Aboard.Black and (Aboard.Black shl 8) and (Aboard.Black shl 16);
  black_3 := black_3 + PopCount(temp);
  temp := Aboard.Black and (Aboard.Black shl 1) and (Aboard.Black shl 2) and $FCFCFCFCFCFCFCFC;
  black_3 := black_3 + PopCount(temp);
  temp := Aboard.Black and (Aboard.Black shl 9) and (Aboard.Black shl 18) and $FCFCFCFCFCFCFCFC;
  black_3 := black_3 + PopCount(temp);
  temp := Aboard.Black and (Aboard.Black shl 7) and (Aboard.Black shl 14) and $3F3F3F3F3F3F3F3F;
  black_3 := black_3 + PopCount(temp);

  // Red 2-in-a-row
  red_2 := 0;
  temp := Aboard.Red and (Aboard.Red shl 8);
  red_2 := red_2 + PopCount(temp);
  temp := Aboard.Red and (Aboard.Red shl 1) and $FEFEFEFEFEFEFEFE;
  red_2 := red_2 + PopCount(temp);
  temp := Aboard.Red and (Aboard.Red shl 9) and $FEFEFEFEFEFEFEFE;
  red_2 := red_2 + PopCount(temp);
  temp := Aboard.Red and (Aboard.Red shl 7) and $7F7F7F7F7F7F7F7F;
  red_2 := red_2 + PopCount(temp);

  // Black 2-in-a-row
  black_2 := 0;
  temp := Aboard.Black and (Aboard.Black shl 8);
  black_2 := black_2 + PopCount(temp);
  temp := Aboard.Black and (Aboard.Black shl 1) and $FEFEFEFEFEFEFEFE;
  black_2 := black_2 + PopCount(temp);
  temp := Aboard.Black and (Aboard.Black shl 9) and $FEFEFEFEFEFEFEFE;
  black_2 := black_2 + PopCount(temp);
  temp := Aboard.Black and (Aboard.Black shl 7) and $7F7F7F7F7F7F7F7F;
  black_2 := black_2 + PopCount(temp);

  if SideIsRed then
    Result := (red_3 - black_3) * 100 + (red_2 - black_2) * 10
  else
    Result := (black_3 - red_3) * 100 + (black_2 - red_2) * 10;
end;

function Tform1.EvaluateScore(const Aboard:Tboard;const SideIsRed:Boolean):Integer;
begin
  Result := InternalEvaluate(Aboard, SideIsRed);
end;

procedure TForm1.BatchEvaluateOnAVX512(const Boards: array of Tboard; const SideIsRed: Boolean; var Scores: array of Integer);
var
  i: Integer;
begin
  for i := 0 to High(Boards) do
    Scores[i] := InternalEvaluate(Boards[i], SideIsRed);
end;


end.
