program Main;

uses GraphABC, DragonModule;

var
  x1, y1: integer;
  step1: integer;
  level1: integer;

procedure KeyDown(key: integer);
begin
  case key of
    VK_Escape: Halt;

    VK_Left:  x1 += 20;
    VK_Right: x1 -= 20;
    VK_Up:    y1 += 20;
    VK_Down:  y1 -= 20;

    VK_Z:
      if step1 < 20 then
        step1 += 1;

    VK_X:
      if step1 > 1 then
        step1 -= 1;

    VK_A:
      if level1 > 1 then
        level1 -= 1;

    VK_D:
      if level1 < 15 then
        level1 += 1;
  end;

  RedrawScene(x1, y1, step1, level1);
end;

begin
  SetWindowSize(900, 600);
  SetWindowCaption('Итеративная кривая Дракона');
  LockDrawing;

  x1 := 550;
  y1 := 350;
  step1 := 6;
  level1 := 10;

  RedrawScene(x1, y1, step1, level1);
  OnKeyDown += KeyDown;
end.