{-# LANGUAGE NoMonomorphismRestriction #-}
import Text.Show.Functions
import Data.List
import Data.Maybe 
import Test.Hspec 

 ---------------------------------------------------------------- Testing --------------------------------------------------------------- 
    describe "Transacciones: " $do 
        it "El resultado de aplicar la transacción 1 a pepe con una billetera de 20 monedas debería ser 20, porque queda igual" $ transacción1 (nuevaBilleteraPara pepe 20) `shouldBe` 20 
        it "El resultado de aplicar la transacción 2 a pepe con una billetera de 10 monedas debería ser 15, porque deposita 5 monedas" $ transacción2 pepe `shouldBe` 15 
        it "El resultado de aplicar la transacción 2 a pepeDos con una billetera de 50 monedas debería ser 55, porque deposita 5 monedas" $ transacción2 (nuevaBilleteraPara pepeDos 50) `shouldBe` 55  


 ---------------------------------------------------------------- Eventos --------------------------------------------------------------- 



 ---------------------------------------------------------------- Usuarios --------------------------------------------------------------- 

data Usuario = Usuario {
    nombre :: String,
    billetera :: Dinero
 } deriving (Show, Eq)

pepe  = Usuario "Jose" 10.0  
lucho = Usuario "Luciano" 2.0
pepeDos = Usuario "Jose" 20.0

---------------------------------------------------------------- Transacciones --------------------------------------------------------------- 


type Evento = Float
type Transacción = Usuario -> Evento

generarTransacciones ::  Usuario -> Billetera -> Transacción 
generarTransacciones usuario1 evento usuario2 
  | funcionQueComparaNombres usuario1 usuario2  =  (evento.billetera) usuario2
  | otherwise =  (quedaIgual.billetera) usuario2

funcionQueComparaNombres :: Usuario -> Usuario -> Bool
funcionQueComparaNombres usuario1 usuario2 = ( == ) (nombre usuario1) (nombre usuario2)

nuevaBilleteraPara :: Usuario -> Dinero -> Usuario
nuevaBilleteraPara usuario nuevoMonedero = usuario { billetera = nuevoMonedero}

transacción1 :: Transacción
transacción1 = generarTransacciones lucho cerrarCuenta

transacción2 :: Transacción
transacción2 = generarTransacciones pepe (depósito 5)





 
 ---------------------------------------------------------------- Nuevos Eventos --------------------------------------------------------------- 
