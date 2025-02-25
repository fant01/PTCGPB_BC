#NoEnv
#SingleInstance, Force
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%
CoordMode, Pixel, Screen

#Include %A_ScriptDir%\Scripts\Include\Gdip_All.ahk
#Include %A_ScriptDir%\Scripts\Include\Gdip_Imagesearch.ahk
#Include %A_ScriptDir%\Scripts\Include\Gdip_Extra.ahk
#Include %A_ScriptDir%\Scripts\Include\OCR.ahk
#Include %A_ScriptDir%\Scripts\Include\Capture2Text.ahk

app := "C:\Capture2Text\Capture2Text_CLI.exe"
out = %A_ScriptDir%\Scripts\temp\tmp_friendcode.txt
RunWait, %app% --screen-rect "174 74 270 89" -o %out%,, Hide
If FileExist(out) {
    FileRead, friendCode, %out%
    friendCode := RTrim(friendCode, "`r`n")
}

RunWait, %app% --screen-rect "174 74 270 89" -o %out%,, Hide
If FileExist(out) {
    FileRead, friendCode, %out%
    friendCode := RTrim(friendCode, "`r`n")
}

MsgBox, %friendCode%`n%numFriends%

;;ret := Capture2Text([174, 74, 270,89])
;;MsgBox % ret

; 43, 199, 342, 126
; 28, 171, 270, 117
/*


area := GetArea()
hBitmap := HBitmapFromScreen(area["x"], area["y"], area["w"], area["h"])
pIRandomAccessStream := HBitmapToRandomAccessStream(hBitmap)
DllCall("DeleteObject", "Ptr", hBitmap)
text := ocr(pIRandomAccessStream, "en")
msg := area["x"] . " " . area["y"] . " " . area["w"] . " " . area["h"] . "`n" . text
MsgBox % msg
;43, 170, 269, 110
;75,166,274,90
;41,193,249,112
;33,79,407,90
;260,74,183,93
ExitApp

*/

; 193, 156, 80, 70
If (!pToken := Gdip_Startup())
{
	MsgBox, 16, gdiplus error!, Gdiplus failed to start. Please ensure you have gdiplus on your system.
	Return
}

if(true)
{
	hwnd := WinExist("Main")
	pBitmap := Gdip_BitmapFromScreen( "hwnd:" hwnd)
	pBitmap2 := Gdip_CropImage(pBitmap, 174, 74, 100, 15)
	;;pBitmap2 := Gdip_CropImage(pBitmap, 0, 0, 500, 800)
	pBitmap3 := Gdip_ResizeBitmap(pBitmap2, 2000, true)
	hBitmap := Gdip_CreateHBITMAPFromBitmap(pBitmap3)
	;hBitmap2 := ToGrayscale(hBitmap)

	ret := SavePicture(hBitmap, "biggrey1.png")
	pIRandomAccessStream := HBitmapToRandomAccessStream(hBitmap)
	text := ocr(pIRandomAccessStream, "en")
	MsgBox %text%

	DeleteObject(hBitmap)
	DeleteObject(hBitmap2)
	Gdip_DisposeImage(pBitmap)
	Gdip_DisposeImage(pBitmap2)
	Gdip_DisposeImage(pBitmap3)

	ExitApp	
}

winTitle := "Main"
WinGetPos, x, y, w, h, %winTitle%
newX := 174 + x
newY := 75 + y
pBitmap := Gdip_BitmapFromScreen(newX "|" newY "|" 98 "|" 13)
ret := Gdip_SaveBitmapToFile(pBitmap, "small1.png")
pBitmap := Gdip_ResizeBitmap(pBitmap, 1500, true)
ret := Gdip_SaveBitmapToFile(pBitmap, "big1.png")
hBitmap := Gdip_CreateHBITMAPFromBitmap(pBitmap)
hBitmap2 := ToGrayscale(hBitmap)
ret := SavePicture(hBitmap2, "biggrey1.png")
pIRandomAccessStream := HBitmapToRandomAccessStream(hBitmap2)
text := ocr(pIRandomAccessStream, "en-US")

DllCall("DeleteObject", "Ptr", hBitmap)
DllCall("DeleteObject", "Ptr", hBitmap2)
Gdip_DisposeImage(pBitmap)
; msg := area["x"] . " " . area["y"] . " " . area["w"] . " " . area["h"] . "`n" . text
;;MsgBox % text
;;ExitApp

newX := 127 + x
newY := 108 + y
pBitmap := Gdip_BitmapFromScreen(newX "|" newY "|" 37 "|" 22)
ret := Gdip_SaveBitmapToFile(pBitmap, "small2.png")
pBitmap := Gdip_ResizeBitmap(pBitmap, 1500, true)
ret := Gdip_SaveBitmapToFile(pBitmap, "big2.png")
hBitmap := Gdip_CreateHBITMAPFromBitmap(pBitmap)
hBitmap2 := ToGrayscale(hBitmap)
pIRandomAccessStream := HBitmapToRandomAccessStream(hBitmap)
text2 := ocr(pIRandomAccessStream, "en-US")
DllCall("DeleteObject", "Ptr", hBitmap)
DllCall("DeleteObject", "Ptr", hBitmap2)
Gdip_DisposeImage(pBitmap)

MsgBox, %text% `n %text2%
ExitApp


; 127 108 37 22 <-- friend count
; 174 75 98 13 <-- fID



hBitmap := HBitmapFromScreen(newX, newY, 98, 13)
pIRandomAccessStream := HBitmapToRandomAccessStream(hBitmap)
; DllCall("DeleteObject", "Ptr", hBitmap)
text := ocr(pIRandomAccessStream, "en")
MsgBox, % text
ExitApp




area := GetArea()
pBitmap := Gdip_BitmapFromScreen(area.x "|" area.y "|" area.w "|" area.h)
pBitmap := Gdip_ResizeBitmap(pBitmap, 500, true)
ret := Gdip_SaveBitmapToFile(pBitmap, "out.png")
hBitmap := Gdip_CreateHBITMAPFromBitmap(pBitmap)
pIRandomAccessStream := HBitmapToRandomAccessStream(hBitmap)
DllCall("DeleteObject", "Ptr", hBitmap)
Gdip_DisposeImage(pBitmap)
text := ocr(pIRandomAccessStream, "en-US")
msg := area["x"] . " " . area["y"] . " " . area["w"] . " " . area["h"] . "`n" . text
MsgBox % msg
ExitApp
; 127 108 37 22 <-- friend count
; 174 75 98 13 <-- fID

/*
hbm := from_window2(WinExist("Main"))
pIRandomAccessStream := HBitmapToRandomAccessStream(hBitmap)
; DllCall("DeleteObject", "Ptr", hBitmap)
text := ocr(pIRandomAccessStream, "en")
; DllCall("DeleteObject", "Ptr", pIRandomAccessStream)
MsgBox, % text
*/

/*
winTitle := "Main"
WinGetPos, x, y, w, h, %winTitle%
newX := 15 + x
newY := 53 + y
hBitmap := HBitmapFromScreen(newX, newY, 234, 198)
pIRandomAccessStream := HBitmapToRandomAccessStream(hBitmap)
DllCall("DeleteObject", "Ptr", hBitmap)
text := ocr(pIRandomAccessStream, "en")
DllCall("DeleteObject", "Ptr", pIRandomAccessStream)
MsgBox, % text
ExitApp
*/

winTitle := "Main"
WinGetPos, x, y, w, h, %winTitle%
newX := 260 + x
newY := 100 + y
hBitmap := HBitmapFromScreen(newX, newY, 200, 100)
pIRandomAccessStream := HBitmapToRandomAccessStream(hBitmap)
; DllCall("DeleteObject", "Ptr", hBitmap)
text := ocr(pIRandomAccessStream, "en")
MsgBox, % text
ExitApp
/*

winTitle := "Main"
WinGetPos, x, y, w, h, %winTitle%
newX := 172 + x
newY := 73 + y
MsgBox, %newX% // %newY%
hBitmap := HBitmapFromScreen(0, 0, 1000, 1000)
pIRandomAccessStream := HBitmapToRandomAccessStream(hBitmap)
txt := ocr(pIRandomAccessStream, "en")
msgbox % txt
temp := "x"
;MsgBox % txt

*/

;;pBitmap := from_window(WinExist(winTitle))
;;pBitmap2 := Gdip_CropImage(pBitmap, 172, 73, 100, 20)
;;ocr(pBitmap2, "en")
;;hBitmap := HBitmapFromScreen(0, 0, A_ScreenWidth, A_ScreenHeight)
;;pIRandomAccessStream := HBitmapToRandomAccessStream(hBitmap)

;;hBitmap := from_window2(WinExist(winTitle))
;;pIRandomAccessStream := HBitmapToRandomAccessStream(hBitmap)
;;txt := ocr(pIRandomAccessStream, "en")
;;MsgBox % txt
;;; Gdip_DisposeImage(hBitmap)
;;DllCall("DeleteObject", "ptr", hBitmap)

;pToken := Gdip_Startup()
;pBitmap := Gdip_CreateBitmapFromFile("lasererror.png")
;Gdip_GetDimensions(pBitmap, w, h)
;pBitmap2 := Gdip_CropImage(pBitmap, 50, 50, w-100, h-100)
;Gdip_SaveBitmapToFile(pBitmap2, "out.jpg")
;Gdip_DisposeImage(pBitmap), Gdip_DisposeImage(pBitmap2)
;Gdip_Shutdown(pToken)
;return



from_window(ByRef image) {
	; Thanks tic - https://www.autohotkey.com/boards/viewtopic.php?t=6517

	; Get the handle to the window.
	image := (hwnd := WinExist(image)) ? hwnd : image

	; Restore the window if minimized! Must be visible for capture.
	if DllCall("IsIconic", "ptr", image)
		DllCall("ShowWindow", "ptr", image, "int", 4)

	; Get the width and height of the client window.
	VarSetCapacity(Rect, 16) ; sizeof(RECT) = 16
	DllCall("GetClientRect", "ptr", image, "ptr", &Rect)
		, width  := NumGet(Rect, 8, "int")
		, height := NumGet(Rect, 12, "int")

	; struct BITMAPINFOHEADER - https://docs.microsoft.com/en-us/windows/win32/api/wingdi/ns-wingdi-bitmapinfoheader
	hdc := DllCall("CreateCompatibleDC", "ptr", 0, "ptr")
	VarSetCapacity(bi, 40, 0)                ; sizeof(bi) = 40
		, NumPut(       40, bi,  0,   "uint") ; Size
		, NumPut(    width, bi,  4,   "uint") ; Width
		, NumPut(  -height, bi,  8,    "int") ; Height - Negative so (0, 0) is top-left.
		, NumPut(        1, bi, 12, "ushort") ; Planes
		, NumPut(       32, bi, 14, "ushort") ; BitCount / BitsPerPixel
		, NumPut(        0, bi, 16,   "uint") ; Compression = BI_RGB
		, NumPut(        3, bi, 20,   "uint") ; Quality setting (3 = low quality, no anti-aliasing)
	hbm := DllCall("CreateDIBSection", "ptr", hdc, "ptr", &bi, "uint", 0, "ptr*", pBits:=0, "ptr", 0, "uint", 0, "ptr")
	obm := DllCall("SelectObject", "ptr", hdc, "ptr", hbm, "ptr")

	; Print the window onto the hBitmap using an undocumented flag. https://stackoverflow.com/a/40042587
	DllCall("PrintWindow", "ptr", image, "ptr", hdc, "uint", 0x3) ; PW_CLIENTONLY | PW_RENDERFULLCONTENT
	; Additional info on how this is implemented: https://www.reddit.com/r/windows/comments/8ffr56/altprintscreen/

	; Convert the hBitmap to a Bitmap using a built in function as there is no transparency.
	DllCall("gdiplus\GdipCreateBitmapFromHBITMAP", "ptr", hbm, "ptr", 0, "ptr*", pBitmap:=0)

	; Cleanup the hBitmap and device contexts.
	DllCall("SelectObject", "ptr", hdc, "ptr", obm)
	DllCall("DeleteObject", "ptr", hbm)
	DllCall("DeleteDC",	 "ptr", hdc)

	return pBitmap
}

from_window2(ByRef image) {
	; Thanks tic - https://www.autohotkey.com/boards/viewtopic.php?t=6517

	; Get the handle to the window.
	image := (hwnd := WinExist(image)) ? hwnd : image

	; Restore the window if minimized! Must be visible for capture.
	if DllCall("IsIconic", "ptr", image)
		DllCall("ShowWindow", "ptr", image, "int", 4)

	; Get the width and height of the client window.
	VarSetCapacity(Rect, 16) ; sizeof(RECT) = 16
	DllCall("GetClientRect", "ptr", image, "ptr", &Rect)
		, width  := NumGet(Rect, 8, "int")
		, height := NumGet(Rect, 12, "int")

	; struct BITMAPINFOHEADER - https://docs.microsoft.com/en-us/windows/win32/api/wingdi/ns-wingdi-bitmapinfoheader
	hdc := DllCall("CreateCompatibleDC", "ptr", 0, "ptr")
	VarSetCapacity(bi, 40, 0)                ; sizeof(bi) = 40
		, NumPut(       40, bi,  0,   "uint") ; Size
		, NumPut(    width, bi,  4,   "uint") ; Width
		, NumPut(  -height, bi,  8,    "int") ; Height - Negative so (0, 0) is top-left.
		, NumPut(        1, bi, 12, "ushort") ; Planes
		, NumPut(       32, bi, 14, "ushort") ; BitCount / BitsPerPixel
		, NumPut(        0, bi, 16,   "uint") ; Compression = BI_RGB
		, NumPut(        3, bi, 20,   "uint") ; Quality setting (3 = low quality, no anti-aliasing)
	hbm := DllCall("CreateDIBSection", "ptr", hdc, "ptr", &bi, "uint", 0, "ptr*", pBits:=0, "ptr", 0, "uint", 0, "ptr")
	obm := DllCall("SelectObject", "ptr", hdc, "ptr", hbm, "ptr")

	; Print the window onto the hBitmap using an undocumented flag. https://stackoverflow.com/a/40042587
	DllCall("PrintWindow", "ptr", image, "ptr", hdc, "uint", 0x3) ; PW_CLIENTONLY | PW_RENDERFULLCONTENT
	; Additional info on how this is implemented: https://www.reddit.com/r/windows/comments/8ffr56/altprintscreen/

	; Convert the hBitmap to a Bitmap using a built in function as there is no transparency.
	;;;; DllCall("gdiplus\GdipCreateBitmapFromHBITMAP", "ptr", hbm, "ptr", 0, "ptr*", pBitmap:=0)

	; Cleanup the hBitmap and device contexts.
	DllCall("SelectObject", "ptr", hdc, "ptr", obm)
	;;;;;DllCall("DeleteObject", "ptr", hbm)
	DllCall("DeleteDC",	 "ptr", hdc)

	return hbm
}