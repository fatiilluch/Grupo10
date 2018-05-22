{-# LANGUAGE NoMonomorphismRestriction #-}
import Text.Show.Functions
import Data.List
import Data.Maybe 
import Test.Hspec 

---------------------------------------------------------------- Testing --------------------------------------------------------------- 
ejecutarTests = hspec $ do
    describe "Eventos: " $ do 
        it "Depositar 10 más. Deberia quedar con 20 monedas" $ depósito 10 10 `shouldBe` 20
        it "Extraer 3: Deberia quedar con 7" $ extracción 3 10 `shouldBe` 7
        it "Extraer 15: Deberia quedar con 0" $ extracción 15 10 `shouldBe` 0
        it "Un upgrade: Deberia quedar con 12" $ upgrade 10 `shouldBe` 12
        it "Cerrar la cuenta : 0" $ cerrarCuenta 10 `shouldBe` 0
        it "Queda igual: 10" $ quedaIgual 10 `shouldBe` 10
        it "Depositar 1000, y luego tener un upgrade: 1020" $ (upgrade.depósito 1000) 10 `shouldBe` 1020
    describe "Usuarios: " $ do
        it "La billetera de pepe debería ser 10 monedas." $ billetera pepe `shouldBe` 10
        it "La billetera de pepe luego de un cierre de cuenta debería quedar vacía." $ (cerrarCuenta.billetera) pepe `shouldBe` 0
        it "La billetera de pepe luego de depositar 15 monedas, extraer 2 y tener un upgrade debería quedar con 27.6 monedas." $ (upgrade.extracción 2.depósito 15.billetera) pepe `shouldBe` 27.6
    describe "Transacciones: " $ do 
        it "El resultado de aplicar la transacción 1 a pepe con una billetera de 20 monedas debería ser 20, porque queda igual" $ transacción1 (nuevaBilleteraPara pepe 20) `shouldBe` 20 
        it "El resultado de aplicar la transacción 2 a pepe con una billetera de 10 monedas debería ser 15, porque deposita 5 monedas" $ transacción2 pepe `shouldBe` 15 
        it "El resultado de aplicar la transacción 2 a pepeDos con una billetera de 50 monedas debería ser 55, porque deposita 5 monedas" $ transacción2 (nuevaBilleteraPara pepeDos 50) `shouldBe` 55  
    describe "Nuevos Eventos: " $ do
        it "El resultado de aplicar la transaccion 3 a lucho con una billetera de 10 monedas debería ser 0, ya que cierra la cuenta" $ transacción3 (nuevaBilleteraPara lucho 10) `shouldBe` 0 
        it "El resultado de aplicar la transaccion 4 a lucho con una billetera de 10 monedas debería ser 34" $ transacción4 (nuevaBilleteraPara lucho 10) `shouldBe` 34 
    describe "Pagos entre Usuarios" $ do
        it "Aplicar transacción 5 a pepe: (extracción 7) 10 : 3" $ transacción5 pepe `shouldBe` 3
        it "Aplicar transacción 5 a lucho: (depósito 7) 10 : 17" $ transacción5 (nuevaBilleteraPara lucho 10) `shouldBe` 17
    describe "Usuario luego de transacción:" $ do
        it "Impacto de la transacción 1 a Pepe . Esto debería quedar igual que como está inicialmente Pepe con una billetera de 10 ." $ impactarLaTransacción [transacción1] pepe `shouldBe` Usuario {nombre = "Jose", billetera = 10.0}
        it "Impacto de la transacción 5 a Lucho. Esto debería producir que Lucho tenga 9 monedas en su billetera inicial de 2."  $ impactarLaTransacción [transacción5] lucho `shouldBe` Usuario {nombre = "Luciano", billetera = 9.0} 
        it "Impacto de la transacción 5 y luego la 2 a Pepe. Eso hace que tenga 8 en su billetera inicial de 10."$ impactarLaTransacción [transacción5,transacción2] pepe `shouldBe` Usuario {nombre = "Jose", billetera = 8.0} 
    describe "Usuario luego de transacción: " $do
        it "18 - El resultado de impactar la transacción 1 a Pepe debería devolver a Pepe como estaba inicialmente." $ impactarTransacción transacción1 pepe `shouldBe` pepe
        it "19 - El resultado de impactar la transacción 5 a Lucho debería devolver a Lucho con una billetera de 9 unidades." $ impactarTransacción transacción5 lucho `shouldBe` nuevaBilleteraPara lucho 9 pepe
        it "20 - El resultado de impactar la transacción 5 y luego la transacción 2 a Pepe debería devolver a Pepe con una billetera de 8 unidades." $ impactarDobletransaccion pepe `shouldBe` nuevaBilleteraPara pepe 8 
    describe "Bloque: " $do
        it "21 - A partir del bloque 1 y de Pepe, este debería quedar con 18 unidades en su billetera." $ (billetera . aplicarBloque bloqueUno) pepe `shouldBe` 18
        it "22 - Las personas que tienen mas de 10 créditos dado una lista de usuarios y un bloque de transacciones debería ser pepe." $ saldoDealMenosNCreditos bloqueUno 10 usuarios `shouldBe` pepe 
        it "23 - El mas adinerado con cierto bloque sería pepe" $ esMasAdinerado bloqueUno usuarios `shouldBe`  pepe
        it "24 - El menos adinerado con cierto bloque sería lucho" $ esMenosAdinerado bloqueUno usuarios `shouldBe` lucho
    describe "Block Chain: " $do
        it "25 -  La billetera de pepe luego de verificar cual sería su peor bloque es 18." $ (billetera . aplicarBloque (peorBloque pepe blockchain)) pepe `shouldBe 18
        it "26 -  A partir de la block chain creada de ejemplo y Pepe, este debería quedar con 115 unidades en su billetera." $ (billetera . aplicarBloqueDeBloques blockchain) pepe `shouldBe` 115
        it "27 -  Siguiendo el ejemplo anterior, tomando los primeros 3 bloques, Pepe debería quedar con 51 monedas." $ ejecutarHastaN 3 blockchain   pepe `shouldBe` Usuario {nombre = "Jose", billetera = 51.0}
        it "28 -  El conjunto de usuarios conformado por pepe y lucho, se ve afectado de tal manera que la billetera de pepe queda con 115  monedas mientras que la billetera de lucho queda con 0. Su suma debería ser 115. " $ sum (map billetera (conjuntoDespuesDeBlockChain blockchain usuarios))usuarios `shouldBe` 115
    describe "Block Chain Infinito: " $do
        it "29 - La cantidad de bloques necesarios para que Pepe llegue a tener 10000 creditos debería ser 11" $ cantidadDeBloquesNecesarios bloqueInfinito pepe `shouldBe` 11
 
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

tocoYMeVoy :: Billetera
tocoYMeVoy = cerrarCuenta.upgrade.depósito 15

ahorranteErrante :: Billetera
ahorranteErrante = depósito 10.upgrade.depósito 8.extracción 1.depósito 2.depósito 1

transacción3:: Transacción
transacción3 = generarTransacciones lucho tocoYMeVoy

transacción4 :: Transacción
transacción4 = generarTransacciones lucho ahorranteErrante 

---------------------------------------------------------------- Pagos entre usuarios--------------------------------------------------------------- 

generarPagos:: Usuario -> Usuario -> Billetera -> Billetera -> Usuario -> Evento
generarPagos usuario1 usuario2 evento1 evento2 usuario 
        | funcionQueComparaNombres usuario1 usuario = (evento1.billetera) usuario
        | funcionQueComparaNombres usuario2 usuario = (evento2.billetera) usuario
        | otherwise = (quedaIgual.billetera) usuario 

transacción5 :: Transacción
transacción5  = generarPagos pepe lucho (extracción 7) (depósito 7)

----------------------------------------------------------- PARTE 2 (CHAIN CHAIN CHAAAAAAIN) --------------------------------------------------------------------

------------------------------------------------------------- Usuario luego de transacción ------------------------------------------------------------------------


impactarTransacción :: Transacción -> Usuario -> Usuario
impactarTransacción transacción usuario =  nuevaBilleteraPara usuario (transacción usuario)


impactarDobletransaccion :: Usuario -> Usuario
impactarDobletransaccion = impactarTransacción transacción2 . impactarTransacción transacción5

---------------------------------------------------------------------- Bloque ------------------------------------------------------------------------------------
type Bloque = [Transacción]

bloqueUno :: Bloque
bloqueUno = [transacción1, transacción2, transacción2, transacción2, transacción3, transacción4, transacción5, transacción3]

usuarios :: [Usuario]
usuarios = [pepe, lucho]

aplicarBloque :: Bloque -> Usuario -> Usuario
aplicarBloque bloqueUno usuario = componerTodo (map impactarTransacción bloqueUno) usuario

componerTodo :: [a -> a] -> a -> a 
componerTodo = foldr (.) id

-- 22

saldoDealMenosNCreditos :: Bloque -> Dinero ->  [Usuario] -> [Usuario] 
saldoDealMenosNCreditos bloqueUno créditos usuarios = 
      filter ((<=) créditos . billetera . aplicarBloque bloqueUno) usuarios

-- 23 y 24
esMasAdinerado bloqueUno (primerUsuario : restoUsuarios) = foldr (tieneMayorBilletera bloqueUno) primerUsuario  restoUsuarios 

esMenosAdinerado bloqueUno (primerUsuario : restoUsuarios) = foldr (tieneMenorBilletera bloqueUno) primerUsuario  restoUsuarios 

tieneMayorBilletera bloqueUno usuario1 usuario2 
 | (>) ((billetera . aplicarBloque bloqueUno) usuario1) ((billetera . aplicarBloque bloqueUno) usuario2) = usuario1
 | otherwise                                                                                             = usuario2

tieneMenorBilletera bloqueUno usuario1 usuario2
 | (<) ((billetera . aplicarBloque bloqueUno) usuario1) ((billetera . aplicarBloque bloqueUno) usuario2) = usuario1
 | otherwise                                                                                             = usuario2
-------------------------------------------------------------------- Block Chain ------------------------------------------------------------------------------------

type BlockChain = [Bloque]

bloqueDos :: Bloque
bloqueDos = [transacción2, transacción2, transacción2, transacción2, transacción2]

blockchain :: BlockChain
blockchain = [bloqueDos, bloqueUno, bloqueUno, bloqueUno, bloqueUno, bloqueUno, bloqueUno, bloqueUno, bloqueUno, bloqueUno, bloqueUno]

--25


peorBloque :: Usuario -> BlockChain -> Bloque
peorBloque usuario (primerBloque : restoBloques)  = foldr (esPeor usuario) primerBloque restoBloques 

esPeor :: Usuario -> Bloque -> Bloque -> Bloque
esPeor usuario bloque1 bloque2
 |(billetera . aplicarBloque bloque1) usuario < (billetera . aplicarBloque bloque2) usuario = bloque1
 |otherwise                                                                                 = bloque2

-- 26 

aplicarBloqueDeBloques :: BlockChain -> Usuario -> Usuario
aplicarBloqueDeBloques blockchain usuario = componerTodo (map impactarTransacción (concat blockchain)) usuario

-- 27

ejecutarHastaN :: Int -> BlockChain -> Usuario -> Usuario
ejecutarHastaN primerosN blockchain usuario 
  |primerosN > length blockchain = aplicarBloque (concat blockchain) usuario
  |otherwise = aplicarBloque ((concat.take primerosN) blockchain) usuario

-- 28

conjuntoDespuesDeBlockChain :: BlockChain -> [Usuario] -> [Usuario]
conjuntoDespuesDeBlockChain blockchain usuarios = map (aplicarBloqueDeBloques blockchain) usuarios

---------------------------------------------------------------- Block Chain infinito -------------------------------------------------------------------------------------- 29

-- 29

bloqueInfinito = blockChainInfinito bloqueUno 

blockChainInfinito bloqueUno = bloqueUno : blockChainInfinito (bloqueUno++bloqueUno)

cantidadDeBloquesNecesarios :: BlockChain -> Usuario -> Int 
cantidadDeBloquesNecesarios bloque usuario = length (filtrarBloquesNecesarios bloque usuario)

filtrarBloquesNecesarios (primerBloque : restoDeBloques) usuario 
 | ((>=) 10000 . billetera . aplicarBloque primerBloque) usuario  = primerBloque : filtrarBloquesNecesarios restoDeBloques usuario
 | otherwise = []


