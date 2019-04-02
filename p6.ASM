%TITLE 'Redemption'

                IDEAL

                MODEL small
                STACK 900h

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

; cadenas para el reporte
bloque0         DB '<Arqui>', 10, 13, 9, '<Encabezado>', 10, 13, 9, 9, '<Universidad>Universidad de San Carlos de Guatemala</Universidad>', '$'
bloque1         DB 10, 13, 9, 9, '<Facultad>Facultad de Ingenieria</Facultad', 10, 13, 9, 9, '<Escuela>Ciencias y Sistemas</Escuela>', '$'
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
bloque12        DB 10, 13, 9, '<Resultados>', 10, 13, 9, 9, '<Tipo>', '$'
bloque13        DB '</Tipo>', 10, 13, 9, 9, '<Lista_Entrada>', '$'
bloque14        DB '</Lista_Entrada>', 10, 13, 9, 9, '<Lista_Ordenada>', '$'
bloque15        DB '</Lista_Ordenada>', 10, 13, 9, 9, '<Ordenamiento_BubbleSort>', 10, 13, 9, 9, 9, '<Velocidad>', '$'
bloque16        DB '</Velocidad>', 10, 13, 9, 9, 9, '<Tiempo>', 10, 13, 9, 9, 9, 9, '<Minutos>', '$'
bloque17        DB '</Minutos>', 10, 13, 9, 9, 9, 9, '<Segundos>', '$'
bloque18        DB '</Segundos>', 10, 13, 9, 9, 9, 9, '<Milisegundos>', '$'
bloque19        DB '</Milisegundos>', 10, 13, 9, 9, 9, '</Tiempo>', 10, 13, 9, 9, '</Ordenamiento_BubbleSort>', '$'
bloque20        DB 10, 13, 9, 9, '<Ordenamiento_QuickSort>', 10, 13, 9, 9, 9, '<Velocidad>', '$'
bloque21        DB '</Velocidad>', 10, 13, 9, 9, 9, '<Tiempo>', 10, 13, 9, 9, 9, 9, '<Minutos>', '$'
bloque22        DB '</Minutos>', 10, 13, 9, 9, 9, 9, '<Segundos>', '$'
bloque23        DB '</Segundos>', 10, 13, 9, 9, 9, 9, '<Milisegundos>', '$'
bloque24        DB '</Milisegundos>', 10, 13, 9, 9, 9, '</Tiempo>', 10, 13, 9, 9, '</Ordenamiento_QuickSort>', '$'
bloque25        DB 10, 13, 9, 9, '<Ordenamiento_ShellSort>', 10, 13, 9, 9, 9, '<Velocidad>', '$'
bloque26        DB '</Velocidad>', 10, 13, 9, 9, 9, '<Tiempo>', 10, 13, 9, 9, 9, 9, '<Minutos>', '$'
bloque27        DB '</Minutos>', 10, 13, 9, 9, 9, 9, '<Segundos>', '$'
bloque28        DB '</Segundos>', 10, 13, 9, 9, 9, 9, '<Milisegundos>', '$'
bloque29        DB '</Milisegundos>', 10, 13, 9, 9, 9, '</Tiempo>', 10, 13, 9, 9, '</Ordenamiento_ShellSort>', '$'
bloque30        DB 10, 13, 9, '</Resultados>', 10, 13, '</Arqui>', '$'


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
number          DB '00$'
numberValue     DB 0
mult10          DW 0Ah
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

                CODESEG
Start:          mov     ax, @data
                mov     ds, ax 
                mov     es, ax
                call DrawFrame

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
                
GenerarRep:

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
                call Sorting
                jmp Salir
Asc:            mov [orderMode], 02h
                call Sorting
                jmp Salir
             

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
FinishProcess:  ret

ENDP            ProcessContent

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
SelectSort:     cmp [sortType], 1
                je Bub
                cmp [sortType], 2
                je Nesquick
                call ShellSorting
                ret
Bub:            call BubbleSorting
                ret
Nesquick:       call PrepareQuick
                ret
ENDP            Sorting

PROC            BubbleSorting
                mov si, 00h
FirstIteB:      mov di, 00h
                cmp si, 19h
                je StopBSorting
                cmp [sortedArray + si], 00h
                je StopBSorting
SecondIteB:     cmp di, si
                jae NextIte
                mov al, [sortedArray + si]
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
                mov dh, [pivot]
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
                mov dh, [pivot]
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
                mov ah, [byte bx]
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
ForwardShell:   inc bx
                inc ch
                jmp InitMainShell
FinishShell:    ret
ENDP            ShellSorting

PROC            Delay
                ; arreglar los valores de m y r
                cmp [speed], 0
                ja Speed1
                mov [mSpeed], 01h
                mov [rSpeed], 01h
                jmp Demorar
Speed1:         cmp [speed], 1
                ja Speed2
                mov [mSpeed], 02h
                mov [rSpeed], 02h
                jmp Demorar
Speed2:         cmp [speed], 2
                ja Speed3
                mov [mSpeed], 03h
                mov [rSpeed], 03h
                jmp Demorar
Speed3:         cmp [speed], 3
                ja Speed4
                mov [mSpeed], 03h
                mov [rSpeed], 03h
                jmp Demorar
Speed4:         cmp [speed], 4
                ja Speed5
                mov [mSpeed], 04h
                mov [rSpeed], 04h
                jmp Demorar
Speed5:         cmp [speed], 5
                ja Speed6
                mov [mSpeed], 05h
                mov [rSpeed], 05h
                jmp Demorar
Speed6:         cmp [speed], 6
                ja Speed7
                mov [mSpeed], 07h
                mov [rSpeed], 07h
                jmp Demorar
Speed7:         cmp [speed], 7
                ja Speed8
                mov [mSpeed], 07h
                mov [rSpeed], 07h
                jmp Demorar
Speed8:         cmp [speed], 8
                ja Speed9
                mov [mSpeed], 08h
                mov [rSpeed], 08h
                jmp Demorar
Speed9:         mov [mSpeed], 09h
                mov [rSpeed], 09h
Demorar:        mov di, [mSpeed]
TresSpeed:      dec di
                jz UnoSpeed
                mov si, [rSpeed]
DosSpeed:       dec si
                jnz DosSpeed
                jmp TresSpeed
UnoSpeed:            ret
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
                mov cx, [mult10]
                div cx
                mov [printNumber], al
                add [printNumber], 30h
                mov [printNumber + 1], dl
                add [printNumber + 1], 30h
                pop dx
                pop cx
                pop ax
                ret
ENDP            ToString

PROC            DrawFrame
                mov ah, 00h
                mov al, 13h
                int 10h
                mov ah, 0bh
                mov bx, 0000h
                int 10h
                mov [x1], 10
                mov [y1], 40
                mov [y2], 40
                mov [x2], 310          
                call DrawLine
                mov [x1], 10
                mov [y1], 180
                mov[x2], 310
                mov [y2], 180
                call DrawLine
                mov [x1], 10
                mov [x2], 10
                mov [y1], 40
                mov [y2], 180
                call DrawLine
                mov [x1], 310
                mov [x2], 310
                mov [y1], 40
                mov [y2], 180
                call DrawLine
                call DrawInfo
                call DrawBars
                mov ah, 10h
                int 16h
                ret
ENDP            DrawFrame

PROC            DrawLine
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
                ret
Vertical:       mov ah, 0Ch
                mov al, 07h
                int 10h
                inc dx
                cmp dx, [y2]
                jne Vertical
                mov cx, 0
                mov dx, 0
                ret
ENDP            DrawLine

PROC            DrawInfo
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
                mov dh, 3
                mov dl, 2
                mov bl, 07h
                int 10h
                ret
ENDP            DrawInfo

PROC            DrawBars
                mov cx, 00h
                mov bx, offset sortedArray
Counting:       cmp [bx], 00h
                je DividirEspacio
                cmp cx, 25
                je DividirEspacio
                inc bx
                inc cx
                jmp Counting
DividirEspacio: mov ax, 300
                div cx
                sub al, 05h
                ret
ENDP            DrawBars
                END Start