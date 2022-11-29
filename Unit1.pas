unit Unit1;

interface

uses
  Windows, Classes, Graphics, Controls, Forms, StdCtrls, SysUtils, Dialogs;

type
  TForm1 = class(TForm)
    ListBox1: TListBox;
    ComboBox1: TComboBox;
    lblLower: TLabel;
    lblUpper: TLabel;
    chkBold: TCheckBox;
    chkItalic: TCheckBox;
    chkUnderline: TCheckBox;
    chkStrikeOut: TCheckBox;
    cbbSize: TComboBox;
    lblSize: TLabel;
    btnBgndCol: TButton;
    btnFontCol: TButton;
    procedure ComboBox1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListBox1DrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure ListBox1Click(Sender: TObject);
    procedure chkBoldClick(Sender: TObject);
    procedure chkItalicClick(Sender: TObject);
    procedure chkUnderlineClick(Sender: TObject);
    procedure chkStrikeOutClick(Sender: TObject);
    procedure cbbSizeChange(Sender: TObject);
    procedure btnBgndColClick(Sender: TObject);
    procedure btnFontColClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  ComboBox1.Items := Screen.Fonts;
  //OR:
  //for i := 0 to Screen.Fonts.Count - 1 do
  //  ComboBox1.Items.Add(Screen.Fonts.Strings[i]);
  ComboBox1.ItemIndex := 0;
  //To show the items in the corresponding font, the Style of the Listbox should be lbOwnerDrawVariable
  ListBox1.Items := Screen.Fonts;
  ListBox1.ItemIndex := 0;
  cbbSize.ItemIndex := 6;
  Form1.Caption := 'Font Viewer (' + IntToStr(Screen.Fonts.Count) + ' fonts)';
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  lblUpper.Width := Form1.Width - 30;
  lblLower.Width := Form1.Width - 30;
end;

procedure TForm1.btnBgndColClick(Sender: TObject);
var
  Dlg: TColorDialog;
  ControlsCol: TColor;
  R, G, B: Integer;
begin
  Dlg := TColorDialog.Create(Form1);
  Dlg.Color := Form1.Color;
  if Dlg.Execute then
  begin
    Form1.Color := Dlg.Color;
    //Calculate brightness using: http://alienryderflex.com/hsp.html
    R := Dlg.Color and $FF;
    G := (Dlg.Color and $FF00) shr 8;
    B := (Dlg.Color and $FF0000) shr 16;
    if ((0.299 * R * R + 0.587 * G * G + 0.114 * B * B) > 16256.25) then
      ControlsCol := clBlack
    else
      ControlsCol := clWhite;
    lblSize.Font.Color := ControlsCol;
    chkBold.Font.Color := ControlsCol;
    chkItalic.Font.Color := ControlsCol;
    chkStrikeOut.Font.Color := ControlsCol;
    chkUnderline.Font.Color := ControlsCol;
  end;
end;

procedure TForm1.btnFontColClick(Sender: TObject);
var
  Dlg: TColorDialog;
begin
  Dlg := TColorDialog.Create(Form1);
  Dlg.Color := lblUpper.Font.Color;
  if Dlg.Execute then
  begin
    lblUpper.Font.Color := Dlg.Color;
    lblLower.Font.Color := Dlg.Color;
  end;
end;

procedure TForm1.cbbSizeChange(Sender: TObject);
begin
  lblLower.Font.Size := StrToInt(cbbSize.Text);
  lblUpper.Font.Size := StrToInt(cbbSize.Text);
end;

procedure TForm1.chkBoldClick(Sender: TObject);
begin
  if chkBold.Checked then
  begin
    lblLower.Font.Style := lblLower.Font.Style + [fsBold];
    lblUpper.Font.Style := lblUpper.Font.Style + [fsBold];
  end
  else
  begin
    lblLower.Font.Style := lblLower.Font.Style - [fsBold];
    lblUpper.Font.Style := lblUpper.Font.Style - [fsBold];
  end;
end;

procedure TForm1.chkItalicClick(Sender: TObject);
begin
  if chkItalic.Checked then
  begin
    lblLower.Font.Style := lblLower.Font.Style + [fsItalic];
    lblUpper.Font.Style := lblUpper.Font.Style + [fsItalic];
  end
  else
  begin
    lblLower.Font.Style := lblLower.Font.Style - [fsItalic];
    lblUpper.Font.Style := lblUpper.Font.Style - [fsItalic];
  end;
end;

procedure TForm1.chkUnderlineClick(Sender: TObject);
begin
  if chkUnderline.Checked then
  begin
    lblLower.Font.Style := lblLower.Font.Style + [fsUnderline];
    lblUpper.Font.Style := lblUpper.Font.Style + [fsUnderline];
  end
  else
  begin
    lblLower.Font.Style := lblLower.Font.Style - [fsUnderline];
    lblUpper.Font.Style := lblUpper.Font.Style - [fsUnderline];
  end;
end;

procedure TForm1.chkStrikeOutClick(Sender: TObject);
begin
  if chkStrikeOut.Checked then
  begin
    lblLower.Font.Style := lblLower.Font.Style + [fsStrikeOut];
    lblUpper.Font.Style := lblUpper.Font.Style + [fsStrikeOut];
  end
  else
  begin
    lblLower.Font.Style := lblLower.Font.Style - [fsStrikeOut];
    lblUpper.Font.Style := lblUpper.Font.Style - [fsStrikeOut];
  end;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  ListBox1.ItemIndex := ComboBox1.ItemIndex;
  lblLower.Font.Name := ComboBox1.Items[ComboBox1.ItemIndex];
  lblUpper.Font.Name := ComboBox1.Items[ComboBox1.ItemIndex];
end;

procedure TForm1.ListBox1Click(Sender: TObject);
begin
  ComboBox1.ItemIndex := ListBox1.ItemIndex;
  lblLower.Font.Name := ComboBox1.Items[ComboBox1.ItemIndex];
  lblUpper.Font.Name := ComboBox1.Items[ComboBox1.ItemIndex];
end;

procedure TForm1.ListBox1DrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  with ListBox1 do
  begin
    Canvas.fillrect(Rect);
    Canvas.Font.Name := Listbox1.Items[Index];
    Canvas.textout(Rect.Left, Rect.Top, Listbox1.Items[Index]);
  end;
end;

end.

