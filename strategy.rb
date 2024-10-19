require "./card.rb"
require "./bahuda.rb"
require "./player.rb"
require "./tehuda.rb"
class Strategy



#出されたカードの配列の中で勝利したカードの添え字を返す
   def maxstrategy(tehuda)

    

    maxtp = tehuda.max {|a,b| a.bangou <=> b.bangou}
    maxar = tehuda.select {|c| c.bangou == maxtp.bangou}
#番号が一番大きいカードが１つか複数かで場合分け    
    
    if maxar.size !=1 

      speAfla=false

      maxar.each do |n|
#複数ありスペードのエースがある場合はフラグをtrueにしその添え字を返し引き分けの場合99を返す
        if n.shurui == "スペード" && n.bangou == 14
          speAfla=true
        end
        
  
      end
  
      if (speAfla)

        puts "スペードのエースは最強"
        return tehuda.index {|v| v.bangou== 14 && v.shurui== "スペード" }


      end
      puts "引き分けです"


      return 99
      end
#勝利カードの配列の長さが１つの場合その添え字を返す
    maxbangou = maxar[0].bangou
    maxshurui = maxar[0].shurui

    tehuda.index {|v| v.bangou == maxbangou && v.shurui == maxshurui }

     
   end

  

  
 end