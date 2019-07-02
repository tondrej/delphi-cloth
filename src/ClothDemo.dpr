program ClothDemo;

{$ifdef FPC}
  {$mode Delphi}
{$endif FPC}

uses
{$ifdef FPC}
  LCLIntf, Interfaces,
{$endif FPC}
  Forms,
  Cloth.Main.Form in 'Cloth.Main.Form.pas' {frmMain},
  ClothDemo.Cloth in 'ClothDemo.Cloth.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
