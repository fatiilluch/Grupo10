{-# LANGUAGE NoMonomorphismRestriction #-}
import Text.Show.Functions
import Data.List
import Data.Maybe 
import Test.Hspec 

 ---------------------------------------------------------------- Testing --------------------------------------------------------------- 

ejecutarTests = hspec $ do
   describe "Eventos (billetera inicial con 10 monedas)" $ do
    it "Luego de depositar 10 monedas más, la billetera deberia quedar con 20 monedas" $ depósito 10 10 `shouldBe` 20
    it "Luego de extraer 3 monedas : La billetera deberia quedar con 7" $ extracción 3 10 `shouldBe` 7
    it "Luego de extraer 15 monedas : La billetera deberia quedar vacía" $ extracción 15 10 `shouldBe` 0
    it "Con un upgrade: La billetera deberia quedar con 12 monedas" $ upgrade 10 `shouldBe` 12
    it "Al cerrar la cuenta : queda en 0" $ cerrarCuenta 10 `shouldBe` 0
    it "La billetera queda igual, como al incio, con 10 monedas" $ quedaIgual 10 `shouldBe` 10
    it "Luego de depositar 1000, y luego de tener un upgrade: la billetera queda con 1020 monedas" $ (upgrade.depósito 1000) 10 `shouldBe` 1020
  
   describe "Usuarios" $ do
    it "La billetera de pepe tiene 10 monedas" $ billetera pepe `shouldBe` 10
    it "La billetera de pepe luego de un cierre de cuenta queda vacía" $ (cerrarCuenta.billetera) pepe `shouldBe` 0
    it "La billetera de pepe luego de depositar 15 monedas, extraer 2 y tener un upgrade queda con 27.6 monedas" $ (upgrade.extracción 2.depósito 15.billetera) pepe `shouldBe` 27.6
  
   {-describe "Transacciones" $ do
    it "Aplicar transaccion 1 a pepe: quedaIgual 20 : 20" $ (aplicarTransaccion uno pepe) 20 `shouldBe` 20
    it "Aplicar transaccion 2 a pepe: (Depositar 5) 10 : 15 " $ (aplicarTransaccion dos pepe) 10 `shouldBe` 15
    it "Aplicar transaccion 2 a pepeDos: (Depositar 5) 50 : 55" $ (aplicarTransaccion dos pepeDos) 50 `shouldBe` 55
   describe "Nuevos Eventos" $ do
    it "Aplicar transacción tres a lucho: (tocoYMeVoy) 10 : 0" $ (aplicarTransaccion tres lucho) 10 `shouldBe` 0
    it "Aplicar transacción cuatro a lucho: (ahorranteErrante) 10 : 34" $ (aplicarTransaccion cuatro lucho) 10 `shouldBe` 34
   describe "Pagos entre Usuarios" $ do
    it "Aplicar transacción cinco a pepe: (extracción 7) 10 : 3" $ (aplicarPagos cinco pepe) 10 `shouldBe` 3
    it "Aplicar transacción cinco a lucho: (depósito 7) 10 : 17" $ (aplicarPagos cinco lucho) 10 `shouldBe` 17

pepeDos = modificarBilletera pepe 20

modificarBilletera usuario nuevaBilletera = usuario {
    billetera = nuevaBilletera
}
-}

 ---------------------------------------------------------------- Eventos --------------------------------------------------------------- 

type Billetera = Float
type Evento = Billetera -> Billetera

depósito     :: Billetera -> Evento
depósito  = (+)

extracción   :: Billetera -> Evento 
extracción monto billetera = max (billetera - monto) 0

upgrade      :: Evento
upgrade billetera = min (billetera * 1.20) (billetera + 10)

cerrarCuenta :: Evento
cerrarCuenta _ = 0.0

quedaIgual   :: Evento
quedaIgual  = id

 ---------------------------------------------------------------- Usuarios (--------------------------------------------------------------- 

data Usuario = Usuario {
    nombre :: String,
    billetera :: Billetera
 } deriving (Show, Eq)

pepe = Usuario {
    nombre = "José",
    billetera = 10
}

lucho = Usuario {
    nombre = "Luciano",
    billetera = 2
}

 {---------------------------------------------------------------- Transacciones --------------------------------------------------------------- 
data Transacciones = Transacciones{ 
    usuario :: Usuario,             
    evento :: Evento                
} deriving (Show)

aplicarTransaccion :: Transacciones -> Usuario -> Evento
aplicarTransaccion transacción otroUsuario
                | nombre (usuario transacción) == nombre (otroUsuario) = evento transacción
                | otherwise = quedaIgual

uno = Transacciones {
    usuario = lucho,
    evento = cerrarCuenta
}

dos = Transacciones{
    usuario = pepe,
    evento = depósito 5
}
 
 ---------------------------------------------------------------- Nuevos Eventos --------------------------------------------------------------- 
tocoYMeVoy :: Evento
tocoYMeVoy = cerrarCuenta . upgrade . depósito 15

ahorranteErrante :: Evento
ahorranteErrante = depósito 10 . upgrade . depósito 8 . extracción 1 . depósito 2 . depósito 1

tres = Transacciones{
    usuario = lucho,
    evento = tocoYMeVoy
}

cuatro = Transacciones{
    usuario = lucho,
    evento = ahorranteErrante
}
data Pago = Pago{
    transacciónUno :: Transacciones,
    transacciónDos :: Transacciones
} deriving (Show)

aplicarPagos pago otroUsuario
            | otroUsuario == usuario (transacciónUno pago) = evento (transacciónUno pago)
            | otroUsuario == usuario (transacciónDos pago) = evento (transacciónDos pago)
            | otherwise = quedaIgual

cinco = Pago {
    transacciónUno = Transacciones {
    usuario = pepe,
    evento = extracción 7
    },
    transacciónDos = Transacciones {
    usuario = lucho,
    evento = depósito 7
    }
}
-}
