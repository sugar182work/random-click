'画面の解像度の300 300を始点にランダム位置、時間にクリックするよ
Option Explicit

Dim x, y, i, x_1, y_1, n
Dim Excel

'シェルオブジェクトの作成
Set Excel = WScript.CreateObject("Excel.Application")

'マウス定数
Const MOUSEEVENTF_ABSOLUTE = 32768
Const MOUSE_MOVE = &H1
Const MOUSEEVENTF_LEFTDOWN = &H2
Const MOUSEEVENTF_LEFTUP = &H4
x_1 = 300
y_1 = 300
MouseMove x_1 , y_1
for i = 0 to 100000
    If i mod 2 = 0 Then
        n = 5 * Int((10 * Rnd) + 1)
'MsgBox(n)
        x_1 = x_1 + n
	y_1 = y_1 - n
    Else
	x_1 = x_1 - n
	y_1 = y_1 + n
    End If
    MouseMove x_1 , y_1
    MouseClick
    WScript.Sleep 10000 + n * 1000
next

'クリック 
Sub MouseClick
    Dim dwFlags
    dwFlags = MOUSEEVENTF_LEFTDOWN or MOUSEEVENTF_LEFTUP
    Call API_mouse_event(dwFlags, 0, 0, 0, 0)
    WScript.Sleep 100
End Sub

'マウスポインタ移動
Sub MouseMove(x, y)
    Dim pos_x, pos_y, dwFlags
    Const SCREEN_X = 1920
    Const SCREEN_Y = 1080

    dwFlags = MOUSEEVENTF_ABSOLUTE + MOUSE_MOVE
    pos_x = Int(x * 65535 / SCREEN_X)
    pos_y = Int(y * 65535 / SCREEN_Y)
    Call API_mouse_event(dwFlags, pos_x, pos_y, 0, 0)
    WScript.Sleep 100
End Sub

'APIを叩く
Sub API_mouse_event(dwFlags, dx, dy, dwData, dwExtraInfo) 
    Dim strFunction 
    Const API_STRING = "CALL(""user32"",""mouse_event"",""JJJJJJ"", $1, $2, $3, $4, $5)" 
    strFunction = Replace(Replace(Replace(Replace(Replace(API_STRING, "$1", dwFlags), "$2", dx), "$3", dy), "$4", dwData), "$5", dwExtraInfo) 
    Call Excel.ExecuteExcel4Macro(strFunction) 
End Sub
