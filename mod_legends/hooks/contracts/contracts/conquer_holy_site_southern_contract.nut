::mods_hookExactClass("contracts/contracts/conquer_holy_site_southern_contract", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DescriptionTemplates = [
			"A Holy Site is being trespassed by northern rats. Flush them out.",
			"The Gilder faithful demand the recapture of a revered holy site. You demand coin.",
			"Despite your heathen ways, the Gilder will permit your assistance in securing a sacred place.",
			"The Gilder\'s gleam will surely shine down on those who reclaim a holy site for the faith.",
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
