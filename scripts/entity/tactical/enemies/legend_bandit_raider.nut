this.legend_bandit_raider <- this.inherit("scripts/entity/tactical/legend_randomized_unit_abstract", {
	m = {
		IsLow = false
	},
	function create()
	{
		this.m.Type = ::Const.EntityType.BanditRaider;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.BanditRaider.XP;
		this.legend_randomized_unit_abstract.create();
		this.m.Faces = ::Const.Faces.AllMale;
		this.m.Hairs = ::Const.Hair.UntidyMale;
		this.m.HairColors = ::Const.HairColors.All;
		this.m.Beards = ::Const.Beards.Raider;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/bandit_melee_agent");
		this.m.AIAgent.setActor(this);
		if (this.randomizeEnemyGender() == 1) {
			this.setGender(1);
		}
	}

	function onInit()
	{
		this.legend_randomized_unit_abstract.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.BanditRaider);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_bandits");
		local dirt = this.getSprite("dirt");
		dirt.Visible = true;
		dirt.Alpha = ::Math.rand(150, 255);
		this.setArmorSaturation(0.85);
		this.getSprite("shield_icon").setBrightness(0.85);

		if (!this.m.IsLow)
		{
			b.IsSpecializedInSwords = true;
			b.IsSpecializedInAxes = true;
			b.IsSpecializedInMaces = true;
			b.IsSpecializedInFlails = true;
			b.IsSpecializedInPolearms = true;
			b.IsSpecializedInThrowing = true;
			b.IsSpecializedInHammers = true;
			b.IsSpecializedInSpears = true;
			b.IsSpecializedInCleavers = true;

			if (!::Tactical.State.isScenarioMode() && ::World.getTime().Days >= ::Const.World.Scaling.Brigands.RaiderStatIncreaseDay)
			{
				b.MeleeSkill += 5;
				b.RangedSkill += 5;
			}
		}
	}

	function onAppearanceChanged( _appearance, _setDirty = true )
	{
		this.actor.onAppearanceChanged(_appearance, false);
		this.setDirty(true);
	}


	function assignRandomEquipment()
	{
		this.legend_randomized_unit_abstract.assignRandomEquipment();
	}
});

