::Const.LegendMod.Formations <- {
	Count = 8
};

::Const.LegendMod.MaxResources <- [
	{
		Food = 300,
		Ammo = 500,
		Medicine = 200,
		ArmorParts = 200,
		Stash = 80
	},
	{
		Food = 250,
		Ammo = 250,
		Medicine = 100,
		ArmorParts = 100,
		Stash = 50
	},
	{
		Food = 200,
		Ammo = 100,
		Medicine = 50,
		ArmorParts = 50,
		Stash = 25
	},
	{
		Food = 50,
		Ammo =  50,
		Medicine = 25,
		ArmorParts = 25,
		Stash = 10
	}
];

::Const.LegendMod.StartResources <- [
	{
		Money = 2000,
		Ammo = 100,
		Medicine = 50,
		ArmorParts = 50
	},
	{
		Money = 1000,
		Ammo = 50,
		Medicine = 25,
		ArmorParts = 25
	},
	{
		Money = 500,
		Ammo = 25,
		Medicine = 10,
		ArmorParts = 10
	},
	{
		Money = 0,
		Ammo = 0,
		Medicine = 0,
		ArmorParts = 0
	}
];

::Const.LegendMod.ResourceModifiers <- {
	Ammo = [13, 21, 34, 55, 89],
	ArmorParts = [5, 8, 13, 21, 34, 55],
	Meds = [8, 13, 21, 34, 55],
	Stash = [3, 5, 8, 13, 21, 34],
	Healing = [0.0, 0.10, 0.30, 0.50],
	Injury = [0.0, 0.03, 0.06, 0.10],
	Repair = [0.0, 0.10, 0.30, 0.50, 1.0],
	Salvage = [0.0, 0.10, 0.30, 0.50],
	Crafting = [0.0, 0.50, 0.75, 1.0],
	Barter = [0.0, 0.005, 0.01, 0.02, 0.03],
	ToolConsumption = [0.0, 0.01, 0.03, 0.05],
	MedConsumption = [0.0, 0.05, 0.10, 0.20],
	Hunting = [0.0, 0.1, 0.2, 0.3], // = BasePoints + BasePoints * Modifier
	Fletching = [0.0, 0.1, 0.2, 0.3], // = BasePoints + BasePoints * Modifier
	Scout = [0.0, 0.1, 0.2, 0.3], // = BasePoints + BasePoints * Modifier
	Gather = [0.0, 0.30, 0.50, 1.0], // = BasePoints + BasePoints * Modifier
	Training = [0.0, 0.1, 0.2, 0.3] // = BasePoints + BasePoints * Modifier
}
