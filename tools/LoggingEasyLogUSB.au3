#AutoIt3Wrapper_Compression=3
#AutoIt3Wrapper_UseUpx=y
#AutoIt3Wrapper_Res_requestedExecutionLevel=requireAdministrator
#AutoIt3Wrapper_Add_Constants=n
#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 -w 7
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#RequireAdmin

#include <MsgBoxConstants.au3>
#include <WindowsConstants.au3>
#include 'log4a.au3'
#include 'WaitForControls.au3'

Const $TD_BTN_NEXT = '&Next >'
Const $TD_BTN_INSTALL = '&Install'
Const $TD_BTN_INSTALL2 = 'Install'
Const $TD_BTN_FINISH = '&Finish'
Const $TD_BTN_CANCEL = 'Cancel'
Const $TD_BTN_IAGREE = "I &accept the terms in the license agreement"
Const $TD_BTN_ALTFINISH = '&Finish'
Const $TD_BTN_ALLOW_ACCESS = '&Allow access'
Const $TD_BTN_REMOVE = '&Remove'
Const $TD_BTN_YES = '&Yes'
Const $TD_BTN_OK = 'OK'
Const $TD_BTN_TYPICAL = '&Typical'
Const $TD_EDIT_DATA = '99999'
Const $TD_TREE_NAME = 'Tree1'

Const $apptext = 'EasyLog USB Device Driver Installer'
Const $text = "EasyLog USB - InstallShield Wizard"
Const $class = "[CLASS:MsiDialogCloseClass]"
Const $stdClass = '[Class:#32770]'
Const $button1 = "[CLASS:Button; INSTANCE:1]"
Const $button2 = "[CLASS:Button; INSTANCE:2]"
Const $button3 = "[CLASS:Button; INSTANCE:3]"
Const $button4 = "[CLASS:Button; INSTANCE:4]"
Const $button5 = "[CLASS:Button; INSTANCE:5]"

#Region ;**** Logging ****
; Enable logging and don't write to stderr
_log4a_SetEnable()
; Write to stderr, set min level to warn, customize message format
_log4a_SetErrorStream()
_log4a_SetCompiledOutput($LOG4A_OUTPUT_FILE)
_log4a_SetMinLevel($LOG4A_LEVEL_DEBUG)
; If @compiled Then _log4a_SetMinLevel($LOG4A_LEVEL_WARN) ; Change the min level if the script is compiled
_log4a_SetFormat("${date} | ${host} | ${level} | ${message}")
#EndRegion ;**** Logging ****


Func Install()
    Local $handle = WinActivate($text)
    _log4a_Info($text & ' Handle :' & $handle)
    _log4a_Info('Begin Install()')
    #_checkClickCtrl($class, $text, $button1, $TD_BTN_NEXT, 0)
    #_checkClickCtrl($class, $text, $button3, $TD_BTN_IAGREE, 0)
    #_checkClickCtrl($class, $text, $button5, $TD_BTN_NEXT, 0)
    #_checkClickCtrl($class, $text, $button1, $TD_BTN_INSTALL, 0)
    #_checkClickCtrl($class, $text, $button1, $TD_BTN_FINISH, 0)

    $handle = WinActivate($apptext)
    _log4a_Info($apptext & ' Handle :' & $handle)
    Local $IsActive = WinActive($handle)

    If ($IsActive) Then
        ProcessClose("EL-USB Driver Setup.exe")
        Sleep(3000)
        ;~ Note that we could also look up the path from registry of the main installer here in case a custom install location was set on the first msi
        ;~ Also we could have just silent installed the first msi I think, lol, but, you need to learn.
        Run("C:\Program Files (x86)\EasyLog USB\EL-USB Driver Setup.exe")

        $handle = WinActivate($apptext)
        _log4a_Info($apptext & ' Handle :' & $handle)

        _checkClickCtrl($stdClass, $apptext, $button1, $TD_BTN_INSTALL2, 0)
        _checkClickCtrl($stdClass, 'Success', $button1, $TD_BTN_OK, 0)
    EndIf

    _log4a_Info('End Install()')

EndFunc   ;==>Install

Install()