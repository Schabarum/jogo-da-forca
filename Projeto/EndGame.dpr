program EndGame;

uses
  Vcl.Forms,
  UPrincipal in '..\Menu\UPrincipal.pas' {MenuPrincipal},
  UPalavra in '..\Menu\PopUp\UPalavra.pas' {APalavra};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'EndGame';
  Application.CreateForm(TMenuPrincipal, MenuPrincipal);
  Application.CreateForm(TAPalavra, APalavra);
  Application.Run;

end.
