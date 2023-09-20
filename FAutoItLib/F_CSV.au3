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
#include "F_LOG.au3"

; ==============================================================================
;
; Description:     	Loads a CSV file to an array.
; Syntax:           F_CSV_LoadToArray( $file, $delimiter = ";" )
; Parameter(s):     $file - The CSV file to load
;					$delimiter - The separator string for the columns
; Requirement(s): 	File.au3, F_LOG.au3
; Return Value(s):  On Success - Returns an array with the CSV values
;					Amount lines: $array[0][0]
;					Amount columns: $array[0][1]
;                   On Failure - Returns Null
; Author(s):        <alexander@fürth.org>
; Note(s):          -
;
Func F_CSV_LoadToArray($file, $delimiter = ";")
	F_LOG_Information("Loading CSV-File '" & $file & "'")
	; Open file
	Local $hFile = FileOpen($file, $FO_READ)
	If $hFile = -1 Then
		F_LOG_Error("Can not open file '" & $file & "'")
		Return Null
	EndIf
	; Check linecount
	Local $lineCount = _FileCountLines($file)
	If $lineCount = 0 Then
		F_LOG_Error("Failed to load linecount")
		Return Null
	EndIf
	; Check columncount
	Local $columnCount = StringSplit(FileReadLine($hFile, 1), $delimiter)[0]
	If $columnCount < 2 Then ; CSV Minimum 2 Spalten
		$columnCount = 2
	EndIf
	; Create array and set sizes
	Local $arr[$lineCount + 1][$columnCount]
	$arr[0][0] = $lineCount		; Zeilenanzahl
	$arr[0][1] = $columnCount	; Spaltenanzahl
	; Parse values to the array
	For $i = 1 To ($lineCount) Step 1
		; Load and parse the line
		Local $line = FileReadLine($hFile, $i)
		Local $sLine = StringSplit($line, $delimiter)
		Local $colSize = $columnCount - 1
		; If a line has fewer columns than the first line
		If $sLine[0] < $columnCount Then
			$colSize = $sLine[0] - 1
		EndIf
		; Put linevalues into array
		For $j = 0 To ($colSize) Step 1
			$arr[$i][$j] = $sLine[$j + 1]
		Next
	Next
	; Close the file
	FileClose($hFile)
	Return $arr
EndFunc ; ==> F_CSV_LoadToArray

; ==============================================================================
;
; Description:     	Searches a CSV array for a value in a specific column.
; Syntax:           F_CSV_FindFirstValue( $arr, $value, $column = 0 )
; Parameter(s):     $arr - The CSV array
;					$value - The value to search
;					$column - The column to be searched
; Requirement(s): 	-
; Return Value(s):  On success - The line-index value
;                   On Failure - 0
; Author(s):        <alexander@fürth.org>
; Note(s):          -
;
Func F_CSV_FindFirstValue($arr, $value, $column = 0)
	For $i = 1 To $arr[0][0] Step 1
		If $arr[$i][$column] == $value Then
			Return $i
		EndIf
	Next
	Return 0
EndFunc ; ==> F_CSV_FindFirstValue

; ==============================================================================
;
; Description:     	Searches a CSV array for some values in a specific column.
; Syntax:           F_CSV_FindValues( $arr, $value, $column = 0 )
; Parameter(s):     $arr - The CSV array
;					$value - The value to search
;					$column - The column to be searched
; Requirement(s): 	-
; Return Value(s):  On success - An array, first value is the size
;                   On Failure - An empty array, with first value 0
; Author(s):        <alexander@fürth.org>
; Note(s):          -
;
Func F_CSV_FindValues($arr, $value, $column = 0)
	Local $bufArr[$arr[0][0] + 1]
	$bufArr[0] = 0
	Local $nextIndex = 1
	For $i = 1 To $arr[0][0] Step 1
		If $arr[$i][$column] == $value Then
			$bufArr[$nextIndex] = $i
			$nextIndex = $nextIndex + 1
			$bufArr[0] = $bufArr[0] + 1
		EndIf
	Next
	Local $retArr[$bufArr[0] + 1]
	$retArr[0] = $bufArr[0]
	For $i = 1 To $bufArr[0] Step 1
		$retArr[$i] = $bufArr[$i]
	Next
	Return $retArr
EndFunc ; ==> F_CSV_FindValues


