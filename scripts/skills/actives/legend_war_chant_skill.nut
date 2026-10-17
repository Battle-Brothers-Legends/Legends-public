this.legend_war_chant_skill <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendWarChant);
		this.m.Description = "Push allies on with your music, lowering the fatigue of all allies within 8 tiles. Must be holding a musical instrument to use. Songs apply once per turn.";
		this.m.SoundOnUse = ::Legends.S.setSounds("sounds/enemies/dlc4/wardrums", 3);
		this.m.SoundVolume = 1.5;
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = true;
		this.m.IsAttack = false;
		this.m.IsVisibleTileNeeded = false;
		this.m.ActionPointCost = 8;
		this.m.FatigueCost = 30;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function getTooltip() {
		local ret = [
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
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Restores [color=%positive%]" + this.getBonus() + "[/color] Fatigue to allies within 8 tiles"
			}
		];
		local actor = this.getContainer().getActor();
		if (::Tactical.isActive() && actor.getTile().hasZoneOfControlOtherThan(actor.getAlliedFactions())) {
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]Cannot be used because this character is engaged in melee[/color]"
			});
		}
		local weapon = actor.getMainhandItem();
		if (weapon == null || !weapon.isWeaponType(::Const.Items.WeaponType.Musical)) {
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]Can only be used while holding a Musical Instrument[/color]"
			});
		}
		return ret;
	}

	function getBonus() {
		local actor = this.getContainer().getActor();
		return 1 + 2 * ([actor.getCurrentProperties().IsSpecializedInMusic, ::Legends.Perks.has(actor, ::Legends.Perk.LegendSpecialistMusician), ::Legends.Perks.has(actor, ::Legends.Perk.LegendMinnesanger)].filter(@(_, _source)(_source == true)).len());
	}

	function isUsable() {
		local actor = this.getContainer().getActor();
		local mainhand = actor.getMainhandItem();
		return this.skill.isUsable() && ::Tactical.isActive() && mainhand != null && mainhand.isWeaponType(::Const.Items.WeaponType.Musical) && !actor.getTile().hasZoneOfControlOtherThan(actor.getAlliedFactions());
	}

	function onUse(_user, _targetTile) {
		local myTile = _user.getTile();
		foreach (ally in ::Tactical.Entities.getInstancesOfFaction(_user.getFaction()).filter(@(_, _ally)(!_ally.getSkills().hasEffect(::Legends.Effect.LegendWarChant) && _ally.getTile().getDistanceTo(myTile) <= 8))) {
			ally.setFatigue(::Math.max(0, ally.getFatigue() - this.getBonus()));
			::Legends.Effects.grant(ally, ::Legends.Effect.LegendWarChant);
		}
		return true;
	}
});
