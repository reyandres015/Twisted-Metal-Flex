%{
#include <stdio.h>
#include <stdbool.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>

#define PI 3.14159265

/* Variables globales*/
int number_of_players = 4; /* Número de jugadores */

bool SceneSelection = false; /* ¿Escenario ya se selecciono? */
bool inGame = false; /* ¿Ya se inicio el juego? */

char brujula[4] = {'N', 'E', 'S', 'O'};

typedef struct {
    char name[20];
    int damage;
} Weapon; /* Clase arma */

typedef struct {
    char name[20];
    int vida;
    int direccion; /*indice de la brujula*/
    int x;
    int y;
    int selectedWeapon;
    bool canMove;
    bool invisible;
} Player; /* Clase jugador */


/*arreglo de armas */
Weapon weapons[3];
Weapon ametralladora;

typedef struct {
    char name[20];
    int damage;
} SpecialAttack; /* Clase ataque especial */

/* Arreglo de jugadores seleccionados */
Player players[4];

int actualPlayer = 0; /* Jugador actual */
int playerAttaked;

#define FILAS 10;
#define COLUMNAS 10;
/* inicializar matriz llena de -1*/
int matrix[10][10];

/* Función para identificar si un jugador ya fue seleccionado. */
bool isCharacterSelected(char* character) {
    for (int i = 0; i < number_of_players; i++) {
        if (strcmp(players[i].name, character) == 0) {
            return true;
        }
    }
    return false;
}

void startGame(){
  Weapon newWeapon = {.damage = 10};
  strncpy(newWeapon.name, "pistola", sizeof(newWeapon.name));
  weapons[0] = newWeapon;

  newWeapon.damage = 30;
  strncpy(newWeapon.name, "Bazuca", sizeof(newWeapon.name));
  weapons[1] = newWeapon;

  newWeapon.damage = 10;
  strncpy(newWeapon.name, "Granada", sizeof(newWeapon.name));
  weapons[2] = newWeapon;

  newWeapon.damage = 40;
  strncpy(newWeapon.name, "Ametralladora", sizeof(newWeapon.name));
  
  ametralladora = newWeapon;
}

/* Ubicar jugadores en la matriz */
void ubicarJugadores(){
  for (int i = 0; i < 10; i++) {
    for (int j = 0; j < 10; j++) {
      matrix[i][j] = -1;
    }
  }

  for(int i = 0; i < number_of_players; i++){ 
      switch(i){
        case 0:
          players[i].x = 0;
          players[i].y = 0;
          matrix[0][0] = i;
          players[i].direccion = 2;
          break;
        case 1:
          players[i].x = 9;
          players[i].y = 0;
          matrix[0][9] = i;
          players[i].direccion = 2;
          break;
        case 2:
          players[i].x = 0;
          players[i].y = 9;
          matrix[9][0] = i;
          break;
        case 3:
          players[i].x = 9;
          players[i].y = 9;
          matrix[9][9] = i;
          break;
      }
    }
}

/* CONTINUAR JUEGO */
void continueGame() {
    /* Verificar si solo queda un jugador vivo */
    int playersAlive = 0;
    for (int i = 0; i < number_of_players; i++) {
        if (players[i].vida > 0) {
            playersAlive++;
        }
    }
    if(playersAlive == 1){
        printf("Player %d wins\n", actualPlayer+1);
        inGame = false;
        /* Finalizar ejecucion del programa*/
        exit(0);

    } else if(playersAlive == 0){
        printf("No players alive\n");
        inGame = false;
        /* Finalizar ejecucion del programa*/
        exit(0);
    }

    if(inGame){
        if(players[actualPlayer+1].vida == 0){
          actualPlayer++;
          printf("Player %d is dead\n", actualPlayer+1);
          if(players[actualPlayer+1].vida == 0){
            actualPlayer++;
            printf("Player %d is dead\n", actualPlayer+1);
          }
        } else {
          /* Imprimir matriz */
          for (int i = 0; i < 10; i++) {
              for (int j = 0; j < 10; j++) {
                      if(matrix[i][j] != -1){
                          int index = matrix[i][j];
                          if(players[index].vida == 0){
                            printf("%d💀 ", index + 1);
                          } else if(players[index].invisible){
                            printf("%d👻 ", index + 1);
                          } else {
                            if(players[index].direccion == 0){
                                printf("%d👆 ", index + 1);
                            } else if(players[index].direccion == 1){
                                printf("%d👉 ", index + 1);
                            } else if(players[index].direccion == 2){
                                printf("%d👇 ", index + 1);
                            } else if(players[index].direccion == 3){
                                printf("%d👈 ", index + 1);
                            }
                          }
                          
                      } else {
                          printf("--- ");
                      }
              }
              printf("\n");
          }

          /* Imprimir vida de los jugadores */
          for (int i = 0; i < number_of_players; i++) {
              printf("Player %s:, Vida: %d\n", players[i].name, players[i].vida);
          }
        }
        printf("\n");
        /* Cambiar de jugador */
        if(actualPlayer == number_of_players-1){ /* Si es el último jugador */
            actualPlayer = 0; /* Iniciar nueva ronda */
        } else{
            actualPlayer++; /* Siguiente jugador */
        }
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
                /* Crear jugador */
                Player newPlayer = {.vida = 100, .direccion = 0, .canMove = true, .invisible = false, .selectedWeapon = 1};
                strncpy(newPlayer.name, character, sizeof(newPlayer.name));

                players[actualPlayer] = newPlayer;
                printf("Character %d selected: %s \n", actualPlayer+1, players[actualPlayer].name);
                actualPlayer++;

                /* Si ya se seleccionaron todos los jugadores */
                if(actualPlayer == number_of_players){
                    ubicarJugadores();
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


int isAngleBetweenMinus15And15(int x1, int y1, int x2, int y2) {
    double angle = atan2(y2 - y1, x2 - x1) * (180 / PI);

    int minAngle;
    int maxAngle;

    switch (players[actualPlayer].direccion) {
      case 0: /*Norte*/
        minAngle = 255;
        maxAngle = 285;
        break;
      case 1: /*Este*/
        minAngle = 345;
        maxAngle = 15;
        break;
      case 2: /*Sur*/
        minAngle = 75;
        maxAngle = 105;
        break;
      case 3: /*Oeste*/
        minAngle = 165;
        maxAngle = 195;
        break;
    }

    if (angle < 0) {
        angle += 360;
    }
    printf("Angle: %f°\n", angle);
    printf("Min angle: %d°\n", minAngle);
    printf("Max angle: %d°\n", maxAngle);

    if ((angle >= minAngle && angle <= maxAngle)) {
        return 1; 
    } else {
        if ((angle >= minAngle+30 && angle <= maxAngle+30)) {
            srand(time(0)); // seed the random number generator
            return rand() % 2; // return 0 or 1 with equal probability
        } else {
            return 0; 
        }
    }
   
}

char* modify_yytext(char* yytext) {
    if(strlen(yytext) > 2) {
        return &yytext[2];
    } else {
        return NULL;
    }
}

char* modify_yytext3(char* yytext) {
    if(strlen(yytext) > 2) {
        return &yytext[4];
    } else {
        return NULL;
    }
}

int findPlayerByName(Player players[], int numPlayers, const char* name) {
    for (int i = 0; i < numPlayers; i++) {
        if (strcmp(players[i].name, name) == 0) {
            return i;
        }
    }
    return -1;
}




%}

ESCENARIO   "Moscow"|"Paris"|"Amazonia"|"New York"|"Antartica"|"Holland"|"Hong Kong"|"Dark Tooth"


/* Personajes */
PLAYER   "Axel"|"Grasshopper"|"Mr. Grimm"|"Hammerhead"|"Minion"|"Outlaw 2"|"Roadkill"|"Shadow"|"Mr. Slam"|"Spectre"|"Sweettooth"|"Thumper"|"Twister"|"Warthog"


/*Movimientos de direccion*/
Direccion_Arriba	    "W"
Direccion_Abajo	    "S"
Direccion_Izquierda	  "A"
Direccion_Derecha	      "D"

tk_forward     ({Direccion_Arriba})
tk_back   ({Direccion_Abajo})
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

 /* TOKEN ESCENARIO SELECCIONADO */
{ESCENARIO} {
  SceneSelection = true;
  startGame();
  printf("\nEscenario seleccionado: %s\n", yytext);
}


 /* TOKEN PLAYER -> Seleccion de personajes y guardado en arreglo*/
{PLAYER} {
  selectCharacter(yytext);
}

 /* TOKEN DIRECCIONES */
{tk_forward} {
  if(inGame){
    printf("%s is moving forward\n", players[actualPlayer].name);

    int direccion = players[actualPlayer].direccion;

    matrix[players[actualPlayer].y][players[actualPlayer].x] = -1;/*borrar posicion anterior*/

    switch (direccion) {
      case 0: /*Norte*/
        if(players[actualPlayer].y > 0){
          players[actualPlayer].y--;
        } else{
          printf("You can't move forward\n");
        }
        break;
      case 1: /*Este*/
        if(players[actualPlayer].x < 9){
          players[actualPlayer].x++;
        }else{
          printf("You can't move forward\n");
        }
        break;
      case 2: /*Sur*/
        if(players[actualPlayer].y < 9){
          players[actualPlayer].y++;
        }else{
          printf("You can't move forward\n");
        }
        break;
      case 3: /*Oeste*/
        if(players[actualPlayer].x > 0){
          players[actualPlayer].x--;
        }else{
          printf("You can't move forward\n");
        }
        break;
    }
    matrix[players[actualPlayer].y][players[actualPlayer].x] = actualPlayer; /*asignar nueva posicion del player*/

    /*SIGUIENTE TURNO*/
    continueGame();
  }else{
    printf("You need to select a character first");
  }
}

{tk_back} {
  if(inGame){
    printf("%s is moving back\n", players[actualPlayer].name);
    int direccion = players[actualPlayer].direccion;

    matrix[players[actualPlayer].y][players[actualPlayer].x] = -1;/*borrar posicion anterior*/

    switch (direccion) {
      case 0: /*Norte*/
        if(players[actualPlayer].y < 9){
          players[actualPlayer].y++;
        }
        break;
      case 1: /*Este*/
        if(players[actualPlayer].x > 0){

          players[actualPlayer].x--;
        }
        break;
      case 2: /*Sur*/
        if(players[actualPlayer].y > 0){
          players[actualPlayer].y--;
        }
        break;
      case 3: /*Oeste*/
        if(players[actualPlayer].x < 9){
          players[actualPlayer].x++;
        }
        break;
    }
    matrix[players[actualPlayer].y][players[actualPlayer].x] = actualPlayer;/*asignar nueva posicion del player*/

    /*SIGUIENTE TURNO*/
    continueGame();
  }else{
    printf("You need to select a character first");
  }
}

{tk_left} {
  if(inGame){
    /* Cambiar direccion */
    if(players[actualPlayer].direccion == 0){  /*Si esta en el norte*/
        players[actualPlayer].direccion = 3; /*cambiar a oeste (ultima posicion del array)*/
    } else {
        players[actualPlayer].direccion--; /*cambiar a la izquierda */
    }
    printf("%s is moving left\n", players[actualPlayer].name);

    /*SIGUIENTE TURNO*/
    continueGame();
  }else{
    printf("You need to select a character first");
  }
}

{tk_right} {
  if(inGame){
    if(players[actualPlayer].direccion == 3){ /*Si esta en el oeste*/
        players[actualPlayer].direccion = 0; /*cambiar a norte (primera posicion del array)*/
    } else {
        players[actualPlayer].direccion++; /*cambiar a la derecha */
    }
    printf("%s is moving right\n", players[actualPlayer].name);

    /*SIGUIENTE TURNO*/
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
{tk_L2}{PLAYER} {
  if(inGame){ 
    playerAttaked = findPlayerByName(players,number_of_players, modify_yytext(yytext));
    if(isAngleBetweenMinus15And15(players[actualPlayer].x, players[actualPlayer].y, players[playerAttaked].x, players[playerAttaked].y) == 1){
      players[playerAttaked].vida -= weapons[players[actualPlayer].selectedWeapon].damage;
      printf("Ataque al player %s, Y se quedo con: %d\n", players[playerAttaked].name, players[playerAttaked].vida);
    }else{
      printf("El ataque falló\n");
    }

  }else{
    printf("You need to select a character first");
  }
  continueGame();
}

{tk_L1}{tk_L2}{PLAYER} {
  if(inGame){
    printf("Player %d is changing weapon to the left\n", actualPlayer+1);
    if(players[actualPlayer].selectedWeapon == 0){
        players[actualPlayer].selectedWeapon = 2;
    } else {
        players[actualPlayer].selectedWeapon--;
    }
    printf("%s seleccionada\n", weapons[players[actualPlayer].selectedWeapon].name);
    /*imprimir direccion*/
    playerAttaked = findPlayerByName(players,number_of_players, modify_yytext3(yytext));
    if(isAngleBetweenMinus15And15(players[actualPlayer].x, players[actualPlayer].y, players[playerAttaked].x, players[playerAttaked].y) == 1){
      players[playerAttaked].vida -= weapons[players[actualPlayer].selectedWeapon].damage;
      printf("Ataque al player %s, Y se quedo con: %d\n", players[playerAttaked].name, players[playerAttaked].vida);
    }else{
      printf("El ataque falló\n");
    }
  }else{
    printf("You need to select a character first");
  }
}

{tk_R1}{tk_L2}{PLAYER} {
  if(inGame){
    printf("Player %d is changing weapon to the right\n", actualPlayer+1);
    if(players[actualPlayer].selectedWeapon == 2){
        players[actualPlayer].selectedWeapon = 0;
    } else {
        players[actualPlayer].selectedWeapon++;
    }
    printf("%s seleccionada\n", weapons[players[actualPlayer].selectedWeapon].name);
    playerAttaked = findPlayerByName(players,number_of_players, modify_yytext3(yytext));
    if(isAngleBetweenMinus15And15(players[actualPlayer].x, players[actualPlayer].y, players[playerAttaked].x, players[playerAttaked].y) == 1){
      players[playerAttaked].vida -= weapons[players[actualPlayer].selectedWeapon].damage;
      printf("Ataque al player %s, Y se quedo con: %d\n", players[playerAttaked].name, players[playerAttaked].vida);
    }else{
      printf("El ataque falló\n");
    }
  }else{
    printf("You need to select a character first");
  }
}

{tk_R2}{PLAYER} {
  if(inGame){ 
    playerAttaked = findPlayerByName(players,number_of_players, modify_yytext(yytext));
    if(isAngleBetweenMinus15And15(players[actualPlayer].x, players[actualPlayer].y, players[playerAttaked].x, players[playerAttaked].y) == 1){
      players[playerAttaked].vida -= weapons[players[actualPlayer].selectedWeapon].damage;
      printf("Ataque al player %s, Y se quedo con: %d\n", players[playerAttaked].name, players[playerAttaked].vida);
    }else{
      printf("El ataque falló\n");
    }

  }else{
    printf("You need to select a character first");
  }
  continueGame();
}

{tk_R1}{tk_R2}{PLAYER} {
  if(inGame){ 
    printf("Player %d is changing weapon to the right\n", actualPlayer+1);
    if(players[actualPlayer].selectedWeapon == 2){
        players[actualPlayer].selectedWeapon = 0;
    } else {
        players[actualPlayer].selectedWeapon++;
    }
    printf("%s seleccionada\n", weapons[players[actualPlayer].selectedWeapon].name);
    playerAttaked = findPlayerByName(players,number_of_players, modify_yytext3(yytext));
    if(isAngleBetweenMinus15And15(players[actualPlayer].x, players[actualPlayer].y, players[playerAttaked].x, players[playerAttaked].y) == 1){
      players[playerAttaked].vida -= weapons[players[actualPlayer].selectedWeapon].damage;
      printf("Ataque al player %s, Y se quedo con: %d\n", players[playerAttaked].name, players[playerAttaked].vida);
    }else{
      printf("El ataque falló\n");
    }

  }else{
    printf("You need to select a character first");
  }
  continueGame();
}

{tk_L1}{tk_R2}{PLAYER} {
  if(inGame){ 
    printf("Player %d is changing weapon to the left\n", actualPlayer+1);
    if(players[actualPlayer].selectedWeapon == 0){
        players[actualPlayer].selectedWeapon = 2;
    } else {
        players[actualPlayer].selectedWeapon--;
    }
    printf("%s seleccionada\n", weapons[players[actualPlayer].selectedWeapon].name);
    
    playerAttaked = findPlayerByName(players,number_of_players, modify_yytext3(yytext));
    if(isAngleBetweenMinus15And15(players[actualPlayer].x, players[actualPlayer].y, players[playerAttaked].x, players[playerAttaked].y) == 1){
      players[playerAttaked].vida -= weapons[players[actualPlayer].selectedWeapon].damage;
      printf("Ataque al player %s, Y se quedo con: %d\n", players[playerAttaked].name, players[playerAttaked].vida);
    }else{
      printf("El ataque falló\n");
    }

  }else{
    printf("You need to select a character first");
  }
  continueGame();
}

 /* ATAQUES ESPECIALES */

{tk_forward}{tk_back}{tk_forward} { /* freeze */
  if(inGame){
    printf("Player %d is freezing\n", actualPlayer);
  }else{
    printf("You need to select a character first");
  }
}
{tk_forward}{tk_left}{tk_left} { /* JUMP */
  if(inGame){
    printf("Player %d is jumping\n", actualPlayer);
  }else{
    printf("You need to select a character first");
  }
}


{tk_right}{tk_left}{tk_back} { /* MINE */
  if(inGame){
    printf("Player %d is placing a mine\n", actualPlayer);
  }else{
    printf("You need to select a character first");
  }
}

{tk_left}{tk_left}{tk_back}{tk_back} { /* BE INVISIBLE */
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
