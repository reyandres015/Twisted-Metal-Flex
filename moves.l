%{
#include <stdio.h>
#include <stdbool.h>
#include <string.h>

/* Variables globales*/
int number_of_players = 0; /* Número de jugadores */

bool SceneSelection = false; /* ¿Escenario ya se selecciono? */
bool inGame = false; /* ¿Ya se inicio el juego? */

typedef struct {
    char name[20];
    int vida;
    int energia;
    char direccion[20];
    int x;
    int y;
} Player; /* Clase jugador */

/* Arreglo de jugadores seleccionados */
Player players[4];

int actualPlayer = 0; /* Jugador actual */

char matrix[4][4][20] = {
    {"", "Grasshopper", "", ""},
    {"", "Outlaw 2", "", ""},
    {"Mr. Slam", "", "", ""},
    {"Twister", "", " ", " "}
}; /* Matriz del campo de juego */

/* Función para identificar si un jugador ya fue seleccionado. */
bool isCharacterSelected(char* character) {
    for (int i = 0; i < number_of_players; i++) {
        if (strcmp(players[i].name, character) == 0) {
            return true;
        }
    }
    return false;
}

/* CONTINUAR JUEGO */
void continueGame() {
    if(inGame){
        printf("\n");
        actualPlayer++;
        printf("Turno del jugador %d: %s", actualPlayer+1, players[actualPlayer].name);
    }else{
        printf("You need to select a character first");
    }
}

/* Función para seleccionar un personaje */
void selectCharacter(char* character) {
    if(!inGame){
        if(SceneSelection){
            if (!isCharacterSelected(character)) {
                Player newPlayer = {.vida = 200, .energia = 200};                  
                strncpy(newPlayer.name, character, sizeof(newPlayer.name));
                strncpy(newPlayer.direccion, "arriba", sizeof(newPlayer.direccion));
                players[actualPlayer] = newPlayer;
                printf("Character %d selected: %s \n", actualPlayer+1, players[actualPlayer].name);
                actualPlayer++;

                /* Si ya se seleccionaron los 4 jugadores */
                if(actualPlayer == number_of_players){
                    inGame = true;
                    printf("The %d players have been selected. The game is ready to start\n",number_of_players);
                    actualPlayer = -1;
                    continueGame();
                }
            } else {
                printf("Character %s has already been selected\n", character);
            }
        }else{
          printf("You need to select a scene first");
        }
    }else{
        printf("You are in game you can't select a character in here");
    }
}

%}

ESCENARIO   "Moscow"|"Paris"|"Amazonia"|"New York"|"Antartica"|"Holland"|"Hong Kong"|"Dark Tooth"

%option noyywrap

NUMERO_JUGADORES   "2"|"3"|"4"

%option noyywrap

/* Personajes */
PLAYER   "Axel"|"Grasshopper"|"Mr. Grimm"|"Hammerhead"|"Minion"|"Outlaw 2"|"Roadkill"|"Shadow"|"Mr. Slam"|"Spectre"|"Sweettooth"|"Thumper"|"Twister"|"Warthog"

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

%option noyywrap

%%

 /* TOKEN ESCENARIO SELECCIONADO */
{ESCENARIO} {
  SceneSelection = true;
  printf("\nEscenario seleccionado: %s\n", yytext);
}


 /* TOKEN NUMERO DE JUGADORES*/
{NUMERO_JUGADORES} {
  number_of_players = atoi(yytext);
  printf("\nNumero de jugadores: %d\n", number_of_players);
}

 /* TOKEN PLAYER -> Seleccion de personajes y guardado en arreglo*/
{PLAYER} {
  selectCharacter(yytext);
}

 /* TOKEN DIRECCIONES */
{tk_up} {
  if(inGame){
    strncpy(players[actualPlayer].direccion, "arriba", sizeof(players[actualPlayer-1].direccion));
    printf("%s is moving up\n", players[actualPlayer].name);
    continueGame();
  }else{
    printf("You need to select a character first");
  }
}

{tk_down} {
  if(inGame){
    strncpy(players[actualPlayer].direccion, "abajo", sizeof(players[actualPlayer-1].direccion));
    printf("%s is moving down\n", players[actualPlayer].name);
    continueGame();
  }else{
    printf("You need to select a character first");
  }
}

{tk_left} {
  if(inGame){
    strncpy(players[actualPlayer].direccion, "izquierda", sizeof(players[actualPlayer-1].direccion));
    printf("%s is moving left\n", players[actualPlayer].name);
    continueGame();
  }else{
    printf("You need to select a character first");
  }
}

{tk_right} {
  if(inGame){
    strncpy(players[actualPlayer].direccion, "derecha", sizeof(players[actualPlayer-1].direccion));
    printf("%s is moving right\n", players[actualPlayer].name);
    continueGame();
  }else{
    printf("You need to select a character first");
  }
}

 /* TOKEN VELOCIDADES */
{tk_turbo} {
  if(inGame){
    printf("Player %d is using turbo\n", actualPlayer);
  }else{
    printf("You need to select a character first");
  }
}

{tk_brake} {
  if(inGame){
    printf("Player %d is using brake\n", actualPlayer);
  }else{
    printf("You need to select a character first");
  }
}

{tk_acelerate} {
  if(inGame){
    printf("Player %d is using acelerate\n", actualPlayer);
  }else{
    printf("You need to select a character first");
  }
}

 /* TOKEN ARMAS */
{tk_L1} {
  if(inGame){
    printf("Player %d is changing weapon to the left\n", actualPlayer);
  }else{
    printf("You need to select a character first");
  }
}

{tk_L2} {
  if(inGame){
    printf("Player %d is shooting\n", actualPlayer);
  }else{
    printf("You need to select a character first");
  }
}

{tk_R1} {
  if(inGame){
    printf("Player %d is changing weapon to the right\n", actualPlayer);
  }else{
    printf("You need to select a character first");
  }
}

{tk_R2} {
  if(inGame){
    printf("Player %d is using the machine gun\n", actualPlayer);
  }else{
    printf("You need to select a character first");
  }
}

 /* TOKEN ATAQUES ESPECIALES */

{tk_jump} {
  if(inGame){
    printf("Player %d is jumping\n", actualPlayer);
  }else{
    printf("You need to select a character first");
  }
}

{tk_freeze} {
  if(inGame){
    printf("Player %d is freezing\n", actualPlayer);
  }else{
    printf("You need to select a character first");
  }
}

{tk_mine} {
  if(inGame){
    printf("Player %d is placing a mine\n", actualPlayer);
  }else{
    printf("You need to select a character first");
  }
}

{tk_invisible} {
  if(inGame){
    printf("Player %d is becoming invisible\n", actualPlayer);
  }else{
    printf("You need to select a character first");
  }
}

 /* TOKEN ERROR */
. {
  printf("Error: %s\n", yytext);
}

%%
int main(int argc, char const *argv[]) {
  printf(" ");
  printf("\n--------------Twisted Metal--------------\n");
  
  yyin = fopen(argv[1], "r");
  yylex();
  fclose(yyin);
  
  FILE *archivo = fopen(argv[1], "r");
  if (archivo == NULL) {
  printf("No es posible ejecutar el archivo: %s\n", argv[1]);
  return 1;
  }
}
