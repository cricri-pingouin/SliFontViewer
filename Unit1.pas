unit Unit1;

interface

uses
  Windows, Classes, Graphics, Controls, Forms, StdCtrls, SysUtils;

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
    procedure ComboBox1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListBox1DrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure ListBox1Click(Sender: TObject);
    procedure chkBoldClick(Sender: TObject);
    procedure chkItalicClick(Sender: TObject);
    procedure chkUnderlineClick(Sender: TObject);
    procedure chkStrikeOutClick(Sender: TObject);
    procedure cbbSizeChange(Sender: TObject);
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
  Form1.Caption := 'Font Viewer (' + IntToStr(Screen.Fonts.Count) + ' fonts)';
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

