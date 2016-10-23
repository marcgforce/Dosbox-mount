#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=dosbox.ico
#AutoIt3Wrapper_Outfile=dosboxmount.exe
#AutoIt3Wrapper_Res_Comment=Ajout d'un menu déroulant "historique"
#AutoIt3Wrapper_Res_Description=montage automatique des images de cd disques disquettes dans dosbox et aussi des repetoires par selection
#AutoIt3Wrapper_Res_Fileversion=0.2.0.0
#AutoIt3Wrapper_Res_LegalCopyright=Marc GRAZIANI
#AutoIt3Wrapper_Res_Language=1036
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
;~ #AutoIt3Wrapper_useansi=y
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <MsgBoxConstants.au3>
#include <FileConstants.au3>
#Region ### START Koda GUI section ### Form=
$version="0.3"
$counthist=1
$dosboxhist = FileExists(@TempDir& "\dbxhist.conf")
if $dosboxhist Then
	$tempfile= @TempDir & "\dbxhist.conf"
Else
	FileWrite(@TempDir & "\dbxhist.conf","Historique de dosboxmount, Marcgforce")
		$tempfile= @TempDir & "\dbxhist.conf"
		for $i = 1 to 5 Step 1
		IniWriteSection($tempfile,"histo" & $i,"label=Vide" & @CRLF & "commande=")
	next
		iniwritesection($tempfile,"Compteur","valeur=0")
EndIf
$histitem1=IniRead($tempfile,"histo1","label","Vide")
$histitem2=IniRead($tempfile,"histo2","label","Vide")
$histitem3=IniRead($tempfile,"histo3","label","Vide")
$histitem4=IniRead($tempfile,"histo4","label","Vide")
$histitem5=IniRead($tempfile,"histo5","label","Vide")
$Form1 = GUICreate("DosBoxMount !", 194, 159, 192, 124)
$MenuItem1 = GUICtrlCreateMenu("&Monter...")
$MenuItem2 = GUICtrlCreateMenu("&Historique...")
$menuitem3 = GUICtrlCreateMenu("Aide")
$idFileItem1 = GUICtrlCreateMenuItem("une image", $MenuItem1)
$idFileItem2 = GUICtrlCreateMenuItem("un iso", $MenuItem1)
$idFileItem3 = GUICtrlCreateMenuItem("un repertoire", $MenuItem1)
$histfileitem1 = GUICtrlCreateMenuItem($histitem1,$MenuItem2)
$histfileitem2 = GUICtrlCreateMenuItem($histitem2,$MenuItem2)
$histfileitem3 = GUICtrlCreateMenuItem($histitem3,$MenuItem2)
$histfileitem4 = GUICtrlCreateMenuItem($histitem4,$MenuItem2)
$histfileitem5 = GUICtrlCreateMenuItem($histitem5,$MenuItem2)
$aideitem=GUICtrlCreateMenuItem("A propos",$menuitem3)
;~ GUICtrlSetState(-1, $GUI_CHECKED)
GUISetBkColor(0x000080)
$Pic1 = GUICtrlCreatePic(@ScriptDir & "\dosboxmount.jpg", 0, 0, 193, 137)

$dosbox = FileExists(@ScriptDir & "\dosbox.exe")
if $dosbox Then
	$dosbox = @scriptdir & "\dosbox.exe"
Else
	msgbox(0,"Erreur","Impossible de trouver Dosbox.exe" & @CRLF & "placer ce fichier au même niveau que Dosbos.exe, Au revoir !")
	exit
EndIf
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $idFileItem1
			$counthist = IniRead($tempfile,"compteur","valeur",1)
			$file2open = FileOpenDialog("Selection du jeu", @ScriptDir, "Images disque et disquettes (*.ima;*.img)", $FD_FILEMUSTEXIST)
			If @error Then
				ContinueLoop
			Else
				$namehisto = $file2open
				$size = FileGetSize($file2open)
				If $size < 2949121 Then
					$file="'" & $file2open & "'"
					$file="""imgmount a " & $file & "-t floppy"""
					$line = " -c " & $file & " -c a: -c dir"
					$counthist = $counthist + 1
					if $counthist > 5 Then
						$counthist=1
						IniWriteSection($tempfile,"Compteur","valeur=" & $counthist)
						IniWriteSection($tempfile,"histo" & $counthist,"label=" & $namehisto & @CRLF & "commande=" & $line)
					Else
						IniWriteSection($tempfile,"Compteur","valeur=" & $counthist)
						IniWriteSection($tempfile,"histo" & $counthist,"label=" & $namehisto & @CRLF & "commande=" & $line)
					EndIf
				Else
					$file="'" & $file2open & "'"
					$file="""imgmount c " & $file & """"
					$line = " -c " & $file & " -c c: -c dir"
					$counthist = $counthist + 1
					if $counthist > 5 Then
						$counthist=1
						IniWriteSection($tempfile,"Compteur","valeur=" & $counthist)
						IniWriteSection($tempfile,"histo" & $counthist,"label=" & $namehisto & @CRLF & "commande=" & $line)
					Else
						IniWriteSection($tempfile,"Compteur","valeur=" & $counthist)
						IniWriteSection($tempfile,"histo" & $counthist,"label=" & $namehisto & @CRLF & "commande=" & $line)
					EndIf
				EndIf
				executer($line)
			EndIf
		Case $idFileItem2
			$counthist = IniRead($tempfile,"compteur","valeur",1)
			$file2open = FileOpenDialog("Selection du jeu", @ScriptDir, "Images iso (*.iso)", $FD_FILEMUSTEXIST)
			If @error Then
				ContinueLoop
			Else
				$namehisto = $file2open
				$file="'" & $file2open & "'"
				$file="""imgmount d " & $file & "-t cdrom"""
				$line = " -c " & $file & " -c d:"
				$counthist = $counthist + 1
					if $counthist > 5 Then
						$counthist=1
						IniWriteSection($tempfile,"Compteur","valeur=" & $counthist)
						IniWriteSection($tempfile,"histo" & $counthist,"label=" & $namehisto & @CRLF & "commande=" & $line)
					Else
						IniWriteSection($tempfile,"Compteur","valeur=" & $counthist)
						IniWriteSection($tempfile,"histo" & $counthist,"label=" & $namehisto & @CRLF & "commande=" & $line)

					EndIf
				executer($line)
			EndIf
		Case $idFileItem3
			$counthist = IniRead($tempfile,"compteur","valeur",1)
			$file2open = FileSelectFolder("Selection du dossier", @ScriptDir)
			If @error Then
				ContinueLoop
			Else
				$namehisto = $file2open
				$file="'" & $file2open & "'"
				$file="""mount c " & $file & """"
				$line = " -c " & $file & " -c c:"
				$counthist = $counthist + 1

				if $counthist > 5 Then
					$counthist=1
					IniWriteSection($tempfile,"Compteur","valeur=" & $counthist)
					IniWriteSection($tempfile,"histo" & $counthist,"label=" & $namehisto & @CRLF & "commande=" & $line)
				Else
					IniWriteSection($tempfile,"Compteur","valeur=" & $counthist)
					IniWriteSection($tempfile,"histo" & $counthist,"label=" & $namehisto & @CRLF & "commande=" & $line)
				EndIf
;~ 				MsgBox(0,"",$line)
				executer($line)
			EndIf
		case $histfileitem1
			$file = IniRead($tempfile,"histo1","label","")
			if $file = "Vide" Then
				ContinueLoop
			Else
				$line=IniRead($tempfile,"histo1","commande","")
				Executer($line)
			EndIf
		case $histfileitem2
			$file = IniRead($tempfile,"histo2","label","")
			if $file = "Vide" Then
				ContinueLoop
			Else
				$line=IniRead($tempfile,"histo2","commande","")
				Executer($line)
			EndIf
		case $histfileitem3
			$file = IniRead($tempfile,"histo3","label","")
			if $file = "Vide" Then
				ContinueLoop
			Else
				$line=IniRead($tempfile,"histo3","commande","")
				Executer($line)
			EndIf
		case $histfileitem4
			$file = IniRead($tempfile,"histo4","label","")
			if $file = "Vide" Then
				ContinueLoop
			Else
				$line=IniRead($tempfile,"histo4","commande","")
				Executer($line)
			EndIf
		case $histfileitem5
			$file = IniRead($tempfile,"histo5","label","")
			if $file = "Vide" Then
				ContinueLoop
			Else
				$line=IniRead($tempfile,"histo5","commande","")
				Executer($line)
			EndIf
	case $aideitem
		MsgBox(4096,"Dosbox mount" & " version " & $version,"Concept et devellopement : -Marc GRAZIANI-" & @CRLF & "marcgforce@gmail.com")
	EndSwitch
WEnd
Func executer($file)
	ShellExecute($dosbox,$file)
	Exit
EndFunc   ;==>executer
