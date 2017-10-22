require "spec_helper"
include FoodGem

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

end
