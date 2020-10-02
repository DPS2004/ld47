-- require() every single file yeah
-- probably not very Good Coding Practices™ but shush

function requireFiles(files)
  for _, file in ipairs(files) do
    local file = file:sub(1, -5)
    require(file)
  end
end

function recursiveEnumerate(folder, file_list)
  local items = love.filesystem.getDirectoryItems(folder)
  for _, item in ipairs(items) do
    local file = folder .. '/' .. item
    if love.filesystem.getInfo(file).type == 'file' then
      table.insert(file_list, file)
    elseif love.filesystem.getInfo(file).type == 'directory' then
      recursiveEnumerate(file, file_list)
    end
  end
end
