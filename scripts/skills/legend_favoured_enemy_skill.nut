this.legend_favoured_enemy_skill <- this.inherit("scripts/skills/skill", {
	m = {
		ValidTypes = [],
		BraveryMult = 1.0
	},

	function create() {
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Icon = "skills/status_effect_57.png";
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden() {
		return this.inBattleHiddenCheck();
	}

	function inBattleHiddenCheck() {
		if (!("State" in ::Tactical) || ::Tactical.State == null) //don't bother hiding the skill when it's not in combat
		{
			return false;
		}

		if (!("Entities" in ::Tactical)) {
			return false;
		}

		if (::Tactical.Entities == null) {
			return false;
		}

		local instances = ::Tactical.Entities.getAllInstancesAsArray();
		local myFaction = this.getContainer().getActor().getFaction();

		foreach (idx in instances) {
			if (idx == null) {
				continue;
			}

			if (idx.getFaction() == myFaction) {
				continue;
			}

			if (idx.getTile() == null) {
				continue;
			}

			if (this.m.ValidTypes.find(idx.getType()) != null) {
				return false;
			}
		}

		return true; //should only hide/reach here if no entity in the valid type is on the tactical map

	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		tooltip.extend(this.getDynamicTooltip());
		return tooltip;
	}

	function getDynamicTooltip(_actor = null) {
		local stats = this.getTotalKillStats(_actor);
		local tooltip = [
			{
				id = 7,
				type = "progressbar",
				icon = "ui/tooltips/positive.png",
				value = stats.HitChance,
				valueMax = 25,
				text = "" + stats.HitChance + "% / " + "25%",
				style = "fatigue-slim"
			},
			{
				id = 8,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=%positive%]+" + stats.HitChance + "[/color] Melee Skill"
			},
			{
				id = 9,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=%positive%]+" + stats.HitChance + "[/color] Ranged Skill"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "[color=%positive%]+" + stats.HitChance + "%[/color] Maximum Damage"
			},
			{
				id = 12,
				type = "hint",
				icon = "ui/icons/special.png",
				text = format((stats.Kills > 0 ? format("This character has already made %s favored enemy kills", ::Legends.S.highlightForLightBackground(stats.Kills)) : "This character has not made any favored enemy kills yet"))
			}
		];
		if (this.m.BraveryMult > 1) {
			tooltip.push({
				id = 11,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=%positive%]+" + ::Math.floor((this.m.BraveryMult - 1.0) * 100.0) + "%[/color] Resolve"
			});
		}
		return tooltip;
	}

	function validTarget(_targetID) {
		foreach (t in this.m.ValidTypes) {
			if (_targetID == t) {
				return true;
			}
		}
		return false;
	}

	function getTotalKillStats(_actor = null) {
		local actor = _actor != null ? _actor : this.getContainer().getActor();
		return ::Const.LegendMod.GetFavoriteEnemyStats(actor, this.m.ValidTypes);
	}

	function onAnySkillUsed(_skill, _targetEntity, _properties) {
		if (_targetEntity == null) {
			return;
		}

		if (this.validTarget(_targetEntity.getType())) {
			local stats = this.getTotalKillStats();
			_properties.MeleeSkill += stats.HitChance;
			_properties.RangedSkill += stats.HitChance;
			_properties.DamageRegularMax *= stats.HitMult;
		}

		else {
			return;
		}
	}

	function onUpdate(_properties) {
		if (this.m.BraveryMult == 1.0) {
			return;
		}

		if (!("Entities" in ::Tactical)) {
			return;
		}

		if (::Tactical.Entities == null) {
			return;
		}

		local actors = ::Tactical.Entities.getAllInstancesAsArray();
		foreach (a in actors) {
			foreach (vt in this.m.ValidTypes) {
				if (a.getType() == vt && !a.isAlliedWithPlayer()) {
					_properties.BraveryMult *= this.m.BraveryMult;
					return;
				}
			}
		}
	}

	function onAdded() {
		::Const.LegendMod.FavEnemyPerkMap.addEnemies(this.m.ValidTypes, this.m.ID);
	}

	// Requires MSU; this will add tooltips to display bonuses when targeting an enemy
	function onGetHitFactors(_skill, _targetTile, _tooltip) {
		if (this.validTarget(_targetTile.getEntity().getType())) {

			local bonuses = this.getTotalKillStats();

			_tooltip.push({
				icon = "ui/tooltips/positive.png",
				text = format("[color=%s]%s%%[/color] Favoured Enemy (also grants [color=%s]+%s%%[/color] max damage)", ::Const.UI.Color.PositiveValue, bonuses.HitChance.tostring(), ::Const.UI.Color.PositiveValue, bonuses.HitChance.tostring())
			});

		}
	}

});
