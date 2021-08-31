unit Unit5;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm5 = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

{$R *.DFM}

procedure TForm5.Button1Click(Sender: TObject);
begin
modalresult := mrYes;
end;

procedure TForm5.Button2Click(Sender: TObject);
begin
modalresult := mrNo;
end;

procedure TForm5.Button3Click(Sender: TObject);
begin
modalresult := mrCancel;
end;

end.
