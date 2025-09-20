::mods_hookExactClass("skills/backgrounds/butcher_background", function(o)
{
    if (!("getTooltip" in o))
    {
        o.getTooltip <- function()
        {
            // Fallback to base background tooltip to satisfy hooks expecting this member
            return this.character_background.getTooltip();
        }
    }
});

