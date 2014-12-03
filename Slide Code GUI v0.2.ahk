;Polaris Slide Code Generator - GUI Enabled Version
; Version 0.2

;Set start point for the script
BeginScript:

;Build the GUI
Gui, New
Gui, Font, s10
Gui, Add, Text,, Please provide a code for the slidedeck.
Gui, Add, Edit, vSlideCode

Gui, Add, Text,, What's the slide's file name?
Gui, Add, Edit, vSlideName

Gui, Add, Text,, Provide a URL for the slide's link.
Gui, Add, Edit, vSlideLink

Gui, Add, Text,, What should the ALT text be for the slde?
Gui, Add, Edit, vAltText

Gui, Add, Text, ym, What is the date of the event?
Gui, Add, MonthCal, vEventDate

Gui, Add, Text,, What time should the slide come down?
Gui, Add, Edit, vDownHour, HH
Gui, Add, Edit, VDownMinute, MM

Gui, Add, Text,, When should the slide go live?
Gui, Add, MonthCal, vEventLive

Gui, Add, Button, default, Submit

Gui, Show, AutoSize Center, Slide Code Generator
return

;Begin slide code generation.
ButtonSubmit:
Gui, Submit

;Gather event date and parse for placement.
EventYear := SubStr(EventDate, 1, 4)
EventMonth := SubStr(EventDate, 5, 2)
EventDay := SubStr(EventDate, 7, 2)

;Gather go live date and parse for placement.
LiveYear := SubStr(EventLive, 1, 4)
LiveMonth := SubStr(EventLive, 5, 2)
LiveDay := SubStr(EventLive, 7, 2)

Clipboard = <`% System.DateTime %SlideCode%StartDate = new System.DateTime`(%LiveYear%`, %LiveMonth%`, %LiveDay%`);`nSystem.DateTime %SlideCode%EndDate = new System.DateTime`(%EventYear%`, %EventMonth%`, %EventDay%`, %DownHour%`, %DownMinute%`, 00);`nif `(DateTime.Now > %SlideCode%StartDate && DateTime.Now < %SlideCode%EndDate`) { `%>`n<a href=`"%SlideLink%`"><img src=`"custom/portal/version1/images/%SlideName%`" width=`"740`" border=`"0`" alt=`"%AltText%`"></a>`n<`%`}`%>

;Code generated and sitting on clipboard, ask if another slide is needed.
MsgBox, 4,, Slide code on clipboard. Do you need another?
	IfMsgBox, Yes
		Goto, BeginScript
	IfMsgBox, No
		ExitApp
	
GuiClose:
ExitApp
