::mods_hookExactClass("skills/actives/hand_to_hand_orc", function (o) {
	local onUpdate = o.onUpdate;
	o.onUpdate = function (_properties) {
		onUpdate(_properties);
		if (this.isUsable()) {
			//Untested fix, theoretically should fix being disarmed and getting extra weapon damage
			local mainhand = this.getContainer().getActor().getItems().getItemAtSlot(::Const.ItemSlot.Mainhand);
			if (mainhand != null) {
				_properties.DamageRegularMin -= mainhand.m.RegularDamage;
				_properties.DamageRegularMax -= mainhand.m.RegularDamageMax;
			}
		}
	}
});
