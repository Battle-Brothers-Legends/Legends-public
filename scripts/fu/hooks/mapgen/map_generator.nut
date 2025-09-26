::mods_hookExactClass("mapgen/map_generator", function(o)
{
    local registerTemplates = o.registerTemplates;
    o.registerTemplates = function()
    {
        local templateScripts = this.IO.enumerateFiles("scripts/mapgen/templates/");
        foreach (i, templateScript in templateScripts)
        {
            local inst = null;
            try { inst = this.new(templateScript); } catch (e) { inst = null; }
            if (inst == null) continue;

            // Mirror vanilla: attempt init + register; rely on inheritance for getName()
            try
            {
                inst.init();
                this.m.Templates[inst.getName()] <- inst;
            }
            catch (e)
            {
                // Non-fatal: skip templates that fail to init
            }
        }
    }
});
