::mods_hookExactClass("scenarios/world/anatomists_scenario", function (o) {
	o.onSpawnAssets <- function ()
	{
		local roster = this.World.getPlayerRoster();
		local names = [];

		for( local i = 0; i < 3; i = ++i )
		{
			local bro;
			bro = roster.create("scripts/entity/tactical/player");
			bro.m.HireTime = this.Time.getVirtualTimeF();
		}

		local bros = roster.getAll();
		bros[0].setStartValuesEx([
			"anatomist_background"
		]);
		bros[0].getBackground().m.RawDescription = "{Captain? Is it alright if I call you captain? Ah, of course it is. What? No, we were not calling you by another name. Yers is a smooth costard, good sir, and we would not be of such derring-do to refer to you as a sellsword who is as ordinary as any of our coetaneous clodpolls, or state that we were in some sense importuning commerce by conducting business with a man of your particular skills. No sir, we would not. We are not children of perdition, sir.}";
		bros[0].setPlaceInFormation(3);
		bros[0].setVeteranPerks(2);
		bros[0].m.Talents = [];
		local talents = bros[0].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.Bravery] = 1;
		talents[this.Const.Attributes.MeleeSkill] = 2;
		talents[this.Const.Attributes.RangedSkill] = 2;
		local items = bros[0].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Body));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));
		local armor = this.new("scripts/items/legend_armor/cloth/legend_tunic");
		local plate = this.new("scripts/items/legend_armor/plate/undertakers_apron");
		armor.setUpgrade(plate);
		items.equip(armor);
		local hood = this.new("scripts/items/legend_helmets/hood/legend_helmet_cloth_scarf");
		local top = this.new("scripts/items/legend_helmets/top/legend_helmet_undertakers_scarf");
		local vanity = this.new("scripts/items/legend_helmets/vanity/legend_helmet_undertakers_hat");
		hood.setUpgrade(top);
		hood.setUpgrade(vanity);
		items.equip(hood);

		bros[1].setStartValuesEx([
			"anatomist_background"
		]);
		bros[1].getBackground().m.RawDescription = "{Despite others\' hesitancies, I\'ve no qualms calling you a javel, sir. You are, after all, a javel. A scapegrace. Some sellsword or another, yes? I think only a man who trucks cowardice would avoid calling you what you are. That someone disrespects your intelligence, thinking you yourself know not yourself. Even I see that in you accepting who you are, you are quite a good specimen. I mean, sellsword.}";
		bros[1].setPlaceInFormation(4);
		bros[1].setVeteranPerks(2);
		bros[1].m.Talents = [];
		talents = bros[1].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.Hitpoints] = 2;
		talents[this.Const.Attributes.Initiative] = 3;
		talents[this.Const.Attributes.MeleeSkill] = 1;
		items = bros[1].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Body));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));

		local armor = this.new("scripts/items/legend_armor/cloth/wanderers_coat");
		local cloak = this.new("scripts/items/legend_armor/cloak/legend_religious_scarf");
		armor.setUpgrade(cloak);
		items.equip(armor);

		local hood = this.new("scripts/items/legend_helmets/hood/legend_helmet_beak_hood");
		local top = this.new("scripts/items/legend_helmets/top/legend_helmet_mask_beak");
		local vanity = this.new("scripts/items/legend_helmets/vanity/legend_helmet_physicians_hood");
		hood.setUpgrade(top);
		hood.setUpgrade(vanity);
		items.equip(hood);



		items.equip(this.new("scripts/items/weapons/dagger"));
		bros[2].setStartValuesEx([
			"anatomist_background"
		]);
		bros[2].getBackground().m.RawDescription = "{Though our quotidian dialogues are no doubt drollery, beneath the banausic surface I must admit I feel a touch of serotinous savagery lurking within you, coming to the fore as if my words be fire. Even our most desultory talks has me on edge, the way you stare at me with such hateful eyes. Well, know this, bounty hunter, I am no casuist, I speak in earnest. You are too fine a specimen-I mean captain to be lofting some sapskull\'s brickbats at. Understand?}";
		bros[2].setPlaceInFormation(5);
		bros[2].setVeteranPerks(2);
		bros[2].m.Talents = [];
		talents = bros[2].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.Bravery] = 2;
		talents[this.Const.Attributes.MeleeDefense] = 3;
		talents[this.Const.Attributes.RangedDefense] = 3;
		items = bros[2].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Body));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));

		local armor = this.new("scripts/items/legend_armor/cloth/anatomist_robe");
		local cloak = this.new("scripts/items/legend_armor/cloak/anatomist_hood");
		armor.setUpgrade(cloak);
		items.equip(armor);

		local hood = this.new("scripts/items/legend_helmets/hood/legend_helmet_full_mask");
		local helm = this.new("scripts/items/legend_helmets/helm/legend_helmet_kettle_hat");
		hood.setUpgrade(helm);
		items.equip(hood);

		items.equip(this.new("scripts/items/weapons/militia_spear"));


		this.World.Assets.getStash().add(this.new("scripts/items/supplies/smoked_ham_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/mead_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/research_notes_beasts_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/research_notes_greenskins_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/research_notes_undead_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/research_notes_legendary_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/apotheosis_potion_item"));
		this.World.Statistics.getFlags().set("isNecromancerPotionAcquired", false);
		this.World.Statistics.getFlags().set("isWiedergangerPotionAcquired", false);
		this.World.Statistics.getFlags().set("isFallenHeroPotionAcquired", false);
		this.World.Statistics.getFlags().set("isGeistPotionAcquired", false);
		this.World.Statistics.getFlags().set("isRachegeistPotionAcquired", false);
		this.World.Statistics.getFlags().set("isSkeletonWarriorPotionAcquired", false);
		this.World.Statistics.getFlags().set("isHonorGuardPotionAcquired", false);
		this.World.Statistics.getFlags().set("isAncientPriestPotionAcquired", false);
		this.World.Statistics.getFlags().set("isNecrosavantPotionAcquired", false);
		this.World.Statistics.getFlags().set("isLorekeeperPotionAcquired", false);
		this.World.Statistics.getFlags().set("isOrcYoungPotionAcquired", false);
		this.World.Statistics.getFlags().set("isOrcWarriorPotionAcquired", false);
		this.World.Statistics.getFlags().set("isOrcBerserkerPotionAcquired", false);
		this.World.Statistics.getFlags().set("isOrcWarlordPotionAcquired", false);
		this.World.Statistics.getFlags().set("isGoblinGruntPotionAcquired", false);
		this.World.Statistics.getFlags().set("isGoblinOverseerPotionAcquired", false);
		this.World.Statistics.getFlags().set("isGoblinShamanPotionAcquired", false);
		this.World.Statistics.getFlags().set("isDirewolfPotionAcquired", false);
		this.World.Statistics.getFlags().set("isLindwurmPotionAcquired", false);
		this.World.Statistics.getFlags().set("isUnholdPotionAcquired", false);
		this.World.Statistics.getFlags().set("isWebknechtPotionAcquired", false);
		this.World.Statistics.getFlags().set("isNachzehrerPotionAcquired", false);
		this.World.Statistics.getFlags().set("isAlpPotionAcquired", false);
		this.World.Statistics.getFlags().set("isHexePotionAcquired", false);
		this.World.Statistics.getFlags().set("isSchratPotionAcquired", false);
		this.World.Statistics.getFlags().set("isSerpentPotionAcquired", false);
		this.World.Statistics.getFlags().set("isKrakenPotionAcquired", false);
		this.World.Statistics.getFlags().set("isIjirokPotionAcquired", false);
		this.World.Statistics.getFlags().set("isIfritPotionAcquired", false);
		this.World.Statistics.getFlags().set("isHyenaPotionAcquired", false);
		this.World.Assets.m.Money = this.World.Assets.m.Money + 700;
	}
});
