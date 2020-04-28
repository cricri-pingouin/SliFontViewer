Unit Unit1;

Interface

Uses
  Windows, Classes, Graphics, Controls, Forms, StdCtrls;

Type
  TForm1 = Class(TForm)
    ListBox1: TListBox;
    ComboBox1: TComboBox;
    lblLower: TLabel;
    lblUpper: TLabel;
    Procedure ComboBox1Change(Sender: TObject);
    Procedure FormCreate(Sender: TObject);
    Procedure ListBox1DrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
    Procedure ListBox1Click(Sender: TObject);
  Private
    { Private declarations }
  Public
    { Public declarations }
  End;

Var
  Form1: TForm1;

Implementation

{$R *.dfm}

Procedure TForm1.ComboBox1Change(Sender: TObject);
Begin
  ListBox1.ItemIndex := ComboBox1.ItemIndex;
  lblLower.Font.Name := ComboBox1.Items[ComboBox1.ItemIndex];
  lblUpper.Font.Name := ComboBox1.Items[ComboBox1.ItemIndex];
End;

Procedure TForm1.FormCreate(Sender: TObject);
Begin
  ComboBox1.Items := Screen.Fonts;
  ComboBox1.ItemIndex := 0;
  ListBox1.Items := Screen.Fonts;
  ListBox1.ItemIndex := 0;
End;

Procedure TForm1.ListBox1Click(Sender: TObject);
Begin
  ComboBox1.ItemIndex := ListBox1.ItemIndex;
  lblLower.Font.Name := ComboBox1.Items[ComboBox1.ItemIndex];
  lblUpper.Font.Name := ComboBox1.Items[ComboBox1.ItemIndex];
End;

Procedure TForm1.ListBox1DrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
Begin
  With ListBox1 Do
  Begin
    Canvas.fillrect(Rect);
    //Canvas.Font.Style := [fsbold];
    Canvas.Font.Name := Listbox1.Items[Index];
    Canvas.textout(Rect.Left, Rect.Top, Listbox1.Items[Index]);
  End;
End;

End.

