unit Unit6;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  umEdit, StdCtrls, ComCtrls, ExtCtrls, math;

type
  TForm6 = class(TForm)
    Button3: TButton;
    Button1: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    GroupBox3: TGroupBox;
    eLine: TEdit;
    GroupBox2: TGroupBox;
    e1: TumNumberEdit;
    e2: TumNumberEdit;
    e3: TumNumberEdit;
    e4: TumNumberEdit;
    e5: TumNumberEdit;
    e6: TumNumberEdit;
    e7: TumNumberEdit;
    e8: TumNumberEdit;
    bPrev: TButton;
    bNext: TButton;
    bFirst: TButton;
    bLast: TButton;
    GroupBox4: TGroupBox;
    mBody: TMemo;
    GroupBox5: TGroupBox;
    TabSheet5: TTabSheet;
    c1: TumEdit;
    c2: TumEdit;
    c3: TumEdit;
    c4: TumEdit;
    c5: TumEdit;
    c6: TumEdit;
    c7: TumEdit;
    c8: TumEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label1: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    labItem: TLabel;
    labOwner: TLabel;
    labSize: TLabel;
    labOffset: TLabel;
    Label8: TLabel;
    labType: TLabel;
    list: TListView;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label9: TLabel;
    Label10: TLabel;
    f1: TumValidEdit;
    f2: TumValidEdit;
    Label11: TLabel;
    i1: TumNumberEdit;
    i2: TumNumberEdit;
    procedure Button3Click(Sender: TObject);
    procedure Updatedata;
    procedure UpdateHEX;
    procedure UpdateText();
    function Asc(s:string):integer;
    procedure bNextClick(Sender: TObject);
    procedure bPrevClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure eLineKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure mBodyKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure e1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure bFirstClick(Sender: TObject);
    procedure bLastClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure GetType();
    procedure UpdateBIN;
    procedure PageControl1Change(Sender: TObject);
    procedure f1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure f2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure e1Enter(Sender: TObject);
    procedure c1KeyPress(Sender: TObject; var Key: Char);
    procedure c1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure c8KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure mBodyKeyPress(Sender: TObject; var Key: Char);
    procedure i1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure i2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

  private
    fChanged: TObject;
    fNextC: boolean;
    fNoKey: boolean;
  public
    { Public declarations }
    fOffSet, fSize, fSubOffs: integer;
    fString, fParentType: String;
    fObjList,fBMlist: TStringlist;
  end;

var
  Form6: TForm6;

implementation

uses Unit1, NumberFunctions;

{$R *.DFM}

procedure TForm6.Updatedata;
begin
fSubOffs := 1;
fString := form1.getraw(fOffSet,fSize);
eLine.Maxlength := fSize;
mBody.Maxlength := fSize;
labOffset.Caption := inttostr(fOffset)+' ( '+inttohex(fOffSet,1)+' )';
labSize.Caption := inttostr(fSize);
Pagecontrol1.ActivePage := Tabsheet1;
GetType;
UpdateText;
UpdateHEX;
end;

function TForm6.Asc(s:string):integer;
var
i:integer;
begin
result := 0;
for i := 0 to 255 do
if chr(i)=s[1] then result := i;
end;

procedure TForm6.UpdateHEX;
begin

e1.Value := 0;e2.Value := 0;e3.Value := 0;e4.Value := 0;
e5.Value := 0;e6.Value := 0;e7.Value := 0;e8.Value := 0;
c1.text := '';c2.text := '';c3.text := '';c4.text := '';
c5.text := '';c6.text := '';c7.text := '';c8.text := '';

f1.text := '0,0';
f2.text := '0,0';
f1.enabled := true;
f2.enabled := true;

i1.value := 0;
i2.value := 0;
f1.enabled := true;
f2.enabled := true;


e1.enabled := true;e2.enabled := true;e3.enabled := true;e4.enabled := true;
e5.enabled := true;e6.enabled := true;e7.enabled := true;e8.enabled := true;
c1.enabled := true;c2.enabled := true;c3.enabled := true;c4.enabled := true;
c5.enabled := true;c6.enabled := true;c7.enabled := true;c8.enabled := true;

if (fSubOffs <= fSize) then e1.Value := asc(fString[fSubOffs]) else begin e1.enabled := false; c1.enabled := false;end;
if (fSubOffs+1 <= fSize) then e2.Value := asc(fString[fSubOffs+1]) else begin e2.enabled := false; c2.enabled := false;end;
if (fSubOffs+2 <= fSize) then e3.Value := asc(fString[fSubOffs+2]) else begin e3.enabled := false; c3.enabled := false;end;
if (fSubOffs+3 <= fSize) then e4.Value := asc(fString[fSubOffs+3]) else begin e4.enabled := false; c4.enabled := false;end;
if (fSubOffs+4 <= fSize) then e5.Value := asc(fString[fSubOffs+4]) else begin e5.enabled := false; c5.enabled := false;end;
if (fSubOffs+5 <= fSize) then e6.Value := asc(fString[fSubOffs+5]) else begin e6.enabled := false; c6.enabled := false;end;
if (fSubOffs+6 <= fSize) then e7.Value := asc(fString[fSubOffs+6]) else begin e7.enabled := false; c7.enabled := false;end;
if (fSubOffs+7 <= fSize) then e8.Value := asc(fString[fSubOffs+7]) else begin e8.enabled := false; c8.enabled := false;end;

// Integers
if (fSubOffs+3 <= fSize) then i1.value :=
(asc(fString[fSubOffs+3])*256*256*256)+(asc(fString[fSubOffs+2])*256*256)
+(asc(fString[fSubOffs+1])*256)+asc(fString[fSubOffs])
else begin i1.enabled := false;end;

if (fSubOffs+7 <= fSize) then i2.value :=
(asc(fString[fSubOffs+7])*256*256*256)+(asc(fString[fSubOffs+6])*256*256)
+(asc(fString[fSubOffs+5])*256)+asc(fString[fSubOffs+4])
else begin i2.enabled := false;end;


// Floats
if (fSubOffs+3 <= fSize) then f1.text :=
floattostrf(bytestosingle(asc(fString[fSubOffs+3]),asc(fString[fSubOffs+2]),asc(fString[fSubOffs+1]),asc(fString[fSubOffs])),ffGeneral,2,0)
else begin f1.enabled := false;end;

if (fSubOffs+7 <= fSize) then f2.text :=
floattostrf(bytestosingle(asc(fString[fSubOffs+7]),asc(fString[fSubOffs+6]),asc(fString[fSubOffs+5]),asc(fString[fSubOffs+4])),ffGeneral,2,0)
else begin f2.enabled := false;end;


// Char
if (fSubOffs <= fSize) then c1.text := fString[fSubOffs];
if (fSubOffs+1 <= fSize) then c2.text := fString[fSubOffs+1];
if (fSubOffs+2 <= fSize) then c3.text := fString[fSubOffs+2];
if (fSubOffs+3 <= fSize) then c4.text := fString[fSubOffs+3];
if (fSubOffs+4 <= fSize) then c5.text := fString[fSubOffs+4];
if (fSubOffs+5 <= fSize) then c6.text := fString[fSubOffs+5];
if (fSubOffs+6 <= fSize) then c7.text := fString[fSubOffs+6];
if (fSubOffs+7 <= fSize) then c8.text := fString[fSubOffs+7];


Label1.Caption := 'Offset: '+inttostr(fOffset)+'+'+inttostr(fSubOffS-1)+' ['+inttohex(fOffset+fSubOffs-1,6)+']';

//UpdateBIN;
end;

procedure TForm6.Button3Click(Sender: TObject);
begin
modalresult := mrOk;
end;

procedure TForm6.bNextClick(Sender: TObject);
begin
if fSubOffs+8<=fSize then inc(fSubOffs);
updatehex;
end;

procedure TForm6.bPrevClick(Sender: TObject);
begin
if fSubOffs>1 then dec(fSubOffs);
updatehex;
end;

procedure TForm6.Button1Click(Sender: TObject);
begin
modalresult := mrCancel;
end;

procedure TForm6.eLineKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key = 13 then begin
fString := eLine.Text;
Button3.Enabled := true;
Updatehex;
end;

end;

procedure TForm6.FormActivate(Sender: TObject);
begin
Button3.Enabled := false;
end;

procedure TForm6.mBodyKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if (Key = 13) and (ssShift in Shift) then begin
fString := mBody.Text;
Button3.Enabled := true;
Updatehex;
fNoKey := true;
end;
end;

procedure TForm6.e1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
fChanged := sender;
if (key = 13) then
with Sender as TumNumberEdit do begin
fString[fSubOffs+Tag] := chr(Value);
UpdateText;
updatehex;
Button3.Enabled := true;
fChanged := nil;
end;

end;

procedure TForm6.UpdateText();
var
i:integer;
begin
eLine.Text := '';
mBody.Text := '';

for i := 1 to fSize do
if asc(fString[i]) > 0 then
eLine.Text := eLine.Text + fString[i]
else eLine.Text := eLine.Text + ' ';

for i := 1 to fSize do
if asc(fString[i]) > 0 then
mBody.Text := mBody.Text + fString[i]
else mBody.Text := mBody.Text + ' ';

end;


procedure TForm6.bFirstClick(Sender: TObject);
begin
fSubOffs := 1;
updatehex;
end;

procedure TForm6.bLastClick(Sender: TObject);
begin
if fSize>8 then fSubOffs := fSize-7;
updatehex;

end;

procedure TForm6.FormCreate(Sender: TObject);
begin
fChanged := nil;
fNextC := false;
fNoKey := false;
fObjList := TStringlist.create;
if fileexists(extractfilepath(paramstr(0))+'dbase\objects.txt') then
fObjlist.Loadfromfile(extractfilepath(paramstr(0))+'dbase\objects.txt');

fBMlist := TStringlist.create;
if fileexists(extractfilepath(paramstr(0))+'dbase\bitmasks.txt') then
fBMlist.Loadfromfile(extractfilepath(paramstr(0))+'dbase\bitmasks.txt');
end;

procedure TForm6.GetType();
var
i:integer;
begin
labType.Caption := 'Unknown';
for i := 0 to fObjlist.count-1 do
if lowercase(copy(fObjlist.strings[i],1,4))=lowercase(labItem.Caption) then begin
labType.Caption := copy(fObjlist.strings[i],6,100);break;end;
end;

procedure TForm6.UpdateBIN;
var
i,j:integer;
item: TListitem;
bbm:boolean;
bs,bm:string;

function BytetoBin(b:Byte):string;
var
s,r:string;
i:integer;
begin
if b>=128 then begin s:= s+'1';b := b-128; end else s := s+'0';
if b>=64 then begin s:= s+'1';b := b-64; end else s := s+'0';
if b>=32 then begin s:= s+'1';b := b-32; end else s := s+'0';
if b>=16 then begin s:= s+'1';b := b-16; end else s := s+'0';
if b>=8 then begin s:= s+'1';b := b-8; end else s := s+'0';
if b>=4 then begin s:= s+'1';b := b-4; end else s := s+'0';
if b>=2 then begin s:= s+'1';b := b-4; end else s := s+'0';
if b>0 then  s:= s+'1' else s := s+'0';
r := '';
for i := 8 downto 1 do
r := r + copy(s,i,1);

result := r;
end;

function Getword(text:string;nr:integer):string;
var
k: integer;
a: string;
b,q:integer;
c:string;
begin
// Tokenizer:
c := ',';
b := 1;
q := 0;
a := '';
for k := 1 to length(text) do
begin
if (b = nr) and (copy(text,k,1)<>c) and (copy(text,k,1)<>'"') then a := a+copy(text,k,1);
if (copy(text,k,1)=c) and (q=0) then b := b+1;
if (copy(text,k,1)=c) and (q=1) then a := a+copy(text,k,1);
if (copy(text,k,1)='"') and (q=1) then q := 4;
if (copy(text,k,1)='"') and (q=3) then q := 4;
if (b = nr) and (q=0) and (copy(text,k,1)='"') then q:=1;
if (b <> nr) and (q=0) and (copy(text,k,1)='"') then q:=3;
if q = 4 then q := 0;
end;
result := a;
end;


begin
list.items.clear;

if length(fString)>32 then begin
Label9.Caption := 'Datastring too long!';
Label9.Font.Color := clRed;
showmessage('Datastring too long! Aborting.');
Exit;end;
bs := '';
// find bitmask
bbm := false;
Label9.Caption := '';
for i := 0 to fbmlist.count-1 do
if (getword(fbmlist.strings[i],1)=labItem.Caption) and (getword(fbmlist.strings[i],2)=uppercase(fParentType))
then begin bbm := true; bm := fbmlist.strings[i];end;

if not bbm then begin
Label9.Caption := 'Bitmask not recognized.';
Label9.font.color := clRed;
end else begin
Label9.Caption := 'Bitmask recognized!';
Label9.font.color := clblack;
end;
list.items.clear;
for i := 1 to length(fString) do
bs := bs+bytetobin(asc(fString[i]));

for i := 0 to length(bs)-1 do begin
item := list.items.add;
item.Caption := inttostr(i);
item.SubItems.add(copy(bs,i+1,1));
if bbm then
item.SubItems.add(getword(bm,i+3));

end;

end;


procedure TForm6.PageControl1Change(Sender: TObject);
begin
if Pagecontrol1.activepage = Tabsheet4 then UpdateBIN;

end;

procedure TForm6.f1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
a,b,c,d:byte;
s: single;
s2: string;

    function HexToInt(hex1:string):integer;
    var
    k:integer;
    a:integer;
    h:string;
    svar:integer;
    begin
    svar := 0;
    a:= length(hex1);
    for k := 1 to length(hex1) do begin
    h:= copy(hex1,k,1);
    a := a-1;
    if h = 'A' then h := '10';
    if h = 'B' then h := '11';
    if h = 'C' then h := '12';
    if h = 'D' then h := '13';
    if h = 'E' then h := '14';
    if h = 'F' then h := '15';
    svar := svar+round(strtoint(h)*power(16,a));
    end;
    result := svar;
    end;
begin
if key<>13 then Exit;
if length(f1.text)=0 then Exit;
s := strtofloat(f1.text);
s2 := floattohex(s,true);
a := hextoint(copy(s2,1,2));
b := hextoint(copy(s2,3,2));
c := hextoint(copy(s2,5,2));
d := hextoint(copy(s2,7,2));
fString[fSubOffs] := chr(a);
fString[fSubOffs+1] := chr(b);
fString[fSubOffs+2] := chr(c);
fString[fSubOffs+3] := chr(d);
UpdateHex;
end;

procedure TForm6.f2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
a,b,c,d:byte;
s: single;
s2: string;

    function HexToInt(hex1:string):integer;
    var
    k:integer;
    a:integer;
    h:string;
    svar:integer;
    begin
    svar := 0;
    a:= length(hex1);
    for k := 1 to length(hex1) do begin
    h:= copy(hex1,k,1);
    a := a-1;
    if h = 'A' then h := '10';
    if h = 'B' then h := '11';
    if h = 'C' then h := '12';
    if h = 'D' then h := '13';
    if h = 'E' then h := '14';
    if h = 'F' then h := '15';
    svar := svar+round(strtoint(h)*power(16,a));
    end;
    result := svar;
    end;
begin
if key<>13 then Exit;
if length(f2.text)=0 then Exit;
s := strtofloat(f2.text);
s2 := floattohex(s,true);
a := hextoint(copy(s2,1,2));
b := hextoint(copy(s2,3,2));
c := hextoint(copy(s2,5,2));
d := hextoint(copy(s2,7,2));
fString[fSubOffs+4] := chr(a);
fString[fSubOffs+5] := chr(b);
fString[fSubOffs+6] := chr(c);
fString[fSubOffs+7] := chr(d);
UpdateHex;
end;

procedure TForm6.e1Enter(Sender: TObject);
begin
if fChanged is TumNumberEdit then
with fChanged as TumNumberEdit do begin
fString[fSubOffs+Tag] := chr(Value);
UpdateText;
updatehex;
Button3.Enabled := true;
fChanged := nil;
end;
if sender is TumNumberEdit then
with sender as TumNumberEdit do
SelectAll;

end;

procedure TForm6.c1KeyPress(Sender: TObject; var Key: Char);
begin
fNextC := true;
end;

procedure TForm6.c1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if fNextC = true then begin
fNextC := false;

with Sender as TumEdit do begin
if length(text)=0 then exit;
fString[fSubOffs+Tag] := text[1];
UpdateText;
updatehex;
Button3.Enabled := true;
end;
if sender = c1 then focuscontrol(c2);
if sender = c2 then focuscontrol(c3);
if sender = c3 then focuscontrol(c4);
if sender = c4 then focuscontrol(c5);
if sender = c5 then focuscontrol(c6);
if sender = c6 then focuscontrol(c7);
if sender = c7 then focuscontrol(c8);
end;
end;

procedure TForm6.c8KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if fNextC = true then begin
fNextC := false;

with Sender as TumEdit do begin
if length(text)=0 then Exit;
fString[fSubOffs+Tag] := text[1];
UpdateText;
updatehex;
Button3.Enabled := true;
end;
bNextClick(self);
end;

end;

procedure TForm6.mBodyKeyPress(Sender: TObject; var Key: Char);
begin
if fNoKey then begin
fNoKey := false;
Key := #0;
end;
end;

procedure TForm6.i1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
i:integer;
a,b,c,d: byte;
begin
if key <> 13 then Exit;
if length(i1.text)=0 then Exit;
i := i1.Value;
a := i div (256*256*256);
b := (i div (256*256))- (a*256);
c := (i div 256)- (b*256);
d := i-(c*256);
//showmessage(inttostr(i1.value)+': '+inttostr(d)+','+inttostr(c)+','+inttostr(b)+','+inttostr(a));
fString[fSubOffs] := chr(d);
fString[fSubOffs+1] := chr(c);
fString[fSubOffs+2] := chr(b);
fString[fSubOffs+3] := chr(a);
UpdateHex;

end;

procedure TForm6.i2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
i:integer;
a,b,c,d: byte;
begin
if key <> 13 then Exit;
if length(i2.text)=0 then Exit;
i := i2.Value;
a := i div (256*256*256);
b := (i div (256*256))- (a*256);
c := (i div 256)- (b*256);
d := i-(c*256);
//showmessage(inttostr(i1.value)+': '+inttostr(d)+','+inttostr(c)+','+inttostr(b)+','+inttostr(a));
fString[fSubOffs+4] := chr(d);
fString[fSubOffs+5] := chr(c);
fString[fSubOffs+6] := chr(b);
fString[fSubOffs+7] := chr(a);
UpdateHex;

end;
end.
