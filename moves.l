%{
#include <stdio.h>
#include <stdbool.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>


#define PI 3.14159265

/* Variables globales*/
int numberOfPlayers = 4; /* Número de jugadores */

<<<<<<< HEAD
bool SceneSelection = false; /* ¿Escenario ya se selecciono? */
bool inGame = false; /* ¿Ya se inicio el juego? */

=======
bool sceneSelection = false; /* ¿SCENE ya se selecciono? */
bool = false; /* ¿Ya se inicio el juego? */
>>>>>>> 5fc18269d2890053d261024ae6369e68f63d6698

typedef struct {
    char name[20];
    int damage;
} Weapon; /* Clase arma */

typedef struct {
    char name[20];
    int health;
    int direction; /*0 = Norte, 1 = Este, 2 = Sur, 3 = Oeste*/
    int x;
    int y;
    int selectedWeapon;
    bool canMove;
    bool invisible;
    bool shot; /* ¿Ya disparo? */	
} Player; /* Clase jugador */


/*arreglo de armas */
Weapon weapons[3];
Weapon machineGun;

typedef struct {
    char name[20];
    int damage;
} SpecialAttack; /* Clase ataque especial */

/* Arreglo de jugadores seleccionados */
Player players[4];

int actualPlayer = 0; /* Jugador actual */
int playerAttaked;

/* inicializar matriz llena de -1*/
int matrix[10][10];

/* Función para identificar si un jugador ya fue seleccionado. */
bool isCharacterSelected(char* character) {
    for (int i = 0; i < numberOfPlayers; i++) {
        if (strcmp(players[i].name, character) == 0) {
            return true;
        }
    }
    return false;
}

void startGame(){
  Weapon newWeapon = {.damage = 10};
  strncpy(newWeapon.name, "SOCOM", sizeof(newWeapon.name));
  weapons[0] = newWeapon;

  newWeapon.damage = 30;
  strncpy(newWeapon.name, "FAMAS", sizeof(newWeapon.name));
  weapons[1] = newWeapon;

  newWeapon.damage = 20;
  strncpy(newWeapon.name, "GRANADE", sizeof(newWeapon.name));
  weapons[2] = newWeapon;

  newWeapon.damage = 40;
  strncpy(newWeapon.name, "MACHINEGUN", sizeof(newWeapon.name));
  
  machineGun = newWeapon;
}

/* Ubicar jugadores en la matriz */
void locatePlayers(){
  for (int i = 0; i < 10; i++) {
    for (int j = 0; j < 10; j++) {
      matrix[i][j] = -1;
    }
  }

  for(int i = 0; i < numberOfPlayers; i++){ 
      switch(i){
        case 0:
          players[i].x = 0;
          players[i].y = 0;
          matrix[0][0] = i;
          players[i].direction = 2;
          break;
        case 1:
          players[i].x = 9;
          players[i].y = 0;
          matrix[0][9] = i;
          players[i].direction = 2;
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
    for (int i = 0; i < numberOfPlayers; i++) {
        if (players[i].health > 0) {
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
        if(players[actualPlayer + 1].health == 0 && actualPlayer < 3){
          actualPlayer++;
          printf("Player %d is dead\n", actualPlayer);
          if(players[actualPlayer + 1].health == 0 && actualPlayer < 3){
            actualPlayer++;
            printf("Player %d is dead\n", actualPlayer);
          } else if(actualPlayer == 3) {
            actualPlayer = 0
            printf("Player %d is dead\n", actualPlayer);
          }
        } else if(actualPlayer == 3) {
          actualPlayer = 0
          printf("Player %d is dead\n", actualPlayer);
          if(players[actualPlayer + 1].health == 0){
            actualPlayer++;
            printf("Player %d is dead\n", actualPlayer);
          }
        } else {
          /* Imprimir matriz */
          for (int i = 0; i < 10; i++) {
              for (int j = 0; j < 10; j++) {
                      if(matrix[i][j] != -1){
                          int index = matrix[i][j];
                          if(matrix[i][j] == -2){
                            printf("💣 ");
                          } else if(players[index].vida == 0){
<<<<<<< HEAD
                            printf("%d💀 ", index + 1);
                          } else if(players[index].invisible){
                            printf("%d👻 ", index + 1);
                          } else if(players[index].canMove == false){
                            printf("%d❄️ ", index + 1);
=======
                            printf("💀%d ", index + 1);
                          } else if(players[index].invisible){
                            printf("👻%d ", index + 1);
>>>>>>> 5fc18269d2890053d261024ae6369e68f63d6698
                          } else {
                            if(players[index].direction == 0){
                                printf("⬆️%d ", index + 1);
                            } else if(players[index].direction == 1){
                                printf("➡️%d ", index + 1);
                            } else if(players[index].direction == 2){
                                printf("⬇️%d ", index + 1);
                            } else if(players[index].direction == 3){
                                printf("⬅️%d ", index + 1);
                            }
                          }
                          
                      } else {
                          printf(" --- ");
                      }
              }
              printf("\n");
          }
<<<<<<< HEAD

          /* Imprimir vida de los jugadores */
          for (int i = 0; i < number_of_players; i++) {
              printf("Player %s:, Vida: %d\n", players[i].name, players[i].vida);
=======
          /* Imprimir vida de los jugadores */
          for (int i = 0; i < number_of_players; i++) {
              printf("Player %s:, health: %d\n", players[i].name, players[i].vida);
>>>>>>> 5fc18269d2890053d261024ae6369e68f63d6698
          }
        }
        printf("\n");
        /* Cambiar de jugador */
        if(actualPlayer == numberOfPlayers-1){ /* Si es el último jugador */
            actualPlayer = 0; /* Iniciar nueva ronda */
        } else{
            actualPlayer++; /* Siguiente jugador */
        }
<<<<<<< HEAD
        players[actualPlayer].canMove = true;
        printf("Turno del jugador %d: %s", actualPlayer+1, players[actualPlayer].name);
=======
        printf("Player %d turn: %s", actualPlayer+1, players[actualPlayer].name);
>>>>>>> 5fc18269d2890053d261024ae6369e68f63d6698
    }else{
        printf("You need to select a character first");
    }
}

/* Función para seleccionar un personaje */
void selectCharacter(char* character) {
    if(!inGame){
        if(sceneSelection){
            if (!isCharacterSelected(character)) {
                /* Crear jugador */
                Player newPlayer = {.health = 100, .direction = 0, .canMove = true, .invisible = false, .selectedWeapon = 1};
                strncpy(newPlayer.name, character, sizeof(newPlayer.name));

                players[actualPlayer] = newPlayer;
                printf("Character %d selected: %s \n", actualPlayer+1, players[actualPlayer].name);
                actualPlayer++;

                /* Si ya se seleccionaron todos los jugadores */
                if(actualPlayer == numberOfPlayers){
                    locatePlayers();
                    inGame = true;
                    printf("The %d players have been selected. The game is ready to start\n",numberOfPlayers);
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

<<<<<<< HEAD
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
=======
switch (players[actualPlayer].direction) {
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
>>>>>>> 5fc18269d2890053d261024ae6369e68f63d6698

    if (angle < 0) {
        angle += 360;
    }
<<<<<<< HEAD
    printf("Angle: %f°\n", angle);
    printf("Min angle: %d°\n", minAngle);
    printf("Max angle: %d°\n", maxAngle);
=======
>>>>>>> 5fc18269d2890053d261024ae6369e68f63d6698

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

void placeMine() {
  int x = players[actualPlayer].x;
  int y = players[actualPlayer].y;

switch (players[actualPlayer].direccion) {

      case 0: /*Norte*/
        if(y < 9){
          matrix[++y][x] = -2;
          printf("actual y%d\n", players[actualPlayer].y);
          printf("actual x%d\n", players[actualPlayer].x);
        }
        break;
      case 1: /*Este*/
        if(x > 0){
          matrix[y][--x] = -2;
        }
        break;
      case 2: /*Sur*/
        if(y > 0){
          matrix[--y][x] = -2;

          printf("actual y %d\n", players[actualPlayer].y);
          printf("actual x %d\n", players[actualPlayer].x);

        }
        break;
      case 3: /*Oeste*/
        if(x < 9){
          matrix[y][++x] = -2;
        }
        break;
    }
}

void placeMine() {
  int x = players[actualPlayer].x;
  int y = players[actualPlayer].y;
  printf("%d x, %d y\n", x, y);

switch (players[actualPlayer].direccion) {

      case 0: /*Norte*/
        if(y < 9){
          matrix[++y][x] = -2;
        }
        break;
      case 1: /*Este*/
        if(x > 0){
          matrix[y][--x] = -2;
        }
        break;
      case 2: /*Sur*/
        if(y > 0){
          matrix[--y][x] = -2;
        }
        break;
      case 3: /*Oeste*/
        if(x < 9){
          matrix[y][++x] = -2;
        }
        break;
    }
}

char* modify_yytext(char* yytext) {
    if(strlen(yytext) > 2) {
        return &yytext[2];
    } else {
        return NULL;
    }
}

<<<<<<< HEAD
char* modify_yytext2(char* yytext) {
    if(strlen(yytext) > 2) {
        return &yytext[3];
    } else {
        return NULL;
    }
}

=======
>>>>>>> 5fc18269d2890053d261024ae6369e68f63d6698
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

SCENE   "Moscow"|"Paris"|"Amazonia"|"New York"|"Antartica"|"Holland"|"Hong Kong"|"Dark Tooth"


/* Personajes */
PLAYER   "Axel"|"Grasshopper"|"Mr. Grimm"|"Hammerhead"|"Minion"|"Outlaw 2"|"Roadkill"|"Shadow"|"Mr. Slam"|"Spectre"|"Sweettooth"|"Thumper"|"Twister"|"Warthog"


/*Movimientos de direction*/
move_forward	    "W"
move_back	        "S"
turn_left	        "A"
turn_right	      "D"

<<<<<<< HEAD
tk_forward     ({Direccion_Arriba})
tk_back   ({Direccion_Abajo})
tk_left   ({Direccion_Izquierda})
tk_right  ({Direccion_Derecha})

pasar_turno "pass"

tk_pasar ({pasar_turno})

/*Movimientos de velocidad*/
Velocidad_Turbo		  "speed_turbo"
Velocidad_Frenar	  "speed_brake"
Velocidad_Acelerar	"speed_up"

tk_turbo      ({Velocidad_Turbo})
tk_brake      ({Velocidad_Frenar})
tk_acelerate  ({Velocidad_Acelerar})
=======
tk_forward     ({move_forward})
tk_back        ({move_back})
tk_left        ({turn_left})
tk_right       ({turn_right})
>>>>>>> 5fc18269d2890053d261024ae6369e68f63d6698

/*Armas y cambio de armas*/
change_wp_left		    "L1"
shoot_wp		          "L2"
change_wp_right		    "R1"
machinegun	          "R2"

tk_L1 ({change_wp_left})
tk_L2 ({shoot_wp})
tk_R1 ({change_wp_right})
tk_R2 ({machinegun})


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

 /* TOKEN SCENE SELECCIONADO */
{SCENE} {
  sceneSelection = true;
  startGame();
  printf("\nSelected Scene: %s\n", yytext);
}


 /* TOKEN PLAYER -> Seleccion de personajes y guardado en arreglo*/
{PLAYER} {
  selectCharacter(yytext);
}

<<<<<<< HEAD
{tk_pasar} {
  if(inGame){
    continueGame();
  }else{
    printf("You need to select a character first");
  }
}
  

 /* TOKEN DIRECCIONES */
=======
 /* TOKENS DE DIRECCION */
>>>>>>> 5fc18269d2890053d261024ae6369e68f63d6698
{tk_forward} {
  if(inGame && players[actualPlayer].canMove){

<<<<<<< HEAD
    printf("%s is moving forward\n", players[actualPlayer].name);
    
    int direccion = players[actualPlayer].direccion;
=======
    int direction = players[actualPlayer].direction;
>>>>>>> 5fc18269d2890053d261024ae6369e68f63d6698



    matrix[players[actualPlayer].y][players[actualPlayer].x] = -1;/*borrar posicion anterior*/

    switch (direction) {
      case 0: /*Norte*/
        if(players[actualPlayer].y > 0){
          if(matrix[players[actualPlayer].y-1][players[actualPlayer].x] == -2){
<<<<<<< HEAD
            printf("%s se ha encontrado con una mina \n", players[actualPlayer].name);
            players[actualPlayer].vida -= 50;
            printf("%s Vida restante: %d\n", players[actualPlayer].name, players[actualPlayer].vida);
=======
            printf("%s has found a mine \n", players[actualPlayer].name);
            players[actualPlayer].vida -= 50;
            printf("%s Remaining health: %d\n", players[actualPlayer].name, players[actualPlayer].vida);
>>>>>>> 5fc18269d2890053d261024ae6369e68f63d6698
            players[actualPlayer].y--;
          } else {
            players[actualPlayer].y--;
          }
        } else{
          printf("You can't move forward\n");
        }
        break;
      case 1: /*Este*/
        if(players[actualPlayer].x < 9){
          if(matrix[players[actualPlayer].y][players[actualPlayer].x+1] == -2){
<<<<<<< HEAD
            printf("%s se ha encontrado con una mina \n", players[actualPlayer].name);
            players[actualPlayer].vida -= 50;
            printf("%s Vida restante: %d\n", players[actualPlayer].name, players[actualPlayer].vida);
=======
            printf("%s has found a mine \n", players[actualPlayer].name);
            players[actualPlayer].vida -= 50;
            printf("%s Remaining health: %d\n", players[actualPlayer].name, players[actualPlayer].vida);
>>>>>>> 5fc18269d2890053d261024ae6369e68f63d6698
            players[actualPlayer].x++;
          } else {
            players[actualPlayer].x++;
          }
        }else{
          printf("You can't move forward\n");
        }
        break;
      case 2: /*Sur*/
        if(players[actualPlayer].y < 9){
          if(matrix[players[actualPlayer].y+1][players[actualPlayer].x] == -2){
<<<<<<< HEAD
            printf("%s se ha encontrado con una mina \n", players[actualPlayer].name);
            players[actualPlayer].vida -= 50;
            printf("%s Vida restante: %d\n", players[actualPlayer].name, players[actualPlayer].vida);
=======
            printf("%s has found a mine \n", players[actualPlayer].name);
            players[actualPlayer].vida -= 50;
            printf("%s Remaining health: %d\n", players[actualPlayer].name, players[actualPlayer].vida);
>>>>>>> 5fc18269d2890053d261024ae6369e68f63d6698
            players[actualPlayer].y++;
          } else {
            players[actualPlayer].y++;
          }
        }else{
          printf("You can't move forward\n");
        }
        break;
      case 3: /*Oeste*/
        if(players[actualPlayer].x > 0){
          if(matrix[players[actualPlayer].y][players[actualPlayer].x-1] == -2){
<<<<<<< HEAD
            printf("%s se ha encontrado con una mina \n", players[actualPlayer].name);
            players[actualPlayer].vida -= 50;
            printf("%s Vida restante: %d\n", players[actualPlayer].name, players[actualPlayer].vida);
=======
            printf("%s has found a mine \n", players[actualPlayer].name);
            players[actualPlayer].vida -= 50;
            printf("%s Remaining health: %d\n", players[actualPlayer].name, players[actualPlayer].vida);
>>>>>>> 5fc18269d2890053d261024ae6369e68f63d6698
            players[actualPlayer].x--;
          } else {
            players[actualPlayer].x--;
          }
        }else{
          printf("You can't move forward\n");
        }
        break;
    }
    matrix[players[actualPlayer].y][players[actualPlayer].x] = actualPlayer; /*asignar nueva posicion del player*/

  }else{
    printf("You need to select a character first");
  }
}

{tk_back} {
  if(inGame && players[actualPlayer].canMove){
    printf("%s is moving back\n", players[actualPlayer].name);
    int direction = players[actualPlayer].direction;

    matrix[players[actualPlayer].y][players[actualPlayer].x] = -1;/*borrar posicion anterior*/
<<<<<<< HEAD
    switch (direccion) {
      case 0: /*Norte*/
        if(players[actualPlayer].y > 0){
          if(matrix[players[actualPlayer].y+1][players[actualPlayer].x] == -2){
            printf("%s se ha encontrado con una mina \n", players[actualPlayer].name);
            players[actualPlayer].vida -= 50;
            printf("%s Vida restante: %d\n", players[actualPlayer].name, players[actualPlayer].vida);
=======

    switch (direction) {
      case 0: /*Norte*/
        if(players[actualPlayer].y > 0){
          if(matrix[players[actualPlayer].y+1][players[actualPlayer].x] == -2){
            printf("%s has found a mine \n", players[actualPlayer].name);
            players[actualPlayer].vida -= 50;
            printf("%s Remaining health: %d\n", players[actualPlayer].name, players[actualPlayer].vida);
>>>>>>> 5fc18269d2890053d261024ae6369e68f63d6698
          }
          players[actualPlayer].y++;
        } else{
          printf("You can't move forward\n");
        }
        break;
      case 1: /*Este*/
        if(players[actualPlayer].x < 9){
          if(matrix[players[actualPlayer].y][players[actualPlayer].x-1] == -2){
<<<<<<< HEAD
            printf("%s se ha encontrado con una mina \n", players[actualPlayer].name);
            players[actualPlayer].vida -= 50;
            printf("%s Vida restante: %d\n", players[actualPlayer].name, players[actualPlayer].vida);
=======
            printf("%s has found a mine \n", players[actualPlayer].name);
            players[actualPlayer].vida -= 50;
            printf("%s Remaining health: %d\n", players[actualPlayer].name, players[actualPlayer].vida);
>>>>>>> 5fc18269d2890053d261024ae6369e68f63d6698
          }
          players[actualPlayer].x--;
        }else{
          printf("You can't move forward\n");
        }
        break;
      case 2: /*Sur*/
        if(players[actualPlayer].y < 9){
          if(matrix[players[actualPlayer].y-1][players[actualPlayer].x] == -2){
<<<<<<< HEAD
            printf("%s se ha encontrado con una mina \n", players[actualPlayer].name);
            players[actualPlayer].vida -= 50;
            printf("%s Vida restante: %d\n", players[actualPlayer].name, players[actualPlayer].vida);
=======
            printf("%s has found a mine \n", players[actualPlayer].name);
            players[actualPlayer].vida -= 50;
            printf("%s Remaining health: %d\n", players[actualPlayer].name, players[actualPlayer].vida);
>>>>>>> 5fc18269d2890053d261024ae6369e68f63d6698
          }
          players[actualPlayer].y--;
        }else{
          printf("You can't move forward\n");
        }
        break;
      case 3: /*Oeste*/
        if(players[actualPlayer].x > 0){
          if(matrix[players[actualPlayer].y][players[actualPlayer].x+1] == -2){
<<<<<<< HEAD
            printf("%s se ha encontrado con una mina \n", players[actualPlayer].name);
            players[actualPlayer].vida -= 50;
            printf("%s Vida restante: %d\n", players[actualPlayer].name, players[actualPlayer].vida);
=======
            printf("%s has found a mine \n", players[actualPlayer].name);
            players[actualPlayer].vida -= 50;
            printf("%s Remaining health: %d\n", players[actualPlayer].name, players[actualPlayer].vida);
>>>>>>> 5fc18269d2890053d261024ae6369e68f63d6698
          }
          players[actualPlayer].x++;
        }else{
          printf("You can't move forward\n");
        }
        break;
}

    matrix[players[actualPlayer].y][players[actualPlayer].x] = actualPlayer;/*asignar nueva posicion del player*/

  }else{
    printf("You need to select a character first");
  }
}

{tk_left} {
<<<<<<< HEAD
  if(inGame && players[actualPlayer].canMove){
    /* Cambiar direccion */
    if(players[actualPlayer].direccion == 0){  /*Si esta en el norte*/
        players[actualPlayer].direccion = 3; /*cambiar a oeste (ultima posicion del array)*/
=======
  if(inGame){
    /* Cambiar direction */
    if(players[actualPlayer].direction == 0){  /*Si esta en el norte*/
        players[actualPlayer].direction = 3; /*cambiar a oeste (ultima posicion del array)*/
>>>>>>> 5fc18269d2890053d261024ae6369e68f63d6698
    } else {
        players[actualPlayer].direction--; /*cambiar a la izquierda */
    }
    printf("%s is moving left\n", players[actualPlayer].name);

  }else{
    printf("You need to select a character first");
  }
}

{tk_right} {
<<<<<<< HEAD
  if(inGame && players[actualPlayer].canMove){
    if(players[actualPlayer].direccion == 3){ /*Si esta en el oeste*/
        players[actualPlayer].direccion = 0; /*cambiar a norte (primera posicion del array)*/
=======
  if(inGame){
    if(players[actualPlayer].direction == 3){ /*Si esta en el oeste*/
        players[actualPlayer].direction = 0; /*cambiar a norte (primera posicion del array)*/
>>>>>>> 5fc18269d2890053d261024ae6369e68f63d6698
    } else {
        players[actualPlayer].direction++; /*cambiar a la derecha */
    }
    printf("%s is moving right\n", players[actualPlayer].name);

  }else{
    printf("You need to select a character first");
  }
}

 /* TOKEN ARMAS */
{tk_L2}{PLAYER} {
<<<<<<< HEAD
  /* verificar si el jugador ya disparo*/
  if(players[actualPlayer].shot){
    printf("You can't shoot again\n");
  } else {
    if(inGame){ 
      playerAttaked = findPlayerByName(players,number_of_players, modify_yytext(yytext));
      if(isAngleBetweenMinus15And15(players[actualPlayer].x, players[actualPlayer].y, players[playerAttaked].x, players[playerAttaked].y) == 1){
        players[playerAttaked].vida -= weapons[players[actualPlayer].selectedWeapon].damage;
        printf("Ataque al player %s, Y se quedo con: %d\n", players[playerAttaked].name, players[playerAttaked].vida);
      }else{
        printf("El ataque falló\n");
      }

      /* definir que el jugador ya disparo */
      players[actualPlayer].shot = true;

    }else{
      printf("You need to select a character first");
    }
  }
  
}

{tk_L1}{tk_L2}{PLAYER} {
  /* verificar si el jugador ya disparo*/
  if(players[actualPlayer].shot){
    printf("You can't shoot again\n");
  } else {
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
      /* definir que el jugador ya disparo */
      players[actualPlayer].shot = true;
    }else{
      printf("You need to select a character first");
    }
=======
  if(inGame){ 
    playerAttaked = findPlayerByName(players,number_of_players, modify_yytext(yytext));
    if(isAngleBetweenMinus15And15(players[actualPlayer].x, players[actualPlayer].y, players[playerAttaked].x, players[playerAttaked].y) == 1){
      players[playerAttaked].vida -= weapons[players[actualPlayer].selectedWeapon].damage;
      printf("Attack on player %s, remaining health: %d\n", players[playerAttaked].name, players[playerAttaked].vida);
    }else{
      printf("Failed attack\n");
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
    printf("%s selected\n", weapons[players[actualPlayer].selectedWeapon].name);
    /*imprimir direccion*/
    playerAttaked = findPlayerByName(players,number_of_players, modify_yytext3(yytext));
    if(isAngleBetweenMinus15And15(players[actualPlayer].x, players[actualPlayer].y, players[playerAttaked].x, players[playerAttaked].y) == 1){
      players[playerAttaked].vida -= weapons[players[actualPlayer].selectedWeapon].damage;
      printf("Attack on player %s, remaining health: %d\n", players[playerAttaked].name, players[playerAttaked].vida);
    }else{
      printf("Failed attack\n");
    }
  }else{
    printf("You need to select a character first");
>>>>>>> 5fc18269d2890053d261024ae6369e68f63d6698
  }
}

{tk_R1}{tk_L2}{PLAYER} {
<<<<<<< HEAD
  /* verificar si el jugador ya disparo*/
  if(players[actualPlayer].shot){
    printf("You can't shoot again\n");
  } else {
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
      /* definir que el jugador ya disparo */
      players[actualPlayer].shot = true;
    }else{
      printf("You need to select a character first");
    }
=======
  if(inGame){
    printf("Player %d is changing weapon to the right\n", actualPlayer+1);
    if(players[actualPlayer].selectedWeapon == 2){
        players[actualPlayer].selectedWeapon = 0;
    } else {
        players[actualPlayer].selectedWeapon++;
    }
    printf("%s selected\n", weapons[players[actualPlayer].selectedWeapon].name);
    playerAttaked = findPlayerByName(players,number_of_players, modify_yytext3(yytext));
    if(isAngleBetweenMinus15And15(players[actualPlayer].x, players[actualPlayer].y, players[playerAttaked].x, players[playerAttaked].y) == 1){
      players[playerAttaked].vida -= weapons[players[actualPlayer].selectedWeapon].damage;
      printf("Attack on player %s, remaining health: %d\n", players[playerAttaked].name, players[playerAttaked].vida);
    }else{
      printf("Attack failed\n");
    }
  }else{
    printf("You need to select a character first");
>>>>>>> 5fc18269d2890053d261024ae6369e68f63d6698
  }
}

{tk_R2}{PLAYER} {
<<<<<<< HEAD
  /* verificar si el jugador ya disparo*/
  if(players[actualPlayer].shot){
    printf("You can't shoot again\n");
  } else {
    if(inGame){ 
      playerAttaked = findPlayerByName(players,number_of_players, modify_yytext(yytext));
      if(isAngleBetweenMinus15And15(players[actualPlayer].x, players[actualPlayer].y, players[playerAttaked].x, players[playerAttaked].y) == 1){
        players[playerAttaked].vida -= weapons[players[actualPlayer].selectedWeapon].damage;
        printf("Ataque al player %s, Y se quedo con: %d\n", players[playerAttaked].name, players[playerAttaked].vida);
      }else{
        printf("El ataque falló\n");
      }
      /* definir que el jugador ya disparo */
      players[actualPlayer].shot = true;
    }else{
      printf("You need to select a character first");
    }
  }
}

{tk_R1}{tk_R2}{PLAYER} {
  /* verificar si el jugador ya disparo*/
  if(players[actualPlayer].shot){
    printf("You can't shoot again\n");
  } else {
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
      /* definir que el jugador ya disparo */
      players[actualPlayer].shot = true;
    }else{
      printf("You need to select a character first");
    }
=======
  if(inGame){ 
    playerAttaked = findPlayerByName(players,number_of_players, modify_yytext(yytext));
    if(isAngleBetweenMinus15And15(players[actualPlayer].x, players[actualPlayer].y, players[playerAttaked].x, players[playerAttaked].y) == 1){
      players[playerAttaked].vida -= weapons[players[actualPlayer].selectedWeapon].damage;
      printf("Attack on player %s, remaining health: %d\n", players[playerAttaked].name, players[playerAttaked].vida);
    }else{
      printf("Attack failed\n");
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
    printf("%s selected\n", weapons[players[actualPlayer].selectedWeapon].name);
    playerAttaked = findPlayerByName(players,number_of_players, modify_yytext3(yytext));
    if(isAngleBetweenMinus15And15(players[actualPlayer].x, players[actualPlayer].y, players[playerAttaked].x, players[playerAttaked].y) == 1){
      players[playerAttaked].vida -= weapons[players[actualPlayer].selectedWeapon].damage;
      printf("Attack on player %s, remaining health: %d\n", players[playerAttaked].name, players[playerAttaked].vida);
    }else{
      printf("Attack failed\n");
    }
    continueGame();
  }else{
    printf("You need to select a character first");
>>>>>>> 5fc18269d2890053d261024ae6369e68f63d6698
  }
}

{tk_L1}{tk_R2}{PLAYER} {
<<<<<<< HEAD
  /* verificar si el jugador ya disparo*/
  if(players[actualPlayer].shot){
    printf("You can't shoot again\n");
  } else {
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
      /* definir que el jugador ya disparo */
      players[actualPlayer].shot = true;
    }else{
      printf("You need to select a character first");
=======
  if(inGame){ 
    printf("Player %d is changing weapon to the left\n", actualPlayer+1);
    if(players[actualPlayer].selectedWeapon == 0){
        players[actualPlayer].selectedWeapon = 2;
    } else {
        players[actualPlayer].selectedWeapon--;
    }
    printf("%s selected\n", weapons[players[actualPlayer].selectedWeapon].name);

    playerAttaked = findPlayerByName(players,number_of_players, modify_yytext3(yytext));
    if(isAngleBetweenMinus15And15(players[actualPlayer].x, players[actualPlayer].y, players[playerAttaked].x, players[playerAttaked].y) == 1){
      players[playerAttaked].health -= weapons[players[actualPlayer].selectedWeapon].damage;
      printf("Atacked player: %s. Remaining health: %d\n", players[playerAttaked].name, players[playerAttaked].health);
    }else{
      printf("The atack failed\n");
>>>>>>> 5fc18269d2890053d261024ae6369e68f63d6698
    }
  }
}

 /* ATAQUES ESPECIALES */

{tk_forward}{tk_back}{tk_forward} { /* freeze */
/* verificar si el jugador ya disparo*/
  if(players[actualPlayer].shot){
    printf("You can't shoot again\n");
  } else {
    if(inGame){
          playerAttaked = findPlayerByName(players,number_of_players, modify_yytext2(yytext));
    printf("Player %s is freezing %s\n", players[actualPlayer].name, players[playerAttaked].name);
    players[playerAttaked].canMove = false;
    }else{
      printf("You need to select a character first");
    }
    /* definir que el jugador ya disparo */
    players[actualPlayer].shot = true;
  }
}
{tk_forward}{tk_left}{tk_left} { /* JUMP */
/* verificar si el jugador ya disparo*/
  if(players[actualPlayer].shot){
    printf("You can't shoot again\n");
  } else {
    if(inGame){
      printf("Player %d is jumping\n", actualPlayer);
    }else{
      printf("You need to select a character first");
    }
    /* definir que el jugador ya disparo */
    players[actualPlayer].shot = true;
  }
}


<<<<<<< HEAD
({tk_right}{tk_left}{tk_back}) { /* MINE */
/* verificar si el jugador ya disparo*/
  if(players[actualPlayer].shot){
    printf("You can't shoot again\n");
  } else {
    if(inGame){
    placeMine();

      printf("Player %s is placing a mine\n", players[actualPlayer].name);
    
    }else{
      printf("You need to select a character first");
    }
    /* definir que el jugador ya disparo */
    players[actualPlayer].shot = true;
=======
{tk_right}{tk_left}{tk_back} { /* MINE */
  if(inGame){
    placeMine();

    printf("Player %s is placing a mine\n", players[actualPlayer].name);
    continueGame();
  }else{
    printf("You need to select a character first");
>>>>>>> 5fc18269d2890053d261024ae6369e68f63d6698
  }
}

{tk_left}{tk_left}{tk_back}{tk_back} { /* BE INVISIBLE */
  /* verificar si el jugador ya disparo*/
  if(players[actualPlayer].shot){
    printf("You can't shoot again\n");
  } else {
    if(inGame){
      printf("Player %d is becoming invisible\n", actualPlayer);
    }else{
      printf("You need to select a character first");
    }
    /* definir que el jugador ya disparo */
    players[actualPlayer].shot = true;
  }
}

 /* TOKEN ERROR */
. {
  printf("Error: %s\n", yytext);
}

%%
int main(int argc, char const *argv[]) {
  printf(" ");
  printf("\n¡WELCOME TO TWISTED METAL!\n");
  
  yyin = fopen(argv[1], "r");
  yylex();
  fclose(yyin);
  
  FILE *archivo = fopen(argv[1], "r");
  if (archivo == NULL) {
  printf("No es posible ejecutar el archivo: %s\n", argv[1]);
  return 1;
  }
}
