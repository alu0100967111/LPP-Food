require "spec_helper"

include FoodGem
include DLLModule

FOOD_DATA_FILENAME = "docs/input/food-data.txt"
SAMPLES_DATA_FILENAME = "docs/input/samples-data.txt"

RSpec.describe Food do
  
  before :all do
    @food_array = read_data(FOOD_DATA_FILENAME, SAMPLES_DATA_FILENAME)
    
    @food_array.each { |food|
      @apple = food if (food.name == "Manzana")
      @yogurt = food if (food.name == "Yogurt")
      @chocolate = food if (food.name == "Chocolate")
    }
    
  end
  
  context "Calcular AIBC para cada alimento" do
    it "Calcular el aibc de la Manzana para el índividuo 1" do
      expect(@apple.get_aibc_of_person(1).round(3)).to eq(27.5)
    end
    it "Calcular el aibc de la Manzana para el índividuo 2" do
      expect(@apple.get_aibc_of_person(2).round(3)).to eq(183.25)
    end
    it "Calcular el aibc de la Yogurt para el índividuo 1" do
      expect(@yogurt.get_aibc_of_person(1).round(3)).to eq(21.75)
    end
    it "Calcular el aibc de la Yogurt para el índividuo 2" do
      expect(@yogurt.get_aibc_of_person(2).round(3)).to eq(138.5)
    end
    it "Calcular el aibc de la Chocolate para el índividuo 1" do
      expect(@chocolate.get_aibc_of_person(1).round(3)).to eq(7.5)
    end
  end
  
  context "Calcular IG relativo al individuo para cada alimento" do
    it "Calcular el IG relativo al individuo 1 para la Manzana" do
      expect(@apple.get_ig_of_person(1).round(3)).to eq(10.742)
    end
    it "Calcular el IG relativo al individuo 2 para la Manzana" do
      expect(@apple.get_ig_of_person(2).round(3)).to eq(98.257)
    end
    it "Calcular el IG relativo al individuo 1 para la Yogurt" do
      expect(@yogurt.get_ig_of_person(1).round(3)).to eq(8.496)
    end
    it "Calcular el IG relativo al individuo 2 para la Yogurt" do
      expect(@yogurt.get_ig_of_person(2).round(3)).to eq(74.263)
    end
    it "Calcular el IG relativo al individuo 1 para la Chocolate" do
      expect(@chocolate.get_ig_of_person(1).round(3)).to eq(2.93)
    end
    it "Calcular el IG relativo al individuo 2 para la Chocolate" do
      expect(@chocolate.get_ig_of_person(2).round(3)).to eq(23.727)
    end
  end
  
  context "Calcular IG total de cada alimento" do
    it "Calcular el IG total para la Manzana" do
      expect(@apple.get_ig.round(3)).to eq(54.5)
    end
    it "Calcular el IG total para la Yogurt" do
      expect(@yogurt.get_ig.round(3)).to eq(41.379)
    end
    it "Calcular el IG total para la Chocolate" do
      expect(@chocolate.get_ig.round(3)).to eq(13.328)
    end
  end
  
end