/*
	NOTES

	The armour debug mod iterates through the item variants in order. Relevant ones are below
	Gambeson - 
		1 plain, 
		2 black, 
		3 black-v, 
		4 blue, 
		5 green+gold stripe, 
		6 red+blue halves, 
		7 red, 
		8 white+blue, 
		9 white, 
		10 green shoulder+white, 
		11 gold, 
		12 blue/green/gold sash, 
		13 gold/red halves
		14 white buckled
		15 olive
		16 lavendar?
		17 magenta?
		18 full red
		19 red white stripe
		20 red white checked
		21 red sleeve
		22 red sleeve 2
		23 red quarter
		24 green white stripe
		25 green white checked
		26 green sleeve
		27 green sleeve 2
		28 green quarter
		29 full green
		30 blue white stripe
		31 blue white checked
		32 blue sleeve
		33 blue sleeve 2
		34 full blue
		35 full black
		36 black stripe
		37 black check
		38 black sleeve
		39 black sleeve 2
		40 black quarter
	Surcoat  - 
		1 plain, 
		2 red, 
		3 red under white, 
		4 red over white, 
		5 red white check, 
		6 red white X 
		7 red white slices, 
		8 green, 
		9 green under white, 
		10green over white, 
		11green white check, 
		12green white X 
		13green white slices,
		14blue, 
		15blue under white, 
		16blue over white, 
		17blue white check, 
		18blue white X 
		19blue white slices,
		20blue, 
		21blue under white, 
		22blue over white, 
		23blue white check, 
		24blue white X 
		25blue white slices,
		26-31 - various browns
	Sellsword coat -
		1 plain - brownish, 
		2 yellow, 
		3 lighter green, 
		4 mid green, 
		5 dark green, 
		6 greeny blue 
		7 blue, 
		8 grey, 
		9 black
	Nasal/Norman Helm - 
		1 plain, 
		2 Blue stripe, 
		3 green, 
		4 red+yellow stripe, 
		5 red
	Flat Top helms (all tiers except faceplate) -
		1 plain, 
		2 Blue white, 
		3 green white, 
		4 red+yellow, 
		5 black
		6 red
	Flat Top helms w/faceplate - WHHHY!?!?
		1 Blue white, 
		2 green white, 
		3 red+yellow, 
		4 black
		5 red
		6 plain, 
	Nordic helms 
		1 plain 
		2 balck 
		3 red
		4 red + yellow
		5 blue white
		6 green gold,
	Conic helms
		1 plain 
		2 red yellow 
		3 blue white
		4 green white
		5 red
		6 black
	Kettle Helms
		1 plain
		2 blue white
		3 green gold
		4 red gold
		5 black
		6 red
	Zwei Hats
		1 red blue
		2 red black, 
		3 white black
		4 red gold
		5 white green
		6 white blue
		7 blue gold, 
		8 white black 2
		9 blue white gold
		10green gold 
	Noble House Decorations
		1-3 Kettle
			1 red blue - castle
				helm 6 - red kettle helm, 
				face 2 - blue
			2 red black - lady
				helm 6 - red kettle helms, 
				face 5 - black face
			3 white black - horns
				helm 5 - black kettle helm, 
				face 5 black face
		4-6 flat top
			4 red gold - lion
				helm 4 - red gold flat top, 
				face 4 - red gold face
			5 white green - feather
				helm 3 flat top, 
				face 3 greeen face
			6 white blue - swan
				helm 2 blue white flat top
				face 2 blue face
		7-10 nasal/nordic
			7 black gold - fish
				helm 1 - plain nasal
				elite - helm 2 - black nordic
				face 5 black mask
			8 white black - antlers
				helm 1 - plain nasal
				elite - helm 2 - black nordic
				face 5 black mask
			9 blue white gold - sun
				helm 2 - blue white nasal
				elite helm 5 - blue white nordic
				mask 2 - blue
			10green gold - dragon
				helm 3 - green nasal
				elite helm 6 - green gold nordic
				mask 1 - plain

*/

::Const.FacColors <- {

    BasicHelm = 
    [
        1, // plain helm - index 0
        6, // red kettle
        6, // red kettle
        5, // black kettle
        4, // red gold flat
        3, // green flat top
        2, // blue white flat top
        1, // plain nasal
        1, // plain nasal
        2, // blue white nasal
        3  // green nasal
    ]
    EliteHelm =
    [
        1, // plain helm - index 0
        6, // red kettle
        6, // red kettle
        5, // black kettle
        4, // red gold flat
        3, // green flat top
        2, // blue white flat top
        2, // black nordic
        2, // black nordic
        5, // blue white nordic
        6  // green gold nordic
    ]
    EliteSallet =
    [
        1, // plain helm - index 0
        6, // red 
        6, // red 
        2, // black 
        3, // red gold 
        4, // green  
        5, // blue white flat top
        2, // black 
        2, // black 
        5, // blue white
        4  // green gold
    ]
    EliteMask =
    [
        1, // plain - index 0
        2, // blue
        5, // black
        5, // black
        4, // red gold
        3, // green
        2, // blue
        5, // black
        5, // black
        2, // blue
        1  // plain
    ]
    NordicHelm = 
    [
        1,
        1, // plain
        2, // dark grey
        2, // dark grey
        1, // plain
        1, // plain
        5, // blue
        6, // green yellow
        2, // dark grey/blk
        4, // yellow red
        6 // green yellow
    ]
    VikingHelm =
    [
        1,
        1,
        2,
        2,
        4,
        1,
        5,
        6,
        2,
        4,
        6
    ],
    // Nasal/Norman Helm - 
	// 	1 plain, 
	// 	2 Blue stripe, 
	// 	3 green, 
	// 	4 red+yellow stripe, 
	// 	5 red
    NormanHelm = 
    [
        1, 
        1,
        1,
        1,
        5,
        3,
        2,
        1,
        1,
        4,
        1
    ]
};