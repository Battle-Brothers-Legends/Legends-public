::mods_hookExactClass("contracts/contracts/conquer_holy_site_contract", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DescriptionTemplates = [
			"A Holy Site has been conquered by southern heathens. Honor and fear of the Old Gods demands that it be retaken.",
			"Purify a holy site in a way most pleasing to the Old Gods... with blood.",
			"Glory, renown and much coin awaits in the recapture of a most sacred site.",
			"The faith demands the recapture of a revered holy site. You demand coin.",
		];
	}

	local spawnAlly = o.spawnAlly;
	o.spawnAlly = function () {
		local f = this.World.FactionManager.getFaction(this.getFaction());
		local party = spawnAlly();
		party.getLoot().Money = this.Math.rand(100, 300);
		party.getLoot().ArmorParts = this.Math.rand(10, 35);
		party.getLoot().Medicine = this.Math.rand(5, 15);
		party.getLoot().Ammo = this.Math.rand(10, 40);
		return party;
	}

	local spawnEnemy = o.spawnEnemy;
	o.spawnEnemy = function () {
		local f = this.World.FactionManager.getFaction(this.m.Flags.get("EnemyID"));
		local party = spawnEnemy();
		party.getLoot().Money = this.Math.rand(100, 300);
		party.getLoot().ArmorParts = this.Math.rand(10, 35);
		party.getLoot().Medicine = this.Math.rand(5, 15);
		party.getLoot().Ammo = this.Math.rand(10, 40);
		local r = this.Math.rand(1, 4);
		local arr = ["trade/silk_item", "trade/silk_item", "trade/incense_item", "trade/spices_item"];
		for(local i = 0; i < this.Math.round(r/2); i++) //adds either 1 silk, 1 silk, 2 incense, 2 spices
			party.addToInventory(arr[r-1]);
		return party;
	}
});
