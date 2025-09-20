FU.Key = {
	sortKeyString : function( _key )
	{
		var key = '';
		var keyArray = _key.split('+');
		var mainKey = keyArray.pop();
		if (keyArray.length > 0)
		{
			keyArray.sort();
			key = keyArray.reduce(function(a, b) {return a + '+' + b;}) + '+';
		}
		key += mainKey;
		return key;
	},
	capitalizeKeyString : function( _keyString )
	{
		_keyString = FU.capitalizeFirst(_keyString);
		return _keyString.split('+').reduce(function(a, b) {return a + "+" + FU.capitalizeFirst(b);}).split('/').reduce(function(a, b) {return a + "/" + FU.capitalizeFirst(b);});
	},
	sortKeyCombinationString : function( _keyCombinations )
	{
		return _keyCombinations.split('/').map(FU.Key.sortKeyString).reduce(function(a, b) {return a + '/' + b;});
	},
	MouseMapJS : {
		0 : "leftclick",
		// 1 : "middleclick", these are not handled properly by JS
		2 : "rightclick"
		// 3 : "sidebackward",
		// 4 : "sideforward"
	},
	KeyMapJS : {
		8 :"backspace",
		9 :"tab",
		13 :"return",
		16 :"shift",
		17 :"ctrl",
		18 :"alt",
		19 :"pause",
		20 :"capslock",
		27 :"escape",
		32 :"space",
		33 :"pageup",
		34 :"pagedown",
		35 :"end",
		36 :"home",
		37 :"left",
		38 :"up",
		39 :"right",
		40 :"down",
		45 :"insert",
		46 :"delete",
		48 :"0",
		49 :"1",
		50 :"2",
		51 :"3",
		52 :"4",
		53 :"5",
		54 :"6",
		55 :"7",
		56 :"8",
		57 :"9",
		65 :"a",
		66 :"b",
		67 :"c",
		68 :"d",
		69 :"e",
		70 :"f",
		71 :"g",
		72 :"h",
		73 :"i",
		74 :"j",
		75 :"k",
		76 :"l",
		77 :"m",
		78 :"n",
		79 :"o",
		80 :"p",
		81 :"q",
		82 :"r",
		83 :"s",
		84 :"t",
		85 :"u",
		86 :"v",
		87 :"w",
		88 :"x",
		89 :"y",
		90 :"z",
		91 :"leftwindowkey",
		92 :"rightwindowkey",
		93 :"selectkey",
		96 :"n0",
		97 :"n1",
		98 :"n2",
		99 :"n3",
		100 :"n4",
		101 :"n5",
		102 :"n6",
		103 :"n7",
		104 :"n8",
		105 :"n9" ,
		106 :"*" ,
		107 :"+",
		112 :"f1",
		113 :"f2",
		114 :"f3",
		115 :"f4",
		116 :"f5",
		117 :"f6",
		118 :"f7",
		119 :"f8",
		120 :"f9",
		121 :"f10",
		122 :"f11",
		123 :"f12",
		124 :"f13",
		125 :"f14",
		126 :"f15",
		127 :"f16",
		128 :"f17",
		129 :"f18",
		130 :"f19",
		131 :"f20",
		132 :"f21",
		133 :"f22",
		134 :"f23",
		135 :"f24",
		144 :"numlock",
		145 :"scrolllock",
		186 :"semicolon",
		187 :"equalsign",
		188 :"comma",
		189 :"dash",
		190 :"dot",
		191 :"forwardslash",
		192 :"graveaccent",
		219 :"openbracket",
		220 :"backslash",
		221 :"closebracket",
		222 :"singlequote"
	}
};
