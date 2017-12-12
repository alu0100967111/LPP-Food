require "spec_helper"

include FoodGem
include DLLModule

FOOD_DATA_FILENAME = "input/food-data.txt"
SAMPLES_DATA_FILENAME = "input/samples-data.txt"

RSpec.describe Food do
  
  before :all do
    @food_array = read_data(FOOD_DATA_FILENAME, SAMPLES_DATA_FILENAME)
  end

  context "Instanciación de clase Food." do
    it "Crear un objeto Alimento con un nombre y tres pares (macronutriente, contenido energético): Proteínas, glúcidos y lípidos." do
      Food.new("Huevo frito", [14.1, 4], [0.0, 4], [19.5, 9], "Lacteos")
    end
    it "No permitir que el primer atributo sea no String." do
      expect {Food.new(5, [14.1, 4], [0.0, 4], [19.5, 9], "Lacteos")}.to raise_error(RuntimeError)
    end
    it "No permitir que el segundo, tercer y cuarto atributo sea no Array." do
      expect {Food.new("Huevo frito", 5, 6, 7, "Lacteos")}.to raise_error(RuntimeError)
    end
    it "No permitir que el segundo, tercer y cuarto atributo sean un par vacío." do
      expect {Food.new("Huevo frito", [], [], [], "Lacteos")}.to raise_error(RuntimeError)
    end
    it "No permitir que el segundo, tercer y cuarto atributo no sean un par." do
      expect {Food.new("Huevo frito", [5], [6], [7, 8, 5], "Lacteos")}.to raise_error(RuntimeError)
    end
    it "No permitir que el segundo, tercer y cuarto atributo sean un par de no Float||Int." do
      expect {Food.new("Huevo frito", ["A", "B"], ["A", "B"], ["A", "B"], "Lacteos")}.to raise_error(RuntimeError)
    end
  end
  
  context "Obtener atributos de un Alimento." do
    food = Food.new("Huevo frito", [14.1, 4], [0.0, 4], [19.5, 9], "Lacteos")
    it "Obtener el nombre del alimento" do
      expect(food.name).to eq("Huevo frito")
    end
    it "Obtener la cantidad de proteínas del alimento en gramos." do
      expect(food.protein_quantity).to eq(14.1)
    end
    it "Obtener la cantidad de glúcidos del alimento en gramos." do
      expect(food.glucid_quantity).to eq(0.0)
    end
    it "Obtener la cantidad de lípidos del alimento en gramos." do
      expect(food.lipid_quantity).to eq(19.5)
    end
  end
  
  context "Leer datos por fichero." do
    it "Llamo a la función read_data con un fichero de texto donde están los datos." do
      read_data(FOOD_DATA_FILENAME, SAMPLES_DATA_FILENAME)
    end
    it "Compruebo que la función read_data me devuelve un array de Alimento." do
      expect(read_data(FOOD_DATA_FILENAME, SAMPLES_DATA_FILENAME)).to be_instance_of(Array)
    end
    it "Compruebo que la función read_data me devuelva el primer elemento bien leído." do
      expect(@food_array[0].name).to eq("Huevo frito")
      expect(@food_array[0].protein_quantity).to eq(14.1)
      expect(@food_array[0].glucid_quantity).to eq(0.0)
      expect(@food_array[0].lipid_quantity).to eq(19.5)
    end
  end
  
  context "Realizar Operaciones en el alimento." do
    it "Obtener el valor energético del alimento." do
      expect(@food_array[0].energetic_content).to eq(56.4 + 0.0 + 175.5)
    end
    it "Mostrar datos del alimento." do
      expect(@food_array[0].to_s).to eq ("Grupo: Huevos, lacteos y helados | Nombre: Huevo frito | Proteínas: 14.1 gramos | Glúcidos: 0.0 gramos | Lípidos: 19.5 gramos | Contenido Energético: 231.9 Kcal.")
    end
    it "Comparar con array de resultados los valores energéticos del alimento." do
      result_array = [231.9, 61.2, 69, 142.7, 112.3, 132.8, 74.4, 225.5, 202, 897.2, 479.2, 399.2, 343.4, 314.6, 70.5, 19.8, 31.1, 54.4, 92.2];
      for i in 0...(result_array.count)
        expect(@food_array[i].energetic_content.round(2)).to eq(result_array[i]) # Redondeamos a 2!
      end
    end
  end
  
  context "Jerarquía de clases" do
    before :each do
      @food = Food.new("Huevo frito", [14.1, 4], [0.0, 4], [19.5, 9], "Huevos, lacteos y helados")
    end
    
    it "Food sea Food" do
      expect(@food).is_a?Food
    end
    it "Food sea FoodAbstract" do
      expect(@food).is_a?FoodAbstract
    end
    it "Food sea Object" do
      expect(@food).is_a?Object
    end
    it "Food sea BasicObject" do
      expect(@food).is_a?BasicObject
    end
    it "Food no sea instancia FoodAbstract" do
      expect(@food.instance_of?FoodAbstract).to eq(false)
    end
    it "Food sea instancia de Food" do
      expect(@food).instance_of?Food
    end
    it "Clase Food sea clase Class" do
      expect(Food).is_a?Class
    end
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
      expect(@food_2).to be < @food_3
    end
    it "Comprobar que leche de vaca es igual que leche de vaca" do
      expect(@food_2).to eq(@food_2)
    end
    it "Comprobar que Yogurt está entre Huevo fito y Leche de vaca" do
      expect(@food_2).to be_between(@food_1, @food_3).exclusive
    end
  end
  
end