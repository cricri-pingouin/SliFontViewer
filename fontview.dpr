Program fontview;

Uses
  Forms,
  Unit1 In 'Unit1.pas' {Form1};

{$R *.res}
{$SetPEFlags 1}

Begin
  Application.Initialize;
  Application.Title := 'Font Viewer';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
End.

