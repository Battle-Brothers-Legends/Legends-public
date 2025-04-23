::mods_hookExactClass("events/events/dlc8/oathbreaker_event", function(o) {
	local create = o.create;
	o.create = function () {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "BuyArmor") {
				s.start <- function (_event) {
					local item;
					local stash = this.World.Assets.getStash();
					local weapons = [
						"weapons/arming_sword",
						"weapons/military_pick",
						"weapons/hand_axe",
						"weapons/pike",
						"weapons/warbrand"
					];
					item = this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]);
					item.setCondition(item.getConditionMax() / 3 - 1);
					stash.add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
					});
					item = this.Const.World.Common.pickArmor([
						[1, ::Legends.Armor.Standard.adorned_heavy_mail_hauberk],
					]);
					item.setCondition(item.getRepair() / 3 - 1);
					stash.add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.makeName()
					});
					item = this.Const.World.Common.pickHelmet([
						[1, ::Legends.Helmet.Standard.adorned_full_helm],
					]);
					item.setCondition(item.getRepair() / 3 - 1);
					stash.add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.makeName()
					});
					this.World.Assets.addMoney(-9000);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "You lose [color=" + this.Const.UI.Color.NegativeEventValue + "]9,000[/color] Crowns"
					});
				}
			}
			if (s.ID == "Oathtaker") {
				s.start <- function (_event) {
					local roster = this.World.getTemporaryRoster();
					_event.m.Dude = roster.create("scripts/entity/tactical/player");
					_event.m.Dude.setStartValuesEx([
						"paladin_background"
					]);
					_event.m.Dude.setTitle("the Oathbreaker");
					_event.m.Dude.getBackground().m.RawDescription = "Like many men, %name% was found in squalor. Ale on his lips, grime in his ears, piss and shit at least somewhere on his person. But he was an Oathtaker at heart, and by the providence of Young Anselm it was certainly no ordinary circumstance which brought him back into the faith. Of course, he\'ll still yet pair beer with belief, but now and again one must allow a man his vices, particularly if said man shares an interest in slaying Oathbringers.";
					_event.m.Dude.getBackground().buildDescription(true);
					_event.m.Dude.m.PerkPoints = 0;
					_event.m.Dude.m.LevelUps = 0;
					_event.m.Dude.m.Level = 1;
					_event.m.Dude.m.XP = this.Const.LevelXP[_event.m.Dude.m.Level - 1];
					::Legends.Traits.grant(_event.m.Dude, ::Legends.Trait.Drunkard);
					local dudeItems = _event.m.Dude.getItems();

					if (dudeItems.getItemAtSlot(this.Const.ItemSlot.Mainhand) != null)
					{
						dudeItems.getItemAtSlot(this.Const.ItemSlot.Mainhand).removeSelf();
					}

					if (dudeItems.getItemAtSlot(this.Const.ItemSlot.Offhand) != null)
					{
						dudeItems.getItemAtSlot(this.Const.ItemSlot.Offhand).removeSelf();
					}

					if (dudeItems.getItemAtSlot(this.Const.ItemSlot.Head) != null)
					{
						dudeItems.getItemAtSlot(this.Const.ItemSlot.Head).removeSelf();
					}

					if (dudeItems.getItemAtSlot(this.Const.ItemSlot.Body) != null)
					{
						dudeItems.getItemAtSlot(this.Const.ItemSlot.Body).removeSelf();
					}

					local weapons = [
						"weapons/arming_sword",
						"weapons/military_pick",
						"weapons/hand_axe",
						"weapons/pike",
						"weapons/warbrand"
					];
					local item = this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]);
					item.setCondition(item.getRepair() / 3 - 1);
					dudeItems.equip(item);
					item = this.Const.World.Common.pickHelmet([
						[1, ::Legends.Helmet.Standard.adorned_full_helm],
					]);
					item.setCondition(item.getRepair() / 3 - 1);
					dudeItems.equip(item);
					item = this.Const.World.Common.pickArmor([
						[1, ::Legends.Armor.Standard.adorned_heavy_mail_hauberk],
					]);
					item.setCondition(item.getConditionMax() / 3 - 1);
					dudeItems.equip(item);
					this.Characters.push(_event.m.Dude.getImagePath());
				}
			}
		}
	}
});
