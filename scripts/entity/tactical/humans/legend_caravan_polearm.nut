this.legend_caravan_polearm <- this.inherit("scripts/entity/tactical/legend_randomized_unit_abstract", {
	m = {
	},
	function create()
	{
		this.m.Type = ::Const.EntityType.LegendCaravanPolearm;
		this.m.BloodType = ::Const.BloodType.Red;
		// this.m.XP = ::Const.Tactical.Actor.LegendCaravanPolearm.XP;
		this.legend_randomized_unit_abstract.create();
		this.m.Faces = ::Const.Faces.AllMale;
		this.m.Hairs = ::Const.Hair.AllMale;
		this.m.HairColors = ::Const.HairColors.All;
		this.m.Beards = ::Const.Beards.All;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/caravan_melee_agent");
		this.m.AIAgent.setActor(this);
		if (this.randomizeEnemyGender() == 1) {
			this.setGender(1);
		}
	}

	function onInit()
	{
		this.legend_randomized_unit_abstract.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.LegendCaravanPolearm);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_caravan");
		this.getSprite("dirt").Visible = true;
	}


	function assignRandomEquipment()
	{
		this.legend_randomized_unit_abstract.assignRandomEquipment();
	}
});

