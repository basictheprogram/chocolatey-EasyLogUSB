#include-once
#include <Timers.au3>
#include "log4a.au3"

; #FUNCTION# ====================================================================================================================
; Name ..........: _checkClickCtrl
; Description ...: Automatically wait for a control to exist. Forever or Limited
; Syntax ........: _checkClickCtrl($formclass, $text, $ctrl, $ctrltxt, $timeout, $delayafter
; Parameters ....: $formclass           - Form Class info.
;                  $text                - Windows text to match
;                  $ctrl                - Class of Copntrol
;                  $ctrltxt             - Text of the Control
;                  $timeout             - Timeout = 0 by default, millisecond timer
;                  $delayafter          - Time in milliseconds to delay after operation carried out
; Return values .: None
; Author ........: Earthshine
; Modified ......:
; Remarks .......:	Waits for each button indefinatly, unless you give it a timeout
;					Logger found here: https://www.autoitscript.com/forum/topic/156196-log4a-a-logging-udf/
; Related .......:
; Link ..........:
; Example(s) ....: 	_checkClickCtrl ('[CLASS:#32770]', 'ApplicationX - InstallShield Wizard', '[CLASS:Button; INSTANCE:1]', , '&Next >' 5000, 0)
; 				 	_checkClickCtrl($formclass, $text, $button2, $TD_BTN_REMOVE, 0, 0)
; 					_checkClickCtrl($formclass, $text, $button3, $TD_BTN_NEXT, 0, 500)
; 					_checkClickCtrl($formclass, $text, $button1, $TD_BTN_YES, 0, 0)
; 					_checkClickCtrl($formclass, $text, $button4, $TD_BTN_FINISH, 0, 0)
; ===============================================================================================================================
Func _checkClickCtrl($formclass, $text, $ctrl, $ctrltxt, $timeout = 0, $delayafter = 0)
	_log4a_Info("_checkClickCtrl():Begin")
	_log4a_Info("Searching for Formclass: " & $formclass)
	_log4a_Info("Searching for Text: " & $text)
	_log4a_Info("Searching for Control: " & $ctrl)
	_log4a_Info("Searching for Ctrl Txt: " & $ctrltxt)
	_log4a_Info("Timeout: " & $timeout)
	_log4a_Info("Time Delay (after click): " & $delayafter)
	Local $time_run = _Timer_Init()
	While (1)
		If WinExists($formclass) Then
			Local $hCtrl = ControlGetHandle($text, '', $ctrl)
			If $hCtrl Then
				If ($timeout > 0) Then
					_log4a_Info(_Timer_Diff($time_run))
					If (_Timer_Diff($time_run) > $timeout) Then
						_log4a_Info("ExitLoop:Timeout - " & $ctrl)
						ExitLoop
					EndIf
				EndIf
				Local $hCtrlHandle = ControlGetText($text, '', $ctrl)
				_log4a_Info("Control Text Search: " & $ctrltxt)
				_log4a_Info("Control Text Found: " & $hCtrlHandle)
				If ($hCtrlHandle == $ctrltxt) Then
					; we got the handle, so the button is there
					; now do whatever you need to do
					_log4a_Info("Found Formclass: " & $formclass)
					_log4a_Info("Found Text: " & $text)
					_log4a_Info("Found Control: " & $ctrl)
					_log4a_Info("Found Ctrl Txt: " & $ctrltxt)
					_log4a_Info("Timeout: " & $timeout)
					_log4a_Info("Time Delay (after click): " & $delayafter)
					_log4a_Info($ctrl)
					Local $return = ControlClick($formclass, '', $ctrl)
					If ($return) Then
						_log4a_Info('Control ' & $ctrl & ' return code success: ' & $return)
						If ($delayafter > 0) Then
							Sleep($delayafter)
						EndIf
					Else
						_log4a_Info('Control ' & $ctrl & ' return code error: ' & $return)
					EndIf
					_log4a_Info("ExitLoop:Normal - " & $ctrl)
					ExitLoop
				EndIf
			EndIf
		EndIf
	WEnd
	_log4a_Info("_checkClickCtrl():End")
EndFunc   ;==>_checkClickCtrl


