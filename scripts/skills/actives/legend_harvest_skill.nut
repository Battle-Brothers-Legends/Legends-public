this.legend_harvest_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create() {
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendHarvest);
		this.m.Description = "A seemingly weak attack meant to finish off a wounded enemy.";
		this.m.SoundOnUse = ::Legends.S.setSounds("sounds/combat/cleave", 3);
		this.m.SoundOnHitHitpoints = ::Legends.S.setSounds("sounds/combat/decapitate_hit", 3);
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsAOE = true;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = ::Const.Injury.CuttingBody;
		this.m.InjuriesOnHead = ::Const.Injury.CuttingHead;
		this.m.DirectDamageMult = 0.35;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 20;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.ChanceDecapitate = 99;
		this.m.ChanceDisembowel = 50;
		this.m.ChanceSmash = 0;
	}

	function getTooltip() {
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 8,
			type = "text",
			icon = "ui/icons/damage_dealt.png",
			text = "Inflicts [color=%damage%]20%[/color] more damage for each injury on the target"
		});
		ret.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Killing your target will refund this skill's Action Point cost"
		});
		return ret;
	}

	function onAfterUpdate( _properties ) {
		this.m.FatigueCostMult = _properties.IsSpecializedInCleavers ? ::Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onUse( _user, _targetTile ) {
		this.spawnAttackEffect(_targetTile, ::Const.Tactical.AttackEffectSlash);
		return this.attackEntity(_user, _targetTile.getEntity());
	}

	function onTargetSelected( _targetTile ) {
		local ownTile = this.m.Container.getActor().getTile();
		local dir = ownTile.getDirectionTo(_targetTile);
		::Tactical.getHighlighter().addOverlayIcon(::Const.Tactical.Settings.AreaOfEffectIcon, _targetTile, _targetTile.Pos.X, _targetTile.Pos.Y);
		local nextDir = dir - 1 >= 0 ? dir - 1 : ::Const.Direction.COUNT - 1;

		if (ownTile.hasNextTile(nextDir)) {
			local nextTile = ownTile.getNextTile(nextDir);

			if (::Math.abs(nextTile.Level - ownTile.Level) <= 1) {
				::Tactical.getHighlighter().addOverlayIcon(::Const.Tactical.Settings.AreaOfEffectIcon, nextTile, nextTile.Pos.X, nextTile.Pos.Y);
			}
		}
	}

	function onTargetKilled( _targetEntity, _skill ) {
		if (_skill == this) {
			local actor = this.getContainer().getActor();
			actor.setActionPoints(::Math.min(actor.getActionPointsMax(), actor.getActionPoints() + this.m.ActionPointCost));
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties ) {
		if (_skill != this)
			return;

		local damage = 0.1;
		if (_targetEntity != null) {
			damage += _targetEntity.getSkills().getAllSkillsOfType(::Const.SkillType.TemporaryInjury).len() * 0.2;
		}
		_properties.DamageTotalMult *= damage
	}
});

