local function pre_process(msg)
	local chken = redis:hget('settings:en',msg.chat_id_)
	if not chken then
		redis:hset('settings:en',msg.chat_id_,'off')
	end
end

local function run(msg, matches)
	--Commands --دستورات فعال و غیرفعال کردن فحش

	if matches[1]:lower() == 'unlock' then
		if matches[2]:lower() == 'en' then
			if not is_mod(msg) then return end
			local en = redis:hget('settings:en',msg.chat_id_)
			if en == 'on' then
				redis:hset('settings:en',msg.chat_id_,'off')
				return ''
			elseif en == 'off' then
				return ''
			end
		end
	end
	if matches[1]:lower() == 'lock' then
		if matches[2]:lower() == 'en' then
			if not is_mod(msg) then return end
			local en = redis:hget('settings:en',msg.chat_id_)
			if en == 'off' then
				redis:hset('settings:en',msg.chat_id_,'on')
				return ''
			elseif en == 'on' then
				return ''
			end
		end
	end

	--Delete words contains --حذف پیامهای فحش
	if not is_mod(msg) then
		local en = redis:hget('settings:en',msg.chat_id_)
		if en == 'on' then
			tdcli.deleteMessages(msg.chat_id_, {[0] = msg.id_}, dl_cb, nil)
			send_large_msg(chat, 'انگلیسی ممنوعه😐✋')
		end
	end
end

return {
  patterns = {

	"[Aa](.*)",
	"[Bb](.*)",
	"[Cc](.*)",
	"[Dd](.*)",
	"[Ee](.*)",
	"[Ff](.*)",
	"[Gg](.*)",
	"[Hh](.*)",
	"[Ii](.*)",
	"[Jj](.*)",
	"[Kk](.*)",
	"[Ll](.*)",
	"[Mm](.*)",
	"[Nn](.*)",
	"[Oo](.*)",
	"[Pp](.*)",
	"[Qq](.*)",
	"[Rr](.*)",
	"[Ss](.*)",
	"[Tt](.*)",
	"[Uu](.*)",
	"[Vv](.*)",
	"[Ww](.*)",
	"[Xx](.*)",
	"[Yy](.*)",
	"[Zz](.*)",

	--Commands ##Don't change this##
	"^[!/#]([Ll][Oo][Cc][Kk]) (.*)$",
	"^[!/#]([Uu][Nn][Ll][Oo][Cc][Kk]) (.*)$",
	------------End----------------
  },
  run = run,
  pre_process = pre_process
}
