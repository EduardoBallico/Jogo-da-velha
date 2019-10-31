unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Math;

type
  TForm1 = class(TForm)
    StringGrid1: TStringGrid;
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    //
  public
    procedure winCondition(Points: Integer);
    procedure resetGame;
    function catsGame: Boolean;
    procedure smartPlayerTurn;
    procedure matrixToScreen;
  end;

var
  Form1: TForm1;
  jogoVelha: array [0 .. 2, 0 .. 2] of Integer;
  switch, switch2: Integer;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  resetGame;
end;

procedure TForm1.matrixToScreen;
// ESCREVE OS MOVIMENTOS
var
  I, J: Integer;
begin
  for J := 0 to 2 do
    for I := 0 to 2 do
    begin
      if jogoVelha[J][I] = 1 then
      begin
        StringGrid1.Cells[J, I] := ' X';
      end
      else if jogoVelha[J][I] = -1 then
      begin
        StringGrid1.Cells[J, I] := ' O';
      end
      else
      begin
        StringGrid1.Cells[J, I] := '';
      end;
    end;
end;

procedure TForm1.StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  if (StringGrid1.Cells[ACol, ARow] = '') then
  begin
    jogoVelha[ACol, ARow] := 1;
    matrixToScreen;
    catsGame;
    winCondition(3);
    smartPlayerTurn;
    matrixToScreen;
    catsGame;
    winCondition(-3);
  end
  else
  begin
    ShowMessage('Tente outra posição!');
  end;
end;

procedure TForm1.winCondition(Points: Integer);
// CONFERE SE ALGUM DOS JOGADORES GANHOU
var
  msg: string;
begin
  if Points = 3 then
    msg := 'Ganhou!'
  else
    msg := 'Perdeste camarada!';
  // VERIFICA AS DIAGONAIS
  if (jogoVelha[0][0] + jogoVelha[1][1] + jogoVelha[2][2] = Points) or
    (jogoVelha[2][0] + jogoVelha[1][1] + jogoVelha[0][2] = Points) then
  begin
    ShowMessage(msg);
    resetGame;
  end
  // VERIFICA AS LINHAS
  else if (jogoVelha[0][0] + jogoVelha[1][0] + jogoVelha[2][0] = Points) or
    (jogoVelha[0][1] + jogoVelha[1][1] + jogoVelha[2][1] = Points) or
    (jogoVelha[0][2] + jogoVelha[1][2] + jogoVelha[2][2] = Points) then
  begin
    ShowMessage(msg);
    resetGame;
  end
  // VERIFICA AS COLUNAS
  else if (jogoVelha[0][0] + jogoVelha[0][1] + jogoVelha[0][2] = Points) or
    (jogoVelha[1][0] + jogoVelha[1][1] + jogoVelha[1][2] = Points) or
    (jogoVelha[2][0] + jogoVelha[2][1] + jogoVelha[2][2] = Points) then
  begin
    ShowMessage(msg);
    resetGame;
  end
  // DECLARA EMPATE
  else if catsGame = True then
  begin
    ShowMessage('Velha!');
    resetGame;
  end;
end;

procedure TForm1.resetGame;
// RESTARTA O JOGO
var
  I, J: Integer;
begin
  switch := 0;
  switch2 := 0;
  for J := 0 to 2 do
  begin
    for I := 0 to 2 do
    begin
      jogoVelha[J][I] := 0;
    end;
  end;
  matrixToScreen;
end;

function TForm1.catsGame: Boolean;
// VERIFICA EMPATE
var
  I, J: Integer;
begin
  for J := 0 to 2 do
  begin
    for I := 0 to 2 do
    begin
      if jogoVelha[J][I] = 0 then
      begin
        Result := False;
        Exit;
      end
      else
      begin
        Result := True;
      end;
    end;
  end;
end;

procedure TForm1.smartPlayerTurn;
// JOGADA DO COMPUTADOR
var
  I, J: Integer;
begin
  // TENTATIVA DE VITÓRIA DO PC

  // DIAGONAL
  if (jogoVelha[0][0] + jogoVelha[1][1] + jogoVelha[2][2]) = -2 then
  begin
    for I := 0 to 2 do
    begin
      if jogoVelha[I][I] = 0 then
      begin
        jogoVelha[I, I] := -1;
        Exit;
      end;
    end;
  end
  else if (jogoVelha[2][0] + jogoVelha[1][1] + jogoVelha[0][2]) = -2 then
  begin
    for I := 0 to 2 do
      for J := 0 to 2 do
        if (I + J = 2) and (jogoVelha[I][J] = 0) then
        begin
          jogoVelha[I][J] := -1;
          Exit;
        end;
  end;
  // LINHA
  for J := 0 to 2 do
  begin
    if (jogoVelha[0][J] + jogoVelha[1][J] + jogoVelha[2][J]) = -2 then
    begin
      for I := 0 to 2 do
      begin
        if jogoVelha[I][J] = 0 then
        begin
          jogoVelha[I][J] := -1;
          Exit;
        end;
      end;
    end;
  end;
  // COLUNA
  for J := 0 to 2 do
  begin
    if (jogoVelha[J][0] + jogoVelha[J][1] + jogoVelha[J][2]) = -2 then
    begin
      for I := 0 to 2 do
      begin
        if jogoVelha[J][I] = 0 then
        begin
          jogoVelha[J][I] := -1;
          Exit;
        end;
      end;
    end;
  end;

  // TTENTATIVA DE BLOQUEAR A VITÓRIA DO PLAYER

  // DIAGONAL
  if (jogoVelha[0][0] + jogoVelha[1][1] + jogoVelha[2][2]) = 2 then
  begin
    for I := 0 to 2 do
    begin
      if jogoVelha[I, I] = 0 then
      begin
        jogoVelha[I, I] := -1;
        Exit;
      end;
    end;
  end
  else if (jogoVelha[2][0] + jogoVelha[1][1] + jogoVelha[0][2]) = 2 then
  begin
    for I := 0 to 2 do
      for J := 0 to 2 do
        if (I + J = 2) and (jogoVelha[I][J] = 0) then
        begin
          jogoVelha[I][J] := -1;
          Exit;
        end;
  end;
  // LINHA
  for J := 0 to 2 do
  begin
    if (jogoVelha[0][J] + jogoVelha[1][J] + jogoVelha[2][J]) = 2 then
    begin
      for I := 0 to 2 do
      begin
        if jogoVelha[I][J] = 0 then
        begin
          jogoVelha[I][J] := -1;
          Exit;
        end;
      end;
    end;
  end;
  // COLUNA
  for J := 0 to 2 do
  begin
    if (jogoVelha[J][0] + jogoVelha[J][1] + jogoVelha[J][2]) = 2 then
    begin
      for I := 0 to 2 do
      begin
        if jogoVelha[J][I] = 0 then
        begin
          jogoVelha[J][I] := -1;
          Exit;
        end;
      end;
    end;
  end;

  // SE NÃO CONSEGUIR BLOQUEAR NEM GANHAR
  if jogoVelha[1][1] = 0 then
  begin
    jogoVelha[1][1] := -1;
    Exit;
  end
  // TENTATIVA DE BLOQUAR AS ESTRATÉGIAS MAIS NORMAIS
  else if switch = 0 then
  begin
    if (jogoVelha[2][0] = 1) and (jogoVelha[0][2] = 1) and (jogoVelha[1][2] = 0)
    then
    begin
      jogoVelha[1][2] := -1;
      switch := 2;
      Exit;
    end
    else if (jogoVelha[0][0] = 1) and (jogoVelha[2][2] = 1) and
      (jogoVelha[1][2] = 0) then
    begin
      jogoVelha[1][2] := -1;
      switch := 2;
      Exit;
    end

    else if (jogoVelha[1][0] = 1) and (jogoVelha[0][2] = 1) and
      (jogoVelha[0][1] = 0) then
    begin
      jogoVelha[0][1] := -1;
      switch := 1;
      Exit;
    end
    else if (jogoVelha[1][0] = 1) and (jogoVelha[2][2] = 1) and
      (jogoVelha[2][1] = 0) then
    begin
      jogoVelha[2][1] := -1;
      switch := 1;
      Exit;
    end

    else if (jogoVelha[0][1] = 1) and (jogoVelha[2][2] = 1) and
      (jogoVelha[1][2] = 0) then
    begin
      jogoVelha[1][2] := -1;
      switch := 1;
      Exit;
    end
    else if (jogoVelha[0][1] = 1) and (jogoVelha[2][0] = 1) and
      (jogoVelha[1][0] = 0) then
    begin
      jogoVelha[1][0] := -1;
      switch := 1;
      Exit;
    end

    else if (jogoVelha[1][2] = 1) and (jogoVelha[2][0] = 1) and
      (jogoVelha[2][1] = 0) then
    begin
      jogoVelha[2][1] := -1;
      switch := 1;
      Exit;
    end
    else if (jogoVelha[1][2] = 1) and (jogoVelha[0][0] = 1) and
      (jogoVelha[0][1] = 0) then
    begin
      jogoVelha[0][1] := -1;
      switch := 1;
      Exit;
    end

    else if (jogoVelha[2][1] = 1) and (jogoVelha[0][0] = 1) and
      (jogoVelha[1][0] = 0) then
    begin
      jogoVelha[1][0] := -1;
      switch := 1;
      Exit;
    end
    else if (jogoVelha[2][1] = 1) and (jogoVelha[0][2] = 1) and
      (jogoVelha[1][2] = 0) then
    begin
      jogoVelha[1][2] := -1;
      switch := 1;
      Exit;
    end

    else if (jogoVelha[1][0] = 1) and (jogoVelha[0][1] = 1) and
      (jogoVelha[0][0] = 0) then
    begin
      jogoVelha[0][0] := -1;
      switch := 2;
      Exit;
    end;
  end
  else if switch = 1 then
  begin
    if (jogoVelha[1][0] = 1) and (jogoVelha[0][1] = 1) and (jogoVelha[0][0] = 0)
    then
    begin
      jogoVelha[0][0] := -1;
      switch := 2;
      Exit;
    end
    else if (jogoVelha[1][0] = 1) and (jogoVelha[2][1] = 1) and
      (jogoVelha[2][0] = 0) then
    begin
      jogoVelha[2][0] := -1;
      switch := 2;
      Exit;
    end
    else if (jogoVelha[1][2] = 1) and (jogoVelha[2][1] = 1) and
      (jogoVelha[2][2] = 0) then
    begin
      jogoVelha[2][2] := -1;
      switch := 2;
      Exit;
    end
    else if (jogoVelha[1][2] = 1) and (jogoVelha[0][1] = 1) and
      (jogoVelha[0][2] = 0) then
    begin
      jogoVelha[0][2] := -1;
      switch := 2;
      Exit;
    end;
  end;

  // MELHORA A INTELIGENCIA ARTIFICIAL DO ADVERSÁRIO
  if jogoVelha[2][2] = 0 then
  begin
    jogoVelha[2][2] := -1;
    Exit;
  end
  else if jogoVelha[2][0] = 0 then
  begin
    jogoVelha[2][0] := -1;
    Exit;
  end
  else if jogoVelha[0][2] = 0 then
  begin
    jogoVelha[0][2] := -1;
    Exit;
  end;

  for J := 0 to 2 do
  begin
    for I := 0 to 2 do
    begin
      if jogoVelha[J][I] = 0 then
      begin
        jogoVelha[J][I] := -1;
        Exit;
      end;
    end;
  end;
end;

end.
