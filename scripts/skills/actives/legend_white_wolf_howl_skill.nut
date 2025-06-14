this.legend_white_wolf_howl_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendWhiteWolfHowl);
		this.m.Description = "";
		this.m.Icon = "skills/active_22.png";
		this.m.IconDisabled = "skills/active_22_sw.png";
		this.m.Overlay = "active_22";
		this.m.SoundOnUse = [
			"sounds/enemies/werewolf_howl.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 20;
		this.m.MinRange = 0;
		this.m.MaxRange = 0;
	}

	function getTooltip()
	{
		local p = this.getContainer().getActor().getCurrentProperties();
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 3,
				type = "text",
				text = this.getCostString()
			}
		];
	}

	function raiseMorale( _actor, _tag )
	{
		if (_actor.getFaction() == _tag.Self.getFaction() && _actor.getFlags().has("werewolf"))
		{
			_actor.setMorale(_actor.getMorale() + 30);
			_tag.Skill.spawnIcon("status_effect_06", _actor.getTile());
		}
	}

	function onUse( _user, _targetTile )
	{
		this.result <- {
			Self = _user,
			Skill = this
		};
		this.Tactical.queryActorsInRange(_user.getTile(), 1, 6, this.raiseMorale, this.result);
		return true;
	}

});
