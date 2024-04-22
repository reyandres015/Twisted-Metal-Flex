/* 
   Ciencia Computacional Avanzada G02
   Taller Flex _ Corte 2
   Integrantes Cerecitas: 
   - Daniela Pinzon
   - Isabella Ardila
   
*/
%{
#include <stdio.h>
#include <string.h>
#include <time.h>   /* Librería para manejo del tiempo*/

/* Definicion de variables globales*/
int Japon [3] = {200,200,200}; /*Cada equipo cuenta con [3] personajes*/
int Italia [3] = {200,200,200}; /*Cada personaje cuenta con su barra completa de vida*/

/* Contador de vida para ambos equipos*/
int p_life_2 = 0;
int p_life = 0;

/* Posicion del contador de cada equipo*/
int position_Italia= 0;
int position_Japon= 0;

/*Asignacion de integrantes de cada equipo*/
char Equipo_Italia[3][20] = {"Terry Bogard","Andy Bogard","Joe Higashi"}; 
char Equipo_Japon[3][20] = {"Kyō Kusanagi","Benimaru Nikaido","Goro Daimon"};
 
/* Barra para poder especial incial en 0 - por cada golpe sube la barra */
int special_power_1 = 0;  /*Equipo Italia */
int special_power_2 = 0;  /*Equipo Japon */

int time_limit = 60;         /*  Límite de tiempo por ronda en segundos (60 segundos = 1 minuto) */
int current_round = 1;       /*  Ronda actual */
int max_rounds = 2;          /*  Máximo de rondas (2) */
int extra_round = 0;         /*  Ronda extra en caso de empate en vida */

/* Función para obtener el tiempo actual */
float get_current_time() {
    return (float)clock() / CLOCKS_PER_SEC;
}

%}

/* Token para cada escenario predefinido*/
Tk_scene_Brasil      "Brasil"
Tk_scene_China       "China"
Tk_scene_England     "England"
Tk_scene_Italia      "Italia"

/* Llamda por escenario*/
tk_Br  ({Tk_scene_Brasil})
tk_Ch  ({Tk_scene_China})
tk_Eng ({Tk_scene_England})
tk_Ita ({Tk_scene_Italia})


%option noyywrap
/*Movimientos basicos para el equipo Italia - #1*/
P1_MOVE_PUNCH           "A_1"
P1_MOVE_PUNCH_SPECIAL   "B_1"
P1_MOVE_KICK 	        "C_1"
P1_MOVE_KICK_SPECIAL    "D_1"

/* Llamda para cada movimiento del equipo Italia - #1*/
tk_MP({P1_MOVE_PUNCH})
tk_MPS({P1_MOVE_PUNCH_SPECIAL})
tk_MK({P1_MOVE_KICK})
tk_MKS({P1_MOVE_KICK_SPECIAL})

/* Movimientos basicos para el equipo Japon - #2*/
P2_MOVE_PUNCH           "A_2"
P2_MOVE_PUNCH_SPECIAL   "B_2"
P2_MOVE_KICK 	        "C_2"
P2_MOVE_KICK_SPECIAL    "D_2"

/* Llamada para cada movimiento del equipo Japon - #2*/
tk_MP_2({P2_MOVE_PUNCH})
tk_MPS_2({P2_MOVE_PUNCH_SPECIAL})
tk_MK_2({P2_MOVE_KICK})
tk_MKS_2({P2_MOVE_KICK_SPECIAL})
newLine \n|\r|\r\n

/* Movimientos especiales para el equipo Italia - #1 */
/* Se definen por jugador y por equipo en general */
/* 1 -> arriba , 2 -> abajo , 3 -> derecha , 4 -> izquierda */
tk_special_Terry_Bogard          "B2A3"
tk_special_Andy_Bogard 	         "D2A4"
tk_special_Joe_Higashi           "C1B3"
tk_move_super_special_italia	 "BB1B3A"

/* Llamda para cada movimiento especial del equipo Italia - #1 */
tk_STB ({tk_special_Terry_Bogard})
tk_SAB ({tk_special_Andy_Bogard})
tk_SJH ({tk_special_Joe_Higashi})
tk_SSI ({tk_move_super_special_italia})

/* Movimientos especiales para el equipo Japon - #2 */
/* Se definen por jugador y por equipo en general */
tk_special_kyo_Kusanagi	       "D2D1"
tk_special_Benimaru_Nikaido    "A3D3"
tk_special_Goro_Daimon         "B1B2"
tk_move_super_special_japon    "AB2DC3"

/* Llamada para cada movimiento especial del equipo Japon - #2 */
tk_SKK ({tk_special_kyo_Kusanagi})
tk_SBN ({tk_special_Benimaru_Nikaido})
tk_SGD ({tk_special_Goro_Daimon})
tk_SSJ ({tk_move_super_special_japon})

%%

 /*DEFINICION DE REGALAS PARA CADA TOKEN DEL ESCENARIO SELECCIONADO*/
({Tk_scene_Brasil}:)?{tk_Br} {
	printf("Escenario seleccionado correctamente : \n");
	printf("Bienvenidos a Brasil");
	printf(" ");
}
({Tk_scene_Italia}:)?{tk_Ita} {
	printf("Escenario seleccionado correctamente : \n");
	printf( "Bienvenidos a Italia" );
	printf(" ");
}
({Tk_scene_England}:)?{tk_Eng} {
	printf("Escenario seleccionado correctamente : \n");
	printf( "Bienvenidos a England" );
	printf(" ");
}
({Tk_scene_China}:)?{tk_Ch} {
	printf("Escenario seleccionado correctamente : \n");
	printf( "Bienvenidos a China" );
	printf(" ");
}

 /*DEFINICION DE REGALAS PARA CADA TOKEN DE GOLPES PREDETERMINADOS EQUIPO ITALIA #1*/
({P1_MOVE_PUNCH}:)?{tk_MP} {
	printf(" ");
  printf("\nEquipo Italia - MOVE PUNCH  : %s\n", yytext);
  printf("Player :  %s",Equipo_Italia[position_Italia]);printf("-- Golpe Dirigido a player-- %s",Equipo_Japon[position_Japon]);
  Japon[p_life_2] = Japon[p_life_2] - 15;
  special_power_2 = special_power_2 + 5;
  printf("\n Count life player 2 : %d", Japon[p_life_2]);
  printf("\n Count life player 1 : %d", Italia[p_life]);
  printf("\n barra actual de poder equipo 2: [ %d]",special_power_2); 
  
  if(Japon[p_life_2]<=0){
  printf("\nNuevo jugador : %s" ,Equipo_Japon[position_Japon]);printf(" vs %s",Equipo_Italia[position_Italia]);
  p_life_2 = p_life_2 +1;
  position_Japon = position_Japon+1;;
  }if(Japon[p_life_2]<=0){ 
     printf("\n*******************************************************\n");
  printf("\nEl ganador es el Equipo 1 %s\n",Equipo_Italia[position_Italia]);
        printf("\n*******************************************************\n");
  exit(-1);
  }
}
 
({P1_MOVE_PUNCH_SPECIAL}:)?{tk_MPS} {
	printf(" ");
  printf("\nEquipo Italia - MOVE PUNCH SPECIAL :%s\n", yytext);
  printf("Player: %s",Equipo_Italia[position_Italia]);printf("-- Golpe Dirigido a player-- %s",Equipo_Japon[position_Japon]);
  Japon[p_life_2] = Japon[p_life_2]- 30;
  special_power_2 = special_power_2+ 20;
  printf("\n Count life player 2 : %d", Japon[p_life_2]);
  printf("\n Count life player 1 : %d", Italia[p_life]);
  printf("\n barra actual de poder equipo 2: [ %d]",special_power_2); 
  
  if(Japon[p_life_2]<= 0){
  printf("\nNuevo jugador : %s" ,Equipo_Japon[position_Japon]);printf(" vs %s",Equipo_Italia[position_Italia]);
  p_life_2 = p_life_2 +1;
  position_Japon = position_Japon+1;
  }if(Japon[p_life_2] <=0){ 
        printf("\n*******************************************************\n");
  printf("\nEl ganador es el Equipo 1 %s\n",Equipo_Italia[position_Italia]);
        printf("\n*******************************************************\n");
  exit(-1);
  }
}
 
({P1_MOVE_KICK}:)?{tk_MK} {
	printf(" ");
  printf("\nEquipo Italia - MOVE KICK :%s\n", yytext);
  printf("Player %s",Equipo_Italia[position_Italia]);printf("-- Golpe Dirigido a player-- %s",Equipo_Japon[position_Japon]);
  Japon[p_life_2] = Japon[p_life_2] - 25;
  special_power_2 = special_power_2+ 15;
  printf("\n Count life player 2 : %d", Japon[p_life_2]);
  printf("\n Count life player 1 : %d", Italia[p_life]);
  printf("\n barra actual de poder equipo 2: [ %d]",special_power_2); 
  
  if(Japon[p_life_2]<= 0){
  printf("\nNuevo jugador : %s" ,Equipo_Japon[position_Japon]);printf(" vs %s",Equipo_Italia[position_Italia]);
  p_life_2 = p_life_2 +1;
  position_Japon = position_Japon+1;
  }if(Japon[p_life_2]<=0){ 
  printf("\n*******************************************************\n");
  printf("\nEl ganador es el Equipo 1 %s\n",Equipo_Italia[position_Italia]);;
        printf("\n*******************************************************\n");
  exit(-1);
  }
}

({P1_MOVE_KICK_SPECIAL}:)?{tk_MKS} {
	printf(" ");
  printf("\nEquipo Italia - MOVE KICK SPECIAL : %s\n", yytext);
  printf("Player %s",Equipo_Italia[position_Italia]);printf("-- Golpe Dirigido a player-- %s",Equipo_Japon[position_Japon]);
  Japon[p_life_2] = Japon[p_life_2] - 50;
  special_power_2 = special_power_2+ 30;
  printf("\n Count life player 2 : %d", Japon[p_life_2]);
  printf("\n Count life player 1 : %d", Italia[p_life]);
  printf("\n barra actual de poder equipo 2: [ %d]",special_power_2); 
  
  if(Japon[p_life_2]<= 0){
  printf("\nNuevo jugador : %s" ,Equipo_Japon[position_Japon]);printf(" vs %s",Equipo_Italia[position_Italia]);
  p_life_2 = p_life_2 +1;
  position_Japon = position_Japon+1;
  }if(Japon[p_life_2]<=0){ 
     printf("\n*******************************************************\n");
  printf("\nEl ganador es el Equipo 1 %s\n",Equipo_Italia[position_Italia]);
  printf("\n*******************************************************\n");
  exit(-1);
  }
}

 /*DEFINICION DE REGLAS PARA CADA TOKEN DE COMBOS ESPECIALES EQUIPO ITALIA #1*/
({tk_special_Terry_Bogard}:)?{tk_STB} {
    printf("\nCombo especial del jugador Terry Bogard- Ejecutado [%s]\n ",yytext);  
    Japon[p_life_2] = Japon[p_life_2] - 60;
    printf("\n Count life player 2 : %d", Japon[p_life_2]);
    printf("\n Count life player 1 : %d", Italia[p_life]);
    special_power_1 = special_power_1+ 30;
}

({tk_special_Andy_Bogard}:)?{tk_SAB} {
 printf(" ");
    printf("\nCombo especial del jugador Andy Bogard- Ejecutado [%s]\n ",yytext);  
    Japon[p_life_2] = Japon[p_life_2] - 60;
    printf("\n Count life player 2 : %d", Japon[p_life_2]);
    printf("\n Count life player 1 : %d", Italia[p_life]);
    special_power_1 = special_power_1+ 30;
}

({tk_special_Joe_Higashi}:)?{tk_SJH} {
 printf(" ");
    printf("\nCombo especial del jugador Joe Higashi- Ejecutado [%s]\n ",yytext);  
    Japon[p_life_2] = Japon[p_life_2] - 60;
    printf("\n Count life player 2 : %d", Japon[p_life_2]);
    printf("\n Count life player 1 : %d", Italia[p_life]);
    special_power_1 = special_power_1+ 30;
}


({tk_move_super_special_italia}:)?{tk_SSI} {
 if(special_power_1 < 100 ){
 printf("******************************************************");
 printf(" \nNo puedes usar la Super Especial de este equipo \n");
 printf("******************************************************");
 
 }if(Japon[3] <= 50){
 special_power_1 = 0;
 printf("\nMovimiento Super Especial del Equipo Italia - Ejecutado [%s]\n ",yytext);  
 Japon[p_life_2] = Japon[p_life_2] - 120;
 printf("\n Count life player 2 : %d", Japon[p_life_2]);
 printf("\n Count life player 1 : %d", Italia[p_life]);
 printf("\n barra de poder actual: %d",special_power_1);
 }
}

 /*DEFINICION DE REGLAS PARA CADA TOKEN DE COMBOS ESPECIALES EQUIPO JAPON #2*/
 
({P2_MOVE_PUNCH}:)?{tk_MP_2} {
  
  printf(" ");
  printf("\nEquipo Mexico Ataca---> Golpe Basico : %s\n", yytext);
  printf("El personaje %s",Equipo_Japon[position_Japon]);printf("--> acierta golpe a --> %s",Equipo_Italia[position_Italia]);
  Italia[p_life] = Italia[p_life] - 15;
  special_power_1 = special_power_1+ 5;
  printf("\n Count life player 2 : %d", Japon[p_life_2]);
  printf("\n Count life player 1 : %d", Italia[p_life]);
  printf("\n barra actual de poder equipo 2: [ %d]",special_power_1); 
  
  if(Italia[p_life]<= 0){
  printf("\nNuevo jugador : %s" ,Equipo_Japon[position_Japon]);printf(" vs %s",Equipo_Italia[position_Italia]);
  p_life = p_life +1;
  position_Italia = position_Italia+1;
  }if(Italia[p_life]<=0){ 
   printf("\n*******************************************************\n");
  printf("\n*******************************************************\n");
  printf("\nEl ganador es el Equipo 1 %s\n",Equipo_Japon[position_Japon]);
  printf("\n*******************************************************\n");
    printf("\n*******************************************************\n");;
  exit(-1);
  }
}
 
({P2_MOVE_PUNCH_SPECIAL}:)?{tk_MPS_2} {
		printf(" ");
  printf("\nEquipo Mexico Ataca---> Golpe Basico : %s\n", yytext);
  printf("El personaje %s",Equipo_Japon[position_Japon]);printf("--> acierta golpe a --> %s",Equipo_Italia[position_Italia]);
  Italia[p_life] = Italia[p_life] - 30;
  special_power_1 = special_power_1+ 20;
  printf("\n Count life player 2 : %d", Japon[p_life_2]);
  printf("\n Count life player 1 : %d", Italia[p_life]);
  printf("\n barra actual de poder equipo 2: [ %d]",special_power_1); 
  
  if(Italia[p_life]<= 0){
  printf("\nNuevo jugador : %s" ,Equipo_Japon[position_Japon]);printf(" vs %s",Equipo_Italia[position_Italia]);
  p_life = p_life +1;
  position_Italia = position_Italia+1;
  }if(Italia[p_life]<=0){ 
   printf("\n*******************************************************\n");
  printf("\n*******************************************************\n");
  printf("\nEl ganador es el Equipo 1 %s\n",Equipo_Japon[position_Japon]);
  printf("\n*******************************************************\n");
    printf("\n*******************************************************\n");
  exit(-1);
  } 
}

({P2_MOVE_KICK}:)?{tk_MK_2} {
		printf(" ");
  printf("\nEquipo Mexico Ataca---> Golpe Basico : %s\n", yytext);
  printf("El personaje %s",Equipo_Japon[position_Japon]);printf("--> acierta golpe a --> %s",Equipo_Italia[position_Italia]);
  Italia[p_life] = Italia[p_life] - 25;
  special_power_1 = special_power_1+ 15;
  printf("\n Count life player 2 : %d", Japon[p_life_2]);
  printf("\n Count life player 1 : %d", Italia[p_life]);
  printf("\n barra actual de poder equipo 2: [ %d]",special_power_1); 
  
  if(Italia[p_life]<= 0){
  printf("\nNuevo jugador : %s" ,Equipo_Japon[position_Japon]);printf(" vs %s",Equipo_Italia[position_Italia]);
  p_life = p_life +1;
  position_Italia = position_Italia+1;
  }if(Italia[p_life]<=0){ 
   printf("\n*******************************************************\n");
  printf("\n*******************************************************\n");
  printf("\nEl ganador es el Equipo 1 %s\n",Equipo_Japon[position_Japon]);
  printf("\n*******************************************************\n");
    printf("\n*******************************************************\n");
  exit(-1);
  }
}

({P2_MOVE_KICK_SPECIAL}:)?{tk_MKS_2} {
			printf(" ");
  printf("\nEquipo Mexico Ataca---> Golpe Basico : %s\n", yytext);
  printf("El personaje %s",Equipo_Japon[position_Japon]);printf("--> acierta golpe a --> %s",Equipo_Italia[position_Italia]);
  Italia[p_life] = Italia[p_life] - 50;
  special_power_1 = special_power_1+ 30;
  printf("\n Count life player 2 : %d", Japon[p_life_2]);
  printf("\n Count life player 1 : %d", Italia[p_life]);
  printf("\n barra actual de poder equipo 2: [ %d]",special_power_1); 
  
  if(Italia[p_life]<= 0){
  printf("\nNuevo jugador : %s" ,Equipo_Japon[position_Japon]);printf(" vs %s",Equipo_Italia[position_Italia]);
  p_life = p_life +1;
  position_Italia = position_Italia+1;
  }if(Italia[p_life]<=0){ 
  printf("\n*******************************************************\n");
  printf("\n*******************************************************\n");
  printf("\nEl ganador es el Equipo 1 %s\n",Equipo_Japon[position_Japon]);
  printf("\n*******************************************************\n");
    printf("\n*******************************************************\n");
  exit(-1);
  }
}

 /*DEFINICION DE REGLAS PARA CADA TOKEN DE COMBOS ESPECIALES EQUIPO JAPON #2*/
({tk_special_kyo_Kusanagi}:)?{tk_SKK} {
    printf(" ");
    printf("\nCombo especial del jugador Kyo Kusanagi- Ejecutado [%s]\n ",yytext);  
    Japon[p_life_2] = Japon[p_life_2] - 60;
    printf("\n Count life player 2 : %d", Japon[p_life_2]);
    printf("\n Count life player 1 : %d", Italia[p_life]);
    special_power_2 = special_power_2+ 30;
}

({tk_special_Benimaru_Nikaido}:)?{tk_SBN} {
 printf(" ");
    printf("\nCombo especial del jugador Benimaru Nikaido- Ejecutado [%s]\n ",yytext);  
     Japon[p_life_2] = Japon[p_life_2] - 60;
    printf("\n Count life player 2 : %d", Japon[p_life_2]);
    printf("\n Count life player 1 : %d", Italia[p_life]);
    special_power_2 = special_power_2+ 30;
}

({tk_special_Goro_Daimon}:)?{tk_SGD} {
    printf("\nCombo especial del jugador Goro Daimon- Ejecutado [%s]\n ",yytext);  
    Japon[p_life_2] = Japon[p_life_2] - 60;
    printf("\n Count life player 2 : %d", Japon[p_life_2]);
    printf("\n Count life player 1 : %d", Italia[p_life]);
    special_power_2 = special_power_2+ 30;
}

({tk_move_super_special_japon}:)?{tk_SSJ} {
 if(special_power_2 < 100 ){
 printf("******************************************************");
 printf(" \nNo puedes usar la Super Especial de este equipo \n");
 printf("******************************************************");
 
 }if(Japon[3] <= 50){
 special_power_1 = 0;
 printf("\nMovimiento Super Especial del Equipo Japon - Ejecutado[%s]\n ",yytext);  
 Japon[p_life_2] = Japon[p_life_2] - 120;
 printf("\n Count life player 2 : %d", Japon[p_life_2]);
 printf("\n Count life player 1 : %d", Italia[p_life]);
 printf("\n barra de poder actual: %d",special_power_2);
 }
}


.+ {
  printf("No se reconoce este comando porfavor intentelo de nuevo: %s\n", yytext);
}

{newLine} {;}


%%
int main(int argc, char const *argv[]) {
  printf(" ");
  printf("\n--------------The kings Of fighters'94--------------\n");
  printf("\n----------------Que empiece el juego ! ---------------\n");
  
  yyin = fopen(argv[1], "r");
  yylex();
  fclose(yyin);
  
  FILE *archivo = fopen(argv[1], "r");
  if (archivo == NULL) {
  printf("No es posible ejecutar el archivo: %s\n", argv[1]);
  return 1;
  }
}
