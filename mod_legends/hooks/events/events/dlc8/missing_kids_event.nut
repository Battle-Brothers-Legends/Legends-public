::mods_hookExactClass("events/events/dlc8/missing_kids_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "Killer") {
				s.start <- function ( _event ) {
					local attachmentList = [
						"legend_mail_patch_upgrade",
						"legend_double_mail_upgrade"
					];
					local item = this.new("scripts/items/legend_armor/armor_upgrades/" + attachmentList[this.Math.rand(0, attachmentList.len() - 1)]);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + item.getName()
					});
					this.World.Assets.getStash().add(item);
					this.Characters.push(_event.m.Anatomist.getImagePath());
					this.Characters.push(_event.m.Killer.getImagePath());
				}
			}
		}
	}
})
