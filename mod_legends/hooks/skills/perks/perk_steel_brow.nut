::mods_hookExactClass("skills/perks/perk_steel_brow", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Type = this.m.Type | this.Const.SkillType.StatusEffect;
		this.m.Description = "Will turn any stun attacks made against you into dazes instead.";
		this.m.IconMini = "mini_steel_brow";
	}

	o.getTooltip <- function()
	{
		return [
			{
				id = 1,
				type = "title",
				text = getName()
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Any stun attack that hits you will turn into a daze instead"
			}
		];
	}

	o.onBeforeDamageReceived <- function( _attacker, _skill, _hitInfo, _properties )
	{
		if (_hitInfo.BodyPart == ::Const.BodyPart.Head)
			_hitInfo.BodyDamageMult = _hitInfo.BodyDamageMultBeforeSteelBrow * 0.67;
	}

});