this.legend_consecrated_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 0,
		DamageMin = 10,
		DamageMax = 20,
		Actor = null
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendConsecrated);
		this.m.Description = "This character is consecrated in the holy flames.";
		this.m.IsRemovedAfterBattle = true;
	}

	function setActor(_a) {
		this.m.Actor = ::MSU.asWeakTableRef(_a);
	}

	function getTooltip() {
		local ret = this.skill.getTooltip();
		local damageText = format(" Take %s - %s damage at the end of each turn.", ::Const.UI.getColorized(this.m.DamageMin, ::Const.UI.Color.NegativeValue), ::Const.UI.getColorized(this.m.DamageMax, ::Const.UI.Color.NegativeValue));
		local turnsText = this.m.TurnsLeft > 0 ? (" Lasts [color=%negative%]" + this.m.TurnsLeft + "[/color] more turns.") : "";
		ret.push({
			id = 12,
			type = "text",
			icon = "ui/icons/immunity.png",
			text = "Loses immunity to Bleeding, Injuries and Poison." + damageText + turnsText,
		});
		return ret;
	}

	function isActorOnTileWithHolyFlame() {
		local tile = this.getContainer().getActor().getTile();
		if (tile.Properties.Effect != null && tile.Properties.Effect.Type == "legend_holy_flame") {
			return true;
		} else {
			return false;
		}
	}

	function onRefresh() {
		this.m.TurnsLeft = ::Math.max(1, 2 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
	}

	function applyDamage() {
		local actor = this.getContainer().getActor();
		this.spawnIcon("fire_circle", actor.getTile());
		local hitInfo = clone ::Const.Tactical.HitInfo;
		hitInfo.DamageRegular = ::Math.rand(this.m.DamageMin, this.m.DamageMax);
		hitInfo.DamageDirect = 1.0;
		hitInfo.BodyPart = ::Const.BodyPart.Body;
		hitInfo.BodyDamageMult = 1.0;
		hitInfo.FatalityChanceMult = 0.0;
		::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " is burnt by holy flames");
		actor.onDamageReceived(this.getEffectOwner(), this, hitInfo);
	}

	function onTurnEnd() {
		this.applyDamage();
	}

	function onNewRound() {
		if (!this.isActorOnTileWithHolyFlame() && this.m.TurnsLeft <= 0) {
			this.removeSelf();
		}
	}

	function onUpdate(_properties) {
		if (!this.isActorOnTileWithHolyFlame() && this.m.TurnsLeft <= 0) {
			this.removeSelf();
		} else {
			_properties.IsAffectedByLosingHitpoints = true;
			if (!::Legends.Traits.has(this.getContainer().getActor(), ::Legends.Trait.RacialGhost)) {
				_properties.IsAffectedByInjuries = true;
				_properties.IsAffectedByFreshInjuries = true;
				_properties.IsImmuneToBleeding = false;
				_properties.IsImmuneToPoison = false;
			}
		}
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "Takes [color=%negative%]" + this.m.DamageMin + " - " + this.m.DamageMax + "[/color] " + ::Legends.S.inlineIcon("regular_damage") + "every turn, loses " + ::Legends.S.inlineIcon("immunity") + " to Bleeding, Injuries and Poison";
	}
});
