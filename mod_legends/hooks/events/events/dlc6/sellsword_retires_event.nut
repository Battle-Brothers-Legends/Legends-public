::mods_hookExactClass("events/events/dlc6/sellsword_retires_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.start <- function ( _event ) {
					local item;
					local stash = this.World.Assets.getStash();
					item = this.new("scripts/items/weapons/arming_sword");
					item.setCondition(item.getRepairMax() / 2 - 1);
					stash.add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
					});
					item = this.Const.World.Common.pickArmor([
						[1, ::Legends.Armor.Standard.basic_mail_shirt],
					]);
					item.setArmor(item.getArmorMax() / 2 - 1);
					stash.add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
					});
				}
			}
		}
	}
})
