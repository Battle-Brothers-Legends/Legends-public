// FU: Add a [def] BBCode tag for nested tooltips
// New format: [def=scripts/skills/effects/legend_baffled_effect]baffled[/def]
// Pass a path to a .nut (without or with .nut extension). We will query the backend
// to fetch title/description from that script (m.Description, getDescription(), etc.).

(function(){
  if (typeof XBBCODE === 'undefined' || typeof XBBCODE.addTags !== 'function') return;

  XBBCODE.addTags({
    def: {
      openTag: function(params, content) {
        // Parameter form: =scripts/skills/.../foo_effect[.nut]
        var raw = '';
        if (params && params.length > 0) {
          // params like "=Legends.Status.Baffled"
          raw = params[0].substr(1); // remove '='
        }
        var path = raw || '';
        // Escape attributes minimally
        var esc = function(s){ return ('' + s).replace(/"/g, '&quot;').replace(/</g,'&lt;').replace(/>/g,'&gt;'); };
        return '<span class="fu-nested-tooltip" style="text-decoration: underline; cursor: help;" data-fu-path="' + esc(path) + '">';
      },
      closeTag: function(params, content) {
        return '</span>';
      },
      noParse: false
    }
  });
})();
