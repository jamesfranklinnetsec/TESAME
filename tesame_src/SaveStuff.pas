unit SaveStuff;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  math, filectrl, stdctrls;

type
  TSavestuff = class(TComponent)
  private
    { Private declarations }
  F: TFilestream;
  FFilename: string;
  FValues: TStringList;

    function ToAsc(s:string):integer;
    procedure WriteByte(a:integer);
    function ReadByte():integer;
    function Getword(text:string;nr:integer):string;
    function ShiftInt(a:integer;b:integer):integer;
  protected
    { Protected declarations }
  public
    { Public declarations }
   constructor Create(AOwner: TComponent); override;
   destructor Destroy; override;
    procedure Save();
    Procedure Load();
    procedure LoadASCII();
    procedure SaveASCII();
    procedure SetValue(name:string;value:string);
    function GetValue(name:string):string;
    function GetValueName(index:integer):string;
    procedure ClearValues();
  published
    { Published declarations }
   property Filename: String read FFilename write FFilename;
   property Values: TStringList read FValues write FValues;
  end;

procedure Register;

{$R Savestuff.res}

implementation

procedure Register;
begin
  RegisterComponents('Samples', [TSavestuff]);
end;

constructor TSaveStuff.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FValues := TStringlist.Create;
end;

destructor TSaveStuff.Destroy;
begin
  inherited Destroy;
  FValues.Free;
end;


procedure TSaveStuff.SetValue(name:string;value:string);
var
i:integer;
begin
for i := 0 to FValues.Count-1 do
if lowercase(name)=lowercase(getword(FValues.Strings[i],1)) then begin
FValues.Strings[i] := '"'+ getword(FValues.Strings[i],1)+'","'+value+'"';
exit;end;
FValues.add('"'+ name+'","'+value+'"');
end;

function TSaveStuff.GetValue(name:string):string;
var
i:integer;
begin
result := '';
for i := 0 to FValues.Count-1 do
if lowercase(name)=lowercase(getword(FValues.Strings[i],1)) then begin
result := getword(FValues.Strings[i],2);
break;exit;end;
end;

function TSaveStuff.GetValueName(index:integer):string;
begin
result := getword(FValues.Strings[index],1);
end;

procedure TSaveStuff.ClearValues();
begin
FValues.clear;
end;


function TSaveStuff.ToAsc(s:string):integer;
var
k:integer;
begin
result := 0;
for k := 0 to 255 do
if chr(k) = s then begin
result := ShiftInt(k,50);break;end;
end;

function TSaveStuff.ShiftInt(a:integer;b:integer):integer;
begin
a := a+b;
if a>255 then a := a-255;
result := a;
end;

function TSaveStuff.Getword(text:string;nr:integer):string;
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



procedure TSaveStuff.WriteByte(a:integer);
var
b2:byte;
begin
b2 := Byte(a);f.WriteBuffer(b2,1);
end;

function TSaveStuff.ReadByte():integer;
var
a1:byte;
begin
f.Readbuffer(a1,1);result := integer(a1);
end;


Procedure TSaveStuff.Save();
var
i,j:integer;
begin
//fValues.SaveToFile(FFilename);
if Fileexists(FFilename)=true then
Deletefile(FFilename);
f := TFilestream.Create(FFilename,fmCreate);
for i := 0 to FValues.Count-1 do begin
WriteByte(length(getword(FValues.Strings[i],1)));
WriteByte(length(getword(FValues.Strings[i],2)));
for j := 1 to length(getword(FValues.Strings[i],1)) do
Writebyte(toasc(copy(getword(FValues.Strings[i],1),j,1)));
for j := 1 to length(getword(FValues.Strings[i],2)) do
Writebyte(toasc(copy(getword(FValues.Strings[i],2),j,1)));
end;
F.Free;

end;

procedure TSaveStuff.LoadASCII();
begin
fValues.LoadfromFile(FFilename);
end;

procedure TSaveStuff.SaveASCII();
begin
fValues.SavetoFile(FFilename);
end;

Procedure TSaveStuff.Load();
var
a,b,i:integer;
n,v:string;
begin
//fValues.SaveToFile(FFilename);
if Fileexists(fFilename)=false then Exit;
f := TFilestream.Create(FFilename,fmOpenRead);
if f.size = 0 then begin f.free; exit;end;
ClearValues;
repeat
a := readbyte;
b := readbyte;
n := '';v := n;
for i := 1 to a do
n := n + chr(shiftint(readbyte,-50));
for i := 1 to b do
v := v + chr(shiftint(readbyte,-50));
FValues.add('"'+n+'","'+v+'"');
until (F.Position >= F.Size);
F.Free;
end;


end.
