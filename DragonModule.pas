unit DragonModule;

interface

uses GraphABC;

const
  MaxTurns = 32767;

procedure DrawInfo(level1, step1: integer);
procedure DrawDragonIter(x, y, step, level: integer);
procedure RedrawScene(x1, y1, step1, level1: integer);

implementation

procedure DrawInfo(level1, step1: integer);
begin
  SetFontSize(12);
  SetBrushColor(clWhite);
  SetPenColor(clBlack);

  TextOut(10, 10, 'Esc - выход');
  TextOut(10, 30, 'Стрелки - перемещение');
  TextOut(10, 50, 'Z / X - увеличить / уменьшить размер');
  TextOut(10, 70, 'A / D - уменьшить / увеличить глубину');

  TextOut(10, 110, 'Кривая Дракона');
  TextOut(10, 130, 'Уровень: ' + level1.ToString);
  TextOut(10, 150, 'Шаг: ' + step1.ToString);
end;

procedure DrawDragonIter(x, y, step, level: integer);
var
  turn: array[1..MaxTurns] of boolean;
  temp: array[1..MaxTurns] of boolean;
  len, newLen, n, i: integer;
  dx, dy, t: integer;
begin
  len := 0;
  for n := 1 to level do
  begin
    for i := 1 to len do
      temp[i] := turn[i];

    temp[len + 1] := true;

    for i := 1 to len do
      temp[len + 1 + i] := not turn[len - i + 1];

    newLen := len * 2 + 1;
    for i := 1 to newLen do
      turn[i] := temp[i];

    len := newLen;
  end;

  dx := 0;
  dy := -step;

  MoveTo(x, y);
  x += dx;
  y += dy;
  LineTo(x, y);

  for i := 1 to len do
  begin
    if turn[i] then
    begin
      t := dx;
      dx := -dy;
      dy := t;
    end
    else
    begin
      t := dx;
      dx := dy;
      dy := -t;
    end;

    x += dx;
    y += dy;
    LineTo(x, y);
  end;
end;

procedure RedrawScene(x1, y1, step1, level1: integer);
begin
  Window.Clear(clWhite);
  DrawInfo(level1, step1);

  SetPenColor(clBlue);
  SetPenWidth(1);

  DrawDragonIter(x1, y1, step1, level1);

  Redraw;
end;

end.