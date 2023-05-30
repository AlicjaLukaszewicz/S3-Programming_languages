Object subclass: #Wielokat
	instanceVariableNames: 'wierzcholki nazwa '
	classVariableNames: ''
	poolDictionaries: ''
	category: 'JezykiProgramowania'!

!Wielokat methodsFor: 'initialize-release'!

initialize: liczbaWierzcholkow name: nowaNazwa
	"konstruktor obiektu - wielokata"

	nazwa:=nowaNazwa.
	wierzcholki:=Array new: liczbaWierzcholkow.
	wierzcholki at: 1 put: 0@0.! !

!Wielokat methodsFor: 'accessing'!

wierzcholki
	^wierzcholki!

nazwa
	"podaje nazwe wielokata"

	^nazwa!

nazwa: nowa_nazwa
	"ustawia nowa nazwe wielokata"

	nazwa:=nowa_nazwa! !

!Wielokat methodsFor: 'actions'!

drukuj
    "Drukuje informacje o rombie"

    Transcript show: 'Dana jest figura: '.
    Transcript show: nazwa printString.
    Transcript cr.
    Transcript show: 'Pole: '.
    Transcript show: self pole printString.
    Transcript cr.
    Transcript show: 'Wierzcholki: '.
    Transcript cr.
    1 to: wierzcholki size do: [:i |
        Transcript show: (self wierzcholki at: i) printString.
        Transcript cr.].
    Transcript cr.!!

"WIELOKĄT - KWADRAT"

Wielokat subclass: #Kwadrat
	instanceVariableNames: 'bok'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'JezykiProgramowania'!

!Kwadrat methodsFor: 'accessing'!

bok
	^bok!!

!Kwadrat methodsFor: 'arithmetic'!

+ figura
	"dodaj 2 figury w sensie pola"

	| p |

	p:=self pole + figura pole.
	^(Kwadrat new) initialize: p sqrt!

wysrodkuj
    "wyśrodkuj kwadrat"

    | x y |
    x := (wierzcholki at: 1) x.
    y := (wierzcholki at: 1) y.

    (x = 0 & y = 0) ifTrue: [
        1 to: wierzcholki size do: [:i |
	        x := (wierzcholki at: i) x.
	        y := (wierzcholki at: i) y.
	        wierzcholki at: i put: (x-(bok/2.0))@(y - (bok/2.0)).].].
	! !

!Kwadrat methodsFor: 'actions'!

pole
	"licz pole kwadratu"

	^(bok) squared!

!Kwadrat methodsFor: 'initialize-release'!

initialize: nowyBok
	"tworz kwadrat o podanym boku"
	bok:=nowyBok.

	super initialize: 4 name: 'Kwadrat'.
	wierzcholki at: 2 put: bok@0.
	wierzcholki at: 3 put: bok@bok.
	wierzcholki at: 4 put: 0@bok.! !

"WIELOKĄT - ROMB"

Wielokat subclass: #Romb
	instanceVariableNames: 'bok kat '
	classVariableNames: ''
	poolDictionaries: ''
	category: 'JezykiProgramowania'!

!Romb methodsFor: 'accessing'!

kat
	^(kat degreesToRadians)!!

!Romb methodsFor: 'arithmetic'!

+ figura
	"dodaj 2 figury w sensie pola"
    | p a |
	p := self pole + figura pole.
	a := (self kat sin).
	^(Romb new) initialize: ((p/a) sqrt) kat: self kat!

!Romb methodsFor: 'actions'!

pole
	"licz pole rombu"

	| k |
	k:=kat degreesToRadians.
	^((bok squared) * k sin)!

wysrodkuj
    "wyśrodkuj romb"

    | p x y |
    p:=(bok*((2+(2*(kat cos))) sqrt)).
    x:=(wierzcholki at: 1) x.
    y:=(wierzcholki at: 1) y.

    (x = 0 & y = 0) ifTrue: [
        1 to: wierzcholki size do: [:i |
	        x := (wierzcholki at: i) x.
	        y := (wierzcholki at: i) y.
	        wierzcholki at: i put: (x-(p/2.0))@(y).].].
	 ! !

!Romb methodsFor: 'initialize-release'!

initialize: nowyBok kat: nowyKat
	"tworz romb o podanym boku i kącie"
    | p d |

    bok:=nowyBok.
    kat:=nowyKat.

    p:=(bok*((2+(2*(kat cos))) sqrt)).
    d:=(bok*((2-(2*(kat cos))) sqrt)).
	super initialize: 4 name: 'Romb'.
	wierzcholki at: 2 put: (p/2)@(d/2).
	wierzcholki at: 3 put: p@0.
	wierzcholki at: 4 put: (p/2)@((d/2) negated).! !

"Kompilator: JDoodle"

"TESTY"

k := (Kwadrat new) initialize:2.
r := (Romb new) initialize: 2
                kat: 60.
Transcript show: 'Dane sa wielokaty:'; cr.
r drukuj.
k drukuj.
Transcript cr; show: 'r+k'.Transcript cr.
r2 :=  r + k.
r2 drukuj.
Transcript cr; show: 'k+r'.Transcript cr.
k1 := k + r.
k1 drukuj.
k3 := k wysrodkuj.
k3 drukuj.
r4 := r wysrodkuj.
r4 drukuj.
