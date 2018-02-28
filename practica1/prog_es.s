* Inicializa el SP y el PC
**************************
        ORG     $0
        DC.L    $8000           * Pila
        DC.L    INICIO          * PC

        ORG     $400

* Definici?n de equivalencias
*********************************

MR1A    EQU     $effc01       * de modo A (escritura)
MR2A    EQU     $effc01       * de modo A (2? escritura)
SRA     EQU     $effc03       * de estado A (lectura)
CSRA    EQU     $effc03       * de seleccion de reloj A (escritura)
CRA     EQU     $effc05       * de control A (escritura)
TBA     EQU     $effc07       * buffer transmision A (escritura)
RBA     EQU     $effc07       * buffer recepcion A  (lectura)
ACR	EQU	$effc09	      * de control auxiliar
IMR     EQU     $effc0B       * de mascara de interrupcion A (escritura)
ISR     EQU     $effc0B       * de estado de interrupcion A (lectura)


**************************** INIT *************************************************************
INIT:
        MOVE.B          #%00010000,CRA      * Reinicia el puntero MR1
        MOVE.B          #%00000011,MR1A     * 8 bits por caracter.
        MOVE.B          #%00000000,MR2A     * Eco desactivado.
        MOVE.B          #%11001100,CSRA     * Velocidad = 38400 bps.
        MOVE.B          #%00000000,ACR      * Velocidad = 38400 bps.
        MOVE.B          #%00000101,CRA      * Transmision y recepcion activados.
        RTS
**************************** FIN INIT *********************************************************

**************************** PRINT ************************************************************
PRINT:  RTS

**************************** FIN PRINT ********************************************************
*alex
**************************** SCAN ************************************************************
SCAN:   MOVE.B #10,D3		*Contador
b_scan:	BTST #0,SRA		*Comparamos el bit 0 (RxRDY) de SRA con 1, sin es != se va a fin
	BNE fin	
	MOVE.B RBA,-(A7)	*Obtenemos el caracter y lo llevamos a pila	
	ADD D3,1		*Sumamos 1 al contador en cada iteracion
	CMP #13,RBA		*Comparamos 13 con D0
	BNE b_scan
fin:	DC.L $8000		*SP la dejamos igual
	RTS
**************************** FIN SCAN ********************************************************
*pollas
**************************** PROGRAMA PRINCIPAL **********************************************
INICIO: BSR             INIT                * Inicia el controlador
*MOVE.B #5,D3
MOVE.B #10,D3
        BREAK
  OTRO:  MOVE.L          #$5000,-(A7)        * Prepara la direcci?n del buffer
         BSR             SCAN                * Recibe la linea
         ADD.L           #4,A7               * Restaura la pila
 *        MOVE.L          #$5000,-(A7)        * Prepara la direcci?n del buffer
 *        BSR             PRINT               * Imprime l?nea
 *        ADD.L           #4,A7               * Restaura la pila
 	BRA		OTRO
 *
         BREAK
**************************** FIN PROGRAMA PRINCIPAL ******************************************

