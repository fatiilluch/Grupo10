{-# LANGUAGE NoMonomorphismRestriction #-}
import Text.Show.Functions
import Data.List
import Data.Maybe 
import Test.Hspec 

 ---------------------------------------------------------------- Testing --------------------------------------------------------------- 
 ejecutarTests = hspec $ do
 describe "Eventos: " $ do 
  it " Aplicar Depositar 10 más Debería quedar con 20 monedas "  deposito 10 'shouldBe' 20
  it " Extraer 3 y Debería quedar con 7 " extracción 3 'shouldBe'7
  it " Extraer 15 y Debería quedar con 0 " extracción 15 'shouldBe'0 
  it " Un upgrade debería quedar con 12 "  upgrade 'shouldBe'12 
  it " Cerrar la cuenta quedaria 0 " cerrarCuenta 'shouldBe' 0.0 
  it " Queda igual 10 " quedaIgual 'shouldBe' billetera 
  it " Depositar 1000 y luego tener un upgrade 1020 " depósito 1000 ( upgrade 'shouldBe' 1020)
describe "Transacciones: " $ do 
  it "El resultado de aplicar la transacción 1 a pepe con una billetera de 20 monedas debería ser 20, porque queda igual" $ transacción1 (nuevaBilleteraPara pepe 20) `shouldBe` 20 
  it "El resultado de aplicar la transacción 2 a pepe con una billetera de 10 monedas debería ser 15, porque deposita 5 monedas" $ transacción2 pepe `shouldBe` 15 
  it "El resultado de aplicar la transacción 2 a pepeDos con una billetera de 50 monedas debería ser 55, porque deposita 5 monedas" $ transacción2 (nuevaBilleteraPara pepeDos 50) `shouldBe` 55  
describe "Nuevos Eventos: " $ do
  it "El resultado de aplicar la transaccion 3 a lucho con una billetera de 10 monedas debería ser 0, ya que cierra la cuenta" $ transacción3 (nuevaBilleteraPara lucho 10) `shouldBe` 0 
  it "El resultado de aplicar la transaccion 4 a lucho con una billetera de 10 monedas debería ser 34" $ transacción4 (nuevaBilleteraPara lucho 10) `shouldBe` 34 

 ---------------------------------------------------------------- Eventos --------------------------------------------------------------- 

type Dinero    = Float
type Billetera = Dinero -> Dinero

depósito     ::  Dinero -> Billetera
depósito     = (+)

extracción :: Dinero -> Billetera
extracción monto billetera = max (billetera - monto) 0

upgrade :: Billetera
upgrade billetera = min (billetera * 1.20) (billetera + 10)

cerrarCuenta ::  Billetera
cerrarCuenta _ = 0.0

quedaIgual   :: Billetera
quedaIgual  = id

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




