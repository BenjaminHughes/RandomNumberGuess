; Jump to start
JMP START

; Declare strings
s_request   DB  "Please guess a number between 1 and 5: $"
s_retryfail DB  13, 10, "Unlucky! Your guess was incorrect! :(", 13, 10, "Would you like to try again? (y/n): $"
s_retrysucc DB  13, 10, "Congratulations! Your guess was correct! :)", 13, 10, "Would you like to play again? (y/n): $"
s_bye       DB  13, 10, "Thanks for playing, bye! :)", 13, 10, "$"
s_blankline DB  13, 10, "$"

; Start prog
START:
JMP RANDNUM

; Generate randnum
RANDNUM:
MOV AH, 2CH
INT 21H
MOV AL,DL
MOV AH,0
MOV CL,20
DIV CL
MOV BL, AL
INC BL
JMP INPUT

; Recieve input
INPUT:
LEA DX, s_request
MOV AH, 9
INT 21H
MOV AH, 1
INT 21H
SUB AL, 30H
JMP COMPARE

; Compare guess with randnum
COMPARE:
CMP AL, BL
JZ SUCCESS
JMP FAIL

; If guess is successful
SUCCESS:
LEA DX, s_retrysucc
MOV AH, 9
INT 21H
JMP RETRY

; If guess is unsuccessful
FAIL:
LEA DX, s_retryfail
MOV AH, 9
INT 21H
JMP RETRY


RETRY:
MOV AH, 1
INT 21H
CMP AL, 79H
LEA DX, s_blankline
MOV AH, 9
INT 21H
JZ START
LEA DX, s_bye
MOV AH, 9
INT 21H

