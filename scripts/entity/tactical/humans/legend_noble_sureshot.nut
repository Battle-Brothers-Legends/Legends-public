this.legend_noble_sureshot <- this.inherit("scripts/entity/tactical/legend_randomized_unit_noble_abstract", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.NobleSureshot;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.NobleSureshot.XP;
		this.legend_randomized_unit_noble_abstract.create();
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/military_ranged_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.legend_randomized_unit_noble_abstract.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.NobleSureshot);
		b.IsSpecializedInSwords = true;
		b.IsSpecializedInAxes = true;
		b.IsSpecializedInMaces = true;
		b.IsSpecializedInFlails = true;
		b.IsSpecializedInPolearms = true;
		b.IsSpecializedInThrowing = true;
		b.IsSpecializedInHammers = true;
		b.IsSpecializedInSpears = true;
		b.IsSpecializedInCleavers = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
	}

	function assignRandomEquipment()
	{
        this.legend_randomized_unit_noble_abstract.assignRandomEquipment();
		this.getItems().addToBag(::Const.World.Common.pickItem([
			[1, "weapons/dagger"],
		], "scripts/items/"));
	}

});

