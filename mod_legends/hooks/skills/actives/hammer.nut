::mods_hookExactClass("skills/actives/hammer", function(o)
{
	o.m.IsMordhau <- false;
	o.m.IsGreatMordhau <- false;

	o.setItem <- function (_item) {
		if (this.m.IsMordhau)
		{
			this.m.Name = "Mordhau";
			this.m.Description = "Grip your sword by the blade and strike with the guard and pommel for a strike that can be felt through the thickest of armor and will leave a lasting mark.";
			this.m.Icon = "skills/active_mordhau.png";
			this.m.IconDisabled = "skills/active_mordhau_bw.png";
			this.m.Overlay = "active_mordhau";
			this.m.IsIgnoredAsAOO = true;
			this.m.ActionPointCost = this.m.IsGreatMordhau ? 7 : 5;
			this.m.FatigueCost = this.m.IsGreatMordhau ? 18 : 14;

		}
		this.skill.setItem(_item);
	}

	o.getTooltip = function () {
		local ret = this.getDefaultTooltip();
		if (this.m.IsMordhau) {
			local effects = this.m.IsGreatMordhau ? "stagger" : "daze";
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=%positive%]100%[/color] chance to " + effects + " on hits to the head"
			});
		}
		return ret;
	}

	local onAfterUpdate = o.onAfterUpdate;
	o.onAfterUpdate = function ( _properties ) {
		if (this.m.IsMordhau || this.m.IsGreatMordhau)
			this.m.FatigueCostMult = _properties.IsSpecializedInSwords ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		else
			return onAfterUpdate(_properties);
	}

	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties ) {
		if (_skill != this)
			return;
		
		_properties.DamageMinimum += 10;
		if (this.m.IsMordhau)
			_properties.DamageArmorMult *= 1.5;	
	}

	o.onTargetHit <- function ( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor ) {
		if (_skill != this)
			return;

		if (!this.m.IsMordhau)
			return;

		if (_bodyPart != this.Const.BodyPart.Head)
			return;

		if (::Legends.S.skillEntityAliveCheck(_targetEntity)) {
			return;
		}

		local actor = this.getContainer().getActor();
		local effect = this.m.IsGreatMordhau ? ::Legends.Effects.grant(_targetEntity, ::Legends.Effect.Staggered) : ::Legends.Effects.grant(_targetEntity, ::Legends.Effect.Dazed);
		if (!actor.isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer) {
			this.Tactical.EventLog.log(effect.getLogEntryOnAdded(this.Const.UI.getColorizedEntityName(actor), this.Const.UI.getColorizedEntityName(_targetEntity)));
		}
	}
});