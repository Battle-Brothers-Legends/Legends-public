this.legend_possession_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendPossession);
		this.m.Description = "";
		this.m.SoundOnHit = ::Legends.S.setSounds("sounds/enemies/necromancer", 3);
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.UtilityTargeted + 27;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsVisibleTileNeeded = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 18;
		this.m.MinRange = 1;
		this.m.MaxRange = 9;
		this.m.MaxLevelDifference = 4;
	}

	function getTooltip() {
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

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		local target = _targetTile.getEntity();
		local actor = this.getContainer().getActor();

		if (!actor.isAlliedWith(target))
		{
			return false;
		}

		if (!target.getFlags().has("IsSummoned") && !target.getFlags().has("PlayerZombie") && !::MSU.isKindOf(target, "legend_player_legion") && !target.getFlags().has("zombie_minion"))
		{
			return false;
		}

		if (target.getSkills().hasEffect(::Legends.Effect.LegendPossession))
		{
			return false;
		}

		return true;
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();

		if (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer)
		{
			::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " possesses " + ::Const.UI.getColorizedEntityName(target));

			if (this.m.SoundOnHit.len() != 0)
			{
				::Sound.play(this.m.SoundOnHit[::Math.rand(0, this.m.SoundOnHit.len() - 1)], ::Const.Sound.Volume.Skill * 1.2, _user.getPos());
			}
		}

		::Legends.Effects.grant(target, ::Legends.Effect.LegendPossession);
		::Legends.Traits.grant(target, ::Legends.Trait.Loyal); //removes charm and makes immune to charm.
		target.setActionPoints(target.getCurrentProperties().ActionPoints);
		// local possessing = this.new("scripts/skills/effects/possessing_undead_effect");
		// possessing.setPossessed(target);
		// _user.getSkills().add(possessing);
		return true;
	}

});
