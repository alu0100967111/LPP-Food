require "spec_helper"
include FoodGem

DATA_FILENAME = "docs/data.txt"

RSpec.describe FoodGem do
  
  context "Instanciación de clase Food." do
    it "Crear un objeto Alimento con un nombre y tres pares (macronutriente, contenido energético): Proteínas, glúcidos y lípidos." do
      Food.new("Huevo frito", [14.1, 4], [0.0, 4], [19.5, 9])
    end
    it "No permitir que el primer atributo sea no String." do
      expect {Food.new(5, [14.1, 4], [0.0, 4], [19.5, 9])}.to raise_error(RuntimeError)
    end
    it "No permitir que el segundo, tercer y cuarto atributo sea no Array." do
      expect {Food.new("Huevo frito", 5, 6, 7)}.to raise_error(RuntimeError)
    end
    it "No permitir que el segundo, tercer y cuarto atributo sean un par vacío." do
      expect {Food.new("Huevo frito", [], [], [])}.to raise_error(RuntimeError)
    end
    it "No permitir que el segundo, tercer y cuarto atributo no sean un par." do
      expect {Food.new("Huevo frito", [5], [6], [7, 8, 5])}.to raise_error(RuntimeError)
    end
    it "No permitir que el segundo, tercer y cuarto atributo sean un par de no Float||Int." do
      expect {Food.new("Huevo frito", ["A", "B"], ["A", "B"], ["A", "B"])}.to raise_error(RuntimeError)
    end
  end
  
  context "Obtener atributos de un Alimento." do
    food = Food.new("Huevo frito", [14.1, 4], [0.0, 4], [19.5, 9])
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
      read_data(DATA_FILENAME)
    end
    it "Compruebo que la función read_data me devuelve un array de Alimento." do
      expect(read_data(DATA_FILENAME)).to be_instance_of(Array)
    end
    it "Compruebo que la función read_data me devuelva el primer elemento bien leído." do
      food_array = read_data(DATA_FILENAME)
      expect(food_array[0].name).to eq("Huevo frito")
      expect(food_array[0].protein_quantity).to eq(14.1)
      expect(food_array[0].glucid_quantity).to eq(0.0)
      expect(food_array[0].lipid_quantity).to eq(19.5)
    end
  end
  
  context "Realizar Operaciones en el alimento." do
    food_array = read_data(DATA_FILENAME)
    it "Obtener el valor energético del alimento." do
      expect(food_array[0].energetic_content).to eq(56.4 + 0.0 + 175.5)
    end
    it "Mostrar datos del alimento." do
      expect(food_array[0].to_s).to eq ("Huevo frito | Proteínas: 14.1 gramos | Glúcidos: 0.0 gramos | Lípidos: 19.5 gramos | Contenido Energético: 231.9 Kcal. |")
    end
  end
  
end