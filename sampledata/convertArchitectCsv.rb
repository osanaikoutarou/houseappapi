require 'csv'
data_list = Array.new

c = 1
bufMessage = ""   # メッセージマージ
bufCareer = ""    # 経歴マージ
bufPolicy = ""    # こだわりマージ

CSV.foreach("architects.csv") do |data|

  # header
  if c==1||c==2
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
    name          = data[1]
    affiliation   = data[2]
    addPost       = data[3]
    addPref       = data[4]
    addCity       = data[5]
    addOther      = data[6]
    qualifications= data[7]
    message       = data[8]
    policy        = data[9]
    goodAtType    = data[10]
    career        = data[11]
    suvacoURL     = data[12]
    architectURL  = data[13]
    architectIconURL = data[14]
    architectIconFileName = data[15]

  end
  # どちみち
  message       = data[8]
  policy        = data[9]
  career        = data[11]

  if isHeader
    ex_data = [architectID,name,affiliation,addPost,addPref,addCity,addOther,qualifications,
    bufMessage,policy,goodAtType,bufCareer,suvacoURL,architectURL,architectIconURL,architectIconFileName]
    data_list.push(ex_data)

    bufMessage = ""
    bufCareer = ""
  end

  if isAddInfo
    bufMessage += (message.to_s + "\r\n")
    bufCareer += (career.to_s + "\r\n")
    bufPolicy += (policy.to_s + "\r\n")
  end
  c+=1
end

file_name = "convertedArchitectCSV.csv"    #保存するファイル

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
