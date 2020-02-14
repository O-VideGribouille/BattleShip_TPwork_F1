program test_battleship_V1;

uses crt;

CONST LMAX=10;
      HMAX=10; // Remplacer CMAX par HMAX
   	  TMAXbat=5;
   	  NBBAT=5;


TYPE tab:ARRAY[0..LMAX,0..HMAX] OF tabElement;
	 tabNav:ARRAY[1..NBBAT] OF INTEGER;
	 tabElement=0..5;
	 tabCoord=ARRAY[1..TMAXbat] OF INTEGER;

VAR 
	//nom:STRING;
    x,y,i,j:INTEGER;
  //  coule:BOOLEAN;


// remplacer dansmat:= danstab, zeronmat:= zerotab
 //   isOpponentDown : boolean;
    c:CHAR;

function nom(nb:integer):STRING;// Differents navires
begin
	CASE nb OF
	1:nom:='Torpilleur';
	2:nom:='Sous-Marin';
	3:nom:='Contre-Torpilleur';
	4:nom:='Croiseur';
	5:nom:='Porte-Avions';
	end;
end;

function tailleNav(nomNav:STRING; nb:INTEGER):INTEGER;
begin
	IF nomNav ... THEN 
	CASE nb OF
	1:taille:=2;
	2:taille:=2;
	3:taille:=3;
	4:taille:=4;
	5:taille:=5;
	end;
	end;
end;

PROCEDURE Initnav(VAR N:tabNav); // Initialisation des navires
VAR i:INTEGER;

begin
	FOR i:=1 TO NBBAT DO
		begin
		coule(N[i]):=false; 
		nom(N[i]):=nom(i);
		IF(i<3) THEN taille(N[i]):=i+1
		ELSE taille(N[i]):=i;
		end;

end;

/// Fnction de convertion ///

function convEntier(car:CHAR):INTEGER; // permet de convertir les chiffres (caractères) en entiers (ex:'1'->1), grace à ord (aide sur forum)
begin
IF(ord(car)>=48)
	AND (ord(car)<=57)
		THEN convEntier:=ord(car)-48
ELSE convEntier:=11;
end;

function convcara1(car:CHAR):INTEGER;// permet de convertir "a" en "1" et ce jusqu'au caractère correspondant à LMAX
begin
IF(ord(car)>=97)
	AND (ord(car)<97+LMAX)
		THEN convcara1:=ord(car)-96
ELSE convcara1:=0;
end;

function convcar1a(car:INTEGER):CHAR;// permet de convertir "1" en "a" et ce jusqu'à LMAX
begin
IF(car>=1)
	AND (car<=LMAX)
		THEN convcar1a:=chr(car+96)
ELSE convcar1a:='£';
end;


/// test placement et tirs navires ///

function existe(x,y:INTEGER):BOOLEAN; //verifie si les coordonnees entrees existent
VAR test:BOOLEAN;
begin
IF 	(((x>=1) AND (x<=HMAX))
AND
	((y<=LMAX) AND (y>=1)))
				THEN test:=true
ELSE test:=false;
existe:=test;
end;

//function touche (N:tabNav;nb:INTEGER):BOOLEAN;

//function coule(m:tab;N:tabNav):BOOLEAN;

//function enligne (B:tailleNav):BOOLEAN;

//function danstab (B:tailleNav) : BOOLEAN;

function voisin(x1,y1,x2,y2:INTEGER):BOOLEAN; //vérifie si le point 2 est voisin du point 1 (sans les diagonales)
var i,j:INTEGER;
	test:BOOLEAN;
begin
test:=false;
FOR i:=y1-1 TO y1+1 DO
	FOR j:=x1-1 TO x1+1 DO
		IF(existe(j,i))	AND ((x2=j) AND (y2=i))
				AND ((x1<>x2) OR (y1<>y2))
					AND ((x1=j) OR (y1=i)) THEN test:=true;
voisin:=test;
end;

function recouvrement(N:tabNav;nb:INTEGER):BOOLEAN;// permet de vérifier que deux bateaux ne se recouvrent pas
var i,j,k,l:INTEGER;
	test:BOOLEAN;
begin
test:=false;
IF(nb<>1) THEN
	begin
	FOR i:=1 TO nb DO
		FOR j:=1 TO nb DO
			FOR k:=1 TO tailleNav(N[i]) DO
				FOR l:=1 TO tailleNav(N[i]) DO
					IF(i<>j) THEN test:=true;
	end;
recouvrement:=test;
end;


/// Fonctions et procedures autres ///

procedure zerotab(var m:tab);// initialise à zéro la grille
var i,j:integer;
begin
FOR i:=1 TO LMAX DO
    FOR j:=1 TO HMAX DO
        m[i,j]:=0;
end;


procedure loss(N:tabNav;var test:BOOLEAN);// verifie si le joueur a perdu
var i:integer;
begin
test:=true;
FOR i:=1 TO NBBAT DO
	IF(coule(N[i])<>true) THEN test:=false;
end;

PROCEDURE Saisiecoord(VAR x:INTEGER;y:INTEGER); //saisi des coordonnées
VAR coord:STRING;

Begin
        REPEAT
		WRITEln ('Entré les coordonnées (exemple: 7A, 2J, etc) : ');
		READln (x,y);
		y:=convcara1(coord[1]);
		IF(length(coord)=2) THEN
			 x:=convEntier(coord[2])
		ELSE
			 IF(length(coord)=3) AND (convEntier(coord[3])<>11) AND (convEntier(coord[2])<>11) THEN
			 	 x:=convEntier(coord[2])*10+convEntier(coord[3])
			 ELSE x:=11;

	    UNTIL (y<>0) AND (x<>11) AND (LENGTH(coord)<=3);
end;

///Forme generale du programme ///

PROCEDURE Affgrille(m1:tab,m2:tab;nb1:INTEGER;nb2:INTEGER); // Affichage de la grile de jeu
VAR i,j:INTEGER;
	c:CHAR;

//joueur 1

begin

	IF(nb1=1) THEN

	WRITEln;

    WRITEln('   | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 |');

    WRITEln('--------------------------------------------');

    for c := 'A' to 'J' do

    begin

		WRITE(' ', c, ' ');

		for i := 0 to 9 do

			WRITE('| ',' ',' ');

			WRITEln('|');

			WRITEln('--------------------------------------------');
    end;

    FOR j:=1 TO HMAX DO

				CASE m2[i,j] OF
					0:	begin
						write('   ');
						end;
					1:	begin
						write('   ');
						end;
					2:	begin
						textbackground(white);
						write('   ');
						textbackground(black);
						end;
					3:	begin
						textbackground(red);
						write('   ');
						textbackground(black);
						end;
			end;
		end;	
			textbackground(black);
		end;

    WRITEln;

end;

//Joueur 2
	
	IF(nb2=1) THEN

	WRITEln;

    WRITEln('   | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 |');

    WRITEln('--------------------------------------------');

    for c := 'A' to 'J' do

    begin

		WRITE(' ', c, ' ');

		for i := 0 to 9 do

			WRITE('| ',' ',' ');

			WRITEln('|');

			WRITEln('--------------------------------------------');
    end;

    FOR j:=1 TO HMAX DO

				CASE m2[i,j] OF
					0:	begin
						write('   ');
						end;
					1:	begin
						write('   ');
						end;
					2:	begin
						textbackground(white);
						write('   ');
						textbackground(black);
						end;
					3:	begin
						textbackground(red);
						write('   ');
						textbackground(black);
						end;
			end;
		end;	
			textbackground(black);
		end;

    WRITEln;

end;

(*

procedure affichtab(N:tabNav;nb:INTEGER); //procédure de débogage qui affiche les coordonnées des bateaux
var i,k:INTEGER;
begin
for k:=0 to nb do
	begin
	if(k=0) then 
		for i:=0 to nb do
			begin
			if(i=0) then write(' ')
			else write(' ',i,' ');
			end;
	if(k<>0) then
		for i:=0 to tailleNAV(N[k]) do
			if(i<>0) then write(convcar1a(y(N[k])[i]),x(N[k])[i],' ')
			else write('  ');
	writeln;
	end;
writeln;
end;

procedure prolongement(var B:tailleNav); //prolonge les bateaux jusqu'à leur taille maximale
var i:INTEGER;
begin
for i:=3 to B do
	begin

*)
procedure initbat(var N:tabNav;x:INTEGER;y:INTEGER); // initialise une flotte
var i:INTEGER;
    ok:STRING;
	a,b:tab;
begin
zerotab(b);zerotab(a);
Affgrille(a,b,0,1);
InitNav(N);
i:=1;
	repeat //Nombre de bateaux
		repeat //Placement souhaité 
			repeat //Placement des bateaux (recouvrements)
			Saisiecoord(x(N[i])[1],y(N[i])[1]);
			Saisiecoord(x(N[i])[2],y(N[i])[2]);
			prolongement(N[i]);
			affichage(a,b,0,1);
			until ((recouvrement(N,i)=false) 
					and (danstab(N[i]));
end;

procedure restir(x,y:INTEGER;var N:tabNav;var m:tab;var mot:STRING; var ok,fait:BOOLEAN); //Rend le résultat du tir
var i,j:INTEGER;
begin
IF((m[y,x]=2) OR (m[y,x]=3)) AND (fait=false) THEN
			begin
			ok:=false;
			fait:=true;
			end
ELSE 
		IF(m[y,x]=0) AND (fait=false) THEN
			begin
			mot:='Rate';
			m[y,x]:=2;
			end;
FOR i:=1 TO NBBAT DO
	FOR j:=1 TO tailleNav(N[i]) DO
		IF(ok=false) THEN writeln('Vous avez dejà tire sur cette case');
		end;
	end;
end;

procedure tir(var N:tabNav;var m:tab;var mot:STRING);// Effectue complètement l'action de tir
var y,x:INTEGER;
	ok,fait:BOOLEAN;
begin
	REPEAT
	ok:=true;fait:=false;
	writeln('Ou voulez-vous tirer ?');
	Saisiecoord(x,y);
	restir(x,y,N,m,mot,ok,fait);
	UNTIL(ok=true);
end;





VAR      i1,i2:tabNav;
         m1,m2,bdd:tab;
		gg1,gg2:boolean;
		i,nb:INTEGER;
		gagnant,perdant,nom1,nom2,res,secret,mode,continuer:STRING;


BEGIN

	gg1:=false;gg2:=false;nb:=0;zerotab(m1);zerotab(m2);
		nom1:=('J1')
		nom2:=('J2')
			REPEAT
		writeln('Placez vos bateaux ',nom1);
		clrscr;

			REPEAT
		writeln('Placez vos bateaux ', nom2);
		clrscr;
			REPEAT
			loss(i1,gg1);loss(i2,gg2); //On teste si l'un des joueurs a gagne
			IF(nb MOD 2=0) AND (gg1=false) AND (gg2=false) THEN //Joueur 1
				begin
				clrscr;
				writeln('C''est au tour de ', nom1,' :');
				readln;
				Affgrille(m1,m2,1,0);
				writeln('Attaquer');tir(i2,m2,res);writeln(res);
				readln;
				end;
			loss(i1,gg1);loss(i2,gg2); //On teste si l'un des joueurs a gagne
			IF(nb MOD 2<>0) AND (gg2=false) AND (gg1=false) THEN //Joueur 2
				begin
				clrscr;
				writeln('C''est au tour de ', nom2,' :');
				readln;
				Affgrille(m2,m1,1,0);
				writeln('Attaquer');tir(i1,m1,res);writeln(res);
				readln;
				end;
			nb:=nb+1;
			UNTIL (gg1=true) OR (gg2=true);
		FOR i:=1 TO NBBAT DO
			begin
			IF // THEN
(*				begin
				gagnant:=nom1;
				perdant:=nom2;
				end;
			ELSE
				begin
				gagnant:=nom2;
				perdant:=nom1;
				end;
			end;
		end;
		

	writeln('Gagnant : ',gagnant,' Perdant : ',perdant); *)

END.




BEGIN
		clrscr;
		Saisiecoord;
		Affgrille;



        Readln;

END.
