unit UPalavra;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TAPalavra = class(TForm)
    Panel1: TPanel;
    btnConfirm: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure btnConfirmClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    function IsEmpty(Componente: TEdit): Boolean;
  public
    { Public declarations }
  end;

var
  APalavra: TAPalavra;

implementation

{$R *.dfm}

procedure TAPalavra.btnConfirmClick(Sender: TObject);
begin
  if IsEmpty(Edit1) or IsEmpty(Edit2) then
  begin
    ShowMessage('Ambos os campos devem estar preenchidos!');
    Edit1.SetFocus;
    Abort;
  end;

  Close;
end;

procedure TAPalavra.FormActivate(Sender: TObject);
begin
  Edit1.SetFocus;
end;

function TAPalavra.IsEmpty(Componente: TEdit): Boolean;
begin
  Result := Componente.Text = '';
end;

end.
