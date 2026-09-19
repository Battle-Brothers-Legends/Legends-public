this.legend_magic_missile_skill <- this.inherit("scripts/skills/legend_magic_skill", {
	m = {
		Range = 6,
		BaseFatigueCost = 20
	},

	function create() {
		this.legend_magic_skill.create();
		this.m.AdditionalAccuracy = 20;
		this.m.DamageInitiativeMin = 15;
		this.m.DamageInitiativeMax = 35;
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendMagicMissile);
		this.m.Description = "A burst of force, leaping forward into a foe.";
		this.m.KilledString = "Shot";
		this.m.SoundOnUse = ::Legends.S.setSounds("sounds/combat/magic_missile", 2);
		this.m.SoundOnHit = ::Legends.S.setSounds("sounds/combat/arrow_hit", 3);
		this.m.SoundOnHitShield = ::Legends.S.setSounds("sounds/combat/shield_hit_arrow", 3);
		this.m.SoundOnMiss = ::Legends.S.setSounds("sounds/combat/arrow_miss", 3);
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.OffensiveTargeted;
		this.m.Delay = 1000;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = true;
		this.m.IsDoingForwardMove = false;
		this.m.InjuriesOnBody = ::Const.Injury.PiercingBody;
		this.m.InjuriesOnHead = ::Const.Injury.PiercingHead;
		this.m.DirectDamageMult = 0.4;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = this.m.BaseFatigueCost;
		this.m.MinRange = 1;
		this.m.MaxRange = 6;
		this.m.MaxLevelDifference = 6;
		this.m.ProjectileType = ::Const.ProjectileType.Missile;
	}

	function getTooltip() {
		local ret = this.getDefaultTooltip();
		ret.extend([
			{
				id = 6,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Range of [color=%positive%]" + this.m.MaxRange + "[/color] tiles"
			},
			{
				id = 8,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "Hit chance based on Ranged Skill, damage based on current Initiative."
			}
		]);
		if (!this.getContainer().getActor().isArmedWithMagicStaff()) {
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]Can only be used while wielding a magic staff[/color]"
			});
		}

		return ret;
	}

	function isUsable() {
		local actor = this.getContainer().getActor();
		if (!actor.isArmedWithMagicStaff()) {
			return false;
		}

		return this.skill.isUsable() && (!::Tactical.isActive() || !actor.getTile().hasZoneOfControlOtherThan(actor.getAlliedFactions()));
	}

	function onAfterUpdate(_properties) {
		this.m.FatigueCost = this.m.BaseFatigueCost;
		this.m.MaxRange = this.m.Range - 1 + (_properties.IsSpecializedInStaves ? 1 : 0);
		this.m.FatigueCostMult = _properties.IsSpecializedInStaves ? ::Const.Combat.WeaponSpecFatigueMult : 1.0;
		this.m.ActionPointCost = _properties.IsSpecializedInStaves ? 5 : 6;

		if (this.m.Container.hasPerk(::Legends.Perk.LegendMagicMissileFocus)) {
			this.m.ActionPointCost -= 1;
		}
		if (this.m.Container.hasPerk(::Legends.Perk.LegendMagicMissileMastery)) {
			this.m.ActionPointCost -= 1;
			this.m.FatigueCost -= 6;
		}
	}

});
