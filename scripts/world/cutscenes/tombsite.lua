return {
    grave_1 = function(cutscene, event)
        cutscene:text("* \"When you find all hopes have [color:yellow]left[color:white],[wait:5] you're not [color:yellow]right[color:white].\"")
    end,
    grave_2 = function(cutscene, event)
        cutscene:text("* Ania Jamm[wait:5]\n* 1999-2023")
        cutscene:text("* \"Always look [color:yellow]up[color:white].[wait:5] Your dreams are waiting.\"")
    end,
    grave_3 = function(cutscene, event)
        cutscene:text("* \"Life is designed to knock you [color:yellow]down[color:white].[wait:5] Just get back [color:yellow]up[color:white].\"")
    end,
    grave_4 = function(cutscene, event)
        cutscene:text("* \"I believe in doing the [color:yellow]right[color:white] things;[wait:5] not knocking others [color:yellow]down[color:white].\"")
    end,
    grave_5 = function(cutscene, event)
        cutscene:text("* \"Our greatest weakness lies in giving [color:yellow]up[color:white].\"")
    end,
	-- left, right, up, down, up, right, down, up
	
	fake_jamm = function(cutscene,event)
		local jamm = cutscene:getCharacter("fake_jamm")
		
		cutscene:showNametag("???")
		cutscene:text("* Oh,[wait:5] Ania...", "shaded_neutral", "jamm")
		
		if cutscene:getCharacter("hero") then
			cutscene:showNametag("Hero")
			cutscene:text("* Would you happen to be Jamm?", "neutral_closed", "hero")
		elseif cutscene:getCharacter("susie") then
			cutscene:showNametag("Susie")
			cutscene:text("* Hey,[wait:5] are you, by any chance,[wait:5] named \"Jamm\"?", "nervous", "susie")
		elseif Game:isDessMode() or cutscene:getCharacter("dess") then
			cutscene:showNametag("Dess")
			cutscene:text("* ermmmm you're jamm right?", "condescending", "dess")
		else
			cutscene:hideNametag()
			cutscene:text("* You ask the person if his name is Jamm.")
		end
		
		cutscene:look(jamm, "down")
		
		cutscene:showNametag("Jamm")
		cutscene:text("* Yeah,[wait:5] who's asking?", "shaded_neutral", "jamm")
		
		if cutscene:getCharacter("susie") then
			cutscene:showNametag("Susie")
			cutscene:text("* Some kid asked us to find you for her.", "neutral", "susie")
		elseif cutscene:getCharacter("hero") then
			cutscene:showNametag("Hero")
			cutscene:text("* Your daughter wanted us to find you.", "neutral_closed", "hero")
		elseif Game:isDessMode() or cutscene:getCharacter("dess") then
			cutscene:showNametag("Dess")
			cutscene:text("* mini-jamm is looking for you", "calm", "dess")
		else
			cutscene:hideNametag()
			cutscene:text("* You tell Jamm that Marcy sent you to look for him.")
		end
		
		cutscene:showNametag("Jamm")
		cutscene:text("* Ah,[wait:5] I see...[wait:10]\n* I didn't mean to make her worry...", "shaded_neutral", "jamm")
		cutscene:text("* I just needed to visit my wife again.", "shaded_neutral", "jamm")
		
		if cutscene:getCharacter("hero") and Game:getPartyMember("hero"):getFlag("karma") <= -15 then
			cutscene:showNametag("Hero")
			cutscene:text("* Don't keep your daughter waiting.", "annoyed", "hero")
			if cutscene:getCharacter("susie") then
				cutscene:showNametag("Susie")
				cutscene:text("* Hero,[wait:5] let the man grieve.", "annoyed", "susie")
				cutscene:text("* But anyways,[wait:5] maybe spending time with your daughter would help?", "neutral", "susie")
			else
				cutscene:showNametag("Jamm")
				cutscene:text("* ...", "shaded_neutral", "jamm")
				cutscene:text("* Alright,[wait:5] I won't.", "shaded_neutral", "jamm")
				cutscene:hideNametag()
				cutscene:text("* You tell Jamm to try to spend some time with Marcy.")
			end
		elseif cutscene:getCharacter("susie") then
			cutscene:showNametag("Susie")
			cutscene:text("* Maybe spending time with your daughter would help?", "neutral", "susie")
		elseif Game:isDessMode() or cutscene:getCharacter("dess") then
			cutscene:showNametag("Dess")
			cutscene:text("* uhhh okay", "neutral_c", "dess")
			cutscene:text("* im gonna go pilfer the diner for roobeer if you wanna join", "condescending", "dess")
		else
			cutscene:hideNametag()
			cutscene:text("* You tell Jamm to try to spend some time with Marcy.")
		end
		
		cutscene:showNametag("Jamm")
		cutscene:text("* I mean,[wait:5] yeah,[wait:5] I guess that would help.", "shaded_neutral", "jamm")
		cutscene:hideNametag()
		
		jamm:convertToFollower(#Game.party, true)
		cutscene:interpolateFollowers()
		cutscene:wait(cutscene:attachFollowers(4))
		
		Game:setFlag("fake_jamm", true)
		
		if Game:isDessMode() then
			cutscene:showNametag("Dess")
			cutscene:text("* i see no way this will backfire within the next few minutes", "heckyeah", "dess")
		end
		cutscene:showNametag("Jamm")
		cutscene:text("* I read an inscription about the crossroads...", "shaded_neutral", "jamm")
		cutscene:text("* It said to work from left to right on the gravestones...", "shaded_neutral", "jamm")
		cutscene:text("* ... and to make note of every direction on them.", "shaded_neutral", "jamm")
		cutscene:hideNametag()
		
		Game:setFlag("acj_quest_prog", 1)
	end,
	transition_1 = function(cutscene, event)
		Game.world:mapTransition("fwood/graves", "entry")
	end,
	transition_2 = function(cutscene, event)
		if Game:getFlag("fake_jamm", false) then
			Game.world:mapTransition("fwood/cross", "up")
		else
			Game.world:mapTransition("fwood/entry", "exit")
		end
	end,
	up = function(cutscene, event)
		local has_value = function (tab, val)
			for index, value in ipairs(tab) do
				if value == val then
					return true
				end
			end

			return false
		end
		
		if has_value({2,4,7},Game:getFlag("jamm_cross")) then
			if Game:getFlag("jamm_cross") == 7 then
				Game.world:mapTransition("fwood/boss", "top")
				Game:setFlag("jamm_cross", 0)
			else
				Game.world:mapTransition("fwood/cross", "down")
				Game:addFlag("jamm_cross", 1)
			end
		elseif Game:getFlag("jamm_cross_2") == 3 then
			Game.world:mapTransition("fwood/dungeon", "entry")
			Game:setFlag("jamm_cross", 0)
			Game:setFlag("jamm_cross_2", 0)
        else
            Game.world:mapTransition("fwood/graves", "entry")
			Assets.playSound("error", 1, 1)
			Game:setFlag("jamm_cross", 0)
			Game:setFlag("jamm_cross_2", 0)
                
        end
	end,
	down = function(cutscene, event)
		local has_value = function (tab, val)
			for index, value in ipairs(tab) do
				if value == val then
					return true
				end
			end

			return false
		end
		
		if has_value({3,6},Game:getFlag("jamm_cross")) then
            Game.world:mapTransition("fwood/cross", "up")
			Game:addFlag("jamm_cross", 1)
		elseif Game:getFlag("jamm_cross_2") == 1 then
            Game.world:mapTransition("fwood/cross", "up")
			Game:setFlag("jamm_cross", 0)
			Game:addFlag("jamm_cross_2", 1)
        else
            Game.world:mapTransition("fwood/graves", "entry")
			Assets.playSound("error", 1, 1)
			Game:setFlag("jamm_cross", 0)
			Game:setFlag("jamm_cross_2", 0)
        end
	end,
	left = function(cutscene, event)
		if Game:getFlag("jamm_cross", 0) < 1 then
            Game.world:mapTransition("fwood/cross", "right")
			Game:addFlag("jamm_cross", 1)
			Game:addFlag("jamm_cross_2", 1)
        else
            Game.world:mapTransition("fwood/graves", "entry")
			Assets.playSound("error", 1, 1)
			Game:setFlag("jamm_cross", 0)
			Game:setFlag("jamm_cross_2", 0)
        end
	end,
	right = function(cutscene, event)
		local has_value = function (tab, val)
			for index, value in ipairs(tab) do
				if value == val then
					return true
				end
			end

			return false
		end
		
		if has_value({1,5},Game:getFlag("jamm_cross")) then
            Game.world:mapTransition("fwood/cross", "left")
			Game:addFlag("jamm_cross", 1)
		elseif Game:getFlag("jamm_cross_2") == 2 then
            Game.world:mapTransition("fwood/cross", "left")
			Game:setFlag("jamm_cross", 0)
			Game:addFlag("jamm_cross_2", 1)
        else
            Game.world:mapTransition("fwood/graves", "entry")
			Game:setFlag("jamm_cross", 0)
			Game:setFlag("jamm_cross_2", 0)
			Assets.playSound("error", 1, 1)
        end
	end,
	
	final_jamm = function(cutscene,event)
		local fake_jamm = cutscene:getCharacter("fake_jamm"):convertToNPC()
		Game:removeFollower(fake_jamm)
		local jamm = cutscene:getCharacter("jamm")
		local susie = cutscene:getCharacter("susie")
		local noel = cutscene:getCharacter("noel")
		
		local members = {}
		for _, member in ipairs(Game.party) do
			table.insert(members, cutscene:getCharacter(member.id))
		end
		local leader = members[1]
		cutscene:wait(cutscene:walkToSpeed(leader, "party", 4))
		
		if Game:getFlag("fwoods_desscut") then
			cutscene:showNametag("Jamm")
			cutscene:text("* ...", "shaded_frown", "jamm")
			cutscene:text("* That's one way to exit the forest,[wait:5] I guess.", "shaded_neutral", "jamm")
			cutscene:text("* Anyways...", "shaded_neutral", "jamm")
			cutscene:hideNametag()
		else
			cutscene:showNametag("Jamm")
			cutscene:text("* Good job at making it out of the bulk of the forest.", "shaded_pissed", "jamm")
			cutscene:text("* I should've known the solution was on the gravestones.", "shaded_neutral", "jamm")
			cutscene:text("* However...", "shaded_neutral", "jamm")
			cutscene:hideNametag()
		end
		
		cutscene:detachFollowers()
		cutscene:wait(cutscene:walkToSpeed(fake_jamm, "jamm", 4))
		cutscene:showNametag("Jamm?")
		cutscene:text("* I can't let you pass alive.", "shaded_revealed", "jamm")
		cutscene:hideNametag()

		if Game:isDessMode() then
			cutscene:showNametag("Dess")
			cutscene:text("* oh you have got to be", "angry", "dess", {auto = true})
			cutscene:hideNametag()
		end
		
		cutscene:setAnimation(fake_jamm, "attack")
		cutscene:wait(1/15)
		
		cutscene:setAnimation(leader, "battle/defeat")
                leader:shake(10, 10)
		Assets.playSound("hurt", 1, 1)
		
		cutscene:wait(cutscene:slideTo(leader, "party_1", 1, "out-cubic"))
		
		cutscene:showNametag("Jamm?")
		cutscene:text("* Do you see how easy it was to knock you down?", "shaded_revealed", "jamm")
		cutscene:text("* It will be even easier to break you entirely.", "shaded_revealed", "jamm")
		cutscene:text("* So then,[wait:5] how will this go?", "shaded_revealed", "jamm")
		cutscene:hideNametag()
		
		local party_walk_wait = nil
		for i, member in ipairs(members) do
			party_walk_wait = cutscene:walkTo(member, "party_" .. i, 0.5)
		end
		cutscene:wait(party_walk_wait)
		
		for i, member in ipairs(members) do
			cutscene:setAnimation(member, "battle/attack")
		end
		Assets.playSound("laz_c", 1, 1)
		
		cutscene:wait(1)
		if Game:isDessMode() then
			cutscene:showNametag("Dess")
			cutscene:text("* im gonna break your fucking kneecaps,[wait:5] dipshit", "angry", "dess")
			cutscene:hideNametag()
		end
		
		cutscene:look(fake_jamm, "left")
		cutscene:resetSprite(fake_jamm)
		
		cutscene:showNametag("Jamm?")
		cutscene:text("* The hard way,[wait:5] huh?", "shaded_revealed", "jamm")
		cutscene:hideNametag()
		
		cutscene:wait(cutscene:walkToSpeed(fake_jamm, "fake_jamm", 4, "left"))
		cutscene:setAnimation(fake_jamm, "idle")
		
		cutscene:showNametag("Jamm?")
		cutscene:text("* You're just making this more fun for me!", "shaded_revealed", "jamm")
		cutscene:hideNametag()
		
		cutscene:startEncounter("fake_jamm", false, {{"fake_jamm", fake_jamm}})

		cutscene:wait(1)
		
		cutscene:showNametag("Jamm?")
		cutscene:text("* Pathetic.", "shaded_revealed", "jamm")
		cutscene:text("* Well,[wait:5] it's time to--", "shaded_revealed", "jamm", {auto = true})
		if Game:hasPartyMember("hero") and (Game:getPartyMember("hero"):getWeapon().id == "chosen_blade" or Game:getPartyMember("hero"):getWeapon().id == "chosen_axe") then
			cutscene:hideNametag()
			local hero = cutscene:getCharacter("hero")
			hero:shake(5)
			Assets.stopAndPlaySound("wing")
			Game.world.music:fade(0, 1)
			cutscene:wait(2)
			cutscene:showNametag("Jamm?")
		    cutscene:text("* What?", "shaded_desperate", "jamm")
			cutscene:showNametag("Hero")
		    cutscene:text("* If...", "shade", "hero")
			cutscene:hideNametag()
			hero:shake(5)
			Assets.stopAndPlaySound("wing")
			hero:setAnimation("battle/defeat")
			cutscene:wait(1)
			cutscene:showNametag("Hero")
		    cutscene:text("* If you think you can take me out that easily...", "shade", "hero")
			cutscene:hideNametag()
			hero:shake(5)
			Assets.stopAndPlaySound("wing")
			hero:setAnimation("battle/idle")
			cutscene:wait(1)
			cutscene:showNametag("Hero")
		    cutscene:text("* You've got another thing coming....", "shade_pissed", "hero")
			cutscene:showNametag("Jamm?")
		    cutscene:text("* Oh,[wait:5] how cute.", "shaded_smile", "jamm")
			cutscene:hideNametag()
			cutscene:setAnimation(fake_jamm, "attack")
			cutscene:wait(1/15)
			Assets.playSound("hurt", 1, 1)
			hero:setAnimation("battle/swooned")
			hero:shake(10, 10)
			Game.world.music:fade(1, 1)
			cutscene:wait(1)
			cutscene:showNametag("Jamm?")
			cutscene:text("* Anyways,[wait:5] as I was saying--", "shaded_revealed", "jamm", {auto = true})
		end
		
		cutscene:showNametag("???")
		cutscene:text("* Hold it!", nil, "jamm")
		cutscene:hideNametag()
		
		cutscene:wait(cutscene:walkToSpeed(jamm, "jamm", 8, "right"))
		
		cutscene:showNametag("Jamm")
		cutscene:text("* Well,[wait:5] Enzio.[wait:10]\n* Never thought you'd stoop this low.", "smirk", "jamm")
		cutscene:text("* Stealing my Root account,[wait:5] sure.[wait:10]\n* But impersonation?", "smirk", "jamm")
		
        if noel_null then
            if not noel_hit == 55 then
		        cutscene:showNametag("Noel")
                cutscene:text("* Ah[wait:5] yes,[wait:5] [speed:0.5][color:yellow]Enzio[color:white][speed:1][wait:5] I remember [speed:0.5][color:yellow]Enzio[color:white][speed:1][wait:5].", "bruh", "noel")
                cutscene:text("* I am totally not completely lost at all.", "huh", "noel")
                cutscene:text("* [speed:0.5][color:yellow]Enzio[color:white][speed:1][wait:5] was the clown my cat hired for m'eye birthday.", "huh", "noel")
                cutscene:text("* (Who the hell is [speed:0.5][color:yellow]Enzio[color:white][speed:1][wait:5]???)", "oh", "noel")
            end
        end

		cutscene:showNametag("Enzio")
		cutscene:text("* How did you escape!?", "shaded_desperate", "jamm")
		
		cutscene:showNametag("Jamm")
		cutscene:text("* Does it matter?[wait:10]\n* All that matters is you're done.", "smirk", "jamm")
		
		cutscene:resetSprite(fake_jamm)
		
		cutscene:showNametag("Enzio")
		cutscene:text("* Tch...[wait:10]\n* This whole thing is inconsequential.", "shaded_neutral", "jamm")
		cutscene:text("* We'll meet again,[wait:5] Jamm.", "shaded_neutral", "jamm")
		cutscene:hideNametag()
		
		cutscene:wait(cutscene:fadeOut(0.75))
		fake_jamm:remove()
		cutscene:wait(cutscene:fadeIn(0.75))
		
		cutscene:showNametag("Jamm")
		cutscene:text("* I'm sure we will,[wait:5] jerk...", "stern", "jamm")
		cutscene:look(jamm, "left")
		cutscene:text("* You okay?", "worried", "jamm")
		cutscene:hideNametag()
		
		for i, member in ipairs(members) do
			cutscene:resetSprite(member)
			cutscene:look(member, "right")
			Assets.stopAndPlaySound("noise")
			cutscene:wait(0.75)
		end

		if Game:isDessMode() then
			cutscene:showNametag("Jamm")
			cutscene:text("* Oh,[wait:5] it's you.", "suspicious", "jamm")
			cutscene:showNametag("Dess")
			cutscene:text("* ay thanks for saving my bacon there pal", "wink", "dess")
			cutscene:showNametag("Jamm")
			cutscene:text("* ... Right.", "suspicious", "jamm")
		elseif susie then
			cutscene:showNametag("Susie")
			cutscene:text("[voice:susie]* What the hell was that!?", "angry", "susie")
			cutscene:showNametag("Jamm")
			cutscene:text("* It was some petty rivalry.", "nervous", "jamm")
			cutscene:text("* Sorry that you were involved.", "look_left", "jamm")
		else
			cutscene:showNametag("Jamm")
			cutscene:text("* Phew,[wait:5] you're alright...", "nervous", "jamm")
			cutscene:text("* Sorry that you were involved in all this..", "look_left", "jamm")
		end

		if noel then
			cutscene:showNametag("Noel")
			cutscene:text("* I don't accept your apology but thank you anyway lego man.", "bruh", "noel")
		end
		
		if Game:isDessMode() then
			cutscene:text("* I'm just gonna...", "stern", "jamm")
			cutscene:text("* Head out now.", "suspicious", "jamm")
			cutscene:hideNametag()
			
			cutscene:wait(cutscene:fadeOut(0.75))
			jamm:remove()
			cutscene:wait(cutscene:fadeIn(0.75))
		
			cutscene:attachFollowers()
			cutscene:wait(2)
			cutscene:showNametag("Dess")
			cutscene:text("* well ermmm THAT just happened", "condescending", "dess")
			cutscene:hideNametag()
		else
			cutscene:showNametag("Jamm")
			cutscene:text("* Thanks for being a distraction for Enzio,[wait:5] by the way.", "neutral", "jamm")
			cutscene:text("* I overheard that Marcy was looking for me,[wait:5] right?", "neutral", "jamm")
			cutscene:text("* Meet me at my apartment later,[wait:5] alright?", "neutral", "jamm")
			cutscene:text("* I'll thank you properly then.", "neutral", "jamm")
			cutscene:hideNametag()
			
			cutscene:wait(cutscene:fadeOut(0.75))
			jamm:remove()
			cutscene:wait(cutscene:fadeIn(0.75))
		
			cutscene:attachFollowers()
			cutscene:wait(2)
			Game:setFlag("jamm_waiting", true)
		end
		Game:setFlag("acj_quest_prog", 2)
	end,
	door = function(cutscene, event)
		local jamm = cutscene:getCharacter("jamm")
		local dess = cutscene:getCharacter("dess")
		
		if Game:getFlag("video_jamm_watched") then
			if jamm then
				if Game:getFlag("jamm_closure") then
					cutscene:showNametag("Jamm")
					cutscene:text("* Never again.", "neutral", "jamm")
				elseif dess then
					local x,y = event:getRelativePos()
					cutscene:detachCamera()
					cutscene:detachFollowers()
					cutscene:walkTo(Game.world.player, x + 20, y + 150, 0.75, "up")
					for i, v in ipairs(Game.world.followers) do
                        local transformed_x = (i+1 - 1) % 2
                        local transformed_y = math.floor((i+1 - 1) / 2)

                        -- Transform the grid into coordinates
                        local offset_x = transformed_x * 120
                        local offset_y = transformed_y * 40
                        cutscene:walkTo(v, offset_x + x + 20, offset_y + y + 150, 0.75, "up")
					end
					cutscene:showNametag("Jamm")
					cutscene:text("* I can give it a shot.", "smile", "jamm")
					cutscene:hideNametag()
					cutscene:wait(cutscene:walkTo(jamm, x + 20, y + 80, 0.75, "up"))
					cutscene:showNametag("Dess")
					cutscene:text("* opening a door with your mind is definitely possible", "condescending", "dess")
					cutscene:showNametag("Jamm")
					cutscene:text("* Oh, you have no idea, Dess.", "smirk", "jamm")
					cutscene:showNametag("Dess")
					cutscene:text("* okay", "condescending", "dess")
					cutscene:hideNametag()
					cutscene:wait(cutscene:walkTo(dess, x + 80, y + 80, 0.75, "up"))
					
					local layer = Game.world.map:getTileLayer("door_closed")
					layer.visible = false
					Assets.playSound("noise")
					
					cutscene:wait(1)
					cutscene:look(jamm, "right")
					cutscene:look(dess, "left")
					cutscene:showNametag("Jamm")
					cutscene:text("* ...So I guess it's you and me, huh?", "stern", "jamm")
					cutscene:showNametag("Dess")
					cutscene:text("* are you asking me out?", "condescending", "dess")
					cutscene:showNametag("Jamm")
					cutscene:text("* Hell no.\n* Let's just go in already.", "stern", "jamm")
					cutscene:hideNametag()
					cutscene:look(jamm, "up")
					cutscene:look(dess, "up")
					
					cutscene:wait(cutscene:fadeOut(0.75))
					for k,chara in ipairs(Game.party) do
						Game:setFlag(chara.id .. "_party", false)
					end
					Game.party = {}
					Game:addPartyMember("jamm")
					Game:addPartyMember("dess")
					Game:setFlag("jamm_party", true)
					Game:setFlag("dess_party", true)
					Assets.playSound("impact")
					cutscene:wait(1)
					cutscene:loadMap("fwood/dungeon_inside/entrance", "entry", "up")
					
					cutscene:wait(cutscene:fadeIn(0.75))
					
					cutscene:showNametag("Dess")
					cutscene:text("* hey Jamm, the door locked behind us.", "condescending", "dess")
					cutscene:showNametag("Jamm")
					cutscene:text("* ...That makes this a lot worse.", "nervous", "jamm")
					cutscene:hideNametag()
					local jamm_party = Game:getPartyMember("jamm")
					jamm_party.has_act = true
					Game:setFlag("jamm_canact", true)
					cutscene:text("* Jamm can now use ACTs!")
				else
					cutscene:showNametag("Jamm")
					cutscene:text("* Well, this is the door Ania mentioned.", "smile", "jamm")
					cutscene:text("* She said she's been working on this a lot, but...", "neutral", "jamm")
					cutscene:text("* She told me I need help from [color:yellow]a certain person[color:white].", "neutral", "jamm")
				end
			else
				cutscene:text("* It's a door.\n* It doesn't seem to budge.")
			end
		else
			if jamm then
				cutscene:showNametag("Jamm")
				cutscene:text("* ...Not yet.", "shaded_frown", "jamm")
			else
				cutscene:text("* It's a door.\n* It doesn't seem to budge.")
				if Game:isDessMode() and Game:getFlag("acj_quest_prog") >= 2 then
					cutscene:showNametag("Dess")
					cutscene:text("* lemme try", "calm_b", "dess")
					cutscene:text("* open [wait:5]seasame", "angry", "dess")
					cutscene:hideNametag()
					cutscene:wait(5)
					cutscene:showNametag("Dess")
					cutscene:text("* ...", "angry", "dess")
					cutscene:text("[noskip]* well i've tried all i could do", "neutral_c", "dess", {auto = true})
					cutscene:hideNametag()
					local layer = Game.world.map:getTileLayer("door_closed")
					layer.visible = false
					Assets.playSound("screenshake")
						
					cutscene:wait(1)
					cutscene:showNametag("Dess")
					cutscene:text("* ...", "wtf_b", "dess")
					cutscene:text("* aw yeah", "smug", "dess")
					if Game:getFlag("can_kill") then
						cutscene:text("* wait dont the enemies here not give you any exp", "angry", "dess")
						cutscene:text("* hold on unless...", "neutral_c", "dess")
						cutscene:text("* yo god my homeslice breadslice dawg", "condescending", "dess")
						cutscene:text("* theres a bunch of unholy beasts in this dungeon", "dess.exe", "dess")
						cutscene:text("* can you give me the power to smite them straight to hell?", "calm_b", "dess")
						cutscene:hideNametag()
						dess:flash()
						Assets.playSound("boost")
						cutscene:wait(1)
						cutscene:showNametag("Dess")
						cutscene:text("* ay thanks g", "swag", "dess")
					end
					cutscene:text("* ok time to go in", "smug", "dess")
					cutscene:hideNametag()

					cutscene:wait(cutscene:fadeOut(0.75))
					Assets.playSound("impact")
					cutscene:wait(1)
					cutscene:loadMap("fwood/dungeon_inside/entrance", "entry", "up")
					
					cutscene:wait(cutscene:fadeIn(0.75))
					
					cutscene:showNametag("Dess")
					cutscene:text("* oh,[wait:5] the door locked behind me.", "reverse", "dess")
					cutscene:text("* im not trapped here with these shades", "doom", "dess")
					cutscene:text("* these shades are trapped in here with me", "doom_shiteatinggrin", "dess")
					cutscene:hideNametag()
				end
			end
		end
		cutscene:hideNametag()
	end,
	
	jamm_dlc = function(cutscene)
        -- no need to check for dpr_main, it's bundled
		
		local has_dess = cutscene:getCharacter("dess") ~= nil
		cutscene:text("* Your "
			.. (has_dess and "desstination" or "destination")
			.." is "
			..(has_dess and "in another castle" or "infinitely far away")
			..".\n* Leave this "
			.. (has_dess and "Dark " or "")
			.."Place?")
		local enter = cutscene:choicer({"Yes", "No"})

		if enter == 1 then
			cutscene:after(Game:swapIntoMod("dpr_main", true, "deoxtest", "jamm"))
		else
			cutscene:text("* You travelen't.")
			cutscene:wait(cutscene:walkTo(Game.world.player, Game.world.player.x, Game.world.player.y - 20))
		end
    end,
}
