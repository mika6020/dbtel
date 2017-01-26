local function pre_process(msg)
	local chkoperator = redis:hget('settings:operator',msg.chat_id_)
	if not chkoperator then
		redis:hset('settings:operator',msg.chat_id_,'off')
	end
end

local function run(msg, matches)
	--Commands --دستورات فعال و غیرفعال کردن فحش

	if matches[1]:lower() == 'unlock' then
		if matches[2]:lower() == 'operator' then
			if not is_mod(msg) then return end
			local operator = redis:hget('settings:operator',msg.chat_id_)
			if operator == 'on' then
				redis:hset('settings:operator',msg.chat_id_,'off')
				return ''
			elseif operator == 'off' then
				return ''
			end
		end
	end
	if matches[1]:lower() == 'lock' then
		if matches[2]:lower() == 'operator' then
			if not is_mod(msg) then return end
			local operator = redis:hget('settings:operator',msg.chat_id_)
			if operator == 'off' then
				redis:hset('settings:operator',msg.chat_id_,'on')
				return ''
			elseif operator == 'on' then
				return ''
			end
		end
	end

	--Delete words contains --حذف پیامهای فحش
	if not is_mod(msg) then
		local operator = redis:hget('settings:operator',msg.chat_id_)
		if operator == 'on' then
			tdcli.deleteMessages(msg.chat_id_, {[0] = msg.id_}, dl_cb, nil)
		end
	end
end

return {
  patterns = {

	"شارژ",
  "ایرانسل",
  "irancell",
  "ir-mci",
  "ir-mci",
  "نوترینو",
  "همراه اول",
  "رایتل",
  "تالیا",

	--Commands ##Don't change this##
	"^[!/#]([Ll][Oo][Cc][Kk]) (.*)$",
	"^[!/#]([Uu][Nn][Ll][Oo][Cc][Kk]) (.*)$",
	------------End----------------
  },
  run = run,
  pre_process = pre_process
}
