{-# LANGUAGE NoMonomorphismRestriction #-}
import Text.Show.Functions
import Data.List
import Data.Maybe 
import Test.Hspec 

 ---------------------------------------------------------------- Testing --------------------------------------------------------------- 


 ---------------------------------------------------------------- Eventos --------------------------------------------------------------- 



 ---------------------------------------------------------------- Usuarios --------------------------------------------------------------- 


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
