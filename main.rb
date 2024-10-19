require "./card.rb"
require "./bahuda.rb"
require "./player.rb"
require "./tehuda.rb"
require "./strategy.rb"

  puts "戦争を開始いたします"

  print "プレイヤーの人数を入力してください:"
  
  playernum = gets.chomp

  if playernum != "2" &&  playernum != "3" && playernum != "4" && playernum != "5"
   puts "入力に問題があります"

   return

  end

  playernum = playernum.to_i

  playerarray=[]

  for value in 1..playernum do
    print "プレイヤー#{value}の名前を入力してください:"
    playername = gets.chomp

    if playername.empty? || playername.length >10
      puts "入力に問題があります"
      return
    end
     
    playerarray <<  Plyer.new(playername,Tehuda.new([]),Bahuda.new([]))



  end

  cardarray=[]

  cardshurui=["スペード","ハート","ダイヤ","クラブ"]


#エースを14、ジョーカーを15とおく
  cardshurui.each do |n|
    for suuzi in 2..14 do
      
       
      cardarray <<  Card.new(n,suuzi)
  
  
  
    end


  end

  cardarray <<  Card.new("ジョーカー",15)

#乱数生成して手札を配る人を決定し、手札を配る
  ransuu = rand(0..playerarray.size-1)
  playerarray[ransuu].cardtrans(playerarray,cardarray)


  tihihuda=[]
  shoubuhuda=[]
#ゲーム開始
  while true

    puts "戦争"
    
    

#shoubuhudaにそれぞれがカードを出す。
    playerarray.each do |n|

      shoubuhuda << n.cardteishutu()
      

    end

    
#勝者の配列の添え字を抽出する。引き分けの場合は99
    strategytp=Strategy.new()
    maxsoezi=strategytp.maxstrategy(shoubuhuda)
    
    if (maxsoezi==99)

      for num in 1..shoubuhuda.size
#引き分けの場合はtihihudaに退避して次に勝ったプレイヤーがすべて取る
        tihihuda << shoubuhuda.pop

      end


      
      
    
   else
#勝った場合はshoubuhudaとtihihudaを勝者のbahudaに加える
     winner=playerarray[maxsoezi]
     puts "プレイヤー#{winner.name}の勝ちです.#{winner.name}はカードを#{shoubuhuda.size + tihihuda.size}枚獲得しました。"
     for num in 1..shoubuhuda.size
      winner.bahuda.bahudaarray << shoubuhuda.pop

     end

    
     for num in 1..tihihuda.size do
      winner.bahuda.bahudaarray << tihihuda.pop
     end
    
   end

 #プレイヤーでtehudaとbahudaが０のプレイヤーがいた場合kechakuflagをTRUEにtehudaのみ０の場合はシャッフルしてtehudaに加える 
       kechaku=false
    playerarray.each do |c|

      if c.tehuda.tehudaarray.size==0

        if c.bahuda.bahudaarray.size==0
          puts "プレイヤー#{c.name}のトランプがなくなりました"
          kechaku=true
        end

        c.shufbahuda
        
      
      end
    end
#決着flagがtrueの場合はbahudaを手札に加えてループを抜ける
    if kechaku==true
      playerarray.each do |d|

        d.shufbahuda
        
      end
      
       break
    end

  end

 ##プレイヤー配列を手札の数でソートし、同じ手札数のプレイヤーを同じ順位として表示 
  juniarray=playerarray.sort{|a,b| a.tehuda.tehudaarray.size <=> b.tehuda.tehudaarray.size}
  douritu=0
  for juni in 1..juniarray.size do
    puts "プレイヤー#{juniarray[juniarray.size - juni].name}の手札の枚数は#{juniarray[juniarray.size - juni].tehuda.tehudaarray.size}\
枚です。"

    if juniarray.size - juni!=juniarray.size-1 && (juniarray[juniarray.size - juni].tehuda.tehudaarray.size==\
      juniarray[juniarray.size - juni+1].tehuda.tehudaarray.size )
      douritu=douritu+1
      
    end

    
    
      puts "プレイヤー#{juniarray[playerarray.size - juni].name}の順位は#{juni-douritu}位です。"
    

  end 

  puts "戦争は終了です。"

  










 













