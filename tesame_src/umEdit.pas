{**************************************************}
{           umEdit Component's set.                }
{ (umEdit, ValidEdit, NumberEdit, IPEdit)          }
{                                                  }
{  E-Mail:    info@utilmind.com                    }
{  Home Page: www.utilmind.com                     }
{  Copyright © 1999-2000, UtilMind Solutions       }
{                                                  }
{**************************************************}
{                                                  }
{ 1. umEdit - like standard TEdit component but    }
{    have "Alignment" and "ColorDisabled" (color   }
{    when component is disabled) properties.       }
{ 2. umValidEdit - improved umEdit component with  }
{    possiblity of setting the symbols permitted   }
{    for input.                                    }
{    For example, if you want to permit numbers    }
{    only for input - set a ValidChars line as     }
{    "0123456789".                                 }
{ 3. umNumberEdit - component for input of the     }
{    numerical values (decimal, hexadecimal,       }
{    octal and binary values).                     }
{ 4. umIPEdit - 100% native Delphi component for   }
{    edution of the IP addresses (looks and feels  }
{    like COM control from IE4 but without DLLs).  }
{                                                  }
{**************************************************}
{  History:                                        }
{   8 jul 1999 - Ver 1.0 First release....         }
{  16 jul 1999 - Ver 1.1 Fixed bug in              }
{             TumNumberEdit when Kind = neDec.     }
{   5 jun 2000 - Ver 1.2 Added IPEdit component    }
{*************************************************************}
{                     IMPORTANT NOTE:                         }
{ This software is provided 'as-is', without any express or   }
{ implied warranty. In no event will the author be held       }
{ liable for any damages arising from the use of this         }
{ software.                                                   }
{ Permission is granted to anyone to use this software for    }
{ any purpose, including commercial applications, and to      }
{ alter it and redistribute it freely, subject to the         }
{ following restrictions:                                     }
{ 1. The origin of this software must not be misrepresented,  }
{    you must not claim that you wrote the original software. }
{    If you use this software in a product, an acknowledgment }
{    in the product documentation would be appreciated but is }
{    not required.                                            }
{ 2. Altered source versions must be plainly marked as such,  }
{    and must not be misrepresented as being the original     }
{    software.                                                }
{ 3. This notice may not be removed or altered from any       }
{    source distribution.                                     }
{*************************************************************}


unit umEdit;

{$IFDEF VER80}  {$DEFINE Delphi3andLower} {$ENDIF}
{$IFDEF VER90}  {$DEFINE Delphi3andLower} {$ENDIF}
{$IFDEF VER93}  {$DEFINE Delphi3andLower} {$ENDIF}
{$IFDEF VER100} {$DEFINE Delphi3andLower} {$ENDIF}
{$IFDEF VER110} {$DEFINE Delphi3andLower} {$ENDIF}

{$IFNDEF Delphi3andLower}
  {$DEFINE Delphi4andHigher}
{$ENDIF}

interface

uses
  {$IFDEF Win32} Windows, {$Else Win32} WinTypes, WinProcs, {$ENDIF Win32}
  Messages, SysUtils, StdCtrls, Classes, Controls, Graphics, Forms;

type
  TumEdit = class(TEdit)
  private
    FColorDisabled: TColor;
    FFocused: Boolean;

    procedure SetColorDisabled(Value: TColor);

    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit (var Message: TCMExit ); message CM_EXIT;
  protected
    fCanvas    : TControlCanvas;
    fAlignment : TAlignment;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Change; override;
    function  GetTextMargins: TPoint;
    procedure SetAlignment(A: TAlignment); virtual;
    procedure SetFocused(A: Boolean); virtual;
    function  GetCanvas: TCanvas; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Canvas: TCanvas read GetCanvas;
  published
    property Alignment: TAlignment read FAlignment write SetAlignment default taLeftJustify;
    property ColorDisabled: TColor read FColorDisabled write SetColorDisabled;
  end;

  TumValidEdit = class(TumEdit)
  private
    fValidChars    : String;
    fValidateChars : Boolean;
    procedure WMChar(var Msg : TWMChar); message WM_CHAR;
  public
    constructor Create(AOwner : TComponent);                           override;
  published
    property ValidChars: String read fValidChars write fValidChars;
    property ValidateChars: Boolean read fValidateChars write fValidateChars default True;
  end;

  TumNumberEditKind = (neDec, neHex, neBin);
  TumNumberEdit = class(TumEdit)
  private
    FOnChange: TNotifyEvent;
    procedure WMChar(var Msg: TWMChar); message WM_CHAR;
  protected
    fKind: TumNumberEditKind;
    fValue: LongInt;
    fMaxValue: LongInt;
    fValidChars: String;
    PrevText: String;
    PrevValue: LongInt;
    PrevPos: Integer;

    procedure NChanged(Sender: TObject);
    procedure SetValue(aValue: LongInt); virtual;
    procedure SetMaxValue(aValue: LongInt); virtual;
    procedure SetKind(aValue: TumNumberEditKind); virtual;
  public
    constructor Create(AOwner : TComponent);                           override;
  published
    property Kind: TumNumberEditKind read fKind write SetKind default neDec;
    property MaxValue: LongInt read fMaxValue write SetMaxValue;
    property Value: LongInt read fValue write  SetValue;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

type
  TumIPMaskEdit = class(TCustomEdit)
  private
    FFocused: Boolean;

    procedure ClickHook(Sender: TObject);
    procedure DblClickHook(Sender: TObject);
    procedure KeyDownHook(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure KeyPressHook(Sender: TObject; var Key: Char);
    procedure KeyUpHook(Sender: TObject; var Key: Word; Shift: TShiftState);

    procedure WMChar(var Msg: TWMChar); message wm_Char;
    procedure WMPaint(var Msg: TWMPaint); message wm_Paint;
    procedure CMEnter(var Msg: TCMEnter); message cm_Enter;
    procedure CMExit(var Msg: TCMExit); message cm_Exit;
  protected
    FCanvas: TControlCanvas;
    FAlignment: TAlignment;

    procedure Change; override;

    function GetTextMargins: TPoint;
    procedure SetAlignment(A: TAlignment); virtual;
    procedure SetFocused (A: Boolean); virtual;
    function GetCanvas: TCanvas; virtual;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Alignment: TAlignment read FAlignment write SetAlignment;  
  end;

  TumIPEdit = class(TWinControl)
  private
    FAlignment: TAlignment;
    FAutoSize: Boolean;
    FCanvas: TCanvas;
    FColor: TColor;
    FColorDisabled: TColor;
    FCtl3D: Boolean;
    FBorderStyle: TBorderStyle;
    FEnabled: Boolean;
    FText: String;
    FIP1, FIP2, FIP3, FIP4: Byte;
    FIPLong: LongInt;
    FIPSection: Array[1.. 4] of TumIPMaskEdit;

    FOnChange: TNotifyEvent;
    FOnKeyDown, FOnKeyUp: TKeyEvent;
    FOnKeyPress: TKeyPressEvent;

    procedure SetAlignment(Value: TAlignment);
    procedure SetAutoSize(Value: Boolean);
    procedure SetBorderStyle(Value: TBorderStyle);
    procedure SetColor(Value: TColor);
    procedure SetColorDisabled(Value: TColor);
    procedure SetCtl3D(Value: Boolean);
    procedure SetEnabled(Value: Boolean);
    procedure SetText(Value: String);
    procedure RefreshText;
    procedure SetIP1(Value: Byte);
    procedure SetIP2(Value: Byte);
    procedure SetIP3(Value: Byte);
    procedure SetIP4(Value: Byte);
    procedure SetIPLong(Value: LongInt);

    procedure ValueChanged;

    procedure WMSetFocus(var Msg: TWMSetFocus); message wm_SetFocus;
    procedure WMPaint(var Msg: TWMPaint); message wm_Paint;
  protected
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Alignment: TAlignment read FAlignment write SetAlignment;
    property AutoSize: Boolean read FAutoSize write SetAutoSize;
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle;
    property Color: TColor read FColor write SetColor;
    property ColorDisabled: TColor read FColorDisabled write SetColorDisabled;
    property Ctl3D: Boolean read FCtl3D write SetCtl3D;
    property Enabled: Boolean read FEnabled write SetEnabled;
    property IP1: Byte read FIP1 write SetIP1;
    property IP2: Byte read FIP2 write SetIP2;
    property IP3: Byte read FIP3 write SetIP3;
    property IP4: Byte read FIP4 write SetIP4;
    property IPLong: LongInt read FIPLong write SetIPLong;
    property Text: String read FText write SetText;

    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnKeyDown: TKeyEvent read FOnKeyDown write FOnKeyDown;
    property OnKeyPress: TKeyPressEvent read FOnKeyPress write FOnKeyPress;
    property OnKeyUp: TKeyEvent read FOnKeyUp write FOnKeyUp;

    // inherited properties
{$IFDEF Delphi4andHigher}
    property Anchors;
{$ENDIF}
    property Cursor;
    property Font;
    property Hint;
    property ShowHint;    
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property TabOrder;
    property TabStop;
    property Visible;

    property OnClick;
    property OnDblClick;
    property OnEnter;
    property OnExit;
  end;


{ BONUS numerical transformation routines}
function DecToHex(aValue: LongInt): String;
function HexToDec(aValue: String ): LongInt;
function DecToBin(aValue: LongInt): String;
function BinToDec(aValue: String ): LongInt;


procedure Register;

implementation

uses WinSock;

{ BONUS numerical transformation routines}

function DecToHex(aValue : LongInt) : String;
var
  w: Array[1..2] of Word absolute aValue;
  St: String;

  function HexByte(b: Byte): String;
  const
    Hex: Array[$0..$F] of Char = '0123456789ABCDEF';
  begin
    HexByte := Hex[b shr 4] + Hex[b and $F];
  end;

  function HexWord(w: Word): String;
  begin
    HexWord := HexByte(Hi(w)) + HexByte(Lo(w));
  end;

begin
  St := HexWord(w[2]) + HexWord(w[1]);
  while (St[1] = '0') and (Length(St) > 1) do
   Delete(St, 1, 1);
  Result := St;
end;

function HexToDec(aValue: String): LongInt;
var
  l: LongInt;
  b: Byte;
begin
  Result := 0;
  if Length(aValue) <> 0 then
   begin
     l := 1;
     b := Length(aValue) + 1;
     repeat
      dec(b);
      if aValue[b] <= '9' then Result := Result + (Byte(aValue[b]) - 48) * l
      else Result := Result + (Byte(aValue[b]) - 55) * l;
      l := l * 16;
     until b = 1;
   end;
end;

function DecToBin(aValue: LongInt): String;
var
  w: Array[1..2] of Word absolute aValue;
  St: String;

  function BinByte(b: Byte): String;
  const
    Bin: array[False..True] of Char = '01';
  begin
    Result := Bin[b and 128 = 128] + Bin[b and 64 = 64] + Bin[b and 32 = 32] + Bin[b and 16 = 16] +
              Bin[b and 8 = 8] + Bin[b and 4 = 4] + Bin[b and 2 = 2] + Bin[b and 1 = 1];
  end;

  function BinWord(w: Word) : String;
  begin
    BinWord := BinByte(Hi(w)) + BinByte(Lo(w));
  end;

begin
  St := BinWord(w[2]) + BinWord(w[1]);
  while (St[1] = '0') and (Length(St) > 1) do
   Delete(St, 1, 1);
  Result := St;
end;

function BinToDec(aValue : String) : LongInt;
var
  l : LongInt;
  b : Byte;
begin
  Result := 0;
  if Length(aValue) = 0
   then Exit;

  l := 1;
  b := Length(aValue) + 1;
  repeat
   dec(b);
   if aValue[b] = '1'
    then Result := Result + l;
   l := l shl 1;
  until b = 1;
end;

{ Stuctures needed for IPEdit }
type
  SunB = packed record
    s_b1, s_b2, s_b3, s_b4: Char;
  end;

  SunW = packed record
    s_w1, s_w2: Word;
  end;

  in_addr = record
    case Integer of
      0: (S_un_b: SunB);
      1: (S_un_w: SunW);
      2: (S_addr: LongInt);
  end;

{ TumEdit }

constructor TumEdit.Create(AOwner: TComponent);
begin
  FAlignment := taLeftJustify;

  inherited Create(AOwner);
  FCanvas := TControlCanvas.Create;
  FCanvas.Control := Self;
  FColorDisabled := clWindow; // though I prefer clBtnFace;
end;

destructor TumEdit.Destroy;
begin
  fCanvas.Free;
  inherited Destroy;
end;

procedure TumEdit.Notification(AComponent: TComponent;
                               Operation : TOperation);
begin
  inherited Notification(AComponent, Operation);
end;

procedure TumEdit.Change;
begin
  inherited Change;
{  Invalidate; {!!! WARNING Bug on loosing focus (KARPOLAN)}
end;

function TumEdit.GetTextMargins : TPoint;
var
  DC       : HDC;
  SaveFont : HFont;
  i        : Integer;
  SysMetrics, Metrics : TTextMetric;
begin
  if NewStyleControls then
   begin
    if BorderStyle = bsNone then i := 0
    else
     if Ctl3D then i := 1
     else i := 2;
    Result.X := SendMessage(Handle, EM_GETMARGINS, 0, 0) and $0000FFFF + i;
    Result.Y := i;
   end
  else
   begin
     if BorderStyle = bsNone then i := 0
     else
      begin
       DC := GetDC(0);
       GetTextMetrics(DC, SysMetrics);
       SaveFont := SelectObject(DC, Font.Handle);
       GetTextMetrics(DC, Metrics);
       SelectObject(DC, SaveFont);
       ReleaseDC(0, DC);
       i := SysMetrics.tmHeight;
       if i > Metrics.tmHeight then i := Metrics.tmHeight;
       i := i div 4;
      end;
     Result.X := i;
     Result.Y := i;
   end;
end;

procedure TumEdit.SetAlignment(A : TAlignment);
begin
  if fAlignment = A then Exit;
  fAlignment := A;
  Invalidate;
end;

procedure TumEdit.SetFocused(A : Boolean);
begin
  if FFocused = A then Exit;
  FFocused := A;
{  Invalidate; {!!! WARNING Bug on loosing focus (KARPOLAN)}
end;

function TumEdit.GetCanvas: TCanvas;
begin
  Result := TCanvas(fCanvas);
end;

procedure TumEdit.SetColorDisabled(Value: TColor);
begin
  if FColorDisabled <> Value then
   begin
    FColorDisabled := Value;
    Invalidate;
   end;
end;

procedure TumEdit.WMPaint(var Message : TWMPaint);
{$IFDEF Delphi4andHigher}
const
  AlignStyle : Array[Boolean, TAlignment] Of DWord =
   ((WS_EX_LEFT , WS_EX_RIGHT, WS_EX_LEFT),
    (WS_EX_RIGHT, WS_EX_LEFT , WS_EX_LEFT));
{$ENDIF Delphi4andHigher}
var
  ALeft       : integer;
  Margins     : TPoint;
  R           : TRect;
  DC          : HDC;
  PS          : TPaintStruct;
  strText     : String;
  AAlignment  : TAlignment;
{$IFDEF Delphi4andHigher}
  ExStyle     : DWord;
{$ENDIF Delphi4andHigher}

  procedure TryToPaint;
  begin
    fCanvas.Font := Font;
    with fCanvas do
     begin
       R := ClientRect;
       if not (NewStyleControls and Ctl3D) and (BorderStyle = bsSingle) then
        begin
          Brush.Color := clWindowFrame;
          FrameRect(R);
          InflateRect(R, -1, -1);
        end;
       if Enabled then
         Brush.Color := Color
       else
         Brush.Color := ColorDisabled; 
       if not Enabled then Font.Color := clGrayText;
       strText := Text;
       if (csPaintCopy in ControlState) then
        begin
          case CharCase of
           ecUpperCase: strText := AnsiUpperCase(strText);
           ecLowerCase: strText := AnsiLowerCase(strText);
          end;
        end;
       if PasswordChar <> #0
        then FillChar(strText[1], Length(strText), PasswordChar);
       Margins := GetTextMargins;
       case AAlignment of
         taLeftJustify: ALeft := Margins.X;
         taRightJustify: ALeft := ClientWidth - TextWidth(strText) - Margins.X - 1;
         else ALeft := (ClientWidth - TextWidth(strText)) div 2;
        end;

{$IFDEF Delphi4andHigher}
       if SysLocale.MiddleEast then UpdateTextFlags;
{$ENDIF Delphi4andHigher}

       TextRect(R, ALeft, Margins.Y, strText);
     end;
  end;

  procedure PaintDefault;
  begin
    DC := Message.DC;
    if DC = 0 then DC := beginPaint(Handle, PS);
    fCanvas.Handle := DC;
    try
      TryToPaint;
    finally
      fCanvas.Handle := 0;
      if Message.DC = 0 then endPaint(Handle, PS);
    end;
  end;

begin
{** Alignment depend Focused state **}
  if FFocused then AAlignment := taLeftJustify
  else AAlignment := FAlignment;

{$IFDEF Delphi4andHigher}
{** Update RightToLeftAlignment **}
  if UseRightToLeftAlignment then
    ChangeBiDiModeAlignment(AAlignment);
    
  if SysLocale.MiddleEast and HandleAllocated and (IsRightToLeft) then
   begin { This keeps the right aligned text, right aligned }
    ExStyle := DWORD(GetWindowLong(Handle, GWL_EXSTYLE)) and (not WS_EX_RIGHT) and
              (not WS_EX_RTLReadING) and (not WS_EX_LEFTSCROLLBAR);
    if UseRightToLeftReading then ExStyle := ExStyle or WS_EX_RTLReadING;
    if UseRightToLeftScrollbar then ExStyle := ExStyle or WS_EX_LEFTSCROLLBAR;
    ExStyle := ExStyle or AlignStyle[UseRightToLeftAlignment, AAlignment];
    if DWORD(GetWindowLong(Handle, GWL_EXSTYLE)) <> ExStyle then
     SetWindowLong(Handle, GWL_EXSTYLE, ExStyle);
   end;
{$ENDIF Delphi4andHigher}

  PaintDefault;
  inherited;
end;

procedure TumEdit.CMEnter(var Message : TCMEnter);
begin
  SetFocused(True);
  inherited;
end;

procedure TumEdit.CMExit(var Message : TCMExit);
begin
  inherited;
  SetFocused(False);
  Invalidate;
end;


{ TumValidEdit }

constructor TumValidEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fValidateChars := True;
end;

procedure TumValidEdit.WMChar(var Msg: TWMChar);
var
  i: Integer;
begin
  if ValidateChars and (Char(Msg.CharCode) <> #8) then
   begin
    i := Length(FValidChars);
    if i <> 0 then
     for i := 1 to i do
      if fValidChars[i] = Char(Msg.CharCode) then inherited
   end
  else inherited;
end;

{ TumNumberEdit }

constructor TumNumberEdit.Create(AOwner : TComponent);
begin
  SetKind(neDec);
  inherited Create(AOwner);
  Text := '0';
  inherited OnChange := NChanged;
end;

procedure TumNumberEdit.NChanged(Sender : TObject);
label ex;
var
  l: LongInt;
  St: String;
  Error: Boolean;
begin
  if (csDesigning in ComponentState) then Exit;

  if (csLoading in ComponentState) or
     (csReading in ComponentState) then Exit;

  if Text = '' then
   begin
    FValue := 0;
    goto ex;
   end;

  l := 0;

  if FKind = neDec then
   begin
    Error := False;
    try
      l := StrToInt(Text)
    except
      Error := True;
      Text := PrevText;
      SelStart := PrevPos;
      SelLength := 0;
    end;
    if Error then goto ex;
   end
  else
   if FKind = neHex then l := HexToDec(Text)
   else l := BinToDec(Text);

  if FMaxValue <> 0 then
   begin
     if FKind = neDec then St := IntToStr(FMaxValue)
     else
      if FKind = neHex then St := DecToHex(FMaxValue)
      else St := DecToBin(FMaxValue);

     if (l > FMaxValue) or (l < 0) or (Length(Text) > Length(St)) or
        ((Length(Text) = Length(St)) and (Text > St)) then
      begin
        Text := PrevText;
        SelStart := PrevPos;
        SelLength := 0;
        goto ex;
      end;
   end;

  FValue := l;
  PrevText := Text;
  PrevValue := FValue;

ex:
  if Assigned(FOnChange)
   then FOnChange(Sender);
end;


procedure TumNumberEdit.SetValue(aValue : LongInt);
begin
  if aValue < 0 then aValue := 0
  else
   if (FMaxValue <> 0) and (aValue > FMaxValue) then
    aValue := FMaxValue;

  FValue := aValue;
  if (Kind = neHex) then Text := DecToHex(aValue)
  else
   if (Kind = neDec) then Text := IntToStr(aValue)
   else Text := DecToBin(aValue)
end;

procedure TumNumberEdit.SetMaxValue(aValue : LongInt);
begin
  FMaxValue := aValue;
  if (FMaxValue <> 0) and (FValue > FMaxValue) then
    Value := FMaxValue;
end;

procedure TumNumberEdit.SetKind(aValue : TumNumberEditKind);
begin
  FKind := aValue;
  if aValue = neDec then FValidChars := '0123456789'
  else
   if aValue = neHex then FValidChars := '0123456789abcdefABCDEF'
   else
    if aValue = neBin then FValidChars := '01'
    else FValidChars := '01234567';  {** Octacl **}
end;

procedure TumNumberEdit.WMChar(var Msg : TWMChar);
var
  i : Integer;
begin
  PrevText  := Text;
  PrevValue := FValue;
  PrevPos   := SelStart;
  if Char(Msg.CharCode) = #8 then inherited
  else
   begin
    i := Length(FValidChars);
    if i <> 0 then
     for i := 1 to i do
      if FValidChars[i] = Char(Msg.CharCode) then
       inherited
   end;
end;

// TumIPMaskEdit

constructor TumIPMaskEdit.Create(aOwner: TComponent);
begin
  inherited;
  FCanvas := TControlCanvas.Create;
  FCanvas.Control := Self;

  OnClick := ClickHook;
  OnDblClick := DblClickHook;
  OnKeyDown := KeyDownHook;
  OnKeyPress := KeyPressHook;
  OnKeyUp := KeyUpHook;
end;

destructor TumIPMaskEdit.Destroy;
begin
  FCanvas.Free;
  inherited;
end;

procedure TumIPMaskEdit.Change;
begin
  inherited;
  try
    TumIPEdit(Parent).ValueChanged;
  except
  end;
end;

function TumIPMaskEdit.GetTextMargins: TPoint;
var
  DC: hDC;
  SaveFont: hFont;
  i: Integer;
  SysMetrics, Metrics: TTextMetric;
begin
  if NewStyleControls then
   begin
    if BorderStyle = bsNone then i := 0
    else
     if Ctl3D then i := 1
     else i := 2;
    Result.X := SendMessage(Handle, EM_GETMARGINS, 0, 0) and $0000FFFF + i;
    Result.Y := i;
   end
  else
   begin
    if BorderStyle = bsNone then i := 0
    else
     begin
      DC := GetDC(0);
      GetTextMetrics(DC, SysMetrics);
      SaveFont := SelectObject(DC, Font.Handle);
      GetTextMetrics(DC, Metrics);
      SelectObject(DC, SaveFont);
      ReleaseDC(0, DC);
      i := SysMetrics.tmHeight;
      if i > Metrics.tmHeight then i := Metrics.tmHeight;
      i := i div 4;
     end;
    Result.X := i;
    Result.Y := i;
   end;
end;

procedure TumIPMaskEdit.SetAlignment(A: TAlignment);
begin
  if FAlignment = A then Exit;
  FAlignment := A;
  Invalidate;
end;

procedure TumIPMaskEdit.SetFocused(A: Boolean);
begin
  if FFocused = A then Exit;
  FFocused := A;
end;

function TumIPMaskEdit.GetCanvas: TCanvas;
begin
  Result := TCanvas(FCanvas);
end;

procedure TumIPMaskEdit.ClickHook(Sender: TObject);
begin
  try
    if Assigned(TumIPEdit(Parent).OnClick) then
     TumIPEdit(Parent).OnClick(Sender);
  except
  end;
end;

procedure TumIPMaskEdit.DblClickHook(Sender: TObject);
begin
  try
    if Assigned(TumIPEdit(Parent).OnDblClick) then
     TumIPEdit(Parent).OnDblClick(Sender);
  except
  end;
end;

procedure TumIPMaskEdit.KeyDownHook(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  try
    if Assigned(TumIPEdit(Parent).FOnKeyDown) then
     TumIPEdit(Parent).FOnKeyDown(Sender, Key, Shift);
  except
  end;
end;

procedure TumIPMaskEdit.KeyPressHook(Sender: TObject; var Key: Char);
begin
  try
    if Assigned(TumIPEdit(Parent).FOnKeyPress) then
     TumIPEdit(Parent).FOnKeyPress(Sender, Key);
  except
  end;
end;

procedure TumIPMaskEdit.KeyUpHook(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  try
    if Assigned(TumIPEdit(Parent).FOnKeyUp) then
     TumIPEdit(Parent).FOnKeyUp(Sender, Key, Shift);
  except
  end;
end;

procedure TumIPMaskEdit.WMChar(var Msg: TWMChar);
var
  St: String;
  i, Code: Integer;
begin
  if ((Char(Msg.CharCode) >= '0') and (Char(Msg.CharCode) <= '9')) or
     (Char(Msg.CharCode) = #8) then
   begin
    St := Text + Char(Msg.CharCode);
    {$R-} Val(St, i, Code);  {$R+}
    if i <= 255 then inherited;
   end;
end;

procedure TumIPMaskEdit.WMPaint(var Msg: TWMPaint);
var
  ALeft: Integer;
  Margins: TPoint;
  R: TRect;
  DC: HDC;
  PS: TPaintStruct;
  strText: String;
  AAlignment: TAlignment;

  procedure TryToPaint;
  begin
    FCanvas.Font := Font;
    with FCanvas do
     begin
       R := ClientRect;
       if not (NewStyleControls and Ctl3D) and (BorderStyle = bsSingle) then
        begin
         Brush.Color := clWindowFrame;
         FrameRect(R);
         InflateRect(R, -1, -1);
        end;
       Brush.Color := Color;
       if not Enabled then Font.Color := clGrayText;
       strText := Text;
       if (csPaintCopy in ControlState) then
        case CharCase of
          ecUpperCase: strText := AnsiUpperCase(strText);
          ecLowerCase: strText := AnsiLowerCase(strText);
         end;
       if PasswordChar <> #0 then
         FillChar(strText[1], Length(strText), PasswordChar);
       Margins := GetTextMargins;
       case AAlignment of
         taLeftJustify: ALeft := Margins.X;
         taRightJustify: ALeft := ClientWidth - TextWidth(strText) - Margins.X - 1;
         else ALeft := (ClientWidth - TextWidth(strText)) div 2;
        end;

       TextRect(R, ALeft, Margins.Y, strText);
     end;
  end;

  procedure PaintDefault;
  begin
    DC := Msg.DC;
    if DC = 0 then DC := BeginPaint(Handle, PS);
    FCanvas.Handle := DC;
    try
      TryToPaint;
    finally
      FCanvas.Handle := 0;
      if Msg.DC = 0 then EndPaint(Handle, PS);
    end;
  end;

begin
  if FFocused then AAlignment := taLeftJustify
  else AAlignment := FAlignment;

  PaintDefault;
  inherited;
end;

procedure TumIPMaskEdit.CMEnter(var Msg: TCMEnter);
begin
  SetFocused(True);
  Invalidate;
  inherited;
end;

procedure TumIPMaskEdit.CMExit(var Msg: TCMExit);
begin
  inherited;
  SetFocused(False);
  Invalidate;
end;

// TumIPEdit

constructor TumIPEdit.Create(aOwner: TComponent);
var
  b: Byte;
begin
  inherited;

  FAlignment := taCenter;
  FAutoSize := True;
  FBorderStyle := bsSingle;
  FColor := clWindow;
  FColorDisabled := clBtnFace;
  FCtl3D := True;
  FEnabled := True;
  TabStop := True;
  FCanvas := TCanvas.Create;
  Width := 96;
  Height := 21;

  for b := 1 to 4 do
   begin
    FIPSection[b] := TumIPMaskEdit.Create(Self);
    FIPSection[b].Top := 3;    
    FIPSection[b].MaxLength := 3;
    FIPSection[b].BorderStyle := bsNone;
    FIPSection[b].Parent := Self;
   end;
end;

destructor TumIPEdit.Destroy;
var
  b: Byte;
begin
  for b := 1 to 4 do
   FIPSection[b].Free;

  FCanvas.Free;

  inherited;
end;

procedure TumIPEdit.SetAlignment(Value: TAlignment);
begin
  if FAlignment <> Value then
   begin
    FAlignment := Value;

   end; 
end;

procedure TumIPEdit.SetAutoSize(Value: Boolean);
begin
  if FAutoSize <> Value then
   begin
    FAutoSize := Value;
    Repaint;
   end
end;

procedure TumIPEdit.SetBorderStyle(Value: TBorderStyle);
begin
  if FBorderStyle <> Value then
   begin
    FBorderStyle := Value;
    Repaint;
   end;
end;

procedure TumIPEdit.SetColor(Value: TColor);
begin
  if FColor <> Value then
   begin
    FColor := Value;
    Repaint;
   end;
end;

procedure TumIPEdit.SetColorDisabled(Value: TColor);
begin
  if FColorDisabled <> Value then
   begin
    FColorDisabled := Value;
    Repaint;
   end;
end;

procedure TumIPEdit.SetCtl3D(Value: Boolean);
begin
  if FCtl3D <> Value then
   begin
    FCtl3D := Value;
    Repaint;
   end;
end;

procedure TumIPEdit.SetEnabled(Value: Boolean);
begin
  if FEnabled <> Value then
   begin
    FEnabled := Value;

    FIPSection[1].Enabled := FEnabled;
    FIPSection[2].Enabled := FEnabled;
    FIPSection[3].Enabled := FEnabled;
    FIPSection[4].Enabled := FEnabled;

    Repaint;
   end;
end;

procedure TumIPEdit.SetText(Value: String);
begin
  if FText <> Value then
   begin
    FText := Value;
    IPLong := inet_addr(PChar(Value));
   end;
end;

procedure TumIPEdit.RefreshText;
begin
  FText := IntToStr(FIP1) + '.' + IntToStr(FIP2) + '.' +
           IntToStr(FIP3) + '.' + IntToStr(FIP4);
  FIPLong := (LongInt(FIP4) shl 24) +
             (LongInt(FIP3) shl 16) +
             (LongInt(FIP2) shl 8) +
             LongInt(FIP1);
end;

procedure TumIPEdit.SetIP1(Value: Byte);
var
  Pos: Integer;
begin
  if FIP1 <> Value then
   begin
    FIP1 := Value;

    FIPSection[1].Text := IntToStr(FIP1);
    if FIPSection[1].Focused then
     begin
      Pos := Length(FIPSection[1].Text);
      SendMessage(FIPSection[1].Handle, em_SetSel, Pos, Pos);
     end; 
    RefreshText;
   end;
end;

procedure TumIPEdit.SetIP2(Value: Byte);
var
  Pos: Integer;
begin
  if FIP2 <> Value then
   begin
    FIP2 := Value;

    FIPSection[2].Text := IntToStr(FIP2);
    if FIPSection[2].Focused then
     begin
      Pos := Length(FIPSection[2].Text);
      SendMessage(FIPSection[2].Handle, em_SetSel, Pos, Pos);
     end;
    RefreshText;
   end;
end;

procedure TumIPEdit.SetIP3(Value: Byte);
var
  Pos: Integer;
begin
  if FIP3 <> Value then
   begin
    FIP3 := Value;

    FIPSection[3].Text := IntToStr(FIP3);
    if FIPSection[3].Focused then
     begin
      Pos := Length(FIPSection[3].Text);
      SendMessage(FIPSection[3].Handle, em_SetSel, Pos, Pos);
     end;
    RefreshText;
   end;
end;

procedure TumIPEdit.SetIP4(Value: Byte);
var
  Pos: Integer;
begin
  if FIP4 <> Value then
   begin
    FIP4 := Value;

    FIPSection[4].Text := IntToStr(FIP4);
    if FIPSection[4].Focused then
     begin
      Pos := Length(FIPSection[4].Text);
      SendMessage(FIPSection[4].Handle, em_SetSel, Pos, Pos);
     end;
    RefreshText;
   end;
end;

procedure TumIPEdit.SetIPLong(Value: LongInt);
var
  Addr: in_addr;
begin
  if FIPLong <> Value then
   begin
    FIPLong := Value;

    Addr.S_addr := FIPLong;
    FIP1 := Byte(Addr.S_un_b.s_b1);
    FIP2 := Byte(Addr.S_un_b.s_b2);
    FIP3 := Byte(Addr.S_un_b.s_b3);
    FIP4 := Byte(Addr.S_un_b.s_b4);

    FText := IntToStr(FIP1) + '.' + IntToStr(FIP2) + '.' +
             IntToStr(FIP3) + '.' + IntToStr(FIP4);

    FIPSection[1].Text := IntToStr(FIP1);
    FIPSection[2].Text := IntToStr(FIP2);
    FIPSection[3].Text := IntToStr(FIP3);
    FIPSection[4].Text := IntToStr(FIP4);
   end;
end;

procedure TumIPEdit.ValueChanged;
var
  Code: Integer;
  b: Byte;
begin
  {$R-}
  Val(FIPSection[1].Text, b, Code);
  if Code = 0 then IP1 := b;
  Val(FIPSection[2].Text, b, Code);
  if Code = 0 then IP2 := b;
  Val(FIPSection[3].Text, b, Code);
  if Code = 0 then IP3 := b;
  Val(FIPSection[4].Text, b, Code);
  if Code = 0 then IP4 := b;
  {$R+}

  if Assigned(FOnChange) then
   FOnChange(Self);
end;

procedure TumIPEdit.WMSetFocus(var Msg: TWMSetFocus);
begin
  inherited;
  if FEnabled then FIPSection[1].SetFocus;
end;

procedure TumIPEdit.WMPaint(var Msg: TWMPaint);
var
  DC: hDC;
  b: Byte;
  SectionWidth, SectionHeight: Integer;

  procedure PaintThisControl;
  var
    b: Byte;
  begin
    FCanvas.Font := Font;
    if FEnabled then
     FCanvas.Brush.Color := Color
    else
     FCanvas.Brush.Color := ColorDisabled;

    SectionWidth := FCanvas.TextWidth('666') + 1;
    SectionHeight := FCanvas.TextHeight('Sj!`,') + 2;

    if not Ctl3D and (FBorderStyle <> bsNone) then
     FCanvas.Pen.Color := clWindowFrame
    else
     FCanvas.Pen.Color := Color;
    FCanvas.Rectangle(0, 0, Width, Height);
    if Ctl3D and (FBorderStyle <> bsNone) then
     begin
      FCanvas.Pen.Color := clBtnShadow;
      FCanvas.MoveTo(0, Height);
      FCanvas.LineTo(0, 0);
      FCanvas.LineTo(Width - 1, 0);

      FCanvas.Pen.Color := clWindow;
      FCanvas.LineTo(Width - 1, Height - 1);
      FCanvas.LineTo(-1, Height - 1);

      FCanvas.Pen.Color := cl3DLight;
      FCanvas.MoveTo(1, Height - 2);
      FCanvas.LineTo(Width - 2, Height - 2);
      FCanvas.LineTo(Width - 2, 0);

      FCanvas.Pen.Color := cl3DDkShadow;
      FCanvas.MoveTo(Width - 3, 1);
      FCanvas.LineTo(0, 1);
      FCanvas.MoveTo(1, 1);
      FCanvas.LineTo(1, Height - 2); 
     end;

    FCanvas.Font.Style := FCanvas.Font.Style + [fsBold];
    for b := 1 to 3 do
     FCanvas.TextOut((SectionWidth + 5) * b - 1, 3, '.');
  end;

begin
  inherited;
  DC := GetDC(Handle);
  FCanvas.Handle := DC;
  try
    PaintThisControl;
  finally
    ReleaseDC(Handle, DC);
  end;

  // Fixing the control size
  if FAutoSize then
   begin
    Width := (SectionWidth + 5) * 4;
    Height := SectionHeight + 6;
   end;

  // Fixing IP sections
  for b := 1 to 4 do
   begin
    FIPSection[b].Alignment := FAlignment;
    if FEnabled then
     FIPSection[b].Color := Color
    else
     FIPSection[b].Color := ColorDisabled;
    FIPSection[b].Cursor := Cursor;
    FIPSection[b].Font := Font;
    FIPSection[b].ParentFont := ParentFont;
    FIPSection[b].Hint := Hint;
    FIPSection[b].ShowHint := ShowHint;
    FIPSection[b].ParentShowHint := ParentShowHint;
    FIPSection[b].PopupMenu := PopupMenu;
    FIPSection[b].HelpContext := HelpContext;
    FIPSection[b].Left := (SectionWidth + 5) * b - (SectionWidth + 5) + 3;
    FIPSection[b].Width := SectionWidth;
    FIPSection[b].Height := Height - 5;
    FIPSection[b].Repaint;
   end;
end;

procedure Register;
begin
  RegisterComponents('UtilMind', [TumEdit, TumValidEdit,
                                  TumNumberEdit, TumIPEdit]);
end;

end.
