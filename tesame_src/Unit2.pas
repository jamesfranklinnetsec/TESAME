unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TForm2 = class(TForm)
    Edit1: TEdit;
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
  end;

var
  Form2: TForm2;

implementation

{$R *.DFM}

procedure TForm2.Button2Click(Sender: TObject);
begin
modalresult := mrOk;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
modalresult := mrCancel;
end;

end.
