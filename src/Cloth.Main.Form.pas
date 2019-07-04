unit Cloth.Main.Form;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, ExtCtrls,
  Types, Contnrs, ClothDemo.Cloth, StdCtrls;

type
  TfrmMain = class(TForm)
    PaintBox: TPaintBox;
    tmr1: TTimer;
    pnlTop: TPanel;
    btnReset: TButton;
    btnZeroG: TButton;
    procedure btnResetClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure PaintBoxMouseDown(Sender: TObject; button: TMouseButton; Shift: TShiftState; x, y: integer);
    procedure PaintBoxMouseMove(Sender: TObject; Shift: TShiftState; x, y: integer);
    procedure PaintBoxMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure PaintBoxPaint(Sender: TObject);
    procedure tmr1Timer(Sender: TObject);
    procedure btnZeroGClick(Sender: TObject);
  private
    FLastUpdate:TDateTime;
  public
    World: TWorld;
    Cloths: TObjectList;
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses Math;

procedure TfrmMain.btnResetClick(Sender: TObject);
var i : Integer; Cloth:TCloth;
begin
  World := TWorld.CreateWithDefaults(PaintBox.Width, PaintBox.Height);

  Cloths.Free;
  Cloths := TObjectList.Create;

  for I := -1 to 1 do
  begin
    Cloth := TCloth.Create(False, World, 25, 25);
    Cloth.Offset(PointF(I*200,0));
    Cloth.Color := Random(MaxInt);
    Cloths.Add(Cloth);
  end;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  Cloths.Free;
  World.Free;
end;

procedure TfrmMain.btnZeroGClick(Sender: TObject);
begin
  World.Gravity := 0;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  btnResetClick(Sender);
end;

procedure TfrmMain.FormResize(Sender: TObject);
begin
  World.Buffer.SetSize(PaintBox.Width, PaintBox.Height);
end;

procedure TfrmMain.PaintBoxMouseDown(Sender: TObject; button: TMouseButton; Shift: TShiftState; x, y: integer);
begin
  World.Mouse.Button  := button;
  World.Mouse.IsDown  := true;
  World.Mouse.PrevPos := World.Mouse.Pos;
  World.Mouse.Pos     := Point(x,y);
end;

procedure TfrmMain.PaintBoxMouseMove(Sender: TObject; Shift: TShiftState; x,
  y: integer);
begin
  World.Mouse.PrevPos := World.Mouse.Pos;
  World.Mouse.Pos := Point(x,y);
end;

procedure TfrmMain.PaintBoxMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  World.Mouse.IsDown := false;
end;

procedure TfrmMain.PaintBoxPaint(Sender: TObject);
begin
  PaintBox.Canvas.Draw(0,0, World.Buffer);
end;

procedure TfrmMain.tmr1Timer(Sender: TObject);
var i:integer; TimeDelta:double;
begin
  TimeDelta := (Now - FLastUpdate)/690000;
  FLastUpdate := now;
  World.ClearCanvas;
  for i := 0 to Cloths.Count-1 do
    TCloth(Cloths[i]).Update(0.016);
  PaintBox.Invalidate;
end;


end.
