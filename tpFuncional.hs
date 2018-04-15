{-# LANGUAGE NoMonomorphismRestriction #-}
import Text.Show.Functions
import Data.List
import Data.Maybe 
import Test.Hspec 


ejecutarTests = hspec $ do
  describe "Eventos (Con billetera de 10)" $ do
    it "Depositar 10 más. Deberia quedar con 20 monedas" $ depósito 10 10 `shouldBe` 20
    it "Extraer 3: Deberia quedar con 7" $ extracción 3 10 `shouldBe` 7
    it "Extraer 15: Deberia quedar con 0" $ extracción 15 10 `shouldBe` 0
    it "Un upgrade: Deberia quedar con 12" $ upgrade 10 `shouldBe` 12
    it "Cerrar la cuenta : 0" $ cerrarCuenta 10 `shouldBe` 0
    it "Queda igual: 10" $ quedaIgual 10 `shouldBe` 10
    it "Depositar 1000, y luego tener un upgrade: 1020" $ (upgrade.depósito 1000) 10 `shouldBe` 1020


 -- Eventos 

type Dinero = Float
type Evento = Dinero -> Dinero

depósito :: Dinero -> Evento
depósito monto billetera = billetera + monto

extracción :: Dinero -> Evento 
extracción monto billetera = max (billetera - monto) 0

upgrade :: Evento
upgrade billetera = min (billetera * 1.20) (billetera + 10)

cerrarCuenta :: Evento
cerrarCuenta billetera = 0.0

quedaIgual :: Evento
quedaIgual billetera = billetera

