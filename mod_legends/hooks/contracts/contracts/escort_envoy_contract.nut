::mods_hookExactClass("contracts/contracts/escort_envoy_contract", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.Name = "A Diplomatic Mission";
		this.m.DescriptionTemplates = [
			"They say the pen is mightier than the sword... if that were really true than this envoy would not be needing an armed escort.",
			"For both protection and deniability, hired sellswords are a popular choice for secret diplomatic missions.",
			"Ensure an envoy/'s safety on a perilous journey into enemy lands. For an outrageous fee of course.",
			"Deliver a secret envoy through enemy territory, then somehow get them out again.",
			"Life as an envoy is a journey filled with diplomacy and intrigue, navigating the delicate balance of power between realms.",
			"In the cutthroat world of diplomacy, envoys face constant danger from rival factions, rogue agents, and deadly traps laid by those who seek to thwart their efforts.",
			"In the midst of war and chaos, envoys are hunted by enemies both seen and unseen, their every move watched and their every step shadowed by the specter of death.",
		];
	}

	local createStates = o.createStates;
	o.createStates = function () {
		createStates();
		foreach (s in this.m.States) {
			if (s.ID == "Offer") {
				s.end = function () {
					this.World.Assets.addMoney(this.Contract.m.Payment.getInAdvance());
					local r = this.Math.rand(1, 100);

					if (r <= 10) {
						if (this.Contract.getDifficultyMult() >= 1.0) {
							this.Flags.set("IsShadyDeal", true);
						}
					}

					local envoy = this.World.getGuestRoster().create("scripts/entity/tactical/humans/envoy");
					local items = envoy.getItems();
					items.equip(this.Const.World.Common.pickArmor([
						[1, ::Legends.Armor.Standard.linen_tunic]
					]));
					items.equip(this.Const.World.Common.pickHelmet([
						[1, ::Legends.Helmet.Standard.feathered_hat],
						[2, ::Legends.Helmet.None]
					]));

					envoy.setName(this.Flags.get("EnvoyName"));
					envoy.setTitle(this.Flags.get("EnvoyTitle"));
					envoy.setFaction(1);
					this.Flags.set("EnvoyID", envoy.getID());
					this.Contract.setScreen("Overview");
					this.World.Contracts.setActiveContract(this.Contract);
				}
			}
		}
	}

	local createScreens = o.createScreens;
	o.createScreens = function () {
		createScreens();
		::Legends.Screens.hook(this, "Task", function (_screen) {
			_screen.Title = "A Diplomatic Mission";
		});
	}

});
