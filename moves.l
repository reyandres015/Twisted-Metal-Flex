%{
#include <stdio.h>
#include <stdbool.h>
#include <string.h>

/* Definicion de variables globales*/
int number_of_players = 0; /* Número de jugadores */
/* Arreglo de juegadores seleccionados */

bool SceneSelection = false;
bool inGame = false;

char players[4][20];
char matrix[4][4][20] = {
    {"", "Grasshopper", "", ""},
    {"", "Outlaw 2", "", ""},
    {"Mr. Slam", "", "", ""},
    {"Twister", "", " ", " "}
};
int player = 0; /* Jugador actual */

bool isCharacterSelected(const char* character) {
    for (int i = 0; i < number_of_players; i++) {
        if (strcmp(players[i], character) == 0) {
            return true;
        }
    }
    return false;
}

void selectCharacter(const char* character) {
    if(!inGame){
        if(SceneSelection){
          if (player < number_of_players) {
              if (!isCharacterSelected(character)) {
                  strcpy(players[player], character);
                  player++;
                  printf("Character %d selected: %s \n", player, character);
              } else {
                  printf("Character %s has already been selected\n", character);
              }
          } else {
              inGame = true;
              printf("The 4 players have been selected, you can't select one more");
          }
        }else{
          printf("You need to select a scene first");
        }
    }else{
        printf("You are in game you can't select a character in here");
    }
}


int Japon [3] = {200,200,200}; /*Cada equipo cuenta con [3] personajes*/
int Italia [3] = {200,200,200}; /*Cada personaje cuenta con su barra completa de vida*/

%}

/* Token para cada escenario predefinido*/
Tk_escenario_Moscow      "Moscow"
Tk_escenario_Paris       "Paris"
Tk_escenario_Amazonia    "Amazonia"
Tk_escenario_NewYork     "New York"
Tk_escenario_Antartica   "Antartica"
Tk_escenario_Holland     "Holland"
Tk_escenario_HongKong    "Hong Kong"
Tk_escenario_DarkTooth   "Dark Tooth"

/* Llamda por escenario*/
tk_Moscow      ({Tk_escenario_Moscow})
tk_Paris       ({Tk_escenario_Paris})
tk_Amazonia    ({Tk_escenario_Amazonia})
tk_NewYork     ({Tk_escenario_NewYork})
tk_Antartica   ({Tk_escenario_Antartica})
tk_Holland     ({Tk_escenario_Holland})
tk_HongKong    ({Tk_escenario_HongKong})
tk_DarkTooth   ({Tk_escenario_DarkTooth})

%option noyywrap

Tk_2 "2"
Tk_3 "3"
Tk_4 "4"

/* Llamada por numero de jugadores*/
tk_2 ({Tk_2})
tk_3 ({Tk_3})
tk_4 ({Tk_4})

%option noyywrap

/* Personajes */
PLAYER    "Axel"|"Grasshopper"|"Mr. Grimm"|"Hammerhead"|"Minion"|"Outlaw 2"|"Roadkill"|"Shadow"|"Mr. Slam"|"Spectre"|"Sweettooth"|"Thumper"|"Twister"|"Warthog"


%option noyywrap

/*Movimientos de direccion*/
Direccion_Arriba	    "W"
Direccion_Derecha	    "S"
Direccion_Izquierda	  "A"
Direccion_Abajo	      "D"

tk_up     ({Direccion_Arriba})
tk_down   ({Direccion_Abajo})
tk_left   ({Direccion_Izquierda})
tk_right  ({Direccion_Derecha})


/*Movimientos de velocidad*/
Velocidad_Turbo		  "speed_turbo"
Velocidad_Frenar	  "speed_brake"
Velocidad_Acelerar	"speed_up"

tk_turbo      ({Velocidad_Turbo})
tk_brake      ({Velocidad_Frenar})
tk_acelerate  ({Velocidad_Acelerar})

/*Armas y cambio de armas*/
Armas_CambioIzq		    "L1"
Armas_Disparar		    "L2"
Armas_CambioDer		    "R1"
Armas_Ametralladora	  "R2"

tk_L1 ({Armas_CambioIzq})
tk_L2 ({Armas_Disparar})
tk_R1 ({Armas_CambioDer})
tk_R2 ({Armas_Ametralladora})


/*Ataques especiales*/
Ataque_Jump         "Jump"
Ataque_Freeze       "Freeze"
Ataque_Mine         "Mine"
Ataque_BeInvisible  "BeInvisible"

tk_jump         ({Ataque_Jump})
tk_freeze       ({Ataque_Freeze})
tk_mine         ({Ataque_Mine})
tk_invisible    ({Ataque_BeInvisible})

%%

 /*DEFINICION DE REGALAS PARA CADA TOKEN DEL ESCENARIO SELECCIONADO*/
({tk_Moscow}|{tk_Paris}|{tk_Amazonia}|{tk_NewYork}|{tk_Antartica}|{tk_Holland}|{tk_HongKong}|{tk_DarkTooth}) {
  SceneSelection = true;
  printf("\nEscenario seleccionado: %s\n", yytext);
}


 /*DEFINICION NUMERO DE JUGADORES*/
({tk_2}|{tk_3}|{tk_4}) {
  number_of_players = atoi(yytext);
  printf("\nNumero de jugadores: %d\n", number_of_players);
}

 /*Seleccion de personajes y guardado en arreglo*/
{PLAYER} {
  selectCharacter(yytext);
}

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
