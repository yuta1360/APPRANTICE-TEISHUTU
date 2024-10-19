require "./card.rb"
require "./bahuda.rb"
require "./player.rb"
require "./tehuda.rb"

class Plyer
  def initialize(name,tehuda,bahuda)
    @name = name
    @tehuda = tehuda
    @bahuda = bahuda

  end
   def name
     @name 
   end

  def tehuda
    @tehuda
  end
  def bahuda
    @bahuda
  end

  def name=(value)
    @name = value
  end

  def tehuda=(value)
    @tehuda = value
  end

  def bahuda=(value)
    @bahuda = value
  end

#シャッフルしてそれぞれのプレイヤーに配る
  def cardtrans(playerarray,cardarray)
      shufarray = cardarray.shuffle

    
    fla=0

    shufarray.each do |n|
    
      if(fla % playerarray.size == 0)
        playerarray[0].tehuda.tehudaarray << n
      end
      if(fla % playerarray.size == 1)
        playerarray[1].tehuda.tehudaarray << n
      end
      if(fla % playerarray.size == 2)
        playerarray[2].tehuda.tehudaarray << n
      end
      if(fla % playerarray.size == 3)
        playerarray[3].tehuda.tehudaarray << n
      end
      if(fla % playerarray.size == 4)
        playerarray[4].tehuda.tehudaarray << n
      end

      fla=fla+1


      
  
  
    end


  end
  #勝負の際プレイヤーが手札を出すメソッド
  def cardteishutu
    
    
    teishutuhuda=@tehuda.tehudaarray.pop
    if teishutuhuda.bangou==11 or teishutuhuda.bangou==12 or teishutuhuda.bangou==13 or teishutuhuda.bangou==14 or teishutuhuda.bangou==15
      if teishutuhuda.bangou==11
        puts "プレイヤー#{@name}は#{teishutuhuda.shurui}のJを出しました"
      elsif teishutuhuda.bangou==12
        puts "プレイヤー#{@name}は#{teishutuhuda.shurui}のQを出しました"
      elsif teishutuhuda.bangou==13
        puts "プレイヤー#{@name}は#{teishutuhuda.shurui}のKを出しました"
      elsif teishutuhuda.bangou==14
        puts "プレイヤー#{@name}は#{teishutuhuda.shurui}のAを出しました"
      elsif teishutuhuda.bangou==15
        puts "プレイヤー#{@name}は#{teishutuhuda.shurui}を出しました"
      end

      
    
    else
      puts "プレイヤー#{@name}は#{teishutuhuda.shurui}の#{teishutuhuda.bangou}を出しました"
    end
    
    teishutuhuda
    
  end
#プレイヤーの場札をtehudaに加える
  def shufbahuda()
    @bahuda.shuffle
    for num in 1..@bahuda.bahudaarray.size do

      @tehuda.tehudaarray <<  @bahuda.popb
      
      
    end


  end


 end