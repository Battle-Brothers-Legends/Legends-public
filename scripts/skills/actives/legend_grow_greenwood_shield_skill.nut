this.legend_grow_greenwood_shield_skill <- this.inherit("scripts/skills/skill", {
	m = {
		IsSpent = false
	},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendGrowGreenwoodShield);
		this.m.Description = "";
		this.m.Icon = "skills/active_121.png";
		this.m.IconDisabled = "skills/active_121.png";
		this.m.Overlay = "active_121";
		this.m.SoundOnUse = [
			"sounds/enemies/dlc2/schrat_regrowth_01.wav",
			"sounds/enemies/dlc2/schrat_regrowth_02.wav",
			"sounds/enemies/dlc2/schrat_regrowth_03.wav",
			"sounds/enemies/dlc2/schrat_regrowth_04.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 25;
		this.m.MinRange = 0;
		this.m.MaxRange = 0;
	}

	function isUsable()
	{
		return !this.getContainer().getActor().isArmedWithShield() && this.skill.isUsable();
	}

	function onUse( _user, _targetTile )
	{
		local actor = this.getContainer().getActor();
		this.Time.scheduleEvent(this.TimeUnit.Virtual, 250, function ( _idk )
		{
			actor.getItems().equip(this.new("scripts/items/shields/beasts/legend_greenwood_schrat_shield"));
			actor.getSprite("shield_icon").Alpha = 0;
			actor.getSprite("shield_icon").fadeIn(1500);
		}, null);
	}

});

