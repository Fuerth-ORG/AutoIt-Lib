#cs
  MIT License
  
  Copyright (c) 2023 Fürth.ORG
  
  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:
  
  The above copyright notice and this permission notice shall be included in all
  copies or substantial portions of the Software.
  
  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.
#ce
#include-once
; Included Files
#include <File.au3>
#include <Date.au3>
; LOG-Configuration
Global $F_LOG_FILE = Null
Global $F_LOG_SHOWMSGBOX = False
Global $F_LOG_MSGBOXTIMEOUT = 0

;===============================================================================
;
; Description:		Logs an information to logfile and console.
; Syntax:			F_LOG_Information(
;					$msg = STRING, $msgBox = BOOL,$timeout = INT )
; Parameter(s):		$msg - The message to be output
; Requirement(s):	File.au3
; Return Value(s):	-
; Author(s):		<alexander@fürth.org>
; Note(s):			-
;
Func F_LOG_Information($msg)
	Local $msgBuf = "INFO       " & $msg
	Local $dateTime = _Date_Time_GetSystemTime()
	Local $dateTimeStr = _Date_Time_SystemTimeToDateTimeStr($dateTime, 1)
	ConsoleWrite($dateTimeStr & "    " & $msgBuf & @CRLF)
	If $F_LOG_FILE <> Null Then
		_FileWriteLog($F_LOG_FILE, $msgBuf)
	EndIf
	If $F_LOG_SHOWMSGBOX Then
		MsgBox(0x40, "Information", $msg, $F_LOG_MSGBOXTIMEOUT)
	EndIf
EndFunc ; ==> F_LOG_Information

;===============================================================================
;
; Description:		Logs an warning to logfile and console.
; Syntax:			F_LOG_Warning(
;					$msg = STRING, $msgBox = BOOL,$timeout = INT )
; Parameter(s):		$msg - The message to be output
; Requirement(s):	File.au3
; Return Value(s):	-
; Author(s):		<alexander@fürth.org>
; Note(s):			-
;
Func F_LOG_Warning($msg)
	Local $msgBuf = "WARNING    " & $msg
	Local $dateTime = _Date_Time_GetSystemTime()
	Local $dateTimeStr = _Date_Time_SystemTimeToDateTimeStr($dateTime, 1)
	ConsoleWrite($dateTimeStr & "    " & $msgBuf & @CRLF)
	If $F_LOG_FILE <> Null Then
		_FileWriteLog($F_LOG_FILE, $msgBuf)
	EndIf
	If $F_LOG_SHOWMSGBOX Then
		MsgBox(0x30, "Warning", $msg, $F_LOG_MSGBOXTIMEOUT)
	EndIf
EndFunc ; ==> F_LOG_Warning

;===============================================================================
;
; Description:		Logs an error to logfile and console.
; Syntax:			F_LOG_Error(
;					$msg = STRING, $msgBox = BOOL,$timeout = INT )
; Parameter(s):		$msg - The message to be output
; Requirement(s):	File.au3
; Return Value(s):	-
; Author(s):		<alexander@fürth.org>
; Note(s):			-
;
Func F_LOG_Error($msg)
	Local $msgBuf = "ERROR      " & $msg
	Local $dateTime = _Date_Time_GetSystemTime()
	Local $dateTimeStr = _Date_Time_SystemTimeToDateTimeStr($dateTime, 1)
	ConsoleWrite($dateTimeStr & "    " & $msgBuf & @CRLF)
	If $F_LOG_FILE <> Null Then
		_FileWriteLog($F_LOG_FILE, $msgBuf)
	EndIf
	If $F_LOG_SHOWMSGBOX Then
		MsgBox(0x10, "Error", $msg, $F_LOG_MSGBOXTIMEOUT)
	EndIf
EndFunc ; ==> F_LOG_Error


