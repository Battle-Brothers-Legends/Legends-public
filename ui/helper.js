/*
 *  @Project:		Battle Brothers
 *	@Company:		Overhype Studios
 *
 *	@Copyright:		(c) Overhype Studios | 2013 - 2020
 * 
 *  @Author:		Overhype Studios
 *  @Date:			15.02.2017
 *  @Description:	Global Helper JS Stuff
 */


/*
	Helpers
 */
var Helper = {

	/**
	 * Formats the given number
	 */
	numberWithCommas: function(_number)
	{
		var parts = _number.toString().split(".");
		return parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",") + (parts[1] ? "." + parts[1] : "");
	},

	getRandomInt: function(min, max) 
	{
		min = Math.ceil(min);
		max = Math.floor(max);
		return Math.floor(Math.random() * (max - min + 1)) + min;
	},

	weightedRandom: function(min, max, target, stddev) 
	{

		function normRand() {
			var x1, x2, rad;
		
			do {
				x1 = 2 * Math.random() - 1;
				x2 = 2 * Math.random() - 1;
				rad = x1 * x1 + x2 * x2;
			} while(rad >= 1 || rad == 0);
		
			var c = Math.sqrt(-2 * Math.log(rad) / rad);
		
			return x1 * c;
		}

		var range = [0, 10];
		var takeGauss = (Math.random() < 0.81546);
		if(takeGauss) {
		// perform gaussian sampling (normRand has mean 0), resample if outside range
		while(1) {
			var sample = ((normRand()*stddev) + target);
			if(sample >= min && sample <= max) 
			{
				return Math.round(sample);
			}
		}
		} else {
		// perform flat sampling
		return Math.round(min+(Math.random()*(max-min)));
		}
		//return Math.round(max / (Math.random() * max + min));
	},

	/**
     * Returns the order of helmet upgrades according to priority.push
     */
    getLayerUpgradeDrawOrder: function(_upgrades, _imagePaths, _slot, _showInInventory) {
	if (!_upgrades) return [];

	// Items with a glow or blocking sneak in the base into imagepaths, so check if there's one and add it later before everything else for upgrade drawing purposes
    var hasBaseLayer = 0;
    var activeUpgradesCount = 0;
	var blockedUpgradesCount = 0;
    for (var u = 0; u < _upgrades.length; u++) {
        if (_upgrades[u] && _upgrades[u] !== -1) {
            activeUpgradesCount++;
        }
		else if(_upgrades[u] === -1){
			blockedUpgradesCount++;
		}
    }
    if (_imagePaths && _imagePaths.length > activeUpgradesCount) {
        hasBaseLayer = 1;
    }

	var layers = [];
	var currentImageIndex = hasBaseLayer;

	function addLayer(slotIndex, pNormal, pLower) {
		var state = _upgrades[slotIndex];
		if (!state) return;

		var p = pNormal;
		if (state === 3 && pLower !== undefined) {
			p = pLower;
		}

		layers.push({
			index:  currentImageIndex,
			p: p,
			visible: (state !== 2 && state !== -1)
		});

		currentImageIndex++;
	}

	var frontBackShoulders = [ // add front-back upgrades here to draw them over cloaks in the inventory
		"legend_armor/inventory_pauldrons_shoulderplates_heraldic",
		"legend_armor/inventory_pauldrons_barbarian_horn",
		"legend_armor/inventory_pauldrons_padding_fur"
	];

	var hasFrontBackShoulders = _imagePaths.some(function(imagepath){
		return frontBackShoulders.some(function(item) { return imagepath.indexOf(item) === 0; });
	})

	if(_slot === "head"){
		addLayer(0, 4, 2); // helm   
		addLayer(1, 5, 3); // top
		addLayer(2, 6, 0); // vanity1
		addLayer(3, 7, 1); // vanity2
		addLayer(4, 8);    // runes
	}
	else if(_slot === "body")
	{
		addLayer(0, 0); // chain   
		addLayer(1, 1); // plate
		addLayer(2, 2); // tabard
		if (hasFrontBackShoulders)	{
			addLayer(3, 3); // cloak
			addLayer(4, 4); // upgrade
		}
		else {
			addLayer(3, 4); // cloak
			addLayer(4, 3); // upgrade
		}
		addLayer(5, 5); // runes
	}

	layers.sort(function (a, b) { return a.p - b.p; });
	var order = [];
	if(hasBaseLayer) order.push(0);

	for (var i = 0; i < layers.length; i++) { 
		if (layers[i].visible || _showInInventory) {
            order.push(layers[i].index-blockedUpgradesCount);
        }
	}
	return order;
	}
};

