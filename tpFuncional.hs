deposito cuenta dineroInicial = cuenta + dineroInicial

extraccion cuenta dineroInicial | dineroInicial - cuenta > 0 = disminuir cuenta dineroInicial
                                | otherwise = cierre cuenta

disminuir cuenta dineroInicial = dineroInicial - cuenta

upgrade dineroInicial = dineroInicial * 1.2

cierre cuenta = 0

quedaIgual cuenta = cuenta

pepe = Usuario "Jose" 10

lucho = Usuario "Luciano" 2

data Usuario = Usuario {
	nombre :: String,
	billeteraInicial :: Int
} deriving Show
