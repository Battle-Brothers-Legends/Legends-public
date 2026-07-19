::mods_hookExactClass("skills/backgrounds/crownling_background", function(o) {
	o.getTooltip = @() this.character_background.getTooltip();

	// TODO pronouns
	o.onBuildDescription = @() "{Uncommon in the south, %name% is a Crownling, a sword for hire. | Though not as common than their northern counterparts, the Crownlings of the south are no less eager for combat if the coin is right. %name% is one such mercenary. | %name% was once a dockworker, until one day he got into a fight with a Crownling and killed the man. The mercenary\'s captain hired him on the spot, and he\'s risen through death ever since. | Always drawing the wrong kind of attention to himself, %name% joined a passing Crownling band to avoid being branded indebted. | %name% is a consummate Crownling, a cutthroat killer ready to ply his trade for coin. | Crownlings are often looked down upon in the south, viewed as just another kind of slave, shackled by the pursuit of gold. %name%\'s own trail of blood and coin as a mercenary suggests he doesn\'t particularly care. | A former gladiator, %name% turned to mercenary work when he realized his career in the arena would be short. His long stint as a Crownling has proven much more successful and no less bloody. | Though often shunned in the south, Crownlings like %name% never go long without work.} {An expert with weapons both exotic and common, his skills have been tested by battle over and over again. | The man boasts he once negotiated a contract over breakfast, slaughtered per its terms before lunch, and used his pay to buy dinner. | Absentmindedly tending this piece of gear and that, he carries himself with the practiced efficiency of a seasoned warrior. | Though he claims to have an affinity for firearms and other exotic weapons, he\'s clearly no stranger to the shieldwall, either. | With practiced ease, the man recites how many men he\'s killed in the past month. He says he doesn\'t keep track of beasts. | From guarding caravans to manhunts to fighting professional soldiers, the man has seen it all.} {A loner at heart, %name% mostly keeps to himself but will occasionally share a tale from this campaign or that. | %name% keeps his own company in camp, having seen too many in his trade die already to grow attached. | %name% has seen bloody carnage and wanton destruction that would scar most men, but to him are just another day on the job. | While the prospect of combat brings out despair in some, it seems to be the only thing that elicits cheer from %name%. | Some passersby whisper that %name% is ensorcelled by an ifrit, and now carries their bloodlust in his heart. A raised eyebrow sends them scuttling off in fear.} {Murmuring some aphorism about the Gilder\'s gleam, he claps his hands together and inquires about pay. | He gives an easy smile with no emotion behind it, and sits down to discuss contract terms. | With the slightest of nods, he agrees to sign off if the pay is acceptable. | Though he claims he follows the Gilder\'s will, you know he\'ll tread any trail as long as it\'s paved with gold. | With a quick flourish of his weapon and a quicker prayer, he says he\'ll offer you a fair rate if you wish to hire him on.}";

	o.setGender <- function (_gender = -1) {
		if (_gender == -1)
			_gender = this.randomizeHumanGender();
		if (_gender != 1)
			return;

		this.m.GoodEnding = "%name% the crownling eventually left the %companyname% and started her own mercenary company. Last you heard, they\'re so highly regarded that the viziers keep them on retainer just to ensure no northern lord gains control of their services.";
		this.m.BadEnding = "%name% the crownling left the %companyname% and started her own competing company. The venture was cut short when a vizier decided the woman had a poor attitude and ordered them slain on the spot. She made it palace gates before a conscript ran her through.";

		this.m.Faces = ::Const.Faces.SouthernFemale;
		this.m.Hairs = ::Const.Hair.SouthernFemale;
		this.m.HairColors = ::Const.HairColors.SouthernYoung;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = ::Const.Bodies.SouthernFemale;
		this.m.Names = ::Const.Strings.SouthernFemaleNames;
		this.addBackgroundType(::Const.BackgroundType.Female);
	}

	local onAddEquipment = o.onAddEquipment;
	o.onAddEquipment = function () {
		onAddEquipment();
		local items = this.getContainer().getActor().getItems();

		local body = items.getItemAtSlot(::Const.ItemSlot.Body);
		if (body != null)
			items.unequip(body);
		items.equip(::Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Southern.linothorax],
			[1, ::Legends.Armor.Southern.stitched_nomad_armor],
			[2, ::Legends.Armor.Southern.southern_mail_shirt],
			[1, ::Legends.Armor.Southern.mail_and_lamellar_plating],
			[1, ::Legends.Armor.Standard.mail_hauberk]
		]));

		local head = items.getItemAtSlot(::Const.ItemSlot.Head);
		if (head != null)
			items.unequip(head);
		items.equip(::Const.World.Common.pickHelmet([
			[2, ::Legends.Helmet.Southern.wrapped_southern_helmet],
			[2, ::Legends.Helmet.Southern.spiked_skull_cap_with_mail],
			[1, ::Legends.Helmet.Southern.nomad_head_wrap],
			[1, ::Legends.Helmet.Southern.leather_head_wrap],
			[1, ::Legends.Helmet.None]
		]));
	}
});
