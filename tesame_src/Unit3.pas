unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm3 = class(TForm)
    Edit1: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Edit2: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    O1: TOpenDialog;
    S1: TSaveDialog;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.DFM}

procedure TForm3.Button1Click(Sender: TObject);
begin
o1.Title := 'Source #1';
if o1.execute then Edit1.Text := o1.filename;
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
o1.Title := 'Source #2';
if o1.execute then Edit2.Text := o1.filename;
end;

procedure TForm3.Button3Click(Sender: TObject);
begin
s1.Title := 'Destination';
if s1.Execute = false then Exit;
Modalresult := mrOk;
end;

procedure TForm3.Button4Click(Sender: TObject);
begin
Modalresult := mrCancel;
end;

end.
