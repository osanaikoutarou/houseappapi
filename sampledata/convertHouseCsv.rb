require 'csv'
data_list = Array.new

c = 1
bufDescription = ""

CSV.foreach("houses.csv") do |data|

  # header
  if c==1
    c+=1
    next
  end

  if data[0].to_s.length>0
    isHeader = true       # IDとかあるヘッダー行
    isAddInfo = false     # それ以外のはみ出した行
  else
    isHeader = false
    isAddInfo = true
  end

  if isHeader
    architectID   = data[0]
    architectName = data[1]
    houseNo       = data[2]
    houseID       = data[3]
    name          = data[4]
    cost          = data[5]
    area          = data[6]
    space         = data[7]
    description   = data[8]
    suvacoURL     = data[9]

  end
  # どちみち
  description   = data[8]

  if isHeader
    ex_data = [architectID,architectName,houseNo,houseID,name,cost,area,space,bufDescription,suvacoURL]
    data_list.push(ex_data)

    bufDescription = ""
  end

  if isAddInfo
    bufDescription += (description.to_s + "\r\n")
  end
  c+=1
end

file_name = "convertedHousesCSV.csv"    #保存するファイル

File.open(file_name, 'w') {|file|
  data_list.each do |data|

    writeStr=""
    data.each do |element|
      writeStr += ('"' + element.to_s + '"' + ",")
    end

    file.write writeStr.chop+"\r\n"

  end
}

puts("end")
