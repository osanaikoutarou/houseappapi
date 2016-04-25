require 'csv'
data_list = Array.new

c = 1
bufDescription = ""

CSV.foreach("photos.csv") do |data|

  # header
  # if c==1||c==2
  #   c+=1
  #   next
  # end

  if data[0].to_s.length>0
    isHeader = true       # IDとかあるヘッダー行
    isAddInfo = false     # それ以外のはみ出した行
  else
    isHeader = false
    isAddInfo = true
  end

  if isHeader
    houseID       = data[0]
    title         = data[1]
    roomType      = data[2]
    roomStyle     = data[3]
    description   = data[4]
    imageURL      = data[5]

  end
  # どちみち
  description   = data[4]

  if isHeader
    ex_data = [houseID,title,roomType,roomStyle,description,imageURL]
    data_list.push(ex_data)

    bufDescription = ""
  end

  if isAddInfo
    bufDescription += (description.to_s + "\r\n")
  end
  c+=1
end

file_name = "convertedPhotosCSV.csv"    #保存するファイル

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
