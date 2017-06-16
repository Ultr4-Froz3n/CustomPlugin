--[[ 
در صورت کپی از محتوا منبع را ذکر کنید
@alireza_PT
@CliApi
@Create_antispam_bot 
--]]
 local function pre_process(msg) 
  local alirezapt = msg['id']
  local user = msg.from.id
  local chat = msg.to.id
  local hash = 'mate:'..chat..':'..user
  if msg.media and not is_momod(msg) then
    if redis:get(hash) and msg.media and not is_momod(msg) then 
      delete_msg(msg.id, ok_cb, false) 
      redis:del(hash) 
      kick_user(user, chat)
    else
      local text = "کاربر ["..msg.from.first_name.."] از ارسال مدیا(عکس/فیلم/صدا و...) خودداری کنید( @create_antispam_bot )\nدر صورت تکرار از گروه حذف خواهید شد( @create_antispam_bot )" 
      reply_msg(alirezapt, text, ok_cb, true) 
      redis:set(hash, true)
    end
  end
  return  msg
end
       

local function run(msg, matches) 
  local alirezapt = msg['id'] 
  if matches[1] == 'warn media' then
    if is_momod(msg) then 
      local hash = 'mate:'..msg.to.id 
      redis:set(hash, true) 
      local text = ' فعال شد\nهم اکنون کاربر پس از ارسال مدیا اخطار دریافت میکند( @create_antispam_bot )'
      reply_msg(alirezapt, text, ok_cb, true) 
    else 
      local text = 'شما دسترسی ندارید ( @create_antispam_bot )' 
      reply_msg(alirezapt, text, ok_cb, true) 
    end
  end
  if matches[1] == 'unwarn media' then
    if is_momod(msg) then 
      local hash = 'mate:'..msg.to.id 
      redis:del(hash) 
      local text = ' فعال شد\nارسال مدیا مجاز شد!( @create_antispam_bot )'
      reply_msg(alirezapt, text, ok_cb, true) 
    else
      local text = 'شما دسترسی ندارید ( @create_antispam_bot )' 
      reply_msg(alirezapt, text, ok_cb, true) 
    end 
  end 
end
return { 
    patterns = {
"^[#!/](warn media)$",
"^[#!/](unwarn media)$"
 
    }, 
     
run = run, 
    pre_process = pre_process 
}
--[[ 
در صورت کپی از محتوا منبع را ذکر کنید
@alireza_PT
@CliApi
@Create_antispam_bot 
--]]