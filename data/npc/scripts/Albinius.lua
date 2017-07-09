local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local voices = {
	{ text = 'Walk in the light of Shaper wisdom!'},
	{ text = 'Welcome, my child.' },
	{ text = 'Our ways are the ways of the Shapers.' }
}

npcHandler:addModule(VoiceModule:new(voices))

local items = {
          item1 = {12437, 50731}, -- item1 e storage dado
          item2 = {19742, 50732}, -- item1 e storage dado
          item3 = {11213, 50733}, -- item1 e storage dado
          item4 = {2667, 50735}, -- item1 e storage dado
          item5 = {21246, 50736} -- item1 e storage dado
		 
}

local counts = {
          count1 = {50, 1}		 
}

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	local player = Player(cid)

       if msgcontains(msg, "shaper") then
				npcHandler:say({
				"The {Shapers} were an advanced civilisation, well versed in art, construction, language and exploration of our world in their time. ...",
				"The foundations of this temple are testament to their genius and advanced understanding of complex problems. They were master craftsmen and excelled in magic."
			}, cid)
			end

if msgcontains(msg, "tomes") then
	  npcHandler:say("I you have some old shaper tomes I would {buy} them.", cid)
end


	if msgcontains(msg, "temple") then
		npcHandler:say(" The temple has been restored to its former glory, yet we strife to live and praise in the {Shaper} ways. Do you still need me to take some old {tomes} from you my child?", cid)
		npcHandler.topic[cid] = 10
	elseif msgcontains(msg, "yes") and npcHandler.topic[cid] == 10 then
		if player:removeItem(26642,5) then
			player:setStorageValue(50730, 1)
			npcHandler:say("Thank you very much for your contributions, child. Your first step in the ways of the {Shapers} has been taken.", cid)
		else
			npcHandler:say("Oh, well I am sorry but without any {Shaper} wisdom to contribute to our community, there is not much you can do to help us. To support us, aquire some {tomes} the Shapers left behind.", cid)
		end
		npcHandler.topic[cid] = 0
	   end

          if msgcontains(msg, 'death portal') then
		  if player:getStorageValue(cid, items.item1[2]) <= 0 then 
                    if getPlayerItemCount(cid, items.item1[1]) >= counts.count1[1] then
                              doPlayerRemoveItem(cid, items.item1[1], counts.count1[1])
                              selfSay('Excellente! Now you can pass in the teleport.', cid)
							 player:setStorageValue(items.item1[2], counts.count1[2])
                    else
                              selfSay('You need '.. counts.count1[1] ..' '.. getItemName(items.item1[1]) ..'.', cid)
                    end
          elseif msgcontains(msg, 'ice portal') then
		  if player:getStorageValue(cid, items.item2[2]) <= 0 then 
                    if getPlayerItemCount(cid, items.item2[1]) >= counts.count1[1] then
                              doPlayerRemoveItem(cid, items.item2[1], counts.count1[1])
                              selfSay('Excellente! Now you can pass in the teleport.', cid)
							 player:setStorageValue(items.item2[2], counts.count1[2])
                    else
                              selfSay('You need '.. counts.count1[1] ..' '.. getItemName(items.item2[1]) ..'.', cid)
                    end
          elseif msgcontains(msg, 'earth portal') then
		  if player:getStorageValue(cid, items.item3[2]) <= 0 then 
                    if getPlayerItemCount(cid, items.item3[1]) >= counts.count1[1] then
                              doPlayerRemoveItem(cid, items.item3[1], counts.count1[1])
                              selfSay('Excellente! Now you can pass in the teleport.', cid)
							 player:setStorageValue(items.item3[2], counts.count1[2])
                    else
                              selfSay('You need '.. counts.count1[1] ..' '.. getItemName(items.item2[1]) ..'.', cid)
                    end
          elseif msgcontains(msg, 'holy portal') then
		  if player:getStorageValue(cid, items.item4[2]) <= 0 then 
                    if getPlayerItemCount(cid, items.item4[1]) >= counts.count1[1] then
                              doPlayerRemoveItem(cid, items.item4[1], counts.count1[1])
                              selfSay('Excellente! Now you can pass in the teleport.', cid)
							 player:setStorageValue(items.item4[2], counts.count1[2])
                    else
                              selfSay('You need '.. counts.count1[1] ..' '.. getItemName(items.item4[1]) ..'.', cid)
                    end
          elseif msgcontains(msg, 'energy portal') then
		  if player:getStorageValue(cid, items.item5[2]) <= 0 then 
                    if getPlayerItemCount(cid, items.item5[1]) >= counts.count1[1] then
                              doPlayerRemoveItem(cid, items.item5[1], counts.count1[1])
                              selfSay('Excellente! Now you can pass in the teleport.', cid)
							 player:setStorageValue(items.item5[2], counts.count1[2])
                    else
                              selfSay('You need '.. counts.count1[1] ..' '.. getItemName(items.item5[1]) ..'.', cid)
                    end
 				
					
          end
		  selfSay('You already have access to teleport.', cid)
          return TRUE
end	   
	   

end  
end
end
end
end


keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = "I find ways to unveil the secrets of the stars. Judging by this question, I doubt you follow my weekly publications concerning this research."})
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setMessage(MESSAGE_GREET, "Greetings, pilgrim. Welcome to the halls of hope. We are the keepers of this {temple} and welcome everyone willing to contribute.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Farewell, my child")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Farewell, my child")
npcHandler:addModule(FocusModule:new())