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

(*
workaround for missing import in VirtualBox guest additions
https://www.virtualbox.org/ticket/18324
causing linker error /usr/lib/x86_64-linux-gnu/VBoxOGLcrutil.so: undefined reference to `crypt_r'
*)
{$ifdef LINUX}
{$linklib 'libcrypt.so'}
{$endif}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
