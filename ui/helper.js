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
	}
};

