local gt = this.getroottable();
gt.Const.Serialization <- {
	Version = 47
};

if (!("LegendMod" in gt.Const))
{
	gt.Const.LegendMod <- {};
}

gt.Const.LegendMod.StartTypes <- {
    Default = "default",
    Beggar = "legends_beggar",
    Crusader = "legends_crusader",
    Rangers = "legends_hunter",
    Healer = "legends_healer",
    Berserker = "legends_beserker",
    Witch = "legends_witch",
    Necro = "legends_necro",
    Noble = "legends_noble",
    Inventor = "legends_inventor"
}

gt.Const.LegendMod.Starts <- [
    // {
    //     name = "Default",
    //     intro = "",
    //     description = "Default Battle Brothers Campaign",
    //     banner = gt.Const.LegendMod.StartTypes.Default
    // },
    {
        name = "Beggar",
        intro = "[img]gfx/ui/events/event_24.png[/img]Six crowns. A whole day and all you have for it is a paltry six crowns. Barely enough for a loaf of bread in this dung heap of a town. It wasn't but a month ago that you could solicit twenty or more from the passersby. But now they barely acknowledge you exist. You sigh as you amble through the narrow streets, heading toward your alley for the night. Thoughts of uncertainty drift into your head. You've seen a lot in the square. There, your hand is on the pulse of the town. You can tell when things aren't right, you see it in the way they all walk. Have they been walking differently? Your thoughts are cut short by clamoring pouring out the mouth of your alley. It must be some street hounds squabbling over some rotten scrap. Before you turn the corner, you hear words, yelling. Why is someone here? You picked this alleyway precisely because it's so remote. The noble is dead, his coins glinting... ",
        description = "Weak and poor, you start with only the rags on your back",
        banner = gt.Const.LegendMod.StartTypes.Beggar
    },
    {
        name = "Crusader",
        intro = "[img]gfx/ui/events/event_24.png[/img]The bishop had told you the world was dying due to the sins of man, that the end of days is upon us. The dark ones come and only the furious justice of peity can hold it back. Since then you have journeyed across the lands to find the root of the infection, to stem the tide of the plague. The more of the world you see, the worse it looks. The corruption is spreading, you've followed its tendrils back to its source, here in these lands you will find the cause. Your faith cannot falter, for you bear the torch into the yawning darkness. The day of reckoning approaches, you must finish your preparations",
        description = "A seasoned veteran on a righteous crusade",
        banner = gt.Const.LegendMod.StartTypes.Crusader
    },
    {
        name = "Ranger",
        intro = "[img]gfx/ui/events/event_24.png[/img]The council sent us out three months ago, in all directions from the grove. They wouldn't tell us what we were looking for exactly, only that we would know the signs of destruction when we saw them. For weeks we have followed the tracks and watched the skies. The birds are migrating the wrong direction. The rabbits only run one way down their bramble paths. The animals abandon their ranges, as is they know what is coming.  So you pushed on in the other direction, past deserted fields and burned homesteads, past rivers, lakes and mountains.  As you passed the last rise you paus, this is the place. These valleys have no deer, smoke hangs in the air and clings to the hills, the light is harsh and the air is bitter. Whatever is coming, it is coming from here. ",
        description = "Fleet footed ranger of the wild hunt",
        banner = gt.Const.LegendMod.StartTypes.Rangers
    },
    // {
    //     name = "Healer",
    //     intro = "[img]gfx/ui/events/event_24.png[/img]The college of surgeons kicked you out for your radical views. All those years of studying the delicate arts of trepanning, leeching and balancing the humors, and no qualification to show for it.  The old masters didn't like having their views challenged, but you'll show everyone the power of soap and hot water.",
    //     description = "A healer of men, alone in the wilderness",
    //     banner = gt.Const.LegendMod.StartTypes.Healer
    // },
    {
        name = "Seer",
        intro = "[img]gfx/ui/events/event_24.png[/img]The omens were in the stew, those giblets were roiling in the bubbles the way only a bad omen can. You tried to tell the farmers that the spirits had demanded a sacrifice, if only to reduce how many mouths there were to feed, but in the end they all blamed you when the crops failed. Its not your fault the gods are angry, there are bigger things at play here than your admidetly poor rain dancing, some daft fool has gone and poked their nose it that old deep magic. The wheel has turned, the cycles are in motion, there will be a lot more trouble in the world before the stars bode well again. In the meantime you might need to keep moving, you might not have a whole village bringing you sweet meat, but you made it out with enough coppers to at least find some apprentices to chop the wood and make tea",
        description = "Old, powerful and quite sleepy",
        banner = gt.Const.LegendMod.StartTypes.Witch
    },
    {
        name = "Warlock",
        intro = "[img]gfx/ui/events/event_24.png[/img]That last town was rough.. lets not talk about that place anymore. You stop and turn to the corpse beside you, your only companion. I told you to stop talking about that last town already, i know you miss your wife and family, but i told you there are much greater opportunities for you in the afterlife.  Your companion's head lolls slightly to the side as if rolling its eyes at you before finally the tattered neck flesh gives way, and sends the skull rolling off down the valley. Thats the problem with people these days, always giving up, no one seems to have the fortitude to handle whatever death throws at them. Time to hire some new assistants.  ",
        description = "Shunned by your village, you look to make a living with your dark art",
        banner = gt.Const.LegendMod.StartTypes.Necro
    },
    // {
    //     name = "Inventor",
    //     intro = "[img]gfx/ui/events/event_24.png[/img]This is an experimental work in progress",
    //     description = "Experimental acedemic",
    //     banner = gt.Const.LegendMod.StartTypes.Inventor
    // },
	//     {
    //     name = "Berserker",
    //     intro = "[img]gfx/ui/events/event_24.png[/img]Currently Unavailable",
    //     description = "Currently Unavailable",
    //     banner = gt.Const.LegendMod.StartTypes.Berserker
    // },
	{
        name = "Noble",
        description = "Rich and looking to make your family name known",
        intro = "[img]gfx/ui/events/event_24.png[/img]You were born to be a leader, raised in the company of the greatest men of our day. Somehow though, inheriting power doesn't feel as satisfying as seizing it for yourself. No, if one is to be king, it must be earned through battle and through the blood of one's subjects. Now, off to find some subjects willing to die for their betters",
        banner = gt.Const.LegendMod.StartTypes.Noble
    }
]


gt.Const.LegendMod.LookupMap <- {};

for( local i = 0; i < this.Const.LegendMod.Starts.len(); i = ++i )
{
    local start = this.Const.LegendMod.Starts[i];
    gt.Const.LegendMod.LookupMap[start.banner] <- start;
}

gt.Const.LegendMod.GetIntro <- function ( _id )
{
	if (_id != null && _id in this.Const.LegendMod.LookupMap)
	{
		return this.Const.LegendMod.LookupMap[_id].intro;
	}

	return "";
};
