#NoEnv  
#Warn
SendMode Input
SetWorkingDir %A_ScriptDir% 

global seed := "-3294725893620991126" ; world seed, default is current 1.17 gravel seed

global difficulty := "easy" ; difficulty, must be easy, hard, normal, or peaceful

global screenWait := 60 ; number of ms to wait when entering the 3 screens for verifying. For 30fps recording I reccommend at least 60ms.

global listWait := 250 ; the ms to wait after entering singleplayer

global tabWait := 35 ; the ms to wait after pressing tab

global worldName := "deeznuts " ; the world name

global countAttempts := "yes" ; yes or no, counts attempts

TabAndWait() {

	Send {Tab}
	Sleep, %tabWait%

}

Finish() {

	TabAndWait()
	TabAndWait()
	TabAndWait()
	TabAndWait()
	TabAndWait()
	TabAndWait()
	Send {Enter}

}

MoreWorldOptions() {

	TabAndWait()
	TabAndWait()
	TabAndWait()
	TabAndWait()
	Send {Enter}
	TabAndWait()
	TabAndWait()
	TabAndWait()
	TypeSeed()
}

DifficultySet() {

	TabAndWait()
	TabAndWait()
	if (difficulty = "normal") {
	
		Sleep, 50
		
	} else if (difficulty = "hard") {
	
		Send {Enter}
		Sleep, 50
		
	} else if (difficulty = "peaceful") {
		
		Send {Enter}
		Sleep, 50	
		Send {Enter}
		Sleep, 50
		
	} else if (difficulty = "easy") {
	
		Send {Enter}
		Sleep, 50
		Send {Enter}
		Sleep, 50
		Send {Enter}
		Sleep, 50
	}
	MoreWorldOptions()
}

Singleplayer() {
	
	TabAndWait()
	Sleep, %screenWait%
	Send {Enter}
	Sleep, %listWait%
	NewWorldMenu()
	
}

TypeSeed() {
	
	SendInput, %seed%
	Finish()
}

NameWorld() {

	SendInput, ^a
	Sleep, %tabWait%
	SendInput, {BackSpace}
	if (countAttempts = "yes") {
		
		FileRead, attemptNumber, attempts.txt
		attemptNumber += 1
		FileDelete, attempts.txt
		FileAppend, %attemptNumber%, attempts.txt
		Sleep, 1
		SendInput, %worldName%
		Sleep, %tabWait%
		SendInput, %attemptNumber%
		Sleep, 1
	} else {
		
		SendInput, %worldName%
	
	}
	DifficultySet()
}

ExitWorld() {

	Send {Esc}
	Send {Tab}
	Send {Tab}
	Send {Tab}
	Send {Tab}
	Send {Tab}
	Send {Tab}
	Send {Tab}
	Send {Tab}
	Send {Enter}
}

NewWorldMenu() {

	TabAndWait()
	TabAndWait()
	TabAndWait()
	Send {Enter}
	Sleep, %listWait%
	NameWorld()
	
}

PgUp::
	if WinActive("Minecraft* 1.17.1") { 
		
		Singleplayer()	
		
	}
PgDn:: 
	if WinActive("Minecraft* 1.17.1") {
	
		ExitWorld()
	
	}
