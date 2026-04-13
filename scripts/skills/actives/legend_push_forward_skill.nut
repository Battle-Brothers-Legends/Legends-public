this.legend_push_forward_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendPushForward);
		this.m.Description = "Advance as one, increasing melee effectiveness of allies nearby.";
		this.m.Icon = "skills/spears_square.png";
		this.m.IconDisabled = "skills/spears_square_bw.png";
		this.m.Overlay = "spears_square";
		this.m.SoundOnUse = [
			"sounds/combat/rally_the_troops_01.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.NonTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.ActionPointCost = 5;
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
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text =  "[color=%positive%]+10[/color] melee skill to all allies within [color=%positive%]4[/color] tiles for one turn"
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/bravery.png",
				text =  "[color=%positive%]+5[/color] resolve to all allies within [color=%positive%]4[/color] tiles for one turn"
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text =  "[color=%positive%]+3[/color] melee defence to all allies within [color=%positive%]4[/color] tiles for one turn"
			}
		];
	}

	function isUsable()
	{
		return this.skill.isUsable() && !this.getContainer().hasEffect(::Legends.Effect.LegendPushingForward);
	}

	function onUse( _user, _targetTile )
	{
		local myTile = _user.getTile();
		local actors = this.Tactical.Entities.getInstancesOfFaction(_user.getFaction());

		foreach( a in actors )
		{
			if (a.getID() == _user.getID())
			{
				continue;
			}

			if (myTile.getDistanceTo(a.getTile()) > 4)
			{
				continue;
			}

			if (a.getFaction() == _user.getFaction() && !a.getSkills().hasEffect(::Legends.Effect.LegendPushingForward))
			{
				::Legends.Effects.grant(a, ::Legends.Effect.LegendPushingForward, function(_effect) {
					_effect.setCommander(this.getContainer().getActor());
				}.bindenv(this));
			}
		}

		::Legends.Effects.grant(this, ::Legends.Effect.LegendPushingForward, function(_effect) {
			_effect.setCommander(this.getContainer().getActor());
		}.bindenv(this));
		return true;
	}

});
