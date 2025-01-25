this.legend_kobold_racial <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "racial.legend_kobold";
		this.m.Name = "Slippery";
		this.m.Description = "This character is very hard to spot";
		this.m.Icon = "";
		this.m.SoundOnUse = [
			"sounds/combat/dlc6/smoke_bomb_01.wav",
			"sounds/combat/dlc6/smoke_bomb_02.wav"
		];
		this.m.Type = this.Const.SkillType.Racial | this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function onTurnEnd()
	{
		local actor = this.getContainer().getActor();
		local slippery = ::Legends.Effects.get(actor, ::Legends.Effect.LegendHiddenKobold);

		if (slippery == null)
		{
			::Legends.Effects.grant(actor, ::Legends.Effect.LegendHiddenKobold);
		}
		else
		{
			slippery.resetTime();
		}
	}

});

