
#プレイヤーが勝った時にもらえるカードを格納する。手札が0枚になった場合ここから補給する
class Bahuda
  def initialize(bahudaarray)
    @bahudaarray = bahudaarray

  end
  def bahudaarray
     @bahudaarray 
  end

  def bahudaarray=(value)
    @bahudaarray = value
  end

  def shuffle 
    @bahudaarray=@bahudaarray.shuffle

  end

  def popb

    @bahudaarray.pop

  end

  
 end