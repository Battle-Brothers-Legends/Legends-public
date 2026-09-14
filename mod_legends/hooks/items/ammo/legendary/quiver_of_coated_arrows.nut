::mods_hookExactClass("items/ammo/legendary/quiver_of_coated_arrows", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.AddGenericSkill = true;
	}

	o.onDamageDealt = function (_target, _skill, _hitInfo) {
		local item = _skill.getItem();
		if (_skill.isAttack() && item != null && item.isItemType(::Const.Items.ItemType.Weapon) && item.isWeaponType(::Const.Items.WeaponType.Bow)) {
			if (::Legends.S.isEntityNullOrDead(_target)) {
				if (_target.getFlags().has("tail") || !_target.getCurrentProperties().IsImmuneToBleeding) {
					::Sound.play(this.m.BleedSounds[::Math.rand(0, this.m.BleedSounds.len() - 1)], ::Const.Sound.Volume.Skill, this.getContainer().getActor().getPos());
				}
			} else if (!_target.getCurrentProperties().IsImmuneToBleeding && _hitInfo.DamageInflictedHitpoints >= ::Const.Combat.MinDamageToApplyBleeding) {
				::Legends.Effects.grant(_target, ::Legends.Effect.Bleeding, function (_effect) {
					_effect.setActor(this.getContainer().getActor());
					_effect.setDamage(this.m.BleedDamage);
				}.bindenv(this));
				::Sound.play(this.m.BleedSounds[::Math.rand(0, this.m.BleedSounds.len() - 1)], ::Const.Sound.Volume.Skill, this.getContainer().getActor().getPos());
			}
		}
	}
});
