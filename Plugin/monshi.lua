local function a(b,c)if c[1]=="monshi"and is_sudo(b)then if c[2]=="on"then redis:set("monshi:bot", true)return "Monshi bot > on" end if c[2]=="off"then redis:del("monshi:bot")return "Monshi bot > off" end end if b.to.type =="user"and redis:get("monshi:bot")and not is_sudo(b)then return "this is bot\nhafez is offline" end end;return{patterns={"^[!/#](monshi) (on)$","^[!/#](monshi) (off)$","^(.*)$"},run=a}