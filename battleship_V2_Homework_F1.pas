program test_battleship_V2;

uses crt;

CONST   LMAX=10; 
		HMAX=10; 
        TMAXbat=5; 
		NBBAT=5; 


TYPE	tab:ARRAY[0..LMAX,0..HMAX] OF tabElement;
	 tabNav:ARRAY[1..NBBAT] OF tabBat;
	 tabElement=0..5;
	 tabCoord=ARRAY[1..TMAXbat] OF INTEGER;
	 tabBat=	RECORD //Type des bateaux
			nom:STRING; //Stocke le nom du bateau
			coule:BOOLEAN; //Stocke si le bateau est coule ou non
			taille:INTEGER; //Stocke la taille du bateau
			x,y:tabCoord;
			end;
function nom(nb:INTEGER):STRING;// lie un nom à une "touche"
begin
	CASE nb OF
	1:nom:='Torpilleur';
	2:nom:='Sous-Marin';
	3:nom:='Contre-Torpilleur';
	4:nom:='Croiseur';
	5:nom:='Porte-Avions';
	end;
end;

procedure InitNav(VAR N:tabNav); //initialisation des navires
VAR i:INTEGER;
begin
FOR i:=1 TO NBBAT DO
	begin
	N[i].coule:=false; // retour à l'enregistrement et y prend les données
	N[i].nom:=nom(i);
	IF(i<3) THEN N[i].taille:=i+1
	ELSE N[i].taille:=i;
	end;
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

function danstab(B:tabBat):BOOLEAN; //verifie si le bateau est dans la matrice
VAR test:BOOLEAN;
	i:INTEGER;
begin
test:=true;
FOR i:=1 TO B.taille DO
	IF NOT (existe(B.x[i],B.y[i])) THEN test:=false;
danstab:=test;
end;

function voisin(x1,y1,x2,y2:INTEGER):BOOLEAN; //verifie si le point 2 est voisin du point 1 (sans les diagonales)
VAR i,j:INTEGER;
	test:BOOLEAN;
begin
test:=false;
FOR i:=y1-1 TO y1+1 DO
	FOR j:=x1-1 TO x1+1 DO
		IF(existe(j,i))	
			AND ((x2=j) AND (y2=i))
				AND ((x1<>x2) OR (y1<>y2))
					AND ((x1=j) OR (y1=i)) THEN test:=true;
voisin:=test;
end;
(*
function coule(m:tab;N:tabNav;nb:INTEGER):BOOLEAN; //verifie si le bateau est coulé
VAR k:INTEGER;
	test:BOOLEAN;
begin
test:=true;
FOR k:=1 TO N[nb].taille DO
	IF(m[N[nb].y[k],N[nb].x[k]]<>3) THEN test:=false;
coule:=test;
end;
*)

/// Fonctions et procedures autres ///

procedure zerotab(VAR m:tab);// initialise à zero la grille
VAR i,j:INTEGER;
begin
FOR i:=1 TO LMAX DO
    FOR j:=1 TO HMAX DO
        m[i,j]:=0;
end;

function debut(N:tabNav;nb:INTEGER):tab;// transforme le tableau contenant les bateaux en matrice contenant ces derniers.
VAR i,j:INTEGER;
	m:tab;
begin
zerotab(m);
debut:=m;
FOR i:=1 TO nb DO
	FOR j:=1 TO N[i].taille DO
                debut[N[i].y[j],N[i].x[j]]:=1;
end;


procedure loss(N:tabNav;VAR test:BOOLEAN);// verifie si le joueur a perdu
VAR i:INTEGER;
begin
test:=true;
FOR i:=1 TO NBBAT DO
	IF(N[i].coule<>true) THEN test:=false;
end;

procedure SaisieCoord(VAR x,y:INTEGER);// saisie des coordonnees
VAR coord:STRING;
begin
	REPEAT
        begin
		writeln('Entré les coordonnées (exemple: 7A, 2J, etc) : ');
		readln(coord);
        end;
	UNTIL (y<>0) and (x<>11) and (length(coord)<=3);
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

procedure prolongement(VAR B:tabBat); //prolonge les bateaux jusqu'a leur taille maximale
VAR i:INTEGER;
begin
FOR i:=3 TO B.taille DO
	begin
	IF(B.x[2]=B.x[1]+1) THEN //horizontal (+1)
		begin
		B.x[i]:=B.x[i-1]+1;
		B.y[i]:=B.y[i-1];
		end
	ELSE
		IF(B.x[2]=B.x[1]-1) THEN //horizontal (-1)
			begin
			B.x[i]:=B.x[i-1]-1;
			B.y[i]:=B.y[i-1];
			end;
		ELSE //vertical
			begin
			B.x[i]:=B.x[i-1];
			IF(B.y[2]=B.y[1]+1) THEN B.y[i]:=B.y[i-1]+1 //(+1)
			ELSE
				IF(B.y[2]=B.y[1]-1) THEN B.y[i]:=B.y[i-1]-1;//(-1)
			end;
		end;
	end;


procedure InitBat(VAR N:tabNav); // initialise une flotte
VAR i:INTEGER;
    ok:STRING;
	a,b:tab;
begin
zerotab(b);zerotab(a);
Affgrille(a,b,0,1);
InitNav(N);
i:=1;
	REPEAT //Boucle sur le nombre de bateaux
		REPEAT //Boucle sur le placement souhaite de l'utilisateur
			REPEAT //Boucle sur le placement des bateaux (recouvrements)
			SaisieCoord(N[i].x[1],N[i].y[1]);
			SaisieCoord(N[i].x[2],N[i].y[2]);
			prolongement(N[i]);
			a:=debut(N,i);
			Affgrille(a,b,0,1);
			UNTIL (danstab(N[i]))
	i:=i+1;
	UNTIL (i=NBBAT+1);
end;

procedure restir(x,y:INTEGER;VAR N:tabNav;VAR m:tab;VAR mot:STRING;VAR ok,fait:BOOLEAN); //Rend le resultat du tir
VAR i,j:INTEGER;
begin
IF((m[y,x]=2) OR (m[y,x]=3)) AND (fait=false)THEN
			begin
			ok:=false;
			fait:=true;
			end;
ELSE IF(m[y,x]=0) AND (fait=false) THEN
			begin
			mot:='Rate';
			m[y,x]:=2;
			end;
FOR i:=1 TO NBBAT DO
	FOR j:=1 TO N[i].taille DO
		IF(N[i].y[j]=y) AND (N[i].x[j]=x) AND (m[y,x]=1) THEN
				begin
				m[y,x]:=3;
				IF(coule(m,N,i)) THEN mot:='Coule'
				ELSE mot:='Touche';
				N[i].coule:=coule(m,N,i);
				end;
IF(ok=false) THEN writeln('Vous avez dejà tire sur cette case.');
end;

procedure tir(VAR N:tabNav;VAR m:tab;VAR mot:STRING);// Permet d'effectuer completement l'action de tir et rend le resultat dans t_nav,t_mat et un string
VAR y,x:INTEGER;
	ok,fait:BOOLEAN;
begin
	REPEAT
	ok:=true;fait:=false;
	writeln('Ou voulez-vous tirer ?');
	SaisieCoord(x,y);
	restir(x,y,N,m,mot,ok,fait);
	UNTIL(ok=true);
end;

VAR      i1,i2:tabNav;
         m1,m2,bdd:tab;
		gg1,gg2:BOOLEAN;
		i,nb:INTEGER;
		gagnant,perdant,nom1,nom2,res,secret,mode,continuer:STRING;


BEGIN

	gg1:=false;gg2:=false;nb:=0;zerotab(m1);zerotab(m2);
		nom1:=('J1')
		nom2:=('J2')
			REPEAT
		writeln('Placez vos bateaux ',nom1);
		InitBat(i1);m1:=debut(i1,NBBAT);
		clrscr;

			REPEAT
		writeln('Placez vos bateaux ', nom2);
		InitBat(i2);m2:=debut(i2,NBBAT);
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
			IF(i1[i].coule=false) THEN
				begin
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
		

	writeln('Gagnant : ',gagnant,' Perdant : ',perdant);

END.