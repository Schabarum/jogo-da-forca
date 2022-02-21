unit UPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls, UPalavra, Vcl.Imaging.pngimage,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons;

type

  TMenuPrincipal = class(TForm)
    pcPrincipal: TPageControl;
    tsMenu: TTabSheet;
    ImgPrincipal: TImage;
    lblWelcome: TLabel;
    ImgClose: TImage;
    ImgPlay: TImage;
    tsJogo: TTabSheet;
    pnlPlayer1: TPanel;
    pnlJogo: TPanel;
    pnlPlayer2: TPanel;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    imgForca1: TImage;
    imgForca2: TImage;
    img7: TImage;
    img1: TImage;
    pnlPalavra: TPanel;
    lblPalavra: TLabel;
    img2: TImage;
    img3: TImage;
    img4: TImage;
    img5: TImage;
    img6: TImage;
    img8: TImage;
    img9: TImage;
    img10: TImage;
    img11: TImage;
    imgStartGame: TImage;
    img12: TImage;
    pnlDica: TPanel;
    lblDica: TLabel;
    Label1: TLabel;
    edtLetra: TEdit;
    lblCont1: TLabel;
    lblPlacar: TLabel;
    lblCont2: TLabel;
    lblVez: TLabel;
    lblVezPl: TLabel;
    btnMenu: TSpeedButton;
    pnlConfig: TPanel;
    btnPalavras: TSpeedButton;
    tsPalavra: TTabSheet;
    pnlFundo: TPanel;
    pnlToolBar: TPanel;
    btnImport: TSpeedButton;
    btnSave: TSpeedButton;
    btnClose: TSpeedButton;
    mmoFile: TMemo;
    pnlAdd: TPanel;
    btnConfim: TSpeedButton;
    edtPalavra: TLabeledEdit;
    edtDica: TLabeledEdit;
    OpenDialog: TOpenDialog;
    lblPlayer01: TLabel;
    lblPlayer02: TLabel;
    procedure ImgCloseClick(Sender: TObject);
    procedure ImgPlayClick(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure imgStartGameClick(Sender: TObject);
    procedure edtLetraKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure btnMenuClick(Sender: TObject);
    procedure btnPalavrasClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnImportClick(Sender: TObject);
    procedure btnConfimClick(Sender: TObject);
  private
    procedure VerifyError(Erro: integer);
    procedure StartGame;
    procedure ChangePlayer;
    procedure VisibleBonecos;
    procedure Contador;
    procedure EndGame;
    procedure Placar;
    procedure StartVariables;
    procedure GameOver;
    procedure Word;
    procedure StartComponentes;
    procedure Error;
    procedure NomePlayers;

    function Player: string;
    function IsEmpty(Componente: TLabeledEdit): Boolean;
  public
    { Public declarations }
  end;

var
  MenuPrincipal: TMenuPrincipal;
  Palavra, Palavra2, Dica, Player1, Player2: string;
  Erro1, Erro2, Players, Cont1, Cont2, Linhas: integer;
  Importou, Salvou: Boolean;

implementation

{$R *.dfm}

procedure TMenuPrincipal.edtLetraKeyPress(Sender: TObject; var Key: Char);
var
  i: integer;
begin
  for i := 1 to Length(Palavra) do
  begin
    if Key = Palavra[i] then
      Palavra2[i] := Palavra[i];
    if UpperCase(Key) = Palavra[i] then
      Palavra2[i] := Palavra[i];
  end;

  lblPalavra.Caption := Palavra2;

  if Palavra2 = Palavra then
  begin
    Contador;
    Placar;
    ShowMessage('Parabéns ' + Player + ' você acertou a palavra!');
    Word;
    Exit;
  end;

  if (Pos(Key, Palavra) = 0) and (Pos(UpperCase(Key), Palavra) = 0) then
    Error;

  edtLetra.Text := '';
end;

// Vai validar se o Cont1/Cont2 = 3, se sim o jogo acaba
procedure TMenuPrincipal.EndGame;
begin
  if Cont1 = 3 then
  begin
    ShowMessage('O ' + Player + ' é o vencedor!');
    if MessageDlg('Deseja reiniciar o jogo ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      Cont1 := 0;
      Cont2 := 0;
      if MessageDlg('Deseja trocar o nick dos players?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
        NomePlayers;
        StartGame;
      end
      else
        StartGame;
    end
    else
      Close;
    Placar;
  end;
  if Cont2 = 3 then
  begin
    ShowMessage('O ' + Player + ' é o vencedor!');

    if MessageDlg('Deseja reiniciar o jogo ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      Cont1 := 0;
      Cont2 := 0;
      if MessageDlg('Deseja trocar o nick dos players?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
        NomePlayers;
        StartGame;
      end
      else
        StartGame;
    end
    else
      Close;
    Placar;
  end;
end;

procedure TMenuPrincipal.Error;
begin
  if Players = 1 then
  begin
    Erro1 := Erro1 + 1;
    VerifyError(Erro1);
    GameOver;
    Placar;
    ChangePlayer;
    lblVezPl.Caption := Player;
  end
  else
  begin
    Erro2 := Erro2 + 1;
    VerifyError(Erro2);
    GameOver;
    Placar;
    ChangePlayer;
    lblVezPl.Caption := Player;
  end;
end;

// Chama o Startvariables e o Placar
procedure TMenuPrincipal.FormActivate(Sender: TObject);
begin
  StartVariables;
  Placar;
end;

// Controla o Erro1/Erro2 se chega em 6
procedure TMenuPrincipal.GameOver;
begin
  if Erro1 = 6 then
  begin
    ChangePlayer;
    ShowMessage('Você perdeu! agora é a vez do: ' + Player);
    Contador;
    StartGame;
  end;

  if Erro2 = 6 then
  begin
    ChangePlayer;
    ShowMessage('Você perdeu! agora é a vez do: ' + Player);
    Contador;
    StartGame;
  end;
end;

procedure TMenuPrincipal.Image3Click(Sender: TObject);
begin
  pcPrincipal.ActivePageIndex := 2;
end;

// Fecha a tela
procedure TMenuPrincipal.ImgCloseClick(Sender: TObject);
begin
  Close;
end;

// Botão Start Principal chama o nome dos players
procedure TMenuPrincipal.ImgPlayClick(Sender: TObject);
begin
  NomePlayers;
  pcPrincipal.ActivePageIndex := 2;
end;

// Chama o StartGame
procedure TMenuPrincipal.imgStartGameClick(Sender: TObject);
begin
  StartGame;
end;

// Verifica se o componente está vazio
function TMenuPrincipal.IsEmpty(Componente: TLabeledEdit): Boolean;
begin
  Result := Componente.Text = '';
end;

procedure TMenuPrincipal.NomePlayers;
begin
  APalavra := TAPalavra.Create(Application);
  APalavra.ShowModal;
  try
    Player1 := APalavra.Edit1.Text;
    Player2 := APalavra.Edit2.Text;
  finally
    APalavra.Free;
  end;
end;

// Valida se foi importado e se salvou o arquivo e troca o tabsheet
procedure TMenuPrincipal.btnCloseClick(Sender: TObject);
begin
  if Importou and Salvou then
    pcPrincipal.ActivePage := tsJogo
  else
    ShowMessage('Você deve importar um arquivo com as palavras e dicas e salva-lo');
  Salvou := False;
end;

// Botão que importa o arquivo txt
procedure TMenuPrincipal.btnImportClick(Sender: TObject);
var
  Arquivo: TextFile;
  Linha: string;
begin
  mmoFile.Lines.Clear;
  OpenDialog.Execute;
  AssignFile(Arquivo, OpenDialog.FileName);
  Reset(Arquivo);
  Readln(Arquivo, Linha);
  while not Eof(Arquivo) do
  begin
    mmoFile.Lines.Add(Linha);
    Readln(Arquivo, Linha);
  end;
  CloseFile(Arquivo);
  Importou := True;
end;

// Mostra o panel para chamar o form da palavra
procedure TMenuPrincipal.btnMenuClick(Sender: TObject);
begin
  pnlConfig.Visible := not pnlConfig.Visible;
end;

// Troca de tabsheet
procedure TMenuPrincipal.btnPalavrasClick(Sender: TObject);
begin
  pcPrincipal.ActivePage := tsPalavra;
end;

// Troca o player
procedure TMenuPrincipal.ChangePlayer;
begin
  if Players = 1 then
    Players := 2
  else
    Players := 1;
end;

// Atribui +1 no Cont1/Cont2
procedure TMenuPrincipal.Contador;
begin
  if Players = 1 then
    Cont1 := Cont1 + 1
  else
    Cont2 := Cont2 + 1;
  Placar;
  EndGame;
end;

// Pega uma palavra aleatoria do arquivo txt
procedure TMenuPrincipal.Word;
var
  i, Line: integer;
  Read, Save: TStrings;
begin
  Randomize;
  Line := random(Linhas);

  Read := TStringList.Create;
  Save := TStringList.Create;
  try
    Read.LoadFromFile(ExtractFileName(OpenDialog.FileName));
    Save.Delimiter := ';';
    Save.StrictDelimiter := True;

    Save.DelimitedText := Read.Strings[Line];
    Palavra := Save.Strings[0];
    Dica := Save.Strings[1];
  finally
    Save.Free;
    Read.Free;
  end;

  lblPalavra.Caption := '';
  Palavra2 := '';
  for i := 1 to Length(Palavra) do
  begin
    lblPalavra.Caption := lblPalavra.Caption + '_';
  end;
  lblDica.Caption := 'A dica é: ' + Dica + ' e a palavra possui ' + IntToStr(Length(Palavra)) + ' letras';
  Palavra2 := lblPalavra.Caption;
  edtLetra.Visible := True;
  edtLetra.SetFocus;
end;

// Atribui o caption dos lbl do contador conforme Cont1/Cont2
procedure TMenuPrincipal.Placar;
begin
  lblCont1.Caption := IntToStr(Cont1);
  lblCont2.Caption := IntToStr(Cont2);
end;

// Retorna o nome do player
function TMenuPrincipal.Player: string;
begin
  if Players = 1 then
    Result := Player1
  else
    Result := Player2;
end;

// Após incrementar o nome do erro ele pega e mostra mais uma parte do boneco
procedure TMenuPrincipal.VerifyError(Erro: integer);
begin
  if Players = 1 then
  begin
    case Erro of
      1:
        img1.Visible := True;
      2:
        begin
          img1.Visible := False;
          img2.Visible := True;
        end;
      3:
        begin
          img2.Visible := False;
          img3.Visible := True;
        end;
      4:
        begin
          img3.Visible := False;
          img4.Visible := True;
        end;
      5:
        begin
          img4.Visible := False;
          img5.Visible := True;
        end;
      6:
        begin
          img5.Visible := False;
          img6.Visible := True;
        end;
    end;
  end
  else
  begin
    case Erro of
      1:
        img7.Visible := True;
      2:
        begin
          img7.Visible := False;
          img8.Visible := True;
        end;
      3:
        begin
          img8.Visible := False;
          img9.Visible := True;
        end;
      4:
        begin
          img9.Visible := False;
          img10.Visible := True;
        end;
      5:
        begin
          img10.Visible := False;
          img11.Visible := True;
        end;
      6:
        begin
          img11.Visible := False;
          img12.Visible := True;
        end;
    end;
  end;
end;

// Adiciona mais palavras e dicas no mmoFile
procedure TMenuPrincipal.btnConfimClick(Sender: TObject);
begin
  if (IsEmpty(edtPalavra)) or (IsEmpty(edtDica)) then
  begin
    ShowMessage('É necessário o preenchimento de ambos os campos!');
    if IsEmpty(edtPalavra) then
      edtPalavra.SetFocus
    else if IsEmpty(edtDica) then
      edtDica.SetFocus;
    Exit;
  end;

  mmoFile.Lines.Add(edtPalavra.Text + ';' + edtDica.Text + ';');
end;

// Salva o arquivo txt com o que está nas linhas do mmoFile
procedure TMenuPrincipal.btnSaveClick(Sender: TObject);
var
  Arquivo: TextFile;
  Linha: String;
  i: integer;
begin
  AssignFile(Arquivo, OpenDialog.FileName);

  Rewrite(Arquivo);
  for i := 0 to mmoFile.Lines.Count - 1 do
  begin
    Writeln(Arquivo, mmoFile.Lines[i]);
  end;

  Linhas := mmoFile.Lines.Count;
  CloseFile(Arquivo);
  ShowMessage('Gravado com sucesso!');
  Salvou := True;
end;

// Starta as propriedades dos componentes e lbls
procedure TMenuPrincipal.StartComponentes;
begin
  imgStartGame.Visible := False;
  pnlPalavra.Visible := True;
  pnlDica.Visible := True;
  Label1.Visible := True;
  edtLetra.Visible := True;
  edtLetra.SetFocus;
  lblCont1.Visible := True;
  lblCont2.Visible := True;
  lblPlacar.Visible := True;
  lblVez.Visible := True;
  lblVezPl.Visible := True;
  lblPlayer01.Visible := True;
  lblPlayer02.Visible := True;
end;

// Chama o StartVariables, StartComponentes, VisibleBonecos, Word
procedure TMenuPrincipal.StartGame;
begin
  StartVariables;
  StartComponentes;
  VisibleBonecos;
  Word;
end;

// Starta as variaveis de controle do jogo
procedure TMenuPrincipal.StartVariables;
begin
  Players := 1;
  Erro1 := 0;
  Erro2 := 0;
  lblPalavra.Caption := '';
  Palavra2 := '';
  lblVezPl.Caption := Player;
  lblPlayer01.Caption := Player1;
  lblPlayer02.Caption := Player2;
end;

// Deixa todas as partes dos bonecos invisiveis
procedure TMenuPrincipal.VisibleBonecos;
begin
  img1.Visible := False;
  img2.Visible := False;
  img3.Visible := False;
  img4.Visible := False;
  img5.Visible := False;
  img6.Visible := False;
  img7.Visible := False;
  img8.Visible := False;
  img9.Visible := False;
  img10.Visible := False;
  img11.Visible := False;
  img12.Visible := False;
end;

end.
