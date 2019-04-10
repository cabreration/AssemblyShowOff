%TITLE 'Redemption'

                IDEAL

                MODEL small
                STACK 0F00h

                DATASEG

menuLine        DB '===================== Menu =====================', 10, 13, '$'
informacion     DB 'UNIVERSIDAD DE SAN CARLOS DE GUATEMALA', 10, 13, 'FACULTAD DE INGENIERIA', 10, 13, 'ESCUELA DE CIENCIAS Y SISTEMAS', 10, 13, '$'
informacion2    DB 'ARQUITECTURA DE COMPUTADOROES Y ENSAMBLADORES 1', 10, 13, 'SECCION A', 10, 13, '$'
informacion3    DB 'NOMBRE: JAVIER ALBERTO CABRERA PUENTE', 10, 13, 'CARNET: 201403905', 10, 13, 'PRACTICA 6', 10, 10, 13, '$'
opciones        DB '1) CARGAR ARCHIVO', 10, 13, '2) ORDENAR', 10, 13, '3) GENERAR REPORTE', 10, 13, '4) SALIR', 10, 10, 13, '$'
warningMes      DB 10, 13, 'Debe elegir una de las opciones listadas', 10, 13, '$'
byeMes          DB 10, 13, 'Mucha suerte en tu vida, toma mucha awa, tkm', 10, 13, '$'
cargaLine       DB 10, 13, '==================== Carga ====================', 10, 13, '$'
ingreso         DB 'Ingrese la ruta del archivo a cargar: ', '$'
xmlFail         DB 'Extension incorrecta', 10, 13, '$'
fileDust        DB 'El archivo que intenta leer no existe', 10, 13, '$'
fileSuccess     DB 'El archivo fue cargado con exito!', 10, 13, '$'
errorBefOrd     DB 10, 13, 'No hay ningun archivo cargado todavia!', 10, 13, '$'
lineaOrd        DB 10, 13, '==================== Ordenamientos ====================', 10, 13, '$'
ordenamientos   DB 'Escoja una opcion: ', 10, 13, '1) BubbleSort', 10, 13, '2) QuickSort', 10, 13, '3) ShellSort', 10, 13, '$'
velocidadMes    DB 10, 13, 'Ingrese una medida de velocidad (0-9)', 10, 13, '$'
direccionMes    DB 10, 13, 'Elija una de las siguientes opciones: ', 10, 13, '1) Descendente', 10, 13, '2) Ascendente', 10, 13, '$'
reportName      DB 'reporte.xml', 0
bubbleHeader    DB 'Ordenamiento Burbuja'
quickHeader     DB 'Ordenamiento Rapido'
shellHeader     DB 'Ordenamiento Shell'
speedHeader     DB 'Velocidad: '
timeHeader      DB 'Tiempo: 00:00'
impresionExit   DB 10, 13, '===== El reporte ha sido generado con exito =====' , 10, 13, '$'
impresionError  DB 10, 13, '===== El reporte no fue generado con exito =====', 10, 13, '$'
ascending       DB 'Ascendente', '$'
descending      DB 'Descendente', '$'
badRange        DB 10, 13, '== Tiene menos de 10 elementos en el archivo a cargar, deben ser al menos 10', 10, 13, '$' 

; cadenas para el reporte
bloque0         DB '<Arqui>', 10, 13, 9, '<Encabezado>', 10, 13, 9, 9, '<Universidad>Universidad de San Carlos de Guatemala</Universidad>', '$'
bloque1         DB 10, 13, 9, 9, '<Facultad>Facultad de Ingenieria</Facultad>', 10, 13, 9, 9, '<Escuela>Ciencias y Sistemas</Escuela>', '$'
bloque2         DB 10, 13, 9, 9, '<Curso>', 10, 13, 9, 9, 9, '<Nombre>Arquitectura de Computadores y Ensambladores 1</Nombre>', '$'
bloque3         DB 10, 13, 9, 9, 9, '<Seccion>A</Seccion>', 10, 13, 9, 9, '</Curso>', 10, 13, 9, 9, '<Ciclo>Primer Semestre 2019</Ciclo>', '$'
bloque4         DB 10, 13, 9, 9, '<Fecha>', 10, 13, 9, 9, 9, '<Dia>', '$'
bloque5         DB '</Dia>', 10, 13, 9, 9, 9, '<Mes>', '$'
bloque6         DB '</Mes>', 10, 13, 9, 9, 9, '<Año>', '$'
bloque7         DB '<Año>', 10, 13, 9, 9, '</Fecha>', 10, 13, 9, 9, '<Hora>', 10, 13, 9, 9, 9, '<Hora>', '$'
bloque8         DB '</Hora>', 10, 13, 9, 9, 9, '<Minutos>', '$'
bloque9         DB '</Minutos>', 10, 13, 9, 9, 9, '<Segundos>', '$'
bloque10        DB '</Segundos>', 10, 13, 9, 9, '</Hora>', 10, 13, 9, 9, '<Alumno>', 10, 13, 9, 9, 9, '<Nombre>Javier Alberto Cabrera Puente</Nombre>', '$'
bloque11        DB 10, 13, 9, 9, 9, '<Carnet>201403905</Carnet>', 10, 13, 9, 9, '</Alumno>', 10, 13, 9, '</Encabezado>', '$'
bloque12        DB 10, 13, 9, '<Resultados>', 10, 13, 9, 9, '<Lista_Entrada>', '$'
bloque13        DB '</Lista_Entrada>', 10, 13, 9, 9, '<Lista_Ordenada>', '$'
bloque14        DB '</Lista_Ordenada>', 10, 13, 9, 9, '<Ordenamiento_BubbleSort>', 10, 13, 9, 9, 9, '<Velocidad>', '$'
bloque15        DB '</Velocidad>', 10, 13, 9, 9, 9, '<Tiempo>', 10, 13, 9, 9, 9, 9, '<Minutos>', '$'
bloque16        DB '</Minutos>', 10, 13, 9, 9, 9, 9, '<Segundos>', '$'
bloque17        DB '</Segundos>', 10, 13, 9, 9, 9, 9, '<Milisegundos>', '$'
bloque18        DB '</Milisegundos>', 10, 13, 9, 9, 9, '</Tiempo>', 10, 13, 9, 9, 9, '<Tipo>', '$'
bloque19        DB '</Tipo>', 10, 13, 9, 9, '</Ordenamiento_BubbleSort>', '$'
bloque20        DB 10, 13, 9, 9, '<Ordenamiento_QuickSort>', 10, 13, 9, 9, 9, '<Velocidad>', '$'
bloque21        DB '</Velocidad>', 10, 13, 9, 9, 9, '<Tiempo>', 10, 13, 9, 9, 9, 9, '<Minutos>', '$'
bloque22        DB '</Minutos>', 10, 13, 9, 9, 9, 9, '<Segundos>', '$'
bloque23        DB '</Segundos>', 10, 13, 9, 9, 9, 9, '<Milisegundos>', '$'
bloque24        DB '</Milisegundos>', 10, 13, 9, 9, 9, '</Tiempo>', 10, 13, 9, 9, 9, '<Tipo>', '$'
bloque25        DB '</Tipo>', 10, 13, 9, 9, '</Ordenamiento_QuickSort>', '$'
bloque26        DB 10, 13, 9, 9, '<Ordenamiento_ShellSort>', 10, 13, 9, 9, 9, '<Velocidad>', '$'
bloque27        DB '</Velocidad>', 10, 13, 9, 9, 9, '<Tiempo>', 10, 13, 9, 9, 9, 9, '<Minutos>', '$'
bloque28        DB '</Minutos>', 10, 13, 9, 9, 9, 9, '<Segundos>', '$'
bloque29        DB '</Segundos>', 10, 13, 9, 9, 9, 9, '<Milisegundos>', '$'
bloque30        DB '</Milisegundos>', 10, 13, 9, 9, 9, '</Tiempo>', 10, 13, 9, 9, 9, '<Tipo>', '$'
bloque31        DB '</Tipo>', 10, 13, 9, 9, '</Ordenamiento_ShellSort>', 10, 13, 9, '</Resultados>', 10, 13, '</Arqui>', '$'


; variables
century         DB '00'
year            DB '00'
month           DB '00'
day             DB '00'
hour            DB '00'
minutes         DB '00'
seconds         DB '00'
miliSeconds     DB '00'
address         DB 20 DUP (0)
fileBuffer      DB 1024 DUP (0)
handle          DW 0
fileState       DB 0                        ; 1 es error de extension, 2 es de que no existe y 3 es que funciona bien
oneByte         DB 0
array           DB 25 DUP (0)
sortedArray     DB 25 DUP (0)
;sortedArray     DB 43, 80, 25, 58, 77, 88, 87, 80, 91, 1, 0
number          DB '00$'
numberValue     DB 0
mult10          DB 0Ah
sortType        DB 0                        ; 1 es bubble, 2 es quick, 3 es shell
speed           DB 0                        ; el rango es de 0 a 9
orderMode       DB 0                        ; 1 es descendente, 2 es ascendente
gap             DB 0
arraySize       DB 0
mSpeed          DW 0
rSpeed          DW 0
printNumber     DB '00$'
left            DB 0
right           DB 0
from            DB 0
to              DB 0
pivot           DB 0
x1              DW 0
y1              DW 0
x2              DW 0
y2              DW 0
hertz           DB 0
grosor          DB 0
largest         DB 0
barraActual     DB 0
colorActual     DB 0
mult100         DB 64h
mult140         DB 140d
xCoordinate     DW 0
heightCounter   DB 0
widthCounter    DB 0
bubbleSpeed     DB 0
quickSpeed      DB 0
shellSpeed      DB 0
bubbleDir       DB 0
quickDir        DB 0
shellDir        DB 0

                CODESEG
Start:          mov     ax, @data
                mov     ds, ax 
                mov     es, ax

Menu:           mov ah, 9
                mov dx, offset menuLine
                int 21h
                mov dx, offset informacion
                int 21h
                mov dx, offset informacion2
                int 21h
                mov dx, offset informacion3
                int 21h
                mov dx, offset opciones
                int 21h
                mov ah, 1
                int 21h
                cmp al, 49
                je Cargar
                cmp al, 50
                je Ordenar
                cmp al, 51
                je GenerarRep
                cmp al, 52
                je Salir
                mov ah, 9
                mov dx, offset warningMes
                int 21h
                jmp Menu

Cargar:         mov ah, 9
                mov dx, offset cargaLine
                int 21h
                mov dx, offset ingreso
                int 21h
                call ReadAddress
                call ValidateAddress
                cmp [fileState], 1
                je XMLF
                cmp [fileState], 2
                je DUSTF
                call ValidateRange
                cmp [fileState], 3
                je LowRange
                mov dx, offset fileSuccess
                mov ah, 9
                int 21h
                jmp Menu
XMLF:           mov ah, 09h
                mov dx, offset xmlFail
                int 21h
                jmp Cargar
DUSTF:          mov ah, 09h
                mov dx, offset fileDust
                int 21h
                jmp Cargar
LowRange:       mov ah, 09h
                mov dx, offset badRange
                int 21h
                jmp Menu
                
GenerarRep:     call GenerateReport
                mov dx, offset impresionExit
                mov ah, 09h
                int 21h
                jmp Menu

Salir:          mov ah, 9
                mov dx, offset byeMes
                int 21h
                mov ah, 4ch
                int 21h  

Ordenar:        cmp [fileBuffer], 0
                jne StartSortMenu
                mov ah, 09h
                mov dx, offset errorBefOrd
                int 21h
                jmp Menu
StartSortMenu:  mov [sortType], 00h
                mov [speed], 00h
                mov [orderMode], 00h
                mov ah, 09h
                mov dx, offset lineaOrd
                int 21h
Opciones1:      mov dx, offset ordenamientos
                int 21h
                mov ah, 01h
                int 21h
                cmp al, 49
                je Bubble
                cmp al, 50
                je Quick
                cmp al, 51
                je Shell
                mov ah, 09h
                mov dx, offset warningMes
                int 21h
                jmp Opciones1
Bubble:         mov [sortType], 01h
                jmp Opciones2    
Quick:          mov [sortType], 02h
                jmp Opciones2
Shell:          mov [sortType], 03h
Opciones2:      mov ah, 09h
                mov dx, offset velocidadMes
                int 21h
                mov ah, 01h
                int 21h
                cmp al, 30h
                jb NotInRange
                cmp al, 39h
                ja NotInRange
                mov [speed], al
                sub [speed], 30h
                mov ah, [speed]
                cmp [sortType], 1
                je VelBubble
                cmp [sortType], 2
                je VelQuick
                mov [shellSpeed], ah
                jmp Opciones3
VelBubble:      mov [bubbleSpeed], ah
                jmp Opciones3
VelQuick:       mov [quickSpeed], ah
                jmp Opciones3
NotInRange:     mov ah, 09h
                mov dx, offset warningMes
                int 21h
                jmp Opciones2
Opciones3:      mov ah, 09h
                mov dx, offset direccionMes
                int 21h
                mov ah, 01h
                int 21h
                cmp al, 49
                je Desc
                cmp al, 50
                je Asc
                mov ah, 09h
                mov dx, offset warningMes
                int 21h
                jmp Opciones3
Desc:           mov [orderMode], 01h
                cmp [sortType], 1
                je DirectBubble
                cmp [sortType], 2
                je DirectQuick
                mov [shellDir], 0
                jmp StartSorting
DirectBubble:   mov [bubbleDir], 0
                jmp StartSorting
DirectQuick:    mov [quickDir], 0
StartSorting:   call Sorting
                jmp Menu
Asc:            mov [orderMode], 02h
                cmp [sortType], 1
                je DirectBubble2
                cmp [sortType], 2
                je DirectQuick2
                mov [shellDir], 1
                jmp StartSorting2
DirectBubble2:  mov [bubbleDir], 1
                jmp StartSorting2
DirectQuick2:   mov [quickDir], 1
StartSorting2:  call Sorting
                jmp Menu
             

PROC            ValidateAddress
                mov si, 00h
CheckDot:       cmp [address + si], '.'
                je VerExt
                inc si
                cmp si, 20
                je ErrorDust
                jmp CheckDot
VerExt:         inc si
                cmp [address + si ], 'X'
                jne ErrorXML
                inc si
                cmp [address + si], 'M'
                jne ErrorXML
                inc si
                cmp [address + si], 'L'
                jne ErrorXML
                mov dx, offset address
                mov ah, 03Dh
                mov al, 0
                int 21h
                jc ErrorDust
                call LoadContent
                jmp FileOk
ErrorXML:       mov [fileState], 1
                ret
ErrorDust:      mov [fileState], 2
                ret
FileOk:         mov [fileState], 3
                ret
ENDP            ValidateAddress

PROC            ReadAddress
                mov si, 00h
CleanAddress:   mov [address + si], 0
                inc si
                cmp si, 14h
                jb CleanAddress
                mov si, 00h
                mov ax, 00h       
LeerAd:         mov ah, 01h
                int 21h
                cmp al, '&'
                je LeerAd
                cmp al, 13
                je FinishReading
                mov [address + si], al
                inc si
                jmp LeerAd
FinishReading:  ret
ENDP            ReadAddress

PROC            LoadContent
                mov si, 00h
CleanFBuff:     mov [fileBuffer + si], 0
                inc si
                cmp si, 1024d
                jb CleanFBuff
                mov [handle], ax
                mov si, 00h
Load:           mov ah, 3Fh
                mov bx, [Handle]
                mov cx, 1
                mov dx, offset oneByte
                int 21h
                or ax, ax
                jz StopReading
                cmp [oneByte], 10
                je Load
                cmp [oneByte], 13
                je Load
                cmp [oneByte], 32
                je Load
                cmp [oneByte], 9
                je Load
                mov dl, [oneByte]
                cmp dl, 'A'
                jb DontLowify
                cmp dl, 'Z'
                ja DontLowify
                add dl, 32
DontLowify:     mov [fileBuffer + si], dl                       
                inc si
                jmp Load
StopReading:    mov bx, [Handle]
                mov ah, 3Eh
                int 21h
                call ProcessContent
                ret
ENDP            LoadContent

PROC            ProcessContent
                mov bx, offset array
                mov cx, 00h
                mov si, 00h
Ignore:         inc si
                cmp [fileBuffer + si], 0
                je FinishProcess
                cmp cx, 25 
                je FinishProcess
                cmp [fileBuffer + si], 47d
                ja UpperLimit
                jmp Ignore 
UpperLimit:     cmp [fileBuffer + si], 58d
                jb SaveNumber
                jmp Ignore
SaveNumber:     mov ah, [fileBuffer + si]
                inc si
                cmp [fileBuffer + si], 47d
                ja UpperTwo
                jmp SaveOne
UpperTwo:       cmp [fileBuffer + si], 58d
                jb SaveSecond
SaveOne:        mov [number + 1], ah
                call ParseInt
                mov dh, [numberValue]
                mov [byte bx], dh
                inc bx
                inc cx
                jmp Ignore
SaveSecond:     mov al, [fileBuffer + si]
                mov [number], ah
                mov [number + 1], al
                call ParseInt
                mov dh, [numberValue]
                mov [byte bx], dh
                inc bx
                inc cx
                jmp Ignore
FinishProcess:  mov [bubbleSpeed], 0
                mov [quickSpeed], 0
                mov [shellSpeed], 0
                mov [bubbleDir], 0
                mov [quickDir], 0
                mov [shellDir], 0
                ret

ENDP            ProcessContent

PROC            ValidateRange
                mov si, 00h
Elements:       cmp [array + si], 0
                je FinishRange
                cmp si, 25
                je FinishRangeOk
                inc si
                jmp Elements
FinishRange:    cmp si, 10d
                jae FinishRangeOk
                mov [fileState], 3
                mov si, 00h
CleanFBuff2:    mov [fileBuffer + si], 0
                inc si
                cmp si, 1024d
                jb CleanFBuff2
                mov si, 00h
CleanArray:     mov [array + si], 0
                inc si
                cmp si, 25
                jb CleanArray
                ret
FinishRangeOk:  mov [fileState], 0
                ret
ENDP            ValidateRange

PROC            ParseInt
                mov dx, 00h
                mov [numberValue], 00h
                cmp [number], '0'
                je Uno
                mov dh, [number + 1]
                sub dh, 30h
                mov [numberValue], dh
                mov dh, 00h
                mov dl, [number]
                sub dl, 30h
                mov ax, dx
                mul [mult10]
                add [numberValue], al
                jmp CleanNumber
Uno:            mov ah, [number + 1]
                sub ah, 30h
                mov [numberValue], ah
CleanNumber:    mov [number], '0'
                mov [number + 1], '0'
                ret
ENDP            ParseInt

PROC            GetDate
                mov [day], '0'
                mov [day + 1], '0'
                mov [month], '0'
                mov [month + 1], 0
                mov ah, 04
                int 1Ah
                xor ah, ah
                mov bl, 10h
                mov al, ch
                div bl
                add ax, '00'
                mov [century], al
                mov [century + 1], ah
                xor ah, ah
                mov al, cl
                div bl
                add ax, '00'
                mov [year], al
                mov [year + 1], ah
                xor ah, ah
                mov al, dl
                div bl
                add ax, '00'
                mov [day], al
                mov [day + 1], ah
                xor ah, ah
                mov al, dh
                div bl
                add ax, '00'
                mov [month], al
                mov [month + 1], ah 
                ret
ENDP            GetDate

PROC            GetTime
                mov [hour], '0'
                mov [hour + 1], '0'
                mov [minutes], '0'
                mov [minutes + 1], '0'
                mov [seconds], '0'
                mov [seconds + 1], '0'
                mov ah, 02h
                int 1Ah
                xor ah, ah
                mov bl, 10h
                mov al, ch
                div bl
                add ax, '00'
                mov [hour], al
                mov [hour + 1], ah
                xor ah, ah
                mov al, cl
                div bl
                add ax, '00'
                mov [minutes], al
                mov [minutes + 1], ah
                xor ah, ah
                mov al, dh
                div bl
                add ax, '00'
                mov [seconds], al
                mov [seconds + 1], ah
                xor ah, ah
                mov al, dl
                div bl
                add ax, '00'
                mov [miliSeconds], al
                mov [miliSeconds + 1], ah
                ret
ENDP            GetTime

PROC            Sorting
                mov si, 00h
CleanSorted:    mov [sortedArray + si], 00h
                inc si
                cmp si, 19h
                je CopyArray
                jmp CleanSorted 
CopyArray:      mov si, 00h
                mov bx, offset array
MoveArray:      mov dl, [byte bx]
                mov [sortedArray + si], dl
                inc si
                inc bx
                cmp si, 19h
                je SelectSort
                jmp MoveArray
SelectSort:     call DrawFrame
Suspenso:       mov ah, 10h
                int 16h
                cmp al, 20h
                jne Suspenso
                cmp [sortType], 1
                je Bub
                cmp [sortType], 2
                je Nesquick
                call ShellSorting
                jmp Validate
Bub:            call BubbleSorting
                jmp Validate
Nesquick:       call PrepareQuick
Validate:       mov ah, 10h
                int 16h
                cmp al, 1Bh
                jne Validate
                mov ah, 00h
                mov al, 03h
                int 10h
                ret
ENDP            Sorting

PROC            BubbleSorting
                mov si, 00h
FirstIteB:      mov di, 00h
                cmp si, 19h
                je StopBSorting
                cmp [sortedArray + si], 00h
                je StopBSorting
                mov ah, [sortedArray + si]
                mov [hertz], ah
                call Sound
SecondIteB:     cmp di, si
                jae NextIte
                mov al, [sortedArray + si]
                mov ah, [sortedArray + di]
                mov [hertz], ah
                call Sound
                cmp [orderMode], 01h
                je DesCondition
                cmp al, [sortedArray + di]
                jb ExchangeValues
                jmp AvanzarB
DesCondition:   cmp al, [sortedArray + di]
                ja ExchangeValues
                jmp AvanzarB
ExchangeValues: mov ah, [sortedArray + di]
                mov [sortedArray + si], ah
                mov [sortedArray + di], al
                call DrawFrame
AvanzarB:       inc di
                jmp SecondIteB
NextIte:        inc si
                jmp FirstIteB
StopBSorting:   ret
ENDP            BubbleSorting

PROC            PrepareQuick
                mov [left], 00h
                mov si, 01h
                mov [right], 01h
FindRight:      cmp [sortedArray + si], 0
                je RightFound
                cmp si, 19h
                je RightFound
                inc si
                inc [right]
                jmp FindRight
RightFound:     dec[right]
                call QuickSorting
                ret
ENDP            PrepareQuick

PROC            QuickSorting
                mov al, [left]
                mov [from], al
                mov al, [right]
                mov [to], al
                add al, [left]
                shr al, 1
                mov ah, 00h
                mov si, ax
                mov al, [sortedArray + si]
                mov [pivot], al
QuickWhile:     mov bl, [from]
                mov bh, 00h
                mov si, bx
                mov dh, [sortedArray + si]
                mov [hertz], dh
                call Sound
                mov dh, [pivot]
                mov [hertz], dh
                call Sound
                cmp [orderMode], 01h
                je QuickDesc
                cmp [sortedArray + si], dh
                jae QuickWhile2
                jmp QInc
QuickDesc:      cmp [sortedArray + si], dh
                jbe QuickWhile2
QInc:           inc [from]
                jmp QuickWhile
QuickWhile2:    mov bl, [to]
                mov bh, 00h
                mov si, bx
                mov dh, [sortedArray + si]
                mov [hertz], dh
                call Sound
                mov dh, [pivot]
                mov [hertz], dh
                call Sound
                cmp [orderMode], 01h
                je QuickDesc2
                cmp [sortedArray + si], dh
                jbe QuickIf
                jmp QDec
DobleQ:         jmp QuickWhile
QuickDesc2:     cmp [sortedArray + si], dh
                jae QuickIf
QDec:           dec [to]
                jmp QuickWhile2 
QuickIf:        mov ah, [from]
                cmp ah, [to]
                ja QuickCond
                mov bl, [from]
                mov bh, 00h
                mov si, bx
                mov ah, [sortedArray + si]
                mov bl, [to]
                mov bh, 00h
                mov si, bx
                mov al, [sortedArray + si]
                mov [sortedArray + si], ah
                mov bl, [from]
                mov bh, 00h
                mov si, bx
                mov [sortedArray + si], al
                inc [from]
                dec [to] 
                call DrawFrame
QuickCond:      mov ah, [from]
                cmp ah, [to]
                jbe DobleQ
Recursive:      mov al, [left]
                mov ah, 00h
                cmp al, [to]
                jae NextRecursive
                push ax
                mov al, [right]
                push ax
                mov al, [to]
                push ax
                push si
                mov [right], al                
                call QuickSorting
                pop si
                pop ax
                mov [to], al
                pop ax
                mov [right], al
                pop ax
                mov [left], al
NextRecursive:  mov al, [from]
                mov ah, 00h
                cmp al, [right]
                jae FinishQuick
                push ax
                mov cl, al
                mov al, [left]
                push ax
                mov [left], cl
                mov al, [right]
                push ax
                push si
                call QuickSorting
                pop si
                pop ax
                mov [right], al
                pop ax
                mov [left], al
                pop ax
                mov [from], al
FinishQuick:    ret
ENDP            QuickSorting

PROC            ShellSorting
                mov [gap], 00h
                mov si, 00h
CountElements:  cmp [sortedArray + si], 00h
                je StartShell
                cmp si, 19h
                je StartShell
                inc si
                inc [gap]
                jmp CountElements
StartShell:     mov ch, [gap]
                mov [arraySize], ch
                shr si, 1
                shr [gap], 1
                inc si
                inc [gap]
EvalShell:      dec si
                dec [gap]
                mov ch, 00h
                mov bx, offset sortedArray
                cmp si, 00h
                je FinishShell
InitMainShell:  mov dh, ch
                add dh, [gap]
                cmp dh, [arraySize]
                jae EvalShell
                mov ah, [byte bx + si]
                mov [hertz], ah
                call Sound
                mov ah, [byte bx]
                mov [hertz], ah
                call Sound
                cmp [orderMode], 1
                je DescShellC
                cmp ah, [byte bx + si]
                ja XChangeShell
                jmp ForwardShell
DescShellC:     cmp ah, [byte bx + si]
                jb XChangeShell
                jmp ForwardShell
XChangeShell:   mov al, [byte bx + si]
                mov [bx], al
                mov [bx + si], ah
                call DrawFrame
ForwardShell:   inc bx
                inc ch
                jmp InitMainShell
FinishShell:    ret
ENDP            ShellSorting

PROC            Delay
                push si
                push di
                ; arreglar los valores de m y r
                cmp [speed], 0
                ja Speed1
                mov [mSpeed], 500d
                mov [rSpeed], 2710h
                jmp Demorar
Speed1:         cmp [speed], 1
                ja Speed2
                mov [mSpeed], 450d
                mov [rSpeed], 2710h
                jmp Demorar
Speed2:         cmp [speed], 2
                ja Speed3
                mov [mSpeed], 400d
                mov [rSpeed], 2710h
                jmp Demorar
Speed3:         cmp [speed], 3
                ja Speed4
                mov [mSpeed], 350d
                mov [rSpeed], 2710h
                jmp Demorar
Speed4:         cmp [speed], 4
                ja Speed5
                mov [mSpeed], 300d
                mov [rSpeed], 2710h
                jmp Demorar
Speed5:         cmp [speed], 5
                ja Speed6
                mov [mSpeed], 250d
                mov [rSpeed], 2710h
                jmp Demorar
Speed6:         cmp [speed], 6
                ja Speed7
                mov [mSpeed], 200d
                mov [rSpeed], 2710h
                jmp Demorar
Speed7:         cmp [speed], 7
                ja Speed8
                mov [mSpeed], 150d
                mov [rSpeed], 2710h
                jmp Demorar
Speed8:         cmp [speed], 8
                ja Speed9
                mov [mSpeed], 100d
                mov [rSpeed], 2710h
                jmp Demorar
Speed9:         mov [mSpeed], 050d
                mov [rSpeed], 2710h
Demorar:        mov di, [mSpeed]
TresSpeed:      dec di
                jz UnoSpeed
                mov si, [rSpeed]
DosSpeed:       dec si
                jnz DosSpeed
                jmp TresSpeed
UnoSpeed:       pop di
                pop si
                ret
ENDP            Delay

PROC            ToString
                mov [printNumber], '0'
                mov [printNumber + 1], '0'
                cmp [numberValue], 10
                jae TwoDigits
                push ax
                mov ah, [numberValue]
                add ah, 30h
                mov [printNumber + 1], ah
                pop ax
                ret
TwoDigits:      push ax
                push cx
                push dx
                mov ah, 00h
                mov al, [numberValue]
                mov cl, [mult10]
                div cl
                mov [printNumber], al
                add [printNumber], 30h
                mov [printNumber + 1], ah
                add [printNumber + 1], 30h
                pop dx
                pop cx
                pop ax
                ret
ENDP            ToString

PROC            DrawFrame
                push ax
                push bx
                push si 
                mov ah, 00h
                mov al, 13h
                int 10h
                mov ah, 0bh
                mov bx, 0000h
                int 10h
                mov [x1], 10
                mov [y1], 30
                mov [y2], 30
                mov [x2], 311          
                call DrawLine
                mov [x1], 10
                mov [y1], 172
                mov[x2], 311
                mov [y2], 172
                call DrawLine
                mov [x1], 10
                mov [x2], 10
                mov [y1], 30
                mov [y2], 172
                call DrawLine
                mov [x1], 310
                mov [x2], 310
                mov [y1], 30
                mov [y2], 172
                call DrawLine
                call DrawInfo
                call DrawBars
                call DrawNumbers
                pop si
                pop bx
                pop ax
                ret
ENDP            DrawFrame

PROC            DrawLine
                push ax
                push bx
                push cx
                push dx
                mov dx, [y1]
                mov cx, [x1]
                cmp cx, [x2]
                je Vertical
Horizontal:     mov ah, 0Ch
                mov al, 07h
                int 10h
                inc cx
                cmp cx, [x2]
                jne Horizontal
                mov cx, 0
                mov dx, 0
                jmp EndLine
Vertical:       mov ah, 0Ch
                mov al, 07h
                int 10h
                inc dx
                cmp dx, [y2]
                jne Vertical
                mov cx, 0
                mov dx, 0
EndLine:        pop dx
                pop cx
                pop bx
                pop ax
                ret
ENDP            DrawLine

PROC            DrawInfo
                push ax
                push bx
                push cx
                push dx
                cmp [sortType], 1
                je DrawBubbleHead
                cmp [sortType], 2
                je DrawQuickHead
                mov bp, offset shellHeader
                mov cx, 18
                jmp DrawTime
DrawBubbleHead: mov bp, offset bubbleHeader
                mov cx, 20
                jmp DrawTime
DrawQuickHead:  mov bp, offset quickHeader
                mov cx, 19
DrawTime:       mov ah, 19
                mov al, 01h
                mov dh, 1
                mov dl, 2
                mov bl, 07h
                int 10h
                mov bp, offset timeHeader
                mov cx, 13
                mov ah, 19
                mov al, 01h
                mov dh, 1
                mov dl, 24
                mov bl, 07h
                int 10h
DrawSpeed:      mov bp, offset speedHeader
                mov cx, 11
                mov ah, 19
                mov al, 01h
                mov dh, 2
                mov dl, 2
                mov bl, 07h
                int 10h
                mov bh, [speed]
                mov [numberValue], bh
                call ToString
                mov bp, offset printNumber
                mov cx, 2
                mov ah, 19
                mov al, 01h
                mov dh, 2
                mov dl, 15
                mov bl, 07h
                int 10h
                pop dx
                pop cx
                pop bx
                pop ax
                ret
ENDP            DrawInfo

PROC            DrawBars
                push ax
                push bx
                push cx
                push dx
                push si
                mov ch, 00h
                mov bx, offset sortedArray
Counting:       cmp [byte bx], 00h
                je DividirEspacio
                cmp ch, 25
                je DividirEspacio
                inc bx
                inc ch
                jmp Counting
DividirEspacio: mov ax, 300
                div ch
                sub al, 05h
                mov [grosor], al
                call FindLargest
                mov si, 00h
                mov [xCoordinate], 14d
PaintIteration: cmp si, 19h
                je DonePainting
                cmp [sortedArray + si], 00h
                je DonePainting
                mov al, [sortedArray + si]
                mov [barraActual], al
                call DrawSingleBar
                inc si
                jmp PaintIteration
DonePainting:   pop si
                pop dx
                pop cx
                pop bx
                pop ax
                ret
ENDP            DrawBars

PROC            DrawSingleBar
                push ax
                push bx
                push cx
                push dx
                push si
                cmp [barraActual], 20
                jbe Red
                cmp [barraActual], 40
                jbe Blue
                cmp [barraActual], 60
                jbe Yellow
                cmp [barraActual], 80
                jbe Green
                mov [colorActual], 07h
                jmp DefineHeight
Red:            mov [colorActual], 04h
                jmp DefineHeight
Blue:           mov [colorActual], 01h
                jmp DefineHeight
Yellow:         mov [colorActual], 0Eh
                jmp DefineHeight
Green:          mov [colorActual], 02h
DefineHeight:   mov al, [barraActual]
                mul [mult100]
                mov ch, [largest]
                div ch 
                mov [barraActual], al
                mul [mult140]
                mov ch, [mult100]
                div ch
                mov [barraActual], al
                mov [heightCounter], 00h
                mov [widthCounter], 00h
                ;mov cx, 14
                ;mov dx, 171d
                mov cx, [xCoordinate]
                mov dx, 171d
FillBar:        mov bh, [barraActual]
                cmp bh, [heightCounter]
                je MoveX
                mov ah, 0Ch
                mov al, [colorActual]
                int 10h
                dec dx
                inc [heightCounter]
                jmp FillBar
MoveX:          inc [widthCounter]
                inc cx
                inc [xCoordinate]
                mov dx, 171d
                mov [heightCounter], 00h
                mov bh, [widthCounter]
                cmp bh, [grosor]
                jne FillBar
                add [xCoordinate], 05h
                pop si
                pop dx
                pop cx
                pop bx
                pop ax
                ret
ENDP            DrawSingleBar

PROC            Sound
                push ax
                mov al, 86h
                out 43h, al

                cmp [hertz], 20
                jbe Cien
                cmp [hertz], 40
                jbe TresCientos
                cmp [hertz], 60
                jbe Quinientos
                cmp [hertz], 80
                jbe SeteCientos
                mov ax, (1193180 / 900)
                jmp Yell
Cien:           mov ax, (1193180 / 100)
                jmp Yell
TresCientos:    mov ax, (1193180 / 300)
                jmp Yell
Quinientos:     mov ax, (1193180 / 500)
                jmp Yell
SeteCientos:    mov ax, (1193180 / 700)

Yell:           out 42h, al
                mov al, ah
                out 42h, al 
                in al, 61h
                or al, 00000011b
                out 61h, al
                Call Delay
                ; apagar la bocina
                in al, 61h
                and al, 11111100b
                out 61h, al
                pop ax
                ret
ENDP            Sound

PROC            FindLargest
                push si
                push ax
                mov [largest], 00h
                mov si, 00h
Larg:           cmp si, 19h
                je LargFound
                cmp [sortedArray + si], 00h
                je LargFound
                mov ah, [largest]
                cmp [sortedArray + si], ah
                ja PowerUp
                jmp AlwaysLarg
PowerUp:        mov ah, [sortedArray + si]
                mov [largest], ah
AlwaysLarg:     inc si
                jmp Larg
LargFound:      pop ax
                pop si
                ret
ENDP            FindLargest

PROC            DrawNumbers
                push si
                push ax
                mov si, 00h
                mov dh, 22
                mov dl, 01h
Ciclo:          cmp si, 25
                je NumbersDone
                cmp [sortedArray + si], 00h
                je NumbersDone
                mov ah, [sortedArray + si]
                mov [numberValue], ah
                call toString
                cmp [numberValue], 20
                jbe RedNumber
                cmp [numberValue], 40
                jbe BlueNumber
                cmp [numberValue], 60
                jbe YellowNumber
                cmp [numberValue], 80
                jbe GreenNumber
                mov [colorActual], 07h
                jmp PaintNumber
RedNumber:      mov [colorActual], 04h
                jmp PaintNumber
BlueNumber:     mov [colorActual], 01h
                jmp PaintNumber
YellowNumber:   mov [colorActual], 0Eh
                jmp PaintNumber
GreenNumber:    mov [colorActual], 02h
                jmp PaintNumber
PaintNumber:    mov bp, offset printNumber
                mov cx, 2
                mov ah, 19
                mov al, 01h
                mov bl, [colorActual]
                int 10h
                inc si
                add dl, 3
                cmp si, 13
                je GoBellow
                jmp Ciclo
GoBellow:       inc dh
                mov dl, 02h
                jmp Ciclo
NumbersDone:    pop ax
                pop si
                mov [colorActual], 00h
                ret
ENDP            DrawNumbers

PROC            GenerateReport
                call GetDate
                call GetTime
                mov dx, offset reportName
                xor cx, cx
                mov ah, 3Ch
                int 21h
                jc Mistake
                mov [handle], ax
                mov cx, 1
                jmp Block0
Mistake:        mov dx, offset impresionError
                mov ah, 09h
                int 21h
                ret
Block0:         mov si, 00h
IteBlock0:      mov ah, 40h
                mov bx, offset bloque0
                mov dl, [byte bx + si]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                cmp [oneByte], '$'
                je Block1
                int 21h
                inc si
                jmp IteBlock0
Block1:         mov si, 00h
IteBlock1:      mov ah, 40h
                mov bx, offset bloque1
                mov dl, [byte bx + si]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                cmp [oneByte], '$'
                je Block2
                int 21h
                inc si
                jmp IteBlock1
Block2:         mov si, 00h
IteBlock2:      mov ah, 40h
                mov bx, offset bloque2
                mov dl, [byte bx + si]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                cmp [oneByte], '$'
                je Block3
                int 21h
                inc si
                jmp IteBlock2
Block3:         mov si, 00h
IteBlock3:      mov ah, 40h
                mov bx, offset bloque3
                mov dl, [byte bx + si]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                cmp [oneByte], '$'
                je Block4
                int 21h
                inc si
                jmp IteBlock3
Block4:         mov si, 00h
IteBlock4:      mov ah, 40h
                mov bx, offset bloque4
                mov dl, [byte bx + si]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                cmp [oneByte], '$'
                je Block5
                int 21h
                inc si
                jmp IteBlock4
Block5:         mov ah, 40h
                mov dl, [day]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                int 21h
                mov ah, 40h
                mov dl, [day + 1]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                int 21h
                mov si, 00h
IteBlock5:      mov ah, 40h
                mov bx, offset bloque5
                mov dl, [byte bx + si]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                cmp [oneByte], '$'
                je Block6
                int 21h
                inc si
                jmp IteBlock5
Block6:         mov ah, 40h
                mov dl, [month]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                int 21h
                mov ah, 40h
                mov dl, [month + 1]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                int 21h
                mov si, 00h
IteBlock6:      mov ah, 40h
                mov bx, offset bloque6
                mov dl, [byte bx + si]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                cmp [oneByte], '$'
                je Block7
                int 21h
                inc si
                jmp IteBlock6
Block7:         mov ah, 40h
                mov dl, [century]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                int 21h
                mov ah, 40h
                mov dl, [century + 1]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                int 21h
                mov ah, 40h
                mov dl, [year]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                int 21h
                mov ah, 40h
                mov dl, [year + 1]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                int 21h
                mov si, 00h
IteBlock7:      mov ah, 40h
                mov bx, offset bloque7
                mov dl, [byte bx + si]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                cmp [oneByte], '$'
                je Block8
                int 21h
                inc si
                jmp IteBlock7
Block8:         mov ah, 40h
                mov dl, [hour]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                int 21h
                mov ah, 40h
                mov dl, [hour + 1]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                int 21h
                mov si, 00h
IteBlock8:      mov ah, 40h
                mov bx, offset bloque8
                mov dl, [byte bx + si]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                cmp [oneByte], '$'
                je Block9
                int 21h
                inc si
                jmp IteBlock8
Block9:         mov ah, 40h
                mov dl, [minutes]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                int 21h
                mov ah, 40h
                mov dl, [minutes + 1]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                int 21h
                mov si, 00h
IteBlock9:      mov ah, 40h
                mov bx, offset bloque9
                mov dl, [byte bx + si]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                cmp [oneByte], '$'
                je Block10
                int 21h
                inc si
                jmp IteBlock9
Block10:        mov ah, 40h
                mov dl, [seconds]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                int 21h
                mov ah, 40h
                mov dl, [seconds + 1]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                int 21h
                mov si, 00h
IteBlock10:     mov ah, 40h
                mov bx, offset bloque10
                mov dl, [byte bx + si]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                cmp [oneByte], '$'
                je Block11
                int 21h
                inc si
                jmp IteBlock10
Block11:        mov si, 00h
IteBlock11:     mov ah, 40h
                mov bx, offset bloque11
                mov dl, [byte bx + si]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                cmp [oneByte], '$'
                je Block12
                int 21h
                inc si
                jmp IteBlock11
Block12:        mov si, 00h
IteBlock12:     mov ah, 40h
                mov bx, offset bloque12
                mov dl, [byte bx + si]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                cmp [oneByte], '$'
                je Block13
                int 21h
                inc si
                jmp IteBlock12
Block13:        call PrintUnordered
                mov si, 00h
IteBlock13:     mov ah, 40h
                mov bx, offset bloque13
                mov dl, [byte bx + si]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                cmp [oneByte], '$'
                je Block14
                int 21h
                inc si
                jmp IteBlock13
Block14:        call PrintOrdered
                mov si, 00h
IteBlock14:     mov ah, 40h
                mov bx, offset bloque14
                mov dl, [byte bx + si]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                cmp [oneByte], '$'
                je Block15
                int 21h
                inc si
                jmp IteBlock14
Block15:        mov ah, 40h
                mov dl, [bubbleSpeed]
                mov [oneByte], dl
                add [oneByte], 30h
                mov dx, offset oneByte
                mov bx, [handle]
                int 21h
                mov si, 00h
IteBlock15:     mov ah, 40h
                mov bx, offset bloque15
                mov dl, [byte bx + si]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                cmp [oneByte], '$'
                je Block16
                int 21h
                inc si
                jmp IteBlock15
Block16:        mov si, 00h
IteBlock16:     mov ah, 40h
                mov bx, offset bloque16
                mov dl, [byte bx + si]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                cmp [oneByte], '$'
                je Block17
                int 21h
                inc si
                jmp IteBlock16
Block17:        mov si, 00h
IteBlock17:     mov ah, 40h
                mov bx, offset bloque17
                mov dl, [byte bx + si]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                cmp [oneByte], '$'
                je Block18
                int 21h
                inc si
                jmp IteBlock17
Block18:        mov si, 00h
IteBlock18:     mov ah, 40h
                mov bx, offset bloque18
                mov dl, [byte bx + si]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                cmp [oneByte], '$'
                je Block19
                int 21h
                inc si
                jmp IteBlock18
Block19:        mov si, 00h
Eve:            cmp [bubbleDir], 0
                je BubDes
                mov bx, offset ascending
                jmp PrintDir
BubDes:         mov bx, offset descending
PrintDir:       mov ah, 40h
                mov dl, [byte bx + si]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                cmp [oneByte], '$'
                je Pre19
                int 21h
                inc si
                jmp Eve
Pre19:          mov si, 00h
IteBlock19:     mov ah, 40h
                mov bx, offset bloque19
                mov dl, [byte bx + si]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                cmp [oneByte], '$'
                je Block20
                int 21h
                inc si
                jmp IteBlock19
Block20:        mov si, 00h
IteBlock20:     mov ah, 40h
                mov bx, offset bloque20
                mov dl, [byte bx + si]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                cmp [oneByte], '$'
                je Block21
                int 21h
                inc si
                jmp IteBlock20
Block21:        mov ah, 40h
                mov dl, [quickSpeed]
                mov [oneByte], dl
                add [oneByte], 30h
                mov dx, offset oneByte
                mov bx, [handle]
                int 21h
                mov si, 00h
IteBlock21:     mov ah, 40h
                mov bx, offset bloque21
                mov dl, [byte bx + si]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                cmp [oneByte], '$'
                je Block22
                int 21h
                inc si
                jmp IteBlock21
Block22:        mov si, 00h
IteBlock22:     mov ah, 40h
                mov bx, offset bloque22
                mov dl, [byte bx + si]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                cmp [oneByte], '$'
                je Block23
                int 21h
                inc si
                jmp IteBlock22
Block23:        mov si, 00h
IteBlock23:     mov ah, 40h
                mov bx, offset bloque23
                mov dl, [byte bx + si]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                cmp [oneByte], '$'
                je Block24
                int 21h
                inc si
                jmp IteBlock23
Block24:        mov si, 00h
IteBlock24:     mov ah, 40h
                mov bx, offset bloque24
                mov dl, [byte bx + si]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                cmp [oneByte], '$'
                je Block25
                int 21h
                inc si
                jmp IteBlock24
Block25:        mov si, 00h
Eve25:          cmp [quickDir], 0
                je QuicDes
                mov bx, offset ascending
                jmp PrintDir25
QuicDes:        mov bx, offset descending
PrintDir25:     mov ah, 40h
                mov dl, [byte bx + si]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                cmp [oneByte], '$'
                je Pre25
                int 21h
                inc si
                jmp Eve25
Pre25:          mov si, 00h
IteBlock25:     mov ah, 40h
                mov bx, offset bloque25
                mov dl, [byte bx + si]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                cmp [oneByte], '$'
                je Block26
                int 21h
                inc si
                jmp IteBlock25
Block26:        mov si, 00h
IteBlock26:     mov ah, 40h
                mov bx, offset bloque26
                mov dl, [byte bx + si]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                cmp [oneByte], '$'
                je Block27
                int 21h
                inc si
                jmp IteBlock26
Block27:        mov ah, 40h
                mov dl, [shellSpeed]
                mov [oneByte], dl
                add [oneByte], 30h
                mov dx, offset oneByte
                mov bx, [handle]
                int 21h
                mov si, 00h
IteBlock27:     mov ah, 40h
                mov bx, offset bloque27
                mov dl, [byte bx + si]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                cmp [oneByte], '$'
                je Block28
                int 21h
                inc si
                jmp IteBlock27
Block28:        mov si, 00h
IteBlock28:     mov ah, 40h
                mov bx, offset bloque28
                mov dl, [byte bx + si]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                cmp [oneByte], '$'
                je Block29
                int 21h
                inc si
                jmp IteBlock28
Block29:        mov si, 00h
IteBlock29:     mov ah, 40h
                mov bx, offset bloque29
                mov dl, [byte bx + si]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                cmp [oneByte], '$'
                je Block30
                int 21h
                inc si
                jmp IteBlock29
Block30:        mov si, 00h
IteBlock30:     mov ah, 40h
                mov bx, offset bloque30
                mov dl, [byte bx + si]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                cmp [oneByte], '$'
                je Block31
                int 21h
                inc si
                jmp IteBlock30
Block31:        mov si, 00h
Eve31:          cmp [shellDir], 0
                je SheDes
                mov bx, offset ascending
                jmp PrintDir31
SheDes:         mov bx, offset descending
PrintDir31:     mov ah, 40h
                mov dl, [byte bx + si]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                cmp [oneByte], '$'
                je Pre31
                int 21h
                inc si
                jmp Eve31
Pre31:          mov si, 00h
IteBlock31:     mov ah, 40h
                mov bx, offset bloque31
                mov dl, [byte bx + si]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                cmp [oneByte], '$'
                je SaveFile
                int 21h
                inc si
                jmp IteBlock31
SaveFile:       mov ah, 3Eh
                int 21h
                ret
ENDP            GenerateReport

PROC            PrintUnordered
                mov ah, [array]
                mov [numberValue], ah
                call toString
                mov ah, 40h
                mov dl, [printNumber]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                int 21h
                mov ah, 40h
                mov dl, [printNumber + 1]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                int 21h
                mov si, 01h
CicloUnord:     cmp si, 25
                je FinishUnord
                cmp [array + si], 00h
                je FinishUnord
                mov ah, 40h
                mov [oneByte], ','
                mov dx, offset oneByte
                mov bx, [handle]
                int 21h
                mov ah, [array+ si]
                mov [numberValue], ah
                call toString
                mov ah, 40h
                mov dl, [printNumber]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                int 21h
                mov ah, 40h
                mov dl, [printNumber + 1]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                int 21h
                inc si
                jmp CicloUnord
FinishUnord:    ret
ENDP            PrintUnordered

PROC            PrintOrdered
                mov ah, [sortedArray]
                mov [numberValue], ah
                call toString
                mov ah, 40h
                mov dl, [printNumber]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                int 21h
                mov ah, 40h
                mov dl, [printNumber + 1]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                int 21h
                mov si, 01h
CicloOrd:       cmp si, 25
                je FinishOrd
                cmp [sortedArray + si], 00h
                je FinishUnord
                mov ah, 40h
                mov [oneByte], ','
                mov dx, offset oneByte
                mov bx, [handle]
                int 21h
                mov ah, [sortedArray + si]
                mov [numberValue], ah
                call toString
                mov ah, 40h
                mov dl, [printNumber]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                int 21h
                mov ah, 40h
                mov dl, [printNumber + 1]
                mov [oneByte], dl
                mov dx, offset oneByte
                mov bx, [handle]
                int 21h
                inc si
                jmp CicloOrd
FinishOrd:    ret
ENDP            PrintOrdered

                END Start