#NoEnv
#SingleInstance, force
SetBatchLines, -1
FileEncoding , CP65001
Menu Tray, Icon, E:\13PF\XY\Data\Icons\608.ico
SetWorkingDir %A_ScriptDir%
dirLL=E:\06GAME
; dirR=\\SAMSUNG\E\24YouTube
dirR=\\INTEL\ssE\24YouTube
; dirR=E:\06GAME
exeCopy = "E:\13PF\FastCopy\FastCopy.exe"
sublimePath="E:\13PF\ST3\sublime_text.exe"
dirLtxt=dirL.txt
dirRtxt=dirR.txt
Source=E:\03UTILITY
Destination=E:\05VIDEO
extt=*.*
global name,dirL,dirR,LVArray
FileDelete %dirLtxt%
FileDelete %dirRtxt%  ; Delete for security reasons.

; FileDelete outdirL.txt
; FileDelete outdirR.txt



Gui +Resize

; Gui Add, Button, x3 y2 w30 h20 gMenu,>>
Gui Add, Picture,x3 y4 w16 h16 gMenu, icons\menu.png
; Gui Add, ComboBox,x+3 y2 w220 r8 vdirLL ReadOnly, E:\03UTILITY||E:\07INET|E:\24YouTube|
Gui Add, Edit,    x+3  y2 w220 h20 vdirLL ReadOnly , E:\03UTILITY
Gui Add, Button,  x+3  y2 w30  h20 gSource, >>
Gui Add, ComboBox,x+8  y2 w80  r8 hwndCB1 vCB1, *||
Gui Add, Button,  x+17 y2 w60  h20 , Unique
Gui Add, Button,  x+5  y2 w60  h20 , Unequal
Gui Add, Button,  x+5  y2 w60  h20 , Equal
Gui Add, Picture, x+11 y2 w20  h20 hwndst3Btn gst3Btn ,E:\13PF\XY\Data\Icons\sublime_text.ico

Gui Add, Edit,    x790  y2 w220 h20 hwnddirR vdirR ReadOnly ,E:\05VIDEO
; Gui Add, ComboBox,x690 y2 w220 r8 vdirR ,E:\05VIDEO||\\INTEL\ssE\24YouTube|E:\24YouTube|
Gui Add, Button,  x+4   y2 w30 h20 hwndDest gDestination, >>

Gui Add, Picture ,x5   y24 w20 h20 gUnchckall, E:\13PF\XY\Data\Icons\unchecked.png
Gui Add, Picture ,x+5  y24 w22 h20 gArrow_left , icons\arrow_right_15600.png
Gui Add, Edit,    x+5  y24 w40 vSearchTermL gSearchL ,vt
Gui Add, CheckBox,x+25 y24 w60 h20 vCBsubDirL, SubDirL

Gui Add, Picture ,x660 y24 w22  h20 hwndArrow_r gArrow_right, icons\arrow_left_15601.png
Gui Add, Edit,    x+9  y24 w40 vSearchTermR gSearchR ,t
Gui Add, CheckBox,x+25 y24 w60  h20 vCBsubDirR, SubDirR
Gui Add, ListView,x3  y48 w550 h610 Checked +grid Count 794 hwndLV1 gLV1 vLV1,time|name
            ; Gui,default
            LV_ModifyCol(1,"22 sortdesc ") ;time
            LV_ModifyCol(2,"670 Left")
Gui Add, ListView,x+3 y48 w550 h610 Checked Grid hwndLV2 gLV2 vLV2 altsubmit,time|name

            LV_ModifyCol(1,"22 sortdesc") ;time
            LV_ModifyCol(2,"670  Left")
            fileread,a, %dirRtxt% ;*P65001
            a :=Trim(a, OmitChars := " `n") ;delit last empty line

            Loop, Parse, a, `n, `r
                     {
                     StringSplit,C, A_LoopField, %A_Tab%
                     LV_ModifyCol(1,"22 sortdesc") ;time
                     LV_Add("",c1,c2) ;vybor colonny
                     }
Gui, Add, StatusBar,, Bar's starting text (omit to start off empty).



Gui Show , Center y6  w1110  h680,Alt_DirComp
Return

Menu:
Menu MMM, add,E:\24YouTube ====> \\INTEL\ssE\24YouTube, Handler1
Menu MMM, add,E:\24YouTube ====> E:\03UTILITY, Handler2
Menu MMM, add,E:\09MUZ\zzmuz ====> \\INTEL\ssE\09MUZ\zzmuz, Handler3
Menu MMM, Show
return
Handler1:
    GuiControl,,Edit1,E:\24YouTube
    GuiControl,,Edit3,\\INTEL\ssE\24YouTube
return
Handler2:
    GuiControl,,Edit1,E:\24YouTube
    GuiControl,,Edit3,E:\03UTILITY
return
Handler3:
    GuiControl,,Edit1,E:\09MUZ\zzmuz
    GuiControl,,Edit3,\\INTEL\ssE\09MUZ\zzmuz
return



ButtonUnique:
    gui Submit, NoHide

    Source=%dirLL%
    Destination=%dirR%
    GuiControlGet, var11, , CBsubDirL
    if var11 = 1
      {Recurs=R
            }
    Else
      {Recurs=
            }
    If Source =
    Return
    If Destination =
    Return
    UnwantedDir =(join|C:\Windows|RECYCLE.BIN|Fashion|C:\Program Files)
    ExcludeDir := RegExReplace(UnwantedDir,"\\","." )
    CB1List := ""
    Loop, Files, %Source%\*.*,FD%Recurs%
    {
        FileGetAttrib, Attributes, %A_LoopFileLongPath%
        if !InStr(Attributes, "D") {
            if !InStr(Attributes, "H") {
                if !InStr(CB1List, A_LoopFileExt) {
                    CB1List .= A_LoopFileExt "|"
                    GuiControl, , CB1,  |%CB1List%
        }
        }
        }

    }
    ; Loop,%Source%\*,0,1
    Files := A_Index
    DF = 0
    STrim := StrLen(Source)+1
    ; Files := 100/Files
    ; SetTimer,Prog,1000
    Gui,ListView, LV1
    LV_Delete()

    LVArra  := {}
    extArra := [*.]

    Loop, Files, %Source%\*%CB1%,FD%Recurs%
    ; Loop,%Source%\*,0,1
    {
        FileGetAttrib, Attributes, %A_LoopFileLongPath% ;zdes kavycki ne stavit
        if !InStr(Attributes, "D") {
            extArra.Push(A_LoopFileExt)
            GameList .= A_LoopFileExt "|"
            ; GuiControl, , CB1,  |%GameList%
            ; SplitPath, A_LoopFileExt,,,, FileExt
            ; List .= FileExt "|"
            ; MsgBox % List
            ; Continue
        }

        if RegExMatch(A_LoopFileLongPath,ExcludeDir)
        ; If A_LoopFileLongPath contains $RECYCLE.BIN
            Continue



        LVArra.Push({1:A_LoopFileTimeCreated,2:A_LoopFileName}) ;a_loopfilefullpath
        TotalItemsLV1 := LVArra.Length()

        SSize := A_LoopFileSize
        DFile := Destination SubStr(A_LoopFileLongPath,STrim)
        FileGetSize,DSize,% DFile

      ; Msgbox %SSize%   %DFile%

        ; GuiControl,,Edit1,% A_LoopFileLongPath
        ; GuiControl,,Edit3,% DFile
        ; CIndex := A_Index
        ; GuiControl,,Button3,% DF "/" A_Index
        If SSize != %DSize%
        {
            List .= A_LoopFileLongPath " - " SSize "`n" DFile " - " DSize "`n`n"
            DF += 1
            If SSize =
            {
                ; Msgbox % A_LoopFileLongPath
                ; FileAppend  %A_LoopFileLongPath% "`n", outdirtdi.txt
                LV_Add("",A_LoopFileTimeCreated,A_LoopFileName)
                Continue
            }
            If DSize =
            {

                Gui,ListView, LV1
                    if var11 = 1
                        {
                        DFile :=  SubStr(A_LoopFileLongPath,STrim)
                        LV_Add("",A_LoopFileTimeCreated,DFile) ;A_LoopFileName
                        ; MsgBox, % DFile
                        }
                    Else {
                        LV_Add("",A_LoopFileTimeCreated,A_LoopFileName)

                        }
                ; FileAppend %A_LoopFileTimeCreated% `t %A_LoopFileName% `n, Missing_in_R.txt



                ; Msgbox "nrtu v Right" %A_LoopFileLongPath%
                Continue
            }
            Else
            {
                Gui,ListView, LV2
                ; FileAppend %A_LoopFileTimeCreated% `t %A_LoopFileName% `n, difrent.txt
                ; Msgbox    %SSize%  %DSize% %A_LoopFileLongPath%
                LV_ModifyCol(1,22)

                ; LV_Add("",A_LoopFileTimeCreated,A_LoopFileName)
                ; FileAppend  %A_LoopFileLongPath% "`n", outdirR.txt
            }


        }

    }

    Gui,ListView, LV1
    LV_DeleteCol(3)
    LV_ModifyCol(1,"22 sortdesc") ;time
    LV_ModifyCol(2,"700 Left") ;name


    GuiControlGet, var12, , CBsubDirR
        if var12 = 1
          {Recur=R
                }
        Else
          {Recur=
                }
    Loop, Files, %Destination%\*.*,FD%Recur%
    ; Loop,%Destination%\*,0,1
    Files := A_Index
    DF = 0
    STrim := StrLen(Destination)+1
    ; Files := 100/Files
    ; SetTimer,Prog,1000
    Gui,ListView, LV2
    LV_Delete()
    LVArray := {}
    Loop, Files, %Destination%\*%CB1%,FD%Recur%
    ; Loop,%Destination%\*,0,1
    {
    	LVArray.Push({1:A_LoopFileTimeCreated,2:A_LoopFileName}) ;
        TotalItemsLV2 := LVArray.Length()

        SSize := A_LoopFileSize
        DFile := Source SubStr(A_LoopFileLongPath,STrim)
        FileGetSize,DSize,% DFile

        ; Msgbox %SSize%   %DSize%

        ; GuiControl,,Edit1,% A_LoopFileLongPath
        ; GuiControl,,Edit3,% DFile
        ; CIndex := A_Index
        ; GuiControl,,Button3,% DF "/" A_Index
        If SSize != %DSize%
        {
            List .= A_LoopFileLongPath " - " SSize "`n" DFile " - " DSize "`n`n"
            DF += 1
            If SSize =
            {
                ; Msgbox % A_LoopFileLongPath
                ; FileAppend  %A_LoopFileLongPath% "`n", outdirtdi.txt
                LV_Add("",A_LoopFileTimeCreated,A_LoopFileName)
                Continue
            }
            If DSize =
            {
                ; LV_Add("",DFile,"Missing")
                Gui,ListView, LV2
                ; FileAppend %A_LoopFileTimeCreated% `t %A_LoopFileName% `n, Missing_in_L.txt
                    if var12 = 1
                        {

                        DFile :=  SubStr(A_LoopFileLongPath,STrim)
                        LV_Add("",A_LoopFileTimeCreated,DFile) ;A_LoopFileName
                        ; MsgBox, % DFile
                        }
                    Else {

                        LV_Add("",A_LoopFileTimeCreated,A_LoopFileName)
                        }

                ; Msgbox "netu v Left" %A_LoopFileLongPath%
                Continue
            }
            Else
            {
                Gui,ListView, LV1
                ; FileAppend %A_LoopFileTimeCreated% `t %A_LoopFileName% `n, difrent.txt
                ; Msgbox    %SSize%  %DSize% %A_LoopFileLongPath%
                ; LV_Add("",A_LoopFileTimeCreated,A_LoopFileName)
                ; FileAppend  %A_LoopFileLongPath% "`n", outdirR.txt
            }
        }
    }
    SB_SetText( "  Items in First LV " . TotalItemsLV1 . "   Items in Second LV  " . TotalItemsLV2)
    Gui,ListView, LV2
                LV_DeleteCol(3)
                LV_ModifyCol(1,"22 sortdesc") ;time
                LV_ModifyCol(2,"700 Left")

; For index, value in extArra
;     MsgBox % "Item " index " is '" value "'"

    ; GuiControl,,PG,100
    ; SetTimer,Prog,Off
    ; MsgBox,Done
    ; Clipboard := List
    ; GuiControl,,Edit1,% Source
    ; GuiControl,,Edit3,% Destination
    ; GuiControl,,Button3,Unequal
    Return

ButtonUnequal:
    gui Submit, NoHide
    Destination=%dirR%
    Source=%dirLL%
    If Source =
    Return
    If Destination =
    Return
    Loop, Files, %Source%\*.*,FD%Recurs%
    ; Loop,%Source%\*,0,1
    Files := A_Index
    DF = 0
    STrim := StrLen(Source)+1
    ; Files := 100/Files
    ; SetTimer,Prog,1000
    Gui,ListView, LV1
    LV_Delete()
    LV_InsertCol(3,"80 Left","size")
    LV_DeleteCol(4)
    LV_ModifyCol(2,"439 sortdesc Left")

    Loop, Files, %Source%\*.*,FD%Recurs%
    ; Loop,%Source%\*,0,1
    {
        SSize := A_LoopFileSize
        DFile := Destination SubStr(A_LoopFileLongPath,STrim)
        FileGetSize,DSize,% DFile
      ; Msgbox %SSize%   %DSize%

        ; GuiControl,,Edit1,% A_LoopFileLongPath
        ; GuiControl,,Edit3,% DFile
        ; CIndex := A_Index
        ; GuiControl,,Button3,% DF "/" A_Index
        If SSize != %DSize%
            {
                List .= A_LoopFileLongPath " - " SSize "`n" DFile " - " DSize "`n`n"
                DF += 1
                If SSize =
                {

              ; Msgbox % A_LoopFileLongPath
                ; FileAppend  %A_LoopFileLongPath% "`n", outdirtdi.txt
                LV_Add("",A_LoopFileTimeCreated,A_LoopFileName)
                    Continue
                }
                If DSize !=
                {
                    ; LV_Add("",DFile,"Missing")
              Gui,ListView, LV1
              ; FileAppend %A_LoopFileTimeCreated% `t %A_LoopFileName% `n, Missing_in_R.txt
              LV_Add("",A_LoopFileTimeCreated,A_LoopFileName,A_LoopFileSize)

              ; Msgbox "nrtu v Right" %A_LoopFileLongPath%
                    Continue
                }
                Else
            {
              Gui,ListView, LV1
              ; FileAppend %A_LoopFileTimeCreated% `t %A_LoopFileName% `n, difrent.txt
              LV_ModifyCol(1,"22 sortdesc") ;time
              LV_ModifyCol(2,"439 Left") ;time
              ; LV_Add("",c1,c2,c3) ;vybor colonny
                ; Msgbox    %SSize%  %DSize% %A_LoopFileLongPath%
            ; LV_Add("",A_LoopFileTimeCreated,A_LoopFileName)
            ; LV_Add("", , ,A_LoopFileSize )
            ; FileAppend  %A_LoopFileLongPath% "`n", outdirR.txt
        }
        }
    }
    ; =====================================================================================

    Loop, Files, %Destination%\*.*,FD%Recurs%
    ; Loop,%Destination%\*,0,1
    Files := A_Index
    DF = 0
    STrim := StrLen(Destination)+1
    Gui,ListView, LV2
    LV_ModifyCol(2,"439 Left")
    LV_InsertCol(3,"80  Left" , "size")
    LV_DeleteCol(4)
    LV_Delete()
    Loop, Files, %Destination%\*.*,FD%Recurs%
    ; Loop,%Destination%\*,0,1
    {
      SSize := A_LoopFileSize
      DFile := Source SubStr(A_LoopFileLongPath,STrim)
      FileGetSize,DSize,% DFile
      ; Msgbox %SSize%   %DSize%

      ; GuiControl,,Edit1,% A_LoopFileLongPath
      ; GuiControl,,Edit3,% DFile

      If SSize != %DSize%
          {
            List .= A_LoopFileLongPath " - " SSize "`n" DFile " - " DSize "`n`n"
            DF += 1
            If SSize =
            {
              ; Msgbox % A_LoopFileLongPath
              ; FileAppend  %A_LoopFileLongPath% "`n", outdirtdi.txt
              LV_Add("",A_LoopFileTimeCreated,A_LoopFileName)
              Continue
            }
            If DSize !=
            {
              ; LV_Add("",DFile,"Missing")
            Gui,ListView, LV2
              ; FileAppend %A_LoopFileTimeCreated% `t %A_LoopFileName% `n, Missing_in_L.txt
            LV_Add("",A_LoopFileTimeCreated,A_LoopFileName,A_LoopFileSize)

              ; Msgbox "netu v Left" %A_LoopFileLongPath%
              Continue
            }
            Else
            {
                Gui,ListView, LV2
                ; FileAppend %A_LoopFileTimeCreated% `t %A_LoopFileName%  `t %A_LoopFileSize%  `n, difrent.txt


                ; LV_Add("",c1,c2,c3) ;vybor colonny


                ; Msgbox    %SSize%  %DSize% %A_LoopFileLongPath%
                ; LV_Add("", , ,A_LoopFileSize )
            ; FileAppend  %A_LoopFileLongPath% "`n", outdirR.txt
          }
      }
    }

    ; Clipboard := List
    ; GuiControl,,Edit1,% Source
    ; GuiControl,,Edit3,% Destination
    ; GuiControl,,Button3,Unequal
    Return

ButtonEqual:
    gui Submit, NoHide
    Destination=%dirR%
    Source=%dirLL%
    If Source =
    Return
    If Destination =
    Return
   ; Loop,%Source%\*,0,1
    Loop, Files, %Source%\*.*,FD%Recurs%
     Files := A_Index
    DF = 0
    STrim := StrLen(Source)+1
    ; Files := 100/Files
    ; SetTimer,Prog,1000
    Gui,ListView, LV1
    LV_Delete()
    LV_ModifyCol(2,"439 Left")
    LV_InsertCol(3,"80 Integer Left" , "size")
    LV_DeleteCol(4)
    Loop, Files, %Source%\*.*,FD%Recurs%
    ; Loop,%Source%\*,0,1
    {
        SSize := A_LoopFileSize
        DFile := Destination SubStr(A_LoopFileLongPath,STrim)
        FileGetSize,DSize,% DFile
      ; Msgbox %SSize%   %DSize%

        ; GuiControl,,Edit1,% A_LoopFileLongPath
        ; GuiControl,,Edit3,% DFile
        ; CIndex := A_Index
        ; GuiControl,,Button3,% DF "/" A_Index
        If SSize = %DSize%
            {
                List .= A_LoopFileLongPath " - " SSize "`n" DFile " - " DSize "`n`n"
                DF += 1
                If SSize =
                {
               Gui,ListView, LV1
              ; Msgbox % A_LoopFileLongPath
                ; FileAppend  %A_LoopFileLongPath% "`n", outdirtdi.txt
                LV_Add("",A_LoopFileTimeCreated,A_LoopFileName)
                    Continue
                }
                If DSize !=
                {
                Gui,ListView, LV1
               ; FileAppend %A_LoopFileTimeCreated% `t %A_LoopFileName% `n, Missing_in_R.txt
                LV_Add("",A_LoopFileTimeCreated,A_LoopFileName,A_LoopFileSize)

                ; Msgbox "nrtu v Right" %A_LoopFileLongPath%
                    Continue
                }
                Else
            {
                Gui,ListView, LV1
                ; FileAppend %A_LoopFileTimeCreated% `t %A_LoopFileName% `n, difrent.txt
                ; LV_ModifyCol(1,"22 sortdesc") ;time
                ;LV_ModifyCol(2,"439 Left")
                ; LV_Add("",c1,c2,c3) ;vybor colonny
                ; Msgbox    %SSize%  %DSize% %A_LoopFileLongPath%
                ; LV_Add("",A_LoopFileTimeCreated,A_LoopFileName)
                ; LV_Add("", , ,A_LoopFileSize )
                ; FileAppend  %A_LoopFileLongPath% "`n", outdirR.txt
            }
        }
    }
    LV_ModifyCol(1,"22 sortdesc") ;time

    ; =====================================================================================
    ; Loop,%Destination%\*,0,1
    Loop, Files, %Destination%\*.*,FD%Recurs%
    Files := A_Index
    DF = 0
    STrim := StrLen(Destination)+1

    Gui,ListView, LV2
    LV_Delete()
    LV_ModifyCol(2,"439 Left")
    LV_InsertCol(3,"80 Integer Left" , "size")
    LV_DeleteCol(4)
    Loop, Files, %Destination%\*.*,FD%Recurs%
    ; Loop,%Destination%\*,0,1
    {
      SSize := A_LoopFileSize
      DFile := Source SubStr(A_LoopFileLongPath,STrim)
      FileGetSize,DSize,% DFile
      ; Msgbox %SSize%   %DSize%

      ; GuiControl,,Edit1,% A_LoopFileLongPath
      ; GuiControl,,Edit3,% DFile

      If SSize = %DSize%
          {
            List .= A_LoopFileLongPath " - " SSize "`n" DFile " - " DSize "`n`n"
            DF += 1
            If SSize =
            {
              ; Msgbox % A_LoopFileLongPath
              ; FileAppend  %A_LoopFileLongPath% "`n", outdirtdi.txt
              LV_Add("",A_LoopFileTimeCreated,A_LoopFileName)
              Continue
            }
            If DSize !=
            {

            Gui,ListView, LV2
              ; FileAppend %A_LoopFileTimeCreated% `t %A_LoopFileName% `n, Missing_in_L.txt

            LV_Add("",A_LoopFileTimeCreated,A_LoopFileName,A_LoopFileSize)

              ; Msgbox "netu v Left" %A_LoopFileLongPath%
              Continue
            }
            Else
            {
                Gui,ListView, LV2

                ; FileAppend %A_LoopFileTimeCreated% `t %A_LoopFileName%  `t %A_LoopFileSize%  `n, difrent.txt


                ; LV_Add("",c1,c2,c3) ;vybor colonny


                ; Msgbox    %SSize%  %DSize% %A_LoopFileLongPath%
                ; LV_Add("", , ,A_LoopFileSize )
            ; FileAppend  %A_LoopFileLongPath% "`n", outdirR.txt
          }
      }
   }
    LV_ModifyCol(1,"22 sortdesc") ;time

    ; Clipboard := List
    ; GuiControl,,Edit1,% Source
    ; GuiControl,,Edit3,% Destination
    ; GuiControl,,Button3,Unequal
    Return

LV1:
  Gui,ListView, LV1
  if (A_GuiEvent = "DoubleClick")
  {
    LV_GetText(RowText, A_EventInfo, 2)
    remm = %RowText%
    MsgBox 64,  ,  "%remm%",  1.5
  }
return

LV2:
  Gui,ListView, LV2
  if (A_GuiEvent = "DoubleClick")
  {
    LV_GetText(RowText, A_EventInfo, 2)  ; Get the text from the row's third column
    remm = %RowText%
    MsgBox 64,  ,  "%remm%",  1.5
    ; listtt("yanSoftbrauz:code","yanSoftbrauz")
    ; listCloud(remm,"yanSoftbrauz")
    ; fileread,a, *P65001 %yanSoftbrauz%
    ; a :=Trim(a, OmitChars := " `n") ;delit last empty line
    ; Goto,guiLabel

    ; Clipboard=     "%RowText%"
    ; MsgBox 64,  ,  "%RowText%",  3.5
    ; ToolTip You double-clicked row number %A_EventInfo%. Text: "%RowText%"
  }
return


Arrow_left:
    Gui,ListView, LV1
    ; Gui, Submit, NoHide
    getCheckList(Source)
    ; Runwait %A_ComSpec% /k "%xxcopy%  "%dirR%" /Y/D/S/H/TC/BB /Q0/oS1/oF1"
    ; Run %exeCopy% /cmd=diff /auto_close /estimate /srcfile="CheckList.txt" /to="%Destination%\"
    Run E:\13PF\TeraCopy\TeraCopy.exe Copy  *E:\DirComp\CheckList.txt %Destination%
    MsgBox 64,  ,  "Arrow_left",  .5
    Gui,ListView, LV2
return

Arrow_right:
    Gui,ListView, LV2
    ; Gui, Submit, NoHide
    getCheckList(Destination)
    Run  %exeCopy% /cmd=diff /auto_close /estimate /srcfile="CheckList.txt" /to="%Source%\"
    MsgBox 64,  ,  "Arrow_right",  .5
return

Source:
	FileSelectFolder,Source,E:\,0,Choose Source
	If Source =
	Return
	GuiControl,,Edit1,% Source
Return

Destination:
	FileSelectFolder,Destination,E:\,0,Choose Destination
	If Destination =
	Return
	GuiControl,,Edit3,% Destination
Return


Unchckall:
    Gui,ListView, LV1
    LV_Modify(0, "-Check")
return
st3Btn:
Run, %sublimePath% "%A_ScriptFullPath%"
Return


getCheckList(dir){ ;zapisyvaet cheknutye v CheckList.txt
    	; Gui, +OwnDialogs
    Gui, Submit, NoHide
    names := ""
    Row := 0
    FileDelete, %A_Scriptdir%\CheckList.txt
    ; Msgbox %name%
    global name
    Loop {
          Row := LV_GetNext(Row, "C")  ; Return next row "C" is "checked"
          ; next LV_GetNext will start from this position
          If (!Row)                    ; No more chekeds
          Break                     ; Break Loop
          LV_GetText(name, Row, 2)     ;get text from first row
          names .= name " "
          FileAppend,%dir%\%name%`n,%A_Scriptdir%\CheckList.txt, CP65001  ;CP1251
          }
          ; Msgbox %name%
 }
; SearchL:
;     Gui,ListView, LV1

;     Gui,1:submit,nohide
;     LV_Delete()
;     ; Sleep, 50
;     loop,read,%dirLtxt% ,*P65001
;     {
;         LR=%A_loopreadline%
;         stringsplit,C,LR,`t,              ; delimiter comma
;         ifinstring,C2,%SearchL%            ;<< search in C2
;         LV_Add("",C1,C2 )
;     }
;     LV_ModifyCol(1,"22 sortdesc") ;time
;     LV_ModifyCol(2,"509 Right") ;time
;     Gui,ListView, LV2

;     Gui,1:submit,nohide
;     LV_Delete()
;     ; Sleep, 50
;     loop,read,%dirRtxt% ,*P65001
;     {
;         LR=%A_loopreadline%
;         stringsplit,C,LR,`t,              ; delimiter comma
;         ifinstring,C2,%SearchL%            ;<< search in C2
;         LV_Add("",C1,C2 )
;     }
;     LV_ModifyCol(1,"22 sortdesc") ;time
;     LV_ModifyCol(2,"509 Right") ;time

;     Return

SearchL:
        Gui,ListView, LV1
        GuiControlGet, SearchTermL
        GuiControl, -Redraw, LV1
        LV_Delete()

        For Each, name In LVArra
        {
           If (SearchTermL != "")
           {
              ; If (InStr(name.2, SearchTermL) = 1) ; for matching at the start
              If InStr(name.2, SearchTermL) ; for overall matching
                LV_Add("", name.1, name.2)
           }
           Else
                LV_Add("", name.1, name.2)
        }
        Items := LV_GetCount()

        SB_SetText("   " . Items . " of " . TotalItems . " Items")
        GuiControl, +Redraw, LV1
Return
SearchR:
        Gui,ListView, LV2
        GuiControlGet, SearchTermR
        GuiControl, -Redraw, LV2
        LV_Delete()

        For Each, name In LVArray
        {
           If (SearchTermR != "")
           {
              ; If (InStr(name.2, SearchTermR) = 1) ; for matching at the start
              If InStr(name.2, SearchTermR) ; for overall matching
                LV_Add("", name.1, name.2)
           }
           Else
                LV_Add("", name.1, name.2)
        }
        Items := LV_GetCount()
        SB_SetText("   " . Items . " of " . TotalItems . " Items")
        GuiControl, +Redraw, LV2
Return

GUISize:
    If (A_EventInfo = 1) ; The window has been minimized.
        Return
;     width:=A_GuiWidth-5
;     height:=A_GuiHeight-25
;     guicontrol, move, LV1, w%width%   h%height%
;     guicontrol, move, LV2, w%width%   h%height%
AutoXYWH("      w 0.5 h 0.95", LV1)
AutoXYWH("x 0.5 w 0.5 h 0.95 ",LV2)
; AutoXYWH("x 0.5  ",Arrow_r)
AutoXYWH("x 0.5  ",Arrow_r,"CBsubDirR","SearchTermR")
GuiControl, +Redraw, "SearchTermR"
; AutoXYWH("x 0.5  ", CB1,dirR,Dest )
; AutoXYWH("w0.5 h 0.75", hEdit, "displayed text", "vLabel", "Button1")
return
#Include,   1AutoXYWH.ahk




GuiClose:
ExitApp

