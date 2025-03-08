::mods_hookExactClass("contracts/contracts/escort_envoy_contract", function(o) 
{
	o.m.Envoy <- null;

	local create = o.create;
	o.create = function()
	{
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
	o.createStates = function()
	{
		createStates();
		foreach (s in this.m.States)
		{
			if (s.ID == "Offer")
			{
				s.end <- function ()
				{
					this.World.Assets.addMoney(this.Contract.m.Payment.getInAdvance());
					local r = this.Math.rand(1, 100);

					if (r <= 10)
					{
						if (this.Contract.getDifficultyMult() >= 1.0)
						{
							this.Flags.set("IsShadyDeal", true);
						}
					}
					if (this.m.Envoy != null)
					{
						local envoy = this.World.getGuestRoster().create("scripts/entity/tactical/humans/envoy");
						envoy.setName(this.Flags.get("EnvoyName"));
						envoy.setTitle(this.Flags.get("EnvoyTitle"));
						envoy.setFaction(1);
						this.m.Envoy = envoy;
						this.Flags.set("EnvoyID", envoy.getID());
					}
					this.Contract.setScreen("Overview");
					this.World.Contracts.setActiveContract(this.Contract);
				}
			}
			if (s.ID == "Task")
			{
				s.Title = "A Diplomatic Mission";
			}
		}
	}
});