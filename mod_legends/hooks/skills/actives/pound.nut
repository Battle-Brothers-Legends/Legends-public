::mods_hookExactClass("skills/actives/pound", function(o)
{
	local create = o.create;
	o.create = function() {
		create();
		this.m.BlockBypass = 0.25;
	}

	o.getTooltip = function() {
		local ret = this.getDefaultTooltip();
		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInFlails) {
			ret.push({
				id = 5,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Hits to the head ignore an additional [color=%positive%]20%[/color] of armor"
			});
		}
		else {
			ret.push({
				id = 5,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Hits to the head ignore an additional [color=%positive%]10%[/color] of armor"
			});
		}

		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Has a [color=%positive%]" + this.m.StunChance + "%[/color] chance to stun on a hit"
		});
		return ret;
	}

	local onAfterUpdate = o.onAfterUpdate;
	o.onAfterUpdate = function ( _properties ) {
		onAfterUpdate(_properties);
		if (_properties.IsSpecializedInFlails) {
			this.m.BlockBypass += 0.25;
		}
	}

	o.onUse = function ( _user, _targetTile ) {
		this.spawnAttackEffect(_targetTile, ::Const.Tactical.AttackEffectBash);
		local target = _targetTile.getEntity();
		local success = this.attackEntity(_user, target);

		if (!_user.isAlive() || _user.isDying()) {
			return success;
		}

		if (success && _targetTile.IsOccupiedByActor && ::Math.rand(1, 100) <= this.m.StunChance && !target.getCurrentProperties().IsImmuneToStun && !target.getSkills().hasEffect(::Legends.Effect.Stunned)) {
			::Legends.Effects.grant(target, ::Legends.Effect.Stunned);

			if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer) {
				::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " has stunned " + ::Const.UI.getColorizedEntityName(target) + " for one turn");
			}
		}

		return success;
	}
});
