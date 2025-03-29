::mods_hookExactClass("items/misc/kraken_horn_plate_item", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "Taken from the head of the legendary kraken, this large and hard horn plate is a trophy few in this world can claim.";
	}
});
