unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, EnhListView, StdCtrls, ExtListView, ImgList, ExtCtrls, Menus,
  SaveStuff, ShellAPI, math;

type
  TForm1 = class(TForm)
    list: TdfsExtListView;
    list2: TdfsExtListView;
    Splitter1: TSplitter;
    O1: TOpenDialog;
    S1: TSaveDialog;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    LoadMod1: TMenuItem;
    SaveMod1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    Marked1: TMenuItem;
    Delete1: TMenuItem;
    Saveas1: TMenuItem;
    Preferences1: TMenuItem;
    cbColor: TMenuItem;
    About1: TMenuItem;
    Howtouse1: TMenuItem;
    About2: TMenuItem;
    N2: TMenuItem;
    EditHeader1: TMenuItem;
    N3: TMenuItem;
    Loadinto1: TMenuItem;
    s2: TSaveDialog;
    o2: TOpenDialog;
    Close1: TMenuItem;
    Merge1: TMenuItem;
    Label2: TLabel;
    Label1: TLabel;
    cfg: TSavestuff;
    Autoclean1: TMenuItem;
    Doit1: TMenuItem;
    N4: TMenuItem;
    cbCells: TMenuItem;
    cbNPC: TMenuItem;
    cbItems: TMenuItem;
    barPanel: TPanel;
    bar1: TProgressBar;
    procedure Loaditems();
    function GetWord():string;
    function GetValue():integer;
    function GetRaw(offs,len:integer):string;
    function SetRaw(offs,len:integer;s:string):string;
    procedure RenameAll();
    function ToItem(s:string):string;
    function GetSpecificData(offs,fsize:integer; itemname:string):string;
    procedure listDblClick(Sender: TObject);
    procedure listDrawItem(Control: TWinControl; var ACanvas: TCanvas;
      Index: Integer; ARect: TRect; State: TOwnerDrawState;
      var DefaultDrawing, FullRowSelect: Boolean);
    procedure listKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure listSortItems(Sender: TObject; Item1, Item2: TListItem;
      SortColumn: Integer; var CompResult: Integer);
    procedure cbColorClick(Sender: TObject);
    procedure listMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LoadMod1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure SaveMod1Click(Sender: TObject);
    procedure Delete1Click(Sender: TObject);
    procedure Saveas1Click(Sender: TObject);
    procedure Close1Click(Sender: TObject);
    procedure Loadinto1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EditHeader1Click(Sender: TObject);
    procedure Merge1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Howtouse1Click(Sender: TObject);
    procedure About2Click(Sender: TObject);
    procedure TurnOn(b:boolean);
    procedure Autoclean();
    function RightType(s:string):boolean;
    procedure Doit1Click(Sender: TObject);
    procedure cbCellsClick(Sender: TObject);
    function GetSpecificOffSet(offs,fsize:integer; itemname:string):TPoint;
    procedure Antifreeze;

  private
    { Private declarations }
  public
    { Public declarations }
    f: TFilestream;
  end;

var
  Form1: TForm1;

implementation

uses Unit2, Unit3, Unit4, Unit5;

{$R *.DFM}

var
CurItem,CurItemO,CurItemS: integer;
tempfile: string;

procedure TForm1.Loaditems();
var
OffSet,Size:integer;
item,name:string;
index:integer;
listitem : TListitem;
begin
list.items.clear;
list2.items.clear;
OffSet := 0; // efter header
index := 0;
bar1.Min := 0;
bar1.max := f.size;
bar1.Position := 0;
barpanel.Height := 18;
try
while Offset<f.Size do begin
f.seek(OffSet,0);
item := GetWord;
size := GetValue;
if item <> 'SCPT' then
name := GetSpecificData(OffSet+16,OffSet+size,'NAME')
else
name := GetSpecificData(OffSet+16,OffSet+size,'SCHD');

// Skapa listitem
listitem := list.items.add;
listitem.Caption := ToItem(item);
listitem.subitems.add(name);
listitem.subitems.add(GetSpecificData(OffSet+16,OffSet+size,'FNAM'));
listitem.subitems.add(inttostr(OffSet));
listitem.subitems.add(inttostr(size+16));
listitem.subitems.add(inttostr(index));
listitem.subitems.add(item);
listitem.Checked := false;
OffSet := OffSet+size+16;
inc(index);
bar1.position := offset;
antifreeze;
end;
except
on e:Exception do begin
f.free;
Exit;
end;end;
barpanel.Height := 1;
//f.Free;
//showmessage('Klar!');
end;

function TForm1.ToItem(s:string):string;
begin
result := s;
s := lowercase(s);
if s = 'cell' then result := 'Cell';
if s = 'scpt' then result := 'Script';
if s = 'npc_' then result := 'NPC';
if s = 'glob' then result := 'Global';
if s = 'ingr' then result := 'Ingredient';
if s = 'acti' then result := 'Activator';
if s = 'cont' then result := 'Container';
if s = 'door' then result := 'Door';
if s = 'ligh' then result := 'Light';
if s = 'stat' then result := 'Static';
if s = 'levi' then result := 'Lev Item';
if s = 'weap' then result := 'Weapon';
if s = 'pgrd' then result := 'Path grid';
if s = 'prob' then result := 'Probe';
if s = 'crea' then result := 'Creature';
if s = 'lock' then result := 'Lockpick';
if s = 'alch' then result := 'Alchemy';
if s = 'appa' then result := 'Apparatus';
if s = 'levc' then result := 'Lev Creature';
if s = 'dial' then result := 'Topic';
if s = 'info' then result := 'Info/Responce';
if s = 'clot' then result := 'Clothing';
if s = 'book' then result := 'Book';
if s = 'body' then result := 'Body Part';
if s = 'misc' then result := 'Misc';
if s = 'sndg' then result := 'Sound';
if s = 'soun' then result := 'Sound';
if s = 'ltex' then result := 'Texture';
if s = 'land' then result := 'Landscape';
if s = 'mgef' then result := 'Magic effect';
if s = 'skil' then result := 'Skill';
if s = 'armo' then result := 'Armor';
if s = 'ench' then result := 'Enchanting';
if s = 'fact' then result := 'Faction';
if s = 'repa' then result := 'Repair item';
if s = 'spel' then result := 'Spell';
if s = 'tes3' then result := 'Header';


end;
function TForm1.GetWord():string;
var
a,b,c,d: integer;
s: string;
begin
f.ReadBuffer(a,1);
f.ReadBuffer(b,1);
f.ReadBuffer(c,1);
f.ReadBuffer(d,1);
s := chr(a)+chr(b)+chr(c)+chr(d);
result := s;
end;

function TForm1.GetValue():integer;
var
a,b,c,x:integer;
begin
a := 0;
b := 0;
c := 0;
f.ReadBuffer(a,1);
f.ReadBuffer(b,1);
f.ReadBuffer(c,1);
f.ReadBuffer(x,1);
result := (c*256*256)+(b*256)+a;
end;

function TForm1.GetRaw(offs,len:integer):string;
var
s:string;
i,b:integer;
begin
f.seek(offs,0);
for i := 1 to len do begin
f.readbuffer(b,1);
s := s + chr(b);
end;
result := s;
end;

function TForm1.SetRaw(offs,len:integer;s:string):string;
var
i,b:integer;
            function Asc(s:string):integer;
            var
            i:integer;
            begin
            result := 0;
            for i := 0 to 255 do
            if chr(i)=s[1] then result := i;
            end;
begin
f.seek(offs,0);
for i := 1 to len do begin
if i<=length(s) then
b := asc(copy(s,i,1))
  else b := 0;
f.writebuffer(b,1);
end;
end;


procedure TForm1.listDblClick(Sender: TObject);
var
OffSet,size,fSize:integer;
item,data:string;
listitem : TListitem;
begin
if list.selcount <> 1 then Exit;
list2.items.clear;

OffSet := strtoint(list.selected.subitems[2])+16;
fSize := OffSet+strtoint(list.selected.subitems[3])-16;
CurItem := list.selected.index;
CurItemO := Offset;
CurItemS := strtoint(list.selected.subitems[3]);

try
while (Offset<f.Size) and (OffSet<fSize) do begin
f.seek(OffSet,0);
item := GetWord;
size := GetValue;
data := GetRaw(OffSet+8,size);
// Skapa listitem
listitem := list2.items.add;
listitem.Caption := item;
listitem.subitems.add(data);
listitem.subitems.add(inttohex(Offset+8,1));
listitem.subitems.add(inttohex(size,1));
//listitem.subitems.add(inttostr(offset));
//listitem.subitems.add(inttostr(size));
//listitem.subitems.add(inttostr(index));
OffSet := OffSet+size+8;
end;
except
on e:Exception do begin
f.free;
Exit;
end;end;
//f.Free;
//showmessage('Klar!');
end;

function TForm1.GetSpecificData(offs,fsize:integer; itemname:string):string;
var
size:integer;
item,data:string;
begin
result := '';
while (Offs<f.Size) and (Offs<fSize) do begin
f.seek(Offs,0);
item := GetWord;
size := GetValue;
data := GetRaw(OffS+8,size);
if lowercase(item) = lowercase(itemname) then begin
result := data;
Exit;
end;
Offs := Offs+size+8;
end;

end;


procedure TForm1.listDrawItem(Control: TWinControl; var ACanvas: TCanvas;
  Index: Integer; ARect: TRect; State: TOwnerDrawState; var DefaultDrawing,
  FullRowSelect: Boolean);
var
s:string;
c:TColor;
begin
defaultdrawing := true;
if not cbColor.checked then Exit; 
//fullrowselect := false;
s := lowercase(list.items[index].subitems.strings[5]);
c := clWhite;
if s = 'cell' then c := $00D9D9FF;
if s = 'scpt' then c := $00FFD0CB;
if s = 'npc_' then c := $00FFD9FE;
if s = 'door' then c := $00D9EDFF;
if s = 'ingr' then c := $00DBFFD9;
if s = 'ligh' then c := $00D9FDFF;
if s = 'cont' then c := $00FFFECB;
//if s = 'land' then c := $0049CE00;

if list.items[index].checked then begin
   acanvas.font.color := clwhite;
   c := clblack;
end;
ACanvas.brush.color := c;
end;

procedure TForm1.listKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
i:integer;
begin
if key = vk_f1 then renameall;
if (list.selcount>0) and (key = VK_Space) then
for i := 0 to list.items.count-1 do
if ((not list.items[i].focused) and (list.items[i].selected)) and (list.items[i].subitems.strings[4]<>'0') then
list.items[i].checked := not list.items[i].checked;

if key = 13 then
listdblclick(self)
end;

procedure TForm1.listSortItems(Sender: TObject; Item1, Item2: TListItem;
  SortColumn: Integer; var CompResult: Integer);
begin
if list.Items.Count<2 then Exit;
if SortColumn>1 then begin
if strtoint(Item1.SubItems[SortColumn])>strtoint(Item2.SubItems[SortColumn]) then Compresult := 1;
if strtoint(Item1.SubItems[SortColumn])<strtoint(Item2.SubItems[SortColumn]) then Compresult := -1;
if strtoint(Item1.SubItems[SortColumn])=strtoint(Item2.SubItems[SortColumn]) then Compresult := 0;
end;

if (SortColumn<=1) and (Sortcolumn>=0) then begin
if Item1.SubItems[SortColumn]>Item2.SubItems[SortColumn] then Compresult := 1;
if Item1.SubItems[SortColumn]<Item2.SubItems[SortColumn] then Compresult := -1;
if Item1.SubItems[SortColumn]=Item2.SubItems[SortColumn] then Compresult := 0;
end;

if SortColumn=-1 then begin
if Item1.Caption>Item2.Caption then Compresult := 1;
if Item1.Caption<Item2.Caption then Compresult := -1;
if Item1.Caption=Item2.Caption then Compresult := 0;
end;

end;

procedure TForm1.cbColorClick(Sender: TObject);
begin
cbColor.checked := not cbColor.checked; 
list.repaint;
end;

procedure TForm1.listMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin

if (button = mbRight) and (list.GetItemAt(x,y) <> nil) then
with list.GetItemAt(x,y) do
if subitems.strings[4]<>'0' then checked := not checked;
end;

procedure TForm1.LoadMod1Click(Sender: TObject);
begin
if o1.execute = false then Exit;
f.free;
tempfile := extractfilepath(paramstr(0))+'tempfile.tmp';
if fileexists(tempfile) then deletefile(tempfile);
copyfile(pchar(o1.filename),pchar(tempfile),false);
try
F := TFileStream.Create(tempfile,fmOpenReadWrite);
except
on e:Exception do begin
showmessage('Error when loading file..');
f.free;
Exit;
end;end;

Loaditems;
Caption := 'TES Advanced Mod Editor ['+extractfilename(o1.filename)+']';
EditHeader1.enabled := true;
SaveMod1.Enabled := true;
Turnon(true);
end;

procedure Tform1.Antifreeze;
var
msg: tagMSG;
begin
while PeekMessage(Msg,0,0,0,pm_Remove) do begin
    TranslateMessage(Msg);
    DispatchMessage(Msg);
  end;
end;

procedure TForm1.TurnOn(b:boolean);
begin
Delete1.Enabled := b;
SaveMod1.Enabled := b;
Delete1.Enabled := b;
Saveas1.enabled := b;
Loadinto1.enabled := b;
EditHeader1.enabled := b;
Autoclean1.enabled := b;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
//if o1.execute = false then Exit;
//Loaditems;

end;

procedure TForm1.SaveMod1Click(Sender: TObject);
var
i:integer;
f2: TFilestream;
begin
s1.filename := o1.filename;
if lowercase(copy(o1.filename,1,7))<>'copy of' then
s1.filename := extractfilepath(o1.filename)+'Copy of '+extractfilename(o1.filename);
if s1.execute = false then Exit;
if extractfileext(s1.filename)='' then s1.Filename := s1.filename+'.esp';
if fileexists(s1.filename) then
if messagedlg('Are you sure you want to overwrite '+extractfilename(s1.filename),mtConfirmation,[mbYes,mbNo],0)= mrNo then Exit;
list.defaultsort(5,true);
//f := TFilestream.create(o1.filename,fmOpenRead);
f2 := TFilestream.create(extractfilepath(s1.filename)+'temp.tmp',fmCreate);
for i := 0 to list.items.count-1 do begin
//offs := strtoint(list.items[i].subitems[2])-16;
//if offs<0 then offs := 0;
f.seek(strtoint(list.items[i].subitems[2]),0);
f2.CopyFrom(f,strtoint(list.items[i].subitems[3]));
end;
//f.free;
f2.free;
if fileexists(s1.filename) then deletefile(s1.filename);
renamefile(extractfilepath(s1.filename)+'temp.tmp',s1.filename);
showmessage('Saved '+extractfilename(s1.filename));
end;

procedure TForm1.Delete1Click(Sender: TObject);
var
i:integer;
begin
for i := list.items.count-1 downto 0 do
if list.items[i].checked then list.items.delete(i);
end;

procedure TForm1.Saveas1Click(Sender: TObject);
var
a,i:integer;
f2: TFilestream;
begin
a := 0;
for i := 0 to list.items.count-1 do
if list.items[i].checked then a := 1;
if a = 0 then begin showmessage('Mark the items you want to save');exit;end;

s2.filename := o1.filename;
s2.filename := extractfilepath(o1.filename)+'untitled.esd';
if s2.execute = false then exit;
if fileexists(s2.filename) then
if messagedlg('Are you sure you want to overwrite '+extractfilename(s2.filename),mtConfirmation,[mbYes,mbNo],0)=
mrNo then Exit;
list.defaultsort(5,true);
//f := TFilestream.create(o1.filename,fmOpenRead);
f2 := TFilestream.create(extractfilepath(s2.filename)+'datatemp.tmp',fmCreate);
for i := 0 to list.items.count-1 do
if list.items[i].checked then begin
f.seek(strtoint(list.items[i].subitems[2]),0);
f2.CopyFrom(f,strtoint(list.items[i].subitems[3]));
end;
//f.free;
f2.free;
if fileexists(s2.filename) then deletefile(s2.filename);
renamefile(extractfilepath(s2.filename)+'datatemp.tmp',s2.filename);
showmessage('Saved '+extractfilename(s2.filename));
end;

procedure TForm1.Close1Click(Sender: TObject);
begin
f.free;
list.items.clear;
list2.items.clear;
Turnon(false);
end;

procedure TForm1.Loadinto1Click(Sender: TObject);
var
f2: TFilestream;
begin
o2.filename := extractfilepath(o1.filename)+'*.esd';
if o2.execute =false then exit;
list.defaultsort(5,true);
if fileexists(extractfilepath(tempfile)+'tempfile2.tmp') then deletefile(extractfilepath(tempfile)+'tempfile2.tmp');
//f3 := TFilestream.create(extractfilepath(tempfile)+'tempfile2.tmp',fmCreate);
f2 := TFilestream.create(o2.filename,fmOpenRead);
f.seek(f.size,0);
//f.Size := f.size+f2.size;
//f.seek(0,0);
f2.seek(0,0);
//f3.CopyFrom(f,f.size);
f.CopyFrom(f2,f2.size);
//f.free;
//f3.free;
//deletefile(tempfile);
//renamefile(extractfilepath(tempfile)+'tempfile2.tmp',tempfile);
//f := TFilestream.Create(tempfile,fmOpenReadWrite);
showmessage('Inserted '+extractfilename(s2.filename)+' ('+inttostr(f2.size)+')');
f2.free;
//f2.free;
loaditems;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
if o1.filename<>'' then begin
cfg.setvalue('dir',extractfilepath(o1.filename));
cfg.save;
end;

try
f.free;
except
end;
end;

procedure TForm1.EditHeader1Click(Sender: TObject);
begin
Form2.Edit1.Text := GetRaw(32,32);
Form2.Memo1.Text := GetRaw(64,256);
if Form2.Showmodal = mrOk then
SetRaw(32,32,Form2.Edit1.Text);
SetRaw(64,256,Form2.Memo1.Text);
end;

procedure TForm1.Merge1Click(Sender: TObject);
var
source1,source2,dest:string;
f2: TFilestream;
begin
if Form3.showmodal <> mrOk then Exit;
source1 := form3.Edit1.Text;
source2 := form3.Edit2.Text;
dest := form3.s1.filename;
if (fileexists(source1)=false)
or (fileexists(source2)=false)
then begin showmessage('Can''t find source');Exit;end;
if (fileexists(dest)) and
(messagedlg('Overwrite '+extractfilename(dest)+'?',mtConfirmation,[mbYes,mbNo],0)=mrNo) then
Exit;

f.free;
list.items.clear;
list2.items.clear;

if fileexists(dest) then deletefile(dest);
f := TFilestream.Create(dest,fmCreate);
f2 := TFilestream.create(source1,fmOpenRead);
f.copyfrom(f2,f2.size);
f2.free;
f2 := TFilestream.create(source2,fmOpenRead);
f2.seek(362,0);
f.copyfrom(f2,f2.size-362);
f2.free;
showmessage(extractfilename(source1)+' + '+extractfilename(source2)+' = '+extractfilename(dest)+'!');
loaditems;
end;

procedure TForm1.Exit1Click(Sender: TObject);
begin
Close;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
cfg.filename := extractfilepath(paramstr(0))+'tesame.cfg';
if fileexists(cfg.filename) then begin
cfg.load;
o1.InitialDir := cfg.getvalue('dir');
o2.InitialDir := cfg.getvalue('dir');
s1.InitialDir := cfg.getvalue('dir');
s2.InitialDir := cfg.getvalue('dir');
end;
Turnon(false);
end;

procedure TForm1.Howtouse1Click(Sender: TObject);
begin
ShellExecute(0, 'open', pchar(extractfilepath(paramstr(0))+'readme.txt'), '', '', SW_SHOWNORMAL);
end;

procedure TForm1.About2Click(Sender: TObject);
begin
Form4.showmodal;
end;

procedure TForm1.Autoclean;
var
oldtype,curType: string;
typelist: TStringlist;
i,j: integer;
bad: boolean;
modalr,count:integer;
begin
typelist := TStringlist.create;
list.defaultsort(0,false);
count := 0;
for i := 0 to list.items.count-1 do
list.items[i].checked := false;

for i := 0 to list.items.count-1 do
if righttype(list.items[i].subitems.strings[5]) then begin oldtype := curtype;curtype := list.items[i].subitems.strings[5];
if curType<> oldtype then typelist.LoadFromFile(extractfilepath(paramstr(0))+'dbase\'+curtype+'.txt');
bad := false;
for j := 0 to typelist.count-1 do
if trim(lowercase(typelist.strings[j]))=trim(lowercase(list.items[i].subitems.strings[0]))
then begin bad := true;break;end;
list.Items[i].checked := bad;
if bad then inc(count);
end;

if count= 0 then begin
messagedlg('No correction needed.',mtInformation,[mbOk],0);
Exit;end;

form5.label1.caption := inttostr(count)+' potentially illegal items have';
modalr := form5.showmodal;
if modalr = mrYes then begin
Delete1Click(self);
end;
if modalr = mrNo then begin
renameall;
//showmessage('Rename all');
end;
//if modalr = mrCancel then showmessage('Nothing');

end;

function TForm1.RightType(s:string):boolean;
begin
s := lowercase(s);
result := false;
if ((s = 'acti') and (cbItems.Checked))
or ((s = 'alch') and (cbItems.Checked))
or ((s = 'appa') and (cbItems.Checked))
or ((s = 'armo') and (cbItems.Checked))
or ((s = 'book') and (cbItems.Checked))
or ((s = 'cell') and (cbCells.Checked))
or ((s = 'clot') and (cbItems.Checked))
or ((s = 'cont') and (cbItems.Checked))
or ((s = 'crea') and (cbItems.Checked))
or ((s = 'door') and (cbItems.Checked))
or ((s = 'ench') and (cbItems.Checked))
or ((s = 'fact') and (cbItems.Checked))
or ((s = 'ingr') and (cbItems.Checked))
or ((s = 'ligh') and (cbItems.Checked))
or ((s = 'lock') and (cbItems.Checked))
or ((s = 'misc') and (cbItems.Checked))
or ((s = 'npc_') and (cbNPC.Checked))
or ((s = 'prob') and (cbItems.Checked))
or ((s = 'repa') and (cbItems.Checked))
or ((s = 'spel') and (cbItems.Checked))
or ((s = 'weap') and (cbItems.Checked))
then result := true;
end;

procedure TForm1.Doit1Click(Sender: TObject);
begin
AutoClean;
end;

procedure TForm1.cbCellsClick(Sender: TObject);
begin
with sender as TMenuitem do
checked := not checked;
end;

procedure TForm1.RenameAll();
var
i,offs,size:integer;
offsize: TPoint;
begin
for i := 0 to list.items.count-1 do
if list.items[i].checked then begin
offs := strtoint(list.items[i].subitems.strings[2]);
size := strtoint(list.items[i].subitems.strings[3]);
offsize := getspecificoffset(offs+16,offs+size,'NAME');

end;

end;

function TForm1.GetSpecificOffSet(offs,fsize:integer; itemname:string):TPoint;
var
size:integer;
item,data:string;
begin
result := point(0,0);
//fsize := offs+fsize;
while (Offs<f.Size) and (Offs<fSize) do begin
f.seek(Offs,0);
item := GetWord;
size := GetValue;
data := GetRaw(OffS+8,size);
if lowercase(item) = lowercase(itemname) then begin
result.x := OffS+8;result.y := size;
Exit;
end;
Offs := Offs+size+8;
end;

end;

end.
