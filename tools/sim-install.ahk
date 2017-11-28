#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; A window's title can contain WinTitle anywhere inside it to be a match.
SetTitleMatchMode, 2

WinWait, Application Install - Security Warning, , 10
WinActivate
IfWinActive
	ControlClick, &Install
	WinMinimize