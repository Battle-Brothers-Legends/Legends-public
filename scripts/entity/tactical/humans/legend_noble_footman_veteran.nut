this.legend_noble_footman_veteran <- this.inherit("scripts/entity/tactical/legend_randomized_unit_noble_abstract", {
	m = {},
	function create()
	{
		this.m.Type = ::Const.EntityType.LegendNobleGuard;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.LegendNobleGuard.XP;
		this.legend_randomized_unit_noble_abstract.create();
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/military_melee_agent");
		this.m.AIAgent.setActor(this);
		if (this.randomizeEnemyGender() == 1) {
			this.setFemale();
		} else {
			this.setMale();
		}
	}

	function onInit()
	{
		this.legend_randomized_unit_noble_abstract.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.LegendNobleGuard);
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
	}

	function setMale()
    {
		this.setGender(0);
        this.m.Faces = ::Const.Faces.AllMale;
		this.m.Hairs = ::Const.Hair.Military;
		this.m.HairColors = ::Const.HairColors.Old;
		this.m.Beards = ::Const.Beards.Tidy;  
    }


});

