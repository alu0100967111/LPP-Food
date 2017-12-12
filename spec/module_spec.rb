require "spec_helper"

include FoodGem
include DLLModule

FOOD_DATA_FILENAME = "input/food-data.txt"
SAMPLES_DATA_FILENAME = "input/samples-data.txt"

RSpec.describe Comparable do
  
  before :all do
    @food_array = read_data(FOOD_DATA_FILENAME, SAMPLES_DATA_FILENAME)
  end
  
  context "Comparando alimentos" do
    before :all do
      @food_1 = @food_array[0] # Huevo frito 
      @food_2 = @food_array[1] # Leche vaca
      @food_3 = @food_array[2] # Yogurt
    end
    
    it "Comprobar que huevo frito es mayor que Leche de vaca" do
      expect(@food_2).to be > @food_1
    end
    it "Comprobar que leche de vaca es menor que Yogurt" do
      expect(@food_1).to be < @food_3
    end
    it "Comprobar que leche de vaca es igual que leche de vaca" do
      expect(@food_1).to eq(@food_1)
    end
    it "Comprobar que Leche de vaca está entre Huevo frito y Yogurt" do
      expect(@food_2).to be_between(@food_1, @food_3).exclusive
    end
  end
  
end

RSpec.describe Enumerable do
  
  before :all do
    @food_array = read_data(FOOD_DATA_FILENAME, SAMPLES_DATA_FILENAME)
    
    @list_array = Hash.new() #H ash de nombre de lista y lista
    
    @food_array.each{ |food| # Rellenamos el Hash
      if (@list_array.has_key?(food.group_name)) # Si existe la lista con ese grupo, insertamos
        @list_array[food.group_name].insert_tail(food)
      else
        @list_array[food.group_name] = DLL.new(food)
      end
    }
  end

  context "Enumerando la lista de alimentos" do
    before :all do
      @hlh_list = @list_array["Huevos, lacteos y helados"]
      @cd_list = @list_array["Carnes y derivados"]
      @pm_list = @list_array["Pescados y mariscos"]
    end
    
    it "Usamos el método each de la lista doblemente enlazada" do
      @hlh_list.each{ |food| expect(food.group_name).to eq ("Huevos, lacteos y helados")}
    end
    it "Usamos el método all de la lista doblemente enlazada" do
      expect(@hlh_list.all?{ |food| food.group_name == "Huevos, lacteos y helados"}).to be_truthy
    end
    it "Usamos el método any de la lista doblemente enlazada" do
      expect(@hlh_list.any?{ |food| food.name == "Yogurt"}).to be_truthy
    end
    it "Usamos el método max de la lista doblemente enlazada" do
      expect(@hlh_list.max.name).to eq("Yogurt")
    end
    it "Usamos el método min de la lista doblemente enlazada" do
      expect(@hlh_list.min.name).to eq("Huevo frito")
    end
    it "Usamos el método first de la lista doblemente enlazada" do
      expect(@hlh_list.first).to eq(@hlh_list.get_head)
    end
    it "Usamos el método count de la lista doblemente enlazada" do
      expect(@hlh_list.count).to eq(3)
    end
    it "Usamos el método find de la lista doblemente enlazada" do
      expect(@hlh_list.find{ |food| food.name == "Huevo frito"}).to eq(@hlh_list.get_head)
    end
    it "Usamos el método drop de la lista doblemente enlazada" do
      expect(@hlh_list.drop(2)).to eq([@hlh_list.get_tail])
    end
  end
  
end

